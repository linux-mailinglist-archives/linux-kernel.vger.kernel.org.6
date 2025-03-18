Return-Path: <linux-kernel+bounces-566834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482C2A67D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F42037AC635
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C491E521A;
	Tue, 18 Mar 2025 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuyui4pT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C80154425;
	Tue, 18 Mar 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326020; cv=none; b=dm0iywDtwjadtm4r+7lP8Xtk8j4SpqruuzsuvDZfz0mqDS+f3PVgu5EEJWJomquWTZhu1HKLOmOIbKZHbu5wE68V2nwOhU0/kqaS3XQVyc+J5eJzh8p+o7zbaKUqPfKyQ1QhB72U3dt3uh4qRqbsaJKUSPjtfnmqLwxehyzlSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326020; c=relaxed/simple;
	bh=HcpPBMONhitl56bp5F0RR7mimHNgclhIc79by5IL1Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhczIR3XAoHtkbApUZ1+vYFKqWIfJFyp46KZrYW3n8KPonoFSQgmVxzxVMhEjzTvmw/1U+TwqVArmsKhpYB26D4PgWs23dOGsKKNciu7I3Cns2MDMTQ+DGzrueIetOzcoBM94/2BREtVUqwndLXBbfRbhy4vKWUdOr6W1sJ3h6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuyui4pT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCBBC4CEDD;
	Tue, 18 Mar 2025 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742326019;
	bh=HcpPBMONhitl56bp5F0RR7mimHNgclhIc79by5IL1Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuyui4pTNA/21jsSGNTak1MaoYLoVi1v4NdO5dYebSyCAfi7lMavoMKFTOx0lisBP
	 kh3WQei9qMDXBnhU2aw6KgJOM0qwd3v+W3MK/GgVI4OAqQc6LkXaUH3a56te3NgCGE
	 Kj4clbZ6HzRz57KkyFuQ4JHTvCOoc+C0bvsmANwbFxltY/E8UOMYvWJjhcLtPoIFHr
	 vUJ1t1/8vkre6WBCGmtPz/jL3DjZNDEwJouWbHc5d15j3cn18uQaVnX/DjWEXjvdfz
	 MqApemIgwO/FXSI4xpvNLioLhYdxk4T8OMsUvgD0EzPAMjrvr9CGvfEtVdPFUCtmnt
	 GjaSCFc3HnC1Q==
Date: Tue, 18 Mar 2025 20:26:54 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <Z9nI_kM6LPELbodm@cassiopeiae>
References: <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <Z9gL5hQWvCNy5XNH@google.com>
 <Z9gcqHihXLg6kcZb@google.com>
 <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com>
 <Z9k9I6mp11Z358vz@google.com>
 <CAJ-ks9kcNvGqGrU1nKjYs_4XPbdxo2cW8Tj9JOGJesGO4StdAw@mail.gmail.com>
 <Z9mGv6ir4c96Of0Q@google.com>
 <CAJ-ks9mHvjPn98mcXh3q18nB5pPH6YBj3jf1YH6510bP-mtFtQ@mail.gmail.com>
 <Z9m_mfg5b0XE_HCF@cassiopeiae>
 <CAJ-ks9=YSN8VRUW6VTfThkN8uh42rbq9pBwvrG=EuW2wpuXx5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=YSN8VRUW6VTfThkN8uh42rbq9pBwvrG=EuW2wpuXx5A@mail.gmail.com>

On Tue, Mar 18, 2025 at 02:53:48PM -0400, Tamir Duberstein wrote:
> On Tue, Mar 18, 2025 at 2:46 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Tue, Mar 18, 2025 at 02:28:02PM -0400, Tamir Duberstein wrote:
> > > On Tue, Mar 18, 2025 at 10:44 AM Alice Ryhl <aliceryhl@google.com> wrote:
> > > >
> > > > On Tue, Mar 18, 2025 at 10:12:28AM -0400, Tamir Duberstein wrote:\
> > > > >
> > > > > The methods you're describing are all on Vec, right? In other words,
> > > > > their usage calls for a private `dec_len` or `set_len`. As I've said
> > > > > repeatedly in the course of this discussion: I would prefer not to
> > > > > introduce `dec_len` at all here. It (or `set_len`) can be introduced
> > > > > in the series that adds truncate or your patch that adds clear, where
> > > > > its signature can be properly scrutinized in the context of an actual
> > > > > caller.
> > > >
> > > > Oh I did not see that you said that. Dropping patch 2 is fine with me.
> > > >
> > > > Alice
> > >
> > > Benno, Danilo: are you both OK with this? I'll discard this patch on
> > > the respin and prepend the patch adding the len <= cap invariant.
> >
> > I mean, the whole reason to switch set_len() to inc_len() and have a separate
> > dec_len() was to properly cover things like [1] and Alice' patch by having
> > dec_len() return the abandoned entries.
> >
> > If we now only switch set_len() to inc_len() and drop dec_len() then what should
> > Andrew do?
> 
> I'd be completely fine with Andrew (or Alice) taking this patch into
> the truncate/resize series[1] (or the series that introduces clear
> [2]). It can be properly reviewed there in context.

Sorry, I'm not willing to make this Andrew's responsibility; set_len() worked
for his patches before.

If you're uncomfortable implementing your proposal without the existence of
truncate(), please rebase onto Andrew's patches.

I think Alice' patch can also go on top of that, since it should just be
truncate(0).

> 
> > Maybe we should just revert to Tamir's first proposal, i.e. keep set_len() as it
> > is, but make it return the abandoned entries, if any.
> 
> This wouldn't be my preference.
> 
> > [1] https://lore.kernel.org/rust-for-linux/20250316111644.154602-1-andrewjballance@gmail.com/
> 
> [2] https://lore.kernel.org/all/20250311-iov-iter-v1-4-f6c9134ea824@google.com/

