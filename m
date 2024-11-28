Return-Path: <linux-kernel+bounces-424820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07AD9DB9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3AB16472C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4E1B3933;
	Thu, 28 Nov 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bGJsTKGj"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EB2233A;
	Thu, 28 Nov 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805487; cv=none; b=OdwrU4+1ptOCTsMESsAFSF/7xi4nHGJr41mg6NaquhXwt4uiqPy9FSDczIVWo7PJ/mX3nxl2TadHHUq0DE70TXcrVUqrOhy0Kyp53eKvDhjIBziYGFNOLQUmb1dzSwuUoYc3pb/I0a7n5Jriqc1+c6QcRY2Uu82tM51SjqNph2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805487; c=relaxed/simple;
	bh=bvFbxc5P++9Gag+zgAYbv6WxVb4HNe8omEWI00cWw4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoiQkghhzPE6NFeZrr+4dclg7Y6pcVlUy7Puh8nISxnwTBPcQt5glDr9jZr8XY9LEBKyA1EBSn6XtMCuz0XWB6rsQP9hLLMP6Nr0DbjgkNAXZT1pXk2hjA7J2S7z1PGwzp7e/IkWC54Nb1AItWagXJKPdmBMQt0vPP0Xt7Nolpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bGJsTKGj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732805478; x=1733410278; i=w_armin@gmx.de;
	bh=LDc/EFycTFB282lPDii06kaNXf50E69nOVsxqUvjg/Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bGJsTKGjmY+0kCOq+9kc5X+VxmXG5KhK/LfJ7TdHyMP94AMk+0F48LAhkJoEINum
	 MLP6eIpGbmR+BQO0t5fxuHDpx5totaM+KdkoElin3XUNU1iBFjjH+bUktw1IZOE0n
	 TuGL9L8RmDfyvf4UUIzvrQLSyQuhTR0zcA32r6myrrCjtOv5vITWTsLnJ849OoAyt
	 w6h0BDJpJCKa9Jk92H8U+qzSmA922WH/6YcZ5hyyaw60tSPhoshpFsmIE8D/xWbzX
	 zDLLr26QcttR/gXO2BbWA5LMCNKrjVsPMb+CXWTBElk6+8RPPf3md4Uc7vkejo3Gi
	 BNwS7I5G2i3LKnMnfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.179.133]) by
 mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MdNY2-1tpjd80Fwu-00jFSQ; Thu, 28 Nov 2024 15:51:18 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] platform/x86: acer-wmi: Add support for Acer PH14-51
Date: Thu, 28 Nov 2024 15:51:00 +0100
Message-Id: <20241128145104.13538-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128145104.13538-1-W_Armin@gmx.de>
References: <20241128145104.13538-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MAxcacE9xM95uXVke8cyHuvbZxSPna3aU4UclLg9j4oOTNcc13o
 wfz+KxYPvPAAddj3fN6k07Vus82wTwyX+qyau8y6BnpGErqygGuuhu1N4t8RVedADUrO7wO
 ZmwZV5s6QWE3wH09FuI1a0sEM5rO8kq0tBXIgo2DmvOmcMaF8dFabl/zjf70IscmvEppX6N
 auS2oDTardU8kicnSzhEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rWrJipU/XM0=;QgfxeM1LDWcbTmBcjr+r0tgIGcg
 108n6GSeofJHxY1R2KtwbEJ9icADtSRl62XxHHIs2G8RfDKVK1+GbPjMBtoMIVwKIfpJ+/8/4
 vXhmlfYIMzIDC8NcwwdSYMcAOztYHVzsJkdciYfTAInCidfWzwryp7WYZgaG0ovmYpWN1B5Lr
 QhMpZ6LKok5RkHqEtvWlU40PEKc2ALUbDHGvBZfmISP5IbQaxalKWKTYzrYopRmq1ybYahGLx
 U8nK2tp60f7KBERcUk9QMH0aMZK8iuQ/IEySVI373JaoZybpNMrs7L+7F2ktKV4vVTxXNZF/K
 P6uszRlHFhbhbOeEFlE4JDi2b8rkCH0aMtZaBgGme4iYRcH6PfQDJGYY0vFdLk5b8un7htd8t
 TfSm0GQJSTJnPFm5J8kKi2G+zcfHf+GG3RD5Qdy3mZmI9ffaOsXsN3guC6Tv5oOGOmcTl/rAW
 ozzwB0ZhBufP5BFQ9LHflivyECBCOV8UQ1Nk9RmIcPBERriuDkmGNNhPZ9P2Zf/dDTMkLCMXa
 8Gmm0CwZ98PxVZERirNfIjSv7Io5i7n9D8eRtfFbXJHEKUc6rgTPmhRalaTJZVq6ixB9A5Yh5
 Zk2plO03mTPUcT9wP0VrlAS9SeOV1eejRfTlAc3xk8aLSQP3w1X7FQLmxsJOBtN6SN2PPy9ZS
 pNvYoQ+3MFhtcZ7B+z8eSGs+7QxJBifjtwGCL4laB1MNecjLRJmCe+BvVEO1SK6Wg3yYWYHts
 7TP2ENheU9C1SrznnDs3EkezDir74oAB9qLcuY8WIBCxH6VSXMzvOJv95R33UrDxA6cHxCn35
 W8rEFySf+je2q/KHCQmp0xL/34IWdbJfy9tSlkiA6pIqObGIJT8IYaEaMb8ZdvUlRJyXIG/Z7
 i4UeiCJExHBXNP/I3McVLMywRYzMLz8yHaXLqSswL9cTqS/Fgr/P01TnwZWqoxoL5suV/KjEh
 JdWdqdOuCgvitVnDi1ndGnhuGUrzJT/KrU4TSaxcQNSFDoKnxuyqsrcUuhC+8+NylBn3TwXQU
 sqRVqmXD2r6VAtQhAuFA/BSqGc1VL1mNqGPrZKsDHsF+t9WdbVSDh1H/7LCn7Erh3q4LXvSrk
 qFARIqKKi4vqZO2oonpk14ER7xPQJs

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


