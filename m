Return-Path: <linux-kernel+bounces-538277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB66A49695
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481371733B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2825EFB2;
	Fri, 28 Feb 2025 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YeymNtEG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB56625E81C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737122; cv=none; b=RumSTYiE7zO/jiv33SVnfBKnXqM3jnE0AYrllIKkJgNlLRUeMhpga5nKFQ/KxkC5Epds+xoOM320ZdRxWBu0WyXaSgAb4tWV3FeZWZUEzvg4ysPWUAUbj1WwGkdt9Mz1hk8hPfrHRld+f02vrHq2sk4OZBJTVBBuGJBEA1jn96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737122; c=relaxed/simple;
	bh=Qzc5AefzWg5/rKF/uU4VJIoRT94mOKd/qPMsAj7dTT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAuZaiJVIpdMUNIBU87ceZ4oQeDI9X6BghMspZzi+hjdqPiUM3C2GArzMvibkAjdxdOUGVGc9T74Iz55R5nDiZiXpcy++7AuM9m6iB3mm5sots3krlY+/lSGPMvLBc8x5LRneWAGgNYQSv9wnvJpUv9kytw06b5rw+ZpXavZ5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YeymNtEG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43996e95114so13295425e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740737119; x=1741341919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yL9lEyEquO86Kxl4vX11fM0ypvSY+BpBD4MiVL6upRc=;
        b=YeymNtEGWUEvGcimFCHJQNxxnMirY58ihEOBqtnPP5ld+gTGvwA9AaaEi83OS3ndRw
         iDvPw1pxXXkT5QHmwIhx46eUBPetAKnpUkxrx4dejNzdF382KmboxsmJPAmRFG9omHMG
         v+FXy/VmsOZBRjkvWiwXysEBCe7E7iQAQ7Um1WAxlX5pk7G9uacqvdudukHRPvPAi/d9
         fup3UzNKpKNj0a/4H+zvP3QwPUb3a97e03M+5/gzE48WfLdBHSkFi4esBrK1TamDqi2P
         7IxuT8tzbaJe2QyRX8XmvX11XWaK7GcPDpBeJZEGGQzqk73oh/lscI+abwS4DP34pd9Z
         JiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740737119; x=1741341919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yL9lEyEquO86Kxl4vX11fM0ypvSY+BpBD4MiVL6upRc=;
        b=s+/ZCCZC8fzuonpUP6e51wDiedqB3jZVPEeY7nwIclUCLcLVqWiwyipNBg2Clc9JOA
         w58jcbRxsQsvt+E2EinjjuS7MVbu4cBGsXo78C2pz3258i+e2vQ1+vmqBzun1IZdp3Wq
         EbrFpmBLCcxlS1Fd79DdBNnFOzNbQv0XynwXLaLryUhi31RAKkGOhz2vDpCnnF9FLbhh
         B4fiS+/prd4NKbxXDi7EvfqPBvdNQNDwrdmEIJq4NKQuu/F27b+ONi0qGuEJ9giFC8E2
         2fJ5ZAcXDjMEqq8Cr7iFaev5Tgq/NUX/Sp2EJCujnmTgHnxeAtmqMOPNu0ZEESewkBas
         iJ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4mL+ASToReI4CZ45FWJC2nD+3ISFD5fJj2xiqCIayR+bgXmVSsn7f6+TU8IVtD9eLJ0CSIkLDgpvoGNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5K1KDUmv7ZAqbFIf1XF9zYXy6Szad+/4QqaloKuDF0vsGi0w
	nXOxcwlWEFgD5SQpV7Iej2hP+xdnDsKgCplDce7pLkfQcMpnXSVilBgi9JnnHZ0=
X-Gm-Gg: ASbGncv9qfmqjSXk1vsZqgH/QOP5RpNZHgjWTfjn+yBdRi3RHEQHhiAD6kOqfpX+3yW
	5XpUtJlTKm7iFDJHLahxmfegTPEFmS0egoaiMtWja48VpAsQZKe7jahO5fUjNFsaTwnVJfLRWfQ
	IJxRlkh1eikbHcmNc79cT9Ey4DjUsWoYkuXFuFwAtb9ubyhISeLNxvOCUkLeHPN93sMnr0oi60h
	mRGbja6S3JsZeuRbsu4egjSOEjaLV4QWt8ygwOuDDVR97Zm+xiGc1PrqztMv5FMws5pQnwz5iTi
	/quGjMLCu7OwuqFSUJn/0x4p/BvF6RzZp6VsqN6fX3m4ZmhFAA==
X-Google-Smtp-Source: AGHT+IHv4FtLxje5vUdur26g0chQhVf1h8nzlJ4iyiy363YRYtipSzVslT2XWY5JjzNlUJjvmXnx1A==
X-Received: by 2002:a05:600c:a01:b0:439:8a44:1e65 with SMTP id 5b1f17b1804b1-43ba66e67b6mr21535205e9.7.1740737118900;
        Fri, 28 Feb 2025 02:05:18 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717230sm49964945e9.19.2025.02.28.02.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:05:18 -0800 (PST)
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
Subject: [PATCH v5 0/1] MIPS: Fix idle VS timer enqueue
Date: Fri, 28 Feb 2025 11:05:08 +0100
Message-ID: <20250228100509.91121-1-marco.crivellari@suse.com>
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

---
Changes in v5:
 - comment: idle interrupt region, instead of rollback region

Changes in v4:
 - comments: 36 byte region

Changes in v3:
 - changed "daddiu k0, 1" with PTR_ADDIU k0, 5
 - replaced CONFIG_CPU_MICROMIPS with 3 _ssnop followed by _ehb
 - integrated the commit message with explanation about
   CONFIG_CPU_MICROMIPS replacement

Changes in v2:
 - Changes introduced by Huacai:
    https://lore.kernel.org/linux-mips/20250214105047.150835-1-marco.crivellari@suse.com/T/#m75d9c587829e15e0d7baec13078be4e65c936408

Marco Crivellari (1):
  MIPS: Fix idle VS timer enqueue

 arch/mips/kernel/genex.S | 42 ++++++++++++++++++++++------------------
 arch/mips/kernel/idle.c  |  1 -
 2 files changed, 23 insertions(+), 20 deletions(-)

-- 
2.48.1


