Return-Path: <linux-kernel+bounces-233026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7F91B159
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A40C28348F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301921A0715;
	Thu, 27 Jun 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg+jwLYI"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B81CF8B;
	Thu, 27 Jun 2024 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523070; cv=none; b=ZuH9f3KecEkvvk52iZpjEZm7sfs7pGio1UigDGR6hKidJSY9XMgxt4f1Brb+kNtMilVKgqjC5EmxTxaoF+05CFy5K3ddTtWv3Hqs5gp8YnFOXCO80cK3epa4Gxd5yl+W7CxRcK986dL/Z6ynP0gIwrShL8dNXAzMH/XMD2dNy4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523070; c=relaxed/simple;
	bh=fIe+WjGyo22eybCG1oWgddFxMBUrGgRXke6p/2u/m0c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=k04EZR4ul20TbF474SGJI5EY2GZRghLreuTl8W+r7gQEA9cAMTzklc8Idvvv8Yq6X2kYbhduw4NO6RRnjXA9ZjBH2zZYvBZmZ5LLz4I9Ikh1qqk3NeVSNmOkv81nfNGZSqQCnM/13JPMg5BeMVVT1FxU09vIye3Z2m6KRe5mFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg+jwLYI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso2459486a12.0;
        Thu, 27 Jun 2024 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719523067; x=1720127867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xnk9uIadAbA+bBaIfSx2BcakWTRFKYQJDJDqca2A88I=;
        b=Tg+jwLYIL9yRVqcA5FvMceZNzpW5h+2wYVTeld4Cuwg7IiSQPSggrIyO+HfJxzlOaA
         xJ1ZVseaQHGACMxxYt5950vuILpSCjFvasnHGfa2kJqbUD/Y2ppwqtgIWLo0wyKCgF7J
         guktLYDtczFxN7rfZH9qD3gkktTGHK3+RH0RCBIb6wAwbJJpz0jl5g7JMw7LJ4UOlnft
         GXdYKuzlKtvbnBIRIaHvRQrAovSAVABXHtyGpHuISsqyPwjYZf35jmf7XtNzmz2grZgP
         qspmC06i/yeY+1wYekq0JumB0Pqpa2jB9Wkuugw49eHpiVg4A94nRn55f2IikeXRtbh+
         DbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719523067; x=1720127867;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xnk9uIadAbA+bBaIfSx2BcakWTRFKYQJDJDqca2A88I=;
        b=tGevrRBtq/6ixgf+SxYXSSapyv3BeHrSYdw/nrAJCr7zfAOZVRNGu0fVbf7fWefML0
         WekZqh0RgrLkJhW1ToBVLvFdGsenb8vFpSYrxyVPJrTVCG/W3p76kt57rEN8RqU3avS9
         bh6DHLb2AvE5saXAO6whgiYoyATMXQ6XTXBi9tWte/R0+x0m8VbgXBnvB1FuMXKfkC+V
         ruGM0HK0tpVyQy4vo2C2MV2j2gqtTJc8Kd5zuXq036M1KooDlonfb5wEBySIjeMPiYl3
         lM91JpQqyRQj8UE+vamH7SComGRZ9YUNrObbfo5z7JNEVXTSh3FrvHwTtdS2gEtH9tOP
         AmTA==
X-Forwarded-Encrypted: i=1; AJvYcCXDpJOBYbjKkcmVxo5wE1AxeV5UFscRXgTHxH/eNIOdB7YfDjkRP3PrWKGKN/wrmQfKTI7ZrNig5kqvmcG7mY3Z3gBUXtfC75zf+j14pcp4yie5Kyv0gTzVJegBxWtOHp1uF3kGGJ6j9Se4uD3kESxg5JusZqenNZE+D4sIiAs+NVg7Ww==
X-Gm-Message-State: AOJu0YyfDO2A8dYNbCG/6QQejf1MRCuO8rvc7aNylHNZSeCkY2Ie2aOA
	zfNFt02rzE0UQvNJcZUiJf7WXAv/FTPg0QJ+ecMhoK6mtGRgCMFr6KPkeA==
X-Google-Smtp-Source: AGHT+IFbtDNlgX18BHhhHB676dlMxYpxY2uD0IhAomzWeFynNtXKV2BsDI/Li5O2s/tR5bnwCUFTRA==
X-Received: by 2002:a17:906:c309:b0:a6f:64cc:ca2e with SMTP id a640c23a62f3a-a7245b88e46mr977230466b.44.1719523067016;
        Thu, 27 Jun 2024 14:17:47 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1843fsm12647866b.39.2024.06.27.14.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 14:17:46 -0700 (PDT)
Message-ID: <6f21c09b-e8d2-4749-aca6-572c79df775d@gmail.com>
Date: Thu, 27 Jun 2024 23:17:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] dt-bindings: clock: rk3188-cru-common: remove CLK_NR_CLKS
To: heiko@sntech.de
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

CLK_NR_CLKS should not be part of the binding.
Remove since the kernel code no longer uses it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 include/dt-bindings/clock/rk3188-cru-common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/dt-bindings/clock/rk3188-cru-common.h b/include/dt-bindings/clock/rk3188-cru-common.h
index afad90680fce..01e14ab252a7 100644
--- a/include/dt-bindings/clock/rk3188-cru-common.h
+++ b/include/dt-bindings/clock/rk3188-cru-common.h
@@ -132,8 +132,6 @@
 #define HCLK_VDPU		472
 #define HCLK_HDMI		473

-#define CLK_NR_CLKS		(HCLK_HDMI + 1)
-
 /* soft-reset indices */
 #define SRST_MCORE		2
 #define SRST_CORE0		3
--
2.39.2


