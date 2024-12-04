Return-Path: <linux-kernel+bounces-431240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF9E9E3B41
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDC1B2FC35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A331BE86E;
	Wed,  4 Dec 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcZ9mY1s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8B01BBBEE;
	Wed,  4 Dec 2024 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318045; cv=none; b=GxpHy5tISQ9mDUeRppYNukwZsTvcm0D7kF57Q+yjQNkTOj/uH4X37b/YJz0uQqpicsh1HhIlzyhGjA5P/LL7k83L98JmZF25ruhCFlZ0RI17Gwm++tY7aMOY3RcxZaeacAX9xm4Rq7ofIkmdcw9j36YUhKpyft9Me/1lpcAD69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318045; c=relaxed/simple;
	bh=/c9ieBp+mfvqCEIAj0gRzcGrDmyscQ21iwqRFMJx20M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kl7sNTLKAQf/NEHlc02+Ep88I9JrfEL/CrWatcNIN1wOPl5wnqYfh7diCeGPFIQ13D/+IDCS+Ia620Ejp1ouJ1hfKP6pSOnxTFIuytJqhMLEf/F2X9nbV/kCujGP9bNerR1aJV13mv2GuOvTZ0TetSHNsjIk/REKtzs27Ihm5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcZ9mY1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9B7C4CED2;
	Wed,  4 Dec 2024 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733318044;
	bh=/c9ieBp+mfvqCEIAj0gRzcGrDmyscQ21iwqRFMJx20M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qcZ9mY1sULYXWAX8IKOBx8AL0CfEL0cwiI5Smbg/7/R7c6F14KAvoTCWKVNVatADp
	 8LWGFdD6njdEKFmkz/uUGNE13dGsgPvNeaZeFgRcZGoH8x9yFch/0SiuPYk3gVN7OX
	 RdMZCP/Pwq2NdMphbwDge9mR13opnqs4hhseV72NryYXDCEsHkDce8KlEPIW9eutlp
	 oFHm0SEpJFw2HHxf/xCugK6Y6DzwuPvTQqjbPc5Clph97clwSp+eL8SrBVf0mQxNwU
	 VMbhKg5CzqzKbbqHSLMnGyECHD3KDxWg3mw9D7Nc86u/Jgi0bzfqcwFoZ0abbWZs+R
	 Ysg5W2lch4Fvg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alistair Francis" <alistair@alistair23.me>
Cc: <linux-kernel@vger.kernel.org>,  <benno.lossin@proton.me>,
  <boqun.feng@gmail.com>,  <me@kloenk.dev>,  <alex.gaynor@gmail.com>,
  <gary@garyguo.net>,  <aliceryhl@google.com>,  <alistair.francis@wdc.com>,
  <bjorn3_gh@protonmail.com>,  <tmgross@umich.edu>,
  <rust-for-linux@vger.kernel.org>,  <ojeda@kernel.org>,
  <alistair23@gmail.com>
Subject: Re: [PATCH v4 00/11] rust: bindings: Auto-generate inline static
 functions
In-Reply-To: <20241114005631.818440-1-alistair@alistair23.me> (Alistair
	Francis's message of "Thu, 14 Nov 2024 10:56:20 +1000")
References: <yZdXTg82eCLGHsaNBfAwwYZTGa63yzxI2YXoaTndUyJzyVN60hPrWoeQoXdrrh2hnRIeugFXvrb3nbq2bpD6Ag==@protonmail.internalid>
	<20241114005631.818440-1-alistair@alistair23.me>
Date: Wed, 04 Dec 2024 14:13:48 +0100
Message-ID: <871pynfv5f.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Alistair,

"Alistair Francis" <alistair@alistair23.me> writes:
>
> This series adds support for bindgen generating wrappers for inline statics and
> then converts the existing helper functions to this new method. This doesn't
> work for C macros, so we can't reamove all of the helper functions, but we
> can remove most.

Are you aware of the helper LTO patches by Gary [1]? Can you tell if
this series will compose with the LTO patches?

Also see this Zulip thread for discussion on the LTO patches [2].


Best regards,
Andreas Hindborg



[1] https://github.com/nbdd0121/linux/tree/thin-lto
[2] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/LTO.20Rust.20modules.20with.20C.20helpers


