Return-Path: <linux-kernel+bounces-285471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44613950DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F9E1C20C15
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4561A7056;
	Tue, 13 Aug 2024 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVF7wKf+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543A1A4F2E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580865; cv=none; b=XeTXif3O8QebpSudYocaVKwkS97N7A71DaczBTq18mjQ6rMeVTqaKnyVEL3zjdppZrN+E4TFARhCo10KMZXEYqOR9wHqMLHkselwuCpwnj6vPijNGp0K2UCVqouDGFp5TG6F3DvrCgQld83mdehpsh/7UiJDubtfsaZTDOPrxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580865; c=relaxed/simple;
	bh=JUcQ2iGYPKnLDMSa9P3eGQMURXWBQxoZ08Sce9vmUi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t+4Q51ph36HgtzlNE4ZuUPuzR8zUs8Kqk0tr+RQbJqVwwQ1th85iPDjRz5sNRNrEAOEikfKtlJSxc73xYrsmZZ15UkpPTaqDd8PccK/cRepP9kIjJ+sRWGJynC21NsyZ8lHgFaWSgedlKL4bliu3IXH+6eZYWetpDgv3q+CZryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVF7wKf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3047EC4AF0C;
	Tue, 13 Aug 2024 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723580865;
	bh=JUcQ2iGYPKnLDMSa9P3eGQMURXWBQxoZ08Sce9vmUi8=;
	h=Date:From:To:Cc:Subject:From;
	b=RVF7wKf+6udWJbDjd2kRqg2It2K4NJqBc24Uq5gUOv2WEz88touYQuTZZGQNVQ97j
	 Km9hBfM4lZnbOP25zrLO7yjrzDaf8Etd3YuAGEGuoYxLlgPu37LwAdtjbAuore+hqX
	 +WRU9a0RYama2qty/MW0gbnkpGCnpBMFkbwlYHEtABu5WQg4hQLL6KdIX4coTuqzym
	 aLY4FY1kFjPLYmAElK5zxwHCaIGrPE1wUBAQcEJSCdtfkuNELpPlewKnmQlRmNBVAK
	 5JqLHNnalfEAI+DgX/ZcnxZF68DZThVkh3bfSbB9PY4Wp3YNJtz6BH3xFQOt6Hxsj5
	 0dFZ+JmDaY2Pg==
Date: Tue, 13 Aug 2024 13:27:44 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Greg Ungerer <gerg@linux-m68k.org>, Kees Cook <kees@kernel.org>,
	Marco Vanotti <mvanotti@google.com>,
	Stefan O'Rear <sorear@fastmail.com>
Subject: [GIT PULL] execve fixes for v6.11-rc4
Message-ID: <202408131327.15CD984B5@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve fixes for v6.11-rc4.

Thanks!

-Kees

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc4

for you to fetch changes up to f50733b45d865f91db90919f8311e2127ce5a0cb:

  exec: Fix ToCToU between perm check and set-uid/gid usage (2024-08-13 13:24:29 -0700)

----------------------------------------------------------------
execve fixes for v6.11-rc4

- binfmt_flat: Fix corruption when not offsetting data start

- exec: Fix ToCToU between perm check and set-uid/gid usage

----------------------------------------------------------------
Kees Cook (2):
      binfmt_flat: Fix corruption when not offsetting data start
      exec: Fix ToCToU between perm check and set-uid/gid usage

 fs/binfmt_flat.c | 4 +++-
 fs/exec.c        | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
Kees Cook

