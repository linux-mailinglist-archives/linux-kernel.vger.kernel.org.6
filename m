Return-Path: <linux-kernel+bounces-170847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9F8BDCE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF911F24E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF07413C8F4;
	Tue,  7 May 2024 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LXUiuorg"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395686FE07
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069029; cv=none; b=kcAoVaWZNxI+arnJDcRXzP/OG4OJbCZb6FJ145T895MjPyo+OjiF8uJeq5acBzOGF2Npw1u3tBkxycAmp+Mw1S8mBtgJev3JVpsPR229rqjwaLhTCDigukydk42EMIO59ndwC3jo35OVlQPcu5iXPhqOLTtZkqT8hecAhGIyd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069029; c=relaxed/simple;
	bh=dckxDuJXcTS8FcNV2HMCeT3R5Pxpcf+5RPhmyxTdlqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxIauO0SGY6wkDmEVFIAM4wFMYrfjGEwJzp2MXMHvcxjg7FQrWGgX0ha51z23jzkk90nXzUIwZJ/Xw5sR3FK5cH7DTtHYAkAvlBQ7TbN4gwkAGjNAQJcORgEA6SYgOO9D182MBYYrntr0DGNdrA46d6DcMN6ob7gcgbFzXREWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LXUiuorg; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77983FF811;
	Tue,  7 May 2024 08:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715069021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3stVzcSl81pEJNONxNBwP2g/IfGB0kfIKSg1nsdNyhA=;
	b=LXUiuorgxAxO5DbieuICsybsdUR95Ht6Gu8+Tx2dG5iJjSPYpqsTCk2IxU5sBridjlOADl
	lCCWm9yo8a+q+MrSiqnUc6RPBkO8AFTqObAc9npdia6HpNvlNi1ETOK1WwnnWuXtyOyfzf
	u/7xb80U6YxZa8/M0HDwBtyK0DKBrkHAORY+l6GgaKB+V6aQE9wkV+VV4NmuCBCsPMODHH
	nbg6+SBiLw9rYZMGZ3A+un9LO2BuGk5Ovt4kxRsZEU7PH7GkKgxd5AqDfw9epOvABnFx3N
	tH00XS/S94VG/PSyhxKHOQgJmLvCRffhWWstdiutPT6Z6M9/9tWGMIUcK92wsg==
Date: Tue, 7 May 2024 10:03:40 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
 imx@lists.linux.dev, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] i3c: master: svc: change ENXIO to EAGAIN when
 IBI occurs during start frame
Message-ID: <20240507100340.674f9acc@xps-13>
In-Reply-To: <20240506164009.21375-2-Frank.Li@nxp.com>
References: <20240506164009.21375-1-Frank.Li@nxp.com>
	<20240506164009.21375-2-Frank.Li@nxp.com>
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

Frank.Li@nxp.com wrote on Mon,  6 May 2024 12:40:08 -0400:

> svc_i3c_master_xfer() returns error ENXIO if an In-Band Interrupt (IBI)
> occurs when the host starts the frame.
>=20
> Change error code to EAGAIN to inform the client driver that this
> situation has occurred and to try again sometime later.
>=20
> Fixes: 5e5e3c92e748 ("i3c: master: svc: fix wrong data return when IBI ha=
ppen during start frame")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu=C3=A8l

