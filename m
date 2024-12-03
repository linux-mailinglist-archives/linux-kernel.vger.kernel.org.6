Return-Path: <linux-kernel+bounces-429425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D9C9E1BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36530280E88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C791E571C;
	Tue,  3 Dec 2024 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgmsyFS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3621DA0F5;
	Tue,  3 Dec 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228188; cv=none; b=KY3J1baDku8DE5oT6b8vIDiMHlAnAoDVJzt64Xdl/1OTTSgsg2De1t+vvt0i5uQtvK6GkmRD63H8Q6xQAQYZGcfP0ic0oJLI7jTJ2o/eCoiHZ2DwkADudN5z4jcBu6A7oPMuXbdgnmGenjcgAMekHVbCtmZZXeOu2Hx2g4T0UP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228188; c=relaxed/simple;
	bh=isUlziUUDm8p6l2GSvo3LsW2yH5N/hjfEDCKC/qlAYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rgNiJ+JJ5RHvH2JdFUyV0u3I2cIRiDueC1Mj447rDyrrQukOQnKZPQKFVL8JES9P92Af4Q/A956ZopQbqUurC8opDBTCdfwGitAImbfiFzHhYs5k+6g0zLwarkk3pvdrEysXv+ZfpbhxddJu1BtzRs31x3OpDzQDeDqGTDFhwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgmsyFS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB333C4CECF;
	Tue,  3 Dec 2024 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733228187;
	bh=isUlziUUDm8p6l2GSvo3LsW2yH5N/hjfEDCKC/qlAYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JgmsyFS3MdyM9dfoTKN28z/Dzc/l3v370iyp84EuG6+9i2nbvFuZXvU7srL+x0zKk
	 qKnNQkZKEr4AxFOf0ewY/2uxnPflKJYG5QV/TFBiRx3j2y4Q3ya93LHetGdkX2wwxT
	 fAYruFfSqzi4nx1UY1hINsocTHfUSdX2rvcfgArHT66hDEw68dwa3dBkt5IsVpu0Ql
	 vDDKSsy+ogaxFmGr8K9JKzON1kyR+hDmz5iXmEZzwxzZkVYdHbZg0cAdI6k72unSZF
	 nFmZQZZ3LEhCH2PgPnBej/WjU2x4EIHLpEsxCOfxmhk2Q0SGIyGDpLKDF5TU5rkiYZ
	 HzM1M+S8lxVug==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/2] rust: xarray: Add an abstraction for XArray
In-Reply-To: <20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com>
	(Tamir Duberstein's message of "Wed, 20 Nov 2024 06:48:18 -0500")
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
	<6-QAwX1sgFm2t2PaGbx9Vw6zd35JfTSAuPp7yhzHZwErXXnBaRrz2lr-ACxVU1VnDQdEuDeN8Lv1PZjT6b13UQ==@protonmail.internalid>
	<20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com>
Date: Tue, 03 Dec 2024 13:16:15 +0100
Message-ID: <87h67lezcg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> `XArray` is an efficient sparse array of pointers. Add a Rust
> abstraction for this type.
>
> This implementation bounds the element type on `ForeignOwnable` and
> requires explicit locking for all operations. Future work may leverage
> RCU to enable lockless operation.
>
> Inspired-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Inspired-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

[cut]

> +
> +// SAFETY: It is safe to send `XArray<T>` to another thread when the und=
erlying `T` is `Send`
> +// because XArray is thread-safe and all mutation operations are synchro=
nized.
> +unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
> +
> +// SAFETY: It is safe to send `&XArray<T>` to another thread when the un=
derlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` =
is `Sync`). Additionally,
> +// `T` is `Send` because XArray is thread-safe and all mutation operatio=
ns are internally locked.
> +unsafe impl<T: ForeignOwnable + Send + Sync> Sync for XArray<T> {}

I don't understand the sentence: "Additionally, `T` is `Send` because XArra=
y is
 thread-safe and all mutation operations are internally locked.", could
 you elaborate?


Best regards,
Andreas Hindborg



