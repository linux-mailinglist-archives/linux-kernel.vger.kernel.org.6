Return-Path: <linux-kernel+bounces-513993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FAFA3511C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3521316CEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315C0266B59;
	Thu, 13 Feb 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OF3e67zR"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7444C7C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485215; cv=none; b=trf8uzTfUKtnaBnDLnOp0hDyGLH5pao4qlTMAcVXWYnTui2SRDrIWGy5eDvO83revQwlySi0HOxVVMnFpCzM1yu/7gvCRLSDwlEZPtNa1BuSPNL1pPjD8T7oxTW9eKlhsRTUP3Sp4NE7TZtFUT54CTuhqP84HE5WtLPcoH06XHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485215; c=relaxed/simple;
	bh=rkI2bgoqBjwvLXctY39v3PT6mQA1sS7b8DeXKPCOsfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thfYN2YYDyMOihAMZYBNVOTDtrARec9ewrz+IWAC247UboF+hDMUgPHSk5h/i5cOvT1ktYHj5jIY9801gQAs5+cZE52QGbEa4/3HmJg19P62x5w4ug7ExUgAdKOwz+sMajaDrG7AaQzPtpPjLxeuqL/esy9BDfkc639xOV9Y9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OF3e67zR; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f3c9c1edbbso59630b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739485213; x=1740090013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRaz9OxCEX01QL7HD6xXPMgP9kkUY8bY3eYmomXDOGg=;
        b=OF3e67zR/H0ZRabAn8rGGSroJXcpFSJ56aYKpIK6V488w+ANSUjA83QfpLPTKWLeBy
         qyvnAkofToppUrHUbc/cVghI1LcSjKTRclliSdOPcvj1uluqVWJgqaLWQSviCyLfsQcO
         idJ9DHzL0cPvZ0RcspRL4AzUAtbjidv042HaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485213; x=1740090013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRaz9OxCEX01QL7HD6xXPMgP9kkUY8bY3eYmomXDOGg=;
        b=lMRuNWksUHKGrtVLZ6SfQZ5NoJkBj1s6NapnfbGjfUUryIfJc2VDkK2Afvn/dOOI+G
         54mgEFITnSYE04NZpap+wBgH3atxgnwHKO1ItZSKJctneP12AnRRNNifqHJ7n3AlQFC3
         UO2DQcvjKjvVPjw6dClufDkIb+6cO05LNvcGavtZUOoypQr0GgqJ5qfkD1ZWI0hpfM4e
         JYXyUrNuES2ENjsLqMNIWbKb68a/N3g9/xVu3zlzqeKyDuTB5dv73jES3NcNvbcSXGYg
         dbjsNHpXGoLEo/KyXHLVyh9pzkDrhZgI/impBvasuC3xhvMusmRWwfaCumEUMxsmQQy/
         L9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy+erCAA4ue5MIlcJcJarW4S97pSU47pJY+Fa0+Dp5XXVx0EcZKLukSuJk7Vlq4Wz378AM91ch6xQut10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdta/mWartYx/Unjfqit5KE/0250OUZSVx0+2gGI/Sca6nf0NV
	SrpROa58sF014157aPpRdvgFLRceB4NwgY+rNVwThp0mB59G2kH2QrHlHHMknDCLAv3cUMhIU6E
	1UfGLEh6KyEGA48wNsTfxh3p2XcvwOSObtDZc
X-Gm-Gg: ASbGnctKSRd+X4+PDoHyAFfZUS2iDTF8VFPrRTqVzpzoPB5HVpVH6/ni0h+s+KMAbpR
	ybtF+BqI3t0tPyiAllngnlkO5PylUvKnowg1BJxT5pC2Q9keUjJPUWqb/htPv8Ifymc0iGg262n
	H4NlIh/XFIexdddwQCsgyUXzV5oExcKg==
X-Google-Smtp-Source: AGHT+IGEgr/tnpmZ7iFKLQkIbh+ChcL78omaiRk8B15Pn3sTe3eFnZc5dLwS9oc27svBh749EcdLfS07kL59waveuvE=
X-Received: by 2002:a05:6808:13c3:b0:3eb:45de:8ab5 with SMTP id
 5614622812f47-3f3e1a32cc6mr168816b6e.4.1739485212888; Thu, 13 Feb 2025
 14:20:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-3-jeffxu@google.com>
 <20250212135000-861e6353-6e0a-43c3-9b28-649ae4dfc607@linutronix.de>
 <CABi2SkUCviiTbd1roeBiqSk98S87R1WwSP9rUYh4t3JfSD+2ZA@mail.gmail.com> <35C0FD0B-0483-4663-AD60-701AB8D9247A@kernel.org>
In-Reply-To: <35C0FD0B-0483-4663-AD60-701AB8D9247A@kernel.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Feb 2025 14:20:01 -0800
X-Gm-Features: AWEUYZli_FRMoDmTOv0oE_wQIaDl_68u_YOG1Uo7f717uYIA8g5CWTTkKASWsyQ
Message-ID: <CABi2SkU0kW8yAoucxLjkqXpFJMJzGDmKZZhgMJGobaALNVTGvA@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 11:28=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On February 13, 2025 6:14:00 AM PST, Jeff Xu <jeffxu@chromium.org> wrote:
> >On Wed, Feb 12, 2025 at 5:04=E2=80=AFAM Thomas Wei=C3=9Fschuh
> ><thomas.weissschuh@linutronix.de> wrote:
> >>
> >> On Wed, Feb 12, 2025 at 03:21:50AM +0000, jeffxu@chromium.org wrote:
> >> > From: Jeff Xu <jeffxu@chromium.org>
> >> >
> >> > Add code to detect if the vdso is memory sealed, skip the test
> >> > if it is.
> >> >
> >> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >> > ---
> >> >  .../testing/selftests/x86/test_mremap_vdso.c  | 38 ++++++++++++++++=
+++
> >> >  1 file changed, 38 insertions(+)
> >> >
> >> > diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/=
testing/selftests/x86/test_mremap_vdso.c
> >> > index d53959e03593..c68077c56b22 100644
> >> > --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> >> > +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> >> > @@ -14,6 +14,7 @@
> >> >  #include <errno.h>
> >> >  #include <unistd.h>
> >> >  #include <string.h>
> >> > +#include <stdbool.h>
> >> >
> >> >  #include <sys/mman.h>
> >> >  #include <sys/auxv.h>
> >> > @@ -55,13 +56,50 @@ static int try_to_remap(void *vdso_addr, unsigne=
d long size)
> >> >
> >> >  }
> >> >
> >> > +#define VDSO_NAME "[vdso]"
> >> > +#define VMFLAGS "VmFlags:"
> >> > +#define MSEAL_FLAGS "sl"
> >> > +#define MAX_LINE_LEN 512
> >> > +
> >> > +bool vdso_sealed(FILE *maps)
> >> > +{
> >> > +     char line[MAX_LINE_LEN];
> >> > +     bool has_vdso =3D false;
> >> > +
> >> > +     while (fgets(line, sizeof(line), maps)) {
> >> > +             if (strstr(line, VDSO_NAME))
> >> > +                     has_vdso =3D true;
> >> > +
> >> > +             if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS=
))) {
> >> > +                     if (strstr(line, MSEAL_FLAGS))
> >> > +                             return true;
> >> > +
> >> > +                     return false;
> >>
> >> This only tests that any mapping after the vdso is sealed.
> >
> >The code above begins by searching for the "[vdso]" string, then looks
> >for the first line that starts with "VmFlags:", and looks for the "sl"
> >substring within that line. We're assuming the format of smaps won't
> >change from release to release.
>
> Oh, I missed this in my reviews: nothing _resets_ has_vdso to false, so i=
f any other mapping follows vdso that happens to be sealed, this will retur=
n true...
>
It won't return the next mapping's sealing flag.
After finding the "[vdso]", if the next line that contains VMFLAGS
doesn't have the "sl" flag, the function returns false immediately.

> >
> >> There is a real parser for /proc/self/smaps in
> >> tools/testing/selftests/mm/vm_util.[ch], see check_vmflag_io().
> >>
> >This test is in selftest/x86, which makes it hard to include the
> >vm_util from selftest/mm, if that's what you're asking.
>
> Hm, we have done these kinds of inter-tests dependencies before. (E.g. se=
ccomp includes stuff from the clone tests.) I think it should be possible i=
f it can just be a header include. Linking across tests would be more frust=
rating.
>
I can switch to vm_util, I will need to add a new parsing function in
vm_util, the existing __get_smap_entry() only searches for vm's
starting address, not name.

Thanks
-Jeff


> -Kees

>
> --
> Kees Cook

