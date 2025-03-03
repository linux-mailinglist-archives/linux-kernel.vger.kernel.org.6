Return-Path: <linux-kernel+bounces-542481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFB6A4C9F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF77E7AD370
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C6D2505A0;
	Mon,  3 Mar 2025 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKZ9hJnt"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C82500DF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023069; cv=none; b=rueb00eM7MFgZH2pyzZC0lZx23fEE+uLivvYob8ulDnqbp0jpdAUlenhHGj3T09kPj873F9n94EGHeyB9YFjotlybPqBPTFSfCcJzfG9LIjXF/l77WF2Hb0Hgww6x8DCug3UWStxXbz1g/ZbOlmBD8dhLhYHXttspXD0scZ21U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023069; c=relaxed/simple;
	bh=nqVSHW1hb8CGjJ3aX4TgRZ7EInx0TlUtu+JIylVTgfk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XXka1R1T2IVVu2DhjkdtAOsvgb1kPWv7CFLuDDIOYwzYNjh+dU8ulZhMNmBcPPv2pMwIRKzRhDN+Z06q35UBr7CxyZXPT52CcOzOHKLyl4uK896XyGW/SA2Cvzlqx9S9pstRXY6LfLwkAl3Tuat4OpdmlX1JPNR/J3gTnWW3BUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKZ9hJnt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e4d3f92250so6253710a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 09:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741023066; x=1741627866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF2rTDt4Vl7NBjjbuhRzwdVJI8zgAEslXXnd2LthCLM=;
        b=kKZ9hJntlumxuNs3mCw9PfbDK90NaYpNFjzZNCatmF3PKloBfMAKus8bBVW8u3aOGG
         6kJD9kQQhuT7HU41A/tZeR6sTPvvHWk3J0nPdSUmZi7hZYrsPqUZ/a2wSUpbap/FYzB0
         0VPE0c2kNI9Ao2mHU2CzP5SlS50rgn1kJPESR0fCeYJ4u/OjDN3bhs/VsFhZX3XYr4q5
         5f9wVpiZiIqQIcNyh2kDOzJuAf/yY1J7EQGLvKV37Z6g0fTvwSf9AVV3lE9Tlu6t+yMk
         sH1sLFKurjW6fHDLdD9jcj603VOple/3uacwWzJQW2GSJ4vlWGKwyWAb/vZ0ZCyRLYcl
         S6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023066; x=1741627866;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF2rTDt4Vl7NBjjbuhRzwdVJI8zgAEslXXnd2LthCLM=;
        b=iNqpZHTpzrq6rJntK1EjriRlpTz6pbeRkb+0WNRlWXlHLWeb3uRUWyGzRGgVIXH4sr
         o/gi2ZDXGD60FsPu55NBoQmM60M5Dtfwm62fWddthivp6TCOolAF1nfnLt1iGoDMmDFN
         OJbH5SBMPmo/bYZ3BtrLe8duXVP1DqR8NChZnZEFKAOejUunE11ZPhvt2BRdGpa+uQiq
         guXJwfa6OcUTVyj8Vcgdevj9nyPfgc9jx5YB5waT2jesM0jYL5mDkYVbU7h21GvBQv4F
         VH/XiRjl3gFsP00Goxv9DWEzI3olcV+Q8P+E/T5ZFqCHKTLL5R4/IadJJvX8tttBZpr+
         og/A==
X-Forwarded-Encrypted: i=1; AJvYcCXI9v24WsUFeEma0Ap8xBpw4a1UjwVcaPFg12YwF3Qb3ZSCNPuy1ijIBol2thfi/vO4LywIRRYo8dVDAXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLnX+jUE4dSAsWZ51ayN8he32RXZhz0xWvPrpo9FriZAxOO7H
	fxQ6KG4GIlrLqwCknk6bQku9m3fRh3vQc0GOtHg/CnhujXmzNPKaBkiLUuGy580=
X-Gm-Gg: ASbGncvkalkNy9VIOl5xVvC54wzA0Vn1qxntDpSx2lwgR6EtHePhTh/7HYLpK3j7aAu
	DdGCQpnMbwSwkSmtzCy5qNxRxlOcc7w2w62RP4NhGX9eDl4ovmcR31dD70j6CMLWH4tiDHF4edJ
	I26p/HBX3cOg1JI4PkS62Nb8dzu6j0+v2diw+h15BLLIjgq6G04IgRTxtwluE1RB44EIPazjEb/
	cmU8B08Z1OE2k+F4MVP94YJqca91K4TqUx1gJI7D9JXjp7W2tZvA68Ae2LPs/o/j9OZ7tTJXVnY
	C97SFDltSYvAgi9DL1QzzaiMe/83hTnEGn59tsuYAO4=
X-Google-Smtp-Source: AGHT+IHZFUDG4I1s5mhjx5BD8Nhn984lVguIKOxIFYPolda1uofxljVhHU7U+dUntUauGH1gOLaGlg==
X-Received: by 2002:a05:6402:3491:b0:5dc:7643:4f3d with SMTP id 4fb4d7f45d1cf-5e4d6ad4170mr14262858a12.1.1741023065567;
        Mon, 03 Mar 2025 09:31:05 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6d26esm7085355a12.20.2025.03.03.09.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:31:04 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
References: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
Subject: Re: [PATCH v4 0/6] arm64: dts: freescale: imx8mp-skov: switch to
 nominal drive mode
Message-Id: <174102306220.2928950.8878245519332562153.b4-ty@linaro.org>
Date: Mon, 03 Mar 2025 19:31:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dedf8


On Tue, 18 Feb 2025 19:26:40 +0100, Ahmad Fatoum wrote:
> Unlike the i.MX8MM and i.MX8MN SoCs added earlier, the imx8mp.dtsi
> configures some clocks at frequencies that are only validated for
> overdrive mode, i.e., when VDD_SOC is 950 mV.
> 
> For the Skov i.MX8MP board, we want to run the SoC at the lower voltage of
> 850 mV though to reduce heat generation and power usage. For this to work,
> clock rates need to adhere to the limits of the nominal drive mode.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: clock: imx8m: document nominal/overdrive properties
      commit: d5992f1af1550a9e11e42cfa2ca1ad2a1b7fd7f3
[2/6] arm64: dts: imx8mp: Add optional nominal drive mode DTSI
      (no commit info)
[3/6] arm64: dts: imx8mp: add fsl,nominal-mode property into nominal.dtsi
      (no commit info)
[4/6] arm64: dts: freescale: imx8mp-skov: configure LDB clock automatically
      (no commit info)
[5/6] arm64: dts: freescale: imx8mp-skov: operate SoC in nominal mode
      (no commit info)
[6/6] clk: imx8mp: inform CCF of maximum frequency of clocks
      commit: 06a61b5cb6a8638fa8823cd09b17233b29696fa2

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


