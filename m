Return-Path: <linux-kernel+bounces-332826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FBA97BF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287E9282423
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AB41C1736;
	Wed, 18 Sep 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="hbqiIht8"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA213AD1C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726678311; cv=none; b=DCDVDLFndFUZD1OZiBnpAbl4rtBWu1s5LJFWt0HUmwgh2Z0OUJFyGOMPW6ziQjuA593MOc4H2Eq4QG3Xjud9ofEUdztOsT8V+ruOtoU60yz/mxSzkHVHlk3wrgIDuV6kNZDDrc3dc974bS+nABRrzNkak94FuPeln9/ssdfx1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726678311; c=relaxed/simple;
	bh=saqdPERl3pSpSVfQHE19jiKuKxFBbOQYkvI4MJit1vw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PFfJ9GrCaMWg/8WrgIKmkTaAhHKBjUBWfCewXuVctL785DxHTebFM73pvYYNbWzOjy9LjcX4sEWVFrY01NsIZiV02vuNTmku2d10FguOMQhIe2oyPWLw9kOxJbcGTI2Ew6nnNDztw159tMVtspUXJZpzRswSKsX+ODd0TO4oaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=hbqiIht8; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726678306; x=1726937506;
	bh=fhuNG8zofIGaLi9EHs/Va7YSL8WAW0FXzVZiEsXHJZQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hbqiIht8AJucWIk1p1fluO8SehCBixY2e2XBgDT+/tLMIktn2JLJdWQn3YYxhfzWJ
	 xF81AR7An6i9zrwptIvtDeW3L23VkbM4oVPZtsYQk+eA1QSBwoPY8acPhcj/5glYOt
	 stmVnuYvMmOlixzn/JA76dLTeIzu92rI5FxlHJulXO7k73366+IrX/Lu5sMQ3V5Iae
	 06Ann1l5sb/ltq6s1Jm+48KoHxA7DmPvqrvXv6TRihvM8XUB0bZANh02Lc3/unxcJY
	 j29N+AvvTuiGYAm2j90393dtFm4nO6sv+0jIoZbrNBnvHoWJYyr7bOoGveuFBIRPZx
	 34YvgWHosFSVw==
Date: Wed, 18 Sep 2024 16:51:40 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH] staging: vt6655: rxtx.c: Fix too long lines in get_rtscts_time
Message-ID: <20240918165052.30386-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 3b2a47204c0ee62749925f8167623ebe64cbf87b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch fixes the lines exceeding 100 columns in get_rtscts_time
function.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 3705cb1e87b6..1ea17e86e3ee 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -202,20 +202,29 @@ static __le16 get_rtscts_time(struct vnt_private *pri=
v,
=20
 =09data_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, frame_le=
ngth, current_rate);
 =09if (rts_rsvtype =3D=3D 0) { /* RTSTxRrvTime_bb */
-=09=09rts_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 20, pr=
iv->byTopCCKBasicRate);
-=09=09ack_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14, pr=
iv->byTopCCKBasicRate);
+=09=09rts_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 20,
+=09=09=09=09=09     priv->byTopCCKBasicRate);
+=09=09ack_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+=09=09=09=09=09     priv->byTopCCKBasicRate);
 =09=09cts_time =3D ack_time;
 =09} else if (rts_rsvtype =3D=3D 1) { /* RTSTxRrvTime_ba, only in 2.4GHZ *=
/
-=09=09rts_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 20, pr=
iv->byTopCCKBasicRate);
-=09=09cts_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14, pr=
iv->byTopCCKBasicRate);
-=09=09ack_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14, pr=
iv->byTopOFDMBasicRate);
+=09=09rts_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 20,
+=09=09=09=09=09     priv->byTopCCKBasicRate);
+=09=09cts_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+=09=09=09=09=09     priv->byTopCCKBasicRate);
+=09=09ack_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09} else if (rts_rsvtype =3D=3D 2) { /* RTSTxRrvTime_aa */
-=09=09rts_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 20, pr=
iv->byTopOFDMBasicRate);
-=09=09ack_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14, pr=
iv->byTopOFDMBasicRate);
+=09=09rts_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 20,
+=09=09=09=09=09     priv->byTopOFDMBasicRate);
+=09=09ack_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09cts_time =3D ack_time;
 =09} else if (rts_rsvtype =3D=3D 3) { /* CTSTxRrvTime_ba, only in 2.4GHZ *=
/
-=09=09cts_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14, pr=
iv->byTopCCKBasicRate);
-=09=09ack_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14, pr=
iv->byTopOFDMBasicRate);
+=09=09cts_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+=09=09=09=09=09     priv->byTopCCKBasicRate);
+=09=09ack_time =3D bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09rrv_time =3D cts_time + ack_time + data_time + 2 * priv->uSIFS;
 =09=09return cpu_to_le16((u16)rrv_time);
 =09}
--=20
2.34.1



