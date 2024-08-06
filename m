Return-Path: <linux-kernel+bounces-275897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD7948BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48061B220B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E01BD501;
	Tue,  6 Aug 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kpmE/bSY"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB213A884
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934296; cv=none; b=a5aLbUh/OaDFxH7vZ3UwTZmL3miMnNV8i1txCgvc+NGfYmCrxZmuK8msrCcdz1PAHJ3XHqz6a+LWQS+gMOAhSxdmmF6+YdU7h+kZuR1unRwWxEFfqoTuyHhw0jzR1t1cIXbsPG7w2owp8R5tMJec6iboB3L4bzT7ufsbL9mfKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934296; c=relaxed/simple;
	bh=cY6OkhPHtRz9xJlrr0Wk6/Mc37QiDA311dyNNdaGZWw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPnQ2Ji9R019EuJ7KEG9vf5Fa+dc1nLLv3s7ReGBgeEE+yoZRaMrc33oVW48e0HDlbWJrjZZ9QZp6DtPcIskvYZslv/p/i7rS/a6xKeeXxqE7D3EFa/+j7iKFFO6tcW9dSG0A7xUzPe7nkO+t+xGygVmfwuxsQUYwa+9EH21NAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kpmE/bSY; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722934292; x=1723193492;
	bh=cY6OkhPHtRz9xJlrr0Wk6/Mc37QiDA311dyNNdaGZWw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kpmE/bSYoVk1y2RaJkOqP0KesYwT5nPkyLy8+M0jQvITAh7buX5AZQO1GprP4bDLq
	 nTFJ6nF3OWOpWWT3d43yA3zb4K+32dCK3P0o5tGMkX6cmhmgiXBuOEEpuGCBebcf6d
	 gNlRMh0QVyJzYVpPRhotIVhe87BCO0X26ER639EvwIQlM8mxRd0KDmpx2n2DI58Y6f
	 LHPHSpQxGv0Zpp6hNj7bcvkI1/lhl4XxtV6obLnzy0dAe7OwrGRIJ5Cuf12hTiR51o
	 InXSSaF9MIKqdMbqaqoAj1JItWzeV3u4KKhhpsVyLNzGjmCTo1TAnwAdrW8cBRj7Su
	 ttyZuHaPdul+Q==
Date: Tue, 06 Aug 2024 08:51:27 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] rust: rbtree: add red-black tree implementation backed by the C version
Message-ID: <b25537d5-97ae-4ff1-9408-2a1c13ae9585@proton.me>
In-Reply-To: <CAH5fLgjHzYJAeZBA7JjK0_dw_m_XL+gU9x6M4Jv0tRzAH40+Pg@mail.gmail.com>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com> <20240727-b4-rbtree-v8-2-951600ada434@google.com> <242d0107-8e2b-4856-8f4c-1d5351fdaad8@proton.me> <CAH5fLgjHzYJAeZBA7JjK0_dw_m_XL+gU9x6M4Jv0tRzAH40+Pg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8c4ff7885984f2caa92e83d84d71dd7d0d6b35b1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 10:41, Alice Ryhl wrote:
> On Mon, Aug 5, 2024 at 9:02=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>> Otherwise the patch looks good.
>=20
> Will you give a Reviewed-by conditional on the above changes?

Yes.

---
Cheers,
Benno


