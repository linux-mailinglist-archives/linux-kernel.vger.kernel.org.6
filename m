Return-Path: <linux-kernel+bounces-332902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB44D97C068
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC2A1C21387
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A21CC157;
	Wed, 18 Sep 2024 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="b/ciog9a"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796D1CC162
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687324; cv=none; b=H93IhcSKethxcyP+55rSxMxMKw2jtsvIQQPPACGRnXRkD9ZOulfDct4nkfroBlh5Zxg0cIaIp38B1SKcKDGK3dPxX5iZtxucVJBTp72faV/pFUnIBNBq18V3TcMC0A2XIR1k0vnTLbgxKP/lwTEkxRtFdczhQmwK0sua03dUxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687324; c=relaxed/simple;
	bh=BtZO/Dn9OOU/+FesLiovjQkEUe2uRE46lW/xdGr68mg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUFlUe+wmQ0wFv9sJUt2xPO2mauOYiR2+WrmiYl6YFzp5B/hcS4wNt4VD9sT5FdzqrOvG6FD8gxasRn0a3odYf8Dg+8ns3IvbGw6s5Wak5Tgp87fRy908lEiAgEzTgAfApORedWWFtIAinrMtM7tvAsxqcc1b1/zSuShE7Ynqb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=b/ciog9a; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687319; x=1726946519;
	bh=B2INdXcYa4ziBQUCJlCJHSGTOSgy7OTqjYfv7rPmVXs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b/ciog9aTpAv6FgNByhDWWfiuC3d6bxp9s0S3rCFrmyAlezWGiPkYHsEDC75L0AS1
	 Me+dgeFtTm8I9a/xvMDrx0BgM0R5Nj8UcvmRNWp3COf9ij3iJJMD6rDwNacPC9etOT
	 gUNKL4bGunyv5HIRGyhdA+tukpPPtQf/UQvEtJFybu4GOPt/my01lz8Dbj/knv31c6
	 m0uWG8uBZAmlNbenDbbWcyfrOetH1uueB2qp6FdIetDQJS9+Fd9ZAnQnVco/MyVpSO
	 9HFmxn/ukNdXgJ+xvcacTT7CqMNbpWAXvKaJgwRXswdUWyPjXg5RY5a7eIi2EKG8gG
	 5o3GLEwLQPh4w==
Date: Wed, 18 Sep 2024 19:21:56 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 13/14] staging: vt6655: s_uGetDataDuration: Rename uNextPktTime variable
Message-ID: <20240918191959.51539-14-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 340005476fa96df63754fd91b23346e05b4c8091
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames uNextPktTime to next_pkt_time in s_uGetDataDuration
function in order to avoid using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 8f28fd1465d4..5e93ca38008e 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -242,7 +242,7 @@ s_uGetDataDuration(
 )
 {
 =09bool last_frag =3D false;
-=09unsigned int ack_time =3D 0, uNextPktTime =3D 0, len;
+=09unsigned int ack_time =3D 0, next_pkt_time =3D 0, len;
=20
 =09if (frag_idx =3D=3D (mac_frag_num - 1))
 =09=09last_frag =3D true;
@@ -265,11 +265,11 @@ s_uGetDataDuration(
 =09=09=09=09return 0;
 =09=09} else {
 =09=09=09/* First Frag or Mid Frag */
-=09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, pkt_type,
-=09=09=09=09=09=09       len, rate, need_ack);
+=09=09=09next_pkt_time =3D s_uGetTxRsvTime(priv, pkt_type,
+=09=09=09=09=09=09=09len, rate, need_ack);
 =09=09}
=20
-=09=09return priv->uSIFS + ack_time + uNextPktTime;
+=09=09return priv->uSIFS + ack_time + next_pkt_time;
=20
 =09case DATADUR_A:    /* DATADUR_A */
 =09=09if (need_ack) {
@@ -283,11 +283,11 @@ s_uGetDataDuration(
 =09=09=09=09return 0;
 =09=09} else {
 =09=09=09/* First Frag or Mid Frag */
-=09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, pkt_type,
-=09=09=09=09=09=09       len, rate, need_ack);
+=09=09=09next_pkt_time =3D s_uGetTxRsvTime(priv, pkt_type,
+=09=09=09=09=09=09=09len, rate, need_ack);
 =09=09}
=20
-=09=09return priv->uSIFS + ack_time + uNextPktTime;
+=09=09return priv->uSIFS + ack_time + next_pkt_time;
=20
 =09case DATADUR_A_F0:    /* DATADUR_A_F0 */
 =09case DATADUR_A_F1:    /* DATADUR_A_F1 */
@@ -314,11 +314,11 @@ s_uGetDataDuration(
 =09=09=09else
 =09=09=09=09rate =3D fb_opt1[FB_RATE0][rate];
=20
-=09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, pkt_type,
-=09=09=09=09=09=09       len, rate, need_ack);
+=09=09=09next_pkt_time =3D s_uGetTxRsvTime(priv, pkt_type,
+=09=09=09=09=09=09=09len, rate, need_ack);
 =09=09}
=20
-=09=09return priv->uSIFS + ack_time + uNextPktTime;
+=09=09return priv->uSIFS + ack_time + next_pkt_time;
=20
 =09default:
 =09=09break;
--=20
2.34.1



