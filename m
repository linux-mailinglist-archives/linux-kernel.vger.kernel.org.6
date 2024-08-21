Return-Path: <linux-kernel+bounces-295450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6097959B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617441F2169C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2327C196D9E;
	Wed, 21 Aug 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJY+CbV8"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695E18F2E2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241276; cv=none; b=tjr1Texmlk70UjugizWhnkbgzx8GRVsT3LpAJXKsvxUIYAwmRxRjCzf6Ej77xjTrLDEjae4zOVquhYJcb9Tl7P8FYbWBTIesGnSsOflvRwNe7kFB4xB4SIDDcfEmGrOke4l3h72/o/DVnPQREDP0DRmDoocKmYL5nTZNMiutdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241276; c=relaxed/simple;
	bh=WSFE00FeDtnofDWlCWa6o9enLw2V0Q9YYDGI3XrXwx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF0afKVE0R87OTS+Z7WqJyCBDK9I2VTL9pnwTBH4+bwb9OwSt535c8LQJOdzX1FWkQCbdqeCnjWiK+kpvHxMcnbFoiBRyHmLWG8KJUM5mVVWlzVCfEz0VmmCiViMkH2DNowSW0tuuqdikKqNq4DVPqT5bfnWEIYj9yk6GpVBy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BJY+CbV8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8682bb5e79so20528066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724241273; x=1724846073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1cKOhqUF3zu7vgZsan9VYbVtQKA6jU1ocQV29bWQbE=;
        b=BJY+CbV8RDd+/YOsQEzpiiRqI+zX6EaRnuQCb91rQUAaFIuDNyreWrNbuyyvqkepWw
         0J4MCz3D1GOJ2vQHZcRwB2UeMr+TyuiPNmfHsYZDuctzym3pdFqlScexijBA6ylSGhkn
         QskNJYyCndrEVYYZpmtgxPrVkYoxX/w55SdckE2S7BhnWFr3WLJCb9jbn1zMs+/VJ6wd
         Gy0RYIPacFntwCV0YudzvXXONL5/mFdv9ULSCB3Cwx2rI6qJ1pHvky1gfhW2C1F8OJBy
         YNDbAkGlrN4ue2KT8fz1HH9yvFGC3vr0eSAb/OxX+VBR2lR2p+KZ7CYSYfa1SasdKTK8
         /B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724241273; x=1724846073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1cKOhqUF3zu7vgZsan9VYbVtQKA6jU1ocQV29bWQbE=;
        b=mk88tubDhWKpM8Ii+v8cNHWe1sd3YbNKWPODQL+my1t64LXMTasa+Oxp2BDMTp3Rkf
         lVBSbVlj3hnfPVtdveA71YYrqIqm6DOFThln/AGWBKdJheBn03mhK/4+VL7I6ro7T7LX
         Pewu3cQKe2jCXKpjHgPLnf1Z/TJMmtUkkPNf6LkIIebHNWvRw5GCkS/fFLeVq+HAbobz
         SIyx4ozHKjQL62gx1Mw0SZI1tl3Nz/tNZpHGmBWt+EngFqh3PV80ClLHhhSsJeNuZj7J
         PyMpSYpEBqcCm+2L5zCT96beCbK0wDqwjjm5IdT7/mVBG3c2Thu+s4ex7ZuPhW1aISiG
         Gkaw==
X-Gm-Message-State: AOJu0Yy2Nty5N434v8PoYE4hznxq/SReUl1xrHAQ2z/WwEkeJHaR2swe
	17M/UPmmreRxBC6DDLhfsRVMkEBdpNCC+/G5V2sXOUlfOc2btx9vLh7rvqYa8lU=
X-Google-Smtp-Source: AGHT+IFotKgao7c3MvbC51pbdgpWNBmepUxyxxfJglrrTLVTS0I2aFuu4fTaeblDXOtgwgBDsM118Q==
X-Received: by 2002:a17:906:f585:b0:a7a:a30b:7b92 with SMTP id a640c23a62f3a-a866f11dcbemr111996166b.1.1724241272808;
        Wed, 21 Aug 2024 04:54:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396c682sm885673166b.196.2024.08.21.04.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:54:32 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:54:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Matthew Brost <matthew.brost@intel.com>, Tejun Heo <tj@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: next: x86_64: ahci 0000:00:1f.2: probe with driver ahci failed
 with error -12
Message-ID: <eb78af03-b407-49d9-b605-af9632eda08e@stanley.mountain>
References: <CA+G9fYuD4-qKAX9nDS-3cy+HwGbyJ6WoD7bZ_QL0J__A++P9aA@mail.gmail.com>
 <CA+G9fYuYfNA7NZDHpq2K24CsUn21LAb8vn38=JTz=54bsdSd9g@mail.gmail.com>
 <43be498f-5a25-4ee2-8c5d-1ef75c4d1ff3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43be498f-5a25-4ee2-8c5d-1ef75c4d1ff3@stanley.mountain>

Give this patch a shot and I'll resend if it fixes the bug.

Fixes: b188c57af2b5 ("workqueue: Split alloc_workqueue into internal function and lockdep init")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/workqueue.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bfeeefeee332..2fb93f3088f9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5623,12 +5623,10 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 	} while (activated);
 }
 
-__printf(1, 4)
 static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 						  unsigned int flags,
-						  int max_active, ...)
+						  int max_active, va_list args)
 {
-	va_list args;
 	struct workqueue_struct *wq;
 	size_t wq_size;
 	int name_len;
@@ -5660,10 +5658,7 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 			goto err_free_wq;
 	}
 
-	va_start(args, max_active);
 	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
-	va_end(args);
-
 	if (name_len >= WQ_NAME_LEN)
 		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
 			     wq->name);
-- 
2.43.0

