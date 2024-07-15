Return-Path: <linux-kernel+bounces-252487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E73B9313B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86421C215D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DC018A957;
	Mon, 15 Jul 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5Tda9bn"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163023BF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045516; cv=none; b=SJp7+juPPPNVNyRIXJrYvlI7KiG/LfQ3BevzM+F2stwDWwtYlgEEG6Uy2HLi0k/S9Z8lrPD81GYyr+TnKQj42ymdcCLYG096VOu00ycFbrclSUIGZGKJYKKJmobkBrtTGqXJ+UcvBZxIeagxHHmB3DOk3w+4Z+tdRmckN8tV738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045516; c=relaxed/simple;
	bh=OUlFHb4N9a6pQv3Udiw7jTaEBxUbY0U+yQGlvY8PizU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kKV6kSFW4ujkAYmsVVy0dvuTM4weKd22zMDtJavP4R5K3hBmAmccTSE0ieXe92zvZg6eWYQ89GdHWsXdjgiqsoYZ8gBtLdT9je//BGA2rG9v3hIxMOZzQgE7fgXHYN16nG8AQ7EiqRaBA1cV1e4zg2QHSAg1pOTFFD60ECpgxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5Tda9bn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so3641095e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721045513; x=1721650313; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KeerRmptgTu2BiTvI0JQTTXHcd7DBDOkOsocDzZOaOA=;
        b=k5Tda9bn1xMbIm4YtQl68Q6K7eBgocLm8AjrFFQCLe8ATgqDHEcY8wxL5jvhbBD08y
         RAInLoTDCJJqfOisYQF1uEEs9tpFv6d2sLGPe4d5v+/43yu4ziKJ2OxvwRt9HOBSDdqO
         d1F0HL0e7lwo12nNGasm+5CdeISE/iidSvfQXTOD6OeIaOmaRhu+t7qerl5d6yFNkIZc
         21XGOUBPmydHdjLwqpQzxiXegMhSMw31lCRZua3U+yaqplZb8p+ipdVpzrTmDVBGKmSv
         780/ffDWWWJaBZNyvnMqaJWotRey0k6iT3nKzo01mLqNuQCAZzEObYVS75R7X0BHCyLY
         zm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721045513; x=1721650313;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeerRmptgTu2BiTvI0JQTTXHcd7DBDOkOsocDzZOaOA=;
        b=Xf8oaVZM1C+0AO8y46bJIb9CPf6h5AY/6logf09vc1M3zu9mTMO6FJamH3Dcl1YjQd
         9zyNhF+Wt/BJBhaKogeUxzm0eitmbMpFUOYZF+DKkqKLvPOjld9RcReUTJ4vxT0PTntS
         DYbbivfcDkqTMnP0nb/Vdy0PiEjv0gJpqc2mDgcTOwvOD5Yt93xUpqD8n4F2NFSTHA1l
         WrAVLCAxuLjsaMJWjginVsIAuH6NUP+5HH1+Wf/TPhUDYa/bqkZCxT+BChS3a5vAmvyf
         CbmGH7RGastsfwsGyWV5BKEKSI1s2ZqITIrsyNFKxBIeLd+E7eeMJV8Zl/9owFbJwTpf
         kVZw==
X-Gm-Message-State: AOJu0Yx9IvM+49LuwpiuIQ8ZVC27bPrfnVYFemN2iZ9624OZ//QY86dh
	RwQNWkuYHJcqiqw7mhfkSB7CdIu0QFAoDDm2fOx02JGEqqZMWyc3
X-Google-Smtp-Source: AGHT+IHaojIBrCDcBhZh0QqhSPnzlpuhN+odX7r97r7a5FigHM3gxhf3mjBQrYMP5uUazumLhO6GtA==
X-Received: by 2002:a05:600c:49a6:b0:426:6dc7:da94 with SMTP id 5b1f17b1804b1-4279da43575mr62603415e9.20.1721045513050;
        Mon, 15 Jul 2024 05:11:53 -0700 (PDT)
Received: from gmail.com (195-38-112-86.pool.digikabel.hu. [195.38.112.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e827efsm86249615e9.16.2024.07.15.05.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:11:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 15 Jul 2024 14:11:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking changes for v6.11
Message-ID: <ZpUSBpYTFbyHtQBv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-07-15

   # HEAD: e81859fe64ad42dccefe134d1696e0635f78d763 locking/rwsem: Add __always_inline annotation to __down_write_common() and inlined callers

Locking changes for v6.11:

 - Jump label fixes, including a perf events fix that originally
   manifested as jump label failures, but was a serialization bug
   at the usage site.

 - Mark down_write*() helpers as __always_inline, to improve
   WCHAN debuggability.

 - Misc cleanups and fixes.

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      cleanup: Standardize the header guard define's name

John Stultz (1):
      locking/rwsem: Add __always_inline annotation to __down_write_common() and inlined callers

Thomas Gleixner (4):
      perf/x86: Serialize set_attr_rdpmc()
      jump_label: Fix concurrency issues in static_key_slow_dec()
      jump_label: Clarify condition in static_key_fast_inc_not_disabled()
      jump_label: Simplify and clarify static_key_fast_inc_cpus_locked()


 arch/x86/events/core.c  |  3 ++
 include/linux/cleanup.h |  6 ++--
 kernel/jump_label.c     | 74 ++++++++++++++++++++++++++++++-------------------
 kernel/locking/rwsem.c  |  6 ++--
 4 files changed, 55 insertions(+), 34 deletions(-)

