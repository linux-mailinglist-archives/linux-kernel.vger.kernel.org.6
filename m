Return-Path: <linux-kernel+bounces-519359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDDA39BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A07A4A87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790B2417D9;
	Tue, 18 Feb 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rre/sk3d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED32417E3;
	Tue, 18 Feb 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881035; cv=none; b=UHx1Lo/OZsAqgvmrUDcJmhtG43WJqyrGxhC9wE/lk+cz5IwXw6uYXu/ZF6mx/hXLF/L/903y0x7s8xz9mkaiTN2et2KXF0edTLUZR4aLfFvPMVMEGxA1oquQeaKCMaZhoDQN8Hh5myqznisqxPaqVlns3nFPbt4+i1p9DViaCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881035; c=relaxed/simple;
	bh=jycLROXglpyoglhdlFPQwOaGmcaR5KbAPUIoKVdoTlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IiYoEJ4rc0oeWvOOhMZF89sTTAvPcfSwzOO8/YwA/qwU2TlOprzS/Kx9cLoBQnTumhlbmxPpP+Cy4DvTFrvHe0jne3Mg+PpPDUOAE0XORDGeDOJY40ICJNvgiGhcAKcHjzl7RYORtxBKJlsurC9k/93YEOchwSM9fdloYRjSQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rre/sk3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC64C4CEE6;
	Tue, 18 Feb 2025 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739881035;
	bh=jycLROXglpyoglhdlFPQwOaGmcaR5KbAPUIoKVdoTlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Rre/sk3dCpaHx5Y1Rx5a5LoWjxy1KENcGvvwHBZKn4YwR5Z3LtP9kouLfiOgsldSK
	 5/s9lYMdTVB/7jtq5p4mEdUSQT/chbjAVA7psAGvydumrgrvMwYYLiy3jqzGDwn68F
	 fDQ94oElGyCTR06JXM7rfdCHpve/XhZO3XyxkdAQ0GMwuHN6c2rJdYAdyA+kXcKbiI
	 uDgfHdOssmLvQ/nnQNkzEs02KbxyIUkxFCMdS7+KwY0xcI97LdR9caPLNzqPkpIt5N
	 wm3AX9EH4iXrYmEwL9pWHyVbKADlCKxPj/DvXbL43NJZ5qg4YnLCX73sp4w3/feG2Y
	 uXP78+WrD9aTQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Joel Becker" <jlbec@evilplan.org>,
  "Christoph Hellwig" <hch@lst.de>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Ingo Molnar" <mingo@redhat.com>,  "Will Deacon"
 <will@kernel.org>,  "Waiman Long" <longman@redhat.com>,  "Fiona Behrens"
 <me@kloenk.dev>,  "Charalampos Mitrodimas" <charmitro@posteo.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for configfs
In-Reply-To: <87bjv0u5j0.fsf@kernel.org> (Andreas Hindborg's message of "Mon,
	17 Feb 2025 13:20:19 +0100")
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org>
	<20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
	<S6DKlLVx4KKevl_q2zrW69Z7oS0jwyX4DXpDZrFiIy1lKo4VYHM52aDiV82c2yf52Ecr7t9FayuqBUPR9onvZA==@protonmail.internalid>
	<dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me>
 <87h64su8ux.fsf@kernel.org>
	<Kkrr23DbfvS1nChcwAfhrogDdCOO92FQ2-9JUCab-_6CREP4iBX8k1KuxaJb-yv_ErGv9TbzDWwBZHvaszFS7w==@protonmail.internalid>
	<bfd79db6-bd79-4187-8577-3ae412f36f35@proton.me>
 <87bjv0u5j0.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Feb 2025 13:17:04 +0100
Message-ID: <87ldu3fnwf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Hindborg <a.hindborg@kernel.org> writes:

> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> On 17.02.25 12:08, Andreas Hindborg wrote:
>
> [...]
>
>>>>
>>>>> +//!
>>>>> +//! See the [rust_configfs.rs] sample for a full example use of this module.
>>>>
>>>> It could also be useful to just put the example directly here into the
>>>> docs instead of/additionally to having it as a sample.
>>>
>>> I don't think we should duplicate the code. As long as the link works, I
>>> think having it separately is fine.
>>
>> When I'm coding in my editor and read some docs directly in it, it often
>> is annoying to find a link, because then I have to open the docs in my
>> web-browser.
>> I understand that you don't want to duplicate the code (and it also is a
>> bit too much for a short example), so how about having a simpler
>> example? Maybe with only a single operation that has no associated data
>> (use `()`)?
>
> Sure, we can do that.

Actually, I am having some problems making the inline example compile.
`configfs_attrs!` references `THIS_MODULE`, which is not present for
doctests.

I'll add the example but mark it `ignore` ?


Best regards,
Andreas Hindborg



