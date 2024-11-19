Return-Path: <linux-kernel+bounces-414684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 162399D2C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D415BB3AB65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B8F1D0967;
	Tue, 19 Nov 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffZPaEJT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F61014A615
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035634; cv=none; b=rQSudoLdqQYESzLfUZPOwzDkcetJtRhrv7JEGW/gH+ks5ssOpJSN0+zbwWEW6un5fR5hutKvKaCmdXh9/jn1P8iODWS19toblM+hASqgysA6lIQTs5zk+2gW2Lsg1mEyc7I6nTNlB/GVFyMVaG6o8OAd69LHopLq77C2efU+jXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035634; c=relaxed/simple;
	bh=xLMAxpsmMUPYRrZACBojtpNoGfLxiJgsBVYKodQdXTc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BlIMRFDQbWW3TKHcuJnmfdl5nIyQ8iepP6q3CrdNWk5Jq3RG6ck7dP7iBH1CJM7XKSUMHqqcTTUZVx6jso0o/7Sm0IyT4TqqKOiDSn8bOVYBZPtmJGXirlkpxHAzcgPgBzw1WNyikrcHiem2BVtQLtHTvs5yoCGf4NRnDan2TDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffZPaEJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CCAC4CECF;
	Tue, 19 Nov 2024 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732035633;
	bh=xLMAxpsmMUPYRrZACBojtpNoGfLxiJgsBVYKodQdXTc=;
	h=Date:From:To:Cc:Subject:From;
	b=ffZPaEJT40p4rjXhZLgOM9UFOhUw+CDI/zUNqJRp9W2gP0bJ4d9tVSZdFCC4JHG/s
	 exTJ32ikAaL+o3Vi+fjCAclU9SLbMHJmJ974yy3xgSohjO2p3+kMyX8NsRQOTMc4Bh
	 dmZuUesqy0wJXBj5nMgYD6bRFKme1/ouio8hzJ7Cj2gFssL7kRFD2x4QDukBDomuYr
	 iobn6x9jp9kAHtPB1mpHpIwBtKUeo5rtNMp4AsaqUZlT/Z3RlMTXoj/c3acCAdq0es
	 YA5ARdMm+p2JL9ZmxcVWNAbOvgZwUcgw8/FsVKxQDMxtfJxJs9CxEWHYD+SmrCeXtm
	 DgnOGKYI9uigw==
Date: Tue, 19 Nov 2024 09:00:31 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>, Nir Lichtman <nir@lichtman.org>,
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com,
	Tycho Andersen <tandersen@netflix.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [GIT PULL] execve updates for v6.13-rc1
Message-ID: <202411190900.FE40FA5@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve updates for v6.13-rc1.

Thanks!

-Kees

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.13-rc1

for you to fetch changes up to 8c9870077aac4b141decfb42431415bb32d1fedf:

  exec: remove legacy custom binfmt modules autoloading (2024-11-16 20:54:03 -0800)

----------------------------------------------------------------
execve updates for v6.13-rc1

- binfmt: Fix comment typos (Christophe JAILLET)

- exec: Use argv[0] for "comm" with AT_EMPTY_PATH (Tycho Andersen,
  Dan Carpenter, Nir Lichtman)

- exec: remove legacy custom binfmt modules autoloading (Nir Lichtman)

- coredump: Do not lock when copying "comm"

- MAINTAINERS: add auxvec.h and set myself as maintainer

----------------------------------------------------------------
Christophe JAILLET (1):
      fs: binfmt: Fix a typo

Dan Carpenter (1):
      exec: Fix a NULL vs IS_ERR() test in bprm_add_fixup_comm()

Kees Cook (4):
      coredump: Do not lock during 'comm' reporting
      MAINTAINERS: exec: Add auxvec.h UAPI
      MAINTAINERS: exec: Mark Kees as maintainer
      exec: NULL out bprm->argv0 when it is an ERR_PTR

Nir Lichtman (1):
      exec: remove legacy custom binfmt modules autoloading

Tycho Andersen (2):
      exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case
      selftests/exec: add a test for execveat()'s comm

nir@lichtman.org (1):
      exec: move warning of null argv to be next to the relevant code

 MAINTAINERS                             |  3 +-
 fs/binfmt_misc.c                        |  2 +-
 fs/exec.c                               | 62 ++++++++++++++++++--------
 include/linux/binfmts.h                 |  1 +
 include/linux/coredump.h                |  4 +-
 tools/testing/selftests/exec/execveat.c | 77 +++++++++++++++++++++++++++++++--
 6 files changed, 123 insertions(+), 26 deletions(-)

-- 
Kees Cook

