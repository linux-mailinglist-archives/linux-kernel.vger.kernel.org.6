Return-Path: <linux-kernel+bounces-364703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEEB99D82A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937B21F22DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B091D0BA4;
	Mon, 14 Oct 2024 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="lZYwal+F"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316B231C94;
	Mon, 14 Oct 2024 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937687; cv=none; b=O2ULu9QsvVUFF8B/RgxewTdq8BhVjEjWM6PlYk9OJJcP4nKZoWHANjzb+WttgEbnpO9VPM8SZZSvsYxg/Lmat/KAPnZbKvWdmFTvFgwfwyENabs/2X+Dk+PfY0zc/9KI+jV6LgBoSGSO3ANsnMomiJ9A+FHpODwKAPFe3A5gez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937687; c=relaxed/simple;
	bh=/vHGSU34qDtaxKOjbL6OXDPlmp1Gri+djVQ2DMGbd4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqtLuyQuRhjhUxHWS/plPB7BccA8R0rflH8DLkc+77ss9dUutOI0BanDbexnpz5tCuMso/ZS7Njc/AVscgI+qoEwHzwC3BHHcZiwy3SAtcFxeBinmqpcqzMkoJWM33ningxG8V5f1ORZe/Kd+qR839IL1BcCcvmAx7DqvN5ehH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=lZYwal+F; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=HhkcX725e/3oAWjz9xZVWQiKXqdRkr07/xexm6SenoI=; b=lZYwal+FxlOb7aLLzWJsDONhrL
	DaHhLlN9YQQTB/thexylNscem+ElDuw8zEc3SrbSzTkisNiWjYaS7PA3CI+3eFVdX9iN5uBwGKbCx
	3TDR/OQZresaAepfP/oNvjtP0yELldkRAdKnyY+7ybzBumz1SwW+qitha/+yGjd/lcbbNpStIypmZ
	rxJ+et0dfo3mF8MEqvBHTrCXU2hq379X5FY8c+Nr1IG7Yo6bC77jAuPwYrwRedLfAHyNwaZzn0st0
	PUzlKWtFNf4f4SUQ/LGnmS7FdE/xD7rdyFxvhSNdOo/DHIPhRaWq25++4RJGOkbbxGY2BO6Vyt9lR
	DY5Udb0A==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1t0RfJ-003pXv-2A;
	Mon, 14 Oct 2024 22:27:41 +0200
Date: Mon, 14 Oct 2024 22:27:41 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	E Shattow <lucent@gmail.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbdjM=?= =?utf-8?Q?=5D?= riscv: dts:
 starfive: jh7110: Add camera subsystem nodes
Message-ID: <Zw1-vcN4CoVkfLjU@aurel32.net>
Mail-Followup-To: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	E Shattow <lucent@gmail.com>
References: <ZQ0PR01MB13026F78B2580376095AF7E7F2442@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB13026F78B2580376095AF7E7F2442@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi,

On 2024-10-14 01:08, Changhuang Liang wrote:
> Hi, Aurelien
> 
> > 
> > Hi,
> > 
> > On 2024-02-18 19:27, Changhuang Liang wrote:
> > > Add camera subsystem nodes for the StarFive JH7110 SoC. They contain
> > > the dphy-rx, csi2rx, camss nodes.
> > >
> > > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> > > ---
> > >  .../jh7110-starfive-visionfive-2.dtsi         | 49 ++++++++++++++
> > >  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 67
> > +++++++++++++++++++
> > >  2 files changed, 116 insertions(+)
> > 
> > We have been asked to enable CONFIG_VIDEO_STARFIVE_CAMSS in the
> > Debian kernel, which from my understanding and given the device tree shown
> > below also requires enabling CONFIG_VIDEO_CADENCE_CSI2RX. That said
> > doing so triggers the following error in dmesg:
> > 
> > [   25.143282] cdns-csi2rx 19800000.csi: probe with driver cdns-csi2rx
> > failed with error -22
> > 
> > From a quick look it seems there is something in the port@0 csi2rx entry. Do
> > you happen to know what is wrong?
> > 
> 
> You need to add your sensor node. You can refer to this patch:
> https://patchwork.kernel.org/project/linux-riscv/patch/20240119100639.84029-3-changhuang.liang@starfivetech.com/
> 
> We suggest that using the imx219

Thanks for your answer. I do not have any sensor attached, the goal is
to build a generic kernel, and people can use overlays or patch their
device tree to add support for additional devices.

In that regard, I have the impression that csi2rx device (and maybe the
camss device?) should not be marked as enabled in the default device
tree. I think they could be enabled by users as part of the change need
to add the sensor node.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

