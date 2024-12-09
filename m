Return-Path: <linux-kernel+bounces-437257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5399E90F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44661164420
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44521770B;
	Mon,  9 Dec 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVzwlqda"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06792185A0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741402; cv=none; b=M/WQ2b/bCn5P7bngwuXWrIoIENgLYdAUkyq2WEMmiYjpq5VupjXBC2blG61TUZibuKSE2bK2hGSQlBa/Rbmu2UEfsHnpCKovIrkc5VOEtFoXdR4353+rEn6EmFzyt/gqgWdgGtTFruzTSWlUwv5imw0sTIzQgxs1+HwU1l95Sg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741402; c=relaxed/simple;
	bh=wV6eR23JkgcbxJIL46tqQ9s/gDpRIqoVfhQkYHZrYN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oPtBchL/whhM7JqIKn1W4VN3hT7JJISV8H29B8SBJa4bKq9nIOVwcUmkugqUHf7OR5Kr0jepn+qpQ5kZqBR85tvm5X6aptH8HVM7TNabMW6pvMfU+xlZXGvPGmnyyfNlZPGxx064Yj6T1zDKJ+pxx4ch9XmLYqPumTvPtSu+A3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cVzwlqda; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434e9e22a99so830715e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741399; x=1734346199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8It1LsERjYk3PRVA4rqnSiz+MggzufbNA8DNofp64o=;
        b=cVzwlqdavc1mXVDFU/EZhVg5U19/mNcg0unlLQ8aDC7BwOECqgIJt7/ard6MQViw8L
         TP6bxf4v9p2eMSJJ06n7/KWbJFXBy2vAuECu3yV3fvuZshagkbDbLbotOHljsSXClH1E
         G+6nRKVaM3vu/xaqCvKj2hyeovJz01ev9uoUtuiUvPzAR9/i/e2c3Ob7HbzyXvrGWzz3
         hqIYeNaYhZvYk93348RRMmCWRh0yNG2dW+U8yMDoUAwuJCCuDdJ3aaLs71j68v4EpKe4
         FaU3iHYB+8KSggDeAnf/DVYTv04A5scFLrjM7/TcjjtEvAXyOwWlpiVTpHYDD5HRnOck
         ytjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741399; x=1734346199;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8It1LsERjYk3PRVA4rqnSiz+MggzufbNA8DNofp64o=;
        b=JT4CkcRGAe/6MoBtOM8454JmUggEfxtn6upwY8prkwMn95a82RuXLwsdwwY1B/wmv+
         mxSeMIXWCpH+qiL/tfaSvqcXgeKkMsgTlREhh7wsr+OWVALUhkv9m2Z/PdiGC9TuMtmS
         JH+LcNLgkDpJj+CMAU/NHTWmPX0BrAzQSV04SrwjsZGEdd/fJDsHelgrdw34qJvtAxuS
         uuJrWxyV/Ly6LrwMc1K6KQmS9oGP1cu6+E605udB6UXf+5vqopZq1zDzGBbuVs2GTqNa
         lJ2hZiFXIMiCKQ6Xh5CPC3CnQrAIdgIOV1b9EbtUj+obdnrSMNPPDaxBbMZ8ZsBLcn+2
         +J8w==
X-Forwarded-Encrypted: i=1; AJvYcCWb3f6xahArptvcGgKXtNx6sWdLzUzpq12NmxFJPKXlUozlZBh3Hfvcr44xi81Q4Is6IlsHLtO7DYNDRGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dEKfmEXDwLFngXAWzhWXzXzpbmoy1jrOUuUsmSD6YYdJsm3V
	jH5SEt3j8kZTUbPeFgb1CPNonermyzISvkx1n0KWnWXm7aMX+FyOk4sozHNUflQ=
X-Gm-Gg: ASbGncsX0VZ6XceE4N4cCTHiMlqcVfaV6WdORk8SLQYTa+SMc5KfxYut7AMr9GwTgoa
	I9T0LOCsBnhdP+xLB5Dih/4H2dzg32kge64651UdhnrBrzLBiuBMWpqkCbmuZq0Df17WVbHPJje
	CsxqGrPNpYavrDCnSAdjklMwOpTUhY39VliCkHdi1jJZzVuf1OyZzZsyIvpMlJbd3QvMRcGqPMF
	52nf9yF/AGIMZGoNKy3ArHEzD0d/q1jw+hqDGlOEwfoFGCgnoqoh9ucGbd6GOnLkA==
X-Google-Smtp-Source: AGHT+IE7auGUR+zKlMOrNWx9KLSq3GSb9mPOKLQ7Zp/59A+kyUHzh9pBlXR7eVUa7fJxWz/7WUXXlA==
X-Received: by 2002:a5d:6c6f:0:b0:385:fa20:6583 with SMTP id ffacd0b85a97d-3862b34e3famr3627780f8f.2.1733741399032;
        Mon, 09 Dec 2024 02:49:59 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434ea1ae415sm80301445e9.33.2024.12.09.02.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:49:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241204145559.524932-3-igor.belwon@mentallysanemainliners.org>
References: <20241204145559.524932-1-igor.belwon@mentallysanemainliners.org>
 <20241204145559.524932-3-igor.belwon@mentallysanemainliners.org>
Subject: Re: (subset) [PATCH v2 2/2] arm64: dts: exynos990: Add pmu and
 syscon-reboot nodes
Message-Id: <173374139792.46435.12839391873743115498.b4-ty@linaro.org>
Date: Mon, 09 Dec 2024 11:49:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 04 Dec 2024 15:55:59 +0100, Igor Belwon wrote:
> Add PMU syscon, and syscon-reboot nodes to the Exynos990 dtsi.
> 
> Reboot of the Exynos990 SoC is handled by setting bit(SWRESET_TRIGGER[1])
> of SWRESET register (PMU + 0x3a00).
> 
> Tested using the "reboot" command.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: exynos990: Add pmu and syscon-reboot nodes
      https://git.kernel.org/krzk/linux/c/d5b3944bec944b40e91cae82583ce11740af6f10

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


