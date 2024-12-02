Return-Path: <linux-kernel+bounces-428304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F99E0CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421732839AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C11DED43;
	Mon,  2 Dec 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U1hcbujf"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E81DD863
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169493; cv=none; b=EbQK/PLVo3iePCQwzuKynsyT5/yCwTySnJUqH3O2P77jUrhaCPDFJJzWDGzgJoHZw3FKCc8NUd2zXDsh3dPrSotbBUK1EeRa05T0oQfNZYXmiGA2BIT7wXtJ8h9L/n7/a+CjyrzCSGXsPHIdniUCO/RjOdUOKhcgnF0AyhbQJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169493; c=relaxed/simple;
	bh=8DSsb8efvzsA4KjFCkMN2hWsbmsEDZXGTeloMlEq/CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPyDPHTXLwnazMmIDGwuKvNM9kRZbyUpmnviucQSMr85GJxk2wLd/Cvex0T0LkJIlPqj2Rd+54fYlhkmUkmuNFFAwr3OLWYspN1zC08awK3q4VGqPurOL/y83uaQpB7ReYLcwB4WIKr2v/Mipe8irZqVhQifs7jkmHKyEOR6A9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U1hcbujf; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71d508ecca6so761448a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733169491; x=1733774291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDO6IZF0SAS4D/s22IkqfUjLK72pbPVPekVRwv7GXjk=;
        b=U1hcbujf4cTWadDXKCzLRoW4JeDCTOL4L2RiqTpGANlKAURgcoVvhDVz2+Yq483Jlu
         5+Y/TC30PyBU/z3eQiopQfLweCiShoM79Y7aeDqXJKR8cPlytzBaHVdDquupQzi6tCPX
         cl2uKLzkD3qv5uxvdRWNv/RXrXenP7sO6P1xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169491; x=1733774291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDO6IZF0SAS4D/s22IkqfUjLK72pbPVPekVRwv7GXjk=;
        b=OV91//aBMffXhOSTPbq7SsQAOwQMYgxTslVEERdy7eDb5tjUirTMTqCK3iFBf8NL1M
         Z1cVKdvL72tcd0tp9qR67Bms8enIqiiQIjQdrIe4QYwgMroVtF+I9iADlrSVL4RgyXku
         Ep2L089fyGXfIbjJhvIhUUhXCCO2Nx7InIS1Sd4fHtAmoHf06U9LQVbNYw24Cx8Z6kEQ
         wNtpf564VUwRiHZVmeIg1PKvP36LfjQDUlTnbR85M35yiNP8HZi5AMcgxcKZNGzAe4rV
         DJxhLffQKamGE4SbpDXAPHoWkDLTSWgffiDLL5L8h46H1EChFZ5/XqO126uz7eoEMCdY
         MN8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSeQJj6gp28yb76XH0m9X6MhQdHFA2H4AIF3rF02KbL5TdAq6jZsajzCnKAdkxF5VrW5RPC7XuNe1n6NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLTTznMEuZe0+4zS2OTQ4o9sMoEreTbSE1egzHud9YD4Ta3Qv
	6+4UqvyIlZfFoIcVskSrIW7wDbSSP+7vM6twkftmq9rD1hWKaqPe3EYK5v1UWz7NQmewHeH8bwW
	rD+SXaPDCs5SbNjjsXntunz4vuD2nvWiA7XgY
X-Gm-Gg: ASbGnctwbG0j9HTntB/wk9n3lvsOYy1Yu2oWTuQWBIDEfVzINrCiWb+q7MK7SD05KIp
	Pbd/4LDjxHhDygkIUMVHWZoKVXmUCkA+WjOWcYnHToerXx19R4vSj9UpIai8y
X-Google-Smtp-Source: AGHT+IGl9S0cXUdxwqv/0H2bzvcmZTd1ty7QqvW+00DZx9eAOiGMi+fu/EM5EbCePNS3yghVEdCoOFfKaX1tiqKTfuw=
X-Received: by 2002:a05:6830:6f0e:b0:71a:20da:f323 with SMTP id
 46e09a7af769-71d65cef4a9mr5426443a34.4.1733169491035; Mon, 02 Dec 2024
 11:58:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <Z0Tgp4WBPvJiojqG@casper.infradead.org> <CABi2SkWkD90ghRHO-1eV9oA9C2sy6Sdzj+3Z-jLzrm6dVGDXvQ@mail.gmail.com>
In-Reply-To: <CABi2SkWkD90ghRHO-1eV9oA9C2sy6Sdzj+3Z-jLzrm6dVGDXvQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 2 Dec 2024 11:57:58 -0800
Message-ID: <CABi2SkX3ES24y=18_kjmi+gzJbmaDsqepMT5jrogB7K5GTnUSA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 9:22=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrote:
>
> On Mon, Nov 25, 2024 at 12:40=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > > +/*
> > > + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> > > + */
> > > +enum seal_system_mappings_type {
> > > +     SEAL_SYSTEM_MAPPINGS_DISABLED,
> > > +     SEAL_SYSTEM_MAPPINGS_ENABLED
> > > +};
> > > +
> > > +static enum seal_system_mappings_type seal_system_mappings_v __ro_af=
ter_init =3D
> > > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_=
ENABLED :
> > > +     SEAL_SYSTEM_MAPPINGS_DISABLED;
> > > +
> > > +static const struct constant_table value_table_sys_mapping[] __initc=
onst =3D {
> > > +     { "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> > > +     { "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> > > +     { }
> > > +};
> > > +
> > > +static int __init early_seal_system_mappings_override(char *buf)
> > > +{
> > > +     if (!buf)
> > > +             return -EINVAL;
> > > +
> > > +     seal_system_mappings_v =3D lookup_constant(value_table_sys_mapp=
ing,
> > > +                     buf, seal_system_mappings_v);
> > > +     return 0;
> > > +}
> > > +
> > > +early_param("exec.seal_system_mappings", early_seal_system_mappings_=
override);
> >
> > Are you paid by the line?
> > This all seems ridiculously overcomplicated.
> > Look at (first example I found) kgdbwait:
> >
> The example you provided doesn't seem to support the kernel cmd-line ?
>
> > static int __init opt_kgdb_wait(char *str)
> > {
> >         kgdb_break_asap =3D 1;
> >
> >         kdb_init(KDB_INIT_EARLY);
> >         if (kgdb_io_module_registered &&
> >             IS_ENABLED(CONFIG_ARCH_HAS_EARLY_DEBUG))
> >                 kgdb_initial_breakpoint();
> >
> >         return 0;
> > }
> > early_param("kgdbwait", opt_kgdb_wait);
> >
> There is an existing pattern of supporting kernel cmd line + KCONFIG
> which I followed [1],
> IMO, this fits this user-case really well, if you have a better
> example, I'm happy to look.
>
> [1] https://lore.kernel.org/lkml/20240802080225.89408-1-adrian.ratiu@coll=
abora.com/
>
Sorry, I miss-understood the code. This code also uses the kernel cmd
line, it is just not using keyword=3Dyes/no pattern, but checking the
existence of "keyword" in the kernel cmd line.

Current pattern allows values beyond "yes"/"no", so if we ever need
extension (e.g. a new system mapping type, or pre-process control), we
have flexibility to do so.

On second thought, that might be over-thinking, I will switch to this
(simpler) pattern in the next version.

Thanks

> > I don't understand why you've created a new 'exec' namespace, and why
> > this feature fits in 'exec'.  That seems like an implementation detail.
> > I'd lose the "exec." prefix.
>
> I would prefer some prefix to group these types of features.
> vdso/vvar are sealed during the execve() call, so I choose "exec".
> The next work I'm planning is sealing the NX stack, it would start
> with the same prefix.
>
>  If exec is not an intuitive prefix, I'm also happy with "process." prefi=
x.
>
> Thanks for reviewing
>
> -Jeff

