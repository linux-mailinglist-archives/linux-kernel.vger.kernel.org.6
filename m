Return-Path: <linux-kernel+bounces-530140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956F5A42F93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241DF177751
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBDB1EA7C7;
	Mon, 24 Feb 2025 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aRXp1Kyk"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987831E0DD8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434109; cv=none; b=eZ46IWj1SmlKk8/dtIBVCKtW9ZGz+tmVpjPRjPS8W9mRgSLnzydfgXN2I/Zz83OZcHUoG3xbeOvdMmQt47B/tvDg9+liTCF3neK4EJI9Jle/kAM1p0mr94HD0ifo1Q8A/zfce6IkuPAyEGP40rDgJhOxoEvBoaIkIud1O7XeA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434109; c=relaxed/simple;
	bh=Of10dtPjq6kWwFSX40vy9fJ7xn30JPo1sH0xcAGR6B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NKome6oXjksMe4eQJ6EjjNTxyYwpD7GwiDEdfha3PBLZDzOkCKhFqPC6y/LMjy3w/vacTbeYfKJmcw7rx5yyhBJmHj9z+q8zbEO/ECkRMzAlU1YpV5uRSiJ3WT/W15thn6GwGRkpToF4CYwl70PehfqhAi5NuJasvucsR27ocz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aRXp1Kyk; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72725e5cbccso455708a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740434106; x=1741038906; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPTTDChOSqTCFQv4mLssfhA9N88UjfFx6y+XJgJnTAA=;
        b=aRXp1KyknTPyek918yF/w0JNb75j71x4YHHsjhpbdS29zpJd1A6QT83AGTVEaCDdvk
         vHAtucYQ8MgFakUdNImQe19Z88OdLaLCnQPUocRpGL7HJ2XgMv/rkOURwK4n+Fcyfk/L
         7IyBjhrBnq6KUReYVmZd2SuWU2BDNVwY+ZF9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434106; x=1741038906;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPTTDChOSqTCFQv4mLssfhA9N88UjfFx6y+XJgJnTAA=;
        b=ErOmy/6BIUx5M5WlIyM4xUcuX7mFoceXd3Am/VldDMYbIA0X69DQvFMOikw94QxxrL
         BIIUIGHgCdiDofDTZTUqW3KfFbdPf3RRcjytD9Sxzbku/JN+cNYxKHaAAMXbu3oy9p+t
         nn/0lJv+/gsYcG1MYjb7VuQoNLfd6fshxzyxLZXrsEKrekoYJ7Gike4xEnhBTA3vbPy6
         ru3FRbDz2KXuMZBgbHmHazZ6uiaQS57y7i8tUOjliQ2BzjPH/vxdqt0YYt4vtCouU2TK
         ouk3tuVBvoX6SznEdKNolyQOvlF+aVgGr/gfR+RFQ2OyDR+kYekO7y/LQP7DqYZjELQ5
         rOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSq7RqZY+PnEMDKIIuBlC21e/20s8My605C4yj+wwlpqnCDtaNQhCkmWxlxfIVu/8yBflSw8tS1QSgne4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZySx1o6QFLlio8LedrfS8SHDX3A8b96kBIhzEUySg0cHj1O0b
	AqczT3IFIeP51gqldjpDGBfD4WpvzdF7cXxFlRXkrmxrzXlQprVTYuWw1wLdpWpQg8kJwnxRRYU
	yX4/s6RsOHgtR4XKWGFGzOfk5ug5ZFDTz8O/x
X-Gm-Gg: ASbGnctq8p3ffyq50UBHzFsU6Gf/5En+hhRUTm7MA5Aoi8u9c3iYSpk9hAKsIfqHBLP
	BluTKfbQ8lkgV3uX+CafB3ETQIkeB32W+n+WIfM0YEXikC5FB71brY2Wmie/QBc30N/Cz+15C/O
	VADToSemGcdqUz2uRbu6zDKycwbMvBzQjU1mDc
X-Google-Smtp-Source: AGHT+IFwwLbERjxJfPs0yISPzcIvd1i2WMO0vsZI2MTAgbx4mU/byaBF43rcmsNs7HBDDxb+7CjeT5YTOOP1+HnX5Xk=
X-Received: by 2002:a05:6808:13c4:b0:3f4:1ba:9e89 with SMTP id
 5614622812f47-3f4246a145amr4457000b6e.1.1740434106640; Mon, 24 Feb 2025
 13:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-8-jeffxu@google.com>
 <rzhfepcwdwiq6khrepv7x7gpgynek4p54fhx4enqgyw7nubegc@uydhglfx67gp> <CABi2SkVLOWEZ6vkUwZyQspz8aqBZ4yhfob-SmscA5RhNv_vS-Q@mail.gmail.com>
In-Reply-To: <CABi2SkVLOWEZ6vkUwZyQspz8aqBZ4yhfob-SmscA5RhNv_vS-Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 13:54:56 -0800
X-Gm-Features: AWEUYZlWnyV6Jdfb2-SNecn18hyqiYaIseEaup8aJSHrCsv9Z2O_gnjBeFaB_Sg
Message-ID: <CABi2SkWzgcFo+PF58K2azNZ1BgmgM-7LtJ8NmOgscN6_NyEo=w@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
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

On Mon, Feb 24, 2025 at 1:06=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Mon, Feb 24, 2025 at 12:26=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * jeffxu@chromium.org <jeffxu@chromium.org> [250224 12:45]:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Update memory sealing documentation to include details about system
> > > mappings.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  Documentation/userspace-api/mseal.rst | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/us=
erspace-api/mseal.rst
> > > index 41102f74c5e2..10147281bf2d 100644
> > > --- a/Documentation/userspace-api/mseal.rst
> > > +++ b/Documentation/userspace-api/mseal.rst
> > > @@ -130,6 +130,13 @@ Use cases
> > >
> > >  - Chrome browser: protect some security sensitive data structures.
> >
> > Did you mean to drop this line?
> >
> Ah, thank you for catching that.
>
Actually, this isn't a problem here.
The "-" here is part of the text, for list, so that line is not dropped).

-Jeff


> -Jeff
>
>
> > >
> > > +- System mappings:
> > > +  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_=
MAPPINGS),
> > > +  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso,=
 vvar,
> > > +  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, r=
r are
> > > +  known to relocate or unmap system mapping, therefore this config c=
an't be
> > > +  enabled universally.
> > > +
> > >  When not to use mseal
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >  Applications can apply sealing to any virtual memory region from use=
rspace,
> > > --
> > > 2.48.1.601.g30ceb7b040-goog
> > >

