Return-Path: <linux-kernel+bounces-196731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6C88D6096
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86461B23D89
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B841615746A;
	Fri, 31 May 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="XTV9YHRk"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4099715575A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154660; cv=none; b=WAjnLxSOZgNxPHtyvYqqvt92e7NhhDsgi6j9INqiQS+sZPSCA9ZwuY5VkmAeFEP94oKmDrAKkvzZAbcjLJ76aRQGuWQUGdIqihAFsqNCts/Z6YxSd9EeHCenEuGDKSU6TRicM4hp9uW2l0gHqthzKuGGf/x6rWfQyYtp0JYO03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154660; c=relaxed/simple;
	bh=TknuzXYSGYBvL4tnZNG0vu3hs7bscxbNbZEVSVBGojs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JV8AhzHzsSKNx/oKfrPLfeD7/h00fKtaQVnI8rAjx8fNpbfUqtkDHUXERrGLGxwR5fDEzXSYN5lR6WSfKyMTgfWiD/LgoFkYxQY6W4ZA4taK5zeUdQBpVcJ307hQtyaZ/30u/EIJs7HawULsauPOUfLP8kPc08LL/M7wCblLdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=XTV9YHRk; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1717154649; x=1717759449; i=christian@heusel.eu;
	bh=NIk0wO5MccgZYUBzv8EbfLQiHFSL8i8W00sI/cWEPdo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XTV9YHRkixZpejmdmVREFxsDyUhhxVaevW90hGzRvz8Sm9cN4B70ScMK9+i+R0/y
	 R8waAaY0kl2M8gzmo7pFQJPhMaxBeMq76PTprCJR4U4jl1CDF0DbmSTwzoC/vA1n9
	 Z4Co1U7fEe5gG473QBnHXYZA672Z496ZWcNhxM3TJ1CPKmkpi1N+jHGiSf9416yje
	 t/JzZaWvkMin9ntpHkO8z2OEUBPbKn3PjqYfNSwPgsS1XjKHKoBBzZYzmRHMs2mja
	 mGn0ya9+mzGHxfTrGmSKpHGFuSBqDmPbfnkNDRZ9FQtCmz/Z1zl6invMw3DbPMz6A
	 6QQPljORyh2rzkAmjw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.chris.vpn.heusel.eu ([141.70.80.5]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MWjQU-1rxdAD1Nk0-00Xy16; Fri, 31 May 2024 13:18:45 +0200
From: Christian Heusel <christian@heusel.eu>
To: Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org
Cc: Christian Heusel <christian@heusel.eu>
Subject: [PATCH RESEND] tools/x86/kcpuid: Add missing dir via Makefile
Date: Fri, 31 May 2024 13:17:58 +0200
Message-ID: <20240531111757.719528-2-christian@heusel.eu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nBRnD6BMmca3It9c8Bq0t0VWMLCyL79OT9OBuq8/jKeWVSqkq/4
 6jvZERsdsbKOifjsERCbnEGKEH5hLuF+8vzIOR8OPRs8g/c/um0uM0Ehgt1buuiXQY5y3CS
 tM7g+pPapAnmCK2EoGvfs2CA+ukgZ3DIZtR5Pgo5BhhBXDAnmMgzAxCgzbquaj5w013tVmt
 DcYLlkaqrp26mUnkNk1xg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bFm4w6UGHcQ=;S7oxE0OWu7MGow4k0PeRCEXIr86
 +6/WBbl3kNg71XUtkBVL0QEaaQC5S8ME/ZRKowGKNs/xEpl6NZcDIAiKrkHJOHTH0fcJbuhja
 lytchSqEvqS8ngCEJ2VfVHbcLK6dFcofoDhSqjZfUjv8MZvXLVV7S8NKQqve5w1yFz316x5PO
 268NIQ+Phvdb8oVEbZusnfsrKdKGeGOGtJy9fvLJ6Dauwh39MhZeq4IdbFqb5V9pC4zhz/9TL
 8uUoJ+Bg09T6L/4gSIh5eQ9e/s6CGIsmVvNRpv2vfqCr+Zg18jnY6ZT4QD/5Sb0gNR5koMuZn
 Z6OW9p+oHs5d/SQLsSWCuYyyuYqql/Brk3otmYBmMmNCOarwaBfKF6lyEsVKL946Jr6e/fRlJ
 qm4NC8fGgpdmJ+aPZVVUdZaRwmeUfr+Lzd2W/ftsOydZzIJ+0WmhP/bxYXFhqqwg+ltNaEghc
 9CTy7M1ZvHxvfzFzo+sQPG5U9iiiGgVyjMZQe1Dh/pl1rHx3VjLDKBYGEVLAqsunez+Mn53qs
 uhXsZCkst2BN4mHjr5C2lDtwZzxPQkf/OFZrVBP1sYB8mhgOzUnpaJPJizQ7MYXfPXJ61psNR
 Jm7KBbaBUfylMID+2C4v3j/bF0OWhqkjzR1emYMa2JvuakoIjgGDtx5lkcU+Ysw6eGmWDtxXt
 US2xIqOB5d55c5Y23v4bZX1o/sfefVWcFaL+jw1LKgezTIjD6u2agt7+Y9hDEWWAevnQfgfvf
 Ow7edo5KAGz6U1fB3A/tH6Z2HFIqBPWShmq3w8rru7asCQhXL5l5Rw=

So far the Makefile just installed the csv into $(HWDATADIR)/cpuid.csv,
which made it unaware about $DESTDIR. Add $DESTDIR to the install
command and while we are at it also create the directory, should it not
exist already. This eases the packaging of kcpuid and allows i.e. for
the install on arch to look like this:

    make BINDIR=3D/usr/bin DESTDIR=3D"$pkgdir" -C tools/arch/x86/kcpuid in=
stall

So far this change is carried as a downstream patch.

Signed-off-by: Christian Heusel <christian@heusel.eu>
=2D--
Resend to add missing linux-kernel@vger.kernel.org to recipients
=2D--
 tools/arch/x86/kcpuid/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/kcpuid/Makefile b/tools/arch/x86/kcpuid/Makefi=
le
index 87b554fab14b8..d0b4b0ed10ff9 100644
=2D-- a/tools/arch/x86/kcpuid/Makefile
+++ b/tools/arch/x86/kcpuid/Makefile
@@ -19,6 +19,6 @@ clean :
 	@rm -f kcpuid

 install : kcpuid
-	install -d  $(DESTDIR)$(BINDIR)
+	install -d  $(DESTDIR)$(BINDIR) $(DESTDIR)$(HWDATADIR)
 	install -m 755 -p kcpuid $(DESTDIR)$(BINDIR)/kcpuid
-	install -m 444 -p cpuid.csv $(HWDATADIR)/cpuid.csv
+	install -m 444 -p cpuid.csv $(DESTDIR)$(HWDATADIR)/cpuid.csv
=2D-
2.45.1


