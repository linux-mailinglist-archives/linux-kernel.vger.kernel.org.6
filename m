Return-Path: <linux-kernel+bounces-255274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25287933E42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EEC1C20F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C894181305;
	Wed, 17 Jul 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwewpGvZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CF2D61B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225878; cv=none; b=jr9ltPVhl4FUTISlT90uzRpBcafvQF9aQeOPHva/ctnqTObZ0+mLUXyLz1FPCwcji8SlV0ulKw4FZk8xOg08g+QvYY0ApX36XYOgudCGGrFTotZYjtD32X4zaloZtBtQnKMr2hptQ9Pp0OwdabDuVVBYEEec6ok1KpWEx3JnJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225878; c=relaxed/simple;
	bh=drrYBCkJhMDvlWi9iyiyn9sbycuyWgXRTcThFv75UK8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QTWvCFYXTsmPICQzua0geELL7d3CA88iFBw5gOdm97Q1UvkLgZezu9dHv5FMptvxDGz2eBRe3Ibx0atL42EwSHtcSE8DUx1VjFE/wYSTRC5Rsu+vXZiIFiYBVFupm0uoxfB/2SaMw2poKUg0e18CuX5dbs4II07xurdL21KWJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwewpGvZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367a464e200so4182163f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721225875; x=1721830675; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kg5TTmeui3v/2YFxASoFFkiLbEWMTeu79bTJ/CQZFzQ=;
        b=HwewpGvZFHnOy2+dbVuvA7GTT986hIiNSGE5YjARVhr3YD2FZsb383GE1Xx+6nwhhN
         xO4FZFQGfLd9gFVrJW/VtTi9HEj0UN/FmrEnClwOd/DEQ1ijOTzxe1CR49yZJG79s/En
         dEkcyjelBcqSkFllkQvRscWpkb3Szt4phDoRPi8JVnoSaXHOT2Wpuua3yv+pVtbVvFUm
         vgrjVIXXv1kJr7yGEugMBGaX/AeXt9RB9uJcnPbXIbARdsrKetHDzGgLripMQ8doNUDO
         cpdODhmiMN4KPAf+KHT/K/A9hIt9HdJW5j61JoXvDlM+//mqbj8+wKxIUhYIhytCwBma
         S2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721225875; x=1721830675;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kg5TTmeui3v/2YFxASoFFkiLbEWMTeu79bTJ/CQZFzQ=;
        b=pJVCvHLthqIHhfuVyljN5oqgtE1B+zfwCVrf9FD6ChB2Mh4kiyhJOzQmE2v6bAMCct
         kXUlomP+w9Lz4ZJ7lNVsTMIbCfJdO6mnGhfVM8b4NlPQ/zNozRcu5WnVpTvHdI18Lhzz
         zOr6snEhB0aIQjE9bzY3TesiZ4b9PfOq72o9GW8xwtD06eoeTxpV0o+HlH0E0ynNN96o
         icD/MboM2YwbJB6XWTQno4WNOuM08szAm1AcDP9cIEqfwxAtvUh9oR0MPU5Oc7xuYLzz
         JNgPjQe/3jWNtda1QjCD+fghBGRUTwTlXDFvkNxuQABzh13cz0XszjSEoEYKIeEaU4Rb
         xZmg==
X-Gm-Message-State: AOJu0Yw2girfE9BN1Z5n7hkNHw1D2Jq6DCXCiowlEnFKuSbvN9AEz9Mh
	UzpQH1mvwKu7ImLiOIHONcgly2YMeWHT3gegVntJ4nr0+wYfbl+o
X-Google-Smtp-Source: AGHT+IFpeKDn0fISUnQ5/zPHM58nhU2GY5wAQX1GQsZQCj7Rph59zN7xLm092VnMTZz63wNqWkObkQ==
X-Received: by 2002:adf:cd81:0:b0:368:3b1a:8350 with SMTP id ffacd0b85a97d-3683b1a83d3mr949244f8f.19.1721225875149;
        Wed, 17 Jul 2024 07:17:55 -0700 (PDT)
Received: from gmail.com (84-236-112-196.pool.digikabel.hu. [84.236.112.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3e1csm11851192f8f.2.2024.07.17.07.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:17:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 17 Jul 2024 16:17:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [GIT PULL] x86/percpu changes for v6.11
Message-ID: <ZpfSkENjiIL7HGJV@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/percpu Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-percpu-2024-07-17

   # HEAD: 47ff30cc1be7bf426c03ecc84371452109b416e4 x86/percpu: Enable named address spaces for all capable GCC versions

x86/percpu changes for v6.11:

 - Enable the named address spaces based percpu accessors optimization
   on all GCC versions that contain this feature, detected through
   a build-time testcase. This effectively enables the feature on
   GCC 6, GCC 7 and GCC 8 versions.

 - Fix operand constraint modifier in __raw_cpu_write()

 - Reorganize the per-CPU headers for better readability

 - Misc cleanups and fixes

 Thanks,

	Ingo

------------------>
Ingo Molnar (2):
      x86/percpu: Clean up <asm/percpu.h> a bit
      x86/percpu: Clean up <asm/percpu.h> vertical alignment details

Uros Bizjak (8):
      x86/percpu: Introduce the pcpu_binary_op() macro
      x86/percpu: Move some percpu macros around for readability
      x86/percpu: Unify percpu read-write accessors
      x86/percpu: Introduce the __raw_cpu_read_const() macro
      x86/percpu: Fix operand constraint modifier in __raw_cpu_write()
      x86/percpu: Rename percpu_stable_op() to __raw_cpu_read_stable()
      x86/percpu: Move some percpu accessors around to reduce ifdeffery
      x86/percpu: Enable named address spaces for all capable GCC versions


 arch/x86/Kconfig              |   3 +-
 arch/x86/include/asm/percpu.h | 535 ++++++++++++++++++++++--------------------
 2 files changed, 281 insertions(+), 257 deletions(-)

