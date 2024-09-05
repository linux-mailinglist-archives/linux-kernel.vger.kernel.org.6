Return-Path: <linux-kernel+bounces-317798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4316C96E3DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004A0281EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9496D1A3AAB;
	Thu,  5 Sep 2024 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VjVLeKRq"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE691917DA;
	Thu,  5 Sep 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567371; cv=none; b=bLxQgjlYGFp4X5e14YUXF3x7HGNYgf9WqPSnF2GkLDr/biAgJahWJPaibD5YBL+5Wlk4XtvJdx+43VtUo3DAY/8I/nD6Y8fzNw4bb4FPC30sWrK20GfmFvCbK8DeM06BXACSAX2WUa1K96BdcsQzYVCGrx/Ebt3Q7YM90/PsRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567371; c=relaxed/simple;
	bh=m0ulFfp0c0qmGfSBo0V7rj/VU29TQ7f0r+ZleaWqHRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2MxKYB+GQZWEk5wZQxl+VQ/AoMLUG1q4VS0UvFuUAPkxP3H4GST7qR/F4AcNmiMN91C3gX3h5yzyr0TjKRSVZHX73moMGgWa73NXfjSXGs2ojUYBJh5Wtl/2awbNDS7xlE3gaHgOVIQAH47O4LEOdZPIqu1EsQDtMvd6ZnVP0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VjVLeKRq; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CFKa3QArvI4ZsME8fxVIP0fQhge8CdtbHTdaKcYYbxA=; b=VjVLeKRq8dDevG/Pgf82iMjFHW
	d3SlhMsrctomJpOXWlFl7C2HRwkWxfzBf+602tm4Ks5+MRNQT1U2GWgQVZ4vK3XR2zdgqDm8FjHHO
	D08O2OI4zPU1tAAgb6m+gJOiXzqiIWH3Zu9E2OvO8LRtioujWJqUr6IxiUFssa7n6RXzDUzblaz5w
	PeaXS5i1M1Jc37QrhHoCFTKjdK4j7Yw+BVou4FJ+1Pq9SuL0aqvSTjeTGu6wBMOVIGiXcD1hWrEue
	WCItGnFcePwUCOKn7qwzQ2WAzKBeigEClVfBSVVtNo2DtRriDuaqFvFzhU4muD8i2rbIbgd3FcA9Q
	Ns39419Q==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1smItd-0004Ph-Vj; Thu, 05 Sep 2024 22:16:02 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: rk3568: add CAN-FD controller
Date: Thu,  5 Sep 2024 22:15:59 +0200
Message-ID: <172556734994.2907703.16804162938733944876.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904-rk3568-canfd-v1-0-73bda5fb4e03@pengutronix.de>
References: <20240904-rk3568-canfd-v1-0-73bda5fb4e03@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 04 Sep 2024 16:07:55 +0200, Marc Kleine-Budde wrote:
> This series first adds the CAN-FD controllers nodes to the rk3568
> devicetree, then it enables the CAN-FD controllers on the
> rk3568-mecsbc board.
> 
> The DT bindings for this series are going upstream via
> can-next/net-next into v6.12 with this PR:
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: add CAN-FD controller nodes to rk3568
      commit: 687d6009ae28d51a081c3d6f66c29d195a5cda2f
[2/2] arm64: dts: rockchip: mecsbc: add CAN0 and CAN1 interfaces
      commit: e00bf11185033456f3d4345bcd366df1f7cc7255

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

