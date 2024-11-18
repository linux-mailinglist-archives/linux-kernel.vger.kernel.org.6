Return-Path: <linux-kernel+bounces-413337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A9C9D178A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E717282E85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FF91DE3DE;
	Mon, 18 Nov 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOVtZbhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB41DE3C9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952955; cv=none; b=kwWdSfM2+WLq058r0+yheLd/OFlG3TkU+O3FTLTsS1Ix0OaafwbO2kA8wui22wVCIPoiCf0PpxZwKtWuKthRLyhPtN4iWEg3zeN13ZAVzrplu2S+BxBPyT0FymklzvhkDVkb+xrO7l/fdT4Kr0mjjkytNNRc+J9YdX6aTp/BPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952955; c=relaxed/simple;
	bh=OitMnpPTLbNgGuBGp3c4MjmLfT4VC6qhFbyzp/4NhIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G6hRuCksw1glAXloMobC+74uLegOikmgci0Hmf3mv02Y4HR1k6xkTPZtQ/xVhGL0ZCpKGQ2JdydX3sBbWl1NiTv2N8RLKaymrd5pYSZIHxwmEH2ONiAk5vDjT42f+rSMMQyKSQVOCc/u2Q/fIuNpP0uMUnkBuVxKPaby8ipAVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOVtZbhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6EAC4CECC;
	Mon, 18 Nov 2024 18:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731952955;
	bh=OitMnpPTLbNgGuBGp3c4MjmLfT4VC6qhFbyzp/4NhIM=;
	h=Date:From:To:Cc:Subject:From;
	b=HOVtZbhjtyBrpEnvYqU9Lhyojy0f41IHWswABzbwM2N7kDs0qpXtnqaTWiDAsYXff
	 E9zupPi4x0mg2bV/UP3TLFFae/0Zt1hRoGwZN38r5/9CTAsrTAyjjYZrOp046q3R/D
	 B/T1l2vuBLNjlv2WzRNBphnOYEwjfO/joVoeZRAxdo9kpjUwgXjS/ozaTtjMNPbSI3
	 z1nS+Xkr5Gco7bBltbHVfNRcuumli5iw4jpLz40RNF0AP5Ano8zFN6Fw/tDMrWju9e
	 0m/anL1YAc1Tx+QfyG3wxooYkNNIKz1qqkhg1E9jPOe/vPv/FS2UEqaDBndxWDbv3N
	 ejS5p0NCqq2eQ==
Date: Mon, 18 Nov 2024 19:02:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [GIT PULL] x86/splitlock changes for v6.13
Message-ID: <ZzuBNj4JImJGUNJc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/splitlock Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2024-11-18

   # HEAD: 408eb7417a92c5354c7be34f7425b305dfe30ad9 x86/bus_lock: Add support for AMD

x86/splitlock changes for v6.13:

 - Move Split and Bus lock code to a dedicated file (Ravi Bangoria)
 - Add split/bus lock support for AMD (Ravi Bangoria)

 Thanks,

	Ingo

------------------>
Ravi Bangoria (2):
      x86/split_lock: Move Split and Bus lock code to a dedicated file
      x86/bus_lock: Add support for AMD


 Documentation/arch/x86/buslock.rst |   3 +-
 arch/x86/Kconfig                   |   8 +
 arch/x86/include/asm/cpu.h         |  11 +-
 arch/x86/kernel/cpu/Makefile       |   2 +
 arch/x86/kernel/cpu/bus_lock.c     | 406 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c       |   2 +
 arch/x86/kernel/cpu/intel.c        | 407 -------------------------------------
 include/linux/sched.h              |   2 +-
 kernel/fork.c                      |   2 +-
 9 files changed, 431 insertions(+), 412 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/bus_lock.c

