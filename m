Return-Path: <linux-kernel+bounces-364801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6B599D99D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C328329F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B2D1D1E79;
	Mon, 14 Oct 2024 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UhqSa0NV"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646213BC02;
	Mon, 14 Oct 2024 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943546; cv=none; b=J/j+LTg3OVfGBVW14p3NU9FZ4EZnsy31D4PKfHIWtbFdupvQd+hDNs7wN1dFS0lHEGlNqOOJbBFhdN3k6EMREKb0FgBbjOHs3fSon5wCd+JiRd1qdUbeCat6e4o/CNTFYmADYagpWr4FP3vBAFnp6cvRUFiYyutOSdpNi3GNlrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943546; c=relaxed/simple;
	bh=uh66LZX3haf9Rmh3VD/1nkFxMjZm+1wvS6DHnsk/QjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f4zCtffFpJzrI4kqjNXe4SdrcuERsWsL38nM2pKLKWgtTxJ3EvtEMNte/BkPNirIuj3deMsD7m12tuJAB8eAuzxZ33WgZP9g8Ck6cUdIADOPvet5EeLA3elSOxYkZVU4ft+ZJ4updvQzUpsRqqXMlbBxxNxf85zx/Ij120oBCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UhqSa0NV; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728943531; x=1729548331; i=w_armin@gmx.de;
	bh=ksSaVCE8uQM5KpO1wCWEAv4wfb41aeZvBoAStv9m/sU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UhqSa0NVKU1I2Z8LrO05KVDzVeje4i3y2nxMmtr2R0fRmZ6yImFg40tigADkDFwC
	 G2DGk3YNwVyfX9QDZF02gIJWW7R0sRt71SBxAPTG2oAZBN4fSjaGCwy2yCnLLJW3P
	 nsUfLd43zBY1bZd2Xk0uGa4qhJdYD5YfPQBamro2yMcpc2os9m/KXzdOCbeqo6mjq
	 tUJQnj+yIkHh3LZsHvfIT42RocaoKFr/GqMQobxv81Tu2ZDNYi7DLttwJdhJJLOXg
	 nWVVPHN/SfZaOfUzgL6o50xPCyrdPcE0RjzobugbB2rmSGHtRezYXvAiKkNibOrmD
	 mai/kHpENw1qF0DOrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MuDc7-1tncrm3Dyf-00rWgO; Tue, 15 Oct 2024 00:05:31 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	siddharth.manthan@gmail.com
Subject: [PATCH] platform/x86: dell-wmi: Ignore suspend notifications
Date: Tue, 15 Oct 2024 00:05:29 +0200
Message-Id: <20241014220529.397390-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lBkfSm0oNe6YMtqY59CtZm9CP16D9n3eGMxPwEOca9ZbChk6Ehl
 XJj2Fxpc7ZgLCYWlD0Sg6COk0GSK5/d+buSCMBrZemKF1nawDF6biym5xypxYWW8PgIU15j
 U9zD8qoZ6AqOKffGkxgiyEEWrw2fK8W1az4b76NIJoTBSobsaGPxU/NNJYRrvwkLs2h87ss
 Fowv7Hbz63qrZpaPBN0FA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NFuodmsOiuM=;KCmqzMAfSXHquOVGzSgEEHc1WKH
 xssPlfUOBwNB4GP7ssMYBieK1zY0zNKJCdKix4quVVEb7BuqB02aueC530nV/ji8R0mtbzz12
 HCbxcdLOwJvhTFltYqjTuWjFUQBDCcDpkjI26zXrFoKd/vvAHrtGnUF6uytfEJebHuUSR04QD
 c/2vFGSbhxQ0nLF7bnJnDnwJjFsIEB56RH+aHH8ZIUPsa3PrKwVn61gI/e1UsBTrgx5SjbI81
 q+AoryFoRWsSmbVT7CcY5oIqDwujEQ/1vPO+WeZTj7ZaXA08cKBmtvf+pdODmC96FMH53vzmG
 I9u3SynKq1LCHFpgvlYfmBXZX49rm0Ttxz8sa1xWUsk0goRglTSVHwkCysESipKJsz+K+RJeO
 DCMfPrNz7lqXp1JDjwdagXbkKaDfuBXPAns4mRA7Xa+UEx8+GEmETR9WNbIHeC4f4eGOVgvPN
 85x5D2zMnBJXAtavonJ3W5Tayu8zSruSkzRIzAm1Sp/jYOxRXYlKG8AKTvsyMZ05TLlqKBzfX
 RYWWEvt5PLQyMKF1D6Nq6n+Ece+M7fI1ucvDGNK4OgGy575NLdiYKMi0iM3PcuURgcxx22nqz
 4zPN88msqIkC0utoXrdjs9B4AuLJs/YQuVq6oSj47bproRR0znYG6X5DqLHIVmixe+KdMhNP5
 X2zGwb5+sDRoGQp4qov/k8IFAd7eof8vHCtq7tFPZqbXR5MTMeQab3dnFth5DaqlMyZlErs9P
 QqbHukmzqoGkv/eBUmDzIh5/Z+OTHCZpRNCZ8l74Q3/340tXBPYhJ6OYTH3haF7YEC5sx8kG7
 XMoQTtQgUOiEilC1Vn8c0Wg8A8aVkxPxWOzOxh0c37j7Y=

Some machines like the Dell G15 5155 emit WMI events when
suspending/resuming. Ignore those WMI events.

Tested-by: siddharth.manthan@gmail.com
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
For some reason mjg59@srcf.ucam.org causes a local error in processing.
=2D--
 drivers/platform/x86/dell/dell-wmi-base.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/=
x86/dell/dell-wmi-base.c
index 502783a7adb1..24fd7ffadda9 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -264,6 +264,15 @@ static const struct key_entry dell_wmi_keymap_type_00=
10[] =3D {
 	/*Speaker Mute*/
 	{ KE_KEY, 0x109, { KEY_MUTE} },

+	/* S2Idle screen off */
+	{ KE_IGNORE, 0x120, { KEY_RESERVED }},
+
+	/* Leaving S4 or S2Idle suspend */
+	{ KE_IGNORE, 0x130, { KEY_RESERVED }},
+
+	/* Entering S2Idle suspend */
+	{ KE_IGNORE, 0x140, { KEY_RESERVED }},
+
 	/* Mic mute */
 	{ KE_KEY, 0x150, { KEY_MICMUTE } },

=2D-
2.39.5


