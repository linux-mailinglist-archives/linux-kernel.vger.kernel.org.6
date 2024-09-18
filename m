Return-Path: <linux-kernel+bounces-332900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC697C066
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3BD1C212A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED921CA6B7;
	Wed, 18 Sep 2024 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="muxobcGo"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A401CB503
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687313; cv=none; b=oyoQXP66izeKHjdWAqfV248EXY7RpEurTHoQ+P3ws8WqBAnBhcBwS+VF5+aKp7hE+5cYNl6Ax0aj+AZemQReL4jAeiCywKkxqPx42SltxlVBGo09k6GxlOTjJYwUFj9bboKbDdhLvUel1fTwWcKOyEr/Kkt3p99q8zluKuytbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687313; c=relaxed/simple;
	bh=NlYdSX0ZLHGzHMCiEyfUrhQGEJFpeAvzAIAlUdb+q6Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqZg+NDTFUBozLH66EspanmdVSqhIAKmZGJGhqUi0g/neI9qWs52VvZvlHL4XHj1CtERVP08cvFADaO8n599QtQfZXRTUdc5muXyHcIPsZrC6j/5wP40wQ7I5BfAYgNp9fqzJbGbhg0gFNCUxfO9Jd3/hStXDzrUUDNWdVRL2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=muxobcGo; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687310; x=1726946510;
	bh=HegoWXI8OKwexilR7FQ1pUEBHBJNMHHtpkObBeTwxDQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=muxobcGo74bAt4GU6vH6wc8Eik7F2P9a18LyYpx5NJzzpQQZSbOHWgSRfd5K7LP0l
	 0Gbilu7+OQYynbnVpGpWGD27414uUGFlIvNs68UangVrYCbPMgSLNyzTW/cpg8Hs14
	 Mkugb7+kt6iO/4rLv8ItPKIH+XhzHbo4FEJWx/d8d6wQDreTUnTizR/SlEChAhf6v1
	 tMGfRGv/qUdXilrW1aiGkZL36hKkbbIpZunYpwXgx8tdtUprVKn0eikcyU4fKhONWA
	 LEQRQjuhnaxWsZ8pUnAZcoxzSDgpoBs/u8TXkzXrGEsu/aT7+ZnwVq57su8kqYg9pX
	 r1qwRpsaLDQYQ==
Date: Wed, 18 Sep 2024 19:21:44 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 11/14] staging: vt6655: s_uGetDataDuration: Rename bLastFrag variable
Message-ID: <20240918191959.51539-12-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: ff8944be3be853cbaa6c69a38186ab4ba472b9eb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames bLastFrag to last_frag in s_uGetDataDuration function
in order to avoid using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 58446eba82cc..4b0a768cf77b 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -241,11 +241,11 @@ s_uGetDataDuration(
 =09unsigned char fb_option
 )
 {
-=09bool bLastFrag =3D false;
+=09bool last_frag =3D false;
 =09unsigned int uAckTime =3D 0, uNextPktTime =3D 0, len;
=20
 =09if (frag_idx =3D=3D (mac_frag_num - 1))
-=09=09bLastFrag =3D true;
+=09=09last_frag =3D true;
=20
 =09if (frag_idx =3D=3D (mac_frag_num - 2))
 =09=09len =3D last_fragment_size;
@@ -260,7 +260,7 @@ s_uGetDataDuration(
 =09=09=09=09=09=09     priv->byTopCCKBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
-=09=09if ((mac_frag_num =3D=3D 1) || bLastFrag) {
+=09=09if ((mac_frag_num =3D=3D 1) || last_frag) {
 =09=09=09if (!need_ack)
 =09=09=09=09return 0;
 =09=09} else {
@@ -278,7 +278,7 @@ s_uGetDataDuration(
 =09=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
-=09=09if ((mac_frag_num =3D=3D 1) || bLastFrag) {
+=09=09if ((mac_frag_num =3D=3D 1) || last_frag) {
 =09=09=09if (!need_ack)
 =09=09=09=09return 0;
 =09=09} else {
@@ -297,7 +297,7 @@ s_uGetDataDuration(
 =09=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
-=09=09if ((mac_frag_num =3D=3D 1) || bLastFrag) {
+=09=09if ((mac_frag_num =3D=3D 1) || last_frag) {
 =09=09=09if (!need_ack)
 =09=09=09=09return 0;
 =09=09} else {
--=20
2.34.1



