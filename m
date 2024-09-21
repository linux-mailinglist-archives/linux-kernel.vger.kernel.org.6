Return-Path: <linux-kernel+bounces-334836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD4497DD31
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 14:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593CFB2127B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 12:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E95171066;
	Sat, 21 Sep 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="AL6OYJse"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC99170A23
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726921343; cv=none; b=PT88IVn4SDN1bt0rDV7t2B8srgObwAPBs+JI3CL7wQSvt9wl5udWqL0ePQtcHTDdgfWCSHa4OsQG+5YC4XFJXbsd34d1G7wr9aGYSFeE9HarT4qe0SGfywKrmJjTWtQZG+8MyPmZ2WefjKX8clCTz0KoepVV68oWciEMNWa3iA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726921343; c=relaxed/simple;
	bh=hyg5WjzQy18Zf5aBihVIpxK6d+aJStU9PUKOrOa+DDg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7gwr+5Wauu+xCjyDA5Kee6ra07JYN9Q0Tn7lH8eadTNypxnNZrazUQ0goX4p7Thi04UwgxIx60Po7/zbC6pXgYnwd30nSy4jJgq39EDURLHEiuPisDDl0M2Xhoy7YDJYbaF6P/tikBHCkcXxV6jUyLz9HpwSFRy9emTiQwpb3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=AL6OYJse; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726921339; x=1727180539;
	bh=n+RqSXfT1ZbSi0Uz/8TOGX7mGgVijkivsamF/d03NDI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AL6OYJseWJr7Kwh/At7cFFQmhtS4jTJRxNY5B3awQ2HAjYbiDs9B7u+C3Ma+D2GQ9
	 m2Nrt8luBArf5xR/64pDZSXqHhEcPq4NyXMKLJbKLppGUCfgFQ1QnClZS2iJZNfy8a
	 fQy+9F+KAkzFsJUVJwgC52GTKWmJ2/URrogZW2PNfttWcj+zveGIZrM5EfpFEnxYUY
	 rTfbrLw4qV3LgHFOF9MYZCYWn6FQoqHT4S29/5iNwRcWnaqdbtFg/oZXniidbVPaQ4
	 b8NrCTlifidByXdhoVsc13xc2p7KV7J4H4GV2Anku4tpOldLcbyXBIQ80gwFH7vpNl
	 DY+v489BOAtPA==
Date: Sat, 21 Sep 2024 12:22:15 +0000
To: gregkh@linuxfoundation.org, tdavies@darkphysics.net, philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 1/2] staging: rtl8192e: Use MSR_LINK_* macros
Message-ID: <20240921122113.30009-2-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240921122113.30009-1-dominik.karol.piatkowski@protonmail.com>
References: <20240921122113.30009-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 52c9a2bd2778e6faf37c62597b2fe10b019e26be
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

There were two seemingly not used macros defined in r8192E_hw.h:
MSR_LINK_ADHOC and MSR_LINK_MASTER.

There is one function explicitly updating MSR (Media Status Register):
_rtl92e_update_msr - only MSR_LINK_MASK and MSR_LINK_MANAGED are used
there. However, in rtl92e_set_reg, inside HW_VAR_MEDIA_STATUS section,
MSR is also updated - covering more than MSR_LINK_MANAGED case.

This patch makes use of appropriate MSR_LINK_* macros in rtl92e_set_reg
and removes duplicated MSR_* macros.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 10 +++++-----
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h  |  6 +-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/stagi=
ng/rtl8192e/rtl8192e/r8192E_dev.c
index 2672b1ddf88e..675e0e263697 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -54,23 +54,23 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable=
, u8 *val)
 =09=09enum rt_op_mode op_mode =3D *((enum rt_op_mode *)(val));
 =09=09u8 btMsr =3D rtl92e_readb(dev, MSR);
=20
-=09=09btMsr &=3D 0xfc;
+=09=09btMsr &=3D ~MSR_LINK_MASK;
=20
 =09=09switch (op_mode) {
 =09=09case RT_OP_MODE_INFRASTRUCTURE:
-=09=09=09btMsr |=3D MSR_INFRA;
+=09=09=09btMsr |=3D MSR_LINK_MANAGED;
 =09=09=09break;
=20
 =09=09case RT_OP_MODE_IBSS:
-=09=09=09btMsr |=3D MSR_ADHOC;
+=09=09=09btMsr |=3D MSR_LINK_ADHOC;
 =09=09=09break;
=20
 =09=09case RT_OP_MODE_AP:
-=09=09=09btMsr |=3D MSR_AP;
+=09=09=09btMsr |=3D MSR_LINK_MASTER;
 =09=09=09break;
=20
 =09=09default:
-=09=09=09btMsr |=3D MSR_NOLINK;
+=09=09=09btMsr |=3D MSR_LINK_NONE;
 =09=09=09break;
 =09=09}
=20
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/stagin=
g/rtl8192e/rtl8192e/r8192E_hw.h
index e507593b939c..743c15da84c8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -166,11 +166,7 @@ enum _RTL8192PCI_HW {
 #define MSR_LINK_MANAGED   2
 #define MSR_LINK_ADHOC     1
 #define MSR_LINK_MASTER    3
-
-#define=09MSR_NOLINK=09=09=09=09=090x00
-#define=09MSR_ADHOC=09=09=09=09=090x01
-#define=09MSR_INFRA=09=09=09=09=090x02
-#define=09MSR_AP=09=09=09=09=09=090x03
+#define MSR_LINK_NONE=09=090
=20
 =09RETRY_LIMIT=09=09=3D 0x304,
 #define RETRY_LIMIT_SHORT_SHIFT 8
--=20
2.34.1



