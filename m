Return-Path: <linux-kernel+bounces-227155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F5D914926
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06371F23F44
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AF13B29D;
	Mon, 24 Jun 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHLsaqwB"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB945BE3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229770; cv=none; b=jUlcl7/SsCDCHFnzEFl+XZf5mWCXnT9ejvVpQnd8dwBEptbdytjVDJnidnADm0ywX7j52DwiJZhFNyZpbG0jreWo4U73/Kjf7bhwMqYf54mNCmt9qEt/hGzQ/mKtzd7+sNR14LT3dYEdg8xsxcdSkwwr2wouvultl9ERxsb7DiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229770; c=relaxed/simple;
	bh=AlnCc/LW6Vc5pW/YQha9WSFDXp8CS6KZBhmApLGCQ1E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m2hAr3wNYR2vAvwvfx6UTQFi/8BfYLxuyZWtf14J0QcF/+YQ9BgXq1LRMJ4jvY3+2iR76/J4wlsUHXYjjqeilHRiBhAu1t/K1IbL8/DR23M3JvbREwfPCx21EJe9oGkNV/hXLk8jHK57tzsJxOKmc4kTWJyAT0wTwdaQ47Ey1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHLsaqwB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a725d756d41so71807166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719229767; x=1719834567; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fps1yu2B/sTlkPHC2bgn3PqSLx1dYrtQgxbyCVXflC8=;
        b=eHLsaqwBEF77TNlcYBqkqdU16nSYB6Uc+ncxHBgMvIVbE62ofQ/r803YwYQspHumhD
         OBm2KDz1DQPryIiixT1ZnZKnLdUIQCgOWC2HWJnf6R6VzVRUvndKiTCNF1m/Y55Eiw5i
         bIcEGSm6vCBJ7HnBFYL94r/9GqVvzG/aGAqvNKg85bAC6dGzh7QLJLQ/faeTVkA2PBPw
         x6cmhy48zXD80AMZNpM1XwxcJqkxwRcPApAuvyGMktIeFjZzMZ2BZlBzFq3dUewYNfZB
         yqxldn6So7Uy29r0kq9/PmWGdExuHixjsk1xkxOsUHQjtVreXFgsFC8dIWoSEoFukRqJ
         ayWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229767; x=1719834567;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fps1yu2B/sTlkPHC2bgn3PqSLx1dYrtQgxbyCVXflC8=;
        b=iVYnCP4CajtiNBBbtHrDgdeC/DIa2H8RsJz4+bzAtX7wLbphJZgj2OJrzGc6xZMDW7
         EDOuG1wOR6C7oh9hbZpkRzpbfNGp2Jme/hFaKQdDUO3VLis6gpQBba44jXhe69CTE3cv
         aJxBxac5vhcNUeFjBfJaV2kr4v8RvDXMvlvoFoV0jvCAbyIrXGSIfxAAQVnPiP2NtbtP
         5pYfCI26PM1+FkIFYvEqgk0Rlt5FFCRV5MmGpG+kkqklhY++9ymlva/2HfAgV1+GGogf
         xWuWZD6ga0B5Kn9fSWQ2FSMXuiW8EFSYjKygve+odNCQTsoPF5l9GcLnioNczEVqtXoK
         XvXA==
X-Gm-Message-State: AOJu0YwdU5BEvUcvY8S+z0XBpyK0pHm/iKOuJiCEweUddM4v5LaxHyrA
	WR7Xfm463NSnAGzyk+amjK7fs+sCoxsPjqZVjn174Q6mRJiLxQ0=
X-Google-Smtp-Source: AGHT+IFmN32/7C55yZJgKkGpe2DlTIDVK9K/xP9NkuPD+ZoFN4/VLXBF7LKceDRn0nc5iEBz6ZD9tw==
X-Received: by 2002:a17:906:3c17:b0:a6f:1464:e1ef with SMTP id a640c23a62f3a-a700e7311a7mr470122466b.31.1719229766817;
        Mon, 24 Jun 2024 04:49:26 -0700 (PDT)
Received: from p183 ([46.53.250.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe3d2a8e7sm286395966b.111.2024.06.24.04.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:49:26 -0700 (PDT)
Date: Mon, 24 Jun 2024 14:49:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] compiler.h: simplify data_race() macro
Message-ID: <f214f15e-4a0a-4f24-9bd7-8f84cbc12e5a@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Use auto type deduction and comma expression to decrease macro expansion
size.

__unqual_scalar_typeof() is quite wordy macro by itself.

"expr" can be arbitrary complex so not expanding it twice is good.
Should be faster too because type is deduced only once
from the initializer.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/compiler.h |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -200,10 +200,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  */
 #define data_race(expr)							\
 ({									\
-	__unqual_scalar_typeof(({ expr; })) __v = ({			\
-		__kcsan_disable_current();				\
-		expr;							\
-	});								\
+	__auto_type __v = (__kcsan_disable_current(), expr);		\
 	__kcsan_enable_current();					\
 	__v;								\
 })

