Return-Path: <linux-kernel+bounces-188123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6CE8CDDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CB52827F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB112882D;
	Thu, 23 May 2024 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NtZhfVkN"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5BB662
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507480; cv=none; b=Ax4PgprJHm8S46cLdG6F0rgKthJyNfKb4edwUPcWPy+Od0czYfcfI5pyg2r+Br8gnlNCVH7QKtXmdGydCVMO7MPjqaN/SOQFLhfgRhs+w7YpNImPNNZxiv3nBbJk539/C+YbKV+zMc1UWKW82BXjHnlbhX/tpjilsBURPVkyl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507480; c=relaxed/simple;
	bh=UXKFPEgBt1shyLFWACYfhbcAuinf7zOUpp60xD/sk/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kB4CHnnaQ+ORhrMxguc4zfvATNKyzQDzsk8VhqeiDigw6/woS5oU3pGij7Nb5HWpz5+ohX9xfoDxybl8eJuwjzT8d3F3uEBNt5Bd1KYxDfe35z9YYSHjl+qMs84wAMfwEe96G83rC4xl4KNU+H2WJF6xlLpxEPNZGRlAuxGA69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NtZhfVkN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f8eba8dcfcso292374b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716507478; x=1717112278; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i5p16vmI0HEdT8v1Ioid4J1CsPTLKqm29ENKWLAvzvY=;
        b=NtZhfVkN6ymZLGdmAW5G94hMQBo9NjEAQwM/w7QNeeNsZFMUeEVhbiuryNcz1KkL0w
         5luOqIrnBu1kJ+QrCJ8lVpHnFnuw7EcL2KpMcsF3EbMzbJSekwClBJatLHhaQxbfllKf
         2cAVuEJJCO+FDz6xpqyYsUEpriWnbSro3uVXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716507478; x=1717112278;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5p16vmI0HEdT8v1Ioid4J1CsPTLKqm29ENKWLAvzvY=;
        b=qjwzOEzqEGBNpyTNqDWwF5rAqA8k5oP0vYb7tVrKu4zDC2G5H/DvB7v66JsDHes1Yd
         a4VgpoDKurfZdve8f4GKA1s9eoYXgLzUPvECGI+kHsqU2c5q5zVCTRcanJ2TJ1+yDdlU
         9KczNweLNJOlnvpI33eywKdfrFZdbzeo9B7YHjrUKHi6y4Xb3TQ3RuESRKtBpFTtn+dk
         bWGKOBOS+npTQalv3DZJzEKbv5/4WwRMCH31C0Jh9v+MFbxkUp+TWpOwgYcSSPevqUbe
         IhXUx5AX91e0vv6TTGqLAGga1m4q9MmoGUHUbjLp2WoUoa8jzg44A5sHOF976ca340y5
         dLjg==
X-Gm-Message-State: AOJu0YxEODASt5pWX3Q1jpPlEMlVdKL71G4bF24TriWFiCpbc5k5e5RN
	0+mViLpoQ6VYHc+hF/CPAgh2ZUKD7BqaZwoUPNwz6fA7ywY4xt63rLlaPH+OcQ==
X-Google-Smtp-Source: AGHT+IEgWVe06eCogPz5mYMDcL8BDBujFYYt824nYUAtrmEJegrEn7sQNGn9HywiRs5cx80JnKHG7g==
X-Received: by 2002:a05:6a21:99a4:b0:1a9:c4ca:dc74 with SMTP id adf61e73a8af0-1b212ce1f54mr1210005637.5.1716507477857;
        Thu, 23 May 2024 16:37:57 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc36c608sm155393b3a.92.2024.05.23.16.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:37:57 -0700 (PDT)
Date: Thu, 23 May 2024 16:37:56 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>
Subject: [GIT PULL] hardening fixes for v6.10-rc1
Message-ID: <202405231637.664DFA26FA@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening fixes for v6.10-rc1-fixes.

Thanks!

-Kees

The following changes since commit 6d305cbef1aa01b9714e01e35f3d5c28544cf04d:

  uapi: stddef.h: Provide UAPI macros for __counted_by_{le, be} (2024-05-08 00:42:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc1-fixes

for you to fetch changes up to ae1a863bcdbd6ea2abc93519a82ab5d715d5dcbc:

  kunit/fortify: Fix memcmp() test to be amplitude agnostic (2024-05-18 13:46:10 -0700)

----------------------------------------------------------------
hardening fixes for v6.10-rc1

- loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without module decompression
  (Stephen Boyd)

- ubsan: Restore dependency on ARCH_HAS_UBSAN

- kunit/fortify: Fix memcmp() test to be amplitude agnostic

----------------------------------------------------------------
Kees Cook (2):
      ubsan: Restore dependency on ARCH_HAS_UBSAN
      kunit/fortify: Fix memcmp() test to be amplitude agnostic

Stephen Boyd (1):
      loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without module decompression

 lib/Kconfig.ubsan        | 1 +
 lib/fortify_kunit.c      | 2 +-
 security/loadpin/Kconfig | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
Kees Cook

