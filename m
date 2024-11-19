Return-Path: <linux-kernel+bounces-414972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED119D2FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB02DB250DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE91D3566;
	Tue, 19 Nov 2024 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ez8OoD4a"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52A1D14F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049873; cv=none; b=oac/N/8ykroeIulcCwENWItFZBUJBkt/nCHMxHApgFDpJ4L760AkcnqaVOKZlQhyz+JLv0raaSLZj20SC+qxZuhl4C6cDzqwPLeNKCcAXHJrqxchJAT5xURaKVPyYl9AiigF2L/9/7OiuNokp8eBXGmDmZC+n7ZlzqZkL60dUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049873; c=relaxed/simple;
	bh=T9k6akBoWDnUL0LVwaHr9eD4/FLAcbYOjsPXB7IxjUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TVS4trcM78ltfsmhjEMI8eC+FUkOs9ObuzyhcGNdhUvJGR64PN5AdkyzVlIU0IAkl9sWaPVrpOw/kD0p5A5OhLwsZ3fmC61KKKjMKAzbYwyWMZDw9icuxTP1YNwW8Era7WqADqwrn/31YXc5LCPYXUhnfbGZyqN61uXnUrU4reg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ez8OoD4a; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ebeca94c87so341418eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732049871; x=1732654671; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO9EX+rbjLtm8cqkrUr8HQs42GPnLgvoRuxnFLut8c0=;
        b=Ez8OoD4aZx7RkQ6/PNXvJD3bVJV5EeVCHx8YP0cQ/xd8zRl4KarNjRTbKUfycKQyDU
         1W2qRNLLq3liRcQrcEMyjhUZd2uZvO8vGl4fMcrVcqcV/5dWhlYqjtVq6iWlhsaWfqHg
         bbD+N1MJ56kkPFXQeF5rflrR8HOK0hFc4GK6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732049871; x=1732654671;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO9EX+rbjLtm8cqkrUr8HQs42GPnLgvoRuxnFLut8c0=;
        b=wIB2gp3pKSE5OzXXYsWUi5H4KGxAuyDyYCeWJk3fzlTc6aj+CeN80XxGZ5ypLKjPZV
         LV7H2X6NfGcjhuMCYkamnsQ9ChEhHhnfWdHx83TU+0ffRRhXDlRM3CJUSkPtzzx692gd
         OQK3qrE3ftR7sJumq7aaBd+xy8b9J2OhWX2LktJN0O2esoDuasjz1b7mFzGv8dgEwpPM
         gXPNBm3FZA6hB4pHIoF9Hi76BXRN1XXiDympMXgyh+hFIDWIpIDa4U4nsNwBrOg49sjd
         7YF6YtlmbHFMOWwKY44h0CW0cYXJDSrB+LZ0NYAu3bl48XrdFVBj4PfcRPBCH2DPrfyd
         q52A==
X-Forwarded-Encrypted: i=1; AJvYcCWgUKVLunXe6beDmXnoFI7cUeivihB1H2XdudoB8XAeU1AKoVOHrT6ZLb0U/uCcObmqvdpRityYBclzxaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4A4AkobAiR17sYJyH4Og9rlnX4fa2riflw9wOxYpCRb3Zxm43
	5o+myTUZXR+d2jeL2b2JEycNLO8c/+z1tNGxHKTFY/Gei1Ns0gflevdw5DyNc06Y6xcSWyiRdRc
	pSGiiiBkE7btXK/gRRACVnY/isrgAmcSL3GSM
X-Gm-Gg: ASbGncu4oU/Or0xPqiIJvX3oIYOqz++arZ+c54vB6ODibZvzZ8PaIdpAflXbkHWOBYd
	4BcfrPiWczx+nk/CYXyz3mXwp06epm964uouN55u9wRHtkLcnxel0XYB58aYq
X-Google-Smtp-Source: AGHT+IFTrU1fA61t0Luh+9E+lP7gFvXHb60eu4Gw43LbPkNHC4l2jJzMO4RiOm3/mriXN7Czm3b797q73IggsHtNEWA=
X-Received: by 2002:a4a:d342:0:b0:5eb:c1fe:881c with SMTP id
 006d021491bc7-5eee7ee759bmr95103eaf.0.1732049870869; Tue, 19 Nov 2024
 12:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113191602.3541870-1-jeffxu@google.com> <20241113191602.3541870-2-jeffxu@google.com>
 <w2kg2rvvp3vwgqlvvtnne2dccnhjamc2g5zxm2ko47khkodedw@ftzp7ekf4sft>
In-Reply-To: <w2kg2rvvp3vwgqlvvtnne2dccnhjamc2g5zxm2ko47khkodedw@ftzp7ekf4sft>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 19 Nov 2024 12:57:39 -0800
Message-ID: <CABi2SkUiJkqyT5=Dun8hHYEFVDcmjP0zz2No-EOm5GFMbLOSBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] exec: seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liam,

On Wed, Nov 13, 2024 at 4:54=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [1]. It is sealed from creation.
>
> Why are you referencing mseal.rst for the uprobe mapping lifetime?  I
> can't find anything in there about uprobe.
>
This should be [2], thanks for checking.

>
> It also can't be used on 32 bit systems, as per your kernel-parameters
> changes (and mseal specification).  This is missing from the changelog.
>
sure, I will add that to the commit msg.

> > +     exec.seal_system_mappings =3D [KNL]
> > +                     Format: { no | yes }
> > +                     Seal system mappings: vdso, vvar, sigpage, vsysca=
ll,
> > +                     uprobe.
> > +                     This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPIN=
GS
>                              ^^^^^^^^^ overrides ?
sure.


> > -     if (vsyscall_mode =3D=3D XONLY)
> > -             vm_flags_init(&gate_vma, VM_EXEC);
> > +     if (vsyscall_mode =3D=3D XONLY) {
> > +             unsigned long vm_flags =3D VM_EXEC;
> > +
> > +             vm_flags |=3D seal_system_mappings();
> > +
>
> nit, extra line here.
>
removed.

> But.. this will add the VM_SEALED flag on any 64bit architecture that
> enables the SEAL_SYSTEM_MAPPINGS config.  That will happen by bots with
> random config builds.  I don't know if they have test cases that
> specifically unmap the vmas you are sealing (ppc64 probably tries to
> unmap the vdso).
>
> I do know that I've had syzbot bugs that unmap _all_ vmas.  I'm guessing
> you will get bot notification on these failures for any 64bit
> architecture.  You may want to look into it to avoid such fuzzing
> failures, but we still need this to be tested somehow.
>test_mremap_vdso.c
I found one selftest that could fail:
tools/testing/selftests/x86/test_mremap_vdso.c

I could add tools/testing/selftests/x86/config and add
CONFIG_SYSTEM_MAPPINGS=3Dn there.
as instructed in selftest documentation [1]

[1] https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests=
-details

>
> overwrite or override?  I think the difference is that overwrite implies
> permanence where override doesn't.  I'm fine with either, it just reads
> a bit odd to me.
>
sure, changed to override

> >
> > +config SEAL_SYSTEM_MAPPINGS
> > +     bool "seal system mappings"
> > +     default n
> > +     depends on 64BIT
> > +     depends on !CHECKPOINT_RESTORE
> > +     help
> > +       Seal system mappings such as vdso, vvar, sigpage, vsyscall, upr=
obes.
> > +       Note: CHECKPOINT_RESTORE might relocate vdso mapping during res=
tore,
> > +       and remap will fail if the mapping is sealed, therefore
> > +       !CHECKPOINT_RESTORE is added as dependency.
>
> You could also add a portion here about your override functionality on
> command line. "this can be disabled or enabled by..."
>
sure.

> I really think having something that can be found by searching for mseal
> is really desirable here.  That is, make menuconfig, press / for search,
> type mseal -> find this feature.  If this was MSEAL_SYSTEM_MAPPINGS,
> searching for seal or mseal would work and would serve to link the
> config option to the mseal document.
>
using "seal" would work here. I will add a note here to mseal.rst for refer=
ence.

> Right now there is no information in the help that will allow it to be
> found by 'mseal'.  There is also nothing in the documentation that
> states this exists, which you should probably update with this feature?
>
I will update mseal.rst to include this feature.

Thanks for reviewing.
-Jeff

