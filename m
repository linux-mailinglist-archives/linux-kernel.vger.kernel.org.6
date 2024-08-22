Return-Path: <linux-kernel+bounces-296808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B595AF66
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E8C1C217EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C041537BF;
	Thu, 22 Aug 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SKYRa6G5"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424FA933;
	Thu, 22 Aug 2024 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312141; cv=none; b=nyMGDgWkVtNr4GBAGJ9wi8vXI9UhUxjBKYVm/1ddbfcQYgDIEAM6gG9iGzETQI8hmJFwYHzkvQj85goQSrYPrmjh4YpBcdCz10FCx+PgS23GnbNQD6oxqzrCecdpo0xcU65YT/2HV3uyXFJ+LHhumAdfHbWlZT+jhHRhWNfr6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312141; c=relaxed/simple;
	bh=zoaoChsEMLtL7kUrFXaDHXOdFyUI+KQJ+Nlmx16QznA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1k5UP1GlglAv4G0XbS270yqF8Dz09kuVwOciyE6mg3mXXN3QHQmt3JJV90ZZNkFrDoadEZydXOmR8OKXwjrzOCuG225tgknnWkY7hJsHneXliSBCL6V+3/rjw2xY4AP5Jr4SrF/BUkXTdaDZdV7ARuCWYLXQNP/Bsg9RddhYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SKYRa6G5; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jzvY1/+ed7pIuhUW1Gu/HKcJVU6D3qMKWWOJhGvZ5lI=; t=1724312139; x=1724744139;
	 b=SKYRa6G5f86UkM4l0nkYBzzPnKjTGBxRuV3WV4Rp/VV411qftmLhjTb3JeHNfLPjEX0D+OmpDV
	zcrbzghDRceEa+U3maSIPnRB41dxGgm3dPnFik5aa48NmAL9/qc8Ja35HZb8iSSycR34Vbp4IuMBM
	AK+abHezeXwSdeKSYI3qx5yr5PBCpvFumhuv2r/quCTdE5++mnR9F0zN2/yQvNin/YXyeBB7oK76x
	l04LuJaRRLeqRNZ9SyCmDK7SlsNEWMvJz7zXRMOVS0iDfBl5NCwK7mEAoQov+iv8N1TYDvnOIkVSM
	GAzpIJz2rw24hCALKJ6ERkn3janOn3AK5t3PA==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1sh2M1-000826-Uc; Thu, 22 Aug 2024 09:35:34 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v3] docs: bug-bisect: rewrite to better match the other bisecting text
Date: Thu, 22 Aug 2024 09:35:33 +0200
Message-ID: <74dc0137dcc3e2c05648e885a7bc31ffd39a0890.1724312119.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1724312139;78e5f5c4;
X-HE-SMSGID: 1sh2M1-000826-Uc

Rewrite the short document on bisecting kernel bugs. The new text
improves .config handling, brings a mention of 'git bisect skip', and
explains what to do after the bisection finished -- including trying a
revert to verify the result. The rewrite at the same time removes the
unrelated and outdated section on 'Devices not appearing' and replaces
some sentences about bug reporting with a pointer to the document
covering that topic in detail.

This overall brings the approach close to the one in the recently added
text Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.
As those two texts serve a similar purpose for different audiences,
mention that document in the head of this one and outline when the
other might be the better one to follow.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
v3: (this version)
- incorporate a few minor changes after review feedback from Petr

v2: https://lore.kernel.org/all/fbeae4056ae8174f454c3865bc45633281bb1b31.1723997526.git.linux@leemhuis.info/
- incorporate review feedback from Jonathan
- rename to 'Bisecting a regression'

v1: https://lore.kernel.org/all/10a565e4ebca5e03a2e7abb7ffe1893136471bf9.1722846343.git.linux@leemhuis.info/
- initial version
---
 Documentation/admin-guide/bug-bisect.rst | 208 +++++++++++++++--------
 MAINTAINERS                              |   1 +
 2 files changed, 139 insertions(+), 70 deletions(-)

diff --git a/Documentation/admin-guide/bug-bisect.rst b/Documentation/admin-guide/bug-bisect.rst
index 325c5d0ed34a0a..585630d14581c7 100644
--- a/Documentation/admin-guide/bug-bisect.rst
+++ b/Documentation/admin-guide/bug-bisect.rst
@@ -1,76 +1,144 @@
-Bisecting a bug
-+++++++++++++++
+.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
+.. [see the bottom of this file for redistribution information]
 
-Last updated: 28 October 2016
+======================
+Bisecting a regression
+======================
 
-Introduction
-============
+This document describes how to use a ``git bisect`` to find the source code
+change that broke something -- for example when some functionality stopped
+working after upgrading from Linux 6.0 to 6.1.
 
-Always try the latest kernel from kernel.org and build from source. If you are
-not confident in doing that please report the bug to your distribution vendor
-instead of to a kernel developer.
+The text focuses on the gist of the process. If you are new to bisecting the
+kernel, better follow Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+instead: it depicts everything from start to finish while covering multiple
+aspects even kernel developers occasionally forget. This includes detecting
+situations early where a bisection would be a waste of time, as nobody would
+care about the result -- for example, because the problem happens after the
+kernel marked itself as 'tainted', occurs in an abandoned version, was already
+fixed, or is caused by a .config change you or your Linux distributor performed.
 
-Finding bugs is not always easy. Have a go though. If you can't find it don't
-give up. Report as much as you have found to the relevant maintainer. See
-MAINTAINERS for who that is for the subsystem you have worked on.
+Finding the change causing a kernel issue using a bisection
+===========================================================
 
-Before you submit a bug report read
-'Documentation/admin-guide/reporting-issues.rst'.
+*Note: the following process assumes you prepared everything for a bisection.
+This includes having a Git clone with the appropriate sources, installing the
+software required to build and install kernels, as well as a .config file stored
+in a safe place (the following example assumes '~/prepared_kernel_.config') to
+use as pristine base at each bisection step; ideally, you have also worked out
+a fully reliable and straight-forward way to reproduce the regression, too.*
 
-Devices not appearing
-=====================
-
-Often this is caused by udev/systemd. Check that first before blaming it
-on the kernel.
-
-Finding patch that caused a bug
-===============================
-
-Using the provided tools with ``git`` makes finding bugs easy provided the bug
-is reproducible.
-
-Steps to do it:
-
-- build the Kernel from its git source
-- start bisect with [#f1]_::
-
-	$ git bisect start
-
-- mark the broken changeset with::
-
-	$ git bisect bad [commit]
-
-- mark a changeset where the code is known to work with::
-
-	$ git bisect good [commit]
-
-- rebuild the Kernel and test
-- interact with git bisect by using either::
-
-	$ git bisect good
-
-  or::
-
-	$ git bisect bad
-
-  depending if the bug happened on the changeset you're testing
-- After some interactions, git bisect will give you the changeset that
-  likely caused the bug.
-
-- For example, if you know that the current version is bad, and version
-  4.8 is good, you could do::
-
-           $ git bisect start
-           $ git bisect bad                 # Current version is bad
-           $ git bisect good v4.8
-
-
-.. [#f1] You can, optionally, provide both good and bad arguments at git
-	 start with ``git bisect start [BAD] [GOOD]``
-
-For further references, please read:
-
-- The man page for ``git-bisect``
-- `Fighting regressions with git bisect <https://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html>`_
-- `Fully automated bisecting with "git bisect run" <https://lwn.net/Articles/317154>`_
-- `Using Git bisect to figure out when brokenness was introduced <http://webchick.net/node/99>`_
+* Preparation: start the bisection and tell Git about the points in the history
+  you consider to be working and broken, which Git calls 'good' and 'bad'::
+
+     git bisect start
+     git bisect good v6.0
+     git bisect bad v6.1
+
+  Instead of Git tags like 'v6.0' and 'v6.1' you can specify commit-ids, too.
+
+1. Copy your prepared .config into the build directory and adjust it to the
+   needs of the codebase Git checked out for testing::
+
+     cp ~/prepared_kernel_.config .config
+     make olddefconfig
+
+2. Now build, install, and boot a kernel. This might fail for unrelated reasons,
+   for example, when a compile error happens at the current stage of the
+   bisection a later change resolves. In such cases run ``git bisect skip`` and
+   go back to step 1.
+
+3. Check if the functionality that regressed works in the kernel you just built.
+
+   If it works, execute::
+
+     git bisect good
+
+   If it is broken, run::
+
+     git bisect bad
+
+   Note, getting this wrong just once will send the rest of the bisection
+   totally off course. To prevent having to start anew later you thus want to
+   ensure what you tell Git is correct; it is thus often wise to spend a few
+   minutes more on testing in case your reproducer is unreliable.
+
+   After issuing one of these two commands, Git will usually check out another
+   bisection point and print something like 'Bisecting: 675 revisions left to
+   test after this (roughly 10 steps)'. In that case go back to step 1.
+
+   If Git instead prints something like 'cafecaca0c0dacafecaca0c0dacafecaca0c0da
+   is the first bad commit', then you have finished the bisection. In that case
+   move to the next point below. Note, right after displaying that line Git will
+   show some details about the culprit including its patch description; this can
+   easily fill your terminal, so you might need to scroll up to see the message
+   mentioning the culprit's commit-id.
+
+   In case you missed Git's output, you can always run ``git bisect log`` to
+   print the status: it will show how many steps remain or mention the result of
+   the bisection.
+
+* Recommended complementary task: put the bisection log and the current .config
+  file aside for the bug report; furthermore tell Git to reset the sources to
+  the state before the bisection::
+
+     git bisect log > ~/bisection-log
+     cp .config ~/bisection-config-culprit
+     git bisect reset
+
+* Recommended optional task: try reverting the culprit on top of the latest
+  codebase and check if that fixes your bug; if that is the case, it validates
+  the bisection and enables developers to resolve the regression through a
+  revert.
+
+  To try this, update your clone and check out latest mainline. Then tell Git
+  to revert the change by specifying its commit-id::
+
+     git revert --no-edit cafec0cacaca0
+
+  Git might reject this, for example when the bisection landed on a merge
+  commit. In that case, abandon the attempt. Do the same, if Git fails to revert
+  the culprit on its own because later changes depend on it -- at least unless
+  you bisected a stable or longterm kernel series, in which case you want to
+  check out its latest codebase and try a revert there.
+
+  If a revert succeeds, build and test another kernel to check if reverting
+  resolved your regression.
+
+With that the process is complete. Now report the regression as described by
+Documentation/admin-guide/reporting-issues.rst.
+
+
+Additional reading material
+---------------------------
+
+* The `man page for 'git bisect' <https://git-scm.com/docs/git-bisect>`_ and
+  `fighting regressions with 'git bisect' <https://git-scm.com/docs/git-bisect-lk2009.html>`_
+  in the Git documentation.
+* `Working with git bisect <https://nathanchance.dev/posts/working-with-git-bisect/>`_
+  from kernel developer Nathan Chancellor.
+* `Using Git bisect to figure out when brokenness was introduced <http://webchick.net/node/99>`_.
+* `Fully automated bisecting with 'git bisect run' <https://lwn.net/Articles/317154>`_.
+
+..
+   end-of-content
+..
+   This document is maintained by Thorsten Leemhuis <linux@leemhuis.info>. If
+   you spot a typo or small mistake, feel free to let him know directly and
+   he'll fix it. You are free to do the same in a mostly informal way if you
+   want to contribute changes to the text -- but for copyright reasons please CC
+   linux-doc@vger.kernel.org and 'sign-off' your contribution as
+   Documentation/process/submitting-patches.rst explains in the section 'Sign
+   your work - the Developer's Certificate of Origin'.
+..
+   This text is available under GPL-2.0+ or CC-BY-4.0, as stated at the top
+   of the file. If you want to distribute this text under CC-BY-4.0 only,
+   please use 'The Linux kernel development community' for author attribution
+   and link this as source:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/bug-bisect.rst
+
+..
+   Note: Only the content of this RST file as found in the Linux kernel sources
+   is available under CC-BY-4.0, as versions of this text that were processed
+   (for example by the kernel's build system) might contain content taken from
+   files which use a more restrictive license.
diff --git a/MAINTAINERS b/MAINTAINERS
index b34385f2e46d92..90c8681d4d311c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6719,6 +6719,7 @@ DOCUMENTATION REPORTING ISSUES
 M:	Thorsten Leemhuis <linux@leemhuis.info>
 L:	linux-doc@vger.kernel.org
 S:	Maintained
+F:	Documentation/admin-guide/bug-bisect.rst
 F:	Documentation/admin-guide/quickly-build-trimmed-linux.rst
 F:	Documentation/admin-guide/reporting-issues.rst
 F:	Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst

base-commit: 8663dd38a7ba5b2bfd2c7b4271e6e63bc0ef1e42
-- 
2.45.0


