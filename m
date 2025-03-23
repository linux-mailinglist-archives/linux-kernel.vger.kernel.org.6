Return-Path: <linux-kernel+bounces-572788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B30A6CEB9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5661416F3E5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D7203714;
	Sun, 23 Mar 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NKBcmdpb"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D2273FD
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725964; cv=none; b=GmaCj37Lw6l3tX7K+0ZJ/5q84W/0Y2n3cdIwSbqFhWMlJYz0i6A7LC0cBvmaN12OxnUWwS5aAO5JhaMhzrIgT4aw69xUSRMFjxK+dXjragjya8/hkEBLskdNDEaCLqDbAoulHG4VNJX/bRdlTFdft+4TfD6twvSzuzUi4nbI9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725964; c=relaxed/simple;
	bh=6l2eQCSW3JNYIBYkHrSb3EFJN8alvjO6wGejc8D1AqI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MgEKbBROMoSuLvWjodz68IfQBaB84OdBMjEftzHhsmCF+o3HOZXNUcYNawVoHfPQ8ityBjnFH/Tjy95JWN1/o8x/dThSkUeJ+foUdtWxQMAXFZZBsQJC9c2BWIVkxzBkpKd6NfxUHht/agpoPF/Skn2opi5fFVl3DidtC/qISik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NKBcmdpb; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742725958; x=1742985158;
	bh=rEFExDG0DgUmP8S1Fyzj6/pKJXTe3E+Sz6RF5IpWpsQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=NKBcmdpb6OoAOBWfB3nWSjf4HGihO1PkHgufLY08//j4JYa0SK2KCZkS6FAc0h1ZX
	 i06i3S7zC81uIv2HXTjFQAP223hXaVe/VtZJ6KUKEMUXCT1L1IKRutYzoaggZh2WP9
	 NOiHiMJfGap7nEPKoEljFWr/GeUtwAxFdS+PwBMZtfz1Uhpyip8TzAtORWXFxrYL49
	 LD2byOr4jtxlLJKOMXKZt55W2up0V/GpoIfk/Au+FNpmYArBmwS+p6SxTRo5h+MO/t
	 fLbgmfFo3+46U0zC+EOZkAx3WjSMIEOEKrw7gHPOxHw2yJj5qK81a8vln6ch4/izVG
	 efEiCqQLjYBbQ==
Date: Sun, 23 Mar 2025 10:32:31 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/17] rust: task: remove use of `addr_of!` macro
Message-ID: <D8NKSFPTB0OG.3QION5HVGH7CL@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c83f0c40be50c89859a9bca3b25058e5eb809b71
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> The use of `addr_of!` here is unnecessary since its immediately
> dereferenced. The main benefit of `addr_of!` is to avoid intermediate
> field loads without immediate dereferencing, so there's no benefit in
> using it here.
>
> We can achieve the same behavior by directly accessing the
> `group_leader` and `pid` fields, which is more idiomatic.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/task.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


