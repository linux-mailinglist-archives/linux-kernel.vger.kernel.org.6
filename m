Return-Path: <linux-kernel+bounces-332893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06EF97C05F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028E61C20B67
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552301CA6B8;
	Wed, 18 Sep 2024 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ZsuUDRwv"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0431CA6B6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687276; cv=none; b=L8yz3OeQG3F/+eliN/46jVcUu/0XbXB2wWuoWq7ERcChyikNO4zlsZZF46Oix0rATPphxOl8xODLvFahw55AsQemdiqnfor0nvYR8/lMKyLMWmakKRTjIBIeDU8CDKcPtPu/QdeIw9nqzQrF5OMI8A5oaq2LMZV3q/z1pBAGg/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687276; c=relaxed/simple;
	bh=2Dxavvxr5+ncqT15+4pRoatg/np2Ek4Qc8vHc3juzO8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSUTsIq97ib6Psq2OBuCXuT6LegKAjTnlpPiBOeLEqISzZWwTETCiuGrhNuiUX2TxtgRrRn0SMO4maHNEORdPJLCh9iZvDr+TJJfntRrsq6fSdSjUd6yHEEmGr74VFrOncmY5uh+wB/IaLv8Ao51z597ntGoL0+lEZx+gpKtzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ZsuUDRwv; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687267; x=1726946467;
	bh=X3N0GMPfcosg7WiMChayJ0RW/yEtBAZL9uGRXzt6OnQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZsuUDRwv1/TTM7nvEz3UQ2Q5t6hY760vtFdZ2r5QdRaWdbpoDy8mXjiczXUaLiNYM
	 KBFv4U0KTnVmnHGi2Zdnq7hoc1VtWp2fJEsiN9F1IXhp52WGkDbOzYr/sbmCW2LQQ3
	 V9pu4V/Vdd2ywAb2oCzNLa7y9Y76yLji1xI3a7K6LrMd1TUXyNMrIliZ6wsEX0SuYp
	 d2Qqz0fUgVqR7Vf9MB7OwKKYD/W/VKhq7bTSlZWZ6JDXVOD3IwZSXQ2Q9++SspjJCB
	 PcNHz9iVegi2w6L1p+kx6XsBn51XEp0lUpRy45bwBZHyDTL+hAYbJ9BUWkiZMmosAD
	 EC3I2wmpOdadw==
Date: Wed, 18 Sep 2024 19:21:03 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 03/14] staging: vt6655: s_uGetDataDuration: Rename cbFrameLength parameter
Message-ID: <20240918191959.51539-4-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 50c0c3d2e8a1ac7262012103bce268fc02819bfa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames cbFrameLength to frame_length in s_uGetDataDuration
function in order to avoid using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 239fa4a1af66..1747018e747a 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -231,7 +231,7 @@ unsigned int
 s_uGetDataDuration(
 =09struct vnt_private *priv,
 =09unsigned char dur_type,
-=09unsigned int cbFrameLength,
+=09unsigned int frame_length,
 =09unsigned char byPktType,
 =09unsigned short wRate,
 =09bool bNeedAck,
@@ -250,7 +250,7 @@ s_uGetDataDuration(
 =09if (uFragIdx =3D=3D (uMACfragNum - 2))
 =09=09len =3D cbLastFragmentSize;
 =09else
-=09=09len =3D cbFrameLength;
+=09=09len =3D frame_length;
=20
 =09switch (dur_type) {
 =09case DATADUR_B:    /* DATADUR_B */
--=20
2.34.1



