Return-Path: <linux-kernel+bounces-405703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B5F9C570C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A218DB44C41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B52E21EBB0;
	Tue, 12 Nov 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhFJpe8u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F921E12B;
	Tue, 12 Nov 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408598; cv=none; b=Z2Gg/pfFLKSr6sz7hDQkmQpfG+UbgoYU3mHWY4AY1RwFafu8jtSHok+EKHtTx2eUswRGQG6HaZWPR9m5vIn6XJwH35jBzFQliH4CsV2igufeXh9KxjVKjoA0fgFyMprc2arJF81c6jdfEQxfVahEZM/66QWI3xOxVohCREHnJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408598; c=relaxed/simple;
	bh=B/bUlKOyUlTKI5Vq3sRcX+JJOx9sQVWitnlmWMDGFsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qGqFuEcwKh1Xy1/ji2SPchzTb3cMQSg1mXwd+W+FH+5EKrWzm8y+K1z4qC9cjm+efBC+HLASyQgVVNcuukdwVv3v9lSit/Q5PX1GBfJvU3ny6MKYIrF5MKMv/QpN6MFDiaeach5yCIp888uFUswIQRuCA2yWPoCZTt+HPFo1zi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhFJpe8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49E8C4CECD;
	Tue, 12 Nov 2024 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731408598;
	bh=B/bUlKOyUlTKI5Vq3sRcX+JJOx9sQVWitnlmWMDGFsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XhFJpe8uaST6D+2FzfQ+USjS3vjqJx0UhnSc571OW+OJ/6jTLeiu2IaXHaJ/5YhmJ
	 wVnO0TY58eGWvEY1298hzRi0TMQMeZBbzvcW68MYK94qIE4hdLaCeJNFY8FGc/dlV1
	 8cbSYdb56iuaIR9QAKijYPkg0iOERrVwZkzbi8pij7Eqjvwnzjbgfzfoz+R8PCn3K9
	 4gqdcU2CpxqzoSKDxfzmHXtnORO1PWDHgXbn1Z70tl4FTJ8G3mKeHmmMOrqvFFw+n2
	 GBKv6LvhRtsLWRmW7rbgCsYsOJV2h1zcp9CZhsKCJci/o5Q6yymqavqKeWwwpAjkm/
	 gOC2D12dbU4jg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/6] rust: reorder `ForeignOwnable` items
In-Reply-To: <20241110-borrow-mut-v4-5-053976068215@gmail.com> (Tamir
	Duberstein's message of "Sun, 10 Nov 2024 09:14:06 -0500")
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
	<SmLmswOjFRt4blVoyuX7Ipu6Sw_74rk2q2SF8TtEPTwQgIDaaDDf9XO5tvIBBr2IshmNuDw3pZp4rmwS5zknag==@protonmail.internalid>
	<20241110-borrow-mut-v4-5-053976068215@gmail.com>
Date: Tue, 12 Nov 2024 11:10:57 +0100
Message-ID: <87wmh8rccu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> `{into,from}_foreign` before `borrow` is slightly more logical.
>
> This removes an inconsistency with `kbox.rs` which already uses this
> ordering.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



