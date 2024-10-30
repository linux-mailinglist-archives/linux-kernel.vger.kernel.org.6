Return-Path: <linux-kernel+bounces-389031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6D9B67BF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DF7B243B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF36E214425;
	Wed, 30 Oct 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpIYwE1o"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E6214409;
	Wed, 30 Oct 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301865; cv=none; b=nF2neRIRtBCiCEIs/NtCot/u6VOBBhL2UjLn8oaF227KjZ+uw9NpQ2kl7hdvNkPRAtbuPfETJ6RiOG1F7cV62EYA9Jfm79PcHEiM6eqN8wjG3Fba/emi+yALjW+2hAuCVeka6POUBkKavAlsVsiezdl5DbyM+Iz7aSyH+RErTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301865; c=relaxed/simple;
	bh=simIDRgpNIogo8rlcxsHSl0Byfsdzt7txDP9IEyqBpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqZ6PVom1AmVdoW7H1SzwDS5tJKr17WPLrJWETM0af/NgdgULaDh9tm9J/Kq8YVWTeQGdYNoHYRtXXxg0HWi7qe4USOnUyhQsOYPykDOmsQscD5g88h8PIYQj/YseRFgvw0255wseKX6Oy1ykuyNe52IPgmr96Z06LF3rbRWiSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpIYwE1o; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so57267231fa.0;
        Wed, 30 Oct 2024 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730301861; x=1730906661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=simIDRgpNIogo8rlcxsHSl0Byfsdzt7txDP9IEyqBpQ=;
        b=UpIYwE1oRqPra2sYqfI3iHDnZmT0u5n5e90sso5PgMzhD2/jIYpZkYEv5pdbVQMubo
         TXo+rzn5+vIjXhptTmIAUkqOXskuV/rXV8PpEBP6Kw2pQkENamSgT7smCFo0K4oR8a23
         3O9LVhppmeHqL0IoC4+IvRSHrqmW6QDN95aYhbh9YjiylVcIDo93r5JEzRo/43OaWH7b
         ME+AXz8wxLZrqcliMykF5hfjEydO9NBPY3wOzdAihY5TpxqOql0dhfqVOUV9JCXJoTQj
         /d5BD3xC/GlhbctvCXcEEt4YJlMpxscTeNidXPJCQljBSUjC6xETzwfbi+204iMFG3tW
         VOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301861; x=1730906661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=simIDRgpNIogo8rlcxsHSl0Byfsdzt7txDP9IEyqBpQ=;
        b=pZNJ/4WcLTM9Sc1QH50UKXVnMhQmK8w6exNO/8yLa+fnqBxKLV6apDSBWFnZnL1zun
         waJGghdgOaqvGTQ84ahnW+k6J3VdbDJ61EeaLJB4ebDLHBNcMyPsoP8vC0B2MItsod5Q
         WTVEq3nNhRPFaB4eAq/uLH3+WTyXAm3NBZMpjDEX9S1+v+S30KSOQbgK8XovO1ChUSQv
         pEUWYDLXEuhCUEruzCZ29bYPSE24ifax3axouM8i6BVEBNYZtkuJ//3mSBkLaa+nsFdi
         bmXbwZUjAne+mIj3av+QvI6U4kKtor3RgPiOleiHs0CWo2WMKudC3UfIwEj/9GZ+1qL9
         DgjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWVss9vtvT7jOR8G9JWG6VXtOJwKcd5UqHfzmVEaDwbhYk+nlx2f/3JqY8SUMAelOP9A5gO+qaGB+uK84=@vger.kernel.org, AJvYcCXgamgiWJnOfR8+a2giK/vC96jitcq9tXUbFhUBtIZycLNrJTu2dM5tKJo99QvaCCBckyiVHPdyu4GB6KNsahY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaoCw9Fgy6DkiQ3qMSxC7LafJbVyh43Jy/WfGofPVcDLsU0Cu
	MShvluTfPHVn1B8D8hfLo132PYBMeZVmfIrbaKpVSMXPJv3VueCQ6UTVidnsqHxVJiORPtvHQ5r
	M/2iYjyJSVh2zP8JOiEDKHKlIxiA=
X-Google-Smtp-Source: AGHT+IE4gyDMqwRdbc7hHX51MJvkoKiADiZ7VWRVyXvrDWfOZoF+Anaaz/unns94k1ZD5ofwBDuthn9jLfGYzBCvxfM=
X-Received: by 2002:a05:651c:19a1:b0:2fb:5138:a615 with SMTP id
 38308e7fff4ca-2fcbddfcba6mr82028751fa.0.1730301861242; Wed, 30 Oct 2024
 08:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-bindgen-libclang-warn-v1-1-3a7ba9fedcfe@google.com>
 <CAJ-ks9=8Bo94Fg_By956ce8X0r-6xBWGO_Ka+rCQ2h3tF2nkRA@mail.gmail.com> <CANiq72=2ALWH-TeHH+=YEmkWw9CEyNUp5EZoBFU=xvqewheeWA@mail.gmail.com>
In-Reply-To: <CANiq72=2ALWH-TeHH+=YEmkWw9CEyNUp5EZoBFU=xvqewheeWA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Oct 2024 11:23:44 -0400
Message-ID: <CAJ-ks9k8S3g_DaWYOdLs6JYr32OZfexqOoJ3XNf87HQ221-JZA@mail.gmail.com>
Subject: Re: [PATCH] rust: warn when using libclang >=19.1 with bindgen <0.70
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 11:22=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Oct 30, 2024 at 3:14=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Might be time to rename this script - in another patch of course.
>
> Why?

It seems to do a lot more than report whether or not rust is available.

