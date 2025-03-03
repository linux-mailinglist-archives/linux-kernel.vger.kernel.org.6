Return-Path: <linux-kernel+bounces-542093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C0A4C5A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6C67A7EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2668214819;
	Mon,  3 Mar 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exaBsChn"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753821481D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016774; cv=none; b=Y/DTgOBWIbzTXxwyeYJ9zI3rLh+Cw7bx3KS0//ZqF5m17BVqQYEVSjCtIqaTR9kViR9xXmwca4miIzbd+y4WLUneKUSg9jQJJA2LEqyFx+4pgKPHJDKoLuQI/YSsji5MdvbphXw39twpvTzOff2jmAvdJaQlSZoHlRbf1lLl4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016774; c=relaxed/simple;
	bh=Lagp7EVGGbW2aNVJgi7iXSFgcZpgqQx1kPoY1EIq/c0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OB0rsMP0RJJETV5SSj9JrU+8PaS3FrdUUVL5Gy7S4fFsI9515bERomaH6U/H6bJQAnzJ7e1ETjak/Le3tagbCG6WFsKkJbhwfsUFOtezg3vHqUoBjLB3e+epnsmKttgF0OXuJCdwobP6inkknGtuSCZasrhWAWblbNooYIlYxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exaBsChn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so20514525e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741016771; x=1741621571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LvqKPSFCb1SyVRLi8Lxjd7q9iolvwjcVsJ/H6eA+bVc=;
        b=exaBsChnrHR8qRkPvOrC7ZyYTxZ6aUfCZ9rl19O3NWr71bkCuxo0gzJhfJ8v2nxa/B
         t6jiXbfSUmsAx59kChi9FGQM4BdQW8+kpxdRH6xOTS1NTvAFpQ4b6Nb9qkzulsZJEXJ9
         6bI3Mfk5McNqVDVIaQgeCkhXeixxXZv22vikGSoWv4hUsD7zu8uwk8DGV+84ouJrE1PN
         zpl/b5WyKAX25tzMITSCKxFSZXJfU6jZPFHlG0xglw1YW0zNxt7R5fOjIJF0Op/XzZqN
         vQFPkx/J4P2JHHemmP4E1GjS1K27TYnIiyZZFNl5XGt60J1c3SBnaC7o460xURlEreJv
         diag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016771; x=1741621571;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvqKPSFCb1SyVRLi8Lxjd7q9iolvwjcVsJ/H6eA+bVc=;
        b=AWnmpyWDZ1JebX/hASSuJqmOEfWgAOBqFWMrnfkzwq4bnjcQMpK6U32GvAscPxJmzp
         3hMyirZ1MoYLZem7WHbib6ZpIngXzIq5nc26N5Lrin62Gsxi5mzJrkV5RfAsJB5z0mVd
         zvIvzbTWUB3SUa8I+abTK3cq/jQUldhdwFGlJd+yz1wNthKsweO7Q4+rzF2cXkEccdUJ
         2AGvYbuh3wkyFhCieSPpmYkdh0C2TDN7u+21h8DEw6VMeb1bJZ7fYcyw7ClQlIgkegvS
         gBg5H2/iwGajUY8eItorR2/G3Rl88wQsA++c12oRZqw6H2qeoM/e3/JNdOq/mpC3ar6F
         OamA==
X-Gm-Message-State: AOJu0Yw38ajY8eBy/z2l35EboypYyY2uMXR9b+CrRHVolHxYwL3p+65y
	AZ83c/gVTOs6Qd4m97R0uvM8s4OYHw97xbxnL4vfGHdZAe7VbzweUAJGnAIMJ4Jzz05DjLLGVnW
	G6Ofk59m5Qw==
X-Google-Smtp-Source: AGHT+IG9pe3JZ7GAYnnNHxxoi6iv9OP8j22do3LO9d2UN7ADzcc9PzIFZGNj2Hv5EddmAd5BAIL2gHOjO/bvJg==
X-Received: from wmbed10.prod.google.com ([2002:a05:600c:614a:b0:439:8715:690e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ca8:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-43ba6760622mr98772625e9.21.1741016771224;
 Mon, 03 Mar 2025 07:46:11 -0800 (PST)
Date: Mon, 03 Mar 2025 15:45:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKDOxWcC/x3MTQqAIBBA4avErBuwRKKuEi38mWogLNQiEO+et
 PwW72WIFJgiTE2GQA9HPn1F1zZgd+03QnbV0IteCSkkRkr2utlh0uwTHuftKKBSg7GjNNqQg9p egVZ+/++8lPIB8P20RWcAAAA=
X-Change-Id: 20250303-setcpuid-taint-louder-557bc93babed
X-Mailer: b4 0.15-dev
Message-ID: <20250303-setcpuid-taint-louder-v1-0-8d255032cb4c@google.com>
Subject: [PATCH 0/3] x86/cpu: Followups to adding setcpuid=
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="utf-8"

To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: H. Peter Anvin <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Brendan Jackman <jackmanb@google.com>

Followup to this patchset:

https://lore.kernel.org/linux-kernel/20250218-force-cpu-bug-v3-0-da3df43d1936@google.com/

Note that some of these changes were actually a part of that patchset
originally, but got lost as the v2 was merged, apparently due to
confusion stemming from Lore losing data.

---
Brendan Jackman (3):
      x86/cpu: Remove some macros about feature names
      x86/cpu: Warn louder about {set,clear}cpuid
      x86/cpu: Log CPU flag cmdline hacks more verbosely

 arch/x86/include/asm/cpufeature.h |  5 ----
 arch/x86/kernel/cpu/common.c      | 62 +++++++++++++++++++++++----------------
 2 files changed, 37 insertions(+), 30 deletions(-)
---
base-commit: ade3daf70f3655ea06606b2f65062ba4554db06e
change-id: 20250303-setcpuid-taint-louder-557bc93babed

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


