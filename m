Return-Path: <linux-kernel+bounces-538016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424EEA49397
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDE63AD613
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A81C2528F5;
	Fri, 28 Feb 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="aw7sxCaH"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D48F6B;
	Fri, 28 Feb 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731592; cv=none; b=aKKneXTonUnfzJvg18kobvOh5ErotUK0VYSA0T5ZAEJ2dr9IN1fa9lOr1t5vrYDogx17KMVQvTu0lPVvI42xGI5sb085fUuyIxwuwIuC6h1BI5Ap05rTE6ssVoT4HFp/jZt7jcAaWJVbEawVjepSv/iI6nF/YzFBm1GouU3PCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731592; c=relaxed/simple;
	bh=FsVOmG+eOn25bBM3FLaDmS1bSRItCTyhAfkQr4QLaYc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V7sGrlnxs6KPxIP86Qy7RcK3FsaxI5/MSXeIaIR0odVvjvSVYEUV8rWWyFsDDX7W78oONKVRRtD/iiARWwi27eWHELkyymlVSi1ZSsoqkvklY0G41YWmt3dXy+26LET8+QMsPSKpSgwM44nKVylU2FiUI/ejdcifbQYSrRtyvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=aw7sxCaH; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-233.tugraz.at (vra-171-233.tugraz.at [129.27.171.233])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z41gB0Bxhz1JJBs;
	Fri, 28 Feb 2025 09:32:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4Z41gB0Bxhz1JJBs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740731576;
	bh=FsVOmG+eOn25bBM3FLaDmS1bSRItCTyhAfkQr4QLaYc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aw7sxCaH0qhEdPR8CbZIfrvPiH3FGpYjUrQmy1JII1+W+77aVTI44jmglapIsuu+0
	 HZOOdkh0gL4xUM9Jj957zm1JDYS7VPx6RcxAjEGwcYVztEeFE6x2UWnZWd+9/fhICu
	 wmpBMTqWDeXOfRyynJGu+nwnLRHttw3txVBjsMpQ=
Message-ID: <d465e17bfc45e02b2bbd68a4235cc1c7fd7500e1.camel@tugraz.at>
Subject: Re: C aggregate passing (Rust kernel policy)
From: Martin Uecker <uecker@tugraz.at>
To: Ralf Jung <post@ralfj.de>, Linus Torvalds
 <torvalds@linux-foundation.org>,  "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Ventura Jack
 <venturajack85@gmail.com>,  Kent Overstreet <kent.overstreet@linux.dev>,
 Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
 rust-for-linux@vger.kernel.org
Date: Fri, 28 Feb 2025 09:32:52 +0100
In-Reply-To: <59c7a1aa-7ff8-4ed1-a83f-5db43094d3a8@ralfj.de>
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
	 <59c7a1aa-7ff8-4ed1-a83f-5db43094d3a8@ralfj.de>
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

Am Freitag, dem 28.02.2025 um 09:08 +0100 schrieb Ralf Jung:

>=20
> (From a different email)
> > It sounds you want to see the semantics strengthened in case
> > of a data race from there being UB to having either the old
> > or new value being visible to another thread, where at some
> > point this could change but needs to be consistent for a
> > single access as expressed in the source code.
>=20
> This would definitely impact optimizations of purely sequential code. May=
be that=20
> is a price worth paying, but one of the goals of the C++ model was that i=
f you=20
> don't use threads, you shouldn't pay for them. Disallowing rematerializat=
ion in=20
> entirely sequential code (just one of the likely many consequences of mak=
ing=20
> data races not UB) contradicts that goal.=C2=A0

This is the feedback I now also got from GCC, i.e. there are cases where
register allocator would indeed rematerialize a load and they think this is
reasonable.

> Given that even in highly concurrent=20
> programs, most accesses are entirely sequential, it doesn't seem unreason=
able to=20
> say that the exceptional case needs to be marked in the program (especial=
ly if=20
> you have a type system which helps ensure that you don't forget to do so)=
.

Martin



