Return-Path: <linux-kernel+bounces-526965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB94A405C2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB342189DD2F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763FC1F150D;
	Sat, 22 Feb 2025 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buRjWkec"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367C101E6;
	Sat, 22 Feb 2025 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204264; cv=none; b=t1QP3kN31Udki0s1HApeciY9biNLtVelF9qZQ4Kr2Mv34WACrcIaodcN6KnWyx0QEQ/L6GnSK/vm+8bo1cCfzlrG8xHgK542GPWv5dXz4KOkJE7+JLIAqocMHIpChnudbm5sJZaHiObxi79wthBEMQ2+7XeWFvSxmcCZF+aSDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204264; c=relaxed/simple;
	bh=duzOIBj+WvWSqYXc4UWBI/jJcPgeKRT2xWPYPWTrPz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NKi9UQNW5+61wZeJxiBvSb6BQiGAiwJhUcE0+oqT/TNzdqOFxWtnqH2+FSsv+5XNQIZOdgNTLw/rQW11DwL8ZkEHKRXVvsobELzny6zn3oIyLYrQVxz3FFPHh/GEmaTskrtmVAFGj/d0WHMJCxaQKYahtO5sDEG1U58CSVdW5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buRjWkec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91617C4CED1;
	Sat, 22 Feb 2025 06:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740204264;
	bh=duzOIBj+WvWSqYXc4UWBI/jJcPgeKRT2xWPYPWTrPz8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=buRjWkecRfA2bXqvU/V1obcs/SoMhlXySQKVDmRHT1CKGOBdYhfe2jRRglAR8arvv
	 jS5dSXRLUnErU9Mv3kbnk8JbAbiB9tgng85F0F6OKmtDhHFe1IF4aeyzKRvlW2QT38
	 KUH6pXZU8eF5pYo3FkGgQx3M9m8zZymnYfg9HypHd1y6couAn2oVjfCqHBOh5FT6aL
	 QM/LfX0Ulhoxp0yZTeVn8YwBGQ/CfR6At9yxKDZM94CSXcWir65tYbqg5RQer5nSvA
	 p2qoyKsD0Qxm/6XpYP10EvMNPm/lhyIcyHeNP9fhXOT+WgD7r/XTC22SPYHJDLNhiI
	 /sLqPFNdeYXWA==
Message-ID: <f9b783dff11a923b53cb654a843af7ae33478f30.camel@kernel.org>
Subject: Re: [PATCH] rust: workqueue: define built-in bh queues
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Hamza Mahfooz	
 <hamzamahfooz@linux.microsoft.com>, Tejun Heo <tj@kernel.org>, Lai
 Jiangshan	 <jiangshanlai@gmail.com>, rust-for-linux@vger.kernel.org, Miguel
 Ojeda	 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo	
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>,  Wedson Almeida Filho <walmeida@microsoft.com>,
 Nell Shamrell-Harrington <nells@linux.microsoft.com>, Dirk Behme	
 <dirk.behme@gmail.com>, Konstantin Andrikopoulos <kernel@mandragore.io>, 
 Danilo Krummrich	 <dakr@kernel.org>, Roland Xu <mu001999@outlook.com>, 
	linux-kernel@vger.kernel.org
Date: Sat, 22 Feb 2025 08:04:19 +0200
In-Reply-To: <Z7lVeWFX-8uQJaJC@Mac.home>
References: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
	 <CANiq72nsDgRJeKk=B7C9Zo7HL12az+ZLR27qxckqi5H=cmuV5w@mail.gmail.com>
	 <Z7lP5VA374-TuNZz@kernel.org> <Z7lUcq3PycSSHiXx@kernel.org>
	 <Z7lVeWFX-8uQJaJC@Mac.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-21 at 20:41 -0800, Boqun Feng wrote:
> On Sat, Feb 22, 2025 at 06:37:06AM +0200, Jarkko Sakkinen wrote:
> > On Sat, Feb 22, 2025 at 06:17:41AM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Feb 21, 2025 at 11:45:38PM +0100, Miguel Ojeda wrote:
> > > > On Fri, Feb 21, 2025 at 11:36=E2=80=AFPM Hamza Mahfooz
> > > > <hamzamahfooz@linux.microsoft.com> wrote:
> > > > >=20
> > > > > We provide these methods because it lets us access these
> > > > > queues from
> > > > > Rust without using unsafe code.
> > > > >=20
> > > > > Signed-off-by: Hamza Mahfooz
> > > > > <hamzamahfooz@linux.microsoft.com>
> > > >=20
> > > > Cc'ing WORKQUEUE -- thanks!
> > >=20
> > > Not meaning to complain but it by practical has no commit
> > > message.
> >=20
> > oops, sorry, "... but by practical means it ..."
> >=20
> > Anyway I hope my message was received ;-) Leaves me wonder tho why
> > this was queued because it apparently is not even part of a patch
>=20
> What do you mean by "queued"? IIUC, Miguel was just copying workqueue
> maintainers, since they should be in the review process.
>=20
> Thanks for your review in another email anyway!

Ah sorry! I have dyslexia (for real) and I did read that the patch
was queued :-) Thanks for correcting and please do also the next
time!

I spent also last 48h awake setting up my personal Rust development
and QA environment... [1]

Anyway, to soften my feedback a bit I'll say this: everything else was
great:

1. Code was great
2. It was commented like you'd expect.

And I don't have much to complain about code quality in any other
patches I've seen so far.

I've been silently following this list for some time and this is a
common problem that the commit messages are quite bad. Thus, I even
wrote a public post about the topic now that I had this in mind:

https://social.kernel.org/notice/ArMk27Ism4Citb90K0

There's two great arguments to improve across the board:

1. Education
2. Integrity. E.g. AI is actually acceptable for short a patch, if
   you can in detail unmask the implementation (as is e.g. Windows
   notepad or really anything that produces text). But AI can be also
   used to engineer harmless looking changes that are actually vulns.
   By being punctual in expalanations we also contribute to the=20
   governance of our ecosystem.

I'm personally reading this list exactly for learning purposes because I
have a roadmap to Rust driver ongoing, and explanations even in trivial
things help to gather bits and pieces... So please help me to succeed
by doing just a tiny bit more effort ;-)

> Regards,
> Boqun

[1] https://codeberg.org/jarkko/linux-tpmdd-nixos

BR, Jarkko

