Return-Path: <linux-kernel+bounces-531404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC5A44018
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056F616ADFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAA3268FE9;
	Tue, 25 Feb 2025 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="JqEupYK1"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44320D4FA;
	Tue, 25 Feb 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488584; cv=pass; b=tUBrv9x6X7gmqt+VDqg0suPxK+h8IvLpcgmhpeLeKIvqc7jmXXp/fUOwp/3IG7mQZFZEOpMLmjAIu3RF8Dg8zqJnpEPIrAZItkdhgCfD4uT3gNN8ZKO+HpDpWub4wDi1wVC2slBUIJgCmHTgOE6zOgN4AT2vJkFKUgrI8PqSEY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488584; c=relaxed/simple;
	bh=tQnceEmFZXQjFeG66AjLVsaLAOoe3bzhozDgQsU6dyM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f4hrCnSSFNt+u1BLeks+CDBJE6ezqLAKVLobsWUG8sR/n6SHdHE7tmUFQXwJ4NEg1H77l714FvtLxn+Kpc07CYReYXa6J53aBapLS0stkyTPPIaV2NPOpiQOB+m9GGl+ZNJ5xlbtuCB5u1omU4iVyOcoqiAOpOB+jHWp+0DhqzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=JqEupYK1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740488536; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bx5p8TnAINx6MKry4un1Rj6TZST3VxaVsCDq/qLhcQXOFb+gTUFq5ouyn+iZJH9lhg9DhcEZzGrdcYAWmYWDoXrv1YbbgC/ac8izMc5JSu2hKvYzCQq4QWw67HSByVw3Ir+9hpKjf2EwDduELE3tpDN44lfqY936qDWETBJRP94=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740488536; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gb8b9ieYfWwUHDImrjBLv13v+4ud8B3oKFwWOrvA9i8=; 
	b=PuDvukpP4bLBvBFEak/Nw+rsBHnslhYIkOdEQXJhwgKIUSBR8jqE35XieXDa7tiz3LmYJqW+oDU0XEhoICu/PtegzY692lWEtFaGyW7IWXLH/iLZVBaJCj9fgWqlG8DDtNWfd8zGFFGycf8iMJdOlHU7PADb0linNzxyxth4KZU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740488535;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=gb8b9ieYfWwUHDImrjBLv13v+4ud8B3oKFwWOrvA9i8=;
	b=JqEupYK1fimntgNzlGtPmhbeEnK22ZGiEt0SQ4I5dZ/ot8yPbUEaon9x8agigcuu
	5JEndeOdQ/boZKzMw7mBS+JBzcTqgtsMNEQCOTBzr2Rmlh4EXCHEAMkqj0cFTID3Acj
	qbqsLE6zvWUei2/IOwYp0cD5KFlRSNM/QW6JGZkw=
Received: by mx.zohomail.com with SMTPS id 17404885330511015.3322192127805;
	Tue, 25 Feb 2025 05:02:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v4 2/4] rust: configfs: introduce rust support for
 configfs
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <8734g2w6ka.fsf@kernel.org>
Date: Tue, 25 Feb 2025 10:01:55 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Fiona Behrens <me@kloenk.dev>,
 Charalampos Mitrodimas <charmitro@posteo.net>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD609CD0-D3A1-47D5-8D5C-E8DB57003932@collabora.com>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
 <20250224-configfs-v4-2-9af9b5e611f6@kernel.org>
 <lOoYh91-WphgZiaB1UWmZfYfG8hcG7pCydLGcO6VmeHOfZir-M4jz0KEO2AUMTkugvDLkvKw-M4Kl40xG8sgvg==@protonmail.internalid>
 <F1FA8DA8-A54D-49B1-BE8F-2B0DE14F4899@collabora.com>
 <87plj6wcz3.fsf@kernel.org>
 <Qb0gTp0yipgyPUH5_OOewMKao_hniHD2k1C4li2QpXqETWNHRjBzMt8q4bxwIr3_r1mqxJ2Tx2D8rS7EDak_2w==@protonmail.internalid>
 <118A2077-91B6-485F-AA5F-03D54AC5771C@collabora.com>
 <8734g2w6ka.fsf@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External


>=20
>>=20
>>>=20
>>> [...]
>>>=20
>>>>> +
>>>>> +/// # Safety
>>>>> +///
>>>>> +/// `this` must be a valid pointer.
>>>>> +///
>>>>> +/// If `this` does not represent the root group of a `configfs` =
subsystem,
>>>>> +/// `this` must be a pointer to a `bindings::config_group` =
embedded in a
>>>>> +/// `Group<Parent>`.
>>>>> +///
>>>>> +/// Otherwise, `this` must be a pointer to a =
`bindings::config_group` that
>>>>> +/// is embedded in a `bindings::configfs_subsystem` that is =
embedded in a
>>>>> +/// `Subsystem<Parent>`.
>>>>> +unsafe fn get_group_data<'a, Parent>(this: *mut =
bindings::config_group) -> &'a Parent {
>>>>> +    // SAFETY: `this` is a valid pointer.
>>>>> +    let is_root =3D unsafe { (*this).cg_subsys.is_null() };
>>>>> +
>>>>> +    if !is_root {
>>>>> +        // SAFETY: By C API contact, `this` is a pointer to a
>>>>> +        // `bindings::config_group` that we passed as a return =
value in from
>>>>> +        // `make_group`. Such a pointer is embedded within a =
`Group<Parent>`.
>>>>=20
>>>> This phrase is confusing.
>>>=20
>>> I am not sure how to rephrase it to be less confusing. The pointer =
is
>>> the thing returned from `make_group`. `make_group` would only return =
a
>>> pointer into a `Group<Parent>`.
>>=20
>> The problem is this: "that we passed as a return value in from=E2=80=9D=
, to pass something as a return value
>> is already hard to parse, and when you reach the =E2=80=9Cin from=E2=80=
=9D part, it becomes even harder.
>>=20
>> Just say a variation of what you said above, that is perfectly =
understandable.
>>=20
>> What about:
>>=20
>> ```
>>=20
>> `this` is a pointer to a `bindings::config_group` that was returned =
from a call to `make_group`. The pointer is known
>> to be embedded within a `Group<Parent>`.
>>=20
>> ```
>=20
> How is this:
>=20
>        // SAFETY: By C API contact,`this` was returned from a call to
>        // `make_group`. The pointer is known to be embedded within a
>        // `Group<Parent>`.
>=20

This is good.

=E2=80=94 Daniel


