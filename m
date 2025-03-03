Return-Path: <linux-kernel+bounces-544658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF95AA4E4A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC213BBEA6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E529617B;
	Tue,  4 Mar 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0b68H6F"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABFC296174
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101647; cv=pass; b=uy4zfKV+jCvBYgC4s/AZWJNacw7U7FOxRhxD7y3lleaIURSuVqbjWdf/Q7iLlC2u1dMjthOmRZkUcubNnT7AOv3JfoyTIDfg5Z8emsdLsI3w4dP/NQD+77a0DImM34XzZ71AP7Bixr17yncxTBlQWrflT9GaZ/dmFw8rnxU1i68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101647; c=relaxed/simple;
	bh=eEQbaOUOg9Ct9BioLacbMGP5yC7XwczqQxZikWutjqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2yaLcg8qnOouFM9T76p5CkVPfKpmtoQLPd+4erEY7N/0N3hraM/91jUuLDoSr605AgVhEBDyI9PyMMTlh/nz9FMaUqhA+cZNxyG7ueMMnvrPUR6g2dPcUi+CYVZ80J0rY4R/IKdjVqewZMgJI8bcEbBFRY/CD57CSOonevnk2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0b68H6F; arc=none smtp.client-ip=209.85.221.43; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id C5CE540D5722
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:20:43 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fRD1FZwzFysK
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:16:40 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 22D0142732; Tue,  4 Mar 2025 18:16:35 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0b68H6F
X-Envelope-From: <linux-kernel+bounces-541130-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0b68H6F
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 62602420A2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:17:36 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 422002DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:17:36 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F3E188DDF5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2436C1EF097;
	Mon,  3 Mar 2025 08:17:22 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB1F1E5706
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989839; cv=none; b=Jx4jmS092PjaiV55sie22mUxGzKYVlpkxlrNbiqWzloJgq56nO2lodfAAmqlrxNwVJyoEfvm6NpmIyw3HhLtOdkIM8Tlid8jvsYfGGmM0n+KqVBEwmqPD4dynmcblq6j35OzUgbob0PwlVXdtSnWVmRnmoBjBHINQhG25B6HVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989839; c=relaxed/simple;
	bh=eEQbaOUOg9Ct9BioLacbMGP5yC7XwczqQxZikWutjqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1o4n5LnBRFe0coQGanPeXQm4nrOg3tpPewCLCSauAlyt4TOsAW3nLmMvs6+EyMo/c/4wfBPCR8Gs1wEF8yFigG1XewyQf9gbeo3syywQLgW4HF/c3i/GSl4WCIzllJ5Ib7oJ79wG1vtJmAQPKuapEWuImJfwnDHcitJKfYORd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0b68H6F; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390edaee0cfso1930040f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740989835; x=1741594635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jA0dpvdILr7SLpPAx2h6QOM8iRHWeLVPpniq08kJ/yM=;
        b=T0b68H6FLXpHdwEpRUX/y/5eqnRLhVVn1Fk0wl25AjztpR469wnvopeV3sg3iXLno7
         xsSd5hLfT02JRNcqWKJFtdZdNl5F/4zkqvrKEl2TL9qFs+dZaCSIu977hbmXsrPPqT8P
         52SF/beL6xHheB9esqRXL2AsHDB76ycmQZdmH5zgIGYvyVGbCueegrB4LkPLwMQHH+mZ
         HjoZQiTGS/m2qqgAIW2LVROSTbb+ESbgggFK+aV7BYhcfWVJUf2aXcUlwNpZZUk0OjMm
         t3MzE4WUi5xdktHez63XUeXmOkGyJ5H7iWwW2j+gVHvVOrL5Whcfve5p33ItBV5Tz0tD
         2/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740989835; x=1741594635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jA0dpvdILr7SLpPAx2h6QOM8iRHWeLVPpniq08kJ/yM=;
        b=ZAk7/hRcoBJ2PASJ5icLxPuwhGULHeSrwpuRm9VIgO6UJSKFURJFP1nO38MM4x+HtC
         W68GHq1sN25XzVcJ9OTdYRhWaJmK1sTw4FqkqxzJA6o8yQOiJs0dm0wdzm27NBOygADf
         SgotSLc+GbhxPeCXZmXqIZOzySEQGINXlh2drbdcAoFk9ImiT2QBN5RUCMPRGKVAvIpV
         qV+zqBaC2/zn4Z0M+w8UTmrl6e8h0jvH+1vPKZqMzrYc6tzvVvXyp4RLInWh++wZRjGH
         hmgax9A6xmFbm9xBEIvUUXdlmzfRnWhVWOGFfB0oLAQcBcAIeKgXu6dtK7z0TGercPyN
         BjLA==
X-Forwarded-Encrypted: i=1; AJvYcCWAjY2WWX1HnmYwVIpYTaxCn6J5A3J2kzl+vsHyyiysliHJ2dX0s808qmsI528DmbZDutm8aN9iUGXTFJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2swAAy1G7fqqA/WJMFfW1gsNCd6JQnUqOJg0Y7pnIHI6n7Jzs
	uC2xrPo1PXeXaguC7CaOq5jRFyvn8ID9hiO75VPe4PwSsHl7mtyBCNkl+s02H5FsohtRUDGn59P
	hlXv2PJ0wjmI79oF8i6UITXp2WRMksKWM93gZ
X-Gm-Gg: ASbGnct9VJaYQ1+ebYPniD5pPR8hqmhlA7h57CX3lyKW5Hx7q/lwhfLTTxxoEjSqg99
	0EyRMk4vR/WbcaZUrFFge/RNWnRmDLACUHKmSEppmnENB6Y/JZm1ERUmit5VJy/jf0vLuG2GARD
	Lhy/4mdTAAqut5w24mDaCEzMNekNIHBgpqcT2hzvRMBqh9kfImFy7JcjyW
X-Google-Smtp-Source: AGHT+IFSYdPrfAT2czicp0H2L34T0MTTXxUfMLTH4DIdYq6oZerde5+Qjh15AbNt/anCVI0itN956I2sXy82N+8E8pk=
X-Received: by 2002:a05:6000:1acb:b0:391:6fd:bb81 with SMTP id
 ffacd0b85a97d-39106fdbd84mr2778396f8f.50.1740989835532; Mon, 03 Mar 2025
 00:17:15 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
 <20250228-export-macro-v2-2-569cc7e8926c@google.com> <CAJ-ks9nn1_gAqz9f3H9O47QA7dwk5MaT5YK3NQtZtUJHyNXbVg@mail.gmail.com>
In-Reply-To: <CAJ-ks9nn1_gAqz9f3H9O47QA7dwk5MaT5YK3NQtZtUJHyNXbVg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 09:17:03 +0100
X-Gm-Features: AQ5f1JorySWi-KYwhNh-r8Q996knGQo2fkyzux-yfstz0yHdBixCTqR1Fqf-3Ok
Message-ID: <CAH5fLgjgfgaoMP7TD46u9OsYuje6yA4ooM+6eCd5whAx+tiTqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] rust: macros: support additional tokens in quote!
To: Tamir Duberstein <tamird@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fRD1FZwzFysK
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706339.77837@AxR90/seb+dR//4rdNeI+Q
X-ITU-MailScanner-SpamCheck: not spam

On Fri, Feb 28, 2025 at 4:26=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Fri, Feb 28, 2025 at 7:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > This gives the quote! macro support for the following additional tokens=
:
> >
> > * The =3D token.
> > * The _ token.
> > * Using #my_var with variables of type Ident.
> >
> > Additionally, some type annotations are added to allow cases where
> > groups are empty. For example, quote! does support () in the input, but
> > only when it is *not* empty. When it is empty, the compiler cannot infe=
r
> > the item type of `tokens`.
> >
> > These additional quote! features are used by a new proc macro that
> > generates code looking like this:
> >
> >         const _: () =3D {
> >             if true {
> >                 ::kernel::bindings::#name
> >             } else {
> >                 #name
> >             };
> >         };
> >
> > where #name has type Ident.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/macros/quote.rs | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> > index 33a199e4f176..c18960a91082 100644
> > --- a/rust/macros/quote.rs
> > +++ b/rust/macros/quote.rs
> > @@ -20,6 +20,12 @@ fn to_tokens(&self, tokens: &mut TokenStream) {
> >      }
> >  }
> >
> > +impl ToTokens for proc_macro::Ident {
> > +    fn to_tokens(&self, tokens: &mut TokenStream) {
> > +        tokens.extend([TokenTree::from(self.clone())]);
> > +    }
> > +}
> > +
> >  impl ToTokens for TokenTree {
> >      fn to_tokens(&self, tokens: &mut TokenStream) {
> >          tokens.extend([self.clone()]);
> > @@ -40,7 +46,7 @@ fn to_tokens(&self, tokens: &mut TokenStream) {
> >  /// `quote` crate but provides only just enough functionality needed b=
y the current `macros` crate.
> >  macro_rules! quote_spanned {
> >      ($span:expr =3D> $($tt:tt)*) =3D> {{
> > -        let mut tokens;
> > +        let mut tokens: ::std::vec::Vec<::proc_macro::TokenTree>;
> >          #[allow(clippy::vec_init_then_push)]
> >          {
> >              tokens =3D ::std::vec::Vec::new();
> > @@ -65,7 +71,8 @@ macro_rules! quote_spanned {
> >          quote_spanned!(@proc $v $span $($tt)*);
> >      };
> >      (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) =3D> {
> > -        let mut tokens =3D ::std::vec::Vec::new();
> > +        #[allow(unused_mut)]
>
> It'd be nice to mention the need for this attribute in the commit
> message along with the added type annotations.

Adding a note to mention that when the () is empty, not only can't it
infer the item type, it's also never modified.

Alice


