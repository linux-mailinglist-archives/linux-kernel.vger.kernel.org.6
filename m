Return-Path: <linux-kernel+bounces-353372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60205992CFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE481F2242F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B341D415D;
	Mon,  7 Oct 2024 13:18:11 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC511D3640
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307091; cv=none; b=ESlJRjAmTCuFTyUbFzC3v/xtiJXwj07AwpjUzjqaQoh91LCinVzX2f80nN1RLs/xXfF3aS6X7IlypND1aCis8W0G5P6muox764xfVUl6Ssl4wOdCLQ5jJiQywhS0MRYxzZqw5VHiAjEQ+l0pQJiJ0g0cGIXDWvVdHSMYFQm0rQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307091; c=relaxed/simple;
	bh=AvC/epgbdUZDYDG4i2i/mkrU7FGOmp/igeJcNdw5xeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVGLvIV8CpTCcXvEZM1dN638DWq0xkDangcnozCP4iysT6LcKcMlB0V9f2IUn+ihjpDFON4rKKa29vbGIuRrCpw9ANoV+Xl6nbPRhV5j4JpE1OYQHasycntbYZI/8GfWhixIANNB5E0yo1Ryglv2BTZn2pll+QKxrVaLZva0I6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id DE2925F863;
	Mon,  7 Oct 2024 15:11:40 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Yuntao Liu <liuyuntao12@huawei.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm32: simplify ARM_MMU_KEEP usage
Date: Mon, 07 Oct 2024 15:11:40 +0200
Message-ID: <2200295.irdbgypaU6@devpool47.emlix.com>
Organization: emlix GmbH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

All current users need to add a KEEP() around the argument so the value is
actually kept, which doesn't feel very natural and is prone to upcoming bug=
s as
the name suggests that this macro alone already keeps things. Move that dir=
ectly
into the definition.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
I'm unsure if ARM_MMU_DISCARD() needs the same treatment for the non-MMU ca=
se.
I suspect noone has tried dead code elimination for non-MMU?

 arch/arm/include/asm/vmlinux.lds.h | 2 +-
 arch/arm/kernel/vmlinux-xip.lds.S  | 2 +-
 arch/arm/kernel/vmlinux.lds.S      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmli=
nux.lds.h
index d60f6e83a9f7..89697f204715 100644
=2D-- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -19,7 +19,7 @@
 #endif
=20
 #ifdef CONFIG_MMU
=2D#define ARM_MMU_KEEP(x)		x
+#define ARM_MMU_KEEP(x)		KEEP(x)
 #define ARM_MMU_DISCARD(x)
 #else
 #define ARM_MMU_KEEP(x)
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xi=
p.lds.S
index 5eddb75a7174..f2e8d4fac068 100644
=2D-- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -63,7 +63,7 @@ SECTIONS
 	. =3D ALIGN(4);
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table =3D .;
=2D		ARM_MMU_KEEP(KEEP(*(__ex_table)))
+		ARM_MMU_KEEP(*(__ex_table))
 		__stop___ex_table =3D .;
 	}
=20
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index de373c6c2ae8..d592a203f9c6 100644
=2D-- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -74,7 +74,7 @@ SECTIONS
 	. =3D ALIGN(4);
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table =3D .;
=2D		ARM_MMU_KEEP(KEEP(*(__ex_table)))
+		ARM_MMU_KEEP(*(__ex_table))
 		__stop___ex_table =3D .;
 	}
=20
=2D-=20
2.46.1


=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner



