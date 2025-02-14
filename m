Return-Path: <linux-kernel+bounces-515100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0259A36012
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC7B189373C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB8E265CA0;
	Fri, 14 Feb 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PcZvAbHA"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948225A645
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542537; cv=none; b=Qu5e6ksmnIOSC3VC37bxwJdD3QbWRULnT4SU6OArADIp21t6erHsvuzo25MXtaEAwcBaoBQGz+GECXkZ1ojOgQBWqXB5mcttquQTgSeWDahDaSVmd/M0mxiRht/KRsv+EeKXsHY5PLkU2RS+cCEybD1L/pH3YJuphrciQiS3KGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542537; c=relaxed/simple;
	bh=Vg3CFjgZ4NjWXgslmVJ4H6JEVnL4fXVyeFPaL3zku7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgqnUipH6RF19pYwe1SrVuyFSIlpNIbzOv9DOidNv9vaUqdjK6zHoVTyAGZSuxkF9vm+qnkF9nDhywZH2ZKAKzwmiIGA+4Zc3hLtmyi8pt9gDaX3t0TnxG6OJIEDuiICOEYojF2ipTqgtWaU7pQH4rAy08dyIvRDE1BsiiV8VFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PcZvAbHA; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f3deb13b87so74786b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739542534; x=1740147334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUSHq3jaDRKrxbHBpMUUMtmLRZDuG6csEtNLoVlgBlw=;
        b=PcZvAbHAhWaVh3TBvScKKHci3ZLEkVWkpaJYLA8Drl5X9+HdqEk2xY5PROIFGAE1Op
         ih1FAc6mf59rAuEl9gp33d+D5i2uR/O1pOrq18gBSC7ItVXtKrhDvS2KyiSglJ5LsXuT
         Wy9VzC6qg3jm7GWcxYcOFA9rwoIQUfpXAruHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739542534; x=1740147334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUSHq3jaDRKrxbHBpMUUMtmLRZDuG6csEtNLoVlgBlw=;
        b=ERb9Z1UEWHXuAaPKDaOKsdcngkBI0mi4iyOz4BJjKhW51NpG9Kj3z9r/IwcoEH+3IS
         p2/Z85Ez/2gDuNLtbaXlWctx5l9yXut+SNwJh6AiLvzQPV1qujLJZiIlwwiKp66yqAz3
         B3s5I6hWMK50B8AU9ygCw0ldXulVNolHM761bIkKnRxP3jrmBgtON2dBgVDrO29SrWTd
         TaSe3kmKJts4jYK7KGEVAKtKliuubgNO/eAs4tYojJuM/YNA+4dhUhfX4zCVZjj5VcXe
         5u1wkNrHAYTrsL8hqIJSGfdV6PMAmZWuJzSQCbK3zuUH5/vWLytYnEQwojccG0NMk966
         7OIA==
X-Forwarded-Encrypted: i=1; AJvYcCVOfnnWgMlR/adJ0e0g9wMPwI8F1ejfoXX92TUZyS89gWIy/OXi7ZQ1ghzDgULZJFAHRPPTYwzkgg3eDM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsUnFkxWqwyEwyi2EUq95SGRcDJkZMeYYoymMtzwtZpZ5LDrEg
	/FPdjeqAjL+xoDdLFvCRw0nYBUHjlG1BIC39/2LQzYlMfiaZg5u2PYbBPjF0MYeGdSK3zmOqyZU
	eVvJVh9cEZxDgYZONDIp39e21wPEfAvqHxN90
X-Gm-Gg: ASbGncsRw4dI2pT/i4Ty2zB21mdYyG3EEmEIr1VE4cawu20aMXoF+cz6sJdilUtW74e
	Y0hnWJQco4O4WZrna81jwbX+6YKvtkPKOCh4Qm9Y0e/wNvYDkuMtlYJzoTiaYGWdBrn8996CJ15
	d4XLtn2evp49CMIf45xz+0u/diXrnzUA==
X-Google-Smtp-Source: AGHT+IGWTatZC4i6Xeclni+qSZuML5VogNMExsBKztM0nMedMyzeMcfxgLKyTArA7nCZqL1C62QN50G8Y+0AaZqQ5oc=
X-Received: by 2002:a05:6808:2223:b0:3f3:d712:ed1d with SMTP id
 5614622812f47-3f3d712eec2mr2215561b6e.3.1739542534360; Fri, 14 Feb 2025
 06:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-3-jeffxu@google.com>
 <20250212135000-861e6353-6e0a-43c3-9b28-649ae4dfc607@linutronix.de>
 <CABi2SkUCviiTbd1roeBiqSk98S87R1WwSP9rUYh4t3JfSD+2ZA@mail.gmail.com>
 <35C0FD0B-0483-4663-AD60-701AB8D9247A@kernel.org> <CABi2SkU0kW8yAoucxLjkqXpFJMJzGDmKZZhgMJGobaALNVTGvA@mail.gmail.com>
 <462A068C-489E-400D-9E82-F54F46E77DF3@kernel.org>
In-Reply-To: <462A068C-489E-400D-9E82-F54F46E77DF3@kernel.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 14 Feb 2025 06:15:00 -0800
X-Gm-Features: AWEUYZnCbHWd4NfDRp5Q7loL4F7IOU0imN4RIPXvJI6KVbMK6gXuf6iKqHba70I
Message-ID: <CABi2SkXjiJ-fmJxTFdzHRyT9opxUYbYJ1zEmRameDhHECLtJdg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/7] selftests: x86: test_mremap_vdso: skip if vdso
 is msealed
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 6:52=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On February 13, 2025 2:20:01 PM PST, Jeff Xu <jeffxu@chromium.org> wrote:
> >On Thu, Feb 13, 2025 at 11:28=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> >>
> >>
> >>
> >> On February 13, 2025 6:14:00 AM PST, Jeff Xu <jeffxu@chromium.org> wro=
te:
> >> >On Wed, Feb 12, 2025 at 5:04=E2=80=AFAM Thomas Wei=C3=9Fschuh
> >> ><thomas.weissschuh@linutronix.de> wrote:
> >> >>
> >> >> On Wed, Feb 12, 2025 at 03:21:50AM +0000, jeffxu@chromium.org wrote=
:
> >> >> > From: Jeff Xu <jeffxu@chromium.org>
> >> >> >
> >> >> > Add code to detect if the vdso is memory sealed, skip the test
> >> >> > if it is.
> >> >> >
> >> >> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >> >> > ---
> >> >> >  .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++=
++++++
> >> >> >  1 file changed, 38 insertions(+)
> >> >> >
> >> >> > diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/too=
ls/testing/selftests/x86/test_mremap_vdso.c
> >> >> > index d53959e03593..c68077c56b22 100644
> >> >> > --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> >> >> > +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> >> >> > @@ -14,6 +14,7 @@
> >> >> >  #include <errno.h>
> >> >> >  #include <unistd.h>
> >> >> >  #include <string.h>
> >> >> > +#include <stdbool.h>
> >> >> >
> >> >> >  #include <sys/mman.h>
> >> >> >  #include <sys/auxv.h>
> >> >> > @@ -55,13 +56,50 @@ static int try_to_remap(void *vdso_addr, unsi=
gned long size)
> >> >> >
> >> >> >  }
> >> >> >
> >> >> > +#define VDSO_NAME "[vdso]"
> >> >> > +#define VMFLAGS "VmFlags:"
> >> >> > +#define MSEAL_FLAGS "sl"
> >> >> > +#define MAX_LINE_LEN 512
> >> >> > +
> >> >> > +bool vdso_sealed(FILE *maps)
> >> >> > +{
> >> >> > +     char line[MAX_LINE_LEN];
> >> >> > +     bool has_vdso =3D false;
> >> >> > +
> >> >> > +     while (fgets(line, sizeof(line), maps)) {
> >> >> > +             if (strstr(line, VDSO_NAME))
> >> >> > +                     has_vdso =3D true;
> >> >> > +
> >> >> > +             if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFL=
AGS))) {
> >> >> > +                     if (strstr(line, MSEAL_FLAGS))
> >> >> > +                             return true;
> >> >> > +
> >> >> > +                     return false;
> >> >>
> >> >> This only tests that any mapping after the vdso is sealed.
> >> >
> >> >The code above begins by searching for the "[vdso]" string, then look=
s
> >> >for the first line that starts with "VmFlags:", and looks for the "sl=
"
> >> >substring within that line. We're assuming the format of smaps won't
> >> >change from release to release.
> >>
> >> Oh, I missed this in my reviews: nothing _resets_ has_vdso to false, s=
o if any other mapping follows vdso that happens to be sealed, this will re=
turn true...
> >>
> >It won't return the next mapping's sealing flag.
> >After finding the "[vdso]", if the next line that contains VMFLAGS
> >doesn't have the "sl" flag, the function returns false immediately.
>
> Oh! Agh, yes. You are right, this is all fine.
>
> >I can switch to vm_util, I will need to add a new parsing function in
> >vm_util, the existing __get_smap_entry() only searches for vm's
> >starting address, not name.
>
> Unless someone feels strongly about this, my instinct is to avoid the hig=
her complexity of a cross-test thing.
>
OK. I will keep the existing test.

If we decide to use vm_util, it would be best to refactor it
separately later on. The existing vm_util can't be used as is for my
needs, so some refactoring would be necessary.


Thanks
-Jeff

> -Kees
>
>
> --
> Kees Cook

