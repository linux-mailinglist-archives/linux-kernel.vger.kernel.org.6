Return-Path: <linux-kernel+bounces-332901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7605197C067
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1600F2831FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28841CC14D;
	Wed, 18 Sep 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Y1vW3z/x"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8DF1CA6BB
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687319; cv=none; b=oCwLa/9BxofWuOtLkmc1ic5OtNDN5qSY1T1SnKdyhTfn3/6g5nx+6HsWWTzr/Y6ZGSNvU9ueeiOJe2Ue78DlldGI95Sp0zhJpBnD9VfLRXtmYn9plhoRXowC4t5KABC+A4Jl1nE00GWf5UzbGn+t2muDCxs0itnBbM++ioq2Tnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687319; c=relaxed/simple;
	bh=fuaKvqkqWwqKbWlbfPmd5BGEos3ZTs9JotBiXBOthYA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDgvRTPspV5qJ/bwi9B0AaZBNFe9BACb3+KPwFYN4snYc+uSxLsLZyqmvnYgk0Ph4wqHQVva6zSTh9Nb/ki4xg5VMhxnsYYo9b6rIa8x27rxxvvzSro2dtr8IGJaAfae+ZPbpTf6NCz+2QiTJZRNfHYUEno/V96oetX5qpDWdNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Y1vW3z/x; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687315; x=1726946515;
	bh=sfltv+vZ9IM5vljZnKyjZ5FCcX3z51Rc/RZAKPMaCHc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Y1vW3z/x8sVoEddREsq9iK4RwgWm4WC/Nn+OS4wT7Hlt9CiT5Fwqc58W9oWzs6aS0
	 i0MBn8R30kByJB7CJO2Pc9hmtxWyqwSUkV6S7SlOcvKq5rffG9zQQlW2eYxIoAXzAt
	 ysn1Ev3GGG3RQZ9K5M87v8x5/EUm0ymqaVJQfTHT4OQkGYvaryMRWSJNXMNxdAg/aL
	 aRl01Sng95puW3mmPHaNwLbck8L3xUdd7w8DvCdUqjp1Pm8w5tfvyos9j7EZG9Jiou
	 6leNWh6GRw+cIzjzEXP7gdO3JCTr8B8aJ3WS3klSlhmhHkPN/KOUVpgvr/VW/hr1b0
	 K6DDI5V+A2K8g==
Date: Wed, 18 Sep 2024 19:21:51 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 12/14] staging: vt6655: s_uGetDataDuration: Rename uAckTime variable
Message-ID: <20240918191959.51539-13-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: f4eac2a3721997fbe84b1cdb2b66fd6567adaf11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames uAckTime to ack_time in s_uGetDataDuration function
in order to avoid using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 4b0a768cf77b..8f28fd1465d4 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -242,7 +242,7 @@ s_uGetDataDuration(
 )
 {
 =09bool last_frag =3D false;
-=09unsigned int uAckTime =3D 0, uNextPktTime =3D 0, len;
+=09unsigned int ack_time =3D 0, uNextPktTime =3D 0, len;
=20
 =09if (frag_idx =3D=3D (mac_frag_num - 1))
 =09=09last_frag =3D true;
@@ -255,7 +255,7 @@ s_uGetDataDuration(
 =09switch (dur_type) {
 =09case DATADUR_B:    /* DATADUR_B */
 =09=09if (need_ack) {
-=09=09=09uAckTime =3D bb_get_frame_time(priv->preamble_type,
+=09=09=09ack_time =3D bb_get_frame_time(priv->preamble_type,
 =09=09=09=09=09=09     pkt_type, 14,
 =09=09=09=09=09=09     priv->byTopCCKBasicRate);
 =09=09}
@@ -269,11 +269,11 @@ s_uGetDataDuration(
 =09=09=09=09=09=09       len, rate, need_ack);
 =09=09}
=20
-=09=09return priv->uSIFS + uAckTime + uNextPktTime;
+=09=09return priv->uSIFS + ack_time + uNextPktTime;
=20
 =09case DATADUR_A:    /* DATADUR_A */
 =09=09if (need_ack) {
-=09=09=09uAckTime =3D bb_get_frame_time(priv->preamble_type,
+=09=09=09ack_time =3D bb_get_frame_time(priv->preamble_type,
 =09=09=09=09=09=09     pkt_type, 14,
 =09=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09}
@@ -287,12 +287,12 @@ s_uGetDataDuration(
 =09=09=09=09=09=09       len, rate, need_ack);
 =09=09}
=20
-=09=09return priv->uSIFS + uAckTime + uNextPktTime;
+=09=09return priv->uSIFS + ack_time + uNextPktTime;
=20
 =09case DATADUR_A_F0:    /* DATADUR_A_F0 */
 =09case DATADUR_A_F1:    /* DATADUR_A_F1 */
 =09=09if (need_ack) {
-=09=09=09uAckTime =3D bb_get_frame_time(priv->preamble_type,
+=09=09=09ack_time =3D bb_get_frame_time(priv->preamble_type,
 =09=09=09=09=09=09     pkt_type, 14,
 =09=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09}
@@ -318,7 +318,7 @@ s_uGetDataDuration(
 =09=09=09=09=09=09       len, rate, need_ack);
 =09=09}
=20
-=09=09return priv->uSIFS + uAckTime + uNextPktTime;
+=09=09return priv->uSIFS + ack_time + uNextPktTime;
=20
 =09default:
 =09=09break;
--=20
2.34.1



