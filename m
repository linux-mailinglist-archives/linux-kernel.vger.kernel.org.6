Return-Path: <linux-kernel+bounces-305955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CCA9636F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F77B23655
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C487DDD9;
	Thu, 29 Aug 2024 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NBoV586L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345EC6125
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892176; cv=none; b=HA5MQ0L/dVVZJm8cWAATwHY+MSw1vEtv6gVXyuo7de4ue6GD93vMBowfEU3qfSFUSJIoo+LTiq5rqvXWsN6SEVjFlJ+kexf7CGronMsnqdDlGb/CLmyBNUJdBeJTrtay5MlAQqYVsGwqIRYK2gWxVuGg/WUBzWJI5tR5l7o7QWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892176; c=relaxed/simple;
	bh=o4brvdfWk5uxX61Zj5d1/G0xxylWqH0ufTuF3bxeDN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kb7m9Tc8sHA8Qu0K11DVrgyH+Hbq2TpYGpiURzLZHBlppM4nN7yQjQcwP+D3MCmWD3LDom7htlb0OJOloemCpjrbQasnbvThz89ETwZiPl+a5N9FQJTzurnJvPgUTp8jHssE5dwcAZRsi1i8UVqz5rKVA3kYd/k8lcCc+mHxSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=NBoV586L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB7DC4CEC0;
	Thu, 29 Aug 2024 00:42:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NBoV586L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724892173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9/30TaV4mvaAKw5rzfdYQI3sb/AgSfx4ekLyAZeVFgA=;
	b=NBoV586L+qpTpJ6WpxTc56uGMEMFeM2Zq6Px5f3pKSAoaIJ+odzjQw4EL8MqbQtYrx49ht
	Xl1aToh6TlE/ex/a403ZklRXar2jhtyEaNgKjd78YcfvhLl823VUOscExzLIQkxIedknnm
	P5i+TJuDlfAu/zgkp5mym7iyDZUFd2k=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b9eee145 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 00:42:52 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 6.11-rc6
Date: Thu, 29 Aug 2024 02:42:46 +0200
Message-ID: <20240829004246.3433304-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

This pull has one small fix:

- Reject invalid flags passed to vgetrandom() in the same way that getrandom()
  does, so that the behavior is the same, from Yann.

  The flags argument to getrandom() only has a behavioral effect on the
  function if the RNG isn't initialized yet, so vgetrandom() falls back to the
  syscall in that case. But if the RNG is initialized, all of the flags behave
  the same way, so vgetrandom() didn't bother checking them, and just ignored
  them entirely. But that doesn't account for invalid flags passed in, which
  need to be rejected so we can use them later.

Please pull.

Side note: there are now enablements of vgetrandom() in review for arm64, ppc,
and loongarch, and hopefully they'll be ready for 6.12. In the process of
getting this wired up on several archs, various build, selftest, header, and
other bureaucratic-style gotchas have been found and fixed. Originally my plan
was to send you a pull containing those fixes, for 6.11, so that the actual new
arch code could then go in via each respective arch tree for 6.12. But these
little fixes have started to pile up, and some of the build ones deserve a bit
of care and testing under different circumstances, so I'd like to actually let
these cook in linux-next for a while longer and send them for 6.12 instead. And
it's not like they actually fix any _current_ issue, as the x86 codegen is the
same; they just fix bugs in order to enable other archs later. So now my
current plan is to send these to you for 6.12, alongside the new arch
enablements in that same pull, after receiving acks from the arch maintainers
to do that. If you are curious or do want these build fixes now for some
reason, though, they're all sitting in my tree.

Thanks,
Jason

The following changes since commit dc1c8034e31b14a2e5e212104ec508aec44ce1b9:

  minmax: simplify min()/max()/clamp() implementation (2024-07-28 20:24:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.11-rc6-for-linus

for you to fetch changes up to 28f5df210d06beb5920cf80446f1c27456c14b92:

  random: vDSO: reject unknown getrandom() flags (2024-08-26 09:58:52 +0200)

----------------------------------------------------------------
Random number generator fixes for Linux 6.11-rc6.
----------------------------------------------------------------

Yann Droneaud (1):
      random: vDSO: reject unknown getrandom() flags

 lib/vdso/getrandom.c | 4 ++++
 1 file changed, 4 insertions(+)

