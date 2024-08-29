Return-Path: <linux-kernel+bounces-306790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F4296439D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F4E1C224B1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C33192B84;
	Thu, 29 Aug 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="N6Y8pbLp"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A5E192B7C;
	Thu, 29 Aug 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932548; cv=none; b=hnDRix6uxj6bDZ2eRhJJYnpz96TyEoAU6jS0QfGpZcADG4V1BUsHvBW1OvXKgSmGhJHwOmHfdjDudPeWplphyV14QgoEuPn65NkQzs+6H9mC9F7ZQTGNYLNDKEmwH5sco3h6DTI+o/9TqpdJ4C0UdQJx8Fdgr+EyYSwOPLWSlwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932548; c=relaxed/simple;
	bh=FCSAChrWFDKdcWJFIikEalr2qxD2b3BG5GIHb84DhVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5/Ezu8xYMXy5f0GbFO6W4RyC8y7ee8hLSymCjqxGD4syEPmB4EIowhOOHEmDdmwof39sqm7jjdd/bLR79Lhsuw+9C39ZZB545NF88mbHIV1BVhfEvsFMQe7xn8yshESTuRKZEN3fihBlbkPpsEMJTQ1C9zdIslG/TD103B+8cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=N6Y8pbLp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=09k5tGRHsX1lPAzdVjGE3UyjwnS3VL8JaqpnFiQJWMk=; b=N6Y8pbLpYqVMpm3S/cLI1Ugkkm
	f3w7juzI9/Dall0G7YTOR/zRPJxONg6czYbBbAjTDstBDZWgSJ/qJlCP/1w6ypFViva++G0l/Pt3m
	A1K3egH+uk88yc7TUac4dQ2CJVrRsCny1smQv0QNtSQzF7TOHM8AHccUPvUMP7YbWlENDtsMpT1Ca
	GhZLFM8/WIdNjvt2khMCpa06verSAKZX7aXUpJY5JjgZNC6XFeuxJi+j2H7qZM16zZeGLYjkYkAs9
	7q+hpa7YHlmgTnFQjtEHme/stEA3VpqJLb2p5QJvDz9XK0DOa9N6HNbAV61IfyzIiUJoi+H6fMeTy
	Aek48RCg==;
Received: from i5e861916.versanet.de ([94.134.25.22] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjdkc-0003fK-8k; Thu, 29 Aug 2024 13:55:42 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix compatibles for RK3588 VO{0,1}_GRF
Date: Thu, 29 Aug 2024 13:55:32 +0200
Message-ID: <172493252602.1711002.13468063682788889129.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828-rk3588-vo-grf-compat-v2-0-4db2f791593f@collabora.com>
References: <20240828-rk3588-vo-grf-compat-v2-0-4db2f791593f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Aug 2024 15:40:07 +0300, Cristian Ciocaltea wrote:
> As Conor noticed recently [1], RK3588 VO0 & VO1 GRFs incorrectly share
> the compatible string, since they are not identical (though quite
> similar in terms of layout).
> 
> Provide dedicated compatible strings, as a follow-up.
> 
> [1] https://lore.kernel.org/lkml/20240821-stretch-scam-09d7adc08a4c@spud/
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: soc: rockchip: Fix compatibles for RK3588 VO{0,1}_GRF
      commit: 11746c33909b082cb3b2183dd4164eb8bdcfc3df
[2/2] arm64: dts: rockchip: Fix compatibles for RK3588 VO{0,1}_GRF
      commit: 5956ee09c8254273c587b07f5b4d42da59a0325c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

