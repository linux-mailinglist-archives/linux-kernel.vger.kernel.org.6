Return-Path: <linux-kernel+bounces-324357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C47A974B95
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732841C25599
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B31213C67E;
	Wed, 11 Sep 2024 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDT+bkpY"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E522075
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040362; cv=none; b=QgW/zCBXgQLeqT9VP2pIjNCHPcfXnPGEM7+F+isFWcOdyJQUT/DBFHMl2BvPTWGNJ9+BtlyWrfMqyOyLJjJxHv3rf1zXBxj8oqsjXVHLYtDPbNG6l99VOIRmkCwkeCfz48Mr5dYMkgfO5q82oRJThQtLoLR7ZJNe4TMxk9THTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040362; c=relaxed/simple;
	bh=HoxR8vfEtIHFIrwB9+FtaybMhmPgqhhqbF2v2L94xzE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sN65XE+gm8JukCcOzOa61JkU4QzDUZft4Xbs5xSatvE7W0uH5Sh7SanECW5lWP/6jwF5HnQ5HOSvsLptLNplNNJtrGpSMz22ViSYYSjZeec19PmnKXqwQF0XzZj8kPmChQw5hqQYyy+NhgLmoQOOEVH8khoYeJEKUYeK1XZbmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cDT+bkpY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374d29ad870so3987507f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726040359; x=1726645159; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMhPnhQLGUUwFA6J63dF4flmVGV7ie7Si62HtCm+ens=;
        b=cDT+bkpYQyZGhu3P5SC+9wRt3DDUZDG+o0mFvWTTbUaSkPeNFz/0SOtFj3dxIms8jI
         88G9BPmqnbCSP9qddzulYeAxdZ239W7TjoWuKTMsYwjE6PqYoRc9MOrC8WcFI+/GuWWQ
         iZUPADirUTqITvaVUW3gWT1bR0es7jI0NGBHZiKH0A6HMo+lVvG0BZJ4NZSuDREwvg3b
         p2wTJWtiGdxIJ9ucgntp7yRv9DKIXiQxEuR+fi0VJqSbmBwcs2Oc9EXBn8SVJgrLXHkl
         aja71qCS5dOQMsRZ6KwAXoEUDzOe7ATFjN/jkT7REtA5NaIdDbMcjJw6QZjW5ME9e/0s
         tmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040359; x=1726645159;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMhPnhQLGUUwFA6J63dF4flmVGV7ie7Si62HtCm+ens=;
        b=ww0O3rY86WQDUfDCOh8wWXc9w6nuyrKvxz9uAP4q3dTJXLETbo7PTiP1EXWOl3AZfA
         Mq/n3pRq+dvnkRGmFzFEnqKobhh89xsGBP0uKXVglicnrxaJH2t6aTGJmV4sC+Ukdj7t
         4DRlZVcxc8vhehMF+x8TqNpcGRxhh/sME9KaM1Py+JMZkAlAP+mQ8cT0C87S+zFGQ4Zw
         2RJNSVQFXlkIhjDFLwfzuJyDdRd9PypAiQR7L7wQD0W/oUcyyIFcy8KoroFwCkYu24eQ
         qh8ybzLW9t46v8K11GJOmj3Biau/y2NTRkzmoEP460vITI818NeDq8RGgDXk3T3mdmWx
         Gkfg==
X-Forwarded-Encrypted: i=1; AJvYcCX2+wyodTx8I/VO3LYSJRCLNFy78HpRinqHurrwzzAYSqouSfJaYho5p0fFTFfSOGRdYmiEwXz3nr1auZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjtKnzS5TyIY+EhzzXmcntVZ0gsCXttOcvWOpaGBpZPVfd2dvo
	rQOW1yPxDKTwgMtJ2Ghz0BR4b8zwkVEz9nVGB51pn7Y/COsvmA5n1Ev4azSUsOE=
X-Google-Smtp-Source: AGHT+IESuS36LExi/2RVMu8sWMe6uqy4QE6i31lVfI6gt/QUy4qRreYxyP5mTDnkIk3YvBnM5tmX7A==
X-Received: by 2002:a5d:6945:0:b0:374:b24e:d2bf with SMTP id ffacd0b85a97d-378895d46c9mr11371355f8f.27.1726040359142;
        Wed, 11 Sep 2024 00:39:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01d3d17sm41603025e9.0.2024.09.11.00.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:39:18 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:39:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ep93xx: clock: Fix off by one in ep93xx_div_recalc_rate()
Message-ID: <a05454f8-e409-4f60-93f7-6aa2ea0a2a23@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The psc->div[] array has psc->num_div elements.  These values come from
when we call clk_hw_register_div().  It's adc_divisors and
ARRAY_SIZE(adc_divisors)) and so on.  So this condition needs to be >=
instead of > to prevent an out of bounds read.

Fixes: 9645ccc7bd7a ("ep93xx: clock: convert in-place to COMMON_CLK")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/arm/mach-ep93xx/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 85a496ddc619..e9f72a529b50 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -359,7 +359,7 @@ static unsigned long ep93xx_div_recalc_rate(struct clk_hw *hw,
 	u32 val = __raw_readl(psc->reg);
 	u8 index = (val & psc->mask) >> psc->shift;
 
-	if (index > psc->num_div)
+	if (index >= psc->num_div)
 		return 0;
 
 	return DIV_ROUND_UP_ULL(parent_rate, psc->div[index]);
-- 
2.45.2


