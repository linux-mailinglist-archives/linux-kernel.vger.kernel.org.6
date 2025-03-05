Return-Path: <linux-kernel+bounces-546632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05AA4FD14
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3C43AA46A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3CE232392;
	Wed,  5 Mar 2025 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="O0SiKX++"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53B1F63F0;
	Wed,  5 Mar 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172604; cv=none; b=DIW4Kn9CGufckBgiOV624XpWWO5NPr83BBqANhMRQMyn3v9VnTwcoiD3BAjuS4LHcTRq3AbMrA+q0Bq9c5ly9qrxlHEbHKycUmNaaXblmJYGJYvaDsR8oSueSG4l/4iWuV/xXng7//j4MDZde0I3gcj54Wn9P5Z2CjAi2Wt+1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172604; c=relaxed/simple;
	bh=OZ46ynppKxTqP5Nv9R7SbLqE97iWRgo6BATZZbJ5iP4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4LbJH0Tpyc2uXp4TOGLIN9q79RJeBnZC3h2yNSFNHDq6MOoXhe8ArwZ93D29hDqaJWqNWa+YuGIfrJe3/FZ8lwD4S3lCJycAAI3Ad56T8thRw8JTgz+UDmupEBRCXt68Wif6TaYkaLsXvvTxn8QyDeri0b4DXggx5YNXnaIy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=O0SiKX++; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=hrjhzq6vkzc2bn7yrbkgmgfb4e.protonmail; t=1741172600; x=1741431800;
	bh=OZ46ynppKxTqP5Nv9R7SbLqE97iWRgo6BATZZbJ5iP4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=O0SiKX++8Qm/x5Jq+LjoY2GHqvb7h7pwAhS0XHZ0UAVWaK5MwC8+/8j1pTRNf1/xQ
	 fTsJfBNSmWsyVSLvaTZvexYEOoKUiSFhut6QtWYdMol/cEWZuh/JqHpjArFtPfeolg
	 l4ZVE3ySp18qaf07aeCbYcHPqt21DJrOIGPsB6GdkNXfkAFcqlbl+GDDhOu6DwxcHp
	 dYDeou3UdE5UlxsTNJTAdqg0qXLKHWfSP95pOILuXayxWRQIb7fz/9GoucdI7gA+1U
	 qenmtxb6KAEI5AE6YDwqw9klK/iAjOne8ZVzrjNm2I+tyDgDkjcl3FtbkmhK+Lmydn
	 SujcpIx4SuHEw==
Date: Wed, 05 Mar 2025 11:03:14 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 03/22] rust: add extensions to the pin-init crate and move relevant documentation there
Message-ID: <D88A66HC772Y.3SKD6JTURFLUZ@proton.me>
In-Reply-To: <87eczbg7vf.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <WfFbEdgY77_F8Av10-sYEt67FhgZBBdxKadOSC-iOzAoK2YvI9JSuaOBybuOyZT-nzpRubp2llVQcXbmE_Ffow==@protonmail.internalid> <20250304225245.2033120-4-benno.lossin@proton.me> <87eczbg7vf.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e10f1a76ab060a99ff84e415ed237ee69c295140
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 10:11 AM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> In preparation of splitting off the pin-init crate from the kernel
>> crate, move all kernel-specific documentation from pin-init back into
>> the kernel crate.
>
> This patch **moves** very few lines. The additions to init.rs seem
> either copied or new additions.

Yes git's `--color-moved` only shows a few moved lines, but all
documentation lines that are removed from `rust/pin-init/src/lib.rs` are
added into `init.rs`. The example is "new", as it is copied from the
user-space version [1]. I can update the commit message with more
information.=20

[1]: https://github.com/Rust-for-Linux/pin-init/blob/main/src/lib.rs#L160

---
Cheers,
Benno


