Return-Path: <linux-kernel+bounces-523286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DD7A3D4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3228188F268
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DAB1EE7D6;
	Thu, 20 Feb 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="T/PMmnlM"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646C2AEFE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043889; cv=none; b=Vw7v32tpuPumgNBoHVcaFNVG9usvLx9i4UUNI1wAIv/GLibCMBbWinAN9AMJKPGcvVsuESHOrN54bF7jk+qrv2j/bdSM1MwfMhfGENbWDQWjCTxw+z8r3QfkRbBZadSffsf33aCm6QEu/9oIl77sa3DY24Dy4RYuLOFAAEbLBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043889; c=relaxed/simple;
	bh=d4+jKvkJJaIOmdujVUcDEyIJ/sZ1CKGmVkbuWSalcKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJ3EJtX4kBAD5KOb+uoaaQBUm6zBfNPIRGujdNEOu6ZBpwk7Z0DXLPekL5D+6wN7GEok+ibjQXfEzFhhDnn662JMCQnrH7aUwLRVpC3O+VU4fIpDDG/+lV87i9MVan3zMvsapCsexugxW9mSvBflLYgRm2msBQhPMTJzlGAhAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=T/PMmnlM; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lR8ijKB3JqpL8pV5Bk+/2fyVFlUM7QF+r6boQ5Lr92c=; b=T/PMmnlM7C/f0zTQljvckKyjoy
	o37J4FXagT+NMydiD6D1ZY83KvKREVopGkgUSs3PqenRjdt1jPttBnqtnIP5itf/xh5Vf0d8ulH34
	an+a02uWsUPNy8mngBiLFV6i19DvtB54Xs6RawBTeXeGFaAmWakp+Ljbohofqs1efOvCitovAjJza
	+RAPJNxTviNbaKhIxpRb/9cyllCYzH7FIUWh/fRpKj0PFJqyOvjZfkM4mKfukr0twLPMID6Xmqmbt
	DviMDaZEVOIhpFPbY5AIEBlz1tcuSjFhwv3LdiGizaJUxce8JT9ahFFZxCCRj2nrFT7K10uqI8S3/
	opw/nKmQ==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tl2tw-0003ew-Bj; Thu, 20 Feb 2025 10:31:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lukasz.czechowski@thaumatec.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: remove supports-cqe from rk3588 jaguar
Date: Thu, 20 Feb 2025 10:31:14 +0100
Message-ID: <174004386808.2551340.16092707795307058059.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219093303.2320517-1-heiko@sntech.de>
References: <20250219093303.2320517-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Feb 2025 10:33:02 +0100, Heiko Stuebner wrote:
> The sdhci controller supports cqe it seems and necessary code also is in
> place - in theory.
> 
> At this point Jaguar and Tiger are the only boards enabling cqe support
> on the rk3588 and we are seeing reliability issues under load.
> 
> This can be caused by either a controller-, hw- or driver-issue and
> definitly needs more investigation to work properly it seems.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: remove supports-cqe from rk3588 jaguar
      commit: 304b0a60d38dc24bfbfc9adc7d254d1cf8f98317
[2/2] arm64: dts: rockchip: remove supports-cqe from rk3588 tiger
      commit: 3e0711f89e5e7b0c7b2ab4843dc92dcbbdbba777

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

