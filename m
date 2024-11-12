Return-Path: <linux-kernel+bounces-406845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED95D9C6503
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D36E1F24B85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A43A21B449;
	Tue, 12 Nov 2024 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBoOfsQI"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABDC1CD1E1;
	Tue, 12 Nov 2024 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453526; cv=none; b=Ke6djeCz3gTeOB2d8kL4+wHNc5g7VpI32acQW00tasGUn1FzEVzrmWf22SEEMkTCzPXMYYqbbX1yJpCe6uIQV2e4D6I2jTm6UEwjyTC+cPw/A+4Tw7gTF2XnafC4DP9eZS73W/POtWIfCGpkAV7bIFWjW0fkzY5i0xc129CPizA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453526; c=relaxed/simple;
	bh=j5tp8BIiEuvNmH9bABxgSGDA3hZWAh0HdrW6c8kKxmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0SXcBtud0ZViPr+YxX597gbGth/UStWw2Yq1/QjdsYhF4062bKOkvRtE420j2/FgGYi6FfhC0rJZ+iOoJbHRlgGFD06q/qDaG/LfiMiVymF4e38DresmuBZGHZ+2OeEHhj78ZRlWEE1ZHVeVsDEJnRLYj6IcKZqDfJRBoQo//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBoOfsQI; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fc9005dccso2260180241.3;
        Tue, 12 Nov 2024 15:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731453524; x=1732058324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi+pYaGR6y7Ai0UyIsT80xxaJyBdGHeNxbYRSDfpr2w=;
        b=QBoOfsQIMmXcR/AdjSa2AEvlj0nd7JAHdZreMEzvP4n+RNZAI00P1ZC9yvrDWOLihD
         71bnyS1G/X/R2xiuWhA9SfbMJQq2ZjMsR47ROVFxEdCw++oYjjCitrvWfOIGQgmO19Yz
         fBPmwVvbWVmgpnOgmwFCRXWeZk+6vO4Sf0nVRnMFyK5Rkv4yReMS09F/hkxAjPHrVrZZ
         4oNuBYfs81FnWOvBshwIqn16Q/SYhzfsSO2qWGM5c0pLUIJdwSQgORPH6KsyIjX1rFb0
         YvXbED9CLwWuRPBJUv2EFfPIVSsH0Z3vUQFpTBKqCtbg3Wjstwj7xHIBacojNvPGXXVH
         03FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453524; x=1732058324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi+pYaGR6y7Ai0UyIsT80xxaJyBdGHeNxbYRSDfpr2w=;
        b=hS/T9SVT4FvusjyVlDApo/jJOl432507qUHjT5HTtXY74cYpnIzPraH3dwcSNs7bxm
         cVJqL2JdgtN+R6yE49pRsF2Jt2yPSEjPhoQl53La0M9ntvV/wJm/H1hxHftFiT53GRq9
         CJgxok24r7TE3+rs4EMgiFeEZ1mLEQggl7Xzh9a0Ue9xTgBm3hDpcasahc6NWHph94v5
         ig6FpQ2hxKHLgZMLqe2k5P8IqfgUwTUhB+91qk2m5FNZt+8sRPWYnBKR3uybOt9IPGyG
         7kWqIibt6bAe2Cy/Zk3k+Q4lfzcNSksggyZ3s2MGEnzkRuVgevt8QDuqDhRXhV2ls6Xb
         qU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2b5vUXtSFZ0q1Xo1EJv2tk1JNKi4Lfuar8P9XngroRqYm7j1YCfow7SCnfOaG6v9XwZRKKoe8PCZQAFg=@vger.kernel.org, AJvYcCUVoofW7ARt6a9qQEdybpXeQOvWk2yWqV/RKeUfKc7XqsJ5GiR7uADK+Y8zukaKb7Z9HORylOs1b21CuvPOQ3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfxpCFPAJdczmrLdFUn/5WSS5/n3fyjc82wm6eZ+hH/301WqY
	1BuJw5CDa8D4avuBlX/13WSqvbfgU6DTQEvy+1zlnEAdn+3Lf/1UXRSRMAEITG0BZxjY5kgIf8u
	eYD7ryt81gRqKBad1Q48IW05xv/U=
X-Google-Smtp-Source: AGHT+IE0KMxl2L7FAgAF1uK83iGl2fLu73Z+liQ++G7K8FyZY20uV35uKgP4t4LCX9V/512WmwQrkmrPAyRu/F2cdHg=
X-Received: by 2002:a05:6102:f14:b0:4a4:97d1:aea0 with SMTP id
 ada2fe7eead31-4ad468a3023mr1095260137.11.1731453523763; Tue, 12 Nov 2024
 15:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111112615.179133-1-alistair@alistair23.me>
 <x6OyXuGQi1xeknAX_pjcl17BOpxRM6OGtLWGhGOH4LUgghJaP29a4ebzCT21QdfxBb88PwZCc2U7zizrTTSzVg==@protonmail.internalid>
 <20241111112615.179133-2-alistair@alistair23.me> <878qtqt1n4.fsf@kernel.org>
 <SnLsh8RJ31-mqOVagPGJkEkUNFbHMWOubRf9pTxflqODI9Hf_iCJm2u0hUV5lY0mwT6WqGQ_4uYd12M2kmPYqw==@protonmail.internalid>
 <CAKmqyKNjjELzVbWgBHaHr8N1XnOJHk-U6RfLyb-FbTJ7h9jPoA@mail.gmail.com> <87iksssrhr.fsf@kernel.org>
In-Reply-To: <87iksssrhr.fsf@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 Nov 2024 09:18:17 +1000
Message-ID: <CAKmqyKPs_nZh4dq6VWty=1WXuPHLCzBs78CBqi7szs+tr37S8g@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] rust: bindings: Support some inline static functions
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alistair Francis <alistair@alistair23.me>, linux-kernel@vger.kernel.org, 
	boqun.feng@gmail.com, me@kloenk.dev, benno.lossin@proton.me, 
	tmgross@umich.edu, aliceryhl@google.com, gary@garyguo.net, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, alex.gaynor@gmail.com, 
	alistair.francis@wdc.com, bjorn3_gh@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 7:58=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alistair Francis" <alistair23@gmail.com> writes:
>
> > On Mon, Nov 11, 2024 at 10:07=E2=80=AFPM Andreas Hindborg <a.hindborg@k=
ernel.org> wrote:
> >>
> >> "Alistair Francis" <alistair@alistair23.me> writes:
> >>
> >> <cut>
> >>
> >> > diff --git a/rust/exports.c b/rust/exports.c
> >> > index 587f0e776aba..288958d2ebea 100644
> >> > --- a/rust/exports.c
> >> > +++ b/rust/exports.c
> >> > @@ -18,6 +18,7 @@
> >> >  #include "exports_core_generated.h"
> >> >  #include "exports_helpers_generated.h"
> >> >  #include "exports_bindings_generated.h"
> >> > +#include "exports_bindings_static_generated.h"
> >>
> >> Generating `exports_bindings_static_generated.h` depends on `exports.o=
`,
> >> which depends on `exports.c`. Does this not create chicken-egg kind of
> >> problem?
> >
> > It is a bit confusing as there are a few levels of autogeneration, but
> > Make happily handles it.
> >
> > `exports.c` depends on `exports_bindings_static_generated.h`
> >
> > But `exports_bindings_static_generated.h` depends on `extern.o`
> > (extern not exports).
> >
> > `extern.o` then depends on `extern.c`
> >
> > `extern.c` then depends on `bindings_generated_static.rs`, which is
> > generated by bindgen.
> >
> > So there isn't a chick-egg problem and this happily builds from a clean=
 tree.
>
> Right, I think I mixed up exports/extern.
>
> Anyway, it does not build for me. I applied it on top of `rust-next` and
> I get:
>
> ..
> =E2=94=82  CC      rust/extern.o                                         =
                                                                           =
                                                                           =
                                                                           =
                                    =E2=94=82
> =E2=94=82/home/aeh/src/linux-rust/helpers/rust/extern.c:1:10: fatal error=
: '/home/aeh/src/linux-rust/helpers/bindings/bindings_helper.h' file not fo=
und                                                                        =
                                                                           =
                                    =E2=94=82
> =E2=94=82    1 | #include "/home/aeh/src/linux-rust/helpers/bindings/bind=
ings_helper.h"                                                             =
                                                                           =
                                                                           =
                                    =E2=94=82
> =E2=94=82      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~                                                             =
                                                                           =
                                                                           =
                                    =E2=94=82
> =E2=94=821 error generated.                                              =
                                                                           =
                                                                           =
                                                                           =
                                    =E2=94=82

Thanks for testing this

The #include in `extern.c` is auto-generated by bindgen based on your
current directory. So for an out of tree build I guess it's just
wrong. I'll fixup the sed operation to ensure we correct the path to
be a relative path instead.

Alistair

>
>
> I am doing out of tree build - maybe that is the culprit?
>
>
> Best regards,
> Andreas Hindborg
>
>

