Return-Path: <linux-kernel+bounces-417083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 393289D4ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26491F2164F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9C91D8DFE;
	Thu, 21 Nov 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4v66zc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9171386D7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200167; cv=none; b=OV1yvk+a7YuFVdIVI0Wz0SDV+RTQ+BmesIW+VliEifYjD/dbhMHdOxVnHfW/wIOTJnsjyFimMbHNp2RPyve3XK8yefJskFVM35noW0IQkr19r1b48tJ5Qf/DZnsbWvsBMKrKmP73IaUtnb9dNNCGQBiXZk31se1iCbv4tD1KLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200167; c=relaxed/simple;
	bh=NR/OHXwCM+eo9mu8Us7MlHfhKk4sKAiJeX05gkoqoAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F8rAdSbBGfTVnCyOmcULZF2INA3n6Y4/IoAfw9THndJvtpP7Be1MliTXrREFOdaUtPYLZglLSI1pZqJXso2Oz7aKIVoqc8BO0XBAzZjaItwr+SMopyWRzubxsTEo6Vq0EZujtZ+Vq7PzaANtP16bCISmej6uUQHSch2FnZcISpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4v66zc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF41EC4CECC;
	Thu, 21 Nov 2024 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732200166;
	bh=NR/OHXwCM+eo9mu8Us7MlHfhKk4sKAiJeX05gkoqoAQ=;
	h=Date:From:To:Cc:Subject:From;
	b=I4v66zc+b1oxlnru0HwzlpW7D+h/3hq8gg29UjcpNbXjNNIGbDgodocnm4m/tfamT
	 cI7soxT0yLHwAz77h+AHmS51iuFpdpiyg3gV/O5SvaJYOhBOST0x3e/e2JrraMtxm3
	 GQSPI+dy6vowemXwC08ijyMZpwoQtWP9/VkFRq8Xx28qoC6UaJWaRn/b173f9ZdZJh
	 JtfnhhY/K5t7gVZspn1y7/PdtImRtnyc+wmcPI499LOabp5lU7HrxSIGYtN86G5/Db
	 h0hcCSPAGhHliV4c8OZBU4cFA4Z55fIwUBKhafvwSl0sotWxItVklAclFyBMq2ZUeh
	 dgC3iSmXRa8Dg==
Date: Thu, 21 Nov 2024 06:42:43 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Kees Cook <kees@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [GIT PULL] hardening updates for v6.13-rc1
Message-ID: <202411210641.BB0D295A@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening updates for v6.13-rc1. I delayed sending
this for several days just to make sure the Kconfig and compiler.h
changes got a little more bake-time in -next since they were added to my
tree pretty late in the cycle. All seems well, so here's the PR.

Thanks!

-Kees

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.13-rc1

for you to fetch changes up to f06e108a3dc53c0f5234d18de0bd224753db5019:

  Compiler Attributes: disable __counted_by for clang < 19.1.3 (2024-11-19 08:48:27 -0800)

----------------------------------------------------------------
hardening updates for v6.13-rc1

- Disable __counted_by in Clang < 19.1.3 (Jan Hendrik Farr)

- string_helpers: Silence output truncation warning (Bartosz Golaszewski)

- compiler.h: Avoid needing BUILD_BUG_ON_ZERO() (Philipp Reisner)

- MAINTAINERS: Add kernel hardening keywords __counted_by{_le|_be}
  (Thorsten Blum)

----------------------------------------------------------------
Bartosz Golaszewski (1):
      lib: string_helpers: silence snprintf() output truncation warning

Jan Hendrik Farr (1):
      Compiler Attributes: disable __counted_by for clang < 19.1.3

Philipp Reisner (1):
      compiler.h: Fix undefined BUILD_BUG_ON_ZERO()

Thorsten Blum (1):
      MAINTAINERS: Add kernel hardening keywords __counted_by{_le|_be}

 MAINTAINERS                         |  2 +-
 drivers/misc/lkdtm/bugs.c           |  2 +-
 include/linux/compiler.h            | 11 +++++++++--
 include/linux/compiler_attributes.h | 13 -------------
 include/linux/compiler_types.h      | 19 +++++++++++++++++++
 init/Kconfig                        |  9 +++++++++
 lib/overflow_kunit.c                |  2 +-
 lib/string_helpers.c                |  2 +-
 8 files changed, 41 insertions(+), 19 deletions(-)

-- 
Kees Cook

