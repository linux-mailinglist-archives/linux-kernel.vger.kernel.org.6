Return-Path: <linux-kernel+bounces-194667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45598D3FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F12E2825B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17C11C8FA2;
	Wed, 29 May 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xx1ALsDI"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE451B960
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014957; cv=none; b=MY3ygZWfCn6q931yrLQG/f0yOG/M9HWm5Fja+6LonppZbsGd+bzAk/0W0omrRrAF5lyz8X8dqVwcbsH3A1MruFTQ0/nPtkJ5DpykSKkCeyEgfiz/Ja/zTa6i7itdGxXv7kY2P0QAlV9pJ2YEVTeBXH73evV7JxJ5VTzPhJmAwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014957; c=relaxed/simple;
	bh=QSiwFxLNEDbQWJuOlv3RSkF9+56K6Kvd4+n/j1PVRDI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSNDBQL11N7i1/sKZvZ6i9Tnhwks7iQCQxe3SSHTzwnA597RPMlkKJKZaBfNJFsVG8BIfmZqFNjyjBTlA9h64TsUBem722XLVRix7kYGqRq+01NohR2Uz2/jYyMXcXTN9tAWb830QS4RSzugTv+bZzrWHyWiv1F2CH8YwqvgXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xx1ALsDI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42121d27861so1851815e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717014951; x=1717619751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JC3x5apHXdzmR/YV5C0DYO7+NyF+i3CFIw4rUzWOank=;
        b=Xx1ALsDISk8u9Efk/NCHmLKZlRAaz9PqJpNVuXZoumVkGK+/4I507Sg06z3m7OnVwt
         G3EQDBbhvH9dEC3mRdDwW/MxlNiXw1kLhnf9PQsPYj+CYqi4Y3eO/NpKvb9SsE3TFYS2
         AgQjtcfS788QXf+p+VEwiKHeHDkLfwmA9pgwtudoGueKTpApdeGY3qcwUu0vzbqlbZ0M
         gem2hbVdkx/+oeAW+/bXF90+sXOiE7hFMYqW4S4KAqrWiwLLeQTcPQHP+7JnSLKAUqbj
         f+eGEv8w1+7m8PGlg4SgPsdvCnKQLtGE3dy60ysi4dKuY7wrbPsnq9Wc8blfYxqB19BX
         tNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717014951; x=1717619751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC3x5apHXdzmR/YV5C0DYO7+NyF+i3CFIw4rUzWOank=;
        b=jWzrz6JPL8ThXT654kNwkFibfXxcWfmtsNc7jmzuzxeWh2cvdHVeBT874oVgjPnX0M
         YnJV4Xv9/5PK4sVR+UnbBmZbktQQf/Bw72r4+A6GC6Paytb121RzDiZLJiuWmFRpZGei
         XpFKnGg+AQ/l70cu+ZzzU+imccyRzxb3OVuqtQD5mKDgeX6kw9jvlNXzxS1hhRRoe/Iv
         n01SI+JdOTgndPTjONe1jSiEPaIUtA4doFdE5JvW+MHOs8SrEh7M+4hVm1w+R47npVPZ
         q6GuvP4YHaqqp+XUDIyD1WoaBihiI/n/iSkXnmc04nqqWOu55iW/MJjODNf1kshKYvFX
         Of4w==
X-Forwarded-Encrypted: i=1; AJvYcCXBz8rzxMnpikKGDahp8J6gSWhWnbVXQGiBfh59LaB2uHjPCfBmkPOY+FcsoVGgPfdusi2YhXet3RqHMHQusXsKaL0mxWoZGrHpJ11f
X-Gm-Message-State: AOJu0YxnCe9e2oLBJTpJIMb5BdvsaOO+cptirWv9SQPCMRO6gQteQNTv
	NxtxmoMy5MTGdYuWp/duEDnkCxWx9PP8QGJOZxBbVtiW6dZ+CuMLa51NHu4KucKQxtiF+c9a6G+
	E
X-Google-Smtp-Source: AGHT+IG3AG7XvBjUxEuIqDkIem5kESHSEggsK3zdIN5ufHeWfrSxUAX8R3RPXwQOqZVR99lIOuJZ2g==
X-Received: by 2002:a05:600c:4ecb:b0:420:29a8:ff5e with SMTP id 5b1f17b1804b1-4212781b3f3mr2973705e9.19.1717014950770;
        Wed, 29 May 2024 13:35:50 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127059a50sm4743805e9.1.2024.05.29.13.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 13:35:50 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 22:35:48 +0200
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/hugetlb: Do not call vma_add_reservation upon ENOMEM
Message-ID: <ZleQrVXDPiF_U7Hn@localhost.localdomain>
References: <20240528205323.20439-1-osalvador@suse.de>
 <ZldNCutdbyroqoNv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZldNCutdbyroqoNv@gmail.com>

On Wed, May 29, 2024 at 08:43:06AM -0700, Breno Leitao wrote:
> vma_needs_reservation returns a long.
> 
> 	static long vma_needs_reservation(struct hstate *h,
> 				struct vm_area_struct *vma, unsigned long addr)

Yeah, I missed that, thanks.

@Andrew: Can you fold the following in? Thanks


diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f35abff8be60..0b9e64aa279b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5769,7 +5769,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * forever.
 		 */
 		if (adjust_reservation) {
-			int rc = vma_needs_reservation(h, vma, address);
+			long rc = vma_needs_reservation(h, vma, address);
 
 			if (rc < 0)
 				/* Pressumably allocate_file_region_entries failed

> Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks


-- 
Oscar Salvador
SUSE Labs

