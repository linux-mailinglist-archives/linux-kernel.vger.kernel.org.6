Return-Path: <linux-kernel+bounces-404126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302B69C3F71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34211F23318
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC3819D075;
	Mon, 11 Nov 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvVf7Wbn"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEFD15575E;
	Mon, 11 Nov 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331295; cv=none; b=bHsWGzyCFRKjJmggPRCG9X5/U7gQkIQiSsc0EiK3HDPkhkju7+0PQpqyn0oAnJzLsafxtzSEUNWkgD1Rbimr8LoKVAppBsrTnVimBixMmSfndUXb0oQaMc/EqBj6uGcWHOkcS8iWsaQyGTp7AvCCPS7k3JcMfNmNhvXqT3NnZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331295; c=relaxed/simple;
	bh=J878j2auIlZ6D4VaLIs/77JAMKT8MvD19nROHcVxwrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ntV578N1ngY4fQZ8jGSkYTd1qWT826wFDY0W+aunFvN03XClzzxvv9NEgxedmgXFTcdlvcsZVAN68WTJPQATxHJnLFpNyGGhsa2t16h7A936jLD7LBDnZGw6fyUXzDUA5G4vDxj847CEqlCo7F2vORuJRvdcs1OPxIku4nq5bB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvVf7Wbn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdbe608b3so44873095ad.1;
        Mon, 11 Nov 2024 05:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731331293; x=1731936093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=im6Jy38t0M9P8Ds0Fkv3ZVsul0UJjJFJRXt3zjTYHNw=;
        b=TvVf7WbnHQhT0DfKNkUKqSBYuI0nqkNmH5VKgto98YlDCpXgAl2wKeOckfm6tq34Ww
         eWnm1UH0JIAFwjH6RTVcUxjUhyhAhCba+QC6aNN9/oCK8C5XhF1TN/Is5Xc9hzVNkDQg
         TObHiM8dIwz6sfAqeuLwPVM51PrRtRU42E9AeR1AUQhQRKBRQT9WC9k/boFP6bHLOMyB
         AHOEVGT/17CGW7CaNXBI2FiSMeiB3PChljUClzfch70Ql9T2n4ocQd4MvQiJkMFJEtFX
         Agy9Ld4S/4Yh+xMIhWdNHWZU8kSscYoTIj4kAVA2xZSTvxteHDTbP+Ojczrzmxy536nK
         OCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731331293; x=1731936093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=im6Jy38t0M9P8Ds0Fkv3ZVsul0UJjJFJRXt3zjTYHNw=;
        b=WR2bHcdkH39Btub/+c8IEFUISRSPjkEvneacGGe+Ot/RdI6eH4Aiz0hSyfVrBCxOpk
         74iF2JbbLi5Gp4tYDX3zuQK2MCMidCSjW9/FzmVxHnC+SG/qsS7TqrFw4mDOi3t0hIAH
         D35MC9iSTxd7K/UU9a+UOQlF8cFRSaw0Ym8z1JVFPDkKgyOiIktXFc57GNas/6ZZ88AR
         3SocS3D8r+5ovvrApM54LqS7JRNoyuR3r9GLxjof61etQWj+B4iDecxxqpXRYYbWzR6r
         JCF4Bv3pJPYb/negsvvQYjrvCVNhqmmaD14jzPhxRLpVGPJ92Sc9NptqlakF40byIUEQ
         dc1A==
X-Forwarded-Encrypted: i=1; AJvYcCUTPWOVA9WHpmeuEiOcy2qEHGYZkrTnl2d5ZI8RuuEJzsZUzcLzRKeXofV73biXdU9mnnDI+HZmMF1hf9/T@vger.kernel.org, AJvYcCVfM5LWczL1rBfnOV7vQNIzYwP0q6O2sWto1xp8SG1fKfZdt3L98m4hLLd7j9mDD3a8tX/JCvfR92lR@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPYcGlGlk3X+YWo9/6NpAivNwphbx6u1e/TegO9PXst5kX7VW
	fbi7HZ1ftgWothUGwAgn1rYrxNZ1/qGHpStTlasndM0Dq39tgGaK
X-Google-Smtp-Source: AGHT+IEwB+o+/qeuUZ9d+KrtWbQEvreMHXJGwJsXjC8Rzhc8kuxIoz8kE4yXWm4kMcXlus1xtS5EDA==
X-Received: by 2002:a17:902:d4cc:b0:211:6b21:5a87 with SMTP id d9443c01a7336-2118360bcccmr143105485ad.56.1731331292724;
        Mon, 11 Nov 2024 05:21:32 -0800 (PST)
Received: from [192.168.0.107] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd17e9sm9591693a91.39.2024.11.11.05.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 05:21:32 -0800 (PST)
Message-ID: <005130df-fea4-462a-8efb-73d8445aca32@gmail.com>
Date: Mon, 11 Nov 2024 21:21:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH asahi-soc/dt v3 00/10] Add PMGR nodes for Apple A7-A11
 SoCs
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241103073319.30672-1-towinchenmi@gmail.com>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20241103073319.30672-1-towinchenmi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Nick Chan 於 2024/11/3 下午3:31 寫道:
> This series adds the PMGR nodes and all known power state subnodes for
> Apple A7-A11 SoCs, along with the associated dt-bindings.
> 
> Changes since v2:
> - Removed "apple,always-on" property from "ps_pmp" from s8001, t8011,
> t8015 power domains. It is not on at boot. (Mixed up with ps_pms which
> is required to be on)
> - Add asahi-soc/dt back into the subject prefix, missing from v2.
> 
> Link to v2: https://lore.kernel.org/asahi/20241102011004.59339-1-towinchenmi@gmail.com
> 
> Changes since v1:
> - Removed "framebuffer0" dt aliases. It is not standard and not needed.
This is in response to Rob's comment[1]. It would be nice to get the
series reviewed by the dt folks[2] in time so it does not slip a cycle.

[1]:
https://lore.kernel.org/asahi/CAL_JsqLv2DJOsL=3bxf229ZdArL1TqArw+9cLtmjYMkm5yfZ7Q@mail.gmail.com/
[2]:
https://lore.kernel.org/asahi/23074410-ffe2-4f68-a983-67cec430f68f@marcan.st/

> 
> Link to v1: https://lore.kernel.org/asahi/20241029010526.42052-1-towinchenmi@gmail.com
> 
> Nick Chan
> ---
> 
> Nick Chan (10):
>   dt-bindings: arm: apple: apple,pmgr: Add A7-A11 compatibles
>   dt-bindings: arm: apple: apple,pmgr-pwrstate: Add A7-A11 compatibles
>   arm64: dts: apple: s5l8960x: Add PMGR node
>   arm64: dts: apple: t7000: Add PMGR node
>   arm64: dts: apple: t7001: Add PMGR node
>   arm64: dts: apple: s8000: Add PMGR nodes
>   arm64: dts: apple: s8001: Add PMGR nodes
>   arm64: dts: apple: t8010: Add PMGR nodes
>   arm64: dts: apple: t8011: Add PMGR nodes
>   arm64: dts: apple: t8015: Add PMGR nodes
> 
>  .../bindings/arm/apple/apple,pmgr.yaml        |   5 +
>  .../bindings/power/apple,pmgr-pwrstate.yaml   |   5 +
>  arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi    |   4 +
>  arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi  |   4 +
>  arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi |   4 +
>  arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi  | 610 ++++++++++++
>  arch/arm64/boot/dts/apple/s5l8960x.dtsi       |  13 +
>  arch/arm64/boot/dts/apple/s8000-pmgr.dtsi     | 757 ++++++++++++++
>  arch/arm64/boot/dts/apple/s8000.dtsi          |  22 +
>  arch/arm64/boot/dts/apple/s8001-common.dtsi   |   1 +
>  .../arm64/boot/dts/apple/s8001-j98a-j99a.dtsi |  26 +
>  arch/arm64/boot/dts/apple/s8001-j98a.dts      |   1 +
>  arch/arm64/boot/dts/apple/s8001-j99a.dts      |   1 +
>  arch/arm64/boot/dts/apple/s8001-pmgr.dtsi     | 822 ++++++++++++++++
>  arch/arm64/boot/dts/apple/s8001.dtsi          |  22 +
>  arch/arm64/boot/dts/apple/s800x-6s.dtsi       |   4 +
>  arch/arm64/boot/dts/apple/s800x-ipad5.dtsi    |   4 +
>  arch/arm64/boot/dts/apple/s800x-se.dtsi       |   4 +
>  arch/arm64/boot/dts/apple/t7000-6.dtsi        |   4 +
>  arch/arm64/boot/dts/apple/t7000-j42d.dts      |   1 +
>  arch/arm64/boot/dts/apple/t7000-mini4.dtsi    |   4 +
>  arch/arm64/boot/dts/apple/t7000-n102.dts      |   4 +
>  arch/arm64/boot/dts/apple/t7000-pmgr.dtsi     | 641 ++++++++++++
>  arch/arm64/boot/dts/apple/t7000.dtsi          |  14 +
>  arch/arm64/boot/dts/apple/t7001-air2.dtsi     |   1 +
>  arch/arm64/boot/dts/apple/t7001-pmgr.dtsi     | 650 ++++++++++++
>  arch/arm64/boot/dts/apple/t7001.dtsi          |  13 +
>  arch/arm64/boot/dts/apple/t8010-7.dtsi        |   4 +
>  arch/arm64/boot/dts/apple/t8010-ipad6.dtsi    |   4 +
>  arch/arm64/boot/dts/apple/t8010-n112.dts      |   4 +
>  arch/arm64/boot/dts/apple/t8010-pmgr.dtsi     | 772 +++++++++++++++
>  arch/arm64/boot/dts/apple/t8010.dtsi          |  22 +
>  arch/arm64/boot/dts/apple/t8011-common.dtsi   |   1 +
>  arch/arm64/boot/dts/apple/t8011-pmgr.dtsi     | 806 +++++++++++++++
>  arch/arm64/boot/dts/apple/t8011-pro2.dtsi     |   8 +
>  arch/arm64/boot/dts/apple/t8011.dtsi          |  22 +
>  arch/arm64/boot/dts/apple/t8015-common.dtsi   |   1 +
>  arch/arm64/boot/dts/apple/t8015-pmgr.dtsi     | 930 ++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8015.dtsi          |  21 +
>  39 files changed, 6236 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s8000-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t7001-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8011-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
> 
> 
> base-commit: 5c9de6f45db36b8a74c12e448cf9db87c97bf1e5

Nick Chan


