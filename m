Return-Path: <linux-kernel+bounces-438615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16D59EA389
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A9A1887D36
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AB6801;
	Tue, 10 Dec 2024 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pO8xBJbD"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132870812;
	Tue, 10 Dec 2024 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789843; cv=none; b=Q/0LSKBwqLFM6phQQl1S9qlLxpjAVIhOpT4HJBV7wj2vKKsrN4bOZNhCpqoqYZ1HEzoX7rZWt/IAFn5Ub+g1BekCMrSbz5o57AzgEIfOXM+OYLDChGn415lwxaI35LU6bTstAHe8cdFdwWLlI8BcMiMQkWvhALTg0pIros1JgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789843; c=relaxed/simple;
	bh=PyFUiziYEU81rlXyeFc86BFSQplMEMqj/jZmq9uqG3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRYAv32DbW1NVoeTtWYk8pbnH7GXIruC0R2AvssgrjxVZEEC4S/kt61/MaeCN26Z8wvWIbAT8YYoYLTgnYJnEcHpCMXCVy4mVWLn8CNnqtYv2Emel+KefYDGHiBr+GCpJ0anBkb5kKYEATBGYQh+Zdz7VVjw2SFZfmm9/SQqbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pO8xBJbD; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733789831; x=1734394631; i=w_armin@gmx.de;
	bh=ynwFX715WAOy4YH4tt/nVds0p82RcqbxW0WOwCF/3VI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pO8xBJbD0nIrlmKOwROLUe7l4bbv9Vc2JLQUZ5wA9haXfsNBLnudTkXM83tMHSja
	 u0LWlmqE3sKa+/UchMDPICrHd/2d4u0rK8yk9e1VtdZedwcn7KrrK3HiYn531ZUtd
	 YC+vtrZ82IH8hHofbEelq3nzjC3DeVhCKyg43tBFRvoLCfQuQGcmw/9ukboihVELB
	 o4gLchxvejPp3YXGy2JowZ+cslZjly8LlDHlG/UG3IamMzzYnBzgNcuAurQ5x8hgo
	 /AG8oDIVa1ChNqvABag6ZmZRCkl53aFV0r4Soswdsl8zkfcB3WbXZpxzhEP7RoC9W
	 8UmuWh8FGHbjLe6q5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.14.230.110]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MhD2Y-1tovxd2VTW-00q6f3; Tue, 10 Dec 2024 01:17:11 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuurtb@gmail.com
Subject: [PATCH v4 5/5] platform/x86: acer-wmi: Ignore AC events
Date: Tue, 10 Dec 2024 01:16:57 +0100
Message-Id: <20241210001657.3362-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210001657.3362-1-W_Armin@gmx.de>
References: <20241210001657.3362-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L2DgElR4FB2QZWQAU3j3F3+wSr6FYXUKneUIoMs7EIjl1l4eUYJ
 1lxIekj71yrR04bjVIa/8pWP03cfHfWBVY5Mz5ZibakKuNhZyXb4zabuunGLyQLnF5UMvMm
 +m0jwWIt0dPShm9NAzDuLgphnyJtT+yVvo+1+FgmhYCsrQyGNjwL30ZlAutZhE8356bUw0/
 U895s56M3m80gDY+WHdPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SsX9P+I93T0=;iQRSMHcgUDof341DwH07ZlGnhe7
 SIyOeuQFIViEF2/MccnfSzv9S11dKmD1K11okrwow2xRpMKyFqOS1+tKygcnsIMLPBnlVbVgR
 Uk48SDmi5WMaJ1iamxxPUppwk6KNkWeMc2tsRcFBjL1ra9BZSUhyYTdeV7uM8JCeVifvuvWZu
 +FEbqN8XdkYLnRQWMvgoo83Ny+bm2oB0e0mwx+gJ5XfIj0PjU6oRtEBw45a3Y1NYe/fzlTsWU
 vFrTb9BELt9s3RMKwEabhXOvXTUClbXqlt4E5IbrixmVuukX8hiDgh29a/3GWsC96lOXsee5X
 j6bpC85uaF6YwQdxllBBQWq9ymAxylZifSEs/3aSeXfCno2u+PJNrLMqMgTH5whJSADgGdQgH
 iiISog/Fe4/SqQIoOEiJ0wttH0twjWfq0QvX+RAqxePlJ1bFR4t9CHpCTz4uIH3sUxLMQYPJk
 E0RKhD4TVnIkksEYLhhSYmgWXIjPVoM2FHPy68NivlOyDgtDWqtTHoUK1QAkhI2PrrNiXnmSd
 pH38Bun+xruzKdor2WYtz2lhs8gq566qbp7/NWvexF5O0FHv/37OdLjVf17S+F7cKBPNywRrn
 6MsoOTlc0LofIg/0OUmGV07sxxDKJWgUjXR6xhLhwKojmtRs5xnMUUhDfIHs3crWenuGdZu+y
 d1XmC9RFd8JnwaXhNcZhf1pEpdjLT8M7DY/AH98d7x3ZLpz/cF6KdJgYjeiVxmmoV41bLKxis
 repYUXrYTDnbpWhdlLwMj/aWCKP5eb/UdyHDVz+S6LO5lRL2N3stqNlxw8N3Uy08xrvI0T3yv
 hJ8qOBsso+Bw852J18FQDfN5U2+aRHoGM0AgvabFbluntz/kr5QEdZtk8pTGzVf/dAW4ilvKK
 vG8rLmeqocWWgmLqcTTiqPB0i+Ykvs7X6F+nlXpbcMV0i78+oC/czbGt852Jrh1etmlwuZtM5
 eU8wWAysXI2ccSTpcRqIS+SSNNEbxlBXl/Yj8K0FGwx2ymvYg9TvQ8RiqdVYjpMqFKcVwL8EQ
 f4UMMVqEvvLnuDHgfxd5SmzVt8Q7pDg5lliaSMGQZs4rExxE44y8mnoEk4lVjTJWnp8iombE/
 2qh5fWa45KsD3HXWSuUKovr0bO3VGh

On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
AC connect/disconnect. Ignore those events to avoid spamming the
kernel log with error messages.

Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3b=
8-120c8e7afec8@gmail.com
Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index aad8eb0ddae5..ef26ec8d90ea 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -99,6 +99,7 @@ enum acer_wmi_event_ids {
 	WMID_HOTKEY_EVENT =3D 0x1,
 	WMID_ACCEL_OR_KBD_DOCK_EVENT =3D 0x5,
 	WMID_GAMING_TURBO_KEY_EVENT =3D 0x7,
+	WMID_AC_EVENT =3D 0x8,
 };

 enum acer_wmi_predator_v4_sys_info_command {
@@ -2304,6 +2305,9 @@ static void acer_wmi_notify(union acpi_object *obj, =
void *context)
 		if (return_value.key_num =3D=3D 0x5 && has_cap(ACER_CAP_PLATFORM_PROFIL=
E))
 			acer_thermal_profile_change();
 		break;
+	case WMID_AC_EVENT:
+		/* We ignore AC events here */
+		break;
 	default:
 		pr_warn("Unknown function number - %d - %d\n",
 			return_value.function, return_value.key_num);
=2D-
2.39.5


