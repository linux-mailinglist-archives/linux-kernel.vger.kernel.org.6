Return-Path: <linux-kernel+bounces-564399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AABFA65419
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986FF1716B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778C52451EE;
	Mon, 17 Mar 2025 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YEBVJb+s"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B10243964
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222634; cv=none; b=kEdowB7skxpmtEJqQAb70VuHtdj/cFh2dYYOUkLrnLpLSuK9CiNfknAGvkYjj0MAgh26HO1FSpjeriPoUAqhJx7Iymy3ZBbydIqh6CTkIGR4JjjlGwMqfNI6Mpr5Zk1LdWcPal2F1QTI/uRqXSdXPq0qYoY7EP2GS6wa7dGANCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222634; c=relaxed/simple;
	bh=7I7CHexxafQZbmnSocoE2kA9d9e97I6XrBxCsZuU39E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmUyttMRrlEKRbkQhHiPJsaU9LX4gvPWJLHavxmkq1yWddOa+5HNloLOGk59L8gw0fZYmpKnkeVzdjCudBiZG1lH3K0mqaM4m/vzU3g3wMRXmp6AkXumQI4uMW8hpCYt3LzJiqH2Y1wDl5VJEVFoD+I61Nxr90dO39FnKkHqZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YEBVJb+s; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742222626; x=1742481826;
	bh=7I7CHexxafQZbmnSocoE2kA9d9e97I6XrBxCsZuU39E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YEBVJb+sPqT3eXVpd7R7N8xMRtKQmqHQID1faEqUwTTbAneyghYpuZMc2nCzi4LXJ
	 nHLUul5DJrIVrHTJtBO4FRzGuOs+oDuATja21UefmOEkZYjLxXZwCpMoLniDXOsQ9x
	 WGPa0bajUHobHyLeTy/e5Rbr5i8bAkepy9FIvf/il8O2ZAq18cUswWwflAJMCW4ZGf
	 3ejEGgdkCsmM16V3A1MTB7PVtapZfvYLxNZE+52Qf7oW/rmpdslagPDTbbZze5MVzw
	 yAGlnWRgb0JYc8ytOrsrMRpIb+x0J/+25v2NCZUGUGNy66E0IM9R+WhfilwCgWgG8x
	 gvWVAJUDqCveg==
Date: Mon, 17 Mar 2025 14:43:39 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
Message-ID: <D8IMDF0SXKHY.2Q57PAP87OBQV@proton.me>
In-Reply-To: <CANiq72nZrHzhYztDMQnhuW3hhg3eXtwM+kZMd=3ARbWZTZWe9g@mail.gmail.com>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com> <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com> <D8IGB61NVPBT.1I3IZYPVPIEMU@proton.me> <CANiq72nZrHzhYztDMQnhuW3hhg3eXtwM+kZMd=3ARbWZTZWe9g@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 540012deab8b70ea7deeb137e637df1d7ebf0121
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 11:23 AM CET, Miguel Ojeda wrote:
> On Mon, Mar 17, 2025 at 10:58=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> What if this overflows? Do we always have overflow debugging on when
>> debug assertions are enabled? If yes, then this is fine.
>
> No, they are independent settings.

I see, then this needs to be `checked_add` or some avoid the overflow
some different way.

---
Cheers,
Benno


