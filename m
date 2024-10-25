Return-Path: <linux-kernel+bounces-381163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B602C9AFB74
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB0283ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CB41B85EC;
	Fri, 25 Oct 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VmxWyjqq"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F135318D64C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842520; cv=none; b=Ym+xszvYqefqekdQTAzttHTnYalNXdgr35ZXf6LRmHMuZDmQ8tcWe70DzhE+seCe8bIlMSS8Sya5SY1x+Z8ZIj+WYF7LmpesulD95gUf+LkUCVIuEwXpxrgB/cYhYAyrMipKy6Qr5aaap4uIpG8HMzzT2RcZB0rLiCQ/M2WQVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842520; c=relaxed/simple;
	bh=uxW9tCKkc895I3RZcBJ8ekW+g3mFs3PukiRhJv7f9HI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwBYWga5x5lFBO3xmw6Y084R/KLRrm9e1zTAKvduhy8xc9ipxMcbLiaKAi8n2R+N7WO+PwXWFXULAdd20LIt58G2Hh32VyOiWaqEuJfZCbYBPuaSIlCwWV/NfUMb7/rVupZIDPt8MCgTW2WhzmT9A+5B9yPBTP8U69dYWki0aOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VmxWyjqq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C70EE000E;
	Fri, 25 Oct 2024 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729842509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAG+QMDqLiDHqQLqGLWIReQrBYnJu8pHDQ37wRmTSD8=;
	b=VmxWyjqqZd9zicLKRBQDCQe2zDPTgl/CUce9nDNZvlVptE+lMZS8X7p75W8z74k3X3gCGi
	3MhJ90CZxbxFFrSyx9V5pXREQs99eftLDCKxJAFA/da2RIrRM5+GI743mXxM5slw5W5cEv
	vUbOPZb6BbuNxQvy8/2af7hxw3ERs3WjaLziz+fO3IZzC9ns5HIYB0WIuz+ECtOUFrAHrq
	+5t2lgjN/eb75jzW+pp1DwS3kp7gsOYJQ1e7W/j4Htamta03MuXG/dAo6prR/BWKGWYxY8
	zBca7LF6jQ5mJrUG2JkpPWtueaIhp03bAMKKN7tQjXwdnBcgKP5sz7ty7flRLw==
Date: Fri, 25 Oct 2024 09:48:25 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Michael Walle" <michael@walle.cc>, Mark Brown <broonie@kernel.org>,
 Chia-Lin Kao <acelan.kao@canonical.com>, Md Sadre Alam
 <quic_mdalam@quicinc.com>, "Ezra Buehler"
 <ezra.buehler@husqvarnagroup.com>, Sridharan S N <quic_sridsn@quicinc.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Alexey Romanov
 <avromanov@salutedevices.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v2 2/5] mtd: spinand: add OTP support
Message-ID: <20241025094825.767c84c7@xps-13>
In-Reply-To: <4ddd0588-0ff5-4c31-94b0-c9f0e453d98f@salutedevices.com>
References: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
	<20240827174920.316756-3-mmkurbanov@salutedevices.com>
	<20241001111225.36cb9701@xps-13>
	<4ddd0588-0ff5-4c31-94b0-c9f0e453d98f@salutedevices.com>
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

Hi Martin,

Sorry for the slow feedback.

> >> +/**
> >> + * spinand_set_mtd_otp_ops() - Set up OTP methods
> >> + * @spinand: the spinand device
> >> + *
> >> + * Set up OTP methods.
> >> + */
> >> +void spinand_set_mtd_otp_ops(struct spinand_device *spinand)
> >> +{
> >> +	struct mtd_info *mtd =3D spinand_to_mtd(spinand);
> >> +
> >> +	if (!spinand->otp->ops) =20
> >=20
> > Could we use something else as check? It feels odd to check for otp ops
> > and then just ignore the fact that they are here. Maybe check npages or
> > otp_size() ? =20
>=20
> A developer may not specify OTP callbacks:
> SPINAND_OTP_INFO(otp_pages, NULL /* OTP ops */)

Is this really a valid situation?

In set_mtd_otp_ops() you set spinand functions only if there are otp
operations. First, is it relevant to consider the fact that a device
would have an otp and not provide operations? Otherwise, my initial
comment was about the fact that the check seems uncorrelated with the
second part of the function.

Maybe setting these functions only if relevant is the best choice, so
you no longer have to make the checks after the init.

	if (ops && ops->erase)
		mtd->_otp_erase =3D spinand_otp_erase;
	...

?

Thanks,
Miqu=C3=A8l

