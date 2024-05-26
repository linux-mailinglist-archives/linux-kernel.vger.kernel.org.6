Return-Path: <linux-kernel+bounces-189919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634D18CF70C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6CD28172E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 00:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F951FAA;
	Mon, 27 May 2024 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b="FvyhgoxR"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612536C;
	Mon, 27 May 2024 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716770549; cv=none; b=HekzSQVZ/sRMNmSV9Mwu+o75VtLK/f43Ix20qimXAWKf5j1Daor2805rPAU0Gr8DMWMDWhzmuOe69+0AbDG5VZDHW8RxNFQKbveUwRlxbeUIpVOeWVHJ1/xxupYpiGHAhoDpkQf2Dp+ddd/aeWNqlg5+m3kh9N9kPQetJbaWI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716770549; c=relaxed/simple;
	bh=TOXuydf6kmrCdRgJX4EWgy9jhoi4MBlPqj8fUxfVgmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJurL84s7hvaO07dPv1xgb8niN2hBZwJx8mY7bghpC8crXiSvs3w6PizxbAA4tAUc0qc7fekAvukWItTae9XUDHawMaZo6XoH4zuNMya+RPf+tQXDoEwQK7ExAsSms4uVO7K+0ck+CUiu7716yBt571xgyDYJNd7meHefQR3I/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b=FvyhgoxR; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716770531; x=1717375331; i=seb-dev@web.de;
	bh=frJ0lI8uicyNb2amZaZ+JjmJ6+ptKOdlxCG1Cr4tB24=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FvyhgoxR9pswppgtaepeMLhibem16GBxIrisWItGNokJYJ8JPLFFQYSK4ljnsDpW
	 R0yS7X2lLJBItQsU8PElSbIAzwp3CddShEmmu1BhBDdT9iZCWOZDfOHUqPhRDxuHz
	 GKjszeSz0uAoamBRuxdq1UGYUlS+Y0H8aA1J5/0QPZcl1urRpT2mLfZavfCLnk+v7
	 Yiw+od5VBnRhCgeZBjahcBLcYhkl1/JFf7kJOKWto40Tt8SqfImOzPA9m21UHxmMe
	 173anCLOkmAAUGisLzkHtQ1TbSRq6fIWTJkBlzFmMZvKQQzk/LBZTxADfsnbE628V
	 6nqPWtCpiHI6HQ2e/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.155.184.248]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N2BI2-1seN2q3Wla-00tG0q; Mon, 27 May 2024 02:42:10 +0200
From: Sebastian Kropatsch <seb-dev@web.de>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sebastian Kropatsch <seb-dev@web.de>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add CM3588 NAS
Date: Sun, 26 May 2024 23:46:22 +0200
Message-ID: <20240526214625.8830-1-seb-dev@web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526214340.8459-1-seb-dev@web.de>
References: <20240526214340.8459-1-seb-dev@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eDvQynp6rlZyxtMKGWx5rnGRjj8VMcE0Df3Mot2Fj73oulGPFk9
 YitcjfcUUj2onb+BqftY/Kez/h7VYIK2JHJjPH6hQRhivqoDHGPvNXiBtolQzBf0qayzZqf
 CZjMgLxlVfbByS4q7/rdkE0zp10ypiPV06Pkz/oQsGefz0A2ZLyOq8KKXfZJDMQvkc8jeXQ
 Z8UTC0CDGhlPAxeLIurOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7rTnEiaqkUc=;C+r37ENNb8ObuTCUnBL8kCFvDY9
 m8XPPSnC7bhX6kTzi1v9ZI9EPjdpbjXIbsSkNGyOSwVViICeiKsGeB2b2TvNYMzDSY35Kveqz
 GG6upZcGjS4f3SNt219cmAqRLHRXpg8mkmULb+RZjTmjdxt0L71aBkKTh8GkdIond0+5JWl6z
 8zCyO3p4p39u9+K6TnUUiEMCqXNFI89XpSD5ktY3xmW87ujehq8l3G20XwzZiZ7COzNMYsFPS
 MBV5blAhLmCj7kgqnR6eFcig1b8OBU/HpVzQK3IHRa4TrQoZoz5aVgdNSNx3a1m5krTCdub7U
 Oxesej3CUoKy9N1+N70GrC5r9K5f58T26nJwkM4DH/eD/qVsyZ9Z8D0+on7Nka2NfFhBKueIb
 F1xz1YzbPDZLZ1rmpd4IvgNwLq1miHdBAyfJqa79If32z0HztrZe/jL/TmTPBYTJtfRc1Z3/x
 AhnnrvuO1B//Pc8czODYYgxUgW5utBb/akPXoZoD8OClpCeI5uh3E+HgZTH10W2OvoiS02Mbi
 2LcAIkqojLj0W3SDNrGCXbRdWxBh6ClrmBEw5wKiGbAlT2q8llV51w/nZ6Kn/PZxRJgGSVWEm
 CDzPsE1klYMCxUWbwu7Pg0mCcljjC5NT0JEW/z8mjv5jDYbdA82me/F9qQTZF1C/hz/umJSEe
 OK2dVFKY1RA/IP8YQuRRxk5zzpyMCeKyNGRIb8WiwLFF8xO4q6WAhW0QBpNdl/NNXDtcIH1lM
 Pta+DO8YpcqSmNwiluClcGmiamCmhpfe+RbtEky0Z8KJUSUDzAgICrkJy94nhoh358W+bcO6Y
 noV0Y1FlYTNiAX62cvbY8W8Wjae5M14CAv40Z4yJREwUQ=

Add devicetree binding for the FriendlyElec CM3588 NAS board.

The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based on
the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.

Signed-off-by: Sebastian Kropatsch <seb-dev@web.de>
=2D--
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documen=
tation/devicetree/bindings/arm/rockchip.yaml
index e04c213a0dee..93d671e13f18 100644
=2D-- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -248,6 +248,11 @@ properties:
           - const: friendlyarm,nanopc-t6
           - const: rockchip,rk3588

+      - description: FriendlyElec CM3588 NAS
+        items:
+          - const: friendlyarm,cm3588-nas
+          - const: rockchip,rk3588
+
       - description: GameForce Chi
         items:
           - const: gameforce,chi
=2D-
2.43.0


