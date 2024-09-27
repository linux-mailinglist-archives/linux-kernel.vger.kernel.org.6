Return-Path: <linux-kernel+bounces-342022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A149889BC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6701F23EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB71C173A;
	Fri, 27 Sep 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="awBtZOik"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205D136E3F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727459112; cv=none; b=soFJ+F6RpMQcMJ33qzG5wWIHnOR+pYpPMR8VHpWWhs1YbUyYgpH78odUbfIEN7i4tqkSJ6sL22fq+eFXfYGQP6Ze6/02OroEAX6yL3uxu/gvOEt6yUBncBH4OAQiqXgMmjgDJGjNKAQBd2OiJiHhZSPJHPodHCs0NmQInEAUrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727459112; c=relaxed/simple;
	bh=YQ11nVg7jwVP9vabZBdDdvEphMuux+bwuBYRoXUpdNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKtGnmb0WoHZbP/tprNGS54hguHFLPW1bxvBbphUcCGfES1cMCOqC0tZZ7O4HSrQwCsvA0oHvxbcxKRlKbZr86lm2QEtfzKoKmIumjo+x7GfKHKG7s5bZSAqGo1SExm0TOwruObyHl/7TNF8APYNhgX820x1O0LRiKunbH9MRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=awBtZOik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA52C4CEC4;
	Fri, 27 Sep 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="awBtZOik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727459109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvaH9Mi6vE8ngulzpiQipfCU4WPdYYr+7ITbEcudDOg=;
	b=awBtZOikigaFbz3oQvdQlPJWAbBtG3IBg+FnD9ilNpHtREvtJTjHBps/3zNT/eR7uznAyR
	E1Zh5Tdf8ECTOfpnmxpbXE+vz22Z1ucLThpdtPutKzy/8nDLCFF+O/L5myTKh0MnD367O5
	OyKjGMKkjBArdWGWD5MXK+I1qrK4yWM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bd0c39dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Sep 2024 17:45:09 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 6.12-rc1
Date: Fri, 27 Sep 2024 19:45:07 +0200
Message-ID: <20240927174507.1795312-1-Jason@zx2c4.com>
In-Reply-To: <20240916121358.3666562-1-Jason@zx2c4.com>
References: <20240916121358.3666562-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following two small improvements for rc1:

- Christophe realized that the LoongArch64 instructions could be scheduled more
  similar to how GCC generates code, which Ruoyao implemented, for a 5% speedup
  from basically some rearrangements.

- An update to MAINTAINERS to match the right files.

Meanwhile, the RISC-V folks are working on vDSO getrandom() for 6.13, and tglx
& co are working on some more generic vDSO cleanups throughout, so it's likely
the 6.13 work will make it to you via tip. I'll also likely route post-rc1
fixes through arch trees wherever possible.

Thanks,
Jason

The following changes since commit 4a39ac5b7d62679c07a3e3d12b0f6982377d8a7d:

  Merge tag 'random-6.12-rc1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random (2024-09-18 15:26:31 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.12-rc1-for-linus

for you to fetch changes up to 9805f39d423a30a7189158905ec3d71774fe98a1:

  LoongArch: vDSO: Tune chacha implementation (2024-09-24 14:21:05 +0200)

----------------------------------------------------------------
Random number generator fixes for Linux 6.12-rc1.
----------------------------------------------------------------

Jason A. Donenfeld (1):
      MAINTAINERS: make vDSO getrandom matches more generic

Xi Ruoyao (1):
      LoongArch: vDSO: Tune chacha implementation

 MAINTAINERS                             |  5 +-
 arch/loongarch/vdso/vgetrandom-chacha.S | 92 ++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 41 deletions(-)

