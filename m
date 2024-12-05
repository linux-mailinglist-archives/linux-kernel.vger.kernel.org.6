Return-Path: <linux-kernel+bounces-433864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E619E5E21
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA38B288562
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE1229B2B;
	Thu,  5 Dec 2024 18:17:02 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266E226EEF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422621; cv=none; b=dBLdyTmNfTP4BhGx8EvLoBcuT6kXh66RWQLn9EBx+Yqqid2rythETJgKork0vPB0wh1IQzB/hyy9nAxkVXhEiP7LmQANa9V+kCQzTZM5koEACsMp+elYxhlThX0u1aWRz3f3v4bn96OknohYy4U6UErTE06vvk4mS4/3TIqAi9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422621; c=relaxed/simple;
	bh=HU3fKEdq+X4pMf6Fx9ukcIrk60Bkr1nGBpu5sND+6i8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZTiyO1kzHNzwibLsIZdxfPea13fZdJxDnG6RZLGI65fdxIiJMoZdINsLgEgT6zj5OwgFHcYuvrlnd1V1vtZsgg4606/JZCN85Pcx2k14DQF3QxwnVBx3ciJJbVn/8QA60aoCSg6koo6asp5d365RpJSuk5SA+xBaGhjOiuHGEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b16a:6561:fa1:2b32])
	by albert.telenet-ops.be with cmsmtp
	id l6Gf2D00B3EEtj2066GftC; Thu, 05 Dec 2024 19:16:47 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJGP0-000LwW-9d;
	Thu, 05 Dec 2024 19:16:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJGP1-00EUTQ-0L;
	Thu, 05 Dec 2024 19:16:39 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Andy Whitcroft <apw@canonical.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
	Simon Horman <horms@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] Align and increase git commit ID abbreviation guidelines and checks
Date: Thu,  5 Dec 2024 19:16:33 +0100
Message-Id: <cover.1733421037.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series:
  - Aligns the documentation and checks to settle on a mininum of 12
    characters for git commit ID abbreviations, so larger abbreviations
    are no longer flagged as a warning by checkpatch.pl,
  - Increase the minimum recommended abbreviation to 16 characters.

The Linux kernel repository is growing fast.  Running
git-unique-abbrev[1] on a tree containing v6.13-rc1 and all stable
releases gives:

    13021585 objects
     4: 13021585 / 65536
     5: 13021519 / 1048507
     6: 7028382 / 3064402
     7: 616474 / 305777
     8: 39566 / 19775
     9: 2452 / 1226
    10: 186 / 93
    11: 12 / 6
    12: 0 / 0
    21cf4d54d3c702ac20c6747fa6d4f64dee07dd11
    21cf4d54d3ced8a3e752030e483d72997721076d
    8a048bbf89528d45c604aed68f7e0f0ef957067d
    8a048bbf895b1359e4a33b779ea6d7386cfe4de2
    c8db0fc796454553647e11a055eed4e46676e3ed
    c8db0fc7964a2c9394c17722f30e4f1420aaa8e0
    d3ac4e475103c4364ecb47a6a55c114d7c42a014
    d3ac4e47510ec0753ebe1e418a334ad202784aa8
    d597639e2036f04f0226761e2d818b31f2db7820
    d597639e203a100156501df8a0756fd09573e2de
    ef91b6e893a00d903400f8e1303efc4d52b710af
    ef91b6e893afc4c4ca488453ea9f19ced5fa5861

13021585 is still smaller than sqrt(16^12) = 16777216, but the safety
margin is getting smaller.  E.g. my main work repo already contains +19M
objects.  Hence the Birthday Paradox states that collisions of
12-character commit IDs are imminent.

Fortunately, git is smart: when the number of configured characters for
abbreviations (using core.abbrev, or --abbrev) is too small, git
automatically prints a larger hash.  Obviously this only takes into
account the repository of the creator, and not the (possibly much
larger) repository of the receiver.
Due to this, patches with 13-char Fixes tags have already been seen in
the wild[2].  Unfortunately such patches are currently flagged by
checkpatch.pl (and sometimes even rejected), despite some parts of the
documentation stating that "at least 12 characters" is fine.  FTR, I've
been using 16-characters commit IDs for quite a while.

Hence the first patch settles on "at least 12 chars" everywhere.
The second patch increases the minimum to 16 characters, to reduce the
risk of conflicts, now and in the near future.

Note that we standardized on 12 chars in commit d311cd44545f2f69
("checkpatch: add test for commit id formatting style in commit log") in
v3.17, when the repo had just surpassed 4M objects.  Going to 16 chars
should provide enough headroom until after my official retirement ;-)

Note that I did not update Documentation/translations/.

Changes compared to v1[3]:
  - Rebase on top of commit 2f07b652384969f5 ("checkpatch: always parse
    orig_commit in fixes tag") in v6.13-rc1,
  - Update documentation, too,
  - New patch to increase the minimum to 16 characters.

Thanks for your comments!

[1] https://blog.cuviper.com/2013/11/10/how-short-can-git-abbreviate/
[2] https://lore.kernel.org/all/20241009-tamale-revisit-7d2606c5fdf3@spud
[3] "[PATCH] checkpatch: Also accept commit ids with 13-40 chars of sha1"
    https://lore.kernel.org/all/62f82b0308de05f5aab913392049af15d53c777d.1701804489.git.geert+renesas@glider.be/

Geert Uytterhoeven (2):
  Align git commit ID abbreviation guidelines and checks
  Increase minimum git commit ID abbreviation to 16 characters

 Documentation/dev-tools/checkpatch.rst        |  2 +-
 Documentation/doc-guide/sphinx.rst            |  4 +--
 Documentation/process/5.Posting.rst           |  2 +-
 .../process/handling-regressions.rst          |  6 ++--
 Documentation/process/maintainer-tip.rst      |  6 ++--
 Documentation/process/submitting-patches.rst  | 18 ++++++------
 scripts/checkpatch.pl                         | 28 +++++++++----------
 7 files changed, 33 insertions(+), 33 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

