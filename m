Return-Path: <linux-kernel+bounces-431280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0799E3B7D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2D1285E41
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B11E3DCF;
	Wed,  4 Dec 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTqDS7VV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291C1DFE15;
	Wed,  4 Dec 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319712; cv=none; b=b/nAVHWVQz0Py4VciLjXH8+Bn8CLHhfyhvmCgZRhFPsgnAEWjZThbb1RJ6MS0BGueGCSFuQarfgNlHFX3byE9gzFU2rMANL34opxu9FG5VIII50GWtO1g3AQI6r3CiUw2oDvCPODb+MbQq5IO0Dj+wVqC0TYD4daCNsA53vpahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319712; c=relaxed/simple;
	bh=8YrSi64SILEzk2L3gzAG7q9pm11+7mhNeKqXUDDxahI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S9sShjKXflMgwyb5VM2vHN5J8mLUv17RFyBcD2eJfe5y+kKx4d//l79MjMQrTW9QKQbvs1MiWFj4c0SO68PB7kg2O5w1CBKFkaLonCbsLVEB1uGrhlgH4B9DG3ooYdh1VyvHz/Yoxysjr2if00vmoeZabhiWPpmQR8hWyziRjoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTqDS7VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CB0C4CED2;
	Wed,  4 Dec 2024 13:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733319711;
	bh=8YrSi64SILEzk2L3gzAG7q9pm11+7mhNeKqXUDDxahI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hTqDS7VVpaRWPd1BV0c9QaY7XdOB+ajT1wweOYxHOO2/7mYdFmKYWpPwudq/4Cb7G
	 6k/zVVJQprfeFuKP/Jols+znDHT8Q1UcehN0Y5R9W1VM+kcbf9D/yDKCzZq1JIFJqd
	 DQZIJkQLzI9IHa+U5tt2kWHRpeSNjIaVhnkIfzENnNvwx12Uja1qM+6xhW02wsh3jc
	 CVafdPbOhK8AfR8YFXMSXRGc0xCTm1eoRQWKOe8v8ILgkvLxBMTXIimZWFBhX0CNAo
	 IiBFua61jkCc3ZBBtYMh9dcTtzdNSQ7atXpqRsZa2HNAvD5WUd8Uvn2qPFrkIDNeBm
	 Ugbx528nA0GRQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Lyude Paul" <lyude@redhat.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Anna-Maria Behnsen" <anna-maria@linutronix.de>,  "Frederic Weisbecker"
 <frederic@kernel.org>,  "Thomas Gleixner" <tglx@linutronix.de>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/13] rust: hrtimer: implement `TimerPointer` for `Arc`
In-Reply-To: <CANiq72mkBufEV43HcZZVKB=1UDxOrpweFxeZJBXt6U0=vPMsdg@mail.gmail.com>
 (Miguel
	Ojeda's message of "Fri, 22 Nov 2024 13:36:25 +0100")
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
	<20241017-hrtimer-v3-v6-12-rc2-v3-4-59a75cbb44da@kernel.org>
	<25I5c2B_KkmqpaLqb6jsZyMd9WMhQbTaIKyUYY5cKa8bvR7--HvRiXJ_5cDiyde31tnivT5_C_5IJ6XvLqCusA==@protonmail.internalid>
	<73814ac7e363af44ae6e410f101feb75e94244ef.camel@redhat.com>
	<874j423p7r.fsf@kernel.org>
	<xSW32IhgoSjRIqCoAHtm1UkO4trcAg7QE1-2cite-wE1dNgIJLtZwnRjMGlSP63MaqOqUjXdmiMcOWhedRz4Yg==@protonmail.internalid>
	<CANiq72mkBufEV43HcZZVKB=1UDxOrpweFxeZJBXt6U0=vPMsdg@mail.gmail.com>
Date: Wed, 04 Dec 2024 14:41:39 +0100
Message-ID: <87wmgfefak.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Wed, Nov 20, 2024 at 4:52=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> No particular reason. It is often easier to rebase things around when
>> they are on their own line.
>>
>> Are there any code guidelines to follow on this?
>
> Not yet -- we have a mixture of styles, though we typically don't go
> to the item-level like in this patch, and instead have done it closer
> to the "Crate" or "Module" styles.

What is the rationale behind this bias? Perhaps we should do a pros/cons
list before settling on a style.

It is arguably easier to merge and rebase when using the `Item` policy.


Best regards,
Andreas Hindborg



