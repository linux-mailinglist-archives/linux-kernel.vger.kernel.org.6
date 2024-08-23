Return-Path: <linux-kernel+bounces-299314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62A95D2E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A652B2A9EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9167193090;
	Fri, 23 Aug 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NK6v0whU"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87EF18BC12
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429566; cv=none; b=XWu8EzSzfqjt7dqnv+C70Eh+hsMpriQ+2K33qHzUrxIfcTSkURKGXYpqyaKsa9rqiYfQGKpdMJAhIdXPjLKVNqkSAhuvFDiGwpR/2wTSmuuAqVEytTRl8uzn9dFXFgZje3/WCKh2/HmcBb1Wtpbzdxyexg8UjCS9trcXTR8koMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429566; c=relaxed/simple;
	bh=NhdWO0uvAR1i83JYVw0dYMM1ur+tGdKczLxU1iyaus8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWuDCJQ01bWCBTAn+wxuq7+PD0usHmlGqwix7ODU56W5vzx1h+L4deUtFzoN2jJH4Pg4vMTZVfmX9WgGhfjnIZa9/u3CfpuOqVc1g4/xQp/uVafDTFUui1qckztg6WBeqNiW7SP88eqLmO5OBn/uo4jaJtNFt/iS3GtlbrRJ7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NK6v0whU; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3ACAD20002;
	Fri, 23 Aug 2024 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724429562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDjhAQo3WCpUKDsGB4htnl2osRW4XTn8+QqEKONfNs4=;
	b=NK6v0whUOddYl9xAAfEd3KnwdBOmT3vPekcBvzUKHznswzXbAr2AOi6v6pk2AxfOiFDn0V
	KHCAFKHqy/ljW11gjMQIzNhcv7OEbBJnaV32gwYkv+YrXftNkQMG7RCsDhbn+FNm8l3H/I
	oO+UNb5Si+srY/9NgWkfHLeW1IfQc3wiwygCWaYUXR/+ZagqoT6fALWhp4NofRvnFtmcop
	yXCxP7n/EieK7KkkRZPY8RRl5oyA1AT0XRSj1eL94XeDWHyG2zxeQPRAMCwHTT4JixxndM
	7r8WoL/Blk4sXCbJYF5EgvokVss31dy5eVbVgN1bzl08cyqmS7ec4l38MO4/eA==
Date: Fri, 23 Aug 2024 18:12:41 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Parshuram Thombare <pthombar@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris Brezillon
 <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Conor Culhane
 <conor.culhane@silvaco.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 08/11] i3c: master: svc: need check IBIWON for
 dynamtica address assign
Message-ID: <20240823181241.37c399d9@xps-13>
In-Reply-To: <20240819-i3c_fix-v3-8-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-8-7d69f7b0a05e@nxp.com>
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

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 19 Aug 2024 12:02:02 -0400:

> When sending REQUEST_PROC_DAA, emit START and address 7E. Address
> arbitration may occur at this time if other devices trigger HJ, IBI, or
> CR events.
>=20
> When IBIWON happen at REQUEST_PROC_DAA, nack IBI request then use repeat

		   during a		NACK the	     send a

repeated start

> start to continue current dynamtica address assign.

                             ?
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Thanks,
Miqu=C3=A8l

