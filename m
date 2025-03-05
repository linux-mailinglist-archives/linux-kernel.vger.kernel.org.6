Return-Path: <linux-kernel+bounces-547582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81899A50B44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80CD188DCD5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4820253352;
	Wed,  5 Mar 2025 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFHFL6lo"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D0F253345
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202114; cv=none; b=jCwpnAc/amXRl7jnsatavmrBbkM2zA8gCr1xW+MZ278qwcc+lCw0U8x33F8TXhbEe1vRhZYOKwYFYO38JD8QM8p+qkeR2r4uZxaDM1lFI9twEsVj2ak3cnuQ48SM/yADgptI6wZN1xFLG8cNYpbq9e0qL3oM0hPAyGnjAa/5QD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202114; c=relaxed/simple;
	bh=eaU02QhNuP30cd+TP36D1lUK8A3cYdfrWfLHBYmeJr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GyT9zboxjUw1sBe1bB/TOSvarXO6LfmIqfcfu8FEcHS2dTa3BMlTj/3g4mIkEHe8NTRKDDha109OX4uuvXm7fRK6fk7MK2k59ksY5XMk5AXQMG7D+hSHViMgdteIU9B8DyGOcYDrxO1FHe9X92Pb3vLEQqu3l4qoefL/ibElGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFHFL6lo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bbe818049so3835205e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741202111; x=1741806911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wM1N8e/M9qgsmj8kvDT3vhaMw3S3wE2BxFSjcycLBlo=;
        b=kFHFL6lomqSYF/E3LRvEq0Mm7d2kvjJlyoVohBremTaSDYgBHHq3h4ERYG1QT+wLr5
         nNHPgntUNXTbAOjtAhTNnqNv+Ni8gxq56jXkYEUBg/mlcPxC25NVlm5bySeOs5V/7Dwn
         NyaHqKUd8HHI0HinjppPFkD31CQf/QmofqowNMoHtBoHR/QvPZr0pSk7Z4SPG8bcKP46
         4k3bnraIXGAgEXAxYNq44eIaOr1ONv+HWnZuFeOXSciFFxKcwtYXol1HDA3LmNKRgrgT
         P3OiwwFHaL35cbBEqMePahFqCnzhT8ssp0FucL9xRaNY4oRKFCVoZiYmIqi9pSv6FMpZ
         bxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202111; x=1741806911;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM1N8e/M9qgsmj8kvDT3vhaMw3S3wE2BxFSjcycLBlo=;
        b=vHxnOxgNhnQiwfm0//jOkon/hLWSddEYm4lgSbwunwlwqd3A0xAELzDjEVfFGMRzbi
         Oy/5qxtGhW3BRVRp1QhNiT9Fulv3mQDdeGuyg8KGV05kU3gNsjX934hG/OylMNJ2BXes
         PgvIZ00EfBzoxl8LOg7zWILJ+xUkAoEZLt+0/cWFrfUDI6avgqGAgL/LxBP8E8mxJYoi
         XfFas7Fr0Hpe7hYzWzBhFzxgkGmjbt23sSL7D2Y00Q5ff1NXWUV/txqazeWxnB+7Iv8K
         UtFdrx9cJvi65UJ6jW7hJq5WTEKP6peKpFwrBHjOe3H8N0dFO7SHOUmYHxXaNntz7yAC
         eSQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGmiNivEGLc+je2AK/8k7A6Ws+Qqcn/cnPYDN09Ju4VkgG/P6KWM+5Cze/AkL+xv6hYauqfbuMkEMPbKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtZXJigFCHfv2JXR7tdwBslAI/SZ4Ry2gXemQWnbrmaiFoEHw
	8V569GuHB3+GaGHACV2DWUL7zLKjreD1Uwj69cxSUsCkawAFLCVThdXMk0JGsZM=
X-Gm-Gg: ASbGnctjNbXWH1o/Ked2H5iuVsqz8otV16wSYJafiwJrfccWjLs+WMRdzF4zYsvGjQE
	SOXRwHdTghofe17na5p7MtWU+XZlhkzzSePAALij48qDkbRmDBQysv1fLXBOBL/OkMJ5lljinWM
	O/utiRkCxgnv4/Tqtpd/3U9cxkaYvRbCS+Z7LM5Q6PpoSrfH2Sr74akDLU63U/n/Eg5VCuqs4w6
	21iPLmLPS9wkCzjRBb1JYAMp1dYFFlka9VCYHrP/W2k9q0tasEHLn9TQ1eMDShaOTJ9zBQw1bxp
	gZvjtA8N26kY12ZS7/24wdefjTItMyvwCLqq4pYL97SR6VjjVIstotg8kOFD
X-Google-Smtp-Source: AGHT+IH0QRpxP2cLe6fhf8H2SFYp0QMMo0PU6M+JQg0NUWa1IhswO3Lg7DHT3HEfhHYxigAaOb6sGQ==
X-Received: by 2002:a5d:59ac:0:b0:38c:5d0b:71ca with SMTP id ffacd0b85a97d-3911f593b5dmr1453208f8f.0.1741202110729;
        Wed, 05 Mar 2025 11:15:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcc186de4sm29421805e9.1.2025.03.05.11.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:15:10 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, aswani.reddy@samsung.com, pankaj.dubey@samsung.com, 
 s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
 mturquette@baylibre.com, sboyd@kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Varada Pavani <v.pavani@samsung.com>
Cc: gost.dev@samsung.com, stable@vger.kernel.org
In-Reply-To: <20250225131918.50925-3-v.pavani@samsung.com>
References: <20250225131918.50925-1-v.pavani@samsung.com>
 <CGME20250225132507epcas5p455347acbd580b26ee807e467d3a6a05e@epcas5p4.samsung.com>
 <20250225131918.50925-3-v.pavani@samsung.com>
Subject: Re: (subset) [PATCH v2 2/2] clk: samsung: update PLL locktime for
 PLL142XX used on FSD platform
Message-Id: <174120210653.76378.2120670200586172536.b4-ty@linaro.org>
Date: Wed, 05 Mar 2025 20:15:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 25 Feb 2025 18:49:18 +0530, Varada Pavani wrote:
> Currently PLL142XX locktime is 270. As per spec, it should be 150. Hence
> update PLL142XX controller locktime to 150.
> 
> 

Applied, thanks!

[2/2] clk: samsung: update PLL locktime for PLL142XX used on FSD platform
      https://git.kernel.org/krzk/linux/c/53517a70873c7a91675f7244768aad5006cc45de

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


