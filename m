Return-Path: <linux-kernel+bounces-330436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE89979E90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2341B21906
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1BB14A095;
	Mon, 16 Sep 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGwIAlvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391A1487D6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479554; cv=none; b=CxicqGQaJvePtvZTGXRbELZRj82fAxJhwZ14Rb3dTuEF2f1TOSD8oWXFA81Dn4gBFhCWXIHEj3sWC9J5eYEjUeR59hdY1NTIMrT2otMW3AImFv0Cbw8bfQOLmUq1ka4zsj+iJCD/++21M4ZJFqu8FPpwD2UI5apOiyYJc+AstRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479554; c=relaxed/simple;
	bh=lHlNVBvig/pgfgHgHRU/PkbsKZHNyb87BjkgNDIW6QE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jzgMgf2dvfVfvn1uQeC/lFMftjtynEusdhKuXLLidVd9X8pgn9AdVs4mopdZVZH3+GKkxKYQ8qv1gXy4WsHpyGjgTQ6j27VSfWwA5aLdmyRyQZiGjhypIHrvoidJQD0vSlsvHnngAGXdr557TQAElGjRFplbWLm8PwrtKcy5drE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGwIAlvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDB6C4CEC4;
	Mon, 16 Sep 2024 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726479553;
	bh=lHlNVBvig/pgfgHgHRU/PkbsKZHNyb87BjkgNDIW6QE=;
	h=Date:From:To:Cc:Subject:From;
	b=IGwIAlvtZgOxe5pkyWwGlf9aNCeghOAVcYhE2BBdlCklqJHX/4TUt5sEmbvvSCAZr
	 YfwF4THCVj+IHaeibbxBlGBNbz6ptj27DDotWzVZJvlVQCqHmHs93Z4nSEVhBTWOlX
	 9jCwkQtpZv2J08Mo0KnnF31XBP9QMdbAdeLIswc96W0FyA2wjttvO6BEBU8egOuvvl
	 E1k1JElGzHiW9abs0D67cEzJu8NHlGq1VktKA1IP1jDYSokJ/TwlOaB32W8eXQP5qY
	 oBZ8k/IqVdhQ8RnL3MuHHKPmi35HYawf+kJREEYCjXXgcr6cKiO9Fbb2H6LwT+r1C7
	 ehCNeJ5N1/IOw==
Date: Mon, 16 Sep 2024 02:39:12 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [GIT PULL] hardening updates for v6.12-rc1
Message-ID: <202409160146.2E6CDE4C2@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening updates for v6.12-rc1. Most of this is
string_choice additions, with some more straggling flexible array fixes,
selftest build improvements, and a new check for nonstring arguments.

A notable conflict is that str_up_down() got defined in drm too. So it
needs to be removed during the merge, which is rather awkward. It was
solved in linux-next with this:
https://lore.kernel.org/linux-next/20240909195939.067c1c13@canb.auug.org.au/

Thanks!

-Kees

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.12-rc1

for you to fetch changes up to c121d5cc3a993cdbfab46a152bdd50227a4d5e8c:

  lib/string_choices: Add some comments to make more clear for string choices helpers. (2024-09-05 09:50:16 -0700)

----------------------------------------------------------------
hardening updates for v6.12-rc1

- lib/string_choices: Add str_up_down() helper (Michal Wajdeczko)

- lib/string_choices: Add str_true_false()/str_false_true() helper
  (Hongbo Li)

- lib/string_choices: Introduce several opposite string choice helpers
  (Hongbo Li)

- lib/string_helpers: rework overflow-dependent code (Justin Stitt)

- fortify: refactor test_fortify Makefile to fix some build problems
  (Masahiro Yamada)

- string: Check for "nonstring" attribute on strscpy() arguments

- virt: vbox: Replace 1-element arrays with flexible arrays

- media: venus: hfi_cmds: Replace 1-element arrays with flexible arrays

----------------------------------------------------------------
Hongbo Li (3):
      lib/string_choices: Add str_true_false()/str_false_true() helper
      lib/string_choices: Introduce several opposite string choice helpers
      lib/string_choices: Add some comments to make more clear for string choices helpers.

Justin Stitt (1):
      lib/string_helpers: rework overflow-dependent code

Kees Cook (6):
      string_choices: Add wrapper for str_down_up()
      coccinelle: Add rules to find str_down_up() replacements
      virt: vbox: struct vmmdev_hgcm_pagelist: Replace 1-element array with flexible array
      media: venus: hfi_cmds: struct hfi_session_release_buffer_pkt: Replace 1-element array with flexible array
      media: venus: hfi_cmds: struct hfi_session_release_buffer_pkt: Add __counted_by annotation
      string: Check for "nonstring" attribute on strscpy() arguments

Masahiro Yamada (3):
      fortify: refactor test_fortify Makefile to fix some build problems
      fortify: move test_fortify.sh to lib/test_fortify/
      fortify: use if_changed_dep to record header dependency in *.cmd files

Michal Wajdeczko (2):
      lib/string_choices: Add str_up_down() helper
      coccinelle: Add rules to find str_up_down() replacements

 MAINTAINERS                                   |  1 -
 drivers/media/platform/qcom/venus/hfi_cmds.h  |  2 +-
 include/linux/compiler.h                      |  3 ++
 include/linux/compiler_types.h                |  7 ++++
 include/linux/string.h                        | 12 ++++---
 include/linux/string_choices.h                | 29 +++++++++++++++++
 include/uapi/linux/vbox_vmmdev_types.h        |  5 ++-
 lib/.gitignore                                |  2 --
 lib/Makefile                                  | 38 +---------------------
 lib/string_helpers.c                          |  3 ++
 lib/test_fortify/.gitignore                   |  2 ++
 lib/test_fortify/Makefile                     | 28 ++++++++++++++++
 {scripts => lib/test_fortify}/test_fortify.sh |  0
 scripts/coccinelle/api/string_choices.cocci   | 46 +++++++++++++++++++++++++++
 scripts/remove-stale-files                    |  2 ++
 15 files changed, 134 insertions(+), 46 deletions(-)
 create mode 100644 lib/test_fortify/.gitignore
 create mode 100644 lib/test_fortify/Makefile
 rename {scripts => lib/test_fortify}/test_fortify.sh (100%)

-- 
Kees Cook

