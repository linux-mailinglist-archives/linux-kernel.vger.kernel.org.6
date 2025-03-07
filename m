Return-Path: <linux-kernel+bounces-551120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB88A5686D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EAB27A81B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03A221766A;
	Fri,  7 Mar 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Pre9mGPW"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1B1C1F21
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352648; cv=none; b=sT50Bbui0XaW4rGA/Kz4yn1CVO7ryTKpHDqElONs2OXMf5pCbCY7J0LHTFtoK6/yXy9W14Gd0Q3Aebe7g0FvDYUe3Wp2YdKbKZoAqKjeQbdFrQAfyhcSTkTJD8eNtoiHnoeAvwZ4XDnnOQ3AeiztcahezOEJYooNGtGkEzeir9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352648; c=relaxed/simple;
	bh=O3znw3OW7PfvT2i8qnYHvMTfqKEg0jBN/R90NfP1mzg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhhVsErfC07CBu8vL9i8BFXdBZ7LMBYERDixB/plR2hVHH97Zs51VW0L3FkTk0fpNVACELQe8IvbTgFu9C3y4Yc2BGU+MpVwCWc2yi2WEjEtU3/Rwojmn1ncWBAkxsQepGjkYWreKip22XwrBmYYg83XxqdvRZ/xwFaZEsbVtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Pre9mGPW; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741352643; x=1741611843;
	bh=O3znw3OW7PfvT2i8qnYHvMTfqKEg0jBN/R90NfP1mzg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Pre9mGPW6jXzh5kewqv1ghkYS61s4+MJiGm6fYjSo7CfxcKYPyXqNxBjDLQJrUj7m
	 fKrIYI+Qf2rfiu8EnbKkHjK7aY28ZT4CfafEhXnbvt/kTfMJ49YAHUVDTJwTy5kBC+
	 dUOEiTSY+cEEO+3IozcS/HJSK6UHGwo8QG/T8uNn+YZlwM1VLZDUqhCkI1aTNcJwyA
	 z3EyTJ3hhm3T/8IbQJ/QaCuh+EICCyecCfjp+o3a1v8fszmiadRJbTigKlQDbIeOfg
	 SjsKFh2tqWt9Od9IDujsBbewYakoaWWQ3ktTDOjqEHJOpBfEpERBdUN5pf6Bu2qj2Y
	 Zq7FR95U1YEkQ==
Date: Fri, 07 Mar 2025 13:03:56 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 04/13] rust: hrtimer: allow timer restart from timer handler
Message-ID: <D8A1ZMOY432V.2L7MRU9C1OU5K@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-4-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-4-0cf7e9491da4@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: aeefb518fd1d19f06e6cd8491e3ddb433fb5eaba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
> Allow timer handlers to report that they want a timer to be restarted aft=
er
> the timer handler has finished executing.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


