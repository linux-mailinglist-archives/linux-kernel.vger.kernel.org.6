Return-Path: <linux-kernel+bounces-332898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CE897C064
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 777CFB21F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159D81CA6A0;
	Wed, 18 Sep 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LCyETxq1"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B91CBEB4
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687299; cv=none; b=bCDd0ZX9/wFy1+rq+SRRQ7bNesqfMx8wsmrSLeUmphc9HLXF+Fk7ivA5M0zbYCy+VdKGwWa0s+VuNZ91FHIYmjEHH8JVdMS4NrdFVHWT1esawzX3YBCSBuBKvDYnerRaOkZrwhf0J+xu0kLQsBd5RlO5v4hit2v9rbxq/u13NqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687299; c=relaxed/simple;
	bh=c7kusT8qRHX+nEftPn+bO1QBgw9v2b6b2CJ4i6Jii7U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5BPj9AbwQDudCvsLFfm/yiMTZJwvME05NVci3kZ5v58RvBqlliK/e+tUmcug9kYHyfiBR1i1I0PtaySwA0rTEfxMH1z/J8J3X9/6ABHS3KWM7zN2b1lsLAgWQ8gd/7KuQfvK+28+0cLobL/wdYHPJrgkp47kfqqm+G9vxwTXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LCyETxq1; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687296; x=1726946496;
	bh=7Rfo9aDVrczzJfait/G4RmS96V3tBF7YgVtfQsfVKJQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LCyETxq1sLn6fxxkCuA+hAnZ2xVV01uI4pG0E97RB0otmrY55fPmeJypEeymdAmQ5
	 3+JDDRvRUt5JUbBZHLLRojwJTwu9v7+uXemDG0MFooafyPkKA8TfrnBfREQyme89Ve
	 Yg5l29WVOJ9cJyGBxqR5vP7hC856/2vwaSWG8Y/D6gYDOz8cTacIp4VuojR28IA2a9
	 K7IONBhOw3vCeWbXKBvM2r5znCfZRegLMeywrfV9LJMuQSvThu0xLN1jZuRiIdmHrh
	 8kPgMNNqQIPWzibh+9EUIdlMI9DARMs3/tuWdfS/3MrpH0xU0FtHtEFKZg7+s452JR
	 TInXmB85vRSkA==
Date: Wed, 18 Sep 2024 19:21:32 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 09/14] staging: vt6655: s_uGetDataDuration: Rename uMACfragNum parameter
Message-ID: <20240918191959.51539-10-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 3982ca58166f909126ef1aa00c449eb017967be2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames uMACfragNum to mac_frag_num in s_uGetDataDuration
function in order to avoid using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 1d0b5b8f09c2..ca92dd72cb72 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -237,17 +237,17 @@ s_uGetDataDuration(
 =09bool need_ack,
 =09unsigned int frag_idx,
 =09unsigned int last_fragment_size,
-=09unsigned int uMACfragNum,
+=09unsigned int mac_frag_num,
 =09unsigned char byFBOption
 )
 {
 =09bool bLastFrag =3D false;
 =09unsigned int uAckTime =3D 0, uNextPktTime =3D 0, len;
=20
-=09if (frag_idx =3D=3D (uMACfragNum - 1))
+=09if (frag_idx =3D=3D (mac_frag_num - 1))
 =09=09bLastFrag =3D true;
=20
-=09if (frag_idx =3D=3D (uMACfragNum - 2))
+=09if (frag_idx =3D=3D (mac_frag_num - 2))
 =09=09len =3D last_fragment_size;
 =09else
 =09=09len =3D frame_length;
@@ -260,7 +260,7 @@ s_uGetDataDuration(
 =09=09=09=09=09=09     priv->byTopCCKBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
-=09=09if ((uMACfragNum =3D=3D 1) || bLastFrag) {
+=09=09if ((mac_frag_num =3D=3D 1) || bLastFrag) {
 =09=09=09if (!need_ack)
 =09=09=09=09return 0;
 =09=09} else {
@@ -278,7 +278,7 @@ s_uGetDataDuration(
 =09=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
-=09=09if ((uMACfragNum =3D=3D 1) || bLastFrag) {
+=09=09if ((mac_frag_num =3D=3D 1) || bLastFrag) {
 =09=09=09if (!need_ack)
 =09=09=09=09return 0;
 =09=09} else {
@@ -297,7 +297,7 @@ s_uGetDataDuration(
 =09=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
-=09=09if ((uMACfragNum =3D=3D 1) || bLastFrag) {
+=09=09if ((mac_frag_num =3D=3D 1) || bLastFrag) {
 =09=09=09if (!need_ack)
 =09=09=09=09return 0;
 =09=09} else {
--=20
2.34.1



