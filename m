Return-Path: <linux-kernel+bounces-412930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E79D1161
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F571F2123E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3071B4F10;
	Mon, 18 Nov 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I4xI+4NR"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4C1AF0A5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935066; cv=none; b=GSlOlxfWl0h1pbIHPPn8bGd4oEy6zcwajO6IXdnMv5gFbAMddi7goCDLCk2w57OvMzuJkGsNgK9tCwvp0Jd6vPK6R95HK83r6lIe5AQoNHZkP4CW7h9nWluvHFgJ+t9iE2zdDramfecy0q9vOKpWHBZ9xeFGTM3NpfINUChQFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935066; c=relaxed/simple;
	bh=6FWzUYWFCrsnvBdRA5DjNCEJdOaye5Th9KK3CZXgcSI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZdtyD4Ydm8oRpYDVtc3R765nPiJ9xCXS+3M94GCehNpYdym/DuKBonoYJVxrfkxuqGtL1QveDdm6sA1sAh1KAlulRcI+H6LVFlC30LoG5Wr8t/RffTN15T7gdFu2TQhfqkoC8v6PlzcbrF9ImCeXcfGSsHyfSHRXdCtSetrWPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I4xI+4NR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3824446d2bcso1333253f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731935062; x=1732539862; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxWmoEeugVS1v5FyiW6L+8vxmWvgvGVYr+32bhSNYVY=;
        b=I4xI+4NRNwIdqEl4aflVO7Kmj0AcLq/HsTkPdfNSTzP/xkuJTfQaW0ozzMQWPVtMrm
         /phHSN7AC2S3XrUHAFRlKqK0UVzBM0fS4t4KUXcol1Pp8PChXmX3A3V8eSSvRQqHO/kf
         owQ1Hiaqep96yfg3F+hPCYjOs/OmlLVant5SicgiwXt0a5kOgTBPDfYAu8QOre9PRqcB
         qrLYcmIkN7U9BgRB8QzTSSXJ5Zru26knyWezZAfrAhBonrCj2uD2v5IEEULTbpdHqHuB
         8GDP8F5+QNobc9LalJArdeO/8kzv5O0I+9bQug0bxmmjdNSJQGSvaBP1KOqCP1pzC3iK
         4alA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731935062; x=1732539862;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxWmoEeugVS1v5FyiW6L+8vxmWvgvGVYr+32bhSNYVY=;
        b=dfe199gj3BP+1W6GMXLy7QCxuiD0rlvP6asMelxfkeKtbwmvUhmldCDORnczLBy/EZ
         zBGtAluGIxnS59EG1a2+hpGormcYNUEs9zB2dApYXW98/cirzhkopLTyiK0Gg+jkYwsi
         rOtAVCyD0TPTGyNKvDF3mcYVRcFXBL86KfEHGSyIWfzqLzy3ad4kGuUT0PCf6KK2Rl5j
         J1vo2OsADH0k6HBAXBxO0BGEBrTp1D+hO8d6KlogpRgWQLME2QtVwqxU8o1HPkXcAPLD
         9iRCNEJV51l1BZnzRMRXAFcinee/Qal/ZYhdi3BrqYvT429OEtRme8wh+nsPdsqKvW4t
         Fe3Q==
X-Gm-Message-State: AOJu0YzYciZLrugQ1eT8DKy5/+SOo2ka56i5miCjbZC1s1ZH6+156/CZ
	tfU//SxcqnYo8dAszPe5B1MDbjExs1v3NatT1/1PpfBRolxMUJiL6aVwK5ORXCQ=
X-Google-Smtp-Source: AGHT+IHy/xNjbMBwdkC38nxZZYbLABoxkMezarb7il7wix1uC6BXNWVekYNhmn0yGD3yIBODDTuVhA==
X-Received: by 2002:a5d:5850:0:b0:382:24b1:e762 with SMTP id ffacd0b85a97d-38225ac4bb6mr12329038f8f.56.1731935062634;
        Mon, 18 Nov 2024 05:04:22 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382455820absm3879797f8f.84.2024.11.18.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 05:04:22 -0800 (PST)
Date: Mon, 18 Nov 2024 14:04:19 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 6.13
Message-ID: <Zzs7U8VsO8YmxxD4@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the latest changes for the kernel livepatching from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-6.13

=============================================

- A new selftest for livepatching of a kprobed function.

----------------------------------------------------------------
Michael Vetter (3):
      selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
      selftests: livepatch: save and restore kprobe state
      selftests: livepatch: test livepatching a kprobed function

 tools/testing/selftests/livepatch/Makefile         |  3 +-
 tools/testing/selftests/livepatch/functions.sh     | 29 ++++++----
 .../testing/selftests/livepatch/test-callbacks.sh  | 24 ++++-----
 tools/testing/selftests/livepatch/test-ftrace.sh   |  2 +-
 tools/testing/selftests/livepatch/test-kprobe.sh   | 62 ++++++++++++++++++++++
 .../testing/selftests/livepatch/test-livepatch.sh  | 12 ++---
 tools/testing/selftests/livepatch/test-state.sh    |  8 +--
 tools/testing/selftests/livepatch/test-syscall.sh  |  6 +--
 tools/testing/selftests/livepatch/test-sysfs.sh    |  8 +--
 .../selftests/livepatch/test_modules/Makefile      |  3 +-
 .../livepatch/test_modules/test_klp_kprobe.c       | 38 +++++++++++++
 11 files changed, 152 insertions(+), 43 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c

