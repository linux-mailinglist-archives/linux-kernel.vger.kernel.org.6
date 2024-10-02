Return-Path: <linux-kernel+bounces-347333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1E198D140
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45537283F41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170F31E6DC6;
	Wed,  2 Oct 2024 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZsMsG1Il"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B141642B;
	Wed,  2 Oct 2024 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865057; cv=none; b=YmbbdFzqIgma3VFxTp1LHQ4bVWJZb8gd7q7ybQlSMktAGr/B5ixTw5Gv6ZtcYXyp2ccvgxDJ7GUbfMDoc4We045Y/APG8255ZDPfRR5goy4itHWWTKcvFHybVmAC1zH+zrf2SCDnDUlz+xIbORDERVXfaIT/stnEh7r79Z5whDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865057; c=relaxed/simple;
	bh=uYBw5tBhJzWcq38xgp2n4AYB0yarF5Gg9Cy2krQMpDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wj5lYXMXWw8ds6H1vr+FSkt2WrEM7Qf/+VKmAj+9+kFGEdQn6QynNwpzTBYAxTghAWieVOtJup1vNMQFVxiYaTaL2TCVPRZcWCd0CXx52yzQuIHNpZrFVBt5+ug3SKbdiWV2iA+hQlWpJ7zAJqLefbgTiYcYW8oqmaPNf+gLJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZsMsG1Il; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3//ArMyAM4NiHtpiKRDuAx6xjbwlVI9LSZBKaxlzmK0=; b=ZsMsG1IlOoWAujfOOm2uNo26T5
	EKfn5btZ3kvp4SnLI4gUdkaq9QZVhuZkZ6vdzRjFb6k8uoXx9VDf59/QBkYF/b2b6AUDdkx0K+iUQ
	Dk+0sZNkQTo9kZmtfZXxXmp1alyvynEjDinPVrkoFa51SMB0wxLNPyso3MRBGL9H8eshW6NXlsCYb
	QOP9PUysOJhFAGUgvPc4pKF8pMbq9EEq+H/V9ziT9g50qFGSsN4CRfTkqtZCxkAeAiK/aS/kjCPAQ
	SIhApK8QQedHRSsPfqrT7q+Hw5AAOMKyr6B959JuHeidBQAN9JEvWHRJRidlnxvrTd/Dt1g0YRvfX
	eDUrTdLQ==;
Received: from i53875aa1.versanet.de ([83.135.90.161] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svwdB-00057r-OW; Wed, 02 Oct 2024 12:30:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Daniel Semkowicz <dse@thaumatec.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add power button for puma-haikou
Date: Wed,  2 Oct 2024 12:30:46 +0200
Message-ID: <172786503304.2125927.13540422477665000891.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241001134741.210979-1-dse@thaumatec.com>
References: <20241001134741.210979-1-dse@thaumatec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 1 Oct 2024 15:46:32 +0200, Daniel Semkowicz wrote:
> There is a PWRBTN# input pin exposed on a Q7 connector. The pin
> is routed to a GPIO0_A1 through a diode. Q7 specification describes
> the PWRBTN# pin as a Power Button signal.
> Configure the pin as KEY_POWER, so it can function as power button and
> trigger device shutdown.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add power button for puma-haikou
      commit: 52f21c63ed6ab7bc5d0ef310c15890ea6a6334c2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

