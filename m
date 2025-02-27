Return-Path: <linux-kernel+bounces-536683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BA7A482F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8553B5335
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229C26B2C3;
	Thu, 27 Feb 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="w8gd+D68"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0D140E30;
	Thu, 27 Feb 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670257; cv=none; b=XQinXGD9Hp+DH8d/NsSGQl384nIToB9OxMnTH875Izki6/rkU4Y00VyDQyGo8nuwA8zUvkkZdwY79lKf1zCDnUmllAFDYq4KkjuQwOI4wjAd25MmFpqUgHI0Jnvv3V+T2T2MvGdYI8Dg+CJzr4s9tiZjIQOxaVu6+yz3YBRKl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670257; c=relaxed/simple;
	bh=o0UvjLqBNiIoXova2cJYX5uoNI9jFerQg1JWrk0OAsk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gXPFLinD+o0BICmZ4kR+MHxD4gd65erXlP8VeCIblvY3v474cLjfF4vMvhQ1ZbJFbrMjIncb0aqf2JXXyRQt+qc7PKi0yMCbgXF3Zf3YfSCkEamK8g7SXCTFOp4qk4tYE5cA+yqcCqGVUanRTAjnMJ/VAxAhAJvF6EeByaaeP4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=w8gd+D68; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51RFRn4l2204046
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 27 Feb 2025 07:27:49 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51RFRn4l2204046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740670071;
	bh=o0UvjLqBNiIoXova2cJYX5uoNI9jFerQg1JWrk0OAsk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=w8gd+D686FERjp+qfzeIMQcKI8kUJJ94AXPZx/ikjhjHqb2nHRoFOXgA/1YD2biNY
	 9oI1ZUJFhat1YOiHgL/qSIhmSuW4OVxBvgNBNXNZiKAIIxmfrzw0xQTdfJaZdC11cw
	 29EjOCKplrI6Do4dE8PEUc/ViIlmcBnPXqSCRSWbY0R/gmYm59+k4BmVEnAA1A3tEv
	 7kD/4/ZaG8Nwd9PW/jbuRkLDKE7fUBnQIRVRBSvTtqg3DydyCKG1Mqb2tGJ+lQv5Qy
	 z+IZa80n1AhnRRmSRRq2zAUxy4vPReygOALrlyczwhP5RPxJ75YSbLkjU61rnO62tJ
	 68/HdI+pV/RaQ==
Date: Thu, 27 Feb 2025 07:27:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ventura Jack <venturajack85@gmail.com>, Martin Uecker <uecker@tugraz.at>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Ralf Jung <post@ralfj.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com,
        david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
        hch@infradead.org, ksummit@lists.linux.dev,
        linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
        rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFJgqgSjRwOUkcC5v6wGcfQ-53oWyWW+wBg3PZ-w7vRweHekpw@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com> <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c> <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com> <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com> <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com> <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com> <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com> <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at> <CAFJgqgSjRwOUkcC5v6wGcfQ-53oWyWW+wBg3PZ-w7vRweHekpw@mail.gmail.com>
Message-ID: <75F703D5-5ECD-4DF5-97AA-0CBD5965F470@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 27, 2025 6:21:24 AM PST, Ventura Jack <venturajack85@gmail=2Eco=
m> wrote:
>On Wed, Feb 26, 2025 at 1:00=E2=80=AFPM Martin Uecker <uecker@tugraz=2Eat=
> wrote:
>>
>> I think C++ messed up a lot (including time-travel UB, uninitialized
>> variables, aliasing ules and much more), but I do not see
>> the problem here=2E
>
>C++26 actually changes the rules of reading uninitialized
>variables from being undefined behavior to being
>"erroneous behavior", for the purpose of decreasing instances
>that can cause UB=2E Though programmers can still opt-into
>the old behavior with UB, on a case by case basis, for the
>sake of performance=2E
>
>Best, VJ=2E
>
>

Of course, that is effectively what one gets if one treats the compiler wa=
rning as binding=2E

