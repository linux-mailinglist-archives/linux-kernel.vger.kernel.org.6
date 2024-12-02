Return-Path: <linux-kernel+bounces-428067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBBB9E0CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5675B351E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F931DA11A;
	Mon,  2 Dec 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VaS+Cqzw"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE51C75F9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160167; cv=none; b=rd18LfHxXTNGkc1d0Y2bj+HFxtiAwUPQVCMVhsE3HHiU94as28vpPK+V4C1urG2UJeUQBUy+Sz4CJI4SBH5WzoowsUo7kdG2HEORA5Qv6Oa3RsaNq6S6cqVp/aAmw9nY6i3BqQCKT9kb6sSej2DJnk6dUxqP97bcbHFq5cxXiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160167; c=relaxed/simple;
	bh=/xRjQHbWlzBmo/lXV8xr86bbH9bz96ffjuJr1wG07ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atzPRm05POqDwwpiy7SdtJ4viXmaUObo0aiSWmapa3VC1BCtN9lWDjWrB3wscSGm2b1OOY+9U6F+9P1J79Psrz7KuPkXXKZIxCaMcaBiNxut1HaioKcp/cmr5FWdNfouMnVdfnCOFEOXYIQVUcIBGfqqzeSyd6JHB0jQ1C3aVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VaS+Cqzw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71d508ecca6so743716a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733160165; x=1733764965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EuSF+5mXGQ+p/ElofT+6RULxRWulOZ82YnMW//ltyo=;
        b=VaS+CqzwVG3VA8Mab47Flj/4sxDBH7YJLoQKGO+YpBPYoLEXWIirP7GowYgyDfueUA
         E26Nn0p81btn2Eh8Rc9275wYn/wv4KpmJr9jDvEBRIZ2LAcVfWoEIfjI0+A3dfKrgIFY
         rFcvGV89JICRzXTRIoUV0hHkUr7M68Olr97k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160165; x=1733764965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EuSF+5mXGQ+p/ElofT+6RULxRWulOZ82YnMW//ltyo=;
        b=qxpHE8pr6lyX/NSBoESCZKakHnOPsy6RYDYTrxt+nV7W5yvNzMHfX7K/zCiFR+CASl
         LZU1uItJb547hgjpV65+3yXbVmWD85UGpl8lkN+psmmURcWCq58T/GNl1G46t/onSI0A
         JCVnXqyBQl7ZT6g+1E4+FDWFrPKZJPBHxXMSh36JNfp+3C5E3C3nu0rs+HOWyyzlu+Fa
         RZAucbt2/s18m2UAuFvwSB6BSDpyTp6qxCCi50gBL/6t+siCZ8SUocMyNb3wGhPMT4vs
         Y/BBwoqikd7FxilMsgMSBV22vzb+5BRUpSN9h5izK5kTGCl++BNMlFJzFnK2bHpWUIbf
         6jlA==
X-Forwarded-Encrypted: i=1; AJvYcCX137Zp1+ka1Dq6tQej1Vc0DdFFLIZcmUOigErURoix2Epq9T6qttJvq14qHOXA2MCAEIZHR2DWrdgpODs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6Qfaq9rFOBzEtksbG7bJjCfjpmpQTTwRthrMWDM1VRL6K12k
	3KzoH/++UTlRzD7yjsPoyIwV0hGgXTAi23cKwi4HeM9oc70UI0iU3Sws1Bm9aUCWHW0l5uHQH5w
	L4ADO0tr54NCxOyhm3IAYAWkFYRgk9AbiSpOV
X-Gm-Gg: ASbGncscgrLhRVh/xjgFmyC0aAIgKRkevUn2N7GpkMFYNgO5XLFGSK2/1nVy5H2CH2U
	+BgwSBR64i9DOyP6hwYtw7JhxPAYK7RfznjimP9w5xzu4ZkY4MSkXAURf3fui
X-Google-Smtp-Source: AGHT+IG3sLYTMxv9zJvhrV40tQEdad/MSdMn1EYDNRgUNjyGpXvRxgNUgrByjfFZ0L91mLSgiaejCm8Ap+1hflJhmrU=
X-Received: by 2002:a05:6830:926:b0:710:f7b0:1d9f with SMTP id
 46e09a7af769-71d65d2ebd7mr4962644a34.7.1733160164868; Mon, 02 Dec 2024
 09:22:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <Z0Tgp4WBPvJiojqG@casper.infradead.org>
In-Reply-To: <Z0Tgp4WBPvJiojqG@casper.infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 2 Dec 2024 09:22:33 -0800
Message-ID: <CABi2SkWkD90ghRHO-1eV9oA9C2sy6Sdzj+3Z-jLzrm6dVGDXvQ@mail.gmail.com>
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
	groeck@chromium.org, mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 12:40=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > +/*
> > + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> > + */
> > +enum seal_system_mappings_type {
> > +     SEAL_SYSTEM_MAPPINGS_DISABLED,
> > +     SEAL_SYSTEM_MAPPINGS_ENABLED
> > +};
> > +
> > +static enum seal_system_mappings_type seal_system_mappings_v __ro_afte=
r_init =3D
> > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_EN=
ABLED :
> > +     SEAL_SYSTEM_MAPPINGS_DISABLED;
> > +
> > +static const struct constant_table value_table_sys_mapping[] __initcon=
st =3D {
> > +     { "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> > +     { "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> > +     { }
> > +};
> > +
> > +static int __init early_seal_system_mappings_override(char *buf)
> > +{
> > +     if (!buf)
> > +             return -EINVAL;
> > +
> > +     seal_system_mappings_v =3D lookup_constant(value_table_sys_mappin=
g,
> > +                     buf, seal_system_mappings_v);
> > +     return 0;
> > +}
> > +
> > +early_param("exec.seal_system_mappings", early_seal_system_mappings_ov=
erride);
>
> Are you paid by the line?
> This all seems ridiculously overcomplicated.
> Look at (first example I found) kgdbwait:
>
The example you provided doesn't seem to support the kernel cmd-line ?

> static int __init opt_kgdb_wait(char *str)
> {
>         kgdb_break_asap =3D 1;
>
>         kdb_init(KDB_INIT_EARLY);
>         if (kgdb_io_module_registered &&
>             IS_ENABLED(CONFIG_ARCH_HAS_EARLY_DEBUG))
>                 kgdb_initial_breakpoint();
>
>         return 0;
> }
> early_param("kgdbwait", opt_kgdb_wait);
>
There is an existing pattern of supporting kernel cmd line + KCONFIG
which I followed [1],
IMO, this fits this user-case really well, if you have a better
example, I'm happy to look.

[1] https://lore.kernel.org/lkml/20240802080225.89408-1-adrian.ratiu@collab=
ora.com/

> I don't understand why you've created a new 'exec' namespace, and why
> this feature fits in 'exec'.  That seems like an implementation detail.
> I'd lose the "exec." prefix.

I would prefer some prefix to group these types of features.
vdso/vvar are sealed during the execve() call, so I choose "exec".
The next work I'm planning is sealing the NX stack, it would start
with the same prefix.

 If exec is not an intuitive prefix, I'm also happy with "process." prefix.

Thanks for reviewing

-Jeff

