Return-Path: <linux-kernel+bounces-566499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FB7A678E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD6C178CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9AF20C46B;
	Tue, 18 Mar 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="N9ntLxtZ"
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123A20D4E3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314503; cv=none; b=IB88pHsF8BPH/xIXcEukazWdn7JkvgVDhnu5rR7dXktCQg2+NyHe5SnFd6SZjl64xVlfV71+bonxD3QeaOGAWiqe5/Of2YywnZk9NaUMWHRI7aues6LGLWz5Q2bDCM/FFZwCXNmeINc58hquRwtDheBINASw4k6AcuKch/jKUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314503; c=relaxed/simple;
	bh=DfDkyMj1tIYaHz4hoTjAqKyZHEMNoutDmpyXNLXROUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GW8+btvZ++NJeWnmRQ0o1sv7TIFHgigrYmVEH78HKdeY6DkH+WXiy0aR0cZKvgZ9m8CC+3c0S5fXKo/QViUDDKlkceiwfl+cd7BNm2d/vMvgrYI+7rgX7vqn4WU9g5OXR5Flwz1Vqxsxw0lTeweK1rrdNB1TSOu5T0fnxbH1Iv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=N9ntLxtZ; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH3t4ZHmz7Fd;
	Tue, 18 Mar 2025 17:14:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314490;
	bh=0G26ifulcpI8LBwhoOBo2yOOyJoQqElv9YQpuMH2qyc=;
	h=From:To:Cc:Subject:Date:From;
	b=N9ntLxtZAdvNsJPTP2kOX1x6wbUcMa5XFY3zOTzXGKIkerMunzvyczKb7g776I35L
	 28DEEmmGYOP8g5D2Wwra6VIATV5NrHEaRGxywKHd44kIdQSj44sF21Ai7P/zlj2/Qu
	 HlZroM0z/EPEeCrTFy0qiRgt8yRjh0NaciO8FUU8=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH3s6gRmzH2Q;
	Tue, 18 Mar 2025 17:14:49 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/8] Landlock signal scope fix and errata interface
Date: Tue, 18 Mar 2025 17:14:35 +0100
Message-ID: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

The initial motivation for this series is a fix for the signal scoping
restriction (see patch 5/8).

Because some user space code cannot use the signal scoping feature
without this fix, we need to have a way to identify if this fix is
applied to the running kernel.  This led me to implement a new "errata"
interface to let user space know if it can use some fixed features.
This should be especially useful in the Landlock Go library to be able
to use the signal scoping control.

Testing this series with Sparse, I had to add a check for __has_include
support to avoid Sparse errors.  I guess this could be fixed in Sparse
but for now let's just ignore this error.

This second patch series also brings new tests for this fix.

Previous version:
v1: https://lore.kernel.org/r/20250313145904.3238184-1-mic@digikod.net

Regards,

Mickaël Salaün (8):
  landlock: Move code to ease future backports
  landlock: Add the errata interface
  landlock: Add erratum for TCP fix
  landlock: Prepare to add second errata
  landlock: Always allow signals between threads of the same process
  selftests/landlock: Split signal_scoping_threads tests
  selftests/landlock: Add a new test for setuid()
  landlock: Document errata

 Documentation/userspace-api/landlock.rst      |  24 +++-
 include/uapi/linux/landlock.h                 |   2 +
 security/landlock/errata.h                    |  99 ++++++++++++++++
 security/landlock/errata/abi-4.h              |  15 +++
 security/landlock/errata/abi-6.h              |  19 +++
 security/landlock/fs.c                        |  22 +++-
 security/landlock/setup.c                     |  38 +++++-
 security/landlock/setup.h                     |   3 +
 security/landlock/syscalls.c                  |  22 +++-
 security/landlock/task.c                      |  12 ++
 tools/testing/selftests/landlock/base_test.c  |  38 +++++-
 tools/testing/selftests/landlock/common.h     |   1 +
 .../selftests/landlock/scoped_signal_test.c   | 108 +++++++++++++++---
 13 files changed, 374 insertions(+), 29 deletions(-)
 create mode 100644 security/landlock/errata.h
 create mode 100644 security/landlock/errata/abi-4.h
 create mode 100644 security/landlock/errata/abi-6.h


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.48.1


