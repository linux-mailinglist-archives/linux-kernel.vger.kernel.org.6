Return-Path: <linux-kernel+bounces-199351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD678D85E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071FE282C60
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027B12E1FF;
	Mon,  3 Jun 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T8nkxOrv"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46186E619
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427966; cv=none; b=nS8bfCHg2TG2wPZfCXkTTXIpxMj0Qx1Bn+gugtdIE1tpsy2c4Fnq7iehjsTx/Cj98iDJ18gxSWux1ReqLcPLCDnN3Rzzo5GRnt+SbtXViYJr2aWUtWaYChWl8Aq6pBfBdZzZ/sUYKwzhVhb2r8vGcvc/GmY3gGXkMijUIdcaFHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427966; c=relaxed/simple;
	bh=kS9r+gzpzHwBEzwPOWdmykoQ+ynbPJPkD5FCG6vUcck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bge1lpH0IPLFe6Um967mMtvA+1aVG7VXeD+GPbZZqCTQQDpTgdHeVwpNa/ceV53o1cxaLKtj7x3SeCPiaspsyfwnqRou181KNP4guaUnyS2Lx0wmS3/lCQtOwO6a0N4xq0hDNHwmelwWDtyFlpYM3GiUOkDrvVdn4BEoWRqbc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T8nkxOrv; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD51720004;
	Mon,  3 Jun 2024 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717427963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIRjh/1emiNXMJXAEyC8Dl3UwXUntJPIvus2EcZ/RsI=;
	b=T8nkxOrvSFYQRPivRxw7V0hHYwWXyPBmBWQl4eQzx42OG3hdiCJG9oSpbbOeTZ9fH38l6C
	PM36RGn7PVI4L/oKdq1+o7ayd44NfXZEepfhNucDduLFGMPkPdgY9oCQekYxYQYJl3qXir
	7WDMBQT0/UchmpWkAcko4PxIKG/QjNMga1K8Q3PK3Ccz2F7C42kSs/vmkWT8e367U5ILBo
	5APTnQEpcOukQjV2BliwWuDV5aqmUsN2zgUirKo1PPffTDdYIIIWfBLtXPM4Qu3EPqIGy0
	X6nBl1Mgrjldox+bbLdfRPu9cpBnv5hAPMx/rOBOaFSPKs7aiGP6ZVA3JTRJhg==
Date: Mon, 3 Jun 2024 17:19:19 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
 imx@lists.linux.dev, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i3c: master: svc: fix IBIWON not set if IBI
 follow a hot join
Message-ID: <20240603171919.02c70327@xps-13>
In-Reply-To: <20240603151527.52235-1-Frank.Li@nxp.com>
References: <20240603151527.52235-1-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

Frank.Li@nxp.com wrote on Mon,  3 Jun 2024 11:15:26 -0400:

> When an In-Band Interrupt(IBI) occurs after svc_i3c_master_do_daa_locked(=
),
> typically triggered during a Hot Join (HJ) event, the IBIWON flag fails to
> be set when issuing an auto IBI command.
>=20
> The issue stems from the omission of emitting STOP upon successful
> execution of svc_i3c_master_do_daa_locked(). Consequently, the controller
> interprets it as a repeat start when emitting the auto IBI command. Per t=
he
> I3C specification, an IBI should never occur during a repeat start, thus
> preventing the IBIWON flag from being set.
>=20
> Emit STOP regardless of the success or failure of
> svc_i3c_master_do_daa_locked() to match I3C spec requirement.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: 05b26c31a485 ("i3c: master: svc: add hot join support")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

