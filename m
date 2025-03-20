Return-Path: <linux-kernel+bounces-569832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD28FA6A834
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47BE19C16FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB62222B5;
	Thu, 20 Mar 2025 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DJoc/lWo"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7261DED7C;
	Thu, 20 Mar 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479857; cv=none; b=LaqFDpqAvTlZ6OLQH8cF8EXumWhmzmm0fHLRAxEFZMGEoOCGubpOYOUkLAgxUx43a4vOhVzPHPl151NFQ0qQObonoMTgw7sXlwZmXilFfWVMMJGWR/pdtFfOC6IGlrFNBvfAbbx+BUIttyIr5uYRpT5MZKF1Zk6idVqo2F5kZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479857; c=relaxed/simple;
	bh=Kt14O2cfoN2G/GyFj9ojaCiqMAko5fuIIc4n4UzkX1M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmUTxOeYTD4hGSktrpdywFi5ONTt4kJictRypc8KKsD0vJB3lMaSt0XReNOusl2ROeTd8n/f0i14Fv2zgmiJ4xOWE/8WS0Qrq8vahBsDRpPem2TfY0G1ymtblx2cyuI5Vow0F6GWz7XAvrbZ417lFEjYbk6m1zefcqK4xoMi6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DJoc/lWo; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6ss77oerjbcj5jnmufyhvcw7ym.protonmail; t=1742479853; x=1742739053;
	bh=Kt14O2cfoN2G/GyFj9ojaCiqMAko5fuIIc4n4UzkX1M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DJoc/lWoVAAtnAcnNFS/cuxr7eWAo3XRLqDxJNMMo/fBFfLs2Iy5l3EwEm7shyHXB
	 D8EcopN13gVgM3+PYx4ZZPzN1kG1XseeW94L+2De1lZyOrNCoQ1E0qWwC1OwM+B03v
	 K7wSiBisfkFkT7TQMLeMRezty8imIt4MT975OelaarykV6sZbrzVXh2riSeQAo0thB
	 vivjXFC6PuICVw3xU0vdZulyIYszvsThnDepio/uE9UWPkKvwqGMJhSKut5yfw7G+h
	 lqMaP1ni06FPgihu3zN7BNm4VAeBo+tFzmh9/ZoU9Mz/Y8+2nNEnC7SLN3YfXHU9pl
	 iM4sd7fsQpf4A==
Date: Thu, 20 Mar 2025 14:10:47 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: pin_init_internal: fix rust-analyzer `mod quote`
Message-ID: <D8L5JXRXHX0N.UIFZ5M15FB3S@proton.me>
In-Reply-To: <CAJ-ks9nTmno12ZC4DnLxV_b0NLUK5Kn5K+cRi4BEvKtveQzJjg@mail.gmail.com>
References: <20250319-pin-init-internal-quote-v1-1-19de6a33a257@gmail.com> <D8L34IUZGXWX.D2LSS2S2NAN7@proton.me> <CAJ-ks9nTmno12ZC4DnLxV_b0NLUK5Kn5K+cRi4BEvKtveQzJjg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0c0d3ef6d055f74376746995de674f0b1f0aae08
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 2:31 PM CET, Tamir Duberstein wrote:
> On Thu, Mar 20, 2025 at 8:16=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> I'd rather not have this change, since this will introduce a dangling
>> symlink upstream [1].
>>
>> [1]: https://github.com/rust-for-Linux/pin-init
>
> I agree it's aesthetically displeasing. I'm not aware of any
> alternative that fixes the development workflow of this crate in the
> kernel.

I don't think it's too bad, and this code is going away soon-ish
anyways.

---
Cheers,
Benno


