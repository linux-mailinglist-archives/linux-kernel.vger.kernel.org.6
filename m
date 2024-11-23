Return-Path: <linux-kernel+bounces-419295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92D9D6BE0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 23:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487E71617D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB91A4F22;
	Sat, 23 Nov 2024 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RU4lodgr"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503615098F;
	Sat, 23 Nov 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732402045; cv=none; b=JL8O2Jt8kuqUFI7jnGQm5jP5qmsvvnLNVETsn6GJ/8pJj/l9JMfhDE+w+2Fg2iZdJLLwYdRvDx0sEwrJlbZJRZvyrDTE+pH+UCdSRKHqvcAcrqBMTt13DsPNhXmvmPyR1939LjcVRGF710KaQ5hkYyc63ykhJXPDN0vpuUxTXDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732402045; c=relaxed/simple;
	bh=cYw6Ms5etAHmXIAkkWWuaOBXV/DpFmBcDFTcsEAfcQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LddLQF64RyLImIO8sLuqw/ef1l7JQANUqDfm2QJK5Qq3VWeLUZZM/+hqKWH1YBtUtepLx2FpBp0ioLb/poUi7ybiwj60iCWr5bONzzBMyj0Vyn2vBX9CppvtlRHgjU9DmleY8OI5mCCMdimCvBZFeEtP3XIrAYnEe1LWurvWRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RU4lodgr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732402031; x=1733006831; i=w_armin@gmx.de;
	bh=LQsxS89vIqTetf9yeZNMLQO1hTX+Mp1qmnM5nEWG6J4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RU4lodgrr59qfULIrRJIUADLK6Rv67wnzbuqldEiHCfMMSRu0OrF/dEQc6Vvvf2H
	 gWgDJMzT/GETXzuPwt4B09CaEGioSxxUaWwvJsV02VJLqHARLRfya6GeZ2BH+/1u4
	 u0aKuSfO32tPE9Rf5WTRbf5gJbBVM0otiUWdZZ3vC24cOAm92sfdRRL6iweCBjFHs
	 a4rZ7jUDPWwp+bqFD/oz2cRdnjpf5utjeGSorYz6dBmHzDrjrWMqmdUoFy/jfgxZf
	 eBx/GtTbHwqLyOYnzhJvp7RjULiQPRZngLNyS25I8+KUxivHNUd/vrrufl63dyFb1
	 8rT58/gP02cvPbyjxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MmUHj-1txQOU20qP-00eSKL; Sat, 23 Nov 2024 23:47:11 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: pespin@espeweb.net,
	corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] platform/x86: asus-nb-wmi: Ignore unknown event 0xCF
Date: Sat, 23 Nov 2024 23:47:00 +0100
Message-Id: <20241123224700.18530-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SbAGKiKII43MELj061xYRrrpMT/X8m2ZyrIQ7e+HrxGJG3qgNaF
 K9rzrThhENvyAusnmKtKjE92TKMZsrcS8+6aYbB8v+nsXNxFLnEqZI//74+RxVrQeo/WdA0
 xLTLzxIlpQyFpoOSGp3tteI3l/NRyBWhVfzmsQ9xs86bfq0THX+HjTQEKpaXdDWqkTPYvUD
 y03byGFSunPy6D8b1597Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:My0FkQuJNjE=;UP01e/4V04bYseoZHlyLoR+kNnQ
 CfbUSRSdcmkF9QCao8tPybwrhZSuJalGIm9L1qcNvXVU9hdpUENcXd7gmdLfEN34Izu3BEbOp
 OP/INUVrPd+nHwdRR1ANeTUQVQDLEHwN3Q5G9Koph/veHkTtsqBmHCBsGkcDL2sFfZCnATyE/
 JdtF63Z7i8PMngtEyZ2MKLtnXnANfXOwH5voCLHoFy7QgoJvBRQVA2lwDul2xfmSxvqghyLEt
 bqP2Rnj/T2vhPKi86V4IpnP9ZQkmn4MXbZhLBaudYqZUESqjJ1s5v/wA/6YPFg7QaVeufpo9P
 Cjqyz3Gtt9FMxEc+UgsUNDHSoVgLqGDeeKeX/l+358tiD9tpWKUOz9XodNjYlHGFfh29dwjuD
 i9F0GF3UQpI/A3x92yQ4SaVhlkQk+Ik46Om8S1s6wbpNywGJ13JuwlJ+cKdJMX16/I7mxPMbt
 zaMOtiJJNhbOlI/Vqpdlulf8AOTQWU+choPcEO96bkxny/fQT+p96lfjY0AcN6j40VjLXolz0
 ww9/kxEu1tLWa1a47R0NEp9dDj4DnGAd1mL/9tt7X4NkNaJLPYTvuJY59fFNQk/76Ip0yvtSr
 t6GHfOJAhAzHypvHZzijOSl8fRhiESUeENiB4OTDK3nDcwjacRnKK50gQM9HYF0emuEdcLycc
 3g65EYYPN63urs2bwkRTZnL+rr6p76c9sAP4OyF67IgUto3E131+9kRl+iRWXx8OjXUPDXV0c
 CCXr6GXYzXDrghBfZlS9YV3/rKiDCATzP2ysWfL3w2kyxCZAf+d/HEwE4BB+LHzHihGOUg0fm
 Ml3Sy1Qz4T/pHKqXmZ/eeAM0R6E0WaHXVZESiWWCSmRoL77wuM2WZqHSLgcKUgDkEc9ytkVth
 VHoIBf8cHKUUIlNGbemBZdBQj7gpa6yhextiLu5KUlcvSEvOFpWMl+Oka

On the Asus X541UAK an unknown event 0xCF is emited when the charger
is plugged in. This is caused by the following AML code:

    If (ACPS ())
    {
        ACPF =3D One
        Local0 =3D 0x58
        If (ATKP)
        {
            ^^^^ATKD.IANE (0xCF)
        }
    }
    Else
    {
        ACPF =3D Zero
        Local0 =3D 0x57
    }

    Notify (AC0, 0x80) // Status Change
    If (ATKP)
    {
        ^^^^ATKD.IANE (Local0)
    }

    Sleep (0x64)
    PNOT ()
    Sleep (0x0A)
    NBAT (0x80)

Ignore the 0xCF event to silence the unknown event warning.

Reported-by: Pau Espin Pedrol <pespin@espeweb.net>
Closes: https://lore.kernel.org/platform-driver-x86/54d4860b-ec9c-4992-acf=
6-db3f90388293@espeweb.net
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/asus-nb-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asu=
s-nb-wmi.c
index ef04d396f61c..a5933980ade3 100644
=2D-- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -623,6 +623,7 @@ static const struct key_entry asus_nb_wmi_keymap[] =3D=
 {
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
+	{ KE_IGNORE, 0xCF, },	/* AC mode */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
 	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xfl=
ow laptops */
 	{ KE_END, 0},
=2D-
2.39.5


