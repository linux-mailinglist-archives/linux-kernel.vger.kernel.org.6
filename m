Return-Path: <linux-kernel+bounces-420182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCDC9D767E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578D31655C2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3157346D;
	Sun, 24 Nov 2024 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HgEWe/9W"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7F148300;
	Sun, 24 Nov 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468496; cv=none; b=JvmBA/mtYyZ70cnu3WAEjpowPLLTlVAGo4o5lSKAycY3GiniH/9SjtLVbtKP2TE5omYHhx5I4wjxu1pU8rKVWVMV7DJdo2LqVXGl4MppQxLUXKU7X/+1P1+pqmpAHGbrvWvk3IsdNZZipDW+d8aI+K2CFhdmrbF72IpCykNOFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468496; c=relaxed/simple;
	bh=mzzZCDT4apevZdSoi/1I/xkCLKfdfaKYP2QGEvMmaLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFdk8P7vIdTBIfxpoCSzvTBglSTFRGCxNuNc/b03vhFm2dmzxy9dMaxl/u3fU4wpt4rSm49EYjsQR6v8jFlkFdZnzICkdGcoPapf9BeQiPkHVtJfn9b7VJMzk8I59IqbfC0RAT6zi8WvckVrzY0+T4sZFuXUoL9pKdHhFu8P7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=HgEWe/9W; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732468486; x=1733073286; i=w_armin@gmx.de;
	bh=SvrPVsAm5TseWOQrJsUD7l2NbvUMXNQH8wvoQdhPT6Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HgEWe/9WivVQmYmVn/VBOi83f5rBR96BSF8h40gt8gnZrYTImsxxdF1pEMgxAH5S
	 JzdkxeQwAWChm9CkL7agZ1Hdb4ZEdcQHRdu2Yko54vEp0R7/rRIv1bzHlfFuTTJbx
	 6MOYjP9anpolVB+FSVsYIJrBeko/BayROBNcPStdMs7Gd9PQjp+upR8Bf7ysdk29u
	 sS/2sOVCdh4rl6IkbIa+NVqYVOR+YlhscEcoa/n179PH1GFGIn9H1GFnq0Bz6oYrw
	 HBALN1TUto9wd2QGZL3SrFOYKzejlMdYRXdAHinyIxvNr0pEgQUPaJ8PC5j6wpLmy
	 bX9sPY0NGTmfDhrSfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N2E1M-1tiUtn3w4c-00ybzh; Sun, 24 Nov 2024 18:14:46 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] platform/x86: acer-wmi: Ignore AC events
Date: Sun, 24 Nov 2024 18:14:26 +0100
Message-Id: <20241124171426.29203-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241124171426.29203-1-W_Armin@gmx.de>
References: <20241124171426.29203-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k0On+4OSPz+hHluHv8K09QPFIQKbZuvsX1umrwKCxWipua9RFm+
 viQqRvndXfgtw/jN5TXlT5q5RCllaYsdD+5j1P/VoKZEByESoO4ieyW7OOMWjIa7pBAr/P6
 1KoyzzZI1PTWT65UylRYYm4WL6pif8+cCuo2bk7VVkI1J99YEfbqDOtHBdTXN+HRPAJQHpi
 mApn0sZ/esb8pM6KMyXSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YXj3lUSOm9Q=;FBolMd4+D2pSAiBl3kVkMw7QMUC
 aTfcedW8Z4fV84CmfWmLu8n8iM664Z2oMsKVWhtD0gPt57rcdj0yeRvZuBUEF6VeCzFciLyuS
 sj27rI8UkCG+NvCMzUibUVRH1vszfwrqP7XqGUBMmLUB8+75G6ilroFS6bwSvRKStafa+2tHt
 G7FrJREF/A+5ZZcZvoemNOhkYLP8k37RcTdS1tA7LuHUxBhBQWiBOv4lU3xSUCrCahHuGphYn
 7mH+wscxNA77NkRfXZgHULf852eXpx7q2aQ5SQ8+jvnhn3fDucoBOO1NHPjJ1lYrLiu/MGyWh
 F+fv+lJFcPGcpyKLohUZSndNqJiQ3rAGn/UevZaPqFyVnXexArM+W2Lv1/0CceF7rJipOaf2K
 dE10HDafh7lWHrG3I/bQjHb3xZctRlKL8DN+CqyEvJYlcjdbYVJndyv5J/Z7aUR5FseoH7D52
 6iTn8Mi74sa9EGDFkbwFkUhn30l348rBrFfr62zqjh9PBx9U3yni3UAYgwD6t3PlrWbeupc8c
 sZGUydmG4QP45ct+SJHGyYrPdprLo+LDQjsvIKM6FN9umAIJXrlfj2tv7S0Xx9jdRy11alxlw
 VSPX4iHygGW3VyM3ctEr5iesmKvwGLpX9+nFHsSs8XzHRh9yT68uHWgDtjNcXbpWKw2lq3ICq
 UWPwYITnGRne12hVEdI9HswJlRDOwIA1hYJppkxUMrvAzzim0vIOdnFbVlwRhMu0eYItwyVRZ
 0QCgcWg9MpGVwmOKVRo6Ax8nu08FVasoLxXd5Tg+1gaKo/IgdBix0s5Elqnqc97JxnTvICcLq
 aQLQdUxCOfGktK+kyTtCc6SeyF5sJSEg1DAbi1P7NvjTEXgPkj7Lzy6IV2nIYbJoIPW+ExQEv
 5PXwM+yH/w9e+HUyqBCqBnLT4Jg4T8m5q8s5IR9MD2ifFcctLXrRF1cBohvmARUrbU1CkoEG7
 Y8JJh9wvTn0OadTizeDA94agtfozapzC4yf85LDqqWTzU3VfZk3ErVqwsDp1IAjHuacBG6jx1
 Sd+Otu0VuH3RUkZxMK+psTVYXUq5lBSpyb0QgGqvpapySXk6PWQcLIof6Hk+svYS02zJ8Jwzt
 WpIpHUv5d4PsreCHB9N/aZr/gh1RDJ

On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
AC connect/disconnect. Ignore those events to avoid spamming the
kernel log with error messages.

Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3b=
8-120c8e7afec8@gmail.com
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 6964fea84fa1..73243090242d 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -97,6 +97,7 @@ enum acer_wmi_event_ids {
 	WMID_HOTKEY_EVENT =3D 0x1,
 	WMID_ACCEL_OR_KBD_DOCK_EVENT =3D 0x5,
 	WMID_GAMING_TURBO_KEY_EVENT =3D 0x7,
+	WMID_AC_EVENT =3D 0x8,
 };

 enum acer_wmi_predator_v4_sys_info_command {
@@ -2302,6 +2303,9 @@ static void acer_wmi_notify(union acpi_object *obj, =
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


