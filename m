Return-Path: <linux-kernel+bounces-253252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 109FA931EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5683F1F21E91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1DF6FB8;
	Tue, 16 Jul 2024 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR6jxab0"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B52A943
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096148; cv=none; b=HZlYqKag7duuQhKAL12x8mGB+CaHfNLvGYbE0RpELmyC/VOTRlqY/hA9QYH7Vv3JcTApDK1FPUU4OJqkacpGKpd5WIx6K6OadUFIrY0bWRTsrQPR+wLiqXT1YelQCqYFjvhh6gD12hUIOg1b0Lb34dfJjwzlQs7n9sX5k8Z8v5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096148; c=relaxed/simple;
	bh=NwPo1eyjJuDRBOKtKZU0n7QtGJkLIhI+TWmdRMTMbzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg7HjetbDs+HQ7J4sXLnM4CfZIK4kTgqJoVo55OiIm6AQ7v384XV9/12FYfOK4nBHegcmFuVZL4MPK86Vm+2L446JD/g9Cv6KsRZtsuWDX/aX4w6yrEPbuDZz2lt4yqIDMn1SxQIOudFLT8FJpyp6JToKghpMKKH27W9fQhOi6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR6jxab0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso6397939a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721096144; x=1721700944; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+45C48sK2A1ATl1+K0+JcvuyS0DLhYqfarOUtI+7ke8=;
        b=FR6jxab04fRNW2AqoolN63dzlyXcLgOKHrH3evnTkpigamgu/4s8PveKSbzbLwWZg0
         v/9ONHcYNdjJKVby9ldCU0DVLpWK1xkHiVzDs4cCSDdCnDtT0WAg4RkC/PQT6JOGewBP
         dAl+w+vV+ft4CXXID9hIcxMugMdLJDAnkFbIr45lcIAL9neSJ/1dc0ODR/MzD9sjhNUK
         gluhsTHHsu4ooO1FkzgnZ19V/NBNZEi2z5AMdwkqB+X3lWt0upd6zXjAr+iYInSRHbzT
         cUAIDMJIDmF79ehL0eQCB9icQ62TTAblwgPt/xIQR8HvY2/e6bdjaLmXkHzGl00qYhlS
         VE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721096144; x=1721700944;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+45C48sK2A1ATl1+K0+JcvuyS0DLhYqfarOUtI+7ke8=;
        b=dlY5KdnTkka4ZEavDWe1PDchjyIIM+lSZXv83pgtxQ/nVHSrXp1aZBgHv0aU4ojOxx
         77ogEKkcHpLX1bRr04zvc/Gtc/rzTzja+ZiI8Y4YpA8BQRdSApLSO+LGsicmfJYHjrbM
         hV40ZWj1ZbU+6bIWTA2bkY0rqkw9m1NNB0Dryi2SOao2Lhj/82lHUzm1tI0Ceywvphjf
         /mmzzHSHKv913Xz1yt35VnwW+HrxZguUcglmpoks5b1S2vIUKGODEtS9LqMV/DIGzDSF
         rBMRkgOOTvBZx5Vy4paji8M3BbGFYCkUyG/rRbCc+tg2CXfHdOPBUfF4rLkkayCAE9pB
         7qQA==
X-Forwarded-Encrypted: i=1; AJvYcCU/sdUkcDCGNIvjS+EKx4LxOuOIJWhaGP7n4ao/13t/+apx/hIHhrL8QItAakWsrEjVNX5EnJis1UL/XKO+3VCptogV3vyt/wz/6M5p
X-Gm-Message-State: AOJu0YyZiURdAj/WauQ1F4ufzFUmh66rkrm04JNEyDGLH83zR9geSqAd
	EiM3m+NX32mOEsdCl0F7CihYj54uQVxkpgwLz0biXRFSb3HlLBAa
X-Google-Smtp-Source: AGHT+IHSJTEixj7jCFigwuWC6KQkpmYCgpJ2MbL9+7DKi5+ds3HnjYyZBJzqiRD4hiqH3Pa8hSxg1Q==
X-Received: by 2002:a17:906:b88f:b0:a77:e48d:bc2 with SMTP id a640c23a62f3a-a79ea3dfbbbmr45437066b.3.1721096144193;
        Mon, 15 Jul 2024 19:15:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a394fsm256068266b.31.2024.07.15.19.15.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2024 19:15:43 -0700 (PDT)
Date: Tue, 16 Jul 2024 02:15:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] radix tree test suite: include kconfig.h with
 incomplete path
Message-ID: <20240716021543.ghzeiq5yqtov43lk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240712074151.27009-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712074151.27009-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jul 12, 2024 at 07:41:50AM +0000, Wei Yang wrote:
>The include path indicates it is the kconfig.h in tools/include/linux.
>
>Let's use the same format as others for better reading.
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>CC: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>CC: Matthew Wilcox (Oracle) <willy@infradead.org>
>---
> tools/testing/radix-tree/linux/kernel.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
>index c0a2bb785b92..fab6f47a9472 100644
>--- a/tools/testing/radix-tree/linux/kernel.h
>+++ b/tools/testing/radix-tree/linux/kernel.h
>@@ -11,7 +11,7 @@
> #include <linux/err.h>
> #include <linux/bitops.h>
> #include <linux/log2.h>
>-#include "../../../include/linux/kconfig.h"
>+#include <linux/kconfig.h>

Liam

I found the original code maybe not correct, but my change log here is not
exact either.

If my understanding is correct. In radix-tree test suite, we want to use the
kconfig.h in local linux/ directory.

But the original format "../../../include/linux/kconfig.h" is the one in
tools/.

My misunderstanding is <linux/kconfig.h> points to tools/. But since we
specify -I. before -I../../include, so it points to the local kconfig.h. This
is what we expect to use. By accident, the code change here seems correct.

If you think my understanding is correct, I would send a v2 with proper
changelog to describe it.

> 
> #define printk printf
> #define pr_err printk
>-- 
>2.34.1

-- 
Wei Yang
Help you, Help me

