Return-Path: <linux-kernel+bounces-518947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD6BA3966E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333AA178548
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B980B22B8C3;
	Tue, 18 Feb 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EHKVsVAl"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4DA154C12
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869339; cv=none; b=cFaIVzFn+W/x6E4MzyuGyjjSerQNrdbnPS/DDdZ1CS3hB7XcGc//wUIHJXg131vk8kLNcCT/nYyRaHRphaUlfS4vtQgge0287KBfqxUmyI2/43k0rWuq3JaqE2UnHNybYvT+C+dm35enNKpq4yQ2An1YOBCU1/eu9hdb5SVbqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869339; c=relaxed/simple;
	bh=oarkjXVLNesvBgN+1HvI9A2bxn4Y0qdmQIl4RN1lPtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/vT7GXbUFWR/7f+uiz5tiV7ZTd6Uhh9SjSLzin4NnstL+jPuVDkbcbBkji6t+rMK9mY2p1Isu7bRF2MncjMYozbyNUTBkZ1O6olnGilO0lmw90VrHa/pjje4NNLk48d9jEwrkHtgiwYVgyeUyU2yF3yclcL8QFDTCt76At/JMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EHKVsVAl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaeec07b705so778644866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739869335; x=1740474135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4NUZe5vZLnQIBsjbsiyFT1DNPvBzyyucEtcVSRHJCo4=;
        b=EHKVsVAlSNDMP1Vi/XD+ri3MhxFxMbSUykq5weBo8Go1sNxdWAN87eQC87xL10Jwwd
         vG/RuEjJhHC8Ll8c0wQE2/LM31rL46nWo258ZDOUcTGvAHyAXL48ieZ3RzAyU4ZkLbKT
         nOmxgz6MlASG8uRpxNSOuovgX4qVfYgWBxqeciv6TegzVe7xfA370BAGe3GSSHYlH6Cw
         tbeFkL3Zz81/XDDjMB1VVzCUO0MEAaZdgPBQuxg7N/4Fc7N0fPMrgG4xsui4EvAA8gNL
         zv3MwQA1KxMIzLMwLk0XTRBm+6VDBC90rj2YmA44VZ+PnV6znCDBbMe3TWIdRhZlWYPt
         a96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869335; x=1740474135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NUZe5vZLnQIBsjbsiyFT1DNPvBzyyucEtcVSRHJCo4=;
        b=K8aL+cm7pUAG4QhKmTR0PmLJUetcN+gruKBmnk6fcKbpFyPD3x/02NU8wJcxzSgsvE
         pwhG4tWsYHLECAWtBAYxRoUOmhIsx7tLHW789DmhTAGbhhErL77YN8UXLlCn6R/qymGd
         rRmDGdcPGOXJDUNvV/A1trE/+7re2iSG31O8SdhtC0zWDEYnZIiW7QqL+ZvkT+sU8m9t
         aMIyox5MGddJPkAaqz4Gh6CF2FbGBvLys1KjzA2dQfxXaX/ccy84gCQhLfbos2U87tet
         R1qbOpg/RVLmFPSGqT5kSREjsKg9t7LSbSSq6MkFFv1uBjr5uDiSy+pkzDeTiIZMh+J6
         xh8A==
X-Forwarded-Encrypted: i=1; AJvYcCUz38WDZQ0WI5OO/Hev0pNkpEmuAupIO+osJ99mWK/ppNrhH575MUqtRbyJ8YUZAZ9FObFgy042lZEb9xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyslnK2Q+P4oDNzaQK51rhDKOMIyFge1SXO0T8njjZeogEOle4
	D25gl/4xsKMwrW/vrRcagErbfFXrP9J+n30qsBd9XeQwIn9nHxhsqeIeCDCM0+Q=
X-Gm-Gg: ASbGncsc6UZfRNlOwa/Ot550czzmqK4UPcjK6SaUNseE4pbB+aPT+I5Az3lWLieOBv9
	6P2Q9DcHaQO1Y2uw1k/bPzTYUeH66Uwnc6QyJhGv0dF7Tdkn2XINK4LOCBD3zVCXkf2xIwKTq0r
	GTxRXB89JNziXANefXPw3YZv59OaA7H8Bb7j5lkbgVakTa29jwwgBeKXRG9aqWPtyGH+tO51bm3
	RKlyyg0JhP+0ZuzyO5UHihCl6bLCt+Uv9/rd7ETFoqWAJOnWH6kOH2Te+FhYynxi/zxgI2Wk+fb
	hF1KVU42FeOZylAWfMo/4GRNQEl7Y7nF8wLcedk=
X-Google-Smtp-Source: AGHT+IEVKDOaJ8wgRnpp688LJVlZFeYtPJ8ll89AQslLn/CISzFdJoslLGXPdUYDZ/rO+DSFM5ORrg==
X-Received: by 2002:a17:906:370c:b0:abb:519e:d395 with SMTP id a640c23a62f3a-abb70a959d9mr1056524866b.20.1739869335339;
        Tue, 18 Feb 2025 01:02:15 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb89ac2e27sm477482966b.80.2025.02.18.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 01:02:15 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v2 0/1] MIPS: Fix idle VS timer enqueue
Date: Tue, 18 Feb 2025 10:02:02 +0100
Message-ID: <20250218090203.43137-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch aims to fix idle routine while the CPU receive an interrupt,
because __r4k_wait() only checks if TIF_NEED_RESCHED is set before
going to sleep.
The same behavior has been changed in LoongArch [1].

Code (cross) compiled successfully and I manage to test it on a VM
emulating a malta board. I ran QEMU with:

qemu-system-mips64el -M malta -m 2G -kernel vmlinux -serial stdio -drive \
file=rootfs.ext2,format=raw -append "rootwait root=/dev/sda" -cpu 5Kc

rootfs generated using buildroot (malta default configuration).

- [1] https://github.com/chenhuacai/linux/commit/a8aa673ea46c03b3f62992ffa4ffe810ac84f6e3

Changes in v2:
 - Changes introduced by Huacai:
	https://lore.kernel.org/linux-mips/20250214105047.150835-1-marco.crivellari@suse.com/T/#m75d9c587829e15e0d7baec13078be4e65c936408

Marco Crivellari (1):
  MIPS: Fix idle VS timer enqueue

 arch/mips/kernel/genex.S | 39 +++++++++++++++++++++------------------
 arch/mips/kernel/idle.c  |  1 -
 2 files changed, 21 insertions(+), 19 deletions(-)

-- 
2.48.1


