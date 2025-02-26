Return-Path: <linux-kernel+bounces-532696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E07A45115
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BBE3AE9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC5B2F5B;
	Wed, 26 Feb 2025 00:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WqK1sGl9"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32669168B1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528069; cv=none; b=tlPxC87ZYVVlFZ+WXzoBuoGkVlYiQz4t03li3qDOyOL/MQ68yGFg1W74au1GXyOu1Xv+WTB/yaMPbmr36sveKsCSD/da+Qgg1IJ3gHXBou8fs4oUekUvN1v2t0IWyHHTOvIPmuDtsrNzrMVmz4Ien9WIMWfgJtOsLxr9tOeuNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528069; c=relaxed/simple;
	bh=RTanE6XR/JH9Zoq0uVHYD+TayIsyzXrlsJ6Fo1TDNp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkTfp6eBAZ7emy2NIZB9DU54YGoauWh2FBFQj+qj+ni2WVb425SQ6easwGSBg3GpgXGKPnxJJ6Vr1ut0RwzGUWRtyf2hroRreltAh65AswlITWLpyZK/BPMLbtONpWAs+XMEhSH4HUP/k3vujFsC6fpg5k9Ejn+eA0hmYD4vvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WqK1sGl9; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f20f9eef03so94622b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740528067; x=1741132867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTanE6XR/JH9Zoq0uVHYD+TayIsyzXrlsJ6Fo1TDNp8=;
        b=WqK1sGl93/qP+yYF7Cz4DUxr6998pqkq52h+W428HJRZY5Dl2l2Mjo+7aWr0j8Iq9m
         dt4gEYsurUqJDBcRGoxFo2fZ32p5xhlL1yV1ohyoAF1uJp5UIaHsi/TXO2EtaVulo/nz
         2zyi1cIPZdoRtjlDrRQD7Hy6Ohd4ILmAWXKOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740528067; x=1741132867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTanE6XR/JH9Zoq0uVHYD+TayIsyzXrlsJ6Fo1TDNp8=;
        b=r2iwCqWdhmG3yNEpJP7gEuniiT21RlYpwlRhH2CfuXRRCYmIX4m1rt46SVmouZVqk4
         P7o4I6oib4uuLBuGDJ9MKKW5dvKErOvw6n4IHuJpH6Y9m2i4XOYjzhTLVVNeg/fryiDQ
         KbRKAkVkWrhY/ISflalcEDCv9WUW1m3Q+LMOkFGBVOe6ib7fAzZb8v6Stf41ggP39Vu0
         EO5jcGirSrMMB0BUMQW0eNwDjSoLTRCcXck0xrvXcluXEi2Vw/ixz5yTAJPOpcZC2ppq
         7CeFp0ehB/AeOb9p1orN3f1lcC37PdnbycUpkY7USBUdQjcuGJK59Tyv1kAzJfumzOKU
         Cvug==
X-Forwarded-Encrypted: i=1; AJvYcCUDuim3UG/o3OkJIHc9RKlTAlUKgQ3bKG+HqH6yV0KSAvVZbMmb0+4TkeTL1LItJ/i4NKOb9Y8w7Vm15JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/OdqhOnFgrRwlMNTafZ+ogxlttQt1q/pU822HJQWyp7BRJcn
	+iADcAINA/TUDPZvfGbQf8bupqSmZ4a6hJtPkvS2vAFPhe/t3cRDIVztVC8AONzTZDxqHFZUOh9
	HyRQ6voI5gCMf62fD18L9XAIZJwG4ueU+PzVs
X-Gm-Gg: ASbGncs1XE6pNRtlfl6k4j+Zdqe3f8Ymboyh6XuTv5J34RpYg7bmK1xo2+zYG3BG9VZ
	2tdwmd03DajLrvaWwJrKXzu4LYSkyheY8MJzt4Uv+Gig6xzPLsGKjfRMO6q6r6T2D01lGSkditR
	GdSLcjfjNrKcjozNM9av0Z4xsb2tzYQgZxESs=
X-Google-Smtp-Source: AGHT+IELe7Q/6O2YWMjS8MjKjcw3APoXgNJtjGq0cBBtTsKkJH0j3uRuC98gBF3d5jfK8A9Ni6bYgLWT/E0p/bexzIM=
X-Received: by 2002:a05:6808:2109:b0:3f4:159d:a27e with SMTP id
 5614622812f47-3f4247df7a0mr5817242b6e.8.1740528067182; Tue, 25 Feb 2025
 16:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-6-jeffxu@google.com>
 <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local> <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com>
 <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local> <DC169C8C-BF10-4125-AA91-29E48BB1AD6A@kernel.org>
 <de5577b5-5d9d-4173-99f7-8c156c53f175@lucifer.local> <202502251035.239B85A93@keescook>
In-Reply-To: <202502251035.239B85A93@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 16:00:55 -0800
X-Gm-Features: AQ5f1JqrFo-3TKx0ZH5FJxQSLMaaUHg4v6Oj3trpyca3fo9xG6lTeqBiqur_uik
Message-ID: <CABi2SkXiBv5nEu4cHBdW2GUrJUFNSEuY_OVwEp6af0hGD-U4VQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Berg, Benjamin" <benjamin.berg@intel.com>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "deller@gmx.de" <deller@gmx.de>, 
	"gerg@kernel.org" <gerg@kernel.org>, "anna-maria@linutronix.de" <anna-maria@linutronix.de>, 
	"davem@davemloft.net" <davem@davemloft.net>, "avagin@gmail.com" <avagin@gmail.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, "enh@google.com" <enh@google.com>, 
	"thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>, "hch@lst.de" <hch@lst.de>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, 
	"jannh@google.com" <jannh@google.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"sroettger@google.com" <sroettger@google.com>, "ardb@google.com" <ardb@google.com>, 
	"jorgelo@chromium.org" <jorgelo@chromium.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "oleg@redhat.com" <oleg@redhat.com>, 
	"willy@infradead.org" <willy@infradead.org>, "peterx@redhat.com" <peterx@redhat.com>, 
	"mike.rapoport@gmail.com" <mike.rapoport@gmail.com>, "mingo@kernel.org" <mingo@kernel.org>, 
	"rientjes@google.com" <rientjes@google.com>, "groeck@chromium.org" <groeck@chromium.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, "ardb@kernel.org" <ardb@kernel.org>, 
	"42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"aleksandr.mikhalitsyn@canonical.com" <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:38=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Feb 25, 2025 at 03:31:06PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Feb 25, 2025 at 07:06:13AM -0800, Kees Cook wrote:
> > >
> > >
> > > On February 25, 2025 2:37:11 AM PST, Lorenzo Stoakes <lorenzo.stoakes=
@oracle.com> wrote:
> > > >On Tue, Feb 25, 2025 at 08:45:21AM +0000, Berg, Benjamin wrote:
> > > >> Hi,
> > > >>
> > > >> On Tue, 2025-02-25 at 06:22 +0000, Lorenzo Stoakes wrote:
> > > >> > On Mon, Feb 24, 2025 at 10:52:44PM +0000, jeffxu@chromium.org wr=
ote:
> > > >> > > From: Jeff Xu <jeffxu@chromium.org>
> > > >> > >
> > > >> > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, cover=
ing
> > > >> > > the vdso.
> > > >> > >
> > > >> > > Testing passes on UML.
> > > >> >
> > > >> > Maybe expand on this by stating that it has been confirmed by Be=
njamin (I
> > > >> > _believe_) that UML has no need for problematic relocation so th=
is is known to
> > > >> > be good.
> > > >>
> > > >> I may well be misreading this message, but this sounds to me that =
this
> > > >> is a misinterpretation. So, just to clarify in case that is needed=
.
> > > >>
> > > >> CONFIG_MSEAL_SYSTEM_MAPPINGS does work fine for the UML kernel.
> > > >> However, the UML kernel is a normal userspace application itself a=
nd
> > > >> for this application to run, the host kernel must have the feature
> > > >> disabled.
> > > >>
> > > >> So, UML supports the feature. But it still *cannot* run on a host
> > > >> machine that has the feature enabled.
> > > >
> > > >Sigh ok. Apologies if I misunderstood.
> > > >
> > > >Is there any point having this for the 'guest' system? I mean securi=
ty wise are
> > > >we concerned about sealing of system mappings?
> > >
> > > UML guests are used for testing. For example, it's the default target=
 for KUnit's scripts. Having sealing working in the guest seems generally u=
seful to me.
> > >
> >
> > 'Having sealing working' you mean system sealing? Because mseal works f=
ine
> > (presumably in UML, not tried myself!)
>
> Sorry, yes, I mean "system mapping msealing".
>
> >
> > System msealing lacks any test in this series (I did ask for them...), =
certainly
> > no kunit tests, so this seems a bit theoretical? Unless you're talking =
about the
> > theoretical interaction of kunit tests and VDSO sealing?
>
> Right, I meant theoretical interaction, but it would be useful for
> future KUnit tests of system mapping msealing too.
>
> > I mean can't we just introduce this at the time if we believe this'd be=
 useful?
>
> Perhaps adding it as part of adding some KUnit tests that exercise the
> system mapping msealing would be the most sensible.
>
> > Generally I'm not a fan of adding features mid-way through a series, th=
e
> > revisions are meant to be refinements of the original, not an evolving =
thing.
> >
> > So in general I'd prefer this to be added if + when we need it for some=
thing.
>
> Yup, makes sense. And it may be that KUnit tests need to exercise more
> than what UML can support, so even the KUnit idea may be invalid.
>
> Jeff, let's leave off UML for this initial "minimum viable feature"
> series, unless there is a strong reason to keep it.
>
Sure.
It will be removed unless someone raises a strong reason to keep it.
UML can be added when future KUnit tests need it.

Thanks
-Jeff


> --
> Kees Cook

