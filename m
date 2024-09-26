Return-Path: <linux-kernel+bounces-340931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8C7987928
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26561F224D9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F8170A3E;
	Thu, 26 Sep 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DK/5vjrI"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80D170A29
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375853; cv=none; b=QEKAyMz69+YDte/LM8MCUio6OVCHi7anYcGbkUyHfTPPxbCx1sCy/uojkbcKRF9Gzzn2AFuleGcnvSDWmD+rtmeyTIPaakjrQGUjcDbLhck2q31wUBBxZRRs4dQP1Fev7TJb5hp+RSR2HcF7Ia11nYVhq1E/81nzbT1YaelZxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375853; c=relaxed/simple;
	bh=qge/ypv3jnq9WkpUdpRE7x8QIIC6GXWB3609FUVVm8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gy4+ztnbxbVrT5YcP4AosfQiR3AAA6JxcQs+CrEqNq/uhiiG/MKOAKwFgp+uneemhiVHjkonpt419iU1hdBVP60uQgJ6Rv+eu4RAJdbchH8NlLh0uiMLBfeVavpAy+MpT3srTDCNauhX19XSX1F7lhV6FwxYyqCe6kSmdEoUlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DK/5vjrI; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4581cec6079so44481cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727375851; x=1727980651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajD7HYLuvBx8/17wWfxPAMem46iIj42I6Vl0LQ86WrE=;
        b=DK/5vjrINJRnrkXe3JMVA2ku6szcsEliriK+KN8cQY3FpVMsbmkmycPY56xGBQItSL
         ibQ8Z4uWK2pii2zWS0HA9AvCc3tUU6f55c8CJsAUyr2P+V24XWfOk5qxTuNr8gTdVeAG
         x5iBsYiAvvRILVTxnokzS5OItpWcLnvsXYagWT4afcqtVcjguOGRzwv9xWM9TpJQtw/g
         R7GAGqOMJ0L1BhaNT8Zd6JCryyMjnjiurgWIZ3DNj5Ou4wRTBxpWcVhZct60XRUdUHUd
         snIJaR8UJpEE6aNpdTRZQytK0yRCi+AlJrLfGWVwDi/JdZMdmluvcKTnmRWBDcGpDn6P
         c6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727375851; x=1727980651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajD7HYLuvBx8/17wWfxPAMem46iIj42I6Vl0LQ86WrE=;
        b=YwC4zDHBH2vhgV3qxjKvcIzrCiaiF+UbfgDctwQWriOBK+QaiPK1yE2Gr+9AjZfBA9
         3ZP7V6JGwH993HLLP+P+8+ObMPH3Ot7Oktymn0HTduVBq0E5BpWQP11uUxK8zFia4sBX
         MT8dyjsjo1YTnjq5PBhmg8x/RnZKXeeTKMjPXck47yiSkYaUMelp286UIWjmmYOQywuG
         aWnMVYOCdqhfW3n7ivg2i9IPHJirKGICWupOvm4aqtlc6iqELeur33W1kKW94xIO2K4q
         khUulrZdj5FIR5U6xK/LwbGYNHWi+pOsZ/H1tRVl2hg4GJuDf5qigbM4OFZKTbJ6yx64
         PfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6HzWYL4IpH9rpk9u3//dwb5pAZ6JzhJd/ks2YxKFUPcZe7iBUrZMpPlE/m4L5FJpvAL2qoGZlr/115ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2YQU/EqUXCMB753TX9J54ZRLVFQpVKhLnu2/Rd8biQO+cSrYB
	E0hk4nB3KWM9kM2p9FeGI/tfy5UhT2/DZ28a6/1G0TW2x9FYxV3VfKTJNtJMM/Q/3/nhnJdrQzB
	Nv7WjKZyPvNoyv3/47eVNFenZdpCNEIL0a4lr
X-Google-Smtp-Source: AGHT+IE5luy5UBQ185BJWoPqDDM1TnLd4PCqV2DLnc+LIC9QgkGZbzUPxUEZLm0+v/dLWn/IHMzUNmnXBY+ab/kjVpA=
X-Received: by 2002:ac8:4904:0:b0:456:7d9f:2af8 with SMTP id
 d75a77b69052e-45ca03bd89bmr245591cf.7.1727375850392; Thu, 26 Sep 2024
 11:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com> <20240925233854.90072-15-mmaurer@google.com>
 <b31c74c1-0c19-4bc4-b1af-db817977748d@csgroup.eu>
In-Reply-To: <b31c74c1-0c19-4bc4-b1af-db817977748d@csgroup.eu>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 26 Sep 2024 11:36:51 -0700
Message-ID: <CABCJKudyC_EzRTtkJSSQqQhLdUk_9tYBtoq62tjmghFyi8omWg@mail.gmail.com>
Subject: Re: [PATCH v5 14/16] modules: Support extended MODVERSIONS info
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Matthew Maurer <mmaurer@google.com>, masahiroy@kernel.org, ndesaulniers@google.com, 
	ojeda@kernel.org, gary@garyguo.net, mcgrof@kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	linux-modules@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 5:22=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 26/09/2024 =C3=A0 01:38, Matthew Maurer a =C3=A9crit :
> > Adds a new format for MODVERSIONS which stores each field in a separate
> > ELF section. This initially adds support for variable length names, but
> > could later be used to add additional fields to MODVERSIONS in a
> > backwards compatible way if needed. Any new fields will be ignored by
> > old user tooling, unlike the current format where user tooling cannot
> > tolerate adjustments to the format (for example making the name field
> > longer).
> >
> > Since PPC munges its version records to strip leading dots, we reproduc=
e
> > the munging for the new format. Other architectures do not appear to
> > have architecture-specific usage of this information.
> >
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > ---
> >   arch/powerpc/kernel/module_64.c | 23 ++++++++-
> >   kernel/module/internal.h        | 11 ++++
> >   kernel/module/main.c            | 92 ++++++++++++++++++++++++++++++--=
-
> >   kernel/module/version.c         | 45 ++++++++++++++++
> >   4 files changed, 161 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/modu=
le_64.c
> > index e9bab599d0c2..4e7b156dd8b2 100644
> > --- a/arch/powerpc/kernel/module_64.c
> > +++ b/arch/powerpc/kernel/module_64.c
> > @@ -355,6 +355,23 @@ static void dedotify_versions(struct modversion_in=
fo *vers,
> >               }
> >   }
> >
> > +static void dedotify_ext_version_names(char *str_seq, unsigned long si=
ze)
> > +{
> > +     unsigned long out =3D 0;
> > +     unsigned long in;
> > +     char last =3D '\0';
> > +
> > +     for (in =3D 0; in < size; in++) {
> > +             /* Skip one leading dot */
> > +             if (last =3D=3D '\0' && str_seq[in] =3D=3D '.')
> > +                     in++;
> > +             last =3D str_seq[in];
> > +             str_seq[out++] =3D last;
> > +     }
>
> Why do you need a loop here ?
>
> Can't you just do something like:
>
>         if (str_seq[0] =3D=3D '.')
>                 memmove(str_seq, str_seq + 1, size);

I initially had the same thought, but it's because this is is a
sequence of multiple null-terminated strings, and we need to dedotify
all of them, not just the first one. Here's an example:

https://godbolt.org/z/avMGnd48M

> > +     /* Zero the trailing portion of the names table for robustness */
> > +     memset(&str_seq[out], 0, size - out);
>
> This seems unneeded.

Strictly speaking it shouldn't be needed, but I think it's still good
hygiene to not leave another null-terminated fragment at the end.

Sami

