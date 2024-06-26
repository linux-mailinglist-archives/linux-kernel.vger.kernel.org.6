Return-Path: <linux-kernel+bounces-231614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16A919ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C792A1F22133
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399AA192B80;
	Wed, 26 Jun 2024 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWQIOj+m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC3181B80
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719442330; cv=none; b=GQICOFcGJZxlBtves0hQaH7Beq9lX4x/4EPUbDDaoLIQLOnsP9poTq+t60PIcm+JzmSQXIqioAuaTP4DbA4Yf5BJk72IgRuzf+ZTmsQViDfnzfcb324lwCoWSAPSXRl5t+pbrww+OQiU32E3OQCKD8hDTG297A7Z3P2l4K1ufeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719442330; c=relaxed/simple;
	bh=n36cwaofjsJ1Cu4DxMbH84JXTU8lCSdSHnjIFblNErM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRhiqs7OdaIbHkE25RYAOYhOHEfGiUeZHAqK6+/s4fcbtkWFTjZI4/Ig45mBrjL1yphdIl5LTHmQaJQZJRQF9n66eRiqIg3Fsn15oSHCgfLofz9EpZ666NlSTh98WLfRYcOgiZRm8qF9oHhnY1X306hW3sQqscDUtevnIAV2H24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWQIOj+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EC4C116B1;
	Wed, 26 Jun 2024 22:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719442330;
	bh=n36cwaofjsJ1Cu4DxMbH84JXTU8lCSdSHnjIFblNErM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UWQIOj+mOT7kzf81cZX3mijSnyGsqata5FMU3DITboFYrcgWegdHQzJymUiLY+9Hi
	 DfBqspgkq18tusQNGRPfQF3pzwDyPD4rNSquTgrT2flCEVw2LAqfFUqjOtoEh3qcO+
	 fdY8lftVeEm3TZkz5/XqNbFb+Xwl0qLViHm1IgludLMaK4EHDz0meT7gS9QETumreO
	 KkDjLWyFty8ZMjUZPBxU8Q22TlloqmNPQy9Enpp0J5m4WJHBjLsloD/vIvPwSE0gqy
	 qBLt8t5nC7XkZskFh94q3y+Fi3cooOZ4TgI9PLq4PBY3Mg4Ai2NIEuJOrNV1/DcMeW
	 vf9plX2CTpB1A==
Date: Wed, 26 Jun 2024 15:52:09 -0700
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	wad@chromium.org, rostedt@goodmis.org, arnd@arndb.de,
	ardb@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
	rick.p.edgecombe@intel.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3]  arm64: entry: Convert to generic entry
Message-ID: <202406261550.2AD733291D@keescook>
References: <20240625092759.1533875-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625092759.1533875-1-ruanjinjie@huawei.com>

On Tue, Jun 25, 2024 at 05:27:56PM +0800, Jinjie Ruan wrote:
> Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
> to use the generic entry infrastructure from kernel/entry/*. The generic
> entry makes maintainers' work easier and codes more elegant, which aslo
> removed a lot of duplicate code.
> 
> Jinjie Ruan (3):
>   entry: Add some arch funcs to support arm64 to use generic entry
>   arm64: Prepare to switch to generic entry
>   arm64: entry: Convert to generic entry
> 
>  arch/arm64/Kconfig                    |   1 +
>  arch/arm64/include/asm/entry-common.h |  60 +++++
>  arch/arm64/include/asm/ptrace.h       |   5 +
>  arch/arm64/include/asm/stacktrace.h   |   5 +-
>  arch/arm64/include/asm/syscall.h      |   6 +-
>  arch/arm64/include/asm/thread_info.h  |  23 +-
>  arch/arm64/kernel/entry-common.c      | 355 ++++++--------------------
>  arch/arm64/kernel/ptrace.c            |  78 +++---
>  arch/arm64/kernel/signal.c            |   3 +-
>  arch/arm64/kernel/syscall.c           |  18 +-
>  include/linux/entry-common.h          |  51 ++++
>  kernel/entry/common.c                 |  49 +++-
>  12 files changed, 294 insertions(+), 360 deletions(-)
>  create mode 100644 arch/arm64/include/asm/entry-common.h

This is very cool! While the arm64 maintainers need to review it, I at
least built and ran tests using the seccomp selftests which tends to be
pretty sensitive to corner cases around syscall exit/entry things, and
it passed just fine.

Tested-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

