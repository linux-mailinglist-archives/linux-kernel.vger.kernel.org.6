Return-Path: <linux-kernel+bounces-259220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF3F9392D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC931F2213C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736CB16EBE2;
	Mon, 22 Jul 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="sEG90JxP"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A416EB50
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667381; cv=none; b=qOURf/Lb07+IXCTXZdooutGqZeERcMsUDVjDvPv75/YNEipAvVmAp23mcK2meJwq0on1YW3kEeAtmZvb0xGG5yerKskeX0jYgxzjW6yq2vKLpc9Q/xOUNf0HYq95fengVX9tPSEg/J//+UYfMhvViVcS4C4TrbK6sqKstEZme/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667381; c=relaxed/simple;
	bh=qWS+P3Xttn1kxQZfDyagjS0gAxal6b05YpgQknqLBT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZOjphzsR8ifM0i1TitI1L6kcMXjV7XvfiwyFDMpbtM6PIyZKX95nc6GWLh7XY4oaYOIKnZmSCEPE6StIePcmx2kEzK+18Jt/zobyPTbTvxJxgU/eevhA5JHfiMmqSvcZZgwhbfoU/mN5YIG6/R5b2EX3t9AZ9nstz1SWr6mjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=sEG90JxP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d333d5890so589203b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1721667379; x=1722272179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HaPFqVHSx1KfpH7V20r5UGQPGW7ZAAcltHc6WnVyWFA=;
        b=sEG90JxPv2dLnXnV8UR4SuHiK/mNEZiC2G9htfiFseL8Za6w+Rio6RvrTI6HjiyJxC
         swwaxDsAa/MiQQ088njUHyGU1ekHjQQy9rLoUQvpqwvxTP0X9gp/Ep++xcij4QjwwjzD
         MmDydbRV/TyP5jTWkV8pfcoCxjUILseHvBNEgs/nF9ytqWdvfoA/rLbvYfYOftwHbOKc
         JcsoTgp3MQl/NE7W86m8SSNtCflDwwW9kuPRK2VUTkAAT/jdYWv9PDq5yHXAEe14Uq9s
         gKFkqJYEksvBiYOXc7GpDVvnJVvZu9XH+Yl7UNuQFXqYw+b/kfu58Pe4LQT1tXKJVecx
         sVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721667379; x=1722272179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaPFqVHSx1KfpH7V20r5UGQPGW7ZAAcltHc6WnVyWFA=;
        b=cQb9XGNjWC81XDLUfVfQXqMfHeoo3ydmP1ny0AV82BilrWurkqrkw87eH+Z3la/yDT
         KEO4NyOMxVrLRwPsb5YbeXLEwLCDpSDz+iNCpUzIW+q+M/QHe9i8AaYA9oFiP/EHaArF
         X9efcOhE1TntaMA7Kbh8c/JOn7Fwcm5kSaiBSlHQicGWm8ZIqPFmRKEVfGemwZkJLObz
         QunnUaugRPGPoX1E0/52wswcoKzgB2tI7vsoSWbjFQdPZrDrYiIKvB/qg5BehkK9PVyO
         0OVd0245uWdeOfgM5VpNn7Lh3/M0TRvUZP0cekGKRcwfDtIFkq50U6X4iJgER9yQuB9k
         4mJw==
X-Forwarded-Encrypted: i=1; AJvYcCWsAoj0rtReFM97wJuCpaw43Hx0RRiKliwDlwIRsSbdia6yettWeUFl1N8MFwhbdEN6DX+A/btmLKltvjvPHnkMutxMpav7n5QsDXS8
X-Gm-Message-State: AOJu0Yyl9oM9pH5Em70ZuT0J5yuzdnu8NqRzlHfFFAA4hM+qFMi4fj3L
	K7IGAhAZdMl4bQYbLOsHN0XW621BkJpOrYUi5IiuUaXvNNEKlPtOQcf13pKG3h4WpTvHUJaE3+E
	pvG+WN0snUuKIYlFvJRcPe/tQAe28y2o3GN8GMlcqlNxsenpbbyRm
X-Google-Smtp-Source: AGHT+IHlCWzv3WwWBjI4tZnpzweNtV0lQc4jmtsZE7VqE1QoVmYF0013pH0goDjIIXdT+yL2ln2NCGQriqN7xFsKDLE=
X-Received: by 2002:a05:6a00:1384:b0:705:de1d:f7f9 with SMTP id
 d2e1a72fcca58-70d08314452mr11422785b3a.0.1721667379173; Mon, 22 Jul 2024
 09:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHbf0-G4bmpuXorwH-e_chWm1fXX7AJ8ck5AL4p+AFevhvdBfg@mail.gmail.com>
 <20240722152330.GCZp55ck8E_FT4kPnC@fat_crate.local>
In-Reply-To: <20240722152330.GCZp55ck8E_FT4kPnC@fat_crate.local>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Mon, 22 Jul 2024 17:56:08 +0100
Message-ID: <CAHbf0-FTrRPfDTkkSjq9yvyFrWvoYjH_uJAW5KDae8vO-hch+w@mail.gmail.com>
Subject: Re: Boot Warning
To: Borislav Petkov <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

That patch does indeed make the warning go away :D

Is there anything else you need from me?

On Mon, 22 Jul 2024 at 16:23, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jul 22, 2024 at 01:45:35PM +0100, Mike Lothian wrote:
> > Hi
> >
> > I'm seeing the following boot warning:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at arch/x86/lib/cmdline.c:211
> > cmdline_find_option_bool+0x741/0x760
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.10.0-tip+ #4105
> > RIP: 0010:cmdline_find_option_bool+0x741/0x760
> > Code: 85 07 f9 ff ff eb 20 41 80 f8 21 72 1c 45 31 c9 41 80 f8 21 41
> > 0f 93 c1 45 01 c9 81 f9 00 08 00 00 0f 85 e5 f8 ff ff 31 c0 c3 <0f> 0b
> > 48 85 ff 0f 85 ce f8 ff ff b8 ff ff ff ff c3 cc cc cc cc cc
> > RSP: 0000:ffffffff83803f18 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
> > RAX: 000000000a50000c RBX: 0000000068747541 RCX: ffffffff833f2bec
> > RDX: 0000000000000000 RSI: ffffffff832def4e RDI: ffffffff83b98820
> > RBP: 0000000000a50f00 R08: 00cf9a000000ffff R09: 0000000000000030
> > R10: 000000006c617470 R11: 0000000000100000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00000000b53e4000 R15: 00000000b53e4000
> > FS:  0000000000000000(0000) GS:ffffffff83acd000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffff8880b61c6810 CR3: 0000000004b57000 CR4: 00000000000000b0
> > Call Trace:
> > <TASK>
> > ? __warn+0xcb/0x1c0
> > ? cmdline_find_option_bool+0x741/0x760
> > ? report_bug+0x173/0x220
> > ? early_fixup_exception+0x4a/0xa0
> > ? early_idt_handler_common+0x2f/0x40
> > ? cmdline_find_option_bool+0x741/0x760
> > ? check_loader_disabled_bsp+0x46/0xa0
> > ? load_ucode_bsp+0x6b/0x80
> > ? x86_64_start_kernel+0x4b/0x70
> > ? common_startup_64+0x12c/0x137
> > </TASK>
> > ---[ end trace 0000000000000000 ]---
> >
> > I use an efi stub kernel
> > https://github.com/FireBurn/KernelStuff/blob/master/dot_config_tip
> >
> > I wasn't quite sure where to report this in the bugzilla, I'll happily
> > raise one if you let me know which section it should be in
>
> Yeah, you can usually CC x86@ and lkml and that is fine too - bugzilla is not
> absolutely required. Did that now.
>
> Anyway, yeah, this is nasty. Our handling of the merging of the builtin and
> boot cmdline options would need some serious reshuffling to fix this: the
> ucode loader needs to parse cmdline but the final cmdline is built a lot
> later.
>
> The only easy thing I could think of right now is, well, to check both cmdline
> strings before the merging happens.
>
> Something like the completely untested below:
>
> ---
>  arch/x86/include/asm/cmdline.h |  4 ++++
>  arch/x86/kernel/setup.c        |  2 +-
>  arch/x86/lib/cmdline.c         | 27 ++++++++++++++++++++-------
>  3 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/cmdline.h b/arch/x86/include/asm/cmdline.h
> index 6faaf27e8899..abcb270e2a07 100644
> --- a/arch/x86/include/asm/cmdline.h
> +++ b/arch/x86/include/asm/cmdline.h
> @@ -2,6 +2,10 @@
>  #ifndef _ASM_X86_CMDLINE_H
>  #define _ASM_X86_CMDLINE_H
>
> +#include <asm/setup.h>
> +
> +extern char __initdata builtin_cmdline[COMMAND_LINE_SIZE];
> +
>  int cmdline_find_option_bool(const char *cmdline_ptr, const char *option);
>  int cmdline_find_option(const char *cmdline_ptr, const char *option,
>                         char *buffer, int bufsize);
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 5d34cad9b7b1..6129dc2ba784 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -164,7 +164,7 @@ unsigned long saved_video_mode;
>
>  static char __initdata command_line[COMMAND_LINE_SIZE];
>  #ifdef CONFIG_CMDLINE_BOOL
> -static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
> +char builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
>  bool builtin_cmdline_added __ro_after_init;
>  #endif
>
> diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
> index 384da1fdd5c6..75e7e2cc4569 100644
> --- a/arch/x86/lib/cmdline.c
> +++ b/arch/x86/lib/cmdline.c
> @@ -207,18 +207,31 @@ __cmdline_find_option(const char *cmdline, int max_cmdline_size,
>
>  int cmdline_find_option_bool(const char *cmdline, const char *option)
>  {
> -       if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
> -               WARN_ON_ONCE(!builtin_cmdline_added);
> +       int ret;
>
> -       return __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
> +       ret = __cmdline_find_option_bool(cmdline, COMMAND_LINE_SIZE, option);
> +       if (ret > 0)
> +               return ret;
> +
> +#ifdef CONFIG_CMDLINE_BOOL
> +       if (!builtin_cmdline_added)
> +               ret = __cmdline_find_option_bool(builtin_cmdline, COMMAND_LINE_SIZE, option);
> +#endif
> +       return ret;
>  }
>
>  int cmdline_find_option(const char *cmdline, const char *option, char *buffer,
>                         int bufsize)
>  {
> -       if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
> -               WARN_ON_ONCE(!builtin_cmdline_added);
> +       int ret;
> +
> +       ret = __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option, buffer, bufsize);
> +       if (ret > 0)
> +               return ret;
>
> -       return __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option,
> -                                    buffer, bufsize);
> +#ifdef CONFIG_CMDLINE_BOOL
> +       if (!builtin_cmdline_added)
> +               ret = __cmdline_find_option(builtin_cmdline, COMMAND_LINE_SIZE, option, buffer, bufsize);
> +#endif
> +       return ret;
>  }
> --
> 2.43.0
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

