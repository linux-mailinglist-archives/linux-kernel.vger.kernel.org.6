Return-Path: <linux-kernel+bounces-536131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F3EA47BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD61172071
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A4E22D4DF;
	Thu, 27 Feb 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGHUfehn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2D22836C;
	Thu, 27 Feb 2025 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655108; cv=none; b=NvRRuql+xKF23iK6TR//bFPPh8kB5k5yn5WgOl4z159HE41JR0uzrHwvVW2dZqxHz7pDBvDds5/JZIKVvi0FJOb8zXrADbT8/wnSfogKGZQxH7vNSCTXgMilLRW13ut2DaZz+vAtQaCLOEa7DRZiu4CxRMXljqPm4HIMp4zLwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655108; c=relaxed/simple;
	bh=18fxekQp5UNFj1KRhDlY4nBV/k4Bu70+SmkhQsKs9YI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FjB1YaII5a+RrWPjvBHiY06GUPv6fjatxuztR5y6d0OCFcyY/vHKoirX6If4oywo5WS5N/w4nAv6t+LEa+btwdTFxI8mIt5/PaTb4FWqfWRID8/aJTdSnINftbzATU95QAaoHYip4aNBSJPBFFUn1i0LRJLkTFKADcDgU3f+wQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGHUfehn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD2BC4CEDD;
	Thu, 27 Feb 2025 11:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740655107;
	bh=18fxekQp5UNFj1KRhDlY4nBV/k4Bu70+SmkhQsKs9YI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JGHUfehnsqo+HA3j59zVlpYAPGKYWblpzLxI/0IHHiZP6HxQTnig5+dsJzd84oIuc
	 UGAgtFyuAe1J4uY27qk2Aswdg63mJpLstpmFIlPHM5pPEUKqr9ZcP5wt78ctRiBIg2
	 ZeODPCBe1g8JinOPZKJb0KDC/csfen4KIpQwwptteqPElZ9veMu350WVpT5feFIEev
	 ND1gGv12MzhMLYDLMOjX9z5gn/863jdoTjWgQ1NcFi3I+87vlmP6Ml1mkim1OuV7bN
	 L7Kofht43Gl7WtZzaY4Spso5ZsmdE4H/QdbD6eKiBVNlp/JK8rJahAdk4pCB2PoDJh
	 w9OUk9Vn+5PFw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Frederic Weisbecker" <frederic@kernel.org>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 13/13] rust: hrtimer: add maintainer entry
In-Reply-To: <87h64feop6.ffs@tglx> (Thomas Gleixner's message of "Thu, 27 Feb
	2025 10:12:21 +0100")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-13-5bd3bf0ce6cc@kernel.org>
	<Z7yT5XU5gAm0ZCZD@Mac.home> <Z78-mVAHdSq1zbJr@localhost.localdomain>
	<Q3CmP7SuqFgOrxKxEhLa2kgf9P2nPp7II7U920gO4m_GYMmuinS4CFyVVqlG5T9IVPe5rILxVIncOaSM47u5cA==@protonmail.internalid>
	<87h64feop6.ffs@tglx>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 27 Feb 2025 11:45:28 +0100
Message-ID: <875xkvr7hz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Thomas Gleixner" <tglx@linutronix.de> writes:

> On Wed, Feb 26 2025 at 17:17, Frederic Weisbecker wrote:
>> Le Mon, Feb 24, 2025 at 07:44:37AM -0800, Boqun Feng a =C3=A9crit :
>>> On Mon, Feb 24, 2025 at 01:03:47PM +0100, Andreas Hindborg wrote:
>>> > Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. A=
lso
>>> > add Boqun Feng as reviewer.
>>> >
>>> > Acked-by: Boqun Feng <boqun.feng@gmail.com>
>>> > Acked-by: Frederic Weisbecker <frederic@kernel.org>
>>>
>>> Frederic, since you've reviewed the series, and we certainly need your
>>> expertise here, do you want to be an reviewer in this maintainer entry
>>> (to watch how we are doing maybe ;-))?
>>
>> Yes indeed! Please include me as a reviewer!
>
> Please add Anna-Maria and myself to the reviewers list well.

Will do =F0=9F=91=8D



Best regards,
Andreas Hindborg




