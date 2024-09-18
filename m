Return-Path: <linux-kernel+bounces-332892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9974197C05E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438FB1F22157
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AC51CA6B1;
	Wed, 18 Sep 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="S86dD7FZ"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F641CA68D
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687273; cv=none; b=Wm21Cs2CrhNjoKNcd44TBj41HfgRHz+6oayDf6CBEmLF/enkG9b+Ii+xYuNq6hoKHi14I0X82jpb73KeWCAUFcqL+50dcqiJwNT2sd0uzRY/97Lk2VlZKupc5vu2vECX5kQM52g3nG0Iv8WbgRwSqgVS3eOv5R4Zu0GlBELK0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687273; c=relaxed/simple;
	bh=z2nMJzqE5n8kJ6yIantqQNYJkLrl44runy54J+tkJQ8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLjqYak4MGeaOwwMITFoJHZPZEjHl3lv6QZTIUyr73Fu1SE1LRWv8eAb8IZBMZJP6VR0BZW0L0dXdstjAHRMyX+r+Cz9y16d4xWr2cn8EYOdcyu5E5ekDNoulEYoVVSfoOT61yH/l4cIbtrOsK9tO1ABmQEAhzMXI2em3a260mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=S86dD7FZ; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687270; x=1726946470;
	bh=qeQbKG2HPh5rehTIUsbVkhaR6dz2tTgrlQZp1wx8Whc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=S86dD7FZUvnkshQ6rviQxyO1+/fx/J3PxDs2oK7roGVz7SozdN3fPrGdkehfpXFf6
	 qIaQu7ADdPkXBpx1kFyTdV77YtIWfMtywEL0CpN5a9yQUhNxB6D3lk27FlK2k+Vp3k
	 8jcwb5pCDSg9ZihjWi2ncKkWkvYXt1sT+8TJlPKMefXBFDfHwqNS73DBtEYGW3mUV4
	 aw5EdV46X92lHfkgXemQkpWq8WFseK1jOFAoXMLMQIjcSFIsBQobZ7tIBNTngBxXgv
	 mqWBMO89AznX8Y0QBQJLqhx5uxoRWf2MfNd2a5WfiOiA450OOKPhMGj6mdERjqYYj2
	 kDWi35jpaBpTw==
Date: Wed, 18 Sep 2024 19:21:07 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 04/14] staging: vt6655: s_uGetDataDuration: Rename byPktType parameter
Message-ID: <20240918191959.51539-5-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 514c58b49714911802dbe44763e24b85257227e8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames byPktType to pkt_type in s_uGetDataDuration function
in order to avoid using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 1747018e747a..dd228962dd77 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -232,7 +232,7 @@ s_uGetDataDuration(
 =09struct vnt_private *priv,
 =09unsigned char dur_type,
 =09unsigned int frame_length,
-=09unsigned char byPktType,
+=09unsigned char pkt_type,
 =09unsigned short wRate,
 =09bool bNeedAck,
 =09unsigned int uFragIdx,
@@ -256,7 +256,7 @@ s_uGetDataDuration(
 =09case DATADUR_B:    /* DATADUR_B */
 =09=09if (bNeedAck) {
 =09=09=09uAckTime =3D bb_get_frame_time(priv->preamble_type,
-=09=09=09=09=09=09     byPktType, 14,
+=09=09=09=09=09=09     pkt_type, 14,
 =09=09=09=09=09=09     priv->byTopCCKBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
@@ -265,7 +265,7 @@ s_uGetDataDuration(
 =09=09=09=09return 0;
 =09=09} else {
 =09=09=09/* First Frag or Mid Frag */
-=09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, byPktType,
+=09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, pkt_type,
 =09=09=09=09=09=09       len, wRate, bNeedAck);
 =09=09}
=20
@@ -274,7 +274,7 @@ s_uGetDataDuration(
 =09case DATADUR_A:    /* DATADUR_A */
 =09=09if (bNeedAck) {
 =09=09=09uAckTime =3D bb_get_frame_time(priv->preamble_type,
-=09=09=09=09=09=09     byPktType, 14,
+=09=09=09=09=09=09     pkt_type, 14,
 =09=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
@@ -283,7 +283,7 @@ s_uGetDataDuration(
 =09=09=09=09return 0;
 =09=09} else {
 =09=09=09/* First Frag or Mid Frag */
-=09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, byPktType,
+=09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, pkt_type,
 =09=09=09=09=09=09       len, wRate, bNeedAck);
 =09=09}
=20
@@ -293,7 +293,7 @@ s_uGetDataDuration(
 =09case DATADUR_A_F1:    /* DATADUR_A_F1 */
 =09=09if (bNeedAck) {
 =09=09=09uAckTime =3D bb_get_frame_time(priv->preamble_type,
-=09=09=09=09=09=09     byPktType, 14,
+=09=09=09=09=09=09     pkt_type, 14,
 =09=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
@@ -314,7 +314,7 @@ s_uGetDataDuration(
 =09=09=09else
 =09=09=09=09wRate =3D fb_opt1[FB_RATE0][wRate];
=20
-=09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, byPktType,
+=09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, pkt_type,
 =09=09=09=09=09=09       len, wRate, bNeedAck);
 =09=09}
=20
--=20
2.34.1



