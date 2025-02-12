Return-Path: <linux-kernel+bounces-511445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C9A32B25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C981882249
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF321171B;
	Wed, 12 Feb 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRdP0xO5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B71D9688;
	Wed, 12 Feb 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376486; cv=none; b=SusyCN0DiKuw5J4MrjbCOENkGFXXbTTJM24TvQJ7MOEv+nPe3UXkXLNT46RLBqjGZM2L6NKMrxcyoZ82LdHl9DiJ/nKT1n7DGUZBfgcFDtVMmmNTq9CQwhg4B4HAo9xpXISfjaJGmkVObvv3AuYsa6HndhslCr/qHfbQkEIWXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376486; c=relaxed/simple;
	bh=VAuhs9u09a/f35HYUTjGbhVG0CNeiFDZpBWCT1Fvqcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Onjmi50RAg4kAZvYq5M59kIRGR83Hpaj4OSVUHQ69qHRK3u+a6ZEjp8lJ6+2eKTedBDQcKjKdyCCPrP6yhJciexucjeAPbrKTolS/MYnBfFipesNIZogyEQ/YkPNQQ55rrmgaqf1bRpiaZXc4VqxJdUTzOeobM4GwdWyFOCCYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRdP0xO5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-439585a0544so6673435e9.1;
        Wed, 12 Feb 2025 08:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739376483; x=1739981283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=enB6VpwoOzA1BhOL6deI72AZfVPGYPPBVh8XI8rOxME=;
        b=iRdP0xO50UU5exUzkENcxj34cR/rv4NXwWX1vgvX8+SaG9Nkfz7uhjBxlIYbs7h4fm
         unwcaTY5nKLEH3zLhkXiTNVyOwYej0U2jwyT+XrHcW64it7I32/Tt6dZ/ODOIdzRxFbw
         nq2bx9/6WM7hzV4ED9N9DYPxdhZVdxSDgwMyxssu+jGiANvZUrsH3+A9TJoaDmZcoNHW
         7AzZc0rwe5gqqbaPVFx3HooEYUiAzBpnDH68fgNoL1nbOoeZu0/HY1ulV9h3HXPGp45p
         Jlteo3JbofaGlcXbmyKhGOzC7LoeiFiD1bAO3jYEF6BgVUwaIEJ3j7PZwRIcexNqXNtg
         jj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739376483; x=1739981283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enB6VpwoOzA1BhOL6deI72AZfVPGYPPBVh8XI8rOxME=;
        b=PX0PUJ/8JahgSMTDKo+hKVcyR2kqoFaEpMhpXU3ziQnhyyC7RRnZi6A++/YoD/SaBh
         G7KURnbXl/RAleyR2UIotsr2IMTjPTadot3MgMndjpiOsNbAVVq67nZqG0hCuEpj1mbs
         t0Z+1mTf/AcRbUKiC2CqG5Mdp4tTYnZPCKv7VFF1DPSXPYgRD5l3Z99EqGY4BrcjM9Qh
         AdE8QNpx0beOugZxWgQ9mmwWL+Ot9RysHZOS9bwbZa9C3rwH92uKGWhKaExqrvGPxW22
         XU28Awp7WftWuf18djTD0WWGq0OYgxAgS+d8eiC4S1yinHQpvVxZnNQAvEy41ta0z32x
         bMXg==
X-Forwarded-Encrypted: i=1; AJvYcCWkeh3fXTekIeEjgg1qvjeoS5mhScQU66TVOAj2TmPlc4QkXQ8nAtlZUxO/9vx1S9v5QPcun2ZD0dOYmHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ19+bN9009DWsJNaKtGVctdPSDHIdjlXS1G+zfYxO0d0WBIEQ
	7RjeSJoodJCwD6vrs76WjBpMityhW9kgRjMwjB/L5Jy5ufsH5w5x
X-Gm-Gg: ASbGncsEqtNbGix3w4Ko0Iov9NqFrVhtt5lzOopmKZYsR3OLj1Pyjsh/2fNRuCHog1Z
	I1uFPPMC+k5XKx1rfMdGbLUv9T2l3KtSB06Cxybi8BESH4opQjoQNBI2X/judPX6aPn4tThWIiB
	cf2eMQesqUEbdYTewfq8ySqAuUIbQ4zcjb3XTAPS7jE80/Z0A+lKihPUVdHDi1+6ZL8CwlCf2Ul
	wz32CC/XETqm9DX9OXFcpfmN83rtaAEkugy7pkJtPKRhj81FJwOPKeD+dxbIXE7S+5edjDbLhKR
	ynVfBNnc2knmNtTE
X-Google-Smtp-Source: AGHT+IFZClm954umRgqvsnO48Pxdz7Faf+eQxyE77ajeKZ1ehn9upBDGCss0Soar4O8O5eriAPlKFQ==
X-Received: by 2002:a05:600c:4f41:b0:434:f131:1e64 with SMTP id 5b1f17b1804b1-43959a2ac15mr29520085e9.9.1739376482705;
        Wed, 12 Feb 2025 08:08:02 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4395a0725eesm23356605e9.31.2025.02.12.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:08:02 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] signal: improve performance of tgkill and do_rt_tgsigqueueinfo
Date: Wed, 12 Feb 2025 16:07:34 +0000
Message-ID: <20250212160734.527199-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Adding an unlikely() hint on a couple of unlikely error return
paths improves run-time performance of tgkill and do_rt_tgsigqueueinfo.

Benchmarking on an i9-12900 shows an improvement of ~5% on a tgkill
on a process and ~3% improvement on sigqueue. Results based on running
20 tests and taking geometric mean of number of calls per second. Used
signal number 0 to check if process exists.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 081f19a24506..4ae848ce3a7a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4165,7 +4165,7 @@ static int do_tkill(pid_t tgid, pid_t pid, int sig)
 SYSCALL_DEFINE3(tgkill, pid_t, tgid, pid_t, pid, int, sig)
 {
 	/* This is only valid for single tasks */
-	if (pid <= 0 || tgid <= 0)
+	if (unlikely(pid <= 0 || tgid <= 0))
 		return -EINVAL;
 
 	return do_tkill(tgid, pid, sig);
@@ -4233,7 +4233,7 @@ COMPAT_SYSCALL_DEFINE3(rt_sigqueueinfo,
 static int do_rt_tgsigqueueinfo(pid_t tgid, pid_t pid, int sig, kernel_siginfo_t *info)
 {
 	/* This is only valid for single tasks */
-	if (pid <= 0 || tgid <= 0)
+	if (unlikely(pid <= 0 || tgid <= 0))
 		return -EINVAL;
 
 	/* Not even root can pretend to send signals from the kernel.
-- 
2.47.2


