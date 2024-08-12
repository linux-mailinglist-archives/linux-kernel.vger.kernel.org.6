Return-Path: <linux-kernel+bounces-282920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2DF94EA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3235AB21CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1F16F0CB;
	Mon, 12 Aug 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqsl2/W9"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E416EC16
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457508; cv=none; b=MR1Nd9tP8N0sjR15f05ai3xoAxiUlt3GRuK6kMZUXcDwnj+kWYYqSqrEW5L5Ajf6n6FI9UoTpIMAO5o8f24tFQRfJ1l467jwXZ7eCSUVqfR+KlW044MI9Ul4H6xP06ZwZRPpLATVscQRT3jlpWda7SsKkUA5Vkgb0sQi596p3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457508; c=relaxed/simple;
	bh=GH0qSyUsEuHixyjX1afzz4BOkXsjAQB7lIohzlTTV9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkfukhToHfT90Lc+I88G9Xzi77kbRV9jP2Q+nMV5mn3gx18TIzBKtGTp32SbnZetz9rvf/4DhJzvygEZ4tAifbNJ6FXRyG1R352CeQ1OWqFtMr4lFohSR66X7JBgP+RPuMJFA2ykfgoqofb26N4wHtJh08u9OMUuUyLS74wc47I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqsl2/W9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so31586105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723457505; x=1724062305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zyxj0Rbqan9SXYocuvBYL2hSYqLAPhyA0e68sVXE3Kk=;
        b=aqsl2/W9kD3vR/UVSo2jpuh/0HbGXY355r30JfWXKRhxYPmFlxacbqMAd4gzuWwa/H
         v7rhor26KFWtFaA9b6A6zoAuV3Yrm0HzkLjIo+LEel8KmJFDahs0N3/riyubnBEN0l3u
         tql8cp8GJGIPSYWwfzDRIjccTBRKIh6jjYATuvvmZEG4cyQq/qmsx4eCjW9RF1UJiXZi
         p34OPJxaAl+GSx9uZwsSisns/8cSDU+Tx4Lo9kfyHVWOLqMqgM8yAEe7NtmjbyEgSnvP
         rIXXyxFQii19AEO040CryRYJ8m/hfntebJUc+ITKPt6VNXuRz+EPkwjukUbraMfcVcR6
         OJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723457505; x=1724062305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyxj0Rbqan9SXYocuvBYL2hSYqLAPhyA0e68sVXE3Kk=;
        b=Fj36FC2AYiwrhemGortzFOfdgaADlquKeOYYQnt0WVwq90y0iosZNL/FNtsp+Toi2a
         rtOvV5JyLx554+9Iy+bCyrBrFL6s1kt53Gqbew7dMbyebEi8EEWma9Gtm7EvtqgC/tQC
         GDEYSwb/AVnDLTOmSSh7k0zT/5hIzmSgX8yCKj7LYmxdEThEE2hrUMmSEyoxwt126XKq
         Oo1/B9wYUCBaS4lA5z3SSjU7rykyj0Wm+0znKgPqYM2ACdW8HSit9Zl3mi9z/OBSBqW2
         Qgu2AsuDIHaxZQnfi4krLrrpXION7elGhREpQFu3Evj00H+VL2svAN2AKtT1OikxkeCN
         ofZA==
X-Forwarded-Encrypted: i=1; AJvYcCXCv1lrmYOIeAGahzHKZywIz2VmTq+m47X8LefHKtr9JxIwriGPz8Rp5p4BYGOHZrBhAJv7AB9u0fHFrtM2vh9/+DF6cDLu0t1qEFyZ
X-Gm-Message-State: AOJu0Yxxr2SEcK0/L2aoFjZ/Gk4sCHntE2xXdoOoqIta88e6HTN03+dX
	1CpPumhps+8+OzLkbSjh0MzGDZryjZ1/h8CtugPnVlaOqpFp0OS9nZp50jD/4PA=
X-Google-Smtp-Source: AGHT+IHOG6MT/xRPaQQHgNz/hMoENdRCR0MnQu0IK7pxqkuUKM3V8HpAPRGkZjlhmtdNcAJRvnjekQ==
X-Received: by 2002:adf:fb46:0:b0:367:96d6:4c2d with SMTP id ffacd0b85a97d-36d5e4d2ad4mr5893870f8f.25.1723457505275;
        Mon, 12 Aug 2024 03:11:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd2accsm7054591f8f.90.2024.08.12.03.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:11:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Cleanup Spreadtum/Unisoc ARM64 DT
Date: Mon, 12 Aug 2024 12:11:33 +0200
Message-ID: <172345744174.104566.12535192989951342506.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720112081.git.stano.jakubek@gmail.com>
References: <cover.1720112081.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 04 Jul 2024 19:41:18 +0200, Stanislav Jakubek wrote:
> This series contains various minor cleanups for Spreadtum/Unisoc ARM64
> DeviceTrees.
> 
> Stanislav Jakubek (3):
>   arm64: dts: sprd: rename SDHCI nodes to mmc
>   arm64: dts: sprd: reorder clock-names after clocks
>   arm64: dts: sprd: move/add SPDX license to top of the file
> 
> [...]

No one took this patch and it waits on the list for very long.

Applied, thanks!

[1/3] arm64: dts: sprd: rename SDHCI nodes to mmc
      (no commit info)
[2/3] arm64: dts: sprd: reorder clock-names after clocks
      https://git.kernel.org/krzk/linux-dt/c/e2e0d4554de7182f4843415343b8888dac8a4f72
[3/3] arm64: dts: sprd: move/add SPDX license to top of the file
      https://git.kernel.org/krzk/linux-dt/c/a4b3f197bcd17ea81605f3121a459dece448e877

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

