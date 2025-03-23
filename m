Return-Path: <linux-kernel+bounces-572783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C9BA6CEB2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F0316EDE4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD587203714;
	Sun, 23 Mar 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="a8DtxVst"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE420127A;
	Sun, 23 Mar 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725792; cv=none; b=FPxuV3lcuPK84+nskB8VQ6UQFCBuzMPcveDrmjJrxMAR2Wo/84hOs+oM9YoV2BI/QwlpmhauzNWb6gVk78cTX+ozIXIWViVfCjhBNPHUMJ8oCyQclyE1dfNkENvQBnuhdiwIsRjim18OSZ0BkkFrUOjgng2pJmEa2LkyukHRf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725792; c=relaxed/simple;
	bh=fPBM9ITvuM7lirHi1AJ+7gCaDuDnmt3ZpcGmkE5puZE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tylpoWExLw+TlP1BEiPtIcYzPJGZJbINdyS0Btd32nqx2lk2WneG5fsO3X4g4NSCqiEz5HRBQ44ex01kvUbsGmWsux+JK8PM2D+zpSrOxFyr0/riOjX9dtM00IBol/roVP9FRi+R7iTUzmRY4oHayVskULpMqVWeSXm2h7QMDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=a8DtxVst; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742725788; x=1742984988;
	bh=l+ASOZcM9HRgZ+nz5pIJnzRypkL94hqWNP9RHmPuWTg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=a8DtxVstiodhLlvooPtOArISro8h+o92/a0NMBGFBqo135ZJ3flUcM2FHDNiygxOK
	 YzoLm+CpxEQOC8NlJrsRXgWOc0et5OXSeP+mxOPcHrCmic1PiTzb//YAhG46Ewq9G9
	 fKStdc+2jpbfrOpjK1ir1TgVxHQiSb84zT1nx9BOnknt5FNAjV+JFOWSaz0GS3lyyv
	 Fl4ggyv/cEyQlwlwZgrnAc6P7peK4+QyISn9eD0F6VXb90ecUTA0PfZgiqU5W0Eo8g
	 MOmvRAO06uJ34ItUF27hL5IaEp21SNpt2NQvrZsRyc9A3S9E4ZXTf5nwOHXhl9/ub0
	 EKDmdnIFTDLnA==
Date: Sun, 23 Mar 2025 10:29:42 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/17] rust: init: refactor to use `&raw [const|mut]`
Message-ID: <D8NKQ9JVRZ0Q.3URGSAFN5MHCN@proton.me>
In-Reply-To: <20250320020740.1631171-3-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-3-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 43106bd6fd4e617b4b99b0cac304b9f6f2e8fe96
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of_mut!(place)`
> with `&raw mut place`.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw mut` is similar to `&mut`
> making it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> ---
>  rust/kernel/init.rs        |  8 ++++----
>  rust/kernel/init/macros.rs | 28 ++++++++++++++--------------
>  2 files changed, 18 insertions(+), 18 deletions(-)

These files have been moved in rust-next, so if you send a new
version, it would be great if you could also rebase onto rust-next.

---
Cheers,
Benno


