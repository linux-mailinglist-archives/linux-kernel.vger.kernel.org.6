Return-Path: <linux-kernel+bounces-534948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F04CA46D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADC33AC1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F2B25A327;
	Wed, 26 Feb 2025 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyhkkvVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD0258CF9;
	Wed, 26 Feb 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604144; cv=none; b=gBVk3W9eBukcZDV44UBwtACNtXZw1mMVGpFu6O4381Gj4c7kIj0TGM4KjfKIXADD+NtEvgpSQ/fkDzY9OFTNYqcEQwK/X5HKp0vp3HkwAiNToMr83PhBl2n631eGJ2NJnd4xeuGHtkoZD+MDri495gv2QSSxMqcuP/ZlB5/w0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604144; c=relaxed/simple;
	bh=wKsuMFbqV1FhjOek7a8mnTHx45psb01PJrZfAh3rWHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uYljKDTGCkVGPEYAgxKDq2+VB0PAAmjQLk5leaMsyhp5ZzdN7uQrcTDCLrsT4rB1ATareNvyvzq5ZxgrKdDUOxzVot+q4prKIwYp5dF3BXAjs/NwxWcDKiZlyw4V6oA3V0uQDx1+e/Ny/WVb8twrolbt5PLe1B0KxL7xExDMqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyhkkvVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17957C4CED6;
	Wed, 26 Feb 2025 21:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604143;
	bh=wKsuMFbqV1FhjOek7a8mnTHx45psb01PJrZfAh3rWHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qyhkkvVX/r8Yac8mIlsMTXoWa5oSjjsQuRxp1D4T/reVdYS7KgDB6iekBko2MUHYi
	 e4JhnaemqK4lcu8sSuxh8r16a4VLAqWtbgn7Ij/iiPzkrIMIPsHpPOdkhcHOj154aQ
	 6jaFax3shDPTKTewilE5iNTrqcpVcA6MwSoCM2mdl+TLrM6DROIQW48O7x0F9bz+7K
	 bKbhkclFv0xSLAt6r/RoOBebif7bIuvDTmNntZxP/5PEkMdqFbkpmhyO8SAQgwsJJX
	 dQlrl/fh7D5dnYedEPQdeyMbMxtsKh7WrpFzivKWaUBx9hDFS74wU5vqpeUXyKBQox
	 UFEQ9DP1GJcYA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Frederic Weisbecker" <frederic@kernel.org>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>,  "Thomas Gleixner"
 <tglx@linutronix.de>,  "Danilo Krummrich" <dakr@kernel.org>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  "Benno Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Guangbo Cui" <2407018371@qq.com>,  "Dirk
 Behme" <dirk.behme@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Tamir Duberstein" <tamird@gmail.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 13/13] rust: hrtimer: add maintainer entry
In-Reply-To: <5894b70c95a2865047ed80a5493d1009e997c16b.camel@redhat.com>
	(Lyude Paul's message of "Wed, 26 Feb 2025 14:49:56 -0500")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-13-5bd3bf0ce6cc@kernel.org>
	<Z7yT5XU5gAm0ZCZD@Mac.home> <Z78-mVAHdSq1zbJr@localhost.localdomain>
	<hv4Fk6XchReQtdXcD478taayXDVblq7VJFmVnxMbUG1YteA3y_E05vwFF_5F8wVxD-pErlnimfO2i3qXUrN7Kw==@protonmail.internalid>
	<5894b70c95a2865047ed80a5493d1009e997c16b.camel@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Feb 2025 22:08:50 +0100
Message-ID: <87ldtstnvh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Lyude Paul" <lyude@redhat.com> writes:

> On Wed, 2025-02-26 at 17:17 +0100, Frederic Weisbecker wrote:
>> Le Mon, Feb 24, 2025 at 07:44:37AM -0800, Boqun Feng a =C3=A9crit :
>> > On Mon, Feb 24, 2025 at 01:03:47PM +0100, Andreas Hindborg wrote:
>> > > Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. =
Also
>> > > add Boqun Feng as reviewer.
>> > >
>> > > Acked-by: Boqun Feng <boqun.feng@gmail.com>
>> > > Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> >
>> > Frederic, since you've reviewed the series, and we certainly need your
>> > expertise here, do you want to be an reviewer in this maintainer entry
>> > (to watch how we are doing maybe ;-))?
>>
>> Yes indeed! Please include me as a reviewer!
>
> If we're adding more reviewers here would you want to add me as well? sti=
ll
> fine with doing that in a separate patch if you'd prefer

Sure, I'll add you =F0=9F=91=8D


Best regards,
Andreas Hindborg



