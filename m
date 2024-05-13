Return-Path: <linux-kernel+bounces-177311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0D28C3CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6B81C211D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BA7146D4D;
	Mon, 13 May 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS0DKQX0"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6552146A8E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587030; cv=none; b=PVUrAsQkT0J7cJ06gjLfrjoPgxzdRt4SFzyfc8OlAZxaCm23xUHDOgUoLDJL5IGyyXX7SHMYwCn1xKMpXhzb8LJWQmQtQOhTFG18Bx5bf6BothLquGFQVf9hAQdKXckRvRICqzCSNMgYWbNilkbwYvfyHhYrwA+htl9tWs221L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587030; c=relaxed/simple;
	bh=FrWhayP5qWvaagrCCPD121wDeuxuPzsweoCZXCHaWFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgGjMGYhv3VXiPgbtFugd4JHD7bV+RTyz2URLcgFBgsR+A86b7bToBPhh7ro3Oee5J0glojtowk21aDvk+f6P8BZfxxCKEvaLzDsFMGgO0Wldx6bTjjv2vXOTaomKqzwpWDsnXRmhOlDdOGObRvIW7RmKvPZZ1aYA8MUfUuAqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS0DKQX0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59b178b75bso758948266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715587027; x=1716191827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsCF8cRPzCwLqfZ9Sx6lTmA2VXF/bwry4jJkEGhVAD4=;
        b=eS0DKQX07kypP0HSuHYf1Im2gCro6cAt+bZBOOReNThz50F52NS47CC1ZiQlIIPnOa
         Shn5hw2kTtZg/FilzAibHOI/raa0kAfVPiyXsziYpIO28Z97W2nOUiVoUbjXV/ktWh7m
         z5ezxgkD1fU0nbw8rwxJTMk5PQY0AlJmBF8FQhD0UlBH92Eb3Kc71xZ8j54yMW6EqS/N
         v4+l/IweMtwrkKNeG+GEc62u+PJKlvSgkXsGyREzkau3ftAzrBo9LzuVD5P9FtULUWCW
         TePC8ckmGAlHAhmzgSSt4KesxKvXdEY7f5Okv0EHt7g8SN6CBW5E+4abRK6zYcIyMrRe
         qzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715587027; x=1716191827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsCF8cRPzCwLqfZ9Sx6lTmA2VXF/bwry4jJkEGhVAD4=;
        b=sVctbKy7EOMAMft4lFEMFVJMWWXnSWpS3kKc/JObwm3SHgpXmo+qjnqj97e1RRsee5
         iffrnj5rfuDqlYP1wCukdNdafAiZlgNCPzCcDeCsXSOKPCQqNLepJdX4gcM93wBnBs6c
         VqEgPcF55bjV0texXgf2B6cOkleKi1c9fMOSBSjEVONs6OCpIXK6FfzwyNSlfI1tSs3k
         NFCrnx7BMPoSquuC9S8+bUzs4Nr/6OhJlbc3ddBxVe5VJbNWQUzbUwaFUOIggU7LM2ar
         xJblAUeTjRBnidKUT7hyvjCtDydVpgA2RiYOs3vWyl6GzhVJlGkq0Jy3jW/WEc9dDiBZ
         W2ew==
X-Gm-Message-State: AOJu0Yx9yTvny2eyl6qGQBLZ0hyTSfAwKbHf8Q62vYQwktAWOUrlpcja
	WpG7v9M4tiCfAoP+CrqyF5ZJXOTeB9qRbMrij/ZEMdENvDisu7Ma
X-Google-Smtp-Source: AGHT+IE8/dAFszDxwarToO/yXTIx2h62iOfUxFu2KY2QLootvpIkwvMqwOovG070Ac1HiIpU8oNUdA==
X-Received: by 2002:a50:8d16:0:b0:568:1882:651f with SMTP id 4fb4d7f45d1cf-5734d5cf95amr6776169a12.25.1715587027052;
        Mon, 13 May 2024 00:57:07 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2d5436sm5851961a12.62.2024.05.13.00.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:57:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 09:57:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [GIT PULL] x86/percpu changes for v6.10
Message-ID: <ZkHH0E9XmbUSEzA6@gmail.com>
References: <ZkHFtnfjXcZQX5ds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkHFtnfjXcZQX5ds@gmail.com>

Linus,

Please pull the latest x86/percpu Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-percpu-2024-05-13

   # HEAD: 93cfa544cf9e4771def159002304a2e366cd97af x86/percpu: Introduce raw_cpu_read_long() to reduce ifdeffery

x86/percpu changes for v6.10:

 - Expand the named address spaces optimizations down to
   GCC 9.1+.

 - Re-enable named address spaces with sanitizers for GCC 13.3+

 - Generate better this_percpu_xchg_op() code

 - Introduce raw_cpu_read_long() to reduce ifdeffery

 - Simplify the x86_this_cpu_test_bit() et al macros

 - Address Sparse warnings

 - Misc cleanups & fixes

 Thanks,

	Ingo

------------------>
Uros Bizjak (11):
      x86/percpu: Convert this_percpu_xchg_op() from asm() to C code, to generate better code
      x86/percpu: Move raw_percpu_xchg_op() to a better place
      x86/percpu: Re-enable named address spaces with KASAN for GCC 13.3+
      x86/percpu: Enable named address spaces for GCC 9.1+
      x86/percpu: Unify arch_raw_cpu_ptr() defines
      x86/percpu: Do not use this_cpu_read_stable_8() for 32-bit targets
      x86/percpu: Use __force to cast from __percpu address space
      x86/percpu: Re-enable named address spaces with sanitizers for GCC 13.3+
      x86/percpu: Fix x86_this_cpu_variable_test_bit() asm template
      x86/percpu: Rewrite x86_this_cpu_test_bit() and friends as macros
      x86/percpu: Introduce raw_cpu_read_long() to reduce ifdeffery


 arch/um/include/asm/cpufeature.h  |   3 +-
 arch/x86/Kconfig                  |  14 ++--
 arch/x86/include/asm/cpufeature.h |   3 +-
 arch/x86/include/asm/percpu.h     | 157 +++++++++++++++++---------------------
 4 files changed, 78 insertions(+), 99 deletions(-)

