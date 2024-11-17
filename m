Return-Path: <linux-kernel+bounces-412205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624259D0534
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283142816EE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD881DB34B;
	Sun, 17 Nov 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBp8N2wR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8A13AA5D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868655; cv=none; b=gYD6X3gB/7qCGpmW8Wbpy8wbMe+NJojsK6w0xftxZ39jZzuJ0X93ZMaVNVJDY4YXhYEn6AFE7QZLKTOsAChmrLVR7DdxHNYEZZOjWoMNdCIrYmszJRBNEO8eaFm6HHOfp5ggR5KTbEuUIagVKEFRCIDp9PK0p1C3mOe6RtnguhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868655; c=relaxed/simple;
	bh=Vrp8EhBtWtOXM1uHsRZq7NfWbbC0NbCcgILRfwj7yCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QgVNWKFC7pAxyRpAMTbyevNfLtbKJy61/DxaPsMSTsqvmKHuLmgMXSK4g0jyN24C9+0qvqW5SPqg4yKmLvD41hxwN7K55EyaeUksEPWl4183VxVyyHmadoutsbayiSb1UCseFGi7gQfT03cRfNgzHlUCXtK2LBcvC5hgRJIr8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBp8N2wR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED22C4CECD;
	Sun, 17 Nov 2024 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731868655;
	bh=Vrp8EhBtWtOXM1uHsRZq7NfWbbC0NbCcgILRfwj7yCI=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=rBp8N2wRRzvwN2SbkRiiuk8hqb2820rbFZUysuFTOzmNp2MKym5eHLfblGDNXj2sn
	 cLn4HiXyAZMtF6dFRVVC8ep4UmOAVKayyWauQTX2DuigU/ybPwAfVr0SyUp0zH9dz1
	 3abOe+WoWnwXoMq1oDLqa1aIbRFfm4VptNhpNrFUX3pzCe501EMpPwYrNiqYRdSpwK
	 wxQ3enEY15WR/Pawqh/syLtAe0YwzrbubeeG9+eoVA600fZ7qjJzBvpqcb9CJQx1tY
	 ibdgwq/qO1hxtVKddfOK0BY0itpTsdlWWq5/L/vXGvLDYzd6WBAiGtBY16ho6RLWT8
	 mW2I+cxnQkJDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B11A8CE0885; Sun, 17 Nov 2024 10:37:34 -0800 (PST)
Date: Sun, 17 Nov 2024 10:37:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, riel@surriel.com,
	neeraj.upadhyay@kernel.org, leobras@redhat.com, tglx@linutronix.de,
	peterz@infradead.org
Subject: [GIT PULL] CSD-lock changes for v6.13
Message-ID: <d3f76f84-9d4c-4fdb-9642-6eed9c62f8c7@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

When the v6.13 merge window opens, please pull this CSD-lock update from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/csd-lock.2024.11.16a
  # HEAD: 9861f7f66f98a6358c944c17a5d4acd07abcb1a7: locking/csd-lock: Switch from sched_clock() to ktime_get_mono_fast_ns() (2024-10-11 09:31:21 -0700)

----------------------------------------------------------------
CSD-lock diagnostic updates for v6.13

This commit switches from sched_clock() to ktime_get_mono_fast_ns(), which
on x86 switches from the rdtsc instruction to the rdtscp instruction,
thus avoiding instruction reorderings that cause false-positive reports
of CSD-lock stalls of almost 2^46 nanoseconds.  These false positives
are rare, but really are seen in the wild.

----------------------------------------------------------------
Paul E. McKenney (1):
      locking/csd-lock: Switch from sched_clock() to ktime_get_mono_fast_ns()

 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

