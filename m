Return-Path: <linux-kernel+bounces-519465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1EFA39D22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213AE3B90E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6779826738D;
	Tue, 18 Feb 2025 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSKGguFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDE2673A9;
	Tue, 18 Feb 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884244; cv=none; b=mXYTo5c3atik+yd50SOXi5wriLtFeYzszG8qLMeMYYRdEUutReIIUKRkgfyFyUHbAVLha5Biwx2VNos0peA7BC2OBJVPjvNsnc8Z+7hXRDLzKgR71KkXB47uZDIXVzGPzYrQAmUxqND7u/s1fdGhfymDih5CcxTpK8SQMpBJ3rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884244; c=relaxed/simple;
	bh=zeUTGsaNbP48jDpGJJxMyCS/5rb77E4H2ZuUqgrfnj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R327ZFQpbd9Q5jpbsBgioDFGwwuwPdZtbguj+0qdD4FsSnpcDsxMQvmpeqEtDyAyGNjsdOwqhK5T3kZS8jTvLO29TK5dkAOfZHEbG9kaDqI1b0sFr27BKqUEvPuFPBNT2JF68LlGFkZI2XWXRXHYDE8hbgf3shomn6aLF9o4YPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSKGguFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532F9C4CEE2;
	Tue, 18 Feb 2025 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739884244;
	bh=zeUTGsaNbP48jDpGJJxMyCS/5rb77E4H2ZuUqgrfnj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RSKGguFoGbyTWnrkPEjFbsRmB3TMpDwakbuvgSg6iJ/DQOFRlcAVKUDL06JN8rSz5
	 IMFiESO2rrv+HfOnozvrTAfYfxAHq2v4+ZLJTMxU2SpD3BZH4X4rRq63O4HMYb4479
	 bL7HhRz8ubqP6th9YME5GjhGpvVXXjDdXSy7tUcUeJ7CCktK/9sXQ2JNWANZV+0+Qx
	 9ojIIlvf4KHaPqEKbkojfbT713JaQkWljQEl1Y5vBhV51hwYueRvOBWJWzVyM92bEN
	 lgsAbex1VfDRN544EOAGlL0ZWMAQCRdaNXa7xexk+52fK4/soP/X8prviCRDpMkFxE
	 akomelMLb5G4w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Benno Lossin" <benno.lossin@proton.me>,  "Miguel Ojeda"
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
In-Reply-To: <Z7SEeBFJT7fRtvVN@pollux> (Danilo Krummrich's message of "Tue, 18
	Feb 2025 14:00:40 +0100")
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org>
	<20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
	<S6DKlLVx4KKevl_q2zrW69Z7oS0jwyX4DXpDZrFiIy1lKo4VYHM52aDiV82c2yf52Ecr7t9FayuqBUPR9onvZA==@protonmail.internalid>
	<dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me>
 <87h64su8ux.fsf@kernel.org>
	<Xowyi45vSJACPiAQ_Ek_CcwuixiZ-oAEK126Z887VLUeR30Dq8FN7gpKbpcYQtgGtCGslezkJeh2DNk-hnU4eg==@protonmail.internalid>
	<Z7SEeBFJT7fRtvVN@pollux>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Feb 2025 14:10:29 +0100
Message-ID: <87frkbflfe.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Danilo Krummrich" <dakr@kernel.org> writes:

> On Mon, Feb 17, 2025 at 12:08:22PM +0100, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>> > On 07.02.25 15:41, Andreas Hindborg wrote:

[...]

>> >> +    /// Implementations can use this method to do house keeping before
>> >> +    /// `configfs` drops its reference to `Child`.
>> >> +    fn drop_item(
>> >
>> > `drop` doesn't really fit here, I think something like `unlink_item`
>> > fits better, since the child isn't actually dropped after this function
>> > returns.
>>
>> Yea, I know. But the function is called `drop_item` on the C side of
>> things. Usually we keep the C names.
>
> I agree C names should be kept as possible.
>
> To me it seems obvious from the context, but maybe it'd still makes sense to add
> a brief note that this callback's name is not related to 'drop' in the sense of
> Rust?

Yes, good idea. I'll get than in for v4.


Best regards,
Andreas Hindborg



