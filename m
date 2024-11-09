Return-Path: <linux-kernel+bounces-402966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F162E9C2F14
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA68D282477
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186E519FA92;
	Sat,  9 Nov 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yZAbTgxP"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A161E4BE;
	Sat,  9 Nov 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176855; cv=none; b=e4wJqT4nFxQ9WT0rCYrZD9Buk/UzZBzqPrN/vqnBdKt0QsCtUHewaMzd/1WE6WKiAO9+pw/GnT9WKzLY39ZNHEq0Ao+ocjIAum1Rf564qo5LPiiNEHFgV6ZMSC4MwEj2wgSp/7nQk59BNaWxp9uFapL6mNegov0ftT9299Mnd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176855; c=relaxed/simple;
	bh=f7MCe2gia/77tSX/lpH2QROavKNEjMHod0MtTlv4aCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYO6IWr8fwjvIF4bs+Iqv5deIhuaXfJSsLEhCqEKNahWN7/mN9TTrJVnI/FWQISlnOJ27ZMh6qR4tIM//oJXbdaib0T4jOToHUgauUIqAFYkLHVOid7+Cb2whLuS0+YMQ7SCu8030Kzi7IHSBtXVenMqdZHfjVIpDloRdVDPZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yZAbTgxP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0VIHC2Ku9UTF968sfdHEdMyRYkhQWzQCl1gtYVzqmTA=; b=yZAbTgxPIS4nAqg1yuE0A1Ibt9
	D5msZmdWwGjNNzL8Q0Zij1iYOx7ZiwOL2yLPUttmiZkPHK/EoPBycqZ+agy6iJeNXDHVDrwzNDEWO
	rmGHyPraD6ThKAEuI2RJusyt68LI38ZlrMs+MGwmHJ+tuS+rtzeHLqKBkOiEDY1eMhjRMYgrBx6hV
	SFYqpLlSKrbuiBNn1cRFBf221KF9K9/+L9U4CwnfZmh49YEGHDubiG2vPCV1dZarAkE7sKvUeUZL8
	luSIej5HbqlpSKkbCZmWsDDo4WJ67y2Y0Bc0NW9QmV3matFoIoLSR22QYfYiXCVv10paHmjOQwbtY
	yuk4evtQ==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9qBI-0007Km-2f; Sat, 09 Nov 2024 19:27:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: Re: [PATCH v1 1/2] ARM: dts: rockchip: fix nodename regulators
Date: Sat,  9 Nov 2024 19:27:13 +0100
Message-ID: <173117675958.1131306.13278216247515118852.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cfc3cfe1-086b-48f1-9b89-f17c9391d3cc@gmail.com>
References: <cfc3cfe1-086b-48f1-9b89-f17c9391d3cc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 5 Oct 2024 22:39:05 +0200, Johan Jonker wrote:
> The nodename for fixed-regulators has changed to
> pattern: '^regulator(-[0-9]+v[0-9]+|-[0-9a-z-]+)?$'
> 
> Fix all Rockchip DT regulator nodenames.
> 
> 

Applied, thanks!

[1/2] ARM: dts: rockchip: fix nodename regulators
      commit: 2c3944d952ec4d3428a8d3163be2263579d1939a
[2/2] arm64: dts: rockchip: fix nodename regulators
      commit: 64b3e42fdbc1f4dc780ca39e860c5514d66e1b97

I've adapted the patches to the changes that happened meanwhile.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

