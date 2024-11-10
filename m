Return-Path: <linux-kernel+bounces-403333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791069C3448
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 19:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA73B2815A6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241213D25E;
	Sun, 10 Nov 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="K23TZD1F"
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CDE84D29
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731265094; cv=none; b=Hizq+bPPCfmCmcPtIytxSi/bi6B8Lkf7Y/X9jCHv8lAYckWNqr5fQpLSl26v3BWkXKjT9BR3zI/MDh7xhM5i1hiC3p6DshXJwN53S49guudqKhJtIwzWYWKNaJdT03uuHcNZLbkMitViqMx5aawKUyQliXixoIL8vn+xkbL9J8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731265094; c=relaxed/simple;
	bh=gwNhPkdB4ruEn6kKJNJyb3mDaAE5VeSeNIQnUk2j1vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aafk2V2ZbKXf/+nITPh8Htms8jSmi6NdXsgMAWqwFMGNi6VS2vEFeHBafa2S5IVVURaCj4g8WpLa9tUKexqS68tC5KLiUBHKmt69v1DD5acgCUCAs+0AkNu3OAmu/ckUmsE59bGHimjVjG8V/DCfQ39/pETKHsqvcKhhlPO+MV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=K23TZD1F; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XmhlM1GQ7zSJb;
	Sun, 10 Nov 2024 19:58:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731265087;
	bh=dLQPd5L0DoALOdUi/7m3a7RNhlisSihSXNCjGti09EA=;
	h=From:To:Cc:Subject:Date:From;
	b=K23TZD1FdH4gPv1ljPAngEUDpTcZGdoivT+Q5AQ2HT4dKhoMHlZr6Vvl3Wjf1DvWX
	 xUI/QuNDLzsgp548R1mnA5i6QaQTW/JKQdD98v3W+LRoDrsFHKryhP82YrLQzFdqIJ
	 q9oQDutkwDZpYfiN6quYQAGLiniYpRFfC0kMLW7o=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XmhlL4ky6zk66;
	Sun, 10 Nov 2024 19:58:06 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.12-rc7 #2
Date: Sun, 10 Nov 2024 19:58:04 +0100
Message-ID: <20241110185804.73158-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR fixes issues in the Landlock's sandboxer sample and documentation,
slightly refactors helpers (required for ongoing patch series), and improve/fix
a feature merged in v6.12 (signal and abstract UNIX socket scoping).

Please pull these changes for v6.12-rc7 (or rc8, if any).  These commits merge
cleanly with your master branch.  The kernel code has been tested in the latest
linux-next releases for a few weeks, but I updated the last three patches with
cosmetic changes according to reviews.

Test coverage for security/landlock is 92.5% of 1129 lines according to
gcc/gcov-14, and it was 92.8% of 1134 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.12-rc7

for you to fetch changes up to 03197e40a22c2641a1f9d1744418cd29f4954b83:

  landlock: Optimize scope enforcement (2024-11-09 19:52:13 +0100)

----------------------------------------------------------------
Landlock fix for v6.12-rc7

----------------------------------------------------------------
Daniel Burgener (1):
      landlock: Fix grammar issues in documentation

Matthieu Buffet (3):
      samples/landlock: Fix port parsing in sandboxer
      samples/landlock: Refactor help message
      samples/landlock: Clarify option parsing behaviour

Mickaël Salaün (4):
      landlock: Improve documentation of previous limitations
      landlock: Refactor filesystem access mask management
      landlock: Refactor network access mask management
      landlock: Optimize scope enforcement

 Documentation/security/landlock.rst      |  14 ++--
 Documentation/userspace-api/landlock.rst |  90 ++++++++++++-------------
 samples/landlock/sandboxer.c             | 112 +++++++++++++++++++------------
 security/landlock/fs.c                   |  31 +++------
 security/landlock/net.c                  |  28 ++------
 security/landlock/ruleset.h              |  74 +++++++++++++++++---
 security/landlock/syscalls.c             |   2 +-
 security/landlock/task.c                 |  18 ++++-
 8 files changed, 217 insertions(+), 152 deletions(-)

