Return-Path: <linux-kernel+bounces-550720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A80AA56343
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFC61895251
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE291E1E06;
	Fri,  7 Mar 2025 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1H9mq/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796DC2E0;
	Fri,  7 Mar 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338609; cv=none; b=LcJPMA+AyLXcTLWJ1bVvwcRc1RrxyVSzgk3NoZHVjyDeoaU/JlHEggfGtf8vx1We/U1TvDPMcZHVJZfIq/gjpKYz+CTE9Cda0rCRqlQy+iGP9lAo/OTz+4ROlzeol/sdA6iqDbVV87vIKdm6bdJKOpsmlrUDA6wMB5e4KZfJgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338609; c=relaxed/simple;
	bh=U2FVI4xcxSsKvXkcx9/dl4qkBmci0IUrmk9oTZ/O+w8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GjBylyjRBg8Za4cwXIdzRdMM1DOQW1CErcoi3VLpsLRaU6P+K4dG1i4vxb9PH3UkYwLNqEqVM3347w0mDofxinsBVnMOefjctZuzEiy+BwJn53l4iNmpXefVFpNuAZTz4rYNqLZ6fQGVcNhBOrCEdJrpHhIMbPAhyKPBA9KGSEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1H9mq/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB02C4CED1;
	Fri,  7 Mar 2025 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741338605;
	bh=U2FVI4xcxSsKvXkcx9/dl4qkBmci0IUrmk9oTZ/O+w8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=O1H9mq/8tvM+Ds6qKS0v/C/qqPtXjJ6L1QWWyENJTr2lzQiePR3dz3OUmrB6R4T1R
	 HLlgEOci4Z1u8GhpXEYlv2WSoj6H3L8nqMRbsFUzOv8t0O/RViM3wfNIiZywr+bahh
	 hFiImzQyka6omCZoWQ1naMG869n5R0AEUMB/iPU2Y3mdfzR9W0mihRfLn6dkdYtNFr
	 IRJJ1bpSv28WQsxO16HSx1J96N4buKYSn24kGmxiGEv0P0XzMM7bFThw9JedF2etMq
	 XYyv8NuCCVMFms+HfzTQXs8MXaF+e/wDWZPf8+PZe8AObcXCovoZBAoWCnaumsHCzm
	 lSHeDDfdz9I1w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Lyude Paul" <lyude@redhat.com>,  "Guangbo Cui" <2407018371@qq.com>,
  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <CAJ-ks9mozekrYvwFTJ4qKj3cpDa37+gUKefiZ1OscU9mP3NjuQ@mail.gmail.com>
 (Tamir
	Duberstein's message of "Wed, 26 Feb 2025 10:29:34 -0500")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
	<q5sIYQbnCqKmdnZZy-eaKvSUY7O5pOy2-QzwWwCo9VoormFcKS6RS3OVIIby-Pf5PDpTRh67txem3sXQKSB1JQ==@protonmail.internalid>
	<CAJ-ks9nj8+fXM_oo0LJo4O6Q=skFRcHwz8TLxw-yB3QTcDF9GA@mail.gmail.com>
	<87cyf6xv7g.fsf@kernel.org>
	<Wy3wqzRK5qG3GyHC7oEg3NR3tv9-Uv7m_tmgKZTHNEU6aZX5hxrIXLudLfzQvuZNvIz1Av2fKzH5eTvomny1Vg==@protonmail.internalid>
	<CAJ-ks9=PR-Laj37NqG5s_TbKddONWxp4-Cf3C57AMk9z92mfDQ@mail.gmail.com>
	<87r03lvnx4.fsf@kernel.org>
	<RWZWPbf2ND3HRx_kFFVnjBngQMWjrmbidBCzyJr58iQsksyu5SpJVfCiEjf7WYWFOz6eWib5Q9j23QmbSqXyEQ==@protonmail.internalid>
	<CAJ-ks9mCvGJoeLhkGHLU-7Q-=g_4XHfX4DBX9w=ZcP4jpWXsPQ@mail.gmail.com>
	<87eczludtp.fsf@kernel.org>
	<5Rw5FzjGNleoSZMNFRziOKrYHsHzxXJoSmBTH0VXvx7vSLojQvEN5iSvf7HYuQjNUp8ehIxfLvm3U_6r2YZxXQ==@protonmail.internalid>
	<CAJ-ks9mozekrYvwFTJ4qKj3cpDa37+gUKefiZ1OscU9mP3NjuQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 10:09:52 +0100
Message-ID: <87a59x5hr3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Wed, Feb 26, 2025 at 6:48=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> "Tamir Duberstein" <tamird@gmail.com> writes:
>>
>> > Sorry, I meant HasHrTimer and HrTimerPointer rather than HrTimer and
>> > HrTimerPointer.
>>
>> `HasHrTimer` is named so because it is meant to be implemented by types
>> that contain a field of type `HrTimer`.
>>
>> `HrTimerPointer` is meant to be implemented by pointer types that point
>> to types that implement `HasHrTimer`.
>>
>> They are different, and the naming reflect that.
>>
>> I will not rename `HasHrTimer` to `ContainsHrTimer`, because the rest of
>> the rust kernel uses the `HasFoo` naming scheme.
>
> The Has prefix makes sense in HasHrTimer. Shouldn't the name
> HrTimerPointer also contain "Has"? HasHrTimerPointer would be
> confusing, but perhaps PointerToHasHrTimer? It's a mouthful to be
> sure.

I get your point, but I really think that `HasHrTimer` and
`HrTimerPointer` is pretty good. Names _can_ get too long.


Best regards,
Andreas Hindborg



