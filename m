Return-Path: <linux-kernel+bounces-217869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B76A990B567
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639C61F20F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2A113C679;
	Mon, 17 Jun 2024 15:42:56 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD413AD0F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638976; cv=none; b=pg0dLBwVtml6uds3hwVOW9FwAvAFovIhfI5JuLCuEjV7yNWEwoV4Z4WMnPxvgynzAd/4zpnk4EQ1iontbj6brebf7bMwAQQJguP+fDwcU2Jv2aW9g6P9bnWzBqHAnNbWUj+sWk8OJhU6LrRNuIeR2VVh616GellHtYyvlNcf/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638976; c=relaxed/simple;
	bh=wVv1rO0oa91kUVdn0i+wSRBoO8oJaEWPjSnCObnPxjc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RRaRBay55YV2wzNLOlV23oO38/lnmnt9Wx3t3GW7td4R/KfAEj12vLgVKSbaH+QrD2AmuNXX/3c6ZDk3V2Jpi8adzfYIIFOPUrKZuHzf8xWB1EvUuihbk32t+an4GqBDZ6sjX4RMWR2qwwUjFT9hVItvTQmaJgWQqWuobz+3Khc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6ED3A61966A6;
	Mon, 17 Jun 2024 17:42:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id CTtxrfEOwEul; Mon, 17 Jun 2024 17:42:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 16FC461966CF;
	Mon, 17 Jun 2024 17:42:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qKE-5wzepDVX; Mon, 17 Jun 2024 17:42:51 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E9C1561966A6;
	Mon, 17 Jun 2024 17:42:50 +0200 (CEST)
Date: Mon, 17 Jun 2024 17:42:50 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Gagan Sidhu <broly@mac.com>
Cc: ZhaoLong Wang <wangzhaolong1@huawei.com>, 
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	dpervushin <dpervushin@embeddedalley.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	yangerkun <yangerkun@huawei.com>, yi zhang <yi.zhang@huawei.com>
Message-ID: <561660214.251562.1718638970757.JavaMail.zimbra@nod.at>
In-Reply-To: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com>
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: gluebi: Fix NULL pointer dereference caused by ftl notifier
Thread-Index: 4cwvQidh1qjlS/CdlD07cpKCQzRcAw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Gagan Sidhu" <broly@mac.com>
> typically what happens is we will wrap a squashfs filesystem inside a UBI=
 layer.
> openwrt people call this =E2=80=9Cubinising=E2=80=9D the root filesystem.
>=20
> then, after we label the appropriate nand partitions as =E2=80=98uimage,f=
w=E2=80=99 to call the
> right mtdsplit, the mtd_ubi subsystem works its magic automatically, as l=
ong as
> the root partition is named =E2=80=9Crootfs=E2=80=9D.
>=20
> at that point, the rootfs will be *AUTOMATICALLY* mounted AND booted from=
 BY THE
> KERNEL. that is, no cmdline hacks are required.
>=20
> this patch breaks that behaviour since mr wang=E2=80=99s additional condi=
tions result in
> the failure of the partition to get added to the mtd list, and thus fails
> mount.
>=20

Please help me understanding the layering.
So, you have sqaushfs inside an UBI volume and create a UBI block device fr=
om that?
And you have enabled gluebi to have the said UBI volume as MTD (and thus as=
 mtdblock too)?

Thanks,
//richard

