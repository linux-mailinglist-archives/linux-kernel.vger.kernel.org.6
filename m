Return-Path: <linux-kernel+bounces-369531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1149A1E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527582847D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C25E1D9598;
	Thu, 17 Oct 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/m8G4ny"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D61D8DE4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157607; cv=none; b=DDfx/ZnEmGvsdQTUa79cGUorcgb3oxvmoBIkPbrNDKhVHJyxK9tb4V6pcrKXmwwcyCr8P7Wvy3LtDWppqKRiNlcbm8up9vm/QE7uvguIVJr73o1B5fqmFryU7No68WOMaorIuHXtwIynn0uNos7eoYB1b9HD4zO+ZnbkmmCt6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157607; c=relaxed/simple;
	bh=eAO4OpzJK+ZqOZ8YhgV52/JYGCtHP8kWPtUgBTS6oeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbmtK62vsZCJbsS1e/Tu3MzLtHAy/vWMCQobVk9VZDlTnPAQllwBPt6XPLyKbZruq7zBp5Jn1pl2ZLjM/Bk54+tjoNh2IB9zXqkoIj3X4yhklB9AuxV3Z5+B6sIs+0eQsehJgivpF0TifEzgBQNejJkDvaZsfaME3pitv6t/x9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/m8G4ny; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so442011f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729157601; x=1729762401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aCF8qbJBg1Dps0D/CUhTqVXgsROfsWWZhphpElZXnQ=;
        b=e/m8G4nyU4TsNR1qulWewsFaJGWpMoB7aH5atbHjthLH6OlnpVqp3NmhvMeJXMEJGQ
         plPTfTX70h6xxcla4GqpiVZ4A8vI6xwHyON3ilDPSvDdqs0V8DeV+7v+nkExsJKFkfyc
         e9t91EXQM0ksoEof04C0IVXmAEwLXbO9fVDNP1CTvAxdTrTwbCkM/cSUgLZkyBFcrm8/
         hh6kT9kpeW5VMgi/c1E1bxz32yi4nVhaHfAbGlI2cPHMuq76vPjggBRfxnyjV+pL1z7e
         84kI1NKpxmle4e/m9FmjjcqYqxQsoH+Y040iM7v7SI4sFcvoy1jaOieU0NaK298H9tus
         kN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157601; x=1729762401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aCF8qbJBg1Dps0D/CUhTqVXgsROfsWWZhphpElZXnQ=;
        b=UlWU/nVGnc0+k+a+hiGj5G7lcVJD2IJCUbwB/y8Ta5j1COtp4kZdQDol9eK4GbzkIK
         D5vkxcGF2sStjlrcX3A4irktaHnQ/qXalKgN0SNxQHv2SSfsqIg1nUhS1yzECLqs2qsI
         3ZpTFo9BYlTWsAVP3yyiX3h2t3yPdzXKH8kRzHc7qgtVLcVdWVDqJreUQng1DX3TIEYr
         BbqQRbHFX6ZcVxGP9scnrIC4llI3QVb/3xTb1cNE78kgXMYHmlEKSMFe5Uv77/v/2him
         ykmBt9JHubAvkjaPXramhJ5eeV/oXcT7Mvg19GItaAnfcz5ROzRoQS/lw707SVmdBsQL
         2BLA==
X-Forwarded-Encrypted: i=1; AJvYcCVzY8y1O5AzGlET1KLVEzzpJIvH74qc0xYGQA+vR5aHhUyVaP4MzK/B+jChneyZuk0G7upaB3KH0gmP9X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwOk4F2w2S01fmVWOLCx4DY6yTXcl4uPekd7kf2aiYTcQ+8uC
	aFRcqijqyFZgRY+IEHdmXvE/knxhp/S8S70+c8v9fMubyjZx4saWiVM/rFs1oZSsxt5//7qYOT1
	5mPvxhZpp+7/PAtgeMCCWsVoFpdLkQtA8ts8g
X-Google-Smtp-Source: AGHT+IGrjgb4tg9+baFKcG84sjc0/H/bT6AHZ0SjBlystoLYnCAsWx0ASGEVpLgSEq/buwud93hxrF4rLN4G3ObBMe4=
X-Received: by 2002:adf:f9c8:0:b0:37d:415c:f27c with SMTP id
 ffacd0b85a97d-37d5ffb9969mr11235445f8f.38.1729157601306; Thu, 17 Oct 2024
 02:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-5-fujita.tomonori@gmail.com> <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
 <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
In-Reply-To: <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 17 Oct 2024 11:33:09 +0200
Message-ID: <CAH5fLgjHf3Z5HHOLnzZkk-Q5MOwz_57LQc6scr9yDy1j89HSCw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:31=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Wed, 16 Oct 2024 12:54:07 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
>
> >> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> >> index 8c00854db58c..9b0537b63cf7 100644
> >> --- a/rust/kernel/time.rs
> >> +++ b/rust/kernel/time.rs
> >> @@ -155,3 +155,14 @@ pub fn as_secs(self) -> i64 {
> >>          self.nanos / NSEC_PER_SEC
> >>      }
> >>  }
> >> +
> >> +impl core::ops::Add<Delta> for Ktime {
> >> +    type Output =3D Ktime;
> >> +
> >> +    #[inline]
> >> +    fn add(self, delta: Delta) -> Ktime {
> >> +        Ktime {
> >> +            inner: self.inner + delta.as_nanos(),
> >
> > What if overflow happens in this addition? Is the expectation that user
> > should avoid overflows?
>
> Yes, I'll add a comment.
>
> > I asked because we have ktime_add_safe() which saturate at
> > KTIME_SEC_MAX.
>
> We could add the Rust version of add_safe method. But looks like
> ktime_add_safe() is used by only some core systems so we don't need to
> add it now?

I think it makes sense to follow the standard Rust addition
conventions here. Rust normally treats + as addition that BUGs on
overflow (with the appropriate configs set), and then there's a
saturating_add function for when you want it to saturate.

Alice

