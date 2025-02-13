Return-Path: <linux-kernel+bounces-513114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC9A341BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A321890B42
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67713281369;
	Thu, 13 Feb 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AmZYHUHw"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58D28135F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456078; cv=none; b=l/tRKGyGMbTLQaRFluoSiQvlAaoHAmHe7h54d8J7Zry5XmsLw8mMy3oAqP4fdUO7A0N1PhCui4VoPRCaosZo+jP7MVU6Rec1toitgrvD4fBf7wzATWw/vt2nxPh5GFmhesbckgNS7s9K+BfOKdNLjwQJtdZYY0ptOojqqKlZ7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456078; c=relaxed/simple;
	bh=GNESsdobWvElHx5uMVlUccaEq7W4UGcITpDJhinMpmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBUGmGB6Me0UfmBnM8QuV4HvE6CsLr4+quZQtp1f8t92kO2QEa29+3qkV+0valR6UMqBx2CGdtFCD8+QShliDXQ24rd4mDPG97KD+r+QrQ6FOe7jUS9HLNnoym1/sLM0o/ZtM1UmC8Ge8eA2aC29F284eSOS3AZnELzE0fowlVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AmZYHUHw; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3d80379d5so27165b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739456076; x=1740060876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwgMpUGpPt83uP2kmDr1SGqVNltXn8RoI5FSgDbOZyI=;
        b=AmZYHUHwi7GRWeguAjU8+vIA8FGLAMjSE4uwnpa7UuXrtw7932K8fhSUpK98LJnhzn
         UVaW0Kiz3kGhiMMI/T4Xo6RXgLCGR5ICqKN64bfXXbuZMFn0eOzX3WfmYISuQzJrrgVk
         ixRYD3XsfHVUjzF3Cz/vA1QLyTVdZ0O1ujnE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456076; x=1740060876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwgMpUGpPt83uP2kmDr1SGqVNltXn8RoI5FSgDbOZyI=;
        b=vP2AZ3igEpe7/S3rQ5vK+3EIPeThTL0KGc9b8cb5uXkyEST4RCVxn5vqt7+bGDDrAy
         V+ugfhZ2NG0/jlHGtouUFDtmzp1nGdGJH+KJszm0IDfMB3PD90VCYPk6xr86rBTxeWGS
         dYzFBW9X3TR+dBvAc6A1Niqh1rF2BCYCAhTZk25agLQ+dOITebscIevrero7jj4d/Poo
         cdh0M60RNLaxTvvPUfYb1Z+MuF/qHBMeGpT0/M95x2qitJGfVAZuZJeBUeswYvPi1Bww
         zJknTAAyZMSqk38BngxAkrQb21sL8/YRWcdFK+nxnCA63dEQ36LO/V1N/MiW7+kMwB6O
         nJgg==
X-Forwarded-Encrypted: i=1; AJvYcCUvzUyxhm4K69koGiWqs4hxieiZWf4mH2IpQ9WsnHXabImmiKcYZsmBsS5zF57hJod6jncFrJUK6fAs1rA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0NniHgzjmZLdCsWxy6ED8OiZydePNQ15m1UHQJ80VikPwl1v8
	AG8VxWbE4OS+rNCvdq47c0j/0KWM7rx1AgQEbbWW1S1ztPwtPl8Tu5mNvr9K2JrQli1sHY2GLEy
	PxNKffN1tXQrlsuNH2pPcshWB76aKnbwYlcTw
X-Gm-Gg: ASbGncvPmLyweOKrvPYuVzi3L/htRdu7qO28jiOPcYFDJZqc+HhxDuj2zdX+brYTM2t
	J2+uE5nBY5CdXGjjQ9onQFUsegn63saT5x2iguBaV+2VjWVGIRsA12b7Yaoqm2/Pkllzpcax6
X-Google-Smtp-Source: AGHT+IEtNnqaFNM3IFYkaevRL1voz6bW7MV+eHfloPEq3p2jBFOfznRwaq9+4MhkBWZc8DES3xDKYRxboQlSxD5GRww=
X-Received: by 2002:a05:6808:189f:b0:3eb:6849:e89 with SMTP id
 5614622812f47-3f3cd5d31a2mr1761716b6e.3.1739456076093; Thu, 13 Feb 2025
 06:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-3-jeffxu@google.com>
 <20250212135000-861e6353-6e0a-43c3-9b28-649ae4dfc607@linutronix.de>
In-Reply-To: <20250212135000-861e6353-6e0a-43c3-9b28-649ae4dfc607@linutronix.de>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Feb 2025 06:14:00 -0800
X-Gm-Features: AWEUYZn6agI683FCVewtEvJCU-TMhKcDzUvXDlTokG6FIGxk-prLy1E5md-55vU
Message-ID: <CABi2SkUCviiTbd1roeBiqSk98S87R1WwSP9rUYh4t3JfSD+2ZA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/7] selftests: x86: test_mremap_vdso: skip if vdso
 is msealed
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
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

On Wed, Feb 12, 2025 at 5:04=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Wed, Feb 12, 2025 at 03:21:50AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add code to detect if the vdso is memory sealed, skip the test
> > if it is.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/tes=
ting/selftests/x86/test_mremap_vdso.c
> > index d53959e03593..c68077c56b22 100644
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
> > @@ -55,13 +56,50 @@ static int try_to_remap(void *vdso_addr, unsigned l=
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
>
> This only tests that any mapping after the vdso is sealed.

The code above begins by searching for the "[vdso]" string, then looks
for the first line that starts with "VmFlags:", and looks for the "sl"
substring within that line. We're assuming the format of smaps won't
change from release to release.

> There is a real parser for /proc/self/smaps in
> tools/testing/selftests/mm/vm_util.[ch], see check_vmflag_io().
>
This test is in selftest/x86, which makes it hard to include the
vm_util from selftest/mm, if that's what you're asking.

If you are asking reusing the code logic from vm_util, the
check_vmflag_io() calls __get_smap_entry(addr, "VmFlags:", ...), which
begins by searching for address, then looks for the first line that
started with "VmFlags:", then check for the "io" within that line.
This is the same logic as my code, if I read the code correctly.

Thanks
-Jeff



> > +             }
> > +     }
> > +
> > +     return false;
> > +}
>
> <snip>

