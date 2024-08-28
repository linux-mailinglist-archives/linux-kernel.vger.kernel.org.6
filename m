Return-Path: <linux-kernel+bounces-305006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDAC96280F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC23B20F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584C184528;
	Wed, 28 Aug 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="WhMkgT+o"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20E15B12F;
	Wed, 28 Aug 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849985; cv=none; b=iw5QklXJTg3SjpgqAMp7miTGb/KHZRH69hk85ntgMah33vXBOn3FsV7z2pwyJQoEL+GEFlM1nNsF7r3TBeHLbYH/Ogb73sjUvtBf0LjR3+pGDGyInKM5rYIc/WINp2J/MhdEGO9YHjX4LVMLWTKuznNcPMGzG/84eiMNmS3wLGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849985; c=relaxed/simple;
	bh=PoJ58OyUY8+InttErmXtLqqc+RMwktChV0+7+uuGVHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHv4BYcjl0V0GwfFlPxUhwisPeIRLpfyCNbz6KQJj2Eb3dfh6wUFh5LERxmsV1u8xCw2LCWZUfr9nDo1yNTGtwHix7ch/hg06AnB09wu08HGTLtiZKgOdd+eIyToywrvwQ9qpRMLSFdThawtyAvvR2vtz9i1uKK4NqJqJHBAvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=WhMkgT+o; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FJB8kqxvEm2TG1FvDWYg7p79qtRb7PR5dNg6chIXUPg=; b=WhMkgT+ozZUJARpn4Hnh7CnYbZ
	4zaPyvWd9DHlGFeyyWBp59bS+8rEpDTCJHnE3tUBhUw5m3+MjQPKu9iwje5dz/ZgFFnSuaEq/EsnG
	lbcDPCCEEW6m2s+2IseCD3i5XPcMLB3rHct68y4Q8o4q7ExAGSBUUrpJzue++N7tKWxEbABLuxeip
	QSKbpFOVe41PVRPGKoGP3VmpRTmOQ6qpw0v2tnvsuPeU1YzZIEA2zEDISn4Zw/sIfl7c74ic7X2h4
	sFD9vEAaLhtlXvVf/FUXofXWAeaneyaAqUXzK97J8QJXB/GZ3yEz+/GaLaoX/etV1B/xSmwNpsgw4
	7ZqNPXrw==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjIGv-0005Ox-Tl; Wed, 28 Aug 2024 14:59:37 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Liu <net147@gmail.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Jonathan Liu <net147@gmail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: Enable RK809 audio codec for Radxa ROCK
 4C+
Date: Wed, 28 Aug 2024 15:00:49 +0200
Message-ID: <2502361.uoxibFcf9D@diego>
In-Reply-To: <20240828074755.1320692-1-net147@gmail.com>
References: <20240828074755.1320692-1-net147@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Jonathan,

Am Mittwoch, 28. August 2024, 09:47:53 CEST schrieb Jonathan Liu:
> This adds the necessary device tree changes to enable analog audio
> output for the 3.5 mm TRS headphone jack on the Radxa ROCK 4C+ with
> its RK809 audio codec.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>

as it looks like you have one of those boards, could I possibly as you
to take a look at the vdd_cpu_b and vdd_gpu nodes?

I see (and devicetree check reports it too) a pinctrl-0 for the vsel-gpio
without accompanying pinctrl-names.

Could you check if things fail if you either add pinctrl-names or remove
the pinctrl-0 entry?


Thanks a lot
Heiko



