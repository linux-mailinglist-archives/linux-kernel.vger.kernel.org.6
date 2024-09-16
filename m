Return-Path: <linux-kernel+bounces-330353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA172979D05
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964E12822E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997714885D;
	Mon, 16 Sep 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugmPLDH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79F142E6F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475980; cv=none; b=SNunmN0WYAFZTysHZfwmEzuWjyMBSKGNJcq43WDIMakgQH5jgBdHn/ksGhYCRi4Jg7QI/wHBK8LOaNbm1OlwaXPGDExjodPMBgdX0v3KEkBmop3BbMH8JxbQxWsIziQJ+Legndkau+P3JkvrC7C5TztuYZF/FUsl3wnC5DB5Ozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475980; c=relaxed/simple;
	bh=+b2VJIFzoPgqgO48968YWz+jIanymhwAaoikVq4taoM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jXqc/w1SvB1DRXC8XGkXtr8mqdQPtFXoef0823u1bwX4uOiANiamejd9WZGIT2RNeGp9ukxv0fAa0Y4z6gEzskBwnRtu7YjKSTMYupcdGHMpiknencpom/z1zyqOdZdZj0BZ4TkqnPjhXixpOSlDeRBhf11bJGm7zi0FUTCHcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugmPLDH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BA6C4CEC4;
	Mon, 16 Sep 2024 08:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726475980;
	bh=+b2VJIFzoPgqgO48968YWz+jIanymhwAaoikVq4taoM=;
	h=Date:From:To:Cc:Subject:From;
	b=ugmPLDH3MxHDRVHox+DWzytxtsrdHsVK+0kPHq3DGEzL2PvHH6JNh9PJTCxFIfFm8
	 qJflsVoBCE/KRTGWE7yhKSP4HFiZts/5sPVOP3UXbdhSS92DPfC6QqhIlAvs5LMh04
	 YdsU2H97kah6PgWyC3IlXGpbbsKaHZNZ3q7rSjzIaTPkgdIlLX1IIw35JCYTCULipB
	 tvTVcTcC0TDoDJIxroiRpXriSk71FZDfYW1k2Q464Eefd9SI5mDsCprvCx9rLJW7x0
	 rkiMsRZffBzFBo0bInGqyDvZiJ6ksX3wcCRZfRgwJxyKHmZAp8DlgAhGSf1ybAW490
	 rbC7aQItljrrQ==
Date: Mon, 16 Sep 2024 01:39:39 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>,
	Brian Mak <makb@juniper.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>,
	Roman Kisel <romank@linux.microsoft.com>
Subject: [GIT PULL] execve updates for v6.12-rc1
Message-ID: <202409160138.7E27F1A55@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve updates for v6.12-rc1. Note there is a trivial
merge conflict between this and mm, which was resolved in -next with:
https://lore.kernel.org/linux-next/20240909171843.78c294da@canb.auug.org.au/

Thanks!

-Kees

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.12-rc1

for you to fetch changes up to 44f65d900698278a8451988abe0d5ca37fd46882:

  binfmt_elf: mseal address zero (2024-08-14 09:56:48 -0700)

----------------------------------------------------------------
execve updates for v6.12-rc1

- binfmt_elf: Dump smaller VMAs first in ELF cores (Brian Mak)

- binfmt_elf: mseal address zero (Jeff Xu)

- binfmt_elf, coredump: Log the reason of the failed core dumps
  (Roman Kisel)

----------------------------------------------------------------
Brian Mak (1):
      binfmt_elf: Dump smaller VMAs first in ELF cores

Jeff Xu (1):
      binfmt_elf: mseal address zero

Roman Kisel (2):
      coredump: Standartize and fix logging
      binfmt_elf, coredump: Log the reason of the failed core dumps

 fs/binfmt_elf.c          |  53 +++++++++++----
 fs/coredump.c            | 166 ++++++++++++++++++++++++++++++++++-------------
 include/linux/coredump.h |  30 ++++++++-
 include/linux/mm.h       |  10 +++
 kernel/signal.c          |  21 +++++-
 mm/mseal.c               |   2 +-
 6 files changed, 220 insertions(+), 62 deletions(-)

-- 
Kees Cook

