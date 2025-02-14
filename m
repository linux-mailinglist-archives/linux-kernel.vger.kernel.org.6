Return-Path: <linux-kernel+bounces-515723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73593A36826
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176D53AA846
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2161FCCEA;
	Fri, 14 Feb 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="exJYMU0T"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF91DDA18;
	Fri, 14 Feb 2025 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571220; cv=none; b=bQKyamMbcV9mMXy2IRD4eK3T5nZKYcTzSPtLJwilxAvHjN4/SVPg2mLMcClrlPga+sHgd2aAuJ7HhxsVGN6ONbXey6chdma3FiOxuGAYiNuJGhHyoc35bGqYun8mtp+r0iYHeQodRC7iA+hEWzvg2bSFNUXg9IadzS1Fu1Ff0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571220; c=relaxed/simple;
	bh=ba+hn+IBiz5wojCra6hymsACBfDSU5cpcyTnl70wcJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4+owbehTWmAWg0P95QT3WZuVMAtyXiBDZIe02ibgj/C4M9AdPUUtyt+YND7PL4xrTqx28tEsTZAIMH1m3b5Qpvu7HXZvxILbflnApE3qXUCs9ob0dh0XSs9TMeylJhpcmvg7LUg1PfYGhqKgy+m93xW1HYqtThCy3oJdU/q404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=exJYMU0T; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739571216; x=1740176016; i=w_armin@gmx.de;
	bh=xB8nfcIGfWAml1wS6DRi4V1OxOYZOMijucslZC0RTIw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=exJYMU0TwtBR1SJjNOn4BYPTgJBVumYgbz7U0sDChGBSyEVUxcHDK0eTpCUto/af
	 XrGdbxXwYtolEy1wQrhB1jX7oCKmrGmAifLTG8+XMTbXiL90K3KzR9U6RCjd8BebL
	 MUQ9ZV0dm94HmggwZVOgAPTIqMlM4I4itU+68caOA9tkZ87HIPmIpEzn7vvKTycXq
	 aq+4BFcrx6QeevptHZmTWBUx9/IuFy5Ni+l+l89JppQWOZPw8LEisp1rFKLhV2idR
	 5KTYdLMXrdyo3btz3R0xoPUrfEBZInNBpfFBCgkHv7nFu/e6JgYsTRj9uaAgeGtbD
	 /5aIyxrmPUB0KVDXeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N5VHM-1tKAfl44ja-00zr26; Fri, 14 Feb 2025 23:13:36 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
Date: Fri, 14 Feb 2025 23:13:22 +0100
Message-Id: <20250214221322.47298-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250214221322.47298-1-W_Armin@gmx.de>
References: <20250214221322.47298-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h7/6J+EORcteXthSIviSokhcGBTy+kDnJLN+kTO/DlegZ23urgd
 p7volsIYHcdfSpEqEregNVGQlfoZwvJ3x7RSh5Ke7LS25L17hGo5L5j4FnC6DzGObTF421l
 2aaGeE1BUx3IoZA0lJ/Zs1a/0LplMycuereRdMrJT8wDkszkFdHf3xzzgJ7Vkcih1qsQ01Z
 xzimeTNr1buGHWqvWyWCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1XHGzZrp/z0=;9MBh75K3zSza1kS/i/94r6U0+oT
 g4Tb7dknFZIJm57UZnFjWdeGTGh8olQP3TWGzzE9h+XG32keaBnHUldM85zLHhMy4casp2hf5
 57o0bcJY5cr/a38fROLrmBIhVl8wur6L4eidqvcMXDVUsBJYzrLBeLJBXhL8WSjQavhWmFudU
 hnDTo8IvJ6XPuVA2NcjjhDeSJs48rCk0yby/BX/SOJVLzaVdWHwk8bXwPF8+0p3rZsVQYH0UI
 mbwLbsGauWW37x0wQiEJNsDLkAK6OLsVMmFVp+8ArnpaHaIKD83p0zNerIV7AWzal3WQ+gkYZ
 fLkHUpEWOL3/7k6Ao3Lj/P8MOPPxVniRoEVfq8/J+7FoKxIgQug5MRSSJ52QCY2i2fiSDrRbx
 kteD+m2E4WE0Os3pkSAkQWyAnTaXgu120Q/6+1Fh+FWxeWtMadA4sNNxkdEqWT+0bsuSqXAAw
 3lyGaf6APc1FWP87CEQModDO+2baHbFBV5vsPbAaEkvSzFArnDlDzyrrEgc/7ZvE+5tzVd83N
 n4w0joMXoyTzcHnobNNCtAHoRl+efSRSuWLgLuWoop2vO78BOVC6zjJEJG1KC2hG1xQKWux6W
 s+Qi+QnKHXpBUyeiaCD42180PdvJfQFWm0oAroSJNuNfhZiGxaM6vcvAqUJbvSABmW1selyRi
 cPYi+r9+G3k43v0sgsV7+MuWjlqP5weBdzvugzi6QfMoPdp7zKahG+ZrNb6e/eL6hVIqKmSps
 z7zCTgphGmE9SxtyeGzTBKImjjVvFhiirqvDUhOi0xqzp28A0KS5Iakod39o1x/2QaXLEaCDU
 LME1MKV2eP3OaanDEADu8klrpp89faUQkyMZTQfUBsnwReuz5VjzlmNosdRggydrp4adoekcl
 kGf1bc6s9mNqwNwRKasAEgwZapgmYDBClAJ8AtnfHn0UrKXHvZrQ22f/8mzkTm8hHJvSREC+x
 +ojKmjx2AmzsFDICDCS4eFHS8/DU3DSBYP2hp5tL6cqUx83oIaEV4OGstS+zLDoILVtztgs0Z
 qWMXz5XcJJbLB3aeZoonplHwnosuKU6NbGj8foJMyH+v7KGRudtCk5uSAb6gkBiQGKQUpBLG4
 d0dkNV7TBQ1UuPbfEGvq+sLem6zrPNqAq3MmXuFg3SLRyIT9KuDF0mljZ9WZyMkQUjtp6Esl8
 ypFZjs/duU0KDc9XjMTQNNEbo4oXFCJAohlFd1nOCsnPTOKwjmsCrw95yw+mUL4/7r8HsXYGz
 WoG8b8KzNJV6I2YarIaYeY9zjPhbc5w9FnzgyzrW+wy1ya8evIxT0/NW0oGclpPckD53DmKj3
 Wif8Q4MCim0HFN5K5NKqMw6vvmxK4sZMYvV1uAW53PituegTlTle6Yd80WgTRNxR93YD05Zhy
 Jeb/7zJstSVISMW/AHZIMfzjIPmOnD9MfhA5rKhxfO+5wVn2y6qu82x9HH

Both machines support the necessary WMI methods, so enable fan control
for them.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index e24f5a323f95..05cbe8f96f21 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -466,6 +466,7 @@ static struct quirk_entry quirk_acer_predator_ph16_72 =
=3D {
 	.cpu_fans =3D 1,
 	.gpu_fans =3D 1,
 	.predator_v4 =3D 1,
+	.pwm =3D 1,
 };

 static struct quirk_entry quirk_acer_predator_pt14_51 =3D {
@@ -473,6 +474,7 @@ static struct quirk_entry quirk_acer_predator_pt14_51 =
=3D {
 	.cpu_fans =3D 1,
 	.gpu_fans =3D 1,
 	.predator_v4 =3D 1,
+	.pwm =3D 1,
 };

 static struct quirk_entry quirk_acer_predator_v4 =3D {
=2D-
2.39.5


