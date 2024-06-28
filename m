Return-Path: <linux-kernel+bounces-233356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E49091B5F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E351F239B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41C62BD1E;
	Fri, 28 Jun 2024 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OvPDBzci"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2D1876
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719551863; cv=none; b=Qcf3ZyTgGOalvbsDZYBC8yXxaX9D5p+iDtEP7KiPZZWDncqI2LaEQmi1qenYITN4PAnN1mpxOmfHmvAdZOfNiJACJ0V5Ds3+b+KkEjfXzIld0m0WkfwmdfDhN9yPKy/WXYR4k0zgNcS8lVS9wPhxmNLQtbtIuJBez0TDUSnF4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719551863; c=relaxed/simple;
	bh=Hea+fhqkoIuvvLdT4MQjrymkpMPDBOEZeogQUQwqIkk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUFS1zgZKo81Zzu7FuquDZ27FdpIoEJ7OR3iNKgc0OE/yzoryiuShdQmA6P6woJUyrNwui7Be/mbsw4/HMFV3nl1knMqmvT7QyxxkLACDWfb2Zihc+sStDEwJWOtEsqDPhJIRy3PWHOGTYZJKwpgqFtpHZOn+GNFXsx0yv11hao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OvPDBzci; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Nwv3S4yz9sSy;
	Fri, 28 Jun 2024 07:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1719551855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9WoXzkzLULCld7QZX4tVDfOoCFDD8QTCpQy/bJja8g=;
	b=OvPDBzci31szDCv+ZLShy4h+Gf8i+ehuXqnF+ZYgJLNSXnua+ACX2eTMlACrAwlivTmgcr
	HyovWrcGXOEaBiZJ/N5Zk2yFQz8z3clY8Jh3V3zDjBSfocDpCa4upvuiTEWYyi0noNp9xV
	A+yuPr/teUBK4carJaMXGFw1O5ar/HnHTpHJmjPr1/+QYvVAm48uhB4yYEyMflKyfM/bfu
	Vpgb+uIsxZckpiMGq8Ly86Ha+bcLakA+tPmK7o0wUu1M8G5I3+jCTkn/VuDz+YrR0PyJ/Z
	ZktqZiXBat+hHasNOESALpEuydG7IGSEZKAn9htrRyP26NsBGpdbAubtxlUKNQ==
From: Alexander Stein <alexander.stein@mailbox.org>
To: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 gregkh@linuxfoundation.org, umang.jain@ideasonboard.com, wahrenst@gmx.net,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bernhard =?ISO-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>
Subject:
 Re: [PATCH] staging: vchiq_debugfs: Fix build if CONFIG_DEBUG_FS is not set
Date: Fri, 28 Jun 2024 07:17:30 +0200
Message-ID: <5807549.DvuYhMxLoT@kongar>
In-Reply-To: <20240627124419.2498642-1-bero@baylibre.com>
References: <20240627124419.2498642-1-bero@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-MBO-RS-META: wcg1h9ybmy8r418qgsneaa856uy6o7ut
X-MBO-RS-ID: 997eb622df03333c934

Hi Bernhard,

Am Donnerstag, 27. Juni 2024, 14:44:19 MESZ schrieb Bernhard Rosenkr=C3=A4n=
zer:
> Commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
> vchiq_state") adds a parameter to vchiq_debugfs_init, but leaves the
> dummy implementation in the !CONFIG_DEBUG_FS case untouched, causing a
> compile time error.
>=20
> Fixes: c3552ab19aeb ("staging: vchiq_debugfs: Fix NPD in vchiq_dump_state=
")
> Signed-off-by: Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
> ---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debu=
gfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> index 1f74d0bb33bae..d5f7f61c56269 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> @@ -138,7 +138,7 @@ void vchiq_debugfs_deinit(void)
> =20
>  #else /* CONFIG_DEBUG_FS */
> =20
> -void vchiq_debugfs_init(void)
> +void vchiq_debugfs_init(struct vchiq_state *state)
>  {
>  }
> =20

How about encapsulating the code inside if (IS_ENABLED(CONFIG_DEBUG_FS)) and
remove the #ifdef CONFIG_DEBUG_FS alltogether? AFAIK this will do a
compile test even if CONFIG_DEBUG_FS is unset.

Best regards,
Alexander







