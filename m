Return-Path: <linux-kernel+bounces-425913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF459DEC7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1184B21030
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B15D1A4F2D;
	Fri, 29 Nov 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QNeiGMQC"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EB71A257A;
	Fri, 29 Nov 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908856; cv=none; b=JNA7+wxKdY/aMp6w0YJFixPM4aqdzhFO3Sn6eRTdrEQs+cKsmSwm4b6Fp522j16twKfLkOxqp+sU5A4xXT/KfrWvMbAq9BsMpLyyizsAsz1VZ3ntzmaBR9DvrvbFE8D0dt2sDfGOITQMKnq0EBExrMlZKMkYWq9QuuJe8m7b3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908856; c=relaxed/simple;
	bh=bvFbxc5P++9Gag+zgAYbv6WxVb4HNe8omEWI00cWw4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+8OOhkQBe4cV3bO6QHYYqDOQtoAxadUH1lNBVYDLHw85vZM3lfvB/MzOdWLK2fca0pwFS9i1Fjv35TAl9yQk5Jr26DJj1X0/+f0wnQ7aENzdD5JyjTAjfEUGta62fy5jiavZXht2ylUDYq9k+HLne1/QDnTyVS2gjkT0Me+QqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QNeiGMQC; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732908846; x=1733513646; i=w_armin@gmx.de;
	bh=LDc/EFycTFB282lPDii06kaNXf50E69nOVsxqUvjg/Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QNeiGMQCYSmh3160HEiZrqA7zIwl0sh+f8zm+XP0xf5YTtPvxUJ55Dogiz8RSy+i
	 Ix1w5Ub8+5pItwm2JmP3t0GE/1q0wWfusNAD7QX+uTt4wh+E+YkvsJtpMTzGqJ6Ja
	 JF4+SJ120SW1ZJm8zRshCtpWhNPQssO6V/1TtcmNjDeLLQmpvfgj3G8ERVFJwPch+
	 ISci7JK8LHAEFXHe9+lATJZoA2q+FpAp+5TfBaJNjLAHHTxXxlPeBrGu7oWDa/8I2
	 910ZcrIm6Oq/NZnJTPcSMeKxXypDoG91wKQofraZL2r56RstmETNBsn0fpN+UmBY1
	 0VwM8z6QK15D8ZfIJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N0X8o-1teOMr3HVc-014EA0; Fri, 29 Nov 2024 20:34:06 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] platform/x86: acer-wmi: Add support for Acer PH14-51
Date: Fri, 29 Nov 2024 20:33:55 +0100
Message-Id: <20241129193359.8392-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241129193359.8392-1-W_Armin@gmx.de>
References: <20241129193359.8392-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nv/KsnFBKmcenTntND5dcJ8srL6zsPEwhXU97BWYZ6fArV7Lq15
 0HxVjCB+EAgGTJFMvOoc7boBaMGanxON3YioaCETLuLR2iA/TxfG8FG+19mXH+TIOL9/KU0
 cidy6+azoqr+YXAh9zxbGOeA6KlpKg+47Zb06Rwo8TjO8qKYtcg9IqPV08Cl8boi+cowqGn
 XDZTXy4AX+JWpC4AIuwSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RL5E4/NIqao=;vIZ78XE3k9MMa4niA7qQLULTFS3
 sfEWnkQgTHqcapfq7cvG55/ue59PKKjeAFGXn9ncNMsRVlxYPp0+ZiOTeP+ygJADC855wLnv8
 HxvpR6ZfAWlbofo7gBxmNvyRK6YVg7lUgyTwkm1bpKuCyJ8H9RhzwDOYVyBKpb/6WGLqXCWkS
 ahJcwGMb+ogwJujd6WyJwCNI6proFu2qw5a2QfZFZJR7uy+hFK7CJTK9Gfn1Z9KfwGqQWV2ei
 vAVNVjgbD1/ozupHZH7JAb8+Gr9KwseuAimyGHbHZzmajrSk3vILDpers+lZaHKx7C5o3uJ8W
 ldycWkctiZtGZAuQ3ecEdLuSOGYb4RvJysHJ1R2h6NB+GZweZdgLqLb/OPkGGZuL/xtXgHeTc
 Wvdgf4wC2ZRYYXcviMV+qysJt0Bqju40polVLPvAkZjO/6Rxo7RLKKKQN0tLkKdqOqKapSrio
 rQVdHTvab6ep/W3NyIez1UEfFeI6IEQkXj1+xqvIJxEkbcL2Pc31bckgwNZOX1E9VvgLQ69yS
 Q3zltcCsf+uw10GIDwkMOlX292lH3kqjdhjEzV6uS3R2kqtBcbokKrCVxG2UeRI/Ns6myaIk9
 FTn1LtoDobZpmOHFeU2VwKADMjd2nGpUUwbf4fkEPO/vEanIQ3MG85hvX1L9/E8FGP+ENBSof
 Z8EV3MYfZBs3XJ0yinrl8uMkk1po3GZkSxxnKD8Pw7fxV2qD/nA54CcrvahUFe7+RtaCvv6SL
 hdiS32EfHz4EultNMtqN8Sff89+kNzrAgfqImYfq8ChpNb61vDkWdvxne5VI1z5odB80t5WFw
 6o27haHLXFtTTvWT6MjtA9xFKimpHy7CJmwFmfmqwjmaaba/nZpolG5hteGUPAMHZL0Z2Qe2Q
 xxl0FymETtmQRW/z+qF57VPYQrb8NDT4I/whtixWTTlseiiMCm+vfWXDCQsS3/WTcGFoaDEyo
 LgtBSkkMZm+33ahmqRF04gBzAdLdEZJnzpgcJ+W0gGYiSOm+Ugp8a9FAPKZq8a115v7VEwtPL
 XQbZ/Q41Z55reaSifOGB3VOh2zJ4sPDXFCm76AJJYv58bpSKOYsBgxaOwZT9rOmLVjhJA0K2g
 5swBczYYi+ghkBUf1iI7XA2usD3QFm

Add the Acer Predator PT14-51 to acer_quirks to provide support
for the turbo button and predator_v4 hwmon interface.

Reported-by: Rayan Margham <rayanmargham4@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/CACzB=3D=3D6tUsCnr5mus=
VMz-EymjTUCJfNtKzhMFYqMRU_h=3DkydXA@mail.gmail.com
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index d09baa3d3d90..5cff538ee67f 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -393,6 +393,13 @@ static struct quirk_entry quirk_acer_predator_ph315_5=
3 =3D {
 	.gpu_fans =3D 1,
 };

+static struct quirk_entry quirk_acer_predator_pt14_51 =3D {
+	.turbo =3D 1,
+	.cpu_fans =3D 1,
+	.gpu_fans =3D 1,
+	.predator_v4 =3D 1,
+};
+
 static struct quirk_entry quirk_acer_predator_v4 =3D {
 	.predator_v4 =3D 1,
 };
@@ -600,6 +607,15 @@ static const struct dmi_system_id acer_quirks[] __ini=
tconst =3D {
 		},
 		.driver_data =3D &quirk_acer_predator_v4,
 	},
+	{
+		.callback =3D dmi_matched,
+		.ident =3D "Acer Predator PT14-51",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PT14-51"),
+		},
+		.driver_data =3D &quirk_acer_predator_pt14_51,
+	},
 	{
 		.callback =3D set_force_caps,
 		.ident =3D "Acer Aspire Switch 10E SW3-016",
=2D-
2.39.5


