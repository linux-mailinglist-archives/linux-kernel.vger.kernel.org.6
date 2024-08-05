Return-Path: <linux-kernel+bounces-275301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF62948303
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD8B1C216A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C40A16C84B;
	Mon,  5 Aug 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUwB+bb9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35016C685
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888775; cv=none; b=Ua37FQNyo8cIaqwxDCjZPWqK3IxXZgWoDTExHSS4DXgVlhPQi32tR8Kfo3Y58Q3BP31umfND+KMiCwOtHvnM9xFicbBw883txWIh7ttEzVrss5pomZG1Ffs+u/ml6o+uoA1iNCz/wBeiAD661G0DiTE7K1Y1+qXwpb5pIqC9cw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888775; c=relaxed/simple;
	bh=jij8aP42T72ubwaJKx50J9XfLi8cZ7pA+OPSpaf44y0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rBHqBVu0hMY2Pp7a0k5s7xgLFCltdXX78U4Z5cqowovC/DKQPx/Dhg11A9TxJU+JMgvaT80ojgW5aFY7AAdjakHKHdM2/k7lPrslsXgwkFHFA/e6Z4ZAn89PiL8RDcS+Df5fuD8uLe+nIKk4s/YAxQ9qQpqZdpcRpB6cPV3kDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUwB+bb9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-654d96c2bb5so213849167b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722888772; x=1723493572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vAM13V73+JGoi3sB94ylLbhhxyQ11c/DL05/0xsi6Kg=;
        b=qUwB+bb98Q1FKW83pvbYeE1E4szPSYsJ4q4jKlP/WkrfiX1Gbi1eByFCPVYXhTPIY2
         SSNxbjHHwGgM+T8ujYZbh2y13WtjEHVZ9gDsq47vYiIc5w7B+l5r2ym2iHSvKH2i/O3R
         psQUCI+SVRE1wcRTumLhybs5mhwhvEJyfp+Wem5KC+5GePy6bkd4pvUFFYXEqktkCWcr
         +lIyzEHMEA/lBAYNMVOP15PpodJfkxKskdONc16suKc3pgpeBcHhNKr0x74d5GWpQOxL
         jFt1eaqI7dAS20LwT+TwUia6qE3qBcZPfTX/sdzvBdVaT0M39gAyHXrGuOx8ve1mlpFl
         Up8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722888772; x=1723493572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAM13V73+JGoi3sB94ylLbhhxyQ11c/DL05/0xsi6Kg=;
        b=MH10TyjrHpG92dZLgz6zQJTrR+v6zbHMdJYAMzD8zc6eKakeb9L3qb8oeWayS5CFOg
         Y/Jo8lFJzyRJLdui1rXIxT9iTIos7+p6Wh4dFKSAYk7bSAOhcf2nMkXF+UbZDpOCAw4f
         0R5GXg7QdlzfmTTMR6JcXUYuhf6M+DxDrb1a1fCJLX9holXo3eAApb1tJw92IOvaJekL
         ZpEgSunZvnBoqmvQRcU8/ZUzBBmZhJMXs6ML0CfprJURyvUg8nSYp56hh7+QJ+rCdyGS
         vJvbYnnK7mtQIXB3G9TSVWRnY7vD0dbxccrh+20efR5UAbP8HHbpYoue7ukCW/u40TSw
         RqNA==
X-Forwarded-Encrypted: i=1; AJvYcCV3hsH3Hah5qfjfTdWV2H4FYDF7qKuJ6FF6a2trIv8ZjywmnIPj3I7ezePJgqcgLj99k0Dfa+j0iKWya0w4gQCmh/VPlXoxo7EBeD/A
X-Gm-Message-State: AOJu0Yx2XMu9QPucMrY8ouhKe5ZORat8InDF4QkVwgBZNmDlSjquYN5w
	bDfLG328oRNgaWFU8C+NnY0xz1m7hRdFD60zeEIkDtt6gD7mR9VvpvWUnJ64sD+dj61UJ+wKz89
	TRXur+ugztyDNCUMVaw==
X-Google-Smtp-Source: AGHT+IGk/lHUMF+5u6MZhgz9dYRcC6aVot88Xvor1TNAzmg3/V3f7iRracYHyGVxtZnEX5KCpV8/IHrD+bjnZQWT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:f06:b0:68d:52a1:be9 with SMTP
 id 00721157ae682-68d52a10ef2mr1180357b3.1.1722888771583; Mon, 05 Aug 2024
 13:12:51 -0700 (PDT)
Date: Mon,  5 Aug 2024 20:12:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201247.427982-1-yosryahmed@google.com>
Subject: [PATCH v2] x86/hyperv: use helpers to read control registers in hv_snp_boot_ap()
From: Yosry Ahmed <yosryahmed@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Use native_read_cr*() helpers to read control registers into vmsa->cr*
instead of open-coded assembly.

No functional change intended, unless there was a purpose to specifying
rax.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

v1 -> v2:
- Fixed a silly bug that overwrote vmsa->cr3 instead of reading
  vmsa->cr0.

---
 arch/x86/hyperv/ivm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index b4a851d27c7cb..60fc3ed728304 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -321,9 +321,9 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 
 	vmsa->efer = native_read_msr(MSR_EFER);
 
-	asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
-	asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
-	asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
+	vmsa->cr4 = native_read_cr4();
+	vmsa->cr3 = __native_read_cr3();
+	vmsa->cr0 = native_read_cr0();
 
 	vmsa->xcr0 = 1;
 	vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


