Return-Path: <linux-kernel+bounces-335375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7E697E4C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 04:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CAFD281388
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 02:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640594A33;
	Mon, 23 Sep 2024 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS0itI1y"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA8624
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727058322; cv=none; b=rDq0051Z9AD7j3mqoCBGf0AzKy/sKGbxuCB8u6bRAS3cupC6WM5PmxtL8V+huEWyyvjKO/WgGT/hMRbNx6lHapI3FV+DaIpjmfWDzfRHQCc0vJwcJFfVBnZ6nYlWZXkTnjHj0R0zsXpERKBNchWH5I5GEYhUgXsMmn/x8xGOUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727058322; c=relaxed/simple;
	bh=xhXbNvM++7qKbgPSVqhFDU2ZhXaHlORv7ZNSLZePNZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arNzPGOTwgEwEUHpS2lMuuMuD/Ds14eVphTZ9N53YT9liFuQg50CkpVlyfdr+az8UoE1w6HBBVrTliJeuHCRCzfNbb2jnUZkm5q8SB9yyt7ma68pFykrqWG2t6qQgKWKAWdKgNESFWJxFvq0KPWvN0KQA/dE68howTOeFq4yXdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS0itI1y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20551eeba95so32644815ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 19:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727058321; x=1727663121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7aLKOb5llbH39oSD2wqFg2ImH5K/xs1d/3DhTSvBAM=;
        b=eS0itI1yg9i2S/SDolCEg3qCWPErBlaeGoXNUnrZQEUvZkSpAxTU25pVW57VT2DRsI
         okNnafKGJWiqGTMUZcbEAGeyxc8DyzQqs7WfiyQ8LYEZVULpnUm9aIta4jpnAt810vVs
         8qFeuDbpQA9yFrIXhOrFOqGLl2y/KCAuhaHuoXKaFpfQ+Z3j24JpaRKSLTCqpVzJ38uS
         kNIPU81oM/Adja6rr+x33ZgAba25Ijvnhn+woLAL6WKyqdtU2YofsVuvPp/2sB3cMtY8
         907mHUKHAd9I5k9HQabaG7X1qMQVcaVYOTMcwCFT92wFy/mZJgwykWPkYQgGPFa6S11B
         TMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727058321; x=1727663121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7aLKOb5llbH39oSD2wqFg2ImH5K/xs1d/3DhTSvBAM=;
        b=rhgdMU2dXQGlH4MKLGUYQwZFTzBx6fY/FfaPXpZRaNfXW6LIpZJanGXSlumYvu/fEd
         +6KtfTkamYmSQr40+YxrOM7yChQ7zhCMCbUSEzp/1teC1ZuOFsJShUkk9hdX5gGu6i8f
         TroGJNa+w+qUWI0BD4tpebFPNNtZ4czrFDZlzv4YBcquKiiH0s+fwlQwAnYTpkZE3rV3
         QN0RaAV1eX4YVvBtATtpTvpT4T8705HIGEcqlfNNgSDYyj3QkLQPm49WxtBRiF9Xk9Nd
         yWAfxImbkF/4jaFkbLD6khQWxJLmBG7FeqvpOcSjrqa0lzqcr81bsZVLG4mPG2/8IIhj
         pPTA==
X-Forwarded-Encrypted: i=1; AJvYcCV8mfmulGnH5rn+666SxB82D6qggEjZQS61xV4VZdwu8pDNnIqM105/WQwdTOSu5SWUSj7IXby1+X0d4co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPBkuTCyRkl2axMM+ur7Fnq7TlfVYScq/spn+L9HyQGPdmQemL
	vP9Yx9tzArFmShxZR7JKXQpLZ3MmMkl8MrN8KmzKlBlAx/W+EbUF
X-Google-Smtp-Source: AGHT+IHMe8B9R9yeowkpYMpdwCkp3LhabZm8IJy9oinfaIcj2oqUQXGLPn9cSkJoTdRgN+hp5ZNI4g==
X-Received: by 2002:a17:902:d503:b0:202:3324:68bd with SMTP id d9443c01a7336-208d84421afmr140151485ad.43.1727058320760;
        Sun, 22 Sep 2024 19:25:20 -0700 (PDT)
Received: from tc (c-67-171-216-181.hsd1.or.comcast.net. [67.171.216.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473e8a2sm124613895ad.251.2024.09.22.19.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 19:25:20 -0700 (PDT)
Date: Sun, 22 Sep 2024 19:25:18 -0700
From: Leo Stone <leocstone@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Leo Stone <leocstone@gmail.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, akpm@linux-foundation.org, 
	ruanjinjie@huawei.com
Subject: [PATCH v2] mm/damon: fix sparse warning for zero initializer
Message-ID: <xriwklcwjpwcz7eiavo6f7envdar4jychhsk6sfkj5klaznb6b@j6vrvr2sxjht>
References: <20240921195511.364023-1-leocstone@gmail.com>
 <20240922151121.469051-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922151121.469051-1-sj@kernel.org>

sparse warns about zero initializing an array with {0,}, change it to
the equivalent {0}.

Fixes the sparse warning:
mm/damon/tests/vaddr-kunit.h:69:47: warning: missing braces around initializer

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
v2: Added fixes tag. Thank you! 
---
 mm/damon/tests/vaddr-kunit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index a339d117150f..3dad8dfd9005 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -66,7 +66,7 @@ static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
        static struct mm_struct mm;
-       struct damon_addr_range regions[3] = {0,};
+       struct damon_addr_range regions[3] = {0};
        /* 10-20-25, 200-210-220, 300-305, 307-330 */
        struct vm_area_struct vmas[] = {
                (struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
--
2.43.0

