Return-Path: <linux-kernel+bounces-404865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42669C4957
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D1F1F2558A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B51BC9FB;
	Mon, 11 Nov 2024 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMmgLN2v"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2539B156F5E;
	Mon, 11 Nov 2024 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365513; cv=none; b=TWIwXZAnyFxip3bJVNJECy+xGzw2T7D9LVev/gdrc8Q2z03HzZkTw7SFpKQGRs1nKlxRmjr/COpjIBIcQtjD78aBFb6i1NxJN2U5UAlpMiLL3g9yizuyqVgM0ZAP0ml2QopAiebltVlXjLXiSJcZzUFZlTp0JyLXK1PTaC21J04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365513; c=relaxed/simple;
	bh=sJ4Soy4X8jXcqT/MKWvjDRJdwDeELmOTBVoKIYInFdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+MVJclVv0IIx07HwcJkZntIJ+unJ9CIAYmHxlruSx+kaqo09mwxeMvVSRC1meaHykofDXQMs3OX0pQ8O1+NR3Lgrz1bWPxEzPJizhxRMIX8MJiknYF2Q7vS0IiTk9yCpsMxYYsoBXfB9MgTHVK3CP5UhwOcP4H6AYyBcPDZpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMmgLN2v; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84fdf96b31aso1838504241.2;
        Mon, 11 Nov 2024 14:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731365511; x=1731970311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQl50ASVKori1aU7G1WY6tJUmNCetIqIxTMQTgNJ8kg=;
        b=OMmgLN2vXhV+FYaWvmenKxpoeFDGwoQFBGioXwwP1ajCw+M2u9F66b3PDJ+OU49HQp
         7qIDMlidbwHZq+UMdMgIRtAVN8AmfjlfvaN4mz8BkAjjqUAdYBfvLX++lsYlFYWxlzIs
         OnCkmZKBPtiKl0rM3eulZr0oQEtgTBkBD4vifeYtphQyru5JtMnz3NFwIIWtbpnLh3QX
         4u7nq8XE1lz9+OJaoh+UazAwX3Z3NxWHJo7bjdm1zucKcmR0BJQMnAGeIiWOpb6u1NUr
         t7GtWPN+aqW7mBOu6LaM196KKwi8typqIoCj4D3g8wzTDZZpi0huTq1CoOrjVTaLRiPu
         Qzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731365511; x=1731970311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQl50ASVKori1aU7G1WY6tJUmNCetIqIxTMQTgNJ8kg=;
        b=Mst/c3M/+vyYzm1wfx4OTd7/HCIxqk6yN5qVpdYlVgwCHdUGNMCtLvzchDj/Tq1DC/
         D/cqIGJpuSm3sWfCCZwE70Y+eSe7uB1g11B6kLZ8VAd+hDdb7XaKtsqXhuz/GHxSm6bB
         LJky0Cwd2aJ+zcFinNzD1ABuXbFJsaDKDYhyDLnCypajFoLWfeeYFdcKPN+0NUMtvf96
         HmApl485SILuf5HXtW2Ymp/ut3RfC4nlwPFhhqroitkIbar3SMJpgI7eBP6dSdpPWTHj
         9FMBQHWtJ0h89NV99MBAb5y+jSAkft6Vtr3QvUojRnAt/IYNsmK4jxAZCVZUZFHRcaOG
         Hu7g==
X-Forwarded-Encrypted: i=1; AJvYcCWsc07J58p60nAGV5fU+Z0jbxXd/RX4e2zfvicpWEMZLEJZSaAqL/bY/0FGGi9g3QM2MYm9wK2QrUEjhWk=@vger.kernel.org, AJvYcCXs8JoCr53v1O+tt4iubGfCTE4VK71HITen7G7TfkeCSYpI4lh7M/tM+507mfSq3gZd53y/Sz9VtnCRpC154bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8JiJMfMb571S9dyhiYyN0mZSvL/qOVGatUMtKnkNGChg1y2Er
	7d9/8XsSLPwvfwbl/LEyVp3NxT9LSuN1VmdA5fur8jQPD8uXy0pCQOgCZ1YLfvUh2yJk0d7S8fQ
	2Slpb0r0hO0A6QXgQ+ijRPD4v744=
X-Google-Smtp-Source: AGHT+IE2YGxxbqCK2DC6cCxuCjY72oZoTCCw7zs/q3dmYzS3MCOQAzruXEf69l3b2YytZ3hreigJPJMD2tEq3F3u0RM=
X-Received: by 2002:a05:6102:38ca:b0:4a5:b159:8557 with SMTP id
 ada2fe7eead31-4ac29776538mr502334137.4.1731365511017; Mon, 11 Nov 2024
 14:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111112615.179133-1-alistair@alistair23.me>
 <x6OyXuGQi1xeknAX_pjcl17BOpxRM6OGtLWGhGOH4LUgghJaP29a4ebzCT21QdfxBb88PwZCc2U7zizrTTSzVg==@protonmail.internalid>
 <20241111112615.179133-2-alistair@alistair23.me> <87cyj2t2l1.fsf@kernel.org>
In-Reply-To: <87cyj2t2l1.fsf@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 12 Nov 2024 08:51:25 +1000
Message-ID: <CAKmqyKM5eOM=+vmvF8t8Um=Cjtx3ykhx9BRibQhDB_mWF2tKGA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] rust: bindings: Support some inline static functions
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alistair Francis <alistair@alistair23.me>, linux-kernel@vger.kernel.org, 
	boqun.feng@gmail.com, me@kloenk.dev, benno.lossin@proton.me, 
	tmgross@umich.edu, aliceryhl@google.com, gary@garyguo.net, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, alex.gaynor@gmail.com, 
	alistair.francis@wdc.com, bjorn3_gh@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 9:47=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alistair Francis" <alistair@alistair23.me> writes:
>
> > The kernel includes a large number of static inline functions that are
> > defined in header files. One example is the crypto_shash_descsize()
> > function which is defined in hash.h as
> >
> > static inline unsigned int crypto_shash_descsize(struct crypto_shash *t=
fm)
> > {
> >       return tfm->descsize;
> > }
> >
> > bindgen is currently unable to generate bindings to these functions as
> > they are not publically exposed (they are static after all).
>
> Very cool!
>
> What does this mean for our minimum bindgen version? Is the feature safe

There are no changes to the minimum bindgen version :)

The next release of bindgen will support it without the experimental
flag [1], but 0.65.1 and newer will all work.

> to use in our current required version of 0.65.1? Did the feature change
> in significant ways between 0.65.1 and whatever version it will be
> stable in?

There are no breaking changes in the changelog that I can find. There
are improvements to support more functions, but as we use an
allow-list that doesn't affect us.

Eventually when the minimum bindgen is updated we can remove the
experimental flag, but otherwise it should work with everything newer
than 0.65.

1: https://github.com/rust-lang/rust-bindgen/blob/main/CHANGELOG.md?plain=
=3D1#L219

>
>
> > diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functi=
ons
> > new file mode 100644
> > index 000000000000..1f24360daeb3
> > --- /dev/null
> > +++ b/rust/bindgen_static_functions
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# Don't generate structs
> > +--blocklist-type '.*'
> > +
> > +--allowlist-function blk_mq_rq_to_pdu
>
> Should this be moved to the "Remove blk helper" patch?

I need a function here, otherwise nothing is generated and it fails to
build. As this would be added in the next patch anyway I just added it
here to maintain bisectability.

Alistair

>
>
> Best regards,
> Andreas Hindborg
>
>

