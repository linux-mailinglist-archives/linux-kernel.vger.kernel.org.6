Return-Path: <linux-kernel+bounces-535540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 956F1A47441
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2DB3A8499
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CFF1E5208;
	Thu, 27 Feb 2025 04:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="X2wLdmzo"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA999198A1A;
	Thu, 27 Feb 2025 04:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629923; cv=none; b=P1RXpdiLhMI0vspZRTDYjej/UMfFHJnk7rVeWYm3K06VOgZmaFiehwFDMivtiaAFt3q3nlQi6QLsYy0nwwSK6VjwTvhLSYYpkYnX+cVNNKYgNeYdDQb80MVzjofrl/PYJeDz0lZL0dAHdl9jckti4DNpOALyXNq4KPZKgqWu+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629923; c=relaxed/simple;
	bh=m5qfims+v2e6exBHmvxfjRGQyhCjqu0KoOwpeSahJMk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bijBmeq7u4yBSt2Kv+1a6BDFw50Lx8yOInIPHF76IwdO1ntv6pAhfETbH/cmsoz9/mEOWcBOS47siUziRB+lPDaWKHxyM3mzzr+c0dEVAwaAd4z/DPMy710SzkDQF8KIas+6k34ID8ev9FZVAVEsy18YQQ0yReTQaDoTFLcC3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=X2wLdmzo; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-223.tugraz.at (vra-171-223.tugraz.at [129.27.171.223])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z3J3z2tmQz3xG8;
	Thu, 27 Feb 2025 05:18:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740629905;
	bh=0scnpHCPrnZ4TGjszWpO3h9174Jy+F/CX80sig3pL7U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X2wLdmzoAOo0QdVAZTeLCUbgqc/gEAzyjdGBredZg7YCFGQoEqiFkZph4pwi07tJi
	 yTjyVGd1yMMA7FsAsKUfU5pmd6XlIEi9cy9Yee5FBJaARpwvnVBSUriaZkZ5B7RE3p
	 Z3oBJeTwJPIPY0kpkXL1rkc9k6FYo1SHVag9ohJ0=
Message-ID: <09e282a9c02fb07ba4fc248f14c0173d9b19179a.camel@tugraz.at>
Subject: Re: C aggregate passing (Rust kernel policy)
From: Martin Uecker <uecker@tugraz.at>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ralf Jung <post@ralfj.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com,  boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de,  gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Date: Thu, 27 Feb 2025 05:18:22 +0100
In-Reply-To: <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
References: 
	<CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	 <20250222141521.1fe24871@eugeo>
	 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
	 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
	 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
	 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
	 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116

Am Mittwoch, dem 26.02.2025 um 13:14 -0800 schrieb Linus Torvalds:
> On Wed, 26 Feb 2025 at 12:00, Martin Uecker <uecker@tugraz.at> wrote:



[...]
>=20
> That "single read done as multiple reads" is sadly still accepted by
> the C standard, as far as I can tell. Because the standard still
> considers it "unobservable" unless I've missed some update.
>=20
> Please do better than that.

This is not really related to "observable" but to visibility
of stores to other threads.

It sounds you want to see the semantics strengthened in case
of a data race from there being UB to having either the old
or new value being visible to another thread, where at some
point this could change but needs to be consistent for a
single access as expressed in the source code.

This does sound entirely resonable to me and if compilers
already do behave this way (though Paul's comment
seems to imply otherwise), then I think the standard
could easily be changed to ensure this.   I do some work to
remove UB and I was already thinking about what could
be done here.

But somebody would have to do the work and propose this. *)
Such a change would need to come with a precise enough
explanation what needs to change and a clear rationale. =20

My guess is that if one could convince compiler people
- especially those from the clang side that are the most
critical in my experience - then such a proposal would
actually have a very good chance to be accepted.

There would certainly be opposition if this fundamentally
diverges from C++ because no compiler framework will seriously
consider implementing a completely different memory model
for C (or for Rust) than for C++.

I could also imagine that the problem here is that it is
actually very difficult for compilers to give the guarantess
you want, because they evolved from compilers
doing optimization for single threads and and one would
have to fix a lot of issues in the optimizers.  So the
actually problem here might be that nobody wants to pay
for fixing the compilers.


Martin


*): https://www.open-std.org/jtc1/sc22/wg14/www/contributing.html


