Return-Path: <linux-kernel+bounces-551058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55FA567A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1EB3B5000
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08A4218ADC;
	Fri,  7 Mar 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7rw3hFk"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA95184E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349747; cv=none; b=j/6dJAhBd/SzXTX87XCqRjoP92yrZ0pzUE+u484c4aSUgymbfRbo8toTsxqLqWOaqFN1tYtVT2Og+ciajwo/o9cteEYLjgnvKmm+zJe6T2YnbpFaGjeIbRCYmEa3aRzMhfvnnrF70dRpr9p/LSHl8UEw0isn1F0TdCrZEg8DRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349747; c=relaxed/simple;
	bh=Uq5EX9UBJZnVWIhuJ2GWRomnXK1KFuooZNZZkTpKySQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0sIS/Tk1w2l/VZZCQkkefLLmFtqf9afMFHTKv5O6/3MRpWCfTeMm5DJq12updqNZscgkxT3Nm4sKk8aZFm+fvjbozBfSlVHEtUySGRhMdWMWckDZ6B3A6z3gSxRNoWdw36VWtafEOSI2yUdkX2Blnv2ALyx9OddVQOGB0Q8ZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7rw3hFk; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfca745c7so348361fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 04:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741349743; x=1741954543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh0WieB7+ME7dypKDGPqNgGpxSoEqDRzIyKGvye1j+Y=;
        b=P7rw3hFklaMjKMiIwCDVVGP3BvbKV00PehCZSiJCvPKVjWm/KHQ7IIO1eI3D6V0Xox
         7SaEXZP/XYof2HkOBJzh6L+aI8INPrjRruv+gZ9XX6i8UB7R34Gw/wNX2hUmDwM+td9x
         1nus37kgCBwdixVFI+xiBmrs00ylNG/0WZisSli60xnTn6EYupcQCToYG97KapOMV361
         gDyHyjUSAzujBcQD4V6zVNWwmallb3FgelZy+Zuk7ha1jdAe41b5uG1CPNA1JuI1YNdM
         q+3xUR2+AmlgpAlXmQf5BHu7xa0QRVaOBdJ10aD9bKvfbC6QR2fY1pBXC+L32U/Fw4Vd
         rGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741349743; x=1741954543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uh0WieB7+ME7dypKDGPqNgGpxSoEqDRzIyKGvye1j+Y=;
        b=isDIp2Mv7RvAlZaoxO+SfHTou3sZQsxDDjd2DagoLykK4OAsEm4w9fWQe/1YVtyojC
         8HEl+LGF5Mzzdip+H/PPBD0UJDSjl3w62I4wonNVLIcOq5qF4fJzes8cBxnn8AoXoLOB
         kN8syhaeZ0fxNhMlIhtnLQHxe9C2Tw1e1dILj1/rZliCdIG8KJ7fOFNAo5K0DWgv2hwS
         EZOeZOqv23YFTAEtnWzAY7sdu1T9swrFaDifwlTL23y9AmfTOLuyaSgloKTbxx5R5uSw
         4YKyNUBMLCQ8ZHu35/ol27ks7yNL+bJAqaL0T8lfiqH2y2i0byirJiFLCm7/EKs4pohm
         22ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHgbSa9EaZxcXOYzva7nte9zfum0U2cX23/ZqZnlh4sRXKzSoOB/uv9l0RdyqQT/oItexkQXB4BlTo3PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIY0X6j4XJzKB8Lh/gK4rMTDsJHN50WD62MjJt+/wAWckp2pcG
	KYxSUlG5EC6C5UGjdthBosv/VJ+J8UTFoMj0AiCvKXJPKotuBfvACldL2dQS/7IaANJDsCTGEZ0
	pj9rmDDkpTEZxM5xdPyXF7Q+2ToQ=
X-Gm-Gg: ASbGnct28FuvGziRBFVLXQ6LgzMWlgby5nXpx3xkiwnqVBand3+UFB7NS0TYzIn4FnK
	YosFyA87ZJoKmiNW7fQAFV5QsLok9YIUTMLUvfiyGkvigBYZvp6q3ZNnZtIc5e0eUmuRCtT42q4
	bacxN2NTxPgrS8iiMnpTL5WIU6Qw==
X-Google-Smtp-Source: AGHT+IEiPbW0qy5iBnOZSkDkqWWSRUblM32gZfBLaGejIR2C+xJp0wAnKF/dzLqGYZ2c4sb5S+5a2lJmz9qy93fu1bM=
X-Received: by 2002:a2e:a592:0:b0:30b:d0d5:1fc6 with SMTP id
 38308e7fff4ca-30bf460acebmr12063981fa.23.1741349743197; Fri, 07 Mar 2025
 04:15:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307091022.181136-1-ubizjak@gmail.com> <DC668A65-3173-4A0C-BF78-1CECF60D300B@zytor.com>
In-Reply-To: <DC668A65-3173-4A0C-BF78-1CECF60D300B@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 7 Mar 2025 13:15:42 +0100
X-Gm-Features: AQ5f1JrhxlrEiJ_cToo0DeNAFPKOUPYFafvHsQo3lPkNPazjdxaWeA5pCotlOb8
Message-ID: <CAFULd4aMkxYp6L=grE7TrvvfdX7gTGOTAJgojJ=mjHfDLJ=kVQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Do not test if AC and ID eflags are changeable
 on x86_64
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:58=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On March 7, 2025 1:10:03 AM PST, Uros Bizjak <ubizjak@gmail.com> wrote:
> >The test for the changeabitily of AC and ID eflags is used to
> >distinguish between i386 and i486 processors (AC) and to test
> >for cpuid instruction support (ID).
> >
> >Skip these tests on x86_64 processors as they always supports cpuid.
> >
> >Also change the return type of has_eflag() to bool.
> >
> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@kernel.org>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >---
> > arch/x86/boot/cpuflags.c | 26 +++++++++-----------------
> > arch/x86/boot/cpuflags.h |  6 +++++-
> > 2 files changed, 14 insertions(+), 18 deletions(-)
> >
> >diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> >index d75237ba7ce9..2150a016176f 100644
> >--- a/arch/x86/boot/cpuflags.c
> >+++ b/arch/x86/boot/cpuflags.c
> >@@ -29,40 +29,32 @@ static int has_fpu(void)
> >       return fsw =3D=3D 0 && (fcw & 0x103f) =3D=3D 0x003f;
> > }
> >
> >+#ifdef CONFIG_X86_32
> > /*
> >  * For building the 16-bit code we want to explicitly specify 32-bit
> >  * push/pop operations, rather than just saying 'pushf' or 'popf' and
> >- * letting the compiler choose. But this is also included from the
> >- * compressed/ directory where it may be 64-bit code, and thus needs
> >- * to be 'pushfq' or 'popfq' in that case.
> >+ * letting the compiler choose.
> >  */
> >-#ifdef __x86_64__
> >-#define PUSHF "pushfq"
> >-#define POPF "popfq"
> >-#else
> >-#define PUSHF "pushfl"
> >-#define POPF "popfl"
> >-#endif
> >-
> >-int has_eflag(unsigned long mask)
> >+bool has_eflag(unsigned long mask)
> > {
> >       unsigned long f0, f1;
> >
> >-      asm volatile(PUSHF "    \n\t"
> >-                   PUSHF "    \n\t"
> >+      asm volatile("pushfl    \n\t"
> >+                   "pushfl    \n\t"
> >                    "pop %0    \n\t"
> >                    "mov %0,%1 \n\t"
> >                    "xor %2,%1 \n\t"
> >                    "push %1   \n\t"
> >-                   POPF "     \n\t"
> >-                   PUSHF "    \n\t"
> >+                   "popfl     \n\t"
> >+                   "pushfl    \n\t"
> >                    "pop %1    \n\t"
> >-                   POPF
> >+                   "popfl"
> >                    : "=3D&r" (f0), "=3D&r" (f1)
> >                    : "ri" (mask));
> >
> >       return !!((f0^f1) & mask);
> > }
> >+#endif
> >
> > void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d)
> > {
> >diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
> >index fdcc2aa4c3c4..a398d9204ad0 100644
> >--- a/arch/x86/boot/cpuflags.h
> >+++ b/arch/x86/boot/cpuflags.h
> >@@ -15,7 +15,11 @@ struct cpu_features {
> > extern struct cpu_features cpu;
> > extern u32 cpu_vendor[3];
> >
> >-int has_eflag(unsigned long mask);
> >+#ifdef CONFIG_X86_32
> >+bool has_eflag(unsigned long mask);
> >+#else
> >+static inline bool has_eflag(unsigned long mask) { return true; }
> >+#endif
> > void get_cpuflags(void);
> > void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d);
> > bool has_cpuflag(int flag);
>
> PUSF et al =E2=86=92 pushf
>
> The -l and -q suffixes have been optional for a long time.

No, not in this case. Please see the comment:

/*
* For building the 16-bit code we want to explicitly specify 32-bit
* push/pop operations, rather than just saying 'pushf' or 'popf' and
* letting the compiler choose.
*/

We are building 16-bit code here, and we want PUSHFL, the one with
operand size prefix 0x66.

Please consider the following code:

    .code16
    pushf
    pushfl

as -o push.o push.s

objdump -dr -Mdata16 push.o

0000000000000000 <.text>:
  0:   9c                      pushf
  1:   66 9c                   pushfl

Uros.

