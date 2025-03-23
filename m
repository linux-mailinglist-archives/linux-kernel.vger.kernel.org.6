Return-Path: <linux-kernel+bounces-572961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E122DA6D0D4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F55416EADF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE04019D093;
	Sun, 23 Mar 2025 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QR84Nsil"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD74C8F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742758786; cv=none; b=NGoYzZfAPGpRXLr6t99dbgGNZJmdk9ujP9enD8ONUz03mkRNsmfSsEO3PWD+cXW1xEQXzgLjyxBa6JuZvkrbAFK/J1/S4CVY6O4PDurzlGGqQHwHuy6CLEFRUmIUHTojn0ayrDRdJ1JFO0sSE4puxKDSj8Xa7Hj3UhkeXnEcA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742758786; c=relaxed/simple;
	bh=C5M9FZxGke4NbdCrsCnEAwe8igTxj8Rkhg3YFuac+xY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=VL19ky1uOJIqWMwQqH4Mu0GegVBXFV4PiTFfhkJ7gZXIZ2crQCLrP7UwOGGqEY0bGpzl84pzkkrjDfm+ZyDtzl4GBO8CVMtMo74tC2jWAaJ0Y4zt8ywRUsM+3Jq18GIBODC+uhAcBvJ8cGPLyLU3bsgNY0hh/1/MDQpHOBQ8XNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QR84Nsil; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8ec399427so29974396d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742758783; x=1743363583; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/9M2NmeSWUFErM1HWVWZj3fEsB3g8mWCeObHDD8N58=;
        b=QR84NsilarWnf2npCDsjB8L774soPwubXBJOsMHjVOStPDs24nsKXzkayc8xhgTKTd
         owE4HK57GdOjX+pUR0bkWHcypiT3Vbtc+Lbtna9kj6QYuWaf3qWbNO1ZvzFOMfoZZ3Uc
         fQpRcCgMakJBtMB44UC/C0zbvrNyKRJcsO3+oRWOG3+BeioMcJVhMWWMAU25CtVRY2af
         DUHutTGKPSucvaaaUrxoa0+EAorrxAXSoQXRE8H/GvckkWqP6Fyr/MUBEfF+sjig648W
         GOr2zSE6fM1JvjyVmvxGK1Gp71n712WXfxpuRlCEFXak5RvTBDgMVCZLwW8IW2zy+4sM
         eGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742758783; x=1743363583;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/9M2NmeSWUFErM1HWVWZj3fEsB3g8mWCeObHDD8N58=;
        b=pg1Co/5+3r5UuaJIKsdoNZJAnwNvPphiDOsRjd6tfRmNdAkYd0HYuTJ4gA8ppcxtGt
         1/3cLOgzm8IAdvDk5BL9Yw6SZD3VLV7DgrcLRXtHFg9vmvKUhCFPCD8ijC9GWsx0b8x4
         zmQoKJVAZ8RztkW2h8Y7sLq3ZJQU072B0P3ZhZRBGM7urEQknEPc+vs/kba6HmoPe7h5
         BE3379U5Cvtmdk21TPlMXhVAXZMuS7M+T5wMZy3meJmbq8IH/fBx779INki9+IYjS7/M
         /urQr0S/eby+fg+x8T2MMYRUp1e5JGa/axUvsG8vlTvKhO4IgCzEa5bVl5h1hdRmK3yt
         Ruww==
X-Forwarded-Encrypted: i=1; AJvYcCWdGZP476myyE37Og/rj/nlstNNyoSSLTzAtrJOBaBW9xOxPJaOZrjiGZMbRoqCvLxexchqKGK9GNiBJMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAdGnllA4qhxEDaJ0NRqO3fXoQpPNM28CBHnk7u1364UsxObPC
	Mgc0Um4z7bKknfCivBa07y+BgSrG2q0NnFZpr3JOQR3KgBdEz9MDuhY1Kio6oQj7mIcbG7WFPLU
	=
X-Gm-Gg: ASbGnctFtLI6COTPTpQwk5wk/m/ntXKBchm+1ZLSyTIIYoHR8zgHYWsd+6Cm8B9w3KJ
	dgp8V7zYWW/+75gzTPKJP7eZnLrchUjBEMj8uzXoKfx2vojSWhSmqW8nOuYfz14tEkKpYrrrmxs
	S/9wnbzkJtz8MqoxnAEO+2zxqCnKs8L1qwfz0Bz4tVvlbqUAat5BGGczEWlzVd8GeRPELCVXLbu
	XcNNPDLzUDWZhW2eQHqo4vodBUuAXq+heEqjrl+WGmPKDivphmRu2YuYNuavChRUaJrQylLnryl
	mzNuBlIXZuiyJTMLM8XW4UGeBfSf4nOUFhcDyYexui13o1L5N4L77x0iuywuUQLWvIkY/KKSrbq
	BqDY/P+c7MTB/UQ==
X-Google-Smtp-Source: AGHT+IHahVX7B5lRciT5ZQupqUnDxS9OGp3103z9xfJu3fR8xW0gMUGFEgUXjuKJoEJI/iSxu93o+A==
X-Received: by 2002:a05:6214:2a4f:b0:6e4:7307:51c6 with SMTP id 6a1803df08f44-6eb3f35b4fcmr155940236d6.34.1742758783513;
        Sun, 23 Mar 2025 12:39:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef1f5d8sm34480356d6.45.2025.03.23.12.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 12:39:42 -0700 (PDT)
Date: Sun, 23 Mar 2025 15:39:42 -0400
Message-ID: <795b758412f3cb7dc64777a6fde9c16c@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20250323
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

Here is the LSM framework pull request for the Linux v6.15 merge window,
the highlights are below:

- Various minor updates to the LSM Rust bindings

  Changes include marking trivial Rust bindings as inlines and comment
  tweaks to better reflect the LSM hooks.

- Add LSM/SELinux access controls to io_uring_allowed()

  Similar to the io_uring_disabled sysctl, add a LSM hook to
  io_uring_allowed() to enable LSMs a simple way to enforce security
  policy on the use of io_uring.  This pull request includes SELinux
  support for this new control using the io_uring/allowed permission.

- Remove an unused parameter from the security_perf_event_open() hook

  The perf_event_attr struct parameter was not used by any currently
  supported LSMs, remove it from the hook.

- Add an explicit MAINTAINERS entry for the credentials code

  We've seen problems in the past where patches to the credentials
  code sent by non-maintainers would often languish on the lists for
  multiple months as there was no one explicitly tasked with the
  responsibility of reviewing and/or merging credentials related code.

  Considering that most of the code under security/ has a vested
  interest in ensuring that the credentials code is well maintained,
  I'm volunteering to look after the credentials code and Serge Hallyn
  has also volunteered to step up as an official reviewer.  I posted
  the MAINTAINERS update as a RFC to LKML in hopes that someone else
  would jump up with an "I'll do it!", but beyond Serge it was all
  crickets.

- Update Stephen Smalley's old email address to prevent confusion

  This includes a corresponding update to the mailmap file.

Please merge,
-Paul

--
The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20250323

for you to fetch changes up to 65b796acea1e5efc13eb29fdb4638fd26deabc17:

  mailmap: map Stephen Smalley's old email addresses
    (2025-03-10 16:06:24 -0400)

----------------------------------------------------------------
lsm/stable-6.15 PR 20250323
----------------------------------------------------------------

Alice Ryhl (3):
      lsm,rust: mark SecurityCtx methods inline
      lsm,rust: reword "destroy" -> "release" in SecurityCtx
      cred,rust: mark Credential methods inline

Hamza Mahfooz (2):
      io_uring: refactor io_uring_allowed()
      io_uring,lsm,selinux: add LSM hooks for io_uring_setup()

Luo Gengkun (1):
      perf: Remove unnecessary parameter of security check

Paul Moore (2):
      lsm: fix a missing security_uring_allowed() prototype
      MAINTAINERS: add an explicit credentials entry

Stephen Smalley (2):
      lsm: remove old email address for Stephen Smalley
      mailmap: map Stephen Smalley's old email addresses

sergeh@kernel.org (1):
      MAINTAINERS: add Serge Hallyn as a credentials reviewer

 .mailmap                            |    2 ++
 MAINTAINERS                         |   10 ++++++++++
 arch/x86/events/intel/bts.c         |    2 +-
 arch/x86/events/intel/core.c        |    2 +-
 arch/x86/events/intel/p4.c          |    2 +-
 drivers/perf/arm_spe_pmu.c          |    4 ++--
 include/linux/lsm_audit.h           |    2 +-
 include/linux/lsm_hook_defs.h       |    3 ++-
 include/linux/perf_event.h          |   10 +++++-----
 include/linux/security.h            |   10 +++++++---
 io_uring/io_uring.c                 |   21 ++++++++++++++-------
 kernel/events/core.c                |   14 +++++++-------
 kernel/trace/trace_event_perf.c     |    4 ++--
 rust/kernel/cred.rs                 |    5 +++++
 rust/kernel/security.rs             |   12 ++++++++----
 security/lsm_audit.c                |    2 +-
 security/security.c                 |   17 ++++++++++++++---
 security/selinux/hooks.c            |   16 +++++++++++++++-
 security/selinux/include/classmap.h |    2 +-
 19 files changed, 99 insertions(+), 41 deletions(-)

--
paul-moore.com

