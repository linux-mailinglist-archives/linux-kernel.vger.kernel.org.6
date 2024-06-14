Return-Path: <linux-kernel+bounces-214358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0EA90833D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434DF1F22F57
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536B117597;
	Fri, 14 Jun 2024 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DGuuHsNf"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BF13C3C9;
	Fri, 14 Jun 2024 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342129; cv=none; b=aaudbfvqB2WLy1v6PypJnttZJqxODhst0/2obee641LYelZaxhy4LK/bQk/EWUaYELwvVPGJIxQQis381LmPs9Tzb062oPfKjhc518Y5QiSDmv+I/YN1JNND4iJtlAchjHGMW9VKobcNU1VjBHVQt3SCA4PVO2Zeer84jp0q+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342129; c=relaxed/simple;
	bh=8Yodx3bQqcaFi/NLCPSDLJAbGk5KG6nr2tgmLyYLi3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1xaZl0aG/HOPvcb385AdvpnOUm7NxdGttpGjcUSbwbNGIkbBx8uGxs1NV/yUyPQZvHIszkBm2Bgc6/0scX7fmpBPixdMADDtg8ughPWCBRVGD6MXZPnhqKtt5xVRI5Uw9+L/Yveuau7xF8yYotn8kfZTzD/kHJGqz7ETiXZ7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DGuuHsNf; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E5FNbd013081;
	Fri, 14 Jun 2024 00:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718342123;
	bh=6idw8Fh3RVDn0M8muiSh2f8OOpn4/F1VEqdyzYTTqsQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DGuuHsNfoA37S51tNV4EXZUhlPcGYdV3N/ueLCXO5Gt9oK2rbnWJ3oMOJ+v82YlST
	 eM7nk2oVM6XqOQ8Z8akY1qKzGhWTnaTSjwJh/glIVub6MoMKdvjemhI0u3k4rvNSoc
	 rCGUTBCozJBVf2eFSkIaDbBTl+LwSe8ymrU1LD4Y=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E5FMuq104519
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 00:15:23 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 00:15:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 00:15:22 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E5FI1f062696;
	Fri, 14 Jun 2024 00:15:19 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, Beleswar Padhi <b-padhi@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <b-kapoor@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v4] arm64: dts: ti: k3-j721e-sk: Add support for multiple CAN instances
Date: Fri, 14 Jun 2024 10:45:15 +0530
Message-ID: <171826022272.240984.1601774830669647807.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240430131512.1327283-1-b-padhi@ti.com>
References: <20240430131512.1327283-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Beleswar Padhi,

On Tue, 30 Apr 2024 18:45:12 +0530, Beleswar Padhi wrote:
> CAN instance 0 in the mcu domain is brought on the J721E-SK board
> through header J1. Thus, add its respective transceiver 1 dt node to add
> support for this CAN instance.
> 
> CAN instances 0, 5 and 9 in the main domain are brought on the J721E-SK
> board through headers J5, J6 and J2 respectively. Thus, add their
> respective transceivers 2, 3 and 4 dt nodes to add support for these CAN
> instances.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e-sk: Add support for multiple CAN instances
      commit: 021d3d5f0741e5393a7a110ac909fc746b1e0a4d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


