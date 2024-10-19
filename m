Return-Path: <linux-kernel+bounces-372657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360E9A4B89
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F301C2200A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 06:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064511D86E6;
	Sat, 19 Oct 2024 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="A4OGqp64"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F8D1D2709
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729319359; cv=none; b=XMNNm7+Rq1pqFlwIV+fi2a9lEgAGI7QuKtiJj1lFYeShHqYpQVa7I/CQqSixrXYizUT+yGiDrZRYSlIrU9BlfuBdNifgvP4lL3qQQ+q9PsumktaVpGmg4CMhQ2Yno96L2XBsNMuTbFL7LfE/QNFR60cvkYHQT4HITh6FvIotr+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729319359; c=relaxed/simple;
	bh=naw/IVAqhwIN//aCLqr4rT5F76OcVTt/VEChS07k7bk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=psZEdhsNpscFeMLraXRTFTYn4LcB/j5B+abl3aJzyH0GO/dJCjZLMezpn1AEA1gaoBm0lLX6AXYRi5NXkO40cyhwn6fZpZAEyAHjJubg6dzHmV9NnbpHg3CEw2MwrBRSVddK4+yxygGx669otC57oaVejlg4VEQD3PPuFWCmXhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=A4OGqp64; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f8490856so3253962e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729319355; x=1729924155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pgNXgmTgAAshCxmGyeiAukDrNsmKFMPVhhjzBzPDJJY=;
        b=A4OGqp64+k4HeJOPuRU9kSs+z7jQk7+lrTyWwQqGCmUZotrcD2E+pulxU2ZUJIjmJW
         TS8OPyHqc+cDzDAeJFDFPzDON+s9/7ersOgASKUIY7qXJ5AlDLhgLpmoc6AwoTjMpQKb
         AZaC4sGmARCSBg3QU3zihAPOfezsS+eVHUUkb3oi6l5R3X95USoA7bsOh1NoqXAoLWbl
         +c0fJRay1Pjfc5o5WLW3C1adJ2LXGMZqQeYktzuylEKa+T0Ui46vq66vEgwQPU6048Jt
         3Smh3ke8GUhWSXHcEtaVOuCfkVEh8zbPqKAT8JWhAWmeVekY7h9Do/o/ETZQNeSAqV1a
         eXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729319355; x=1729924155;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgNXgmTgAAshCxmGyeiAukDrNsmKFMPVhhjzBzPDJJY=;
        b=iubLDBiWHyvUnzo9q36BXrYo4+X/m8CZKKyetuUcMBKFmQ6Wi18cNxzD6inkBtgu87
         /nM9YuBxtRpP8EHKu45SjP9ChsG7EewpTPEEqf+n/jTwIF+XmN31h72HrC4ZBdnSDXcY
         AUqemjgoIzgi99fSbRPmo4F7huYrcGPtwhrhhEp+PhYrIoc56taSGGgDc/qVM82uM6lI
         8lUXWK7DabQ1jACse2tx+eWz5Kc8Hk5vELoVKMU0uv4cbhf6tLwucqMHO/k8lT8EtVmu
         /VvrDGKWN8Uc0QvsoHr6bsST1jRimMBVDOqggAl/gxVrI2XKE3f9iv2dEUOWXrz1kMw2
         n9fA==
X-Gm-Message-State: AOJu0YwT0lPmDyA/pbnqkuBvw3l5QiWobRBEonuLUF4o5wmhRqu/4aP3
	hQPyrU/15hD3eo+ieH5luBexyOAwUUvdRUsIbkULYiYrybPqCinw1IAJqCWBih92qkwWLX+261y
	Lqovoy0jT3rBGNRNL6f9cVigrChv1ES/psYg=
X-Google-Smtp-Source: AGHT+IH7pCKqc0+40B1OEmT88mw9MY37Icw/pliHWulZCTItctoYJXZQrIgT1zeXxh3cnACrtsR2YU+BwNCOa6VwJ78=
X-Received: by 2002:a05:6512:1293:b0:539:f23b:59db with SMTP id
 2adb3069b0e04-53a1543edc6mr2400898e87.5.1729319354641; Fri, 18 Oct 2024
 23:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Oerg866 <oerg866@googlemail.com>
Date: Sat, 19 Oct 2024 08:29:04 +0200
Message-ID: <CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com>
Subject: [PATCH] x86/microcode: Fix crashes on early 486 CPUs due to usage of 'cpuid'.
To: linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Starting with v6.7-rc1, the kernel was no longer able to boot on early
i486-class CPUs.

To clarify, this was caused by the comprehensive microcode rework, from

0a23fb262d17f("Merge tag 'x86_microcode_for_v6.7_rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip").

The breaking changes were introduced with these specific commits:

4c585af7180c1("x86/boot/32: Temporarily map initrd for microcode loading")

...causes immediate reboot.

a7939f0167203("x86/microcode/amd: Cache builtin/initrd microcode early")

...causes kernel panic early on.

They assume the host CPU supports the CPUID instruction, which
the pre-"enhanced" 486 type ones do not.

These changes make every kernel version from 6.7 to 6.11.4 bootable on
them.
---
 arch/x86/kernel/cpu/microcode/amd.c | 8 ++++++--
 arch/x86/kernel/head32.c            | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c
b/arch/x86/kernel/cpu/microcode/amd.c
index c0d56c02b8da..71fa388573ac 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -516,14 +516,18 @@ static enum ucode_state load_microcode_amd(u8
family, const u8 *data, size_t siz

 static int __init save_microcode_in_initrd(void)
 {
- unsigned int cpuid_1_eax = native_cpuid_eax(1);
+ unsigned int cpuid_1_eax;
  struct cpuinfo_x86 *c = &boot_cpu_data;
  struct cont_desc desc = { 0 };
  enum ucode_state ret;
  struct cpio_data cp;

- if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
+ if (!have_cpuid_p() || dis_ucode_ldr ||
+        c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10) {
         return 0;
+ }
+
+ cpuid_1_eax = native_cpuid_eax(1);

  find_blobs_in_containers(cpuid_1_eax, &cp);
  if (!(cp.data && cp.size))
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index de001b2146ab..79fd9f11dbcb 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -146,7 +146,7 @@ void __init __no_stack_protector mk_early_pgtbl_32(void)

 #ifdef CONFIG_MICROCODE_INITRD32
  /* Running on a hypervisor? */
- if (native_cpuid_ecx(1) & BIT(31))
+ if (have_cpuid_p() && (native_cpuid_ecx(1) & BIT(31)))
         return;

  params = (struct boot_params *)__pa_nodebug(&boot_params);
--
2.34.1

