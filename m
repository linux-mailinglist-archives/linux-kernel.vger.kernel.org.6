Return-Path: <linux-kernel+bounces-521827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F6EA3C2D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABAB917AF55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743C1F3B8D;
	Wed, 19 Feb 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz51/1vG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510301E7C23;
	Wed, 19 Feb 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976859; cv=none; b=A7nk+54DHG3HOwSCCATT3PGeaDbyguuo/Rscqvy/8+2/3Ua4kgbB8MyICK5FZ2mBKxZnUmPR98fZydvuyG3BDvW7MgVZoJROdgRD+Re+B/vq+HHfJ0U/6CttxxODrfLMjOK+NnEQQosDlqRYKbW20lfOmA2GSMxG/HITTXl2DSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976859; c=relaxed/simple;
	bh=ePzAI0EZVkG3juq/EiW7UpGx47gYIjwV+1EpqpsAGs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gv0SrT3Mg/OkBtdbl5be9pev4tGv7EQpnDKxG0XmwRFOR2LWLIGpl/meJ3u1rsWTxY7C8vQRkBaIYLGpUAEuH5nuV8RHxu6/QcsiQzP6d6vNgRmzPb9Hspc9hVcVh3DBi4RxdKi/vD1C/KwITsmapF3I3WDFKfAjta2QYtYonNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz51/1vG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E336FC4CED6;
	Wed, 19 Feb 2025 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739976859;
	bh=ePzAI0EZVkG3juq/EiW7UpGx47gYIjwV+1EpqpsAGs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Jz51/1vG6qYTmy5lnSI/vzuhot9lpMUPJMnIUQqpY/DtwKfmEVG/j2xeV53hPM7Lc
	 2A7DStSjZ6Ss+xQhLKkme5gtGfefpTonjGej6NQde7s/otWORqOsugwT14Nd0jxhqW
	 pKW7eO6Fqbud/g5TjsaHSzDmB2FwD+Kr4Sv+gyCW4Z3AlpuAZWAFcgJN6NCPC7nVfP
	 ZIY6QrwXXKvwMZFdpyWEtK6XteOuF4DG2A+VsS7vI/Yen9NfNbHv2vq83QoasxS6nd
	 +rDZbHkT0zEFPiE9Rt+BSUKgxTODk7KEFIUm61R/UwiGjqrd2FvCdXIwboWQBZiH4n
	 YJLOtVcxjFnTQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 01/14] rust: time: Add Ktime::from_ns()
In-Reply-To: <693e39f6-70ac-4752-b371-74a3bd1fcf16@proton.me> (Benno Lossin's
	message of "Wed, 19 Feb 2025 11:58:11 +0000")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-1-48dedb015eb3@kernel.org>
	<pwcv_VHgpKnxTdrx-I-3Nkt-DsC8Q0thWb7mqAtk3L8VuiX5XuVpmWmf_XltyTeDERuNECVpCOwKWMuVXB8RcQ==@protonmail.internalid>
	<693e39f6-70ac-4752-b371-74a3bd1fcf16@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 15:53:40 +0100
Message-ID: <871pvuc7ez.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 18.02.25 14:27, Andreas Hindborg wrote:
>> From: Lyude Paul <lyude@redhat.com>
>>
>> A simple function to turn the provided value in nanoseconds into a Ktime
>> value. We allow any type which implements Into<bindings::ktime_t>, which
>> resolves to Into<i64>.
>>
>> This is useful for some of the older DRM APIs that never got moved to
>> Ktime.
>
> Are these older DRM APIs on the C side, or on the Rust side? If they are
> on the Rust side, we should just move them to Ktime, no?
>
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> This seems wrong considering the `From Lyude Paul` line above :) (or is
> it possible to review your own patch?)
>
> The patch itself looks good, so iff the above question is answered with
> "the older DRM APIs are on the C side" then:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

It occurs to me that I am actually not relying on this patch for this
series any longer, so I will just drop it.


Best regards,
Andreas Hindborg



