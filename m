Return-Path: <linux-kernel+bounces-568660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C80A6990E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F93880E20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CA920E704;
	Wed, 19 Mar 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv2O6cZS"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45171AF0D7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411878; cv=none; b=TUVpbBoBSYkJ1NP7uCM+dIqaHKe3xGKWft0o3GYmnO/JvKIcU+2CFp0oZLBhxgEz90M6xrkAGJPRdFjA8FTbITvfzgVwpks5F2d38h2ztlBtdPZe4P5ehW/6mBbEpjzeJKGBavvuNamoO0o3ak71xdMV7OtaO8FqzwB/UjKqe0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411878; c=relaxed/simple;
	bh=QCEtEkxA27z7lYY4jDZ6Bdte4bA9wKiYDFGDFNSAhkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eC9UAr+zR3PfPQ7X72QGXGeprB6t1v7C12R3gEOq3Oblijni18X81t4gw0wkPNeMHYUIQUEqAEyjzb6UzvAGY+igStVexwopW5u8nJOnYYz8LTd3cYlTkKhCNoFSWxTklMC5QXYbtbhvMsQftSyT7EJCczIg51XL96iKw+EFPE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv2O6cZS; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5439a6179a7so8367e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742411875; x=1743016675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNGUyzT3o52qSNwsF8gyV6fHX+GCEdD9CGDz1M8FRjQ=;
        b=Iv2O6cZSPlq7r+xgrcLeUyh0uyJL8V52OV3xRCSEEM3n2eMZLrrLlvIJBLl05ZuTQ4
         juQua3FEwujfbJ9gVM6kXL8blZfNoHFKPLdikD0naFt4sSctuKDwuG7UmFGIt0YaJPgl
         1vn2Px1RS/dpHL6Uq8IYVy2uYDghSVDQ4su50IOBzqkcg97o/ophIlZx+Lz9w01ik86y
         Ex45VSH1Qo5jjnRpbYzsfQvG87r+nWrzl6A99O4v/BCXMSLfieAVaw2xnnDaCSxaQ9W0
         yA85BMEMUh145Ot+3mWIk4zDUqsXL5il825MqYx+pApj8nhlO7MQVSPJX9qTTDeeY+hO
         VuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742411875; x=1743016675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNGUyzT3o52qSNwsF8gyV6fHX+GCEdD9CGDz1M8FRjQ=;
        b=kCr+H52cwUHby5SM9In92Pta4Oe36VKY5p8OijrwwzFOBNPERo70dZioLaHZnlqxcO
         iGYLuimFLH7V6DNQYPL+xJAlOxw3FqDPmNisl6EMUPPueZ8Hbfkb50qNIcXlIFEeg54j
         FmKlIqGMc7+NhftbcyPu6JlTtC3d49lRtbWNDMx++oYBwlcExaqUiEt8QYarA64ujYFt
         w5exwxnTD7wQolRWqv23AfUvzVI0iEpBxYLygT1hvRVOvCeXYRjbOG9pr26t5ksiY2gf
         iWQ67ojGfHllpVgNOynjZvQJn96YXksVebP5ym70n+r+y4Erpvm6eLQNJV2sWU6v5ErC
         4AkQ==
X-Gm-Message-State: AOJu0YzwPH3dWy0w/jsA6ETfMXIRu9od9dBrULMwOHmK0smH8kYR2axk
	3PJrl98/35KZCHXByo7DuV8gJ8G7rlMyGQP04eNz5yRZHQu+Ff6EaPQM9Qb1NpA+VPf9pPoMHHI
	RJ9xXLYng1nKpVTDitJmrzMLSSA==
X-Gm-Gg: ASbGnctfjftSS6OqBuhYo/FLCFs16JwSGerX64eDesS5bcgogHrkQ5PM7N7vHNKA/BT
	bpRt8upUhiWopy9HbAR/3CvBfzDExRI1oLLrbU/Y57b73J/zpXCzgT8DHL59JIsEc01YNoC1dJ4
	yRleeNFVdwk2tfIbKSt4Ji0T6pXvkOobV0I3xXKrtZ
X-Google-Smtp-Source: AGHT+IHZjjsXNcoPK/FxB8xDIl5NJ+av//2zIcBGVE4ZsLzZk7SuaIjh26A5LRa3Qqgh335l2ipGgC9wnQVti9zON6c=
X-Received: by 2002:a05:6512:6cf:b0:549:68a7:177c with SMTP id
 2adb3069b0e04-54acfa85f7cmr260116e87.7.1742411874453; Wed, 19 Mar 2025
 12:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319071009.1390984-1-xin@zytor.com> <20250319071009.1390984-4-xin@zytor.com>
In-Reply-To: <20250319071009.1390984-4-xin@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 19 Mar 2025 15:17:42 -0400
X-Gm-Features: AQ5f1JrTxZ8q8Skhwgka_P0U7eSx5SOpLrK_pPYJcS3d8bulLd_9KEIrFGZMiJ8
Message-ID: <CAMzpN2jFv8KE97ymEWAX1setxdgXy0jZGn_7JVp9fFEBfZ2ynA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] x86: Zap TOP_OF_KERNEL_STACK_PADDING on x86_64
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, 
	mingo@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:10=E2=80=AFAM Xin Li (Intel) <xin@zytor.com> wrot=
e:
>
> Because task_pt_regs() is now just an alias of thread_info.user_pt_regs,
> and no matter whether FRED is enabled or not a user level event frame on
> x86_64 is always pushed from top of current task kernel stack, i.e.,
> '(unsigned long)task_stack_page(task) + THREAD_SIZE', there is no meaning
> to keep TOP_OF_KERNEL_STACK_PADDING on x86_64, thus remove it.
>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>
> Change in v2:
> * Rebase on latest tip/master.
> ---
>  arch/x86/include/asm/fred.h        |  2 +-
>  arch/x86/include/asm/processor.h   |  6 ++++--
>  arch/x86/include/asm/thread_info.h | 10 ----------
>  arch/x86/kernel/process.c          |  3 +--
>  4 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
> index 2a29e5216881..f9cca8c2c73e 100644
> --- a/arch/x86/include/asm/fred.h
> +++ b/arch/x86/include/asm/fred.h
> @@ -97,7 +97,7 @@ static __always_inline void fred_sync_rsp0(unsigned lon=
g rsp0)
>
>  static __always_inline void fred_update_rsp0(void)
>  {
> -       unsigned long rsp0 =3D (unsigned long) task_stack_page(current) +=
 THREAD_SIZE;
> +       unsigned long rsp0 =3D task_top_of_stack(current);
>
>         if (cpu_feature_enabled(X86_FEATURE_FRED) && (__this_cpu_read(fre=
d_rsp0) !=3D rsp0)) {
>                 wrmsrns(MSR_IA32_FRED_RSP0, rsp0);
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index a88ddf5614f2..3b7adefe05ab 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -656,8 +656,6 @@ extern unsigned long __end_init_stack[];
>   */
>  #define TOP_OF_INIT_STACK ((unsigned long)&__end_init_stack)
>
> -#define task_top_of_stack(task) ((unsigned long)(task_pt_regs(task) + 1)=
)
> -
>  /*
>   * Note, this can't be converted to an inline function as this header
>   * file defines 'struct thread_struct' which is used in the task_struct
> @@ -666,6 +664,9 @@ extern unsigned long __end_init_stack[];
>  #define task_pt_regs(task) ((task)->thread_info.user_pt_regs)
>
>  #ifdef CONFIG_X86_32
> +#define task_top_of_stack(task) ((unsigned long)task_stack_page(task) + =
THREAD_SIZE    \
> +                                - TOP_OF_KERNEL_STACK_PADDING)
> +
>  #define INIT_THREAD  {                                                  =
 \
>         .sp0                    =3D TOP_OF_INIT_STACK,                   =
   \
>         .sysenter_cs            =3D __KERNEL_CS,                         =
   \
> @@ -673,6 +674,7 @@ extern unsigned long __end_init_stack[];
>
>  #else
>  extern unsigned long __top_init_kernel_stack[];
> +#define task_top_of_stack(task) ((unsigned long)task_stack_page(task) + =
THREAD_SIZE)
>
>  #define INIT_THREAD {                                                  \
>         .sp     =3D (unsigned long)&__top_init_kernel_stack,             =
 \
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/th=
read_info.h
> index 915a6839bd61..d8ccca04b4d9 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -30,10 +30,6 @@
>   *
>   * In vm86 mode, the hardware frame is much longer still, so add 16
>   * bytes to make room for the real-mode segments.
> - *
> - * x86-64 has a fixed-length stack frame, but it depends on whether
> - * or not FRED is enabled. Future versions of FRED might make this
> - * dynamic, but for now it is always 2 words longer.
>   */
>  #ifdef CONFIG_X86_32
>  # ifdef CONFIG_VM86
> @@ -41,12 +37,6 @@
>  # else
>  #  define TOP_OF_KERNEL_STACK_PADDING 8
>  # endif
> -#else /* x86-64 */
> -# ifdef CONFIG_X86_FRED
> -#  define TOP_OF_KERNEL_STACK_PADDING (2 * 8)
> -# else
> -#  define TOP_OF_KERNEL_STACK_PADDING 0
> -# endif
>  #endif
>
>  /*
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 58c1cd4ca60a..51020caac332 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -124,9 +124,8 @@ int arch_dup_task_struct(struct task_struct *dst, str=
uct task_struct *src)
>   */
>  void arch_init_user_pt_regs(struct task_struct *tsk)
>  {
> -       unsigned long top_of_stack =3D (unsigned long)task_stack_page(tsk=
) + THREAD_SIZE;
> +       unsigned long top_of_stack =3D task_top_of_stack(tsk);
>
> -       top_of_stack -=3D TOP_OF_KERNEL_STACK_PADDING;
>         tsk->thread_info.user_pt_regs =3D (struct pt_regs *)top_of_stack =
- 1;
>  }
>
> --
> 2.48.1
>

I'm not sure it's worth fully removing TOP_OF_KERNEL_STACK_PADDING for
64-bit if it results in needing separate definitions of
task_top_of_stack().  Leaving it at zero is fine.  The other changes
are fine though.


Brian Gerst

