Return-Path: <linux-kernel+bounces-441082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43A39EC927
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BE81885A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5125C236F8E;
	Wed, 11 Dec 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgtD9YJR"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF406236F8A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909561; cv=none; b=fjefSKPFbU8boRb23Ncc8dU0jNLukWrzCh5UIl8ZydVjIEsX3qgE1qG9PPlrrzcQY+voe4v8IpJnudKWA/9PKeLjFEh3zucFjisMCH1QKB8OT7ESXHn1uIV2SR1p2nUPNuUOCpOykpMggjaBjLUD6/XTSytAjkaqALJWVgpNcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909561; c=relaxed/simple;
	bh=qyKnhrPjdXHEQmybHqZqQhGYiZQe1mwwZIQNT0SPuAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iwxBflHFuRKGTWsIzb9G3nD33BHOJ8M6iKktQF2t4ugidekaJo0vKcExiodTSVw4iTDCPRXISagds+FxLtpw/g1DUReg2EpRgc/3GOO4XDOJKlJHwPC9lYOQ1la38d/jfjhX2yaphSW5US3kRQB/wPgTMXcOwxvumAXjB7miklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NgtD9YJR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385dece873cso3115646f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733909558; x=1734514358; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5VxB938IKtR3Mu0Y5RbPKBoQecG76afLhC+F35TrmE=;
        b=NgtD9YJRPcCBEOJS3AhGUJ72E2qoigxx4gxMxysKyeAZ35LiaAhzMfvTWMmrrlkUcX
         cvsDoRuvQ0Z3uGt2BIRwJbfbL2CFpE476uiP9pTodM/ubyWwdb4Kx8LcH5AWFmjhED88
         RExV2ohDR2BAriaTX5lUmYYTgbXWb93bo+SWsRMHbt6DM0YMK0z2lx5vG0SWOq8EsTFa
         RR76OE+3LRrBJRjqMz7xwFnwrhgO1QLJbbOo74UD62bg8aiVHaLyKAb9qPifLe8G6dk3
         /yVKLN+X+KrSStPF4mjIUdYpwdNCWz2934xa/dbwRFfWim2k8CeGLuY27/rNf9VLEO1+
         3dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733909558; x=1734514358;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5VxB938IKtR3Mu0Y5RbPKBoQecG76afLhC+F35TrmE=;
        b=rtMD3LaamS8lEYp6RdWtw4evsFTcd6pjlTcuwVFpsHG/P781Zo1yzO4FJLnzbe0Fz/
         U0QnPHTfb2u3TUX9iUzMly7yzMUmzSa/lVV/0pLYvwZCB5VDwe/KwtnxauLOgSSiWQSR
         GesTvIOQ6s5VUxrCfMmmZHASamXSAnrm91YWDbhbkBjmdC4LljE1n6dZzMESlXRZDxfc
         i0Nys5Y3Kw3e/I7fODme6CiCIkH56b1AxlacN2kWb2n5A/UZ/wznIJkkywc3AqZPY9I9
         mW9FCnKG7q/2JaVbBdX3BjmXcVnO+EA56v+hvn3bunTphz2fNAV/2Hog9uiXlPdOPDF8
         U+TA==
X-Forwarded-Encrypted: i=1; AJvYcCVH8ERPLBzwNtkiJ1ZfqxlBIJ1QPh6kYsU6CarUSwH2UCplz+gQkCRJzct0UDoN/HV8yc6iZfUwB33pMdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHxJRhivMGrkmPcKTSMEpoK/ONNWZBrEiQNQ1uCyC9s+MuWUHI
	EmLg/Zyd4T+6geOYNoRJoZA9wHMQpk1D9/Hj1M2XgDubYA0us3OcBSvKPWxxzx8=
X-Gm-Gg: ASbGncuuAbrIA6TQYJYpkLCz2SosOne4hw+ThHpqdU3TfLDoRN+j+5Qb9m5dkIhJi3N
	SiAx5nT3K4BSCQf6dc7925Ud7oBR6ZP9vC0RKs1lpC1kmgxF1sOR0+DpWMj8h0CqIRplE30slqv
	0NkPR34PfngfuuoT673xVwcA0zSnqq2QkTXWgQOOvdjqHzAqjOHubUZpPHBL8a83Hyb6Q9DFZbq
	Nw5yx8Z3s9qIWnhmh1kN7mtQOjcaevg61RShDOktcnSj4E4RPUUYMptl/g=
X-Google-Smtp-Source: AGHT+IESPCTVzoAwL8Mu4aP6Ib03zs7NgOeXGz7+aMlKX/SKIPhdsqBIYQQBw02we1gLiAilrzuPjA==
X-Received: by 2002:a5d:598c:0:b0:385:f349:ffe7 with SMTP id ffacd0b85a97d-3864ce8959dmr1766176f8f.2.1733909558245;
        Wed, 11 Dec 2024 01:32:38 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824c8a6esm849864f8f.59.2024.12.11.01.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:32:37 -0800 (PST)
Date: Wed, 11 Dec 2024 12:32:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] rtc: tps6594: Fix integer overflow on 32bit systems
Message-ID: <1074175e-5ecb-4e3d-b721-347d794caa90@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The problem is this multiply in tps6594_rtc_set_offset()

	tmp = offset * TICKS_PER_HOUR;

The "tmp" variable is an s64 but "offset" is a long in the
(-277774)-277774 range.  On 32bit systems a long can hold numbers up to
approximately two billion.  The number of TICKS_PER_HOUR is really large,
(32768 * 3600) or roughly a hundred million.  When you start multiplying
by a hundred million it doesn't take long to overflow the two billion
mark.

Probably the safest way to fix this is to change the type of
TICKS_PER_HOUR to long long because it's such a large number.

Fixes: 9f67c1e63976 ("rtc: tps6594: Add driver for TPS6594 RTC")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/rtc/rtc-tps6594.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tps6594.c b/drivers/rtc/rtc-tps6594.c
index e69667634137..7c6246e3f029 100644
--- a/drivers/rtc/rtc-tps6594.c
+++ b/drivers/rtc/rtc-tps6594.c
@@ -37,7 +37,7 @@
 #define MAX_OFFSET (277774)
 
 // Number of ticks per hour
-#define TICKS_PER_HOUR (32768 * 3600)
+#define TICKS_PER_HOUR (32768 * 3600LL)
 
 // Multiplier for ppb conversions
 #define PPB_MULT NANO
-- 
2.45.2

