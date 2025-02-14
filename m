Return-Path: <linux-kernel+bounces-515765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD1A368A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4CA7A20B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4A1FDA79;
	Fri, 14 Feb 2025 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xH39de91"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E31FCFD4;
	Fri, 14 Feb 2025 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573137; cv=none; b=kFHQQGCyF/1CgPxI12cYXWnylVCpLoSmfyJ4aTrL6B4dG9ga0tbP1/GIGzo08BuLi9pnOIf+JogVh7b3EZOIWmR7AFBm7nMbSBMblTB096jS+dvVG/G7GFULMubPXHA97m+/1XoDewyilH+jC5cW4MeHLRGWqq2cy+r7PSv6Jss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573137; c=relaxed/simple;
	bh=FtqmgF2/TSBtJhzTeg9iBi4krRLgSB1t8d44vUxRww8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiR1ViBi2d4FDwZP/XdiGpNFtw4+hVjvZ2KS1AGx/rnchgh+kP+LGjS/11DwnNYqqA5g3mPC20aIxykQU3ZSNgFXfgAC4/d28WOfnQgnSclYrc7lEJqcfuv+VW/m/bQE02a/9h04pmYJCMYG4dTSrIAIaXLflN/0v2QhBhnJQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xH39de91; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LEAXvMzFV1FVFVMZ3IfVMsNAWfHuN1F5zT0O6OvjfE8=; b=xH39de91My2e970+JCQmw54UlN
	03DzwjTEVPEofRCZWVPBtGZvNnVvrvOiU1SHRxjWe15O8eLee0sgEhFFJcPRPfLsXUnkA92UV9cux
	8eS988mLty8sBhj+RhIKD9IBosm9DlCjm0uDZlyaJvYdlaVzSQFn9ivi3+c5pLzy1zPyN9+TMZIAF
	HVo92OusmjAXW51WvGxFsXnMNx5XghsbwZQemZ6dPMURosY2/ayCmaEe37Q1t2OOZ0L4yLnKUK9cl
	gmfwyO6fAVBgK8+Z13qGaCR3mgSIQJ08S3CwAmq85LAPdRUcdW6jY1PntfLHe6BqSRWpTllqSx2hP
	sfrw26+w==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tj4R5-0003TH-Mj; Fri, 14 Feb 2025 23:45:27 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jagan Teki <jagan@edgeble.ai>,
	Niklas Cassel <cassel@kernel.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 0/4] arm64: dts: rockchip: minimal support for Pre-ICT tester adapter for RK3588 Jaguar + add overlay tests
Date: Fri, 14 Feb 2025 23:45:15 +0100
Message-ID: <173957310723.1747676.16443023437911911043.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211-pre-ict-jaguar-v6-0-4484b0f88cfc@cherry.de>
References: <20250211-pre-ict-jaguar-v6-0-4484b0f88cfc@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 11 Feb 2025 15:02:49 +0100, Quentin Schulz wrote:
> This adds minimal support for the Pre-ICT tester adapter for RK3588
> Jaguar.
> GPIO3A3, GPIO3A4, GPIO3B2 and GPIO3D2 to GPIO3D5 are all routed to power
> rails and can only be used as input and their bias are important to be
> able to properly detect soldering issues.
> 
> Additionally, this adds build-time overlay application tests for all
> Rockchip overlays to try to avoid future regressions.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: rockchip: add overlay test for WolfVision PF5
      commit: eb439f16861a8f1fca2c6d021cf7fce0a7a0ca8d
[2/4] arm64: dts: rockchip: add overlay test for Edgeble NCM6A/NCM6B
      commit: 91abdc6b36e12a2c3a477bde90e9f1dd8c2413bf
[3/4] arm64: dts: rockchip: add overlay tests for Rock 5B PCIe overlays
      commit: e95b72390886f5b4127417e4732cae57c8d89b14
[4/4] arm64: dts: rockchip: minimal support for Pre-ICT tester adapter for RK3588 Jaguar
      commit: 920ceeedeb00eef0c3c4f5f0276882b4666dc770

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

