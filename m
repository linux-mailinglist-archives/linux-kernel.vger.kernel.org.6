Return-Path: <linux-kernel+bounces-532653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEBBA4505E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D90167C72
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B221D3E0;
	Tue, 25 Feb 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cSf1Negk"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767D21D3C4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523080; cv=none; b=unE2k97cAMy8jVbVQsj0i2NJSP9BA+4xyEHsN0dCaL4tnOUslQMwN1T2VvoaXl9Ujf73BCbY3aNSBss8DzlPr5u/ytHM1mtgTKCTktiRQAE6o7vzJa7bFsU1bmTqHZRvM5OGKkNTNneIBYYkYFFLQgim2XeutiyTrB0UfVYGOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523080; c=relaxed/simple;
	bh=aXrabKXlM0IsIZuDH6QT6eCKq7zU4WZZRKh8RcjzM6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsx+TLkkUGSvRIqxcCponbMqlRy1L2n2hUks0qtvFpKA9VEYBr9+6plDUgyFlcCRxl/Lyftvp6fi9o1YHpk+Fvk0ZHCbmzi6I8i4IZ4A66gSYQmiyeOyoC0QnIdhraLMKSip9RFQTYh6Etf9gCJEcvDfp6pmUoanUKBN40mjWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cSf1Negk; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-724daedf8c3so1567739a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740523078; x=1741127878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TM09Vy3kN6bqyw39MdyhtNezW+WJUnfi9H/ALFTk9Q8=;
        b=cSf1Negkg/Ryr7WSJ7S2yPded28YGB1f25ttqVD5kxbAWuN/9ZDbl0nEquaFuQdHOJ
         PxDToikmLTU6tcQdLvsazmQj9ZuU86fblBps8Ezk0CFo0hOILvJe9sV8WbSFW3WwZ0DH
         NlbLEI8ukfOmVqJ3qEBQxzUAqSJefCFg46yxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523078; x=1741127878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TM09Vy3kN6bqyw39MdyhtNezW+WJUnfi9H/ALFTk9Q8=;
        b=G56nzQsRIHicAfwrU/Fqdi3TZLMWohmr8IFPL2GYMtPE3d2JVOyzsvaEQkWZ8GSCh/
         KI3lGK80w6aKLqr5dnuPxj6Mar53NDXSU7v5vellhRHZjvh/VnGgIPBb285cVfPMqIUT
         oW0cgUHbQqiyzCs2uNcwtsH2Tq/PM5Zn+MqFehHSUn1rYRpn/Lk9Vd2NTRPFPjl9NVpH
         s8L46oC6yE0EgL+DbyVgb5sVx4DDgRf7Y9OXKTPrDEA/oeZRZc08j/bq6dgs9vYI1A27
         7xRe3Q4c1bZI4fMnJSiit5las0Szwsh7HGGguxhio6xbag41JPQ+FCWfQGe9RhReDVRc
         GsKA==
X-Forwarded-Encrypted: i=1; AJvYcCXGuOQr6CsC1Usl/UoYvx5grwvrPzqw6BMKFJp6BGUnCzxEM3L/8nr71tieLeQ5sOpa/LwIX/MhOzLmIJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3aFh1EnAYWad1AwXKAgZ0t2tYauhP7qaH/vx62Tw/Ji0Jtrvc
	dBzpYaAyNDCDe1ug5s1dlkHJ27oZ0htOLg5h4RdAng/991JHdkCKUVuRVXy2ENfenw4qD4stms5
	NcL08qvSIBlZG95uaIfWfZsGkalgzSDmEzw/a
X-Gm-Gg: ASbGncv3eJvZ+6PLRKoGRNYSSd+rnCoXsnhs+P/REKev4tKv8ldlL9YXI/ybGJQ8vND
	EvKVanKXBcD1kWrl8QRqHVZx/4lI/TKc6/3S5RLPRxNxjzOT9zgkwEhcGKk4TJj/wq5Bn7dCguh
	c4SkwZVb4JzJaAnWkhAlSHEJHN8wFmqCTSC+I=
X-Google-Smtp-Source: AGHT+IEpcvXgYiPClCySX5ynQ10F8Hy35U+lAZUo00/td8VvueGsr0yfG4XsKHGe1Drl9rCIX+ro1GOLwaDthyw6wO4=
X-Received: by 2002:a05:6830:3106:b0:727:2b73:cbb7 with SMTP id
 46e09a7af769-7274c257d4emr4278353a34.4.1740523077707; Tue, 25 Feb 2025
 14:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-3-jeffxu@google.com>
 <f300404f-91a9-40ae-8fcc-2e855b43ac76@lucifer.local>
In-Reply-To: <f300404f-91a9-40ae-8fcc-2e855b43ac76@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 14:37:46 -0800
X-Gm-Features: AQ5f1JoKtUHhlK-Y7z-DtFO5DD67q41dfSZq435LKdak_34AMb1q5CdQGGx9fmY
Message-ID: <CABi2SkWXvc0p5u+AwFEHXVM00nX=n3ROKwEp8RaYWEZ-3-n5sw@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:15=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Feb 24, 2025 at 10:52:41PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add code to detect if the vdso is memory sealed, skip the test
> > if it is.
>
> I feel this is a little succinct of a commit message, but I guess it gets=
 to the
> heart of what you're doing here.
>
> Fundamentally I mean it makes sense, but I'm concerned that x86 has a tes=
t
> -expliictly checking- whether mremap() of VDSO is possible - are there ca=
ses
> where x86 might want to do this internal to the kernel?
>
> I guess not since this is essentially a userland self test and probably
> asserting you can do this in the way rr, etc. do.
>
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > Reviewed-by: Kees Cook <kees@kernel.org>
>
> Anyway, this aside, this looks fine, aside from nit below, so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> > ---
> >  .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/tes=
ting/selftests/x86/test_mremap_vdso.c
> > index d53959e03593..94bee6e0c813 100644
> > --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> > +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> > @@ -14,6 +14,7 @@
> >  #include <errno.h>
> >  #include <unistd.h>
> >  #include <string.h>
> > +#include <stdbool.h>
> >
> >  #include <sys/mman.h>
> >  #include <sys/auxv.h>
> > @@ -55,13 +56,55 @@ static int try_to_remap(void *vdso_addr, unsigned l=
ong size)
> >
> >  }
> >
> > +#define VDSO_NAME "[vdso]"
> > +#define VMFLAGS "VmFlags:"
> > +#define MSEAL_FLAGS "sl"
> > +#define MAX_LINE_LEN 512
> > +
> > +bool vdso_sealed(FILE *maps)
>
> Should be static?
>
sure.

> > +{
> > +     char line[MAX_LINE_LEN];
> > +     bool has_vdso =3D false;
> > +
> > +     while (fgets(line, sizeof(line), maps)) {
> > +             if (strstr(line, VDSO_NAME))
> > +                     has_vdso =3D true;
> > +
> > +             if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS)))=
 {
> > +                     if (strstr(line, MSEAL_FLAGS))
> > +                             return true;
> > +
> > +                     return false;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  int main(int argc, char **argv, char **envp)
> >  {
> >       pid_t child;
> > +     FILE *maps;
> >
> >       ksft_print_header();
> >       ksft_set_plan(1);
> >
> > +     maps =3D fopen("/proc/self/smaps", "r");
> > +     if (!maps) {
> > +             ksft_test_result_skip(
> > +                     "Could not open /proc/self/smaps, errno=3D%d\n",
> > +                      errno);
> > +
> > +             return 0;
> > +     }
> > +
> > +     if (vdso_sealed(maps)) {
> > +             ksft_test_result_skip("vdso is sealed\n");
> > +             return 0;
> > +     }
> > +
> > +     fclose(maps);
> > +
> >       child =3D fork();
> >       if (child =3D=3D -1)
> >               ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
> > --
> > 2.48.1.658.g4767266eb4-goog
> >

