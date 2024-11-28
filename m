Return-Path: <linux-kernel+bounces-424825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D284F9DB9EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471AD281D42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4F01BD9CA;
	Thu, 28 Nov 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="D+FnNRBW"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032441BC065;
	Thu, 28 Nov 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805493; cv=none; b=pWBNDBqPsWx+RTlYRSYPYiv/vmSr+iP1sbDsqUdJ1Gepr9bFKUPIUPZfEjAT0ds3H58BKgxIgjRWAw5KuFG8kexhnVxRB6+UFkTzuNRuOp9iOZG1s5CnKeGalFCnOU9HDWp3EGLKAV6kKhKsuOmjdFFIFGTCAJi1LrpvBbwdJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805493; c=relaxed/simple;
	bh=gykNvCSx5PNdnquYd1VHSOHJ/RJXek/+SRQGOnywt8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLD5Z+Sowf7iShHEmNWf1MuQa1u0QS2nqZaaFh1XB+XPfFSmIwutH9Ahm+tHXYF9VN2sECxAf1LoyRkl3esbFqi2bNTYE89ehe4Tdoikqm8UsX3AT6m5dMYoz6m5Eb0RfFBOivtEzV9+aglS/6tGqFXJ4Xjs2FrMAuIduOUHkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=D+FnNRBW; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732805483; x=1733410283; i=w_armin@gmx.de;
	bh=3FZ63viKN++1lQdM4gtxY4u7uvshhkYMJ8O/He4ViR8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D+FnNRBWHNXjzqzTBcEAfSQZTVXeC/iWgYCJ2S7SEsGtd2turGz8zSdeAw4yvPMj
	 aZuW+TtFHsj/THpZsVmpLDQqfxQUgIo8yH3na9nDDkBakiYYh45F+CQatY6HKBmIa
	 zImXZsCszXJkpChQI2JgaEfrn4VYAlXSHaEUHs4f/1ux1hVyIlCm64eSTo0/ykb0F
	 mEvB5y6mlZmH19SjBS/oXp1DFVRVSiZ0uLCZhcoStl7+xBAcKP/ToZsgvawlEvXiM
	 +tOLFqpQw1zT+LTUvEv1YkwAh7izE2imK0ODfLFGEDoD11i1Xt3ywyoi9wqykgfAG
	 Q12f+qe8V7eLTQ2qHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.179.133]) by
 mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N4hvR-1tixqO0k4t-00wgD3; Thu, 28 Nov 2024 15:51:23 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] platform/x86: acer-wmi: Ignore AC events
Date: Thu, 28 Nov 2024 15:51:04 +0100
Message-Id: <20241128145104.13538-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128145104.13538-1-W_Armin@gmx.de>
References: <20241128145104.13538-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9JE+u2lwO4nazIYjTlKhrNT+5oryEjBXMWQ/cAzxt49Qx9C6Nlt
 inb7zXz/tCB+DVqMfigMiyjbAFwEITx/ftJd1Z1jxALdGkH8Kge1gaFqFXNe6LoVUzQfEhh
 61z+7/znONM9JtC+FtW95I1yaBrk1jU4QIzLAArltGL70hFWOlEiOEC+EAz//jubjBQC/tm
 u85mzzGeaDkJ65aQkV2FQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pvv8qCmfjLI=;W8MP2m9MVtyZubtmPdQfYJC3RYK
 S4CC5VwnEkA+F81KVGALVFyEBY2XQbmAfLCfSTuChp1XD5NSx7UhP21ZT4P15uViHaiUSQt62
 Kr6pi7XdgifDRZJIsXbWcY2kcrMplFOwu89PN+BU6xt7w6KzAIIwq5FAykmblz/9yPUGG/plJ
 rdUMDjvdHeYUuxBqPENtcdOJd1rFZzpCQlD/nngwK1kQQc3hx9RJxkdwrpm4+Xa4Y05RPjL0Y
 K0Zn5RCQjpc6GMlEuEv7/utAjUMy9L8UTSY0tRNwNEgw/rCpyv5BWa4PXxUTOmgAM89GhE46r
 W21Y3DMlPqKviGDFdiCU2KXvO2EjyrdMrYZphbic03/h3XhqdbSxxpTBAQN1V6J7448dUjcNH
 QjriHUdqWR47Gd4uVAnVU/h1GjxQaKuEmu9RVyozUi2w9TM4h/KutMqRrxEJO7uQMKVIo9AOe
 roNUsOzcOlIC7TUFJKpqMDJNkhE/quxaiGjYgiBwQ0p8Gf3pF66eArphBqemYIJSX8a4XdNMW
 +r4VzT42p1mJNFutStOdR+bZFaezHQGdRBQlj5jkl+njDAilkIguWz1ejSNMaCXrtVENWvm9h
 eKnQDfCZiP7AqtiJUHl1JtgZ4u3lpAcDvuSfpDbk9tGJDrvmkbw/4H/2ikPov+e7W0aYEwno/
 NfaJFqZBvOLOMmVgd5nDSEJ+4daPnTgrEbew2WobwYVbvRdpD7WGujbBidPvF1N36ZjRszKpQ
 qkd7WCFWJrSOCWZVorscsZMJB53wPVmmGhJAGNUk9p/JT0vZk+0BwHetT7MsYx+TOSf4Pm+Pt
 3mCcZT/bIHFJJny/9RGZrGooPkOQAEBalpsGVJfl3RVGQv2i1h/4yHRZvk9oP38No0R5FlWi2
 EGAoSYhceoqNZLNzNHoYNBcpyzgteajamoeCwhMA0dpMaa9PPQUnQkfz7rSdUImsoL/DzFj2l
 LGRKVSZsccU8MQJfPqdy/7lN6GK50zYlmBOuXHmlI8dVNeDseJkG8KHntLAV0N6SBKx/J08Rs
 XCBi/RapowDiZkC0ZhhUuQil2HojIjZ0t4XWoimdahHkpbE1Ezj/E2qrN4NDTFwzmKeULbFq6
 dgRbKaIxjxuXfpJnPSwFJQ2/gIPSgU

On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
AC connect/disconnect. Ignore those events to avoid spamming the
kernel log with error messages.

Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3b=
8-120c8e7afec8@gmail.com
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index e2615ab3fd25..cbd1c473a45b 100644
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


