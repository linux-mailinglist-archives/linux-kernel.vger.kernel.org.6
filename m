Return-Path: <linux-kernel+bounces-434700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729BC9E69E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2BCC18833E5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB911EC010;
	Fri,  6 Dec 2024 09:15:32 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049E1CD219
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476532; cv=none; b=iEPpAVDzhfmUyv0gGazAVET03gpDh05HFeKvZnR1/a1lRJFveV7iqcj796t8V/4R0IFDdm7vQU1uZM9UgVPDE3Hdmv7T1rFdsRz1g8J52yT0VoxglcC80bhT1gIQHb9OBj9BzY9hc/EJESd09a8lxeB/m5AbaZn7B+E35L5/rpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476532; c=relaxed/simple;
	bh=uxZ4OixpnkybQbSKQU9UWo7BqA8BCXd9Bk+qMBMssiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPHQjtkUY85qtJKgzDLSzobTt1UfG+XxS0zeyLIH0Dhtmi+f0SZztAcwT8RAMTlH2XqPIiBlZqCMDz8DVt+rqiuEnP5MgLgMyrx5t2owxZuVyo7Viiacdo/E0KgDtidiMeXlgmV5YBEEwzXXDZ2tLUXRIrjaxsF88oiGuYO7IEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:9701:674a:6aea:a85b])
	by baptiste.telenet-ops.be with cmsmtp
	id lMFS2D00A0YidY701MFSwW; Fri, 06 Dec 2024 10:15:26 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJUQn-000Opy-Bk;
	Fri, 06 Dec 2024 10:15:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJUQo-00FrDL-2R;
	Fri, 06 Dec 2024 10:15:26 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] coccinelle: of_table: Do not add commas after sentinels
Date: Fri,  6 Dec 2024 10:15:20 +0100
Message-Id: <189628fb0ed7b217fe47f073c7db1e41112622dd.1733475800.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It does not make sense to have a comma after a sentinel, as any new
elements must be added before the sentinel.  Hence do not add the comma
when adding the sentinel.

Include the comma after the previous entry, else it will appear after the
sentinel.

Add a comment to clarify the purpose of the empty element.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a patch I wrote last year.
My original intention was to create a Coccinelle script to remove
commas after sentinels, and annotate them, to automate the creation of
patches like commit 0256b6aeee11d705 ("pinctrl: renesas: Annotate
sentinels in tables").  Unfortunately I could not get that work (blame
it on this being my first experiment with Coccinelle).  Hence I gave up,
and instead settled for adapting the existing script to not add these
commas in the first place...

Known issues:

  1. This generates patches like:

	+	{/* sentinel */}

     while I would prefer to see:

	+	{ /* sentinel */ }

     Is there a way to do that, or should I just post-process the
     generated patches?

  2. If the array contains a "{ NULL }" element, this is still flagged
     as a missing sentinel:

	-	{ NULL }
	+	{ NULL },
	+	{},

     Note that this is a pre-existing issue.
---
 scripts/coccinelle/misc/of_table.cocci | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
index 4693ea7447534144..7ade9766dee89c70 100644
--- a/scripts/coccinelle/misc/of_table.cocci
+++ b/scripts/coccinelle/misc/of_table.cocci
@@ -37,15 +37,14 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
--	}
-+	},
-+	{ }
+	},
++	{ /* sentinel */ }
 };
 |
 struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 	...,
 	{ ..., E, ... },
-+	{ },
++	{ /* sentinel */ }
 };
 )
 
-- 
2.34.1


