Return-Path: <linux-kernel+bounces-176109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B68C2A03
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5696FB240C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C40446AB;
	Fri, 10 May 2024 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="Gt5Q9ctk"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DB1C6B8;
	Fri, 10 May 2024 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366446; cv=none; b=UOesS8i19DTi4xhzwM6NogYYD8xwB0O9GE0HR8NPMfpc3OpjyEG5qfV/l+WimgqqWk2OI92CYS4uPNQdwhKbH2NMM8D758mYb0UwGLC/0ANKPkieKLx4vq65pU5xgo6Ef+sXP6nWqQhPjBGdy+/6ebhXjA900i9pTjmSL6yxHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366446; c=relaxed/simple;
	bh=Xzgcufd0pJTHG1iaxME/sHPKeVgiA1NchX1LnWT07kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ingwbGzTEUR3cGR10Y/sZ9mvdieOu1p/zfWdJ6/k2BZ756Yf68r7EtFyE5bI9O+FrJHC2aL7jdG+8K5EjWRa6YskR1R/Jbt9IgTroZWGBe0N3Nm85LEIeZsazfKG8NnNPKDenqt6X/5LTc8hR3auZwqSmg94d5rgfpfTr47r9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=Gt5Q9ctk; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1715366412; x=1716666412;
	bh=HFAYz3DEk0hz8RQyydYwTFdHGtJdepWvGheXpKrS6mA=; h=From;
	b=Gt5Q9ctk/yCLtnnNCXxMeDNVb/ziwIQjPUg6SwsM2P8x16EHKpNzh5TMyh4i20ah+
	 2FLGSEWi4IA/hQWekOK4RjccImfHoaHbID6lK5d6aCabstHCgV2zDUSAmy3Mjuj/dp
	 VDruFWT7NBrolE1WBzuPkywio0xFQiUPEFpz85PyddtnpVCrJt7c0FAxJAETvNhPtm
	 8ecska5//gV1C2Q3KsmNQwkACiLQu3kb23sLNdAYA9XgVnyWZvU5Hx3aAB4kYJHwQM
	 RGizFtSFJ7PgM9W93DIwQ6dTT1CkblYIvlZ9Uv4Gi6tOP+JyLCgHb7OdZBsenyDRty
	 oVAufun+Tb/MQ==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 44AIe9si016816
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 20:40:10 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet <corbet@lwn.net>,
        regressions@lists.linux.dev, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: balejk@matfyz.cz
Subject: [PATCH docs-next v2] docs: handling-regressions.rst: recommend using "Closes:" tags
Date: Fri, 10 May 2024 20:34:41 +0200
Message-ID: <20240510183748.13028-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the handling-regressions guide to recommend using "Closes:" tags
rather than "Link:" when referencing fixed reports. The latter was used
originally but now is only recommended when the given patch only fixes
part of the issue, as described in submitting-patches. Briefly mention
that and also note that regzbot currently doesn't make a distinction.

Also fix a typo.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v2:
    - v1: https://lore.kernel.org/r/20240328194342.11760-1-balejk@matfyz.cz/
    - Rebase to git://git.lwn.net/linux.git docs-next.
    - Prefer Closes: tags, mention that regzbot makes no distinction and
      only mention Link: briefly and explain when it's preferred, in
      accordance with submitting-patches.
    - Include a typo fix.
    - Reword commit message accordingly (and make it less verbose :-).

 .../process/handling-regressions.rst          | 32 ++++++++++++-------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index 49ba1410cfce..c162748f5ec9 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -40,10 +40,13 @@ The important bits (aka "The TL;DR")
        #regzbot from: Some N. Ice Human <some.human@example.com>
        #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
 
-#. When submitting fixes for regressions, add "Link:" tags to the patch
+#. When submitting fixes for regressions, add "Closes:" tags to the patch
    description pointing to all places where the issue was reported, as
    mandated by Documentation/process/submitting-patches.rst and
-   :ref:`Documentation/process/5.Posting.rst <development_posting>`.
+   :ref:`Documentation/process/5.Posting.rst <development_posting>`. If you are
+   only fixing part of the issue that caused the regression, you may use
+   "Link:" tags instead. regzbot currently makes no distinction between the
+   two.
 
 #. Try to fix regressions quickly once the culprit has been identified; fixes
    for most regressions should be merged within two weeks, but some need to be
@@ -91,10 +94,10 @@ When doing either, consider making the Linux kernel regression tracking bot
    Note the caret (^) before the "introduced": it tells regzbot to treat the
    parent mail (the one you reply to) as the initial report for the regression
    you want to see tracked; that's important, as regzbot will later look out
-   for patches with "Link:" tags pointing to the report in the archives on
+   for patches with "Closes:" tags pointing to the report in the archives on
    lore.kernel.org.
 
- * When forwarding a regressions reported to a bug tracker, include a paragraph
+ * When forwarding a regression reported to a bug tracker, include a paragraph
    with these regzbot commands::
 
        #regzbot introduced: 1f2e3d4c5b6a
@@ -102,7 +105,7 @@ When doing either, consider making the Linux kernel regression tracking bot
        #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
 
    Regzbot will then automatically associate patches with the report that
-   contain "Link:" tags pointing to your mail or the mentioned ticket.
+   contain "Closes:" tags pointing to your mail or the mentioned ticket.
 
 What's important when fixing regressions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -112,10 +115,16 @@ remember to do what Documentation/process/submitting-patches.rst,
 :ref:`Documentation/process/5.Posting.rst <development_posting>`, and
 Documentation/process/stable-kernel-rules.rst already explain in more detail:
 
- * Point to all places where the issue was reported using "Link:" tags::
+ * Point to all places where the issue was reported using "Closes:" tags::
 
-       Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
-       Link: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890
+       Closes: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+       Closes: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890
+
+   If you are only fixing part of the issue, you may use "Link:" instead as
+   described in the first document mentioned above. Some maintainers may even
+   prefer it over "Closes:" entirely, although the latter is generally
+   recommended. regzbot currently treats both of these equivalently and
+   considers the linked reports as resolved.
 
  * Add a "Fixes:" tag to specify the commit causing the regression.
 
@@ -126,7 +135,7 @@ All this is expected from you and important when it comes to regression, as
 these tags are of great value for everyone (you included) that might be looking
 into the issue weeks, months, or years later. These tags are also crucial for
 tools and scripts used by other kernel developers or Linux distributions; one of
-these tools is regzbot, which heavily relies on the "Link:" tags to associate
+these tools is regzbot, which heavily relies on the "Closes:" tags to associate
 reports for regression with changes resolving them.
 
 Expectations and best practices for fixing regressions
@@ -326,7 +335,7 @@ How does regression tracking work with regzbot?
 
 The bot watches for replies to reports of tracked regressions. Additionally,
 it's looking out for posted or committed patches referencing such reports
-with "Link:" tags; replies to such patch postings are tracked as well.
+with "Closes:" tags; replies to such patch postings are tracked as well.
 Combined this data provides good insights into the current state of the fixing
 process.
 
@@ -338,8 +347,7 @@ take care of that using ``#regzbot ^introduced``.
 
 For developers there normally is no extra work involved, they just need to make
 sure to do something that was expected long before regzbot came to light: add
-"Link:" tags to the patch description pointing to all reports about the issue
-fixed.
+links to the patch description pointing to all reports about the issue fixed.
 
 Do I have to use regzbot?
 ~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.45.0


