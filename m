Return-Path: <linux-kernel+bounces-267171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66B7940DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CCC285D69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E31946B2;
	Tue, 30 Jul 2024 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIulWvAC"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778918C335
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332200; cv=none; b=Lrquuv/q+1CBl3cJltueylGjvfUJz+31HvP0M1F02+4JH0taPC9uXWqYXo++6uRUyYkZEotvSyiTl40CyxdwG9hoIGDr9Y2aIpjuhcktVfjW6I0EQhIEinXmsIAM8jVk60dZ/GEaywBqBuhMzmc2lJbAbvbxvzpUAge/nPbbQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332200; c=relaxed/simple;
	bh=RNmRBBs8qIC56Yc3oQq23ulp3hpfT6ba+PtyZPOkaRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxLicwr2NQRlcXkolFVhPLtReT9LGeXS4XOqs5cIwixrTwFlvvAHZ8Gv3HBTONbUCs8WfuCzGBsBSFsf5sJ4mVcAyahAyXdv6i82A5gEKBSP6RbLHm+zMCREJhqhSHQSrfL+GP125VD0nClFvPy5oJRlvHc23s0a4LS1d+rw7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIulWvAC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb5787b4a5so2676858a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722332198; x=1722936998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C39pEMxxkaT6a0RlZ/9LBxSQHNmTTBvdXNRF5PK1T+8=;
        b=XIulWvAC7CGraWPvRoDw6gx5p7GdvKvPuQlaK7LSzT2OaTdwd2qhIrib8RRd6CNT2h
         vSp2Lx9hwdECgiNW2jCQggUFOpnd2GuFNriJ/Lx69sK1uhErUKIJw+ctM7DOI675TOQZ
         Ym+xDIow21hDFyeQmBV1XdwLsTv73/9gJigswmiKmmFHJCTIADRjs/Pz+sfTqhB3Vfoo
         MeXuDISKkSTlA/4KE6G3goSrb08NNmHkTlhdZDVHXgjKY/mB3S6bL426B+6AC5sC1ht0
         ayllgVf/HO5HaoPSSMeoC+5sbfsVq5bx0sh9fCUswjg2YlnER2ADMW6xEdqWXTtqB35h
         Pp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332198; x=1722936998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C39pEMxxkaT6a0RlZ/9LBxSQHNmTTBvdXNRF5PK1T+8=;
        b=aIuXbG8IFHjrVhpomDzt7Oj/pOKdJKZnvjLNwTJUodADezPW5o4UUxJx1pqdi44UWx
         ZBfhjtksQBPEmTKdBi5KQtNdotAFKM/YvBP3axzSiK+1ulTyk34e4C/G6QWPxqCUsy88
         zXXY9abi4NGpHnGicbAVeNusXjTOw11f0i7ZoF50tSAeBMM5oRj6xzRpVS9gHhemBZcu
         jpSw6fkF0eNPDQbuwUDqRuU9GBNJyaFPNUACnsviybWbI/JsPQPRXK7xjPZcDntf36t1
         VuwGCzGhaLw9kxqaDwgVBkhWW3ycBV2Fa9OcNCJM0Ik9XEOKy34xF5nqjLlSP2cA8pCr
         jrWw==
X-Forwarded-Encrypted: i=1; AJvYcCUyQyC7UuBox3yCOADE+9j4x4dbdQQljz1fMygrbjVHEI4RNpI3fOsR9Zq0iFjP3+y6jNqKU4gUu9fhAdqSRcnHDlNkIFXbw68Ktfqt
X-Gm-Message-State: AOJu0Yx7tDpg3zpjYLeshdQJ7V5GGriNhvquh/WRUwJsl5g075cuUUTj
	JpgFRqnQvxthrrVNPG2yDljhxXi6Ik/e8WC80gVSPSkigGqxp/y7
X-Google-Smtp-Source: AGHT+IF5YKZrYNMAA+ZmFXhAU3UcNiONmTeaOLCtmT7c53IVPRC9yKAvAmkKewpOZGP7zgaqKy690A==
X-Received: by 2002:a17:90a:2c44:b0:2cb:5654:8367 with SMTP id 98e67ed59e1d1-2cf7e5c1b45mr8578709a91.26.1722332198337;
        Tue, 30 Jul 2024 02:36:38 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-223-76.dynamic-ip.hinet.net. [220.143.223.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73ddb7dsm12068860a91.24.2024.07.30.02.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:36:37 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: urezki@gmail.com
Cc: adrianhuang0701@gmail.com,
	ahuang12@lenovo.com,
	akpm@linux-foundation.org,
	andreyknvl@gmail.com,
	bhe@redhat.com,
	dvyukov@google.com,
	glider@google.com,
	hch@infradead.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	sunjw10@lenovo.com,
	vincenzo.frascino@arm.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of KASAN shadow virtual address into one operation 
Date: Tue, 30 Jul 2024 17:36:30 +0800
Message-Id: <20240730093630.5603-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Zqd9AsI5tWH7AukU@pc636>
References: <Zqd9AsI5tWH7AukU@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 29, 2024 at 7:29 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> It would be really good if Adrian could run the "compiling workload" on
> his big system and post the statistics here.
>
> For example:
>   a) v6.11-rc1 + KASAN.
>   b) v6.11-rc1 + KASAN + patch.

Sure, please see the statistics below.

Test Result (based on 6.11-rc1)
===============================

1. Profile purge_vmap_node()

   A. Command: trace-cmd record -p function_graph -l purge_vmap_node make -j $(nproc)

   B. Average execution time of purge_vmap_node():

	no patch (us)		patched (us)	saved
	-------------		------------    -----
      	 147885.02	 	  3692.51	 97%  

   C. Total execution time of purge_vmap_node():

	no patch (us)		patched (us)	saved
	-------------		------------	-----
	  194173036		  5114138	 97%

   [ftrace log] Without patch: https://gist.github.com/AdrianHuang/a5bec861f67434e1024bbf43cea85959
   [ftrace log] With patch: https://gist.github.com/AdrianHuang/a200215955ee377288377425dbaa04e3

2. Use `time` utility to measure execution time
 
   A. Command: make clean && time make -j $(nproc)

   B. The following result is the average kernel execution time of five-time
      measurements. ('sys' field of `time` output):

	no patch (seconds)	patched (seconds)	saved
	------------------	----------------	-----
	    36932.904		   31403.478		 15%

   [`time` log] Without patch: https://gist.github.com/AdrianHuang/987b20fd0bd2bb616b3524aa6ee43112
   [`time` log] With patch: https://gist.github.com/AdrianHuang/da2ea4e6aa0b4dcc207b4e40b202f694

