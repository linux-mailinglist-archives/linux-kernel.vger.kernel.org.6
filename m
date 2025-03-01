Return-Path: <linux-kernel+bounces-539982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79F0A4AB97
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBF27A90AF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B191E0B70;
	Sat,  1 Mar 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhP+mQhd"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4F1DF992
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838416; cv=none; b=ILE2J9xCkPQghIRpl8bYC1YLI4MIgrBTRUnILuGFDQifOZmhns+HisjD07tGy8MFMto4kra2/hiNcFdPCjX1mTO+Jwmf6JG5aGJn4sSQbI90SMbCyk6j0U0rMd58965N0mRC3BLNrqB/Xpfk7TeKkhq3lwQlMX2Xc3phEWqaBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838416; c=relaxed/simple;
	bh=d50HSxD/PimQmQ45XW3+Ssx/aRWrlXekJzuR2G9oxOk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ImJ+fP2fnKvIolIpZaJrDM3qBoKUnWtRo0Yy27aVrOkpTiYKZ9DduEfGeJIGwXg+W0UYDx86hLkjDvPzv/X0641q9LCApsHuOviiJmo1P10XTYd05f8A19XojUZsC9JhWSUFPbrBEp0iniJMf9W2RWkKZXNusUJBlOjITwcfXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qhP+mQhd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf5f2e4482so5464766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 06:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740838412; x=1741443212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6+VMXcyt281MB6S0PILXj/mc3+AiyRry5Dl88JFAmU=;
        b=qhP+mQhdLTmkv9Ku7kQdEZOo2vx7eIDcFaxyctd9gwCcSJOz1CsfudQBDnECcPjtZk
         KrS8MxElReSfdG8JA4gWWGEuE1m33Nri1WoPsRqOzPt2Mdtn4Ak+zs6/LkHIoE5T/UF4
         pioTugZMIxyRA7qEuN/pEPSBeX85d7a6iT67zJ2cGhxJJIDQghq7lpJIw5K7Iff4riYc
         GEIMmxJHH11vgX40J0QO2arOp8kYU3rlFfhCxRd1VHs6uVr8hwK171EJXv2tMUtpkv+r
         bWEcjQvv0sI5XDDfw4nxxADTN+Gbux/bFJYQ9+2OVakO4yLFVi2Giqr0/ypsdO0abMOS
         ob0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838412; x=1741443212;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6+VMXcyt281MB6S0PILXj/mc3+AiyRry5Dl88JFAmU=;
        b=ssB6scgFvtixrhAuZmZ7z/hmDqxpTW/3tFxzkyBTVVCW4ibISRh557AabgKkZqo8/A
         HRbuojtArQEJpr5COp42xOFpb4i0M6AB8d/OvNB7Laga4ggHHtwlUeiuAk1B5mjYYFiL
         XAhkitXpdm/hvWCg6nkHwkoHSyCmpQHj+krXA2YEIQ9Hwu0gIS0UOHUm3U4Vqqi6gMHw
         GNvJM7cn1o+Zo0kPx/8h89pquSSQPJGl/tOkDaEPQQB+mWBHl7MAqCv+09h1YJsu1x+S
         Kq56QTWLKa5a0Nly8xk1bOgVYDEVRf9VqzY10Wbu7kUKkCIEkHVrRccsMuhjefvjB2B8
         A2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUN+/vg15f98zHjMaBN0oiRsb/SO31bRNoYSX7zLJgqg8zvxohh0utfPmBodgVHLCkTKWXn9i3t+wKuISk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV6kd3/lAog0ywwq9rLN3yRjcd2vh3EeAmRlX/LGfKnrNv+BFu
	oBW12JrN0rZ2GFbJZpEXSJ/4vJ7Rmp2ZOpmJAb+uLm/7BeLbgj26wX8Lujh4GeI=
X-Gm-Gg: ASbGncvoqoT8YlavmJN5Bah/zKyCak/YJMs4wX72/IErkC2KmYRBUpLCiDcinp7nDUJ
	kzefvXRGvt+Wpz0hPRqcd4ZukIq2m1KHlj7xn9FUjIAGwA7/PRdYaQ2qPM8uh4spbQ4WW7LW5ud
	iQSj/fqa5h9l7DK1DKuFB8FnxkZZYBtYakYjhqfWrptGylBrWzH20c0I58oPGJNzuDp4a3aYc8d
	FbVns4xtXfD9UuPeyLpOYMkC7TxRg0XGB7baOkULb0C91cHtmr1OiXgE08VmtxwFLdXVPBIfAid
	2yVkRnFryxvHc5tFp+nNCC0C4oiHn8pNYqaTzrFxpG0R+0HgBRQkiotEOshn
X-Google-Smtp-Source: AGHT+IFpPIcRFdEEfoNRMXs9IiWLSrC8PzKuk8Eq3BxzR7HGMfJRXaPfAjNFS/RvB4XMH80jRhalrg==
X-Received: by 2002:a17:907:7285:b0:ab7:cd83:98bb with SMTP id a640c23a62f3a-abf25fc79abmr339769466b.5.1740838412580;
        Sat, 01 Mar 2025 06:13:32 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9cbfsm485532366b.14.2025.03.01.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:13:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250223115601.723886-4-ivo.ivanov.ivanov1@gmail.com>
References: <20250223115601.723886-1-ivo.ivanov.ivanov1@gmail.com>
 <20250223115601.723886-4-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: (subset) [PATCH v2 3/3] clk: samsung: introduce Exynos2200
 clock driver
Message-Id: <174083840951.17657.11144069313199701338.b4-ty@linaro.org>
Date: Sat, 01 Mar 2025 15:13:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 23 Feb 2025 13:56:00 +0200, Ivaylo Ivanov wrote:
> CMU_TOP is the top level clock management unit which contains PLLs,
> muxes, dividers and gates that feed the other clock management units.
> 
> CMU_ALIVE provides clocks for SPMI, the new MCT and other clock
> management units
> 
> CMU_CMGP provides clocks for USI blocks
> CMU_HSI0 provides clocks for USB
> CMU_PERIC0 provides clocks for USI4 and I3C blocks
> CMU_PERIC1 provides clocks for USI blocks
> CMU_PERIC2 provides clocks for USI and I3C blocks
> CMU_PERIS provides clocks for GIC and the legacy MCT
> CMU_UFS provides clocks for UFS
> CMU_VTS provides clocks for other clock management units
> like CMU_AUD, which will be added in the future.
> 
> [...]

Applied, thanks!

[3/3] clk: samsung: introduce Exynos2200 clock driver
      https://git.kernel.org/krzk/linux/c/11fd259b7a9c386179f4bb9657c7597c8e8de067

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


