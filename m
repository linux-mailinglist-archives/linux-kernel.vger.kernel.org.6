Return-Path: <linux-kernel+bounces-542962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C2EA4CFE7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0208171BCA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4F2DDDC;
	Tue,  4 Mar 2025 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqwVkBOu"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3011A260
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047923; cv=none; b=HtEfND5/Vps3gfUexE6EAUztBW+Y9SIrhir4THM5OPE7gPw8qGLQ5PA/MFwUYc+moCMo1w6oPklIDMIG7Uxaood7/9XiFtEbqxi7ydYWqt5TMEk0nlvBFQi+bmQmMmca8R8sA/WqYnhGnACiMa8yfGtGlnW/r2peIijA5T0Dc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047923; c=relaxed/simple;
	bh=+Zrm1MV11CyznMqTplgKdlEe784avoc0c272vJzfiHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3N9YdU3MbFpNeNiM3i9m2OBMqjicVsxkfWIKLoZgSFHoJY5+/NbRufxwHK3IvHyb/0Z3zeW0bH5W3IE/I7e6coneHnO0FCS/QhHT+JOYp848AwKRocrFMEF37RRbgL8Tq0Vtz9w4VbCDsQHRzOugVf61nz5Vf2XI7xI6Xtdhek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqwVkBOu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-548409cd2a8so5257727e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741047918; x=1741652718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxI/GG4PNTB3m1Ugu6g6VlWiKM3FjEsAmkg2oUQx6FA=;
        b=XqwVkBOusbjuBw2xStxt8S0pe7AIQjPKGqnvT78JUOfK0JmJFOzDFNu0Om1wyQhL63
         JPqAO41iG6NL13airtGBsnh6Gh9u4eW2oz7nSq0BvhugL1/ShoJpfo39GAHjqkEkk2Uk
         FPayPCGFhUrAXM1eixi525S1b4HFtD/aqnMni4D+A9hXGNZO7XzePaSEkeOgyq/uUIZ8
         oYSd+A/3OAZNfrePXBT53wz/MMq05KGJORNixNfDxusyUfigpIkjCP2X1s4FHPMa6mR1
         5EiSGO59kdt2NPWoG02vbexZTb7SB7Jj+HhMrP1Q0q+AmGMga1pZ9WhqsESZwRYvPFDl
         BK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741047918; x=1741652718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxI/GG4PNTB3m1Ugu6g6VlWiKM3FjEsAmkg2oUQx6FA=;
        b=lzfSgVpNMUc73ZyzJxzi1knR+xS+cBos51sqz/ZBP3OcGze/qVnD+V49uVf4mINlex
         quGO6z1aCcBbjXN6riO2dV/NFT2y7iOc8DRXQBxmEqOx6ILT7S0Oe+9InqZ5LR8vAz4r
         FXI5xcVaMl6gHXK242khG9WelblODUveN1XWbh/2rTjpLbhfEQld93BQIb0A69cU81Sd
         f6g7ogcDu5cb6VI9y891BbbpgriEETso3hnxaEMykne3lnoo0wnBs5ReG1EP0sXrAHkb
         C94h3LPXBFdYsKTHI26aABEdTRQWjDmidCIsD2B7u4QVe9NSEp464rP6lFYLyrLCSI38
         fKzQ==
X-Gm-Message-State: AOJu0YyoKMUNCxYE6i/RPhgNw/Eu1QlhYs14nyueceM6WH+VepZ/4GmH
	AlGBEagCEcDaHAoBVE6D4UKXnXWqyGtxZWqshMRsrBTlPiMdFMa9QdTaOSTIZh5VS6+TKW63ddF
	WzTa4zaWsVFsd7NTAdV+tCf01qg==
X-Gm-Gg: ASbGnctw7hmCAOiKdDtyV16nTx+56CH3DJ4LCpGbyWFC0+6liGO+FA9v/MUXpzfVIxr
	iwX+INADLWr4+KGVJrturTDzqe/W71qpIXoPM+bJV1TkMPXDmZt+fdJF1ZCVNAobzeHjILchfyD
	z9JWlEttSSz038njlyweGAvJ6mLMPtQqnprHSQwP96
X-Google-Smtp-Source: AGHT+IH7jePv/cleojM+C8gSVOOrHi6BQQdnULIZr3BC9WdguRpPQOgH9wX4FKVe4fltWVuLdv9DeiOmEDyv8zz8RS0=
X-Received: by 2002:a05:6512:3d0e:b0:545:16f0:6ca2 with SMTP id
 2adb3069b0e04-5494c34ea28mr5030547e87.42.1741047918127; Mon, 03 Mar 2025
 16:25:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303183111.2245129-1-brgerst@gmail.com> <9FC474C9-284D-4EB5-BF8A-7B938247E577@zytor.com>
In-Reply-To: <9FC474C9-284D-4EB5-BF8A-7B938247E577@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 3 Mar 2025 19:25:06 -0500
X-Gm-Features: AQ5f1JrRarMEBfsqBG8IB4cdTewkZmaQsRRRpufSv16xTyd0gz9Lwds8lB4DL9k
Message-ID: <CAMzpN2jjcBtr73iuw8QaJ6MQxnnSRzr2SqDDKhfyDVnRETzLPg@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Merge KSTK_ESP() implementations
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 7:01=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> On March 3, 2025 10:31:11 AM PST, Brian Gerst <brgerst@gmail.com> wrote:
> >Commit 263042e4630a ("Save user RSP in pt_regs->sp on SYSCALL64
> >fastpath") simplified the 64-bit implementation of KSTK_ESP() which is
> >now identical to 32-bit.  Merge them into a common definition.
> >
> >No functional change.
> >
> >Signed-off-by: Brian Gerst <brgerst@gmail.com>
> >---
> > arch/x86/include/asm/processor.h | 5 +----
> > arch/x86/kernel/process_64.c     | 5 -----
> > 2 files changed, 1 insertion(+), 9 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/pro=
cessor.h
> >index a969bea1ed07..55f0e48413b0 100644
> >--- a/arch/x86/include/asm/processor.h
> >+++ b/arch/x86/include/asm/processor.h
> >@@ -652,8 +652,6 @@ static __always_inline void prefetchw(const void *x)
> >       .sysenter_cs            =3D __KERNEL_CS,                         =
   \
> > }
> >
> >-#define KSTK_ESP(task)                (task_pt_regs(task)->sp)
> >-
> > #else
> > extern unsigned long __top_init_kernel_stack[];
> >
> >@@ -661,8 +659,6 @@ extern unsigned long __top_init_kernel_stack[];
> >       .sp     =3D (unsigned long)&__top_init_kernel_stack,             =
 \
> > }
> >
> >-extern unsigned long KSTK_ESP(struct task_struct *task);
> >-
> > #endif /* CONFIG_X86_64 */
> >
> > extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
> >@@ -676,6 +672,7 @@ extern void start_thread(struct pt_regs *regs, unsig=
ned long new_ip,
> > #define TASK_UNMAPPED_BASE            __TASK_UNMAPPED_BASE(TASK_SIZE_LO=
W)
> >
> > #define KSTK_EIP(task)                (task_pt_regs(task)->ip)
> >+#define KSTK_ESP(task)                (task_pt_regs(task)->sp)
> >
> > /* Get/set a process' ability to use the timestamp counter instruction =
*/
> > #define GET_TSC_CTL(adr)      get_tsc_mode((adr))
> >diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> >index 4ca73ddfb30b..f983d2a57ac3 100644
> >--- a/arch/x86/kernel/process_64.c
> >+++ b/arch/x86/kernel/process_64.c
> >@@ -979,8 +979,3 @@ long do_arch_prctl_64(struct task_struct *task, int =
option, unsigned long arg2)
> >
> >       return ret;
> > }
> >-
> >-unsigned long KSTK_ESP(struct task_struct *task)
> >-{
> >-      return task_pt_regs(task)->sp;
> >-}
> >
> >base-commit: 693c8502970a533363e9ece482c80bb6db0c12a5
>
> Why using the macro version?

Why call an out-of-line function?  I guess it could be an inline
function (along with KSK_EIP()).


Brian Gerst

