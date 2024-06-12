Return-Path: <linux-kernel+bounces-211177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE64D904E13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66708289E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA016D9C6;
	Wed, 12 Jun 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhfJP6Hk"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695916C857
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180594; cv=none; b=K8rvCKXY/flIAtvEARtzQrrDldTj5Ln5MZdwStWKClwmmxGhFe7GAsEBtAe1PDflcIr8qdgdzzhhQ02tsXM9V01JnIoZqkSB6oMGpHmz543GNgmCPBWmQ8v/7T97SZmvUWxvgN2HKhp/n5Cf4kSoKkCwvefvHUIz1ba0XvJW7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180594; c=relaxed/simple;
	bh=ojT8IuqMgyzfDw2wMoNvYt+uu32xWFLQUITFx2+fWyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohZdAq5urF3rh5v2yrLD30jni6TrVkDvWjio30vTpNfFRa7v6GLeI6CDVPkblEdGfVZtLf6Elx9EwrFDcSEsKFFCL7ZAJBPz09XdHtOEGmMTXepEdyh7y+zurZM6bNyS2qSB6R3debsiW1CpvK62s5j2SVQaRECycmgZtrj+JG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dhfJP6Hk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4218180a122so13993665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718180591; x=1718785391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpHmVv+aTA7gN193ghI3ZoLV8W1rgoLO43B87PnmGx0=;
        b=dhfJP6HklYagYtTM0l2m1FluX8MDIBdfWF79IHIHyutqxzr6V+juAlQF4NqiHJ1j/e
         6CLFlWsZfSlqiqW0ly0PEwbONhDbUVYfo/Dj2EZ0Xpk1m9ruI9hh9XxKukynmaghrO5u
         t1O0ui9ta8/YAZaEsPaSR/y55dz5XC1jZdT7bT8u0Ca4jadxW/U/zO+alunDmUxeKfCe
         Xh4P0KfQv5GGcLhOuOe1qf196gpCMK6BQNYKPGTzOBQ0ngOOPYRJuzIkx1bmUe1+4Bl+
         AjBkMmXHAeohOPtBnZDD+Tp6fiSStvvHKQGBX/dCedwfqrH3X0O6oWY0RHrYKwtlfJfm
         6AsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180591; x=1718785391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpHmVv+aTA7gN193ghI3ZoLV8W1rgoLO43B87PnmGx0=;
        b=ZYWxGExc3OyVAc/Fr/tzhK685J1imhbxC2CefiLyVl5Xw3aOSQnz+o6mVwQbdNtqeW
         xOF5VboNzSc4Cfy7XrZs6Pirk8yv8vtRM7QdyadZs0jKQWcvzGPmAcQ9YmRPNdhgh4R3
         Gxi5xBDm4WU+sIIAAWyxLo53wqPeRtp05njQZsqUPeBtVg5cXMJFk05Og5b4dSOqaUcZ
         LP2AWs46QAKXMgomXoQPqs7HCa7sx+XdZs1+YF1qug2amOx32kszOuUnQSL2NSemNw9z
         bGwyweswJPwx+SWGB9+kdpinXJ9n6v+eTYtUs1pvXgCxbyb+2WAo8CNwGDlhhHa1+AWz
         e0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUuxgOU44QVFNwmUzilS8mbjzyhud/a8AQs5c9V6Ejxt9faIbEMdPdvaAs2nK2wX6pJ0qdfBx8QKl17oUXmVzjNkicXN2JMesCgzZjK
X-Gm-Message-State: AOJu0Yx/d40ksasRw61GrhshRvYuiTos/QE1hhowwDRVEyC+ktRFLzjE
	jHwQhXtTMDDjRMmRq9N9Gn/v0+prjXI9oiZsuTPc3bLcO187QHMOV6Y90KXVfXA=
X-Google-Smtp-Source: AGHT+IE57OSgQapFB+OyPJPptfmP536/k5ZcHQST0lV1cWK+35gfih4e6xVNky9OWeYJmGgbyKenKw==
X-Received: by 2002:a5d:66c2:0:b0:35f:d54:5589 with SMTP id ffacd0b85a97d-35fdf787aa2mr792729f8f.15.1718180591153;
        Wed, 12 Jun 2024 01:23:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1fd78d1bsm8796559f8f.48.2024.06.12.01.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:23:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sprd: Split PMU nodes for heterogeneous CPUs
Date: Wed, 12 Jun 2024 10:23:07 +0200
Message-ID: <171818054830.16919.3359416958968800927.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412222923.3873814-1-robh@kernel.org>
References: <20240412222923.3873814-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 12 Apr 2024 17:29:22 -0500, Rob Herring wrote:
> Arm heterogeneous configurations should have separate PMU nodes for each
> CPU uarch as the uarch specific events can be different. The
> "arm,armv8-pmuv3" compatible is also intended for s/w models rather than
> specific uarch implementations.
> 
> 

No one took it for two months (!!!), so I'll grab it for my other generic
cleanups.

Applied, thanks!

[1/1] arm64: dts: sprd: Split PMU nodes for heterogeneous CPUs
      https://git.kernel.org/krzk/linux-dt/c/b32e036a7403289b2a10a438bb852da7ca651c86

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

