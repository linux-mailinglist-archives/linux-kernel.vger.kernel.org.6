Return-Path: <linux-kernel+bounces-392289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8A99B91F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D044E1C2144A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C671A0724;
	Fri,  1 Nov 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO2cGDjr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C519B595;
	Fri,  1 Nov 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467507; cv=none; b=NPFTha6pP8z24PxdCeMeoaSsaAras/Wm+wkQEmPpAu4udSk5jDgplkFA/laAFI5+bdFc/Vkvxivl5NaUTA89Pe0bqGmbk6Uux46faJnrQWK08wzslnTn5yMqFrmeMKSZSKKQ/YFkSsMfa7qIQjOOOZCLfnMxXElUs5pku2nZhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467507; c=relaxed/simple;
	bh=+gWLxkzDFu0men3WpeyM2YQpE+xw02L+EZDYwHbxjY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIvqeNa8FO4Zc6j/Fojps4fXoiIfKSsX/fzXYutFgQkiME7bR6C9qASJcj+VfDgM6Ces23bYK7lCGamW9DQaV0XAQHRBtZQ3g356xaKx3WyO9GK+1jlqOtHzmeDv2LiyStdirkJZSdSbxISH5b8kA9b/YzRzM5xFTVQICn4qz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO2cGDjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE903C4CECD;
	Fri,  1 Nov 2024 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730467506;
	bh=+gWLxkzDFu0men3WpeyM2YQpE+xw02L+EZDYwHbxjY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cO2cGDjryYPxJ6XxWrK+/Z5kbrdHJ8Rh6JiTF6QUmQzdxXaceDflNfrcj9Ukbpq7z
	 L8OAMsrmn5N6j7FDVSV2xQTUcBLZyFk6b2QWMNiTcZtK0GuMI81CtTU7ZtbMkhLf0x
	 uj2pS2GwujxSiIo3z9MiYljklnf86JLCNSJsGuqyu81dT1LPcXEvDbhPi9UjjA16bf
	 wKrbyyrx2R4a74bMalKMKbuWAijZqnSAy3KzmjnX5TDkpB/5lhzZG4TEnDIGDQPm34
	 yQ4SJVGe3D0yDeG/m+3WSLq1kGNRs+9FIMN9rR0X3VQ1qpxOJFlJr4+gFHGdmXMdc3
	 /k+EMmBBjeYUA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] rust: reorder `ForeignOwnable` items
In-Reply-To: <CAJ-ks9mf2H8xZ+uZyeQqiGEDY35tyDBP-UpaqXhe_padv=Dqmg@mail.gmail.com>
 (Tamir
	Duberstein's message of "Thu, 31 Oct 2024 09:30:16 -0400")
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
	<Pn1b5OU4cqz38Aiv4RL7MuzPDwDGvxLVRrLuCF7Q3_HaeLzlh4jaM0krBqB39DCFmRLWK59Do8DPaVxLNaaTNQ==@protonmail.internalid>
	<20241030-borrow-mut-v1-4-8f0ceaf78eaf@gmail.com>
	<871pzwpsm9.fsf@kernel.org>
	<CAJ-ks9m-THyqK1tYL39t979BagBqj3Z-MOSn8wPhDc82awjzug@mail.gmail.com>
	<CANiq72nX2=yigRKhP3jN0kQ8vD0kMvUOp3rFpRQZJGAX6RrRhg@mail.gmail.com>
	<VFlWu_3oX5K_m5UWyd8xyC2ap0ju_5IerlL0EmQ905VcE7VHfpSzx8NeFlUDSWYH2Vnjg3U7d5NdGRj6gYH8yQ==@protonmail.internalid>
	<CAJ-ks9mf2H8xZ+uZyeQqiGEDY35tyDBP-UpaqXhe_padv=Dqmg@mail.gmail.com>
Date: Fri, 01 Nov 2024 14:24:49 +0100
Message-ID: <874j4rnl26.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Thu, Oct 31, 2024 at 8:40=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> On Thu, Oct 31, 2024 at 1:23=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
>> >
>> > This change was part of the original patch. Do you prefer the code
>> > movement in the same commit?
>>
>> If we do it, please keep it separate, that is a good idea.
>>
>> However, I think Andreas means to avoid the movement at all,
>> regardless of which commit is used to do it.
>
> Understood. I'll update the commit message to explain that this also
> avoids inconsistency with the implementation in kbox.rs, which is
> already in this order.
>
> Andreas, please let me know if this is acceptable.

I would prefer not to move the code, but I am not going to make more
noise about it that this :) I don't care what order these items are, and
so to me it is just noise in the history.


Best regards,
Andreas Hindborg





