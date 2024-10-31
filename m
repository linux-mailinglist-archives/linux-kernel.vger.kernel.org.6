Return-Path: <linux-kernel+bounces-390459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506C9B7A31
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C140E1F214C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCB19ADA4;
	Thu, 31 Oct 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GJV5GjYL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWKTuAV7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47031BC20
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376250; cv=none; b=riKswQEeIA0CRcVoAXjhMEh8xaNKliHLF6U4RtZ9l72tZawMtz+ALGKprlIsBXpW2MwyUYXSB8QdIjEeTUA3xNGNNZCNANs/EqzW/rEhthQqduAQKtYJdAY6n48POid0Zv2Ix1TBtuJ/PycjvPvfbwexiYsZhCWSTPZM3Rap00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376250; c=relaxed/simple;
	bh=7DyCwb7VlNvvBsHiz7RddaJwmn+ou0DGlvZtBs2bsnU=;
	h=Message-ID:From:To:Cc:Subject:Date; b=otnbq/S4TvslseB4gv/SaGRfYWOT+mazOTRa7oFCu/y6co9DTpYNXuOWKBd9jejAORNEBMlBk4Ql6GJqngj9ZXs0HI3JmnH5rqmAayfrh05Huv3hvzGkSbmP4Hq2wHWTMO9H8RW+muAbOarW6yz8wpDibaepRZNgrhZDknNHIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GJV5GjYL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWKTuAV7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031115448.978498636@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730376246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=NRv8pxWWkjQg0v6CM20mzf5/kbe20oZIZzJbrvdHpzk=;
	b=GJV5GjYLAq6gGF0KmrQio0HyVWAQ2eM8F1er0dPhdU3MLkPi3/I9xiF8mwDky36oAdrZaf
	VS7aZfOMP3uiTC8u37blJoRcn8hNDD4ZX7Gak/49hmBnr1M8C8yciweuhtrBzoZF0Fo3fZ
	vh/mCdKhFq32LJZZsJaWFj12RvTWyHzsItodUlOCwNQilgna78YVqcaYET+bTTRkPUhtcI
	5zUK385slrdwQW6ujhuBWegzh4jDRQ/rf8ebMZbhMJvy8M1+obthjUj1oVPeT+txxkh/Ul
	Mq9vQAAvbuzSnnleyBQPkYKMoqN+QFCcBIBd6tgauQ5Xw8TNHTyeoGJHhk43lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730376246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=NRv8pxWWkjQg0v6CM20mzf5/kbe20oZIZzJbrvdHpzk=;
	b=CWKTuAV7Z9n7CVSeVBSUgGULWb8ypE4dm28a/kLF6KJKM0w914IEjJa7xaHUD00cFuSMZ0
	EmLNJBwulZh54zDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 0/2] timekeeping: Fall cleaning
Date: Thu, 31 Oct 2024 13:04:06 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The sanity checks under CONFIG_TIMEKEEPING_DEBUG have served their purpose
for some time, but now that timekeeping handles potential 64bit math
overflow correctly and is unconditionally protected against negative motion
of time, these checks have no real value anymore.

CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE, which contains a protection against
negative motion of time is only used on x86. It used to be in the
timekeeper hot path, but now it's only in relative slow paths (watchdog and
timekeeping_advance()). This protection is useful in general and the extra
conditional in these usage sites does not really matter.

This series removes CONFIG_TIMEKEEPING_DEBUG and related code and makes the
negative protected variant of clocksource_delta() unconditional.

The series applies on top of

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

Thanks,

	tglx
---
 arch/riscv/configs/defconfig                        |    1 
 arch/x86/Kconfig                                    |    1 
 include/linux/timekeeper_internal.h                 |   16 --
 kernel/time/Kconfig                                 |    5 
 kernel/time/timekeeping.c                           |  108 --------------------
 kernel/time/timekeeping_internal.h                  |    7 -
 lib/Kconfig.debug                                   |   13 --
 tools/testing/selftests/wireguard/qemu/debug.config |    1 
 8 files changed, 3 insertions(+), 149 deletions(-)

