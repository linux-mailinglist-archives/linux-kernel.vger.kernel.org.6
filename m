Return-Path: <linux-kernel+bounces-572799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F9A6CED5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D7516B6B9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBEE2040BA;
	Sun, 23 Mar 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mmTMAgqS"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17174203714
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726396; cv=none; b=XmZyTqClOnazpwYoFhJU0WwAuVV4hOSBeYuWe4HVl6iuelscLB7ZmVNVQ9j55MAGt0DkjlHB8B7gcHzxU0JsCzjpaWef59AfaModv4H0QIgEZkYlTF2L/8NOFJZA+hc1er9MitN1jMY2h48X+3Hl5E71RRGMu3b/RUgVJWf64Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726396; c=relaxed/simple;
	bh=YFSJOefZ1Qpiynuw5+3tVNIJFGm4Y5oQlWcJ+hZ0r98=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ5mFWUIrnrgvmkaikYEUsF5pmKAcyDbLXeb39dCsJFnAkuRJxau6iUGvL/sm7MaUn8osYecMIiqZHA+8PLuSt7CSWa+xcsmf+eXqRHwtycyYAmMBhOCmvDxdtvDPcw+akfMyqjED0fv8PH0nR3K454QSx1bgRvVXBvLS3oW2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mmTMAgqS; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=jqjcjq3wkjex3evlfumwakdk2y.protonmail; t=1742726390; x=1742985590;
	bh=BsOb7GZGLumIAFi422+XDPu7JSfFJHnFf0Wfw4zaLAc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mmTMAgqSo6DhBUtbWMO+IG57W6fpX92BemUtuMi+JOqQ0bn0mtkuPZJNcrPWY6enJ
	 JZs2zkkxqPlWpUQS+nXMAt5Jgb8VWH7dyNpdbCwSrlVnKlyK7YNVOEQSaGQPU0K/0u
	 xTZSOEQmLqV1volflB9bb60xGqmVu0IkQ5N3LnxhIUlLrUR+c3ug83nIr1gZ7/QZaf
	 pSp/0lQ+GnoCElF6jSLD66OXUAMR7IlpiyS/TEe3WuLHxFBf9I56lLeZc+mTCE0RF0
	 ayIzwmIj9m4hub6lGfn1tV1QZH6WF1U47p1ufzezO1LtZdrBo2L+KNLiZwt/1oqFUU
	 spG16CTUqLAmQ==
Date: Sun, 23 Mar 2025 10:39:43 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/17] rust: sync: arc: refactor to use `&raw [const|mut]`
Message-ID: <D8NKXXWW9NGB.8ZWRW8YFB4O5@proton.me>
In-Reply-To: <20250320020740.1631171-14-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-14-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 211d27be077b2f693e987b001a44f9bedcf970f5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of!(place)` with
> `&raw const place`.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const` is similar to `&` making
> it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/sync/arc.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


