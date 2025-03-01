Return-Path: <linux-kernel+bounces-539980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5194CA4AB94
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6464B188B98E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC91DFD94;
	Sat,  1 Mar 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sflCk1nq"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABF1DFD8D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838409; cv=none; b=JGl7Hr3TJOWiKQ2WbI+RYoCrNi5liukuIOYdvh9VFbdbuKdjV4vS47hfSImjS8//2U7zeUWgqZQduJ5+FzqtfF2l+1QieT/odhvIQAnUdwOokfve95mKinrajpuPW5SLZ3mZwF5Hin5teuZHlI8DaEtA0Yxf2z1q4Vhp4Roz+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838409; c=relaxed/simple;
	bh=l0jI5ewz4E8unNwYqgNQ3772jTNnjhi+wvE+Phrny/8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DEpVvr/WaZRX9JYapCO5GmBLLrSiizVQGl46zMuY5W6P3hFU/T4MYOwRZUDRupWsfijAADuPCuNE02mhmMng6t062jGegVrpbrMIX6WIGoPwSCAEEfVLCDNSbfGT2lPrpNJZpUySCSmyvmWRm+kU1+6A1JiTk40tAYDQrElzKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sflCk1nq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ded500589aso499284a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740838406; x=1741443206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kICij+zGJ4SJUAMRx6vOY4fWK/HFQvlnrffeNoOoYzw=;
        b=sflCk1nqgl8RMSI2XM3irIn/+zWof5zGU3bdYiSqzzIng1o3i7Pmsgtw9HbaYtTuGk
         yltDZi+Sn27JC8dDA2x93vPla+vvoLBYjM8gYofZ5oRAhDMbKxRO1bzVtyC1/JSw/VmS
         Ht/BUdkfiFqPhahZsmisuTedEcLiLFnjpCMWrOBoUheN9yqR+7AYCEBiDvr5drdYFVL1
         rUD6W/CIpPYo7Z9huRNFLGti9MI0iCQNhQOh9O4Hz86kwbSVuBq+uDrPtxMjRR19PfFk
         Eln+WYE8U4mM/ZFqh31CvvBm+8PUBFxa6Wdl8k3ZfwoFeSw3iXkZoLnGFhd17cOl7olx
         juwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838406; x=1741443206;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kICij+zGJ4SJUAMRx6vOY4fWK/HFQvlnrffeNoOoYzw=;
        b=kIi3R/PYdspPCYZoU5uPml6xsSKAGkkLkbJVADN44NZX2QiXdKf8QguoDOSQVbbZn5
         d9NBSW0+WvZfLL0RXxjo0qsnjhGspn5GdQAPFgCrjy69/Q0N5LZCBRFwXS/8S/FhV+Li
         X03kvz59+Ydewc9EkWw4dQKUZ4G+9fqpk2XVgpkmNLye/FGiCWBPCz1mr5rbRfjNZzV8
         idy08P8ngBg0oXgy7YYOjdxPRaWV/n9pl2S4S9TCU6zYCyKOBZCL/NvVBYJyQSyCt/Fi
         km6n/o3STvxeiiggiKypni/OQmaDTFqc9XbxYvOgExZhpt1Ra2W7YI03DxF1rGokg71i
         /3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfDWtCV+mz9dvWuPCDyWtNuMJM+bGYcJLEXaMyYQM8LRZYl1q++cx3TMRKCG/6h08jdpOG//oQxfqba2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6GcjdYun8dTK/lLw5OLhVFRKelwHIK24EOCwVCLHcPA4MFE/
	P1UiFxChtcUpyxO/naB75vk/Riw/L/ipNoVyg8vNZxibh3nFfzsZJ36W4Zm0T7E=
X-Gm-Gg: ASbGncsVhArRV0CZX2kXiWTiluzG9RdsAZGgJVmNvap1FKnLng883Otzu/SNYVgvbGr
	O4/cYJHFxOpjKFmy/UTBVnCjLzEhK2qC47KkF0CkVmbWS4IxS3F5L2wo2tY3ThJ87wCRUWJcUTL
	O9fhmVLr2slP3+V7/nyef33rt8r2Y2RMThvsCzbvuSP4kEA1Hbvu+6pXMPmywxvJwQh/RbXokUb
	eDS9c9aWiPx8PJyRAtLkX48CgOV6kBzxVGx3Q6R5yIZFubMMb1J8/wVm3AJ5ODiBrYe73dRhypp
	exfvYywjSt45C5mI/fJ7M+0rpm1YtlYe6VEORMspVWui8wzAeWIhXDSb9whP
X-Google-Smtp-Source: AGHT+IH4LDzdUoKTGOGgBFHqmwTZj1CstR0ayqx7aTgOFcUj9dhcl28Y1Pq7/cB2aRE6iWaW2lq9kw==
X-Received: by 2002:a17:906:da82:b0:abb:ebfe:d5e9 with SMTP id a640c23a62f3a-abf275cbf12mr350485366b.9.1740838406199;
        Sat, 01 Mar 2025 06:13:26 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9cbfsm485532366b.14.2025.03.01.06.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:13:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250301-exynos7870-pmu-clocks-v5-1-715b646d5206@disroot.org>
References: <20250301-exynos7870-pmu-clocks-v5-0-715b646d5206@disroot.org>
 <20250301-exynos7870-pmu-clocks-v5-1-715b646d5206@disroot.org>
Subject: Re: (subset) [PATCH v5 1/2] dt-bindings: clock: add clock
 definitions and documentation for exynos7870 CMU
Message-Id: <174083840306.17657.2523115679702297451.b4-ty@linaro.org>
Date: Sat, 01 Mar 2025 15:13:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 01 Mar 2025 09:27:12 +0530, Kaustabh Chakraborty wrote:
> Add unique identifiers for exynos7870 clocks for every bank. It adds all
> clocks of CMU_MIF, CMU_DISPAUD, CMU_G3D, CMU_ISP, CMU_MFCMSCL, and
> CMU_PERI. Document the devicetree bindings as well.
> 
> 

Applied, thanks!

[1/2] dt-bindings: clock: add clock definitions and documentation for exynos7870 CMU
      https://git.kernel.org/krzk/linux/c/35b2b3328c2e02b544f49d010170fe981f20ff11

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


