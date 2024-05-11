Return-Path: <linux-kernel+bounces-176698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026848C336B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7945CB210C4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 19:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568691CD2C;
	Sat, 11 May 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SG8+yz9n"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740E1B974
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455466; cv=none; b=QMZcAKs96kwD313OQvRNM4UmrnCXHEvhGhSbXpRdeyJlqKhB/dkFnce7dqWh9Uz6XbkqJHpV4EcapVnMvw1qiuuyB39Yg6whd6WojQB/FN3/Npp+S4+1W0UGYtCD+K1EZfw+gQoLeknDQrsu+5szq+ndFQOMy+whROdpNkmUG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455466; c=relaxed/simple;
	bh=3M3BD0Y1waNGEJ50/Jp+zcuKpSFwkiU9LMCkhhKwLkM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jJXst2tctXcobFZ8x9dYXJ7pMkNWjVPfIQQbbZL2LYrrEkdQn7zViJEXXCO0KfOj9oe6zNL18lCf7ciKqBQt2rcu8bYoiFbwSBFTv5RiDemY0jVIlRUpBGpJ1hHtHTPr0XjS6dwZt15u/juuN6IQ9mkH9pwPOC9J7W68YRlT+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SG8+yz9n; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec486198b6so24901265ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715455464; x=1716060264; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4TXunqFT0uWZjzeItEBoMExIHFBPOqppPsH/ewa57k=;
        b=SG8+yz9n5HefYYdHONHu5GutU25ud+0zWKYXqR05ScTAiJwBbZAUE/cV3m2DZ//KYi
         1TrjZLQIx8DVEHsLcOwAk1gyk0R6dkEUShqEGSkeM7WVcU5iWNQa64QC+QMJzllwTg52
         zi3sKaAyMBe0SfV6KA5cSGG5KOFTCQR4F7FR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715455464; x=1716060264;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4TXunqFT0uWZjzeItEBoMExIHFBPOqppPsH/ewa57k=;
        b=pc8pJoQW/kZIkBhBNoVFluSEvnWd2NfXl3AqqgCJbylB/s6P5Xfn2GvCMKtFpBNJ7U
         uUKpwakt59++RBKj5TAuZ4i/ZXqxtqcyi2zqO6H2lhYPiuz0MHgEbqkA3Ygg6AewT8a6
         QzNu/zIKGFg/c3ZvYqTaH72kOrHwH7n7lMymQYgUrgruOujc/iLRKOFraqTqVwnqciS0
         9sdT97GTcMX976uHKfoYvthFpCT20fueW3PeIHr/+cQCdL7sC74cPiWLsZYopsompkIo
         Lci6CI097lChZF1KHwDAgcI1Dvp1gdQkZZt48mt9ivIpNeVlEL6NV5bt6wvJhm6BGWpc
         PojQ==
X-Gm-Message-State: AOJu0YwJhu476R7lDK8sJtTqdQ2fxGUS7I3EppMK17AbfCI9fvaJ52IM
	uxCh7wBGYuraOhTfb9Tq7qnPy+nELbTcTa1ThVpRPL8KgnNBIQol59oPUlFwJw==
X-Google-Smtp-Source: AGHT+IEJVU7zaydZKcShtnNIoFAqoVZlJBivk4Jjb4VaOGiC2l0cgmIMc+ip+IHTdcK00ww4BIou2g==
X-Received: by 2002:a17:903:2292:b0:1e8:9054:101a with SMTP id d9443c01a7336-1ef441a690bmr75036825ad.60.1715455464695;
        Sat, 11 May 2024 12:24:24 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c15d516sm51984105ad.274.2024.05.11.12.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 12:24:24 -0700 (PDT)
Date: Sat, 11 May 2024 12:24:23 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>,
	Jini Susan George <jinisusan.george@amd.com>,
	Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vignesh Balasubramanian <vigbalas@amd.com>,
	Vijay Nag <nagvijay@microsoft.com>, y0un9n132@gmail.com
Subject: [GIT PULL] execve updates for 6.10-rc1
Message-ID: <202405111224.433C7AEAB@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this handful of execve updates for 6.10-rc1.

Thanks!

-Kees

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-6.10-rc1

for you to fetch changes up to 4bbf9c3b53e637eb3a14ee27b996300ce88e752a:

  fs/coredump: Enable dynamic configuration of max file note size (2024-05-08 09:53:00 -0700)

----------------------------------------------------------------
execve updates for 6.10-rc1

- Provide knob to change (previously fixed) coredump NOTES size (Allen Pais)

- Add sched_prepare_exec tracepoint (Marco Elver)

- Make /proc/$pid/auxv work under binfmt_elf_fdpic (Max Filippov)

- Convert ARCH_HAVE_EXTRA_ELF_NOTES to proper Kconfig (Vignesh Balasubramanian)

- Leave a gap between .bss and brk

----------------------------------------------------------------
Allen Pais (1):
      fs/coredump: Enable dynamic configuration of max file note size

Kees Cook (1):
      binfmt_elf: Leave a gap between .bss and brk

Marco Elver (1):
      tracing: Add sched_prepare_exec tracepoint

Max Filippov (1):
      binfmt_elf_fdpic: fix /proc/<pid>/auxv

Vignesh Balasubramanian (1):
      Replace macro "ARCH_HAVE_EXTRA_ELF_NOTES" with kconfig

 arch/Kconfig                   |  9 +++++
 arch/powerpc/Kconfig           |  1 +
 arch/powerpc/include/asm/elf.h |  2 -
 fs/binfmt_elf.c                | 10 ++++-
 fs/binfmt_elf_fdpic.c          | 85 +++++++++++++++++++-----------------------
 fs/coredump.c                  | 17 +++++++++
 fs/exec.c                      |  8 ++++
 include/linux/coredump.h       |  2 +
 include/linux/elf.h            |  2 +-
 include/trace/events/sched.h   | 35 +++++++++++++++++
 10 files changed, 120 insertions(+), 51 deletions(-)

-- 
Kees Cook

