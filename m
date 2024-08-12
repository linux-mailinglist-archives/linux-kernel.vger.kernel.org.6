Return-Path: <linux-kernel+bounces-282850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66A194E96E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719A11F2458D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9B516D31C;
	Mon, 12 Aug 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="D+WUqsf7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="s4hCdMiD"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE816CD19;
	Mon, 12 Aug 2024 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453926; cv=none; b=dwj8lpv97KE1TE4g6UsmTWOGTtI/HnvFDJ+qLqAvVirpRx7A8gjN7UM34Z0VnRuXl3+EHJnYMkVnPs3pTF1oTwJlCt9P/THmeEcLne7x/KMBKhcfuBAremz5mNdhMGCnlAxzQaMeBwEhZ36QtFb+z9WziiYFxEwLBKKOPKieodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453926; c=relaxed/simple;
	bh=iVGhNQ7r+GgMdXvKda908eL/Y5A0YBwZsNL00pSOsYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcwiGtbmxGhP6VamEznWwhQXtw2wB4su3I6+ZVZdxj5omsvf86emWwmKq7mj9Y0adlZaYbziGa0WoOw17IVPFCkJ4YrIKLrCYAEUdUl34n/zW6k5SNXspVfOkke+6iOMiQc6Yunvl/RsGeOEQkM+XWimH0zUwmkiqWghwPXQ3AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=D+WUqsf7; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=s4hCdMiD reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723453922; x=1754989922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iVGhNQ7r+GgMdXvKda908eL/Y5A0YBwZsNL00pSOsYY=;
  b=D+WUqsf78qQ0nPUuXA6hw6GQsuOI2WRmkEZu5XVWHnmmYjZ80dW+aOVs
   KBGd2A2nTBXKZhbTZ2xYpdNpDL2T11+N8l10YkvXSzvTVJiR4FV6B2ISQ
   QsQ1mK/rJ9JrhO4WoGKGpn9Xv86+kb/rGgVehfgBJTjYTpH+Ntm3r3hBX
   2LwasiykPDuqhBBnGcoqU5TXlaf/uUjw3IjKVkr6eahAHN8yCrAPWH0kZ
   w5RwFlhIUDImSlRq+bgEpKp4Zxd6UWqYLvUj45jIFrMvAKbAyvUP5qzpE
   Ml5pKm/3gDlkLZFDZ2gNcnn3YSh2HJk4IVTKlUu7oIRC7rXjNAT96th8L
   A==;
X-CSE-ConnectionGUID: PdjH/twxTq+pzhusnqFE3w==
X-CSE-MsgGUID: abvoOSaXTKCeZz4+6fNkHg==
X-IronPort-AV: E=Sophos;i="6.09,282,1716242400"; 
   d="scan'208";a="38357923"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2024 11:11:53 +0200
X-CheckPoint: {66B9D1D9-14-186E37A7-E5B59163}
X-MAIL-CPID: 62D091DA502B8843C2B26626E6D08F41_2
X-Control-Analysis: str=0001.0A782F1C.66B9D1D9.0176,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94E64160FD1;
	Mon, 12 Aug 2024 11:11:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723453909;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iVGhNQ7r+GgMdXvKda908eL/Y5A0YBwZsNL00pSOsYY=;
	b=s4hCdMiDs717XI3VbNv9Nf+/6xFK6FMANH3wvGCvCemENUybutJh2nG75BBSmlamBOXyGY
	l/UpvQRqa74ePjO65Prn0E5GCvm9mwu4Uyga163H9DvP/XPoJXD2FAfannSHppYIu4EtB6
	Kebeq5n/97quOq4MqpeRzfM/7OBXQ0dr76RvrrXhghYIi51b9pKr7Xaq9jkJ9x1EzcMxfs
	aZwRjBoOdNo0/z2cwUK9vm7nprLaMW9HJ50D0TkywgdApXcCzf/U8jb+j7t+Q9Jvt6jXhY
	GVVzB4K4cr6ZCAQL8JT5nQoCdPSbOVshWMxRaMRIoX8zJ8XjwcuZuAOyqhicYQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs
Date: Mon, 12 Aug 2024 11:11:51 +0200
Message-ID: <4944000.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <PAXPR04MB8459C55F49C08A6B6A0239E988852@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240808090326.425296-1-alexander.stein@ew.tq-group.com> <PAXPR04MB8459C55F49C08A6B6A0239E988852@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Montag, 12. August 2024, 10:45:54 CEST schrieb Peng Fan:
> > Subject: [PATCH 1/1] arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs
> >=20
> > imx8-ss-vpu only contained imx8qxp IRQ numbers, only mu2_m0 uses
> > the correct imx8qm IRQ number, as imx8qxp lacks this MU.
> > Fix this by providing imx8qm IRQ numbers in the main imx8-ss-vpu.dtsi
> > and override the IRQ numbers in SoC-specific imx8qxp-ss-vpu.dtsi,
> > similar to reg property for VPU core devices.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > I did not include a Fixes tag as adding support for imx8qxp and imx8qm
> > is split into several commits. It's at lease the combination of the
> > following commits:
> >=20
> > 0d9968d98467d ("arm64: dts: freescale: imx8q: add imx vpu codec
> > entries") b4efce453f0ca ("arm64: dts: imx8qm: add vpu decoder and
> > encoder")
>=20
> If you are using one patch to try to fix upper two commits, I think
> it would be better to separate the patch to fix the error of
> each upper commit and include Fixes tag.

Commit 0d9968d98467d ("arm64: dts: freescale: imx8q: add imx vpu codec
entries") is talking about imx8q. This is most probably i.MX8 family, while
I confused imx8q with imx8qxp, which is i.MX8X family...
The naming scheme is so confusing :(

=46or that reason I'll just add a Fixes for 0d9968d98467d.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



