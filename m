Return-Path: <linux-kernel+bounces-530819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818DFA438E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA02188811E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D5018BB9C;
	Tue, 25 Feb 2025 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOSYI/UO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1926136A;
	Tue, 25 Feb 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474299; cv=none; b=tEcqUNbBN31isZM3olX3dCakI7LVQo7Gcbrr6gXW4s3gmLCqbOwW739svHuWWFho6s4Fd1JAQP5zfYC7Pc5LTa8+X9ZLgxmBOEOH3b3SnUXB8a6FPFn0kPy9c8gvtHBMrlQxbaO19KJijzUEi2XxND69r0Bee19fIq/uNtyZ0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474299; c=relaxed/simple;
	bh=05QLNDsxtSaPcxhtQ3nsQ6J5e1btNztLI7SRH7c/3Wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OT9J9Q8Pe04B3PyCBMUXUV9IhcfjKQrpLDE0U0kVrLDTEd1PPfU0yJUZwE/xqzfDbPlCTIFYw6LZiI+apnavefPYJNAkbVSw5SumBaIps328wYY33J/DpYbVKlG7JgjA3BDrf64+hQSsY0kDAZPB9+YmtXw7JKv/JcgIloAoAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOSYI/UO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB49C4CEDD;
	Tue, 25 Feb 2025 09:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740474298;
	bh=05QLNDsxtSaPcxhtQ3nsQ6J5e1btNztLI7SRH7c/3Wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gOSYI/UOQZtxdx+Gr0pWQxuMAdCFljQ+3RPA6xKRKNXzVATbtH4id9OTzpB23REx8
	 1TDQhxCZsC25mtM/elDs2BAy+TR90LkgB7kJnN+Ajjnouu8qfVNMeOjhKcPjSdW3Ah
	 ZVX+JqxdsM/FuFy3oGXP7xFv8QjZKxVNstO4/LraaWYGelzZikSvyxEiBD0V9Boz70
	 ZTu+rajUAPin5Mvmkb5xyaTlHsJyAdiWqNnj9rC28SKT20Os1HDbB1FZg/wf7zVDC2
	 8Qqr46VHUVnCII13Eg6BQMhzaL85U9G8qUfwLUE2ogaoWVXfiPNs8H9uJ3NHvTZzAt
	 SFotrwv68A8ng==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 11/13] rust: hrtimer: add `HrTimerMode`
In-Reply-To: <96f4ee3fd83d4b248441f536fae8f694af52d567.camel@redhat.com>
	(Lyude Paul's message of "Mon, 24 Feb 2025 18:40:48 -0500")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-11-5bd3bf0ce6cc@kernel.org>
	<Sk36nx_Y-idodXXeE2t7pzk0a29qre1l249TK_Ln9v2J8R0y3K6aMhv4JZqTh46Po5hPAE6jfC39dDJTw-TCJw==@protonmail.internalid>
	<96f4ee3fd83d4b248441f536fae8f694af52d567.camel@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 10:04:19 +0100
Message-ID: <87v7sywg30.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> On Mon, 2025-02-24 at 13:03 +0100, Andreas Hindborg wrote:

>> +/// Operational mode of [`HrTimer`].
>> +#[derive(Clone, Copy)]
>
> PartialEq, Eq?

Sure, why not. I'm not sure if there is any negative side effects of
this? `Debug` too?

>
>> +pub enum HrTimerMode {
>> +    /// Timer expires at the given expiration time.
>> +    Absolute,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    Relative,
>> +    /// Timer does not move between CPU cores.
>> +    Pinned,
>> +    /// Timer handler is executed in soft irq context.
>> +    Soft,
>> +    /// Timer handler is executed in hard irq context.
>> +    Hard,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer does not move between CPU cores.
>> +    AbsolutePinned,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    /// Timer does not move between CPU cores.
>> +    RelativePinned,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer handler is executed in soft irq context.
>> +    AbsoluteSoft,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    /// Timer handler is executed in soft irq context.
>> +    RelativeSoft,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in soft irq context.
>> +    AbsolutePinnedSoft,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in soft irq context.
>> +    RelativePinnedSoft,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer handler is executed in hard irq context.
>> +    AbsoluteHard,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    /// Timer handler is executed in hard irq context.
>> +    RelativeHard,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in hard irq context.
>> +    AbsolutePinnedHard,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in hard irq context.
>> +    RelativePinnedHard,
>> +}
>
> Besides the question I had earlier about how we represent enums like this
> (e.g. using repr(u32) and using discriminants):

I'll await your response in the other thread

>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>


Best regards,
Andreas Hindborg



