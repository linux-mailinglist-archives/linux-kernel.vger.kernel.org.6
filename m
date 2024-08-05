Return-Path: <linux-kernel+bounces-274359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513294774A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA971F21B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5EC14D433;
	Mon,  5 Aug 2024 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="2O40tvta"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B603149C45;
	Mon,  5 Aug 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846450; cv=none; b=jqtxQvIoXh4ZgZbbLyV2PK9ABcgG82PFF7x8QcQcxgGzDF9oDyJ+A6X39Jfg7GGOXrfGuIFfk+9CBWer1ZyfIqjs9097rDMJeV9JywMWiyIHLnuYzRg6GVbobwlRmRR3/fBaloNzwRy6KQzWe7rOVWBT/830Mo/HdxF+pUhVkkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846450; c=relaxed/simple;
	bh=XQduA1yrJcEmZ0MOj0pc8jiP7CVFLf9SEAEfyYpUppY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ekmlqs/E46cYyoWpKQqQouUILZbu1yP/OjuS4v8jRtjspsKUnnxfUTcMe1WyWtLd7HEOcTVqx2rgf/xySmrspS+fuWTMhKOi8mLqOVdirtvHq89f+Ijp+AT0HZHQu9eLFx+0tLKs4Y3HKHtMciBG5TgzTGz9HS9U10Hy41xoKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=2O40tvta; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=11StMB/CHBVgYxZV+/tIFDr6XxButiIMJq6QA32Y3As=; t=1722846448; x=1723278448;
	 b=2O40tvtaeiCKO5kgmm0g2/hDsrPwvLAPViJp5TyoIhFhV3YV3CwN2LiVf/q14NVV1QA7jD10/x
	a6nOm5PMbcyQh4n2SEabbNzFH2PkkSDMcgsOU2Q5DAHECtt7q5qODKlW9QGqoh3O7Jbq3rp/10umX
	fKUbVyMW3sF5Lr2rbiOIdHzUxCGwmAs8gYDWYK/bApRisfFntHAUrvNNkYKkt4ZT9JxqbNJ2wjcXJ
	tjWbwczO98X563lClKmuYX7iU31EqkPDIyRh7fgWv5GYWn4jVkx3DEfmMkFV1TeT+OTLWz4jz/sI7
	D2Z5Zy90BfPolCEjTGqae0steC1gTWliM471A==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1sat3k-00030P-GN; Mon, 05 Aug 2024 10:27:16 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v1] docs: bug-bisect: rewrite to better match the other bisecting text
Date: Mon,  5 Aug 2024 10:27:15 +0200
Message-ID: <10a565e4ebca5e03a2e7abb7ffe1893136471bf9.1722846343.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1722846448;2e1dcc07;
X-HE-SMSGID: 1sat3k-00030P-GN

Rewrite the short document on bisecting kernel bugs. The new text
improves .config handling, brings a mention of 'git skip', and explains
what to do after the bisection finished -- including trying a revert to
verify the result. The rewrite at the same time removes the unrelated
and outdated section on 'Devices not appearing' and replaces some
sentences about bug reporting with a pointer to the document covering
that topic in detail.

This overall brings the approach close to the one in the recently added
text Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.
As those two texts serve a similar purpose for different audiences,
mention that document in the head of this one and outline when the
other might be the better one to follow.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/bug-bisect.rst | 205 +++++++++++++++--------
 MAINTAINERS                              |   1 +
 2 files changed, 135 insertions(+), 71 deletions(-)

diff --git a/Documentation/admin-guide/bug-bisect.rst b/Documentation/admin-guide/bug-bisect.rst
index 325c5d0ed34a0a..f4a9acab65d0f5 100644
--- a/Documentation/admin-guide/bug-bisect.rst
+++ b/Documentation/admin-guide/bug-bisect.rst
@@ -1,76 +1,139 @@
-Bisecting a bug
-+++++++++++++++
-
-Last updated: 28 October 2016
-
-Introduction
-============
-
-Always try the latest kernel from kernel.org and build from source. If you are
-not confident in doing that please report the bug to your distribution vendor
-instead of to a kernel developer.
-
-Finding bugs is not always easy. Have a go though. If you can't find it don't
-give up. Report as much as you have found to the relevant maintainer. See
-MAINTAINERS for who that is for the subsystem you have worked on.
-
-Before you submit a bug report read
-'Documentation/admin-guide/reporting-issues.rst'.
-
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
+.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
+.. [see the bottom of this file for redistribution information]
 
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
+===============
+Bisecting a bug
+===============
 
+This document describes how to find a change causing a kernel regression using
+``git bisect``.
 
-.. [#f1] You can, optionally, provide both good and bad arguments at git
-	 start with ``git bisect start [BAD] [GOOD]``
+The text focuses on the gist of the process. If you are new to bisecting the
+kernel, better follow Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+instead: it depicts everything from start to finish while covering multiple
+aspects even kernel developers occasionally forget. This includes:
 
-For further references, please read:
+- Detecting situations where a bisections would be a waste of time, as nobody
+  would care about the result -- for example, because the problem is triggered
+  by a .config change, was already fixed, is caused by something your Linux
+  distributor changed, occurs in an abandoned version, or happens after the
+  kernel marked itself as 'tainted'.
+- Preparing the .config file using an appropriate kernel while enabling or
+  disabling debug symbols depending on the situation's needs -- while optionally
+  trimming the .config to tremendously reduce the build time per bisection step.
+- For regressions in stable or longterm kernels: checking mainline as well, as
+  the result determines to whom the regression must be reported to.
 
-- The man page for ``git-bisect``
-- `Fighting regressions with git bisect <https://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html>`_
-- `Fully automated bisecting with "git bisect run" <https://lwn.net/Articles/317154>`_
-- `Using Git bisect to figure out when brokenness was introduced <http://webchick.net/node/99>`_
+Neither document describes how to report a regression, as that is covered by
+Documentation/admin-guide/reporting-issues.rst.
+
+Finding the change causing a kernel issue using a bisection
+===========================================================
+
+*Note: the following process assumes you prepared everything for a bisection;
+this includes having a Git clone with the appropriate sources, installing the
+software required to build and install kernels, as well as a .config file stored
+in a safe place (the following example assumes '~/prepared_kernel_.config') to
+use as pristine base at each bisection step.*
+
+* Preparation: start the bisection and tell Git about the points in the history
+  you consider to be working and broken, which Git calls 'good' and 'bad'::
+
+    git bisect start
+    git bisect good v6.0
+    git bisect bad v6.1
+
+  Instead of Git tags like 'v6.0' and 'v6.1' you can specify commit-ids, too.
+
+1. Copy your prepared .config into the build directory and adjust it to the
+   needs of the codebase Git checked out for testing::
+
+     cp ~/prepared_kernel_.config .config
+     make olddefconfig
+
+2. Now build, install, and boot a kernel; if any of this fails for unrelated
+   reasons, run ``git bisect skip`` and go back to step 1.
+
+3. Check if the feature that regressed works in the kernel you just built.
+
+   If it does, execute::
+
+     git bisect good
+
+   If it does not, run::
+
+     git bisect bad
+
+   Be sure what you tell Git is correct, as getting this wrong just once will
+   send the rest of the bisection totally off course.
+
+   Go back to back to step 1, if Git after issuing one of those commands checks
+   out another bisection point while printing something like 'Bisecting:
+   675 revisions left to test after this (roughly 10 steps)'.
+
+   You finished the bisection and move to the next point below, if Git instead
+   prints something like 'cafecaca0c0dacafecaca0c0dacafecaca0c0da is the first
+   bad commit'; right afterwards it will show some details about the culprit
+   including its patch description. The latter can easily fill your terminal,
+   so you might need to scroll up to see the message mentioning the culprit's
+   commit-id; alternatively, run ``git bisect log`` to show the result.
+
+* Recommended complementary task: put the bisection log and the current
+  .config file aside for the bug report; furthermore tell Git to reset the
+  sources to the state before the bisection::
+
+     git bisect log > ~/bisection-log
+     cp .config ~/bisection-config-culprit
+     git bisect reset
+
+* Recommended optional task: try reverting the culprit on top of the latest
+  codebase; if successful, this will validate your bisection and enable
+  developers to resolve the regression through a revert.
+
+  To try this, update your clone and check out latest mainline. Then tell Git to
+  revert the change::
+
+     git revert --no-edit cafec0cacaca0
+
+  This might be impossible, for example when the bisection landed on a merge
+  commit. In that case, abandon the attempt. Do the same, if Git fails to revert
+  the culprit because later changes depend on it -- unless you bisected using a
+  stable or longterm kernel series, in which case you want to retry using the
+  latest code from that series.
+
+  If a revert succeeds, build and test another kernel to validate the result of
+  the bisection. Mention the outcome in your bug report.
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


