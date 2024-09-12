Return-Path: <linux-kernel+bounces-326058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C98A9761FB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85741B21DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4732718BC34;
	Thu, 12 Sep 2024 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nXY6lTCE"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B6282FB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124240; cv=none; b=Wurqa0DotIRGqTt4PmfkSikqBPUe3HugM206mZp5OfaEIqs1zGvQtID8VSwT23N04pJabi99iL+oTRQ3U4Fn+UQy2jb5LIH7vxvVd+nVP/5lIOBpMNaf7uYkzEBN7LJyKxB2qTLP6aOu5aEGKWMd78iibDwbr/cY+G3LXVgHaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124240; c=relaxed/simple;
	bh=xu0tVvafbFWOUf8uO2BKEzOIYwzDjbJ10BTG9g2S/TI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDwV+mrYxiL5Z5l8pz8mBqXaMpsXjyfVamQA0lz5TCQDH8wiXJdZF5TPwuklU9YohHBxv2xjtvAvNQnjWpGa3j+SgvD8faUPxZLbEHVGSzTXe+Q+r8S5AcsszI7tSK4GscoBHwcWnZEj9VA2lBXuNOyNdEfuux5w9us2BhpEWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nXY6lTCE; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42AB2FF808;
	Thu, 12 Sep 2024 06:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726124234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dx873EE+Zbpqb0LcknS8snbosCHYhAZ1Drfd3qd+3Eg=;
	b=nXY6lTCE1pE7tr2Ao3SJXwpv2lPcyrrxWzySsdX6D/Ye08rctvCMGfZ/61hTkiQBn4t4pV
	6bC8Yc/4juV61DxTQahuu/WOsYIXm+A/hZJTsvye6fKvWmRw2RmYRdTuvsip1k4qkLNIA+
	sTYnmIX7nGyRoBDwtpcHpf7NB5J9kNMHaG93iOXoYFpjHfxE+H+N8B2fSHb6JvPuiAdmML
	AzAgAACWXtPnCxgWD79/Q6plw2x26FOklUyMpuY+O7bcDJjbzIov9KWW8GAoAquqlM8YtL
	eZ1F1yqeAylfUwQK30amHsCut9lPanOomOoY0To4OVLEB+zsWCApjocmQ3FbEA==
Date: Thu, 12 Sep 2024 08:57:09 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>, 21210240012@m.fudan.edu.cn,
 21302010073@m.fudan.edu.cn, conor.culhane@silvaco.com,
 alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: Fix use after free vulnerability in
 svc_i3c_master Driver Due to Race Condition
Message-ID: <20240912085709.6ec0a289@xps-13>
In-Reply-To: <ZuG2SbsHEU5BU9mX@lizhi-Precision-Tower-5810>
References: <20240911150135.839946-1-kxwang23@m.fudan.edu.cn>
	<ZuG2SbsHEU5BU9mX@lizhi-Precision-Tower-5810>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

Frank.li@nxp.com wrote on Wed, 11 Sep 2024 11:24:57 -0400:

> On Wed, Sep 11, 2024 at 11:01:35PM +0800, Kaixin Wang wrote:
> > In the svc_i3c_master_probe function, &master->hj_work is bound with
> > svc_i3c_master_hj_work, &master->ibi_work is bound with
> > svc_i3c_master_ibi_work. And svc_i3c_master_ibi_work =C2=A0can start the
> > hj_work, svc_i3c_master_irq_handler can start the ibi_work.
> >
> > If we remove the module which will call svc_i3c_master_remove to
> > make cleanup, it will free master->base through i3c_master_unregister
> > while the work mentioned above will be used. The sequence of operations
> > that may lead to a UAF bug is as follows:
> >
> > CPU0                                         CPU1
> >
> >                                     | svc_i3c_master_hj_work
> > svc_i3c_master_remove               |
> > i3c_master_unregister(&master->base)|
> > device_unregister(&master->dev)     |
> > device_release                      |
> > //free master->base                 |
> >                                     | i3c_master_do_daa(&master->base)
> >                                     | //use master->base
> >
> > Fix it by ensuring that the work is canceled before proceeding with the
> > cleanup in svc_i3c_master_remove.
> >
> > Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
> > --- =20
>=20
> Please add fixes tag and cc stable.

Yes indeed. Otherwise looks good to me once this fixed.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

