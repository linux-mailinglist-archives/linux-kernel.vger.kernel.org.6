Return-Path: <linux-kernel+bounces-546816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C49A4FF08
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A806E7A6F65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6227B245035;
	Wed,  5 Mar 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KGZAABgC"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4D2441A3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179237; cv=none; b=FDxUFpVODyiwbVJptqzJLy2N/EYWRtmzZ2fahN2Lrm7hzy0SVfHXYA2at2UUxgNowsdSCaXvDXgjeamkkEdr5ucjIFRPu3Vdj9y14r60qbPvAONwpfxOfNVjDXevX9mivTyShlwZLoMW43EY1kvBqj/uQ9SBOA84yE8FoLMmfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179237; c=relaxed/simple;
	bh=/rS6gRQY/VsgkXMSNzTqMzQaTosh6vU30saEmFeEWC4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHc1q/A6T6jVq0/+BZZ+y+mVKpl2v3IaKYVso60DitVhOwINnsAxPgMiou0H0jYfZVa7wwURYJEbL4w+NsFCfYUW/lusd+jarT7oCxazg6Ja88gQVxFiftjD4GkCiAsRdN7Rg0NFsYJWAQ6KFWmHMVDqi0xw+18Ri5ZD4coE3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KGZAABgC; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741179233; x=1741438433;
	bh=/rS6gRQY/VsgkXMSNzTqMzQaTosh6vU30saEmFeEWC4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KGZAABgCwk0qEbi4D976ACkMLU+WZZjXbxPkZg6eFdTPWk8J2g0w1/EhFhmpenSe5
	 ifOPYyakooZLIoLAUOwVGsXSI9Qpb/qGsiZnRPGmqtSIx2lmyJtR4GXIZ+YZCYbe68
	 tHSrfIAxOpngjRdvNof8tQkKO6NyaP9IOwam/RajfoZXua9eA0PDoNaYCMntd9H+Ig
	 mMkaC4VMhnJaU3oiusmQBea+fVkM33VpZIVzil+WNL/qcKL/SU5mZtTq+ovGLhl+ca
	 SIGzVikr8JPREgS0UAFs75q+HWucHwibx/EKPei6BTVnKL0W0Pkncn7Zj36b/1+vWh
	 vGKi2s1uKXnhQ==
Date: Wed, 05 Mar 2025 12:53:49 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/22] rust: init: disable doctests
Message-ID: <D88CITPM946W.1O2W73CGF7L6G@proton.me>
In-Reply-To: <87plivg8s7.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <sIa0gEFObIVkQIOds6BkLjVFyVpGcJ70lKQ6CC6zAjpKS4xGB0hcKqo170yhITiDQfjg7s2CigwRoJfJ2fFvmA==@protonmail.internalid> <20250304225245.2033120-2-benno.lossin@proton.me> <87plivg8s7.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0435d923d529c639e90762b5861196e9f3622a1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 9:51 AM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> This is the first commit in a series that splits off the pin-init crate
>> from the kernel crate.
>
> I recently learned that using imperative mode in the commit message is
> preferred [1]. You might want to consider that for next spin.

Thanks for pointing that out, any suggestions for this concrete case? I
wasn't able to come up with an imperative statement.

---
Cheers,
Benno


