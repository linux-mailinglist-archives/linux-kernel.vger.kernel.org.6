Return-Path: <linux-kernel+bounces-417121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BFF9D4F42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CFC1F2287F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD71DDA2F;
	Thu, 21 Nov 2024 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqnH8PRG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA161DD87D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200801; cv=none; b=f3DklZYyblkXYWHz+eoJsRj/py+379X8U3iSlu2V4QMimWRQj4v1CNUP/i40WB0nT4V5+ZBKlIBJJiDwH6ZfhNawDQopjpFiZBxWIBKAWfy4AtKrjOMded3OtE6Uz9WmTYxx3mQiHpjZnNvW//fWguFw5RaSNAICrJ5KGTMl0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200801; c=relaxed/simple;
	bh=vQjjBK6BgJm1LCyLVxi6jPRZKYDYNzHkgDmoWaypjYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n9NUg70NZnsgNF/nGQmyZq0PBplvg7XIKC6mhRwLDbJaUE4tUSLn8VZMkP4o2o+mALYDpnOuHYt/Sj4HXODsY11Ix7oQkUupzChc/EE/kH1XZAPlEh5vlzWVSbWXdd6QBKqAijQXYDH/4k4dZVsPcAPew1Z7wWVNvMREXcPwJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqnH8PRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8A6C4CECC;
	Thu, 21 Nov 2024 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732200800;
	bh=vQjjBK6BgJm1LCyLVxi6jPRZKYDYNzHkgDmoWaypjYE=;
	h=Date:From:To:Cc:Subject:From;
	b=YqnH8PRGKmsnJIaoame6duItN0bSytKcgikENbKTFAyLj8VsffUW7RzgsTQwf7sfm
	 AGfS8pPsuLRw/OCr78z3yKTqTtC8t2hFMJ+hW93RqA5e1nzoaxyMQVtIwu59Mz/7bU
	 6/i8Nx9h2WuULPXtQMgYZiVdlzflQ1nZm/6aGMX/SFux5QnPajiQWv2USHOm3sqfx+
	 VNLmJvWEv6InCzaEEEKRQYWijV6PgJRzUu+Ob4lL44JM4TTZgEsIYpdA1oZdRoGNaA
	 rXL3PEn+qqNxSZeuIvyzo0R7TmGDRV8tzB8sxVtfbZTZPMs76AGu6alRALOPkIg6vh
	 DU+DNrcUwfyMQ==
Date: Thu, 21 Nov 2024 06:53:17 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>, Nir Lichtman <nir@lichtman.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: [GIT PULL] execve updates for v6.13-rc1 (take 2)
Message-ID: <202411210651.CD8B5A3B98@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve updates for v6.13-rc1 (take 2). I've dropped
the argv[0] vs "comm" setting patches. We'll work on the better solution
for the next merge window.

Thanks!

-Kees

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.13-rc1-take2

for you to fetch changes up to 45bf05a51842c4c274f94514195c2e99cc1c200c:

  exec: remove legacy custom binfmt modules autoloading (2024-11-21 06:44:02 -0800)

----------------------------------------------------------------
execve updates for v6.13-rc1 (take2)

- binfmt_misc: Fix comment typos (Christophe JAILLET)

- exec: move empty argv[0] warning closer to actual logic (Nir Lichtman)

- exec: remove legacy custom binfmt modules autoloading (Nir Lichtman)

- coredump: Do not lock when copying "comm"

- MAINTAINERS: add auxvec.h and set myself as maintainer

----------------------------------------------------------------
Christophe JAILLET (1):
      fs: binfmt: Fix a typo

Kees Cook (3):
      coredump: Do not lock during 'comm' reporting
      MAINTAINERS: exec: Add auxvec.h UAPI
      MAINTAINERS: exec: Mark Kees as maintainer

Nir Lichtman (1):
      exec: remove legacy custom binfmt modules autoloading

Tycho Andersen (1):
      selftests/exec: add a test for execveat()'s comm

nir@lichtman.org (1):
      exec: move warning of null argv to be next to the relevant code

 MAINTAINERS                             |  3 +-
 fs/binfmt_misc.c                        |  2 +-
 fs/exec.c                               | 22 ++--------
 include/linux/coredump.h                |  4 +-
 tools/testing/selftests/exec/execveat.c | 77 +++++++++++++++++++++++++++++++--
 5 files changed, 83 insertions(+), 25 deletions(-)

-- 
Kees Cook

