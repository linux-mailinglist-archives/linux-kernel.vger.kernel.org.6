Return-Path: <linux-kernel+bounces-547164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 638BBA503AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BE2188D949
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400EE2505A2;
	Wed,  5 Mar 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4oicCP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931824EF93;
	Wed,  5 Mar 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189333; cv=none; b=WpZb2g0S3ay0wdD8iC75RyRWUNoK0RSkkdlmbyJJuJub7FsuGevPerv+2cD49y7FWmn+swjbFDKDQFVxiBjT079hE4sEcs8HYtOOel6EB9MIbWrFx4i8u6zxmCsQDCQSazfPGRi+q13ehN68v4dNOArquCXRPqOuBMBZGhElW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189333; c=relaxed/simple;
	bh=GV0POKBYq6XpSVq4vtuiEasCaCiS11ueIrBMGchVxrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oe464pkxWmGYZ/QGuXb+QeDd0Wa6Mle06noRI3OeJNRWS4G6aFqw5n/uhgrxVTo1F/KOl9HVo5b8y4QOX66gHwm2MkzQc8gw+4xWNCA5Bx3xuvbtgJCBD1vXHWsd4sZmf2vBIM1tdzA0nJvyqkcj6WNqIccfXuJ4ufYVcvFl6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4oicCP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BB3C4CED1;
	Wed,  5 Mar 2025 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741189333;
	bh=GV0POKBYq6XpSVq4vtuiEasCaCiS11ueIrBMGchVxrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y4oicCP34B8XiymmLw18DDxxj2sW4bnsER1ScpQTQUh3uju0DB/kSLutDKpXq4Bm9
	 XfK2TDytpfGwtUbSUbiFBNtzWNDSzQbwOaXC86lmQ0gjLdLwMw5ul8JlbcZpbzzly/
	 pKYa2Rqxyr6wwZi1WeaejZ3lJyfCVlKqa6btqUHooAJApYOaPKZnr/OBmZWJDL2xlF
	 bH8kBcme2Lm5CfA+fxPnvpxkz04D7kYMxoaqgZIo9a1lqCQuuLMg962B3QRids2Lym
	 j1x4QIMQiKdRzgyjnSC/j/aBN8r+y/f6Eacrrknclvg+4xW0qMspLa+uf7YOgk6hUs
	 IahZTQk+3I1rw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Oliver Mangold" <oliver.mangold@pm.me>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
In-Reply-To: <CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
 (Alice
	Ryhl's message of "Wed, 05 Mar 2025 16:13:59 +0100")
References: <20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me>
	<Z8hUIPtE_9P60fAf@google.com> <Z8hmCkeZGPwc5MuU@mango>
	<mE_To6ll96gFJQD9YKkT-mwa2KCHFCgOaZFxxczeDVJd0hr1rZCKFHD-vHQfm6deCjlUJIu4U-reNMtrwfyT7w==@protonmail.internalid>
	<CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 16:42:04 +0100
Message-ID: <87frjr8oxf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Mar 5, 2025 at 3:56=E2=80=AFPM Oliver Mangold <oliver.mangold@pm.=
me> wrote:
>>

[...]

>
> What is the use-case for these abstractions?

Missed this Q. It is for asserting uniqueness of a reference to a block
layer request [1].


Best regards,
Andreas Hindborg



[1] https://github.com/metaspace/linux/blob/44dd1c6eff584475f13e2a73eb4ad25=
df17d0d55/rust/kernel/block/mq/request.rs#L406



