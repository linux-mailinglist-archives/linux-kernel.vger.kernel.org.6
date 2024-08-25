Return-Path: <linux-kernel+bounces-300402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6315695E346
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198561F21691
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D702155742;
	Sun, 25 Aug 2024 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ys9zqMnZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1551547DA
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724588536; cv=none; b=d0FkjMSZni4SF21hF9lLnDy0OUKSBBf3fKrhxI0jMHXpg4oYTlG6t4umInCUaz0kEZbqnNoEQgq/ZJosaI29VDYWJTochkBLO95dMICq0fJpqL0Cc3OjUKWuYusX35atTvmNpNBijX7IiFI0vaj5mxyUSpraXLcmVGz4Ru2+IYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724588536; c=relaxed/simple;
	bh=VRn0jER29cO40pMbWCG2MmYb5arOTQsuxvuL/P3IN3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C0yWA0OSUSNnbAl2rVIBn99/0+0FeJY/XbuBb5h9CquKp4ZOlmKwnEZ0sp+YVJr6XqHAaicUVCfR83x67XzzECvQ6ema7y7Em8kiPZYW8eEl6jZ0kOGgCOtMm7uAK1AAGFdIYiAf7DBbRN3UjXbOsgoJuuNjPe36zQ+PNIqpr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ys9zqMnZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280692835dso5323975e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724588533; x=1725193333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFoPAQjrzOMHn/Chb7158dVJFp9Fif0r+ZRIhtuLxDk=;
        b=Ys9zqMnZXDdMXG9U6OTq9APmCGRntQ4ZAX1EgL00q140MB9vIfAkGZpkvUrVnSaKwB
         BkVg3E2ewmfQjiB71gHWqCMAH3HX2dvWSQqL3plCXAVSXawUtdn5z2IzcD7XLbsi9OW6
         yAJra4+N++Ur7MhqpeLlfTdHi3TglKjNpH0aj95J4zT911Ya4Nhf6+KiSI1tEmBRHDOp
         YM8Jq1N2NZiO/tyuxuJnY5/hEn2nm7nlotvMsmclq0JJ5VVy+KSak67+TRe/nXXo6fsh
         NP6ZQBY3LT6vvgtsFyB+rCP+MhrBN0EhXSOtnNZkJ7U/jqgnhESRgcEPaBm6ciLI7jaV
         NhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724588533; x=1725193333;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFoPAQjrzOMHn/Chb7158dVJFp9Fif0r+ZRIhtuLxDk=;
        b=EVkwg2JNkPiUerzKhj+RqtYNtI6MZpfo1D8f9LSuDckJcRAyJRK/p6h8IKzhgw7m00
         bFbogZXhsIOZD0xIVMSsyHPu77+H06O4zGK8Ss10WRlsE0o5KqH+3j5m6HdCeSlJAOFR
         LYaKoeHPQXbLgaf82WjczSywnEwYu8iBwkQhNkkidO2CxmygfyRTCTWPJOCR2DrcBJk8
         KkTFz6/tnqYO/Z8pjhkq6smvC4Xw6Jc7QZxvdx/16gfjPfkLMFZ3zpiRcc6NtaVX2HI5
         vYnSV5xJ1hQcHKPar907WC80gudvmXoaOElT9jcoaEviCK55AzCzfwGcCjRLqx93TlJ5
         KyHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0fukRSco+clFpgaJaTbM5KJGEEuBSb3XemwSFje84snzWFNfesHA2SjXaz3K8vy3WArHDfSuartLBusY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZW6UgKObwOjOzI0gw1pVNqW/aC86VjpVcScQs94FzesL5cndQ
	KVUIhwrnsOxxyE563JYfBAHip014VG6jWA9mbVxVO0dOd349K8Yw6XkiKkqU0pNEhOgiCDUHzEB
	Q
X-Google-Smtp-Source: AGHT+IGV83472j5wbPbeYQa0Bq1nt9bPfZuAyeTcQtQzRN7MOaxKqzcgHhY7/Gdx06UxUhgezQu+2w==
X-Received: by 2002:a05:600c:46d4:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-42acca01063mr33206985e9.3.1724588533010;
        Sun, 25 Aug 2024 05:22:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef81777sm156774065e9.27.2024.08.25.05.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 05:22:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Honghui Zhang <honghui.zhang@mediatek.com>, Joerg Roedel <jroedel@suse.de>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Rong Qianfeng <rongqianfeng@vivo.com>
Cc: opensource.kernel@vivo.com
In-Reply-To: <20240821032558.43052-1-rongqianfeng@vivo.com>
References: <20240821032558.43052-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH v2] memory: mtk-smi: Use devm_clk_get_enabled()
Message-Id: <172458853088.37697.14987421828670080421.b4-ty@linaro.org>
Date: Sun, 25 Aug 2024 14:22:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 21 Aug 2024 11:25:57 +0800, Rong Qianfeng wrote:
> Replace devm_clk_get() and clk_prepare_enable() with
> devm_clk_get_enabled() in .probe().
> 
> Fix the bug of missing clk_disable_unprepare() in .remove() by
> using devm_clk_get_enabled() that can disables and unprepares
> it automatically on driver detach.
> 
> [...]

Applied, thanks!

[1/1] memory: mtk-smi: Use devm_clk_get_enabled()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/ff390189b7f2cfa20c644bc58b4462b5e2621838

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


