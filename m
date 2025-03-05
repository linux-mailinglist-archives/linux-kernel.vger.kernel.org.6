Return-Path: <linux-kernel+bounces-546986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B21A5017D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8A43A819B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3288E24BBEA;
	Wed,  5 Mar 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT9tmiO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A358155751;
	Wed,  5 Mar 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183810; cv=none; b=ayJ8hAxtpn7eepxMd9PJYG5Kq28YH15tQ1/SyOaz5LJ/Zjn1tNGU/g1VGMMK3YK/SJfOhYeOvs3cHEx+e4xU4DZWZ2n2NunmxuoskfDF7oEtoIhiRvfjviiyokOgS8RkUwVqdv7uv/VazBsFzbjixjR4qYquGOtdXE9ty2utjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183810; c=relaxed/simple;
	bh=RGq0CmFE4Teqz4bDzf/ltPZvfasWPuNdUu820Q8P34U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvZkXvSVDyNBpVG082kg35XDLv0w73EpQ23W6RIJukMmCH1w9MFGmMs5Tb55X0hRCfjn0Hz3fGDSfYPBWLs4TCHS99VAQhcHvQjFj2gvz5OtQVfFSsKGWVpBur1VpBJ6Xhgy0KxadDHN6qgIgYexufEyGXCJgV1g4NSWlJuOtNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT9tmiO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9F9C4CED1;
	Wed,  5 Mar 2025 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741183810;
	bh=RGq0CmFE4Teqz4bDzf/ltPZvfasWPuNdUu820Q8P34U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DT9tmiO2/MwfzaejtfX8Sb9tsQypFTjMZOlZaHI1H+oDvaTniACFyDNp4W1A/C/1U
	 t92vqxmiDTpkEW+vNLGf2sYxftRwPczNIeKRhRsR2KJ3S91OWHxwVqxxsrMPPlsa2I
	 viL6PkiHWKOvLeBM9OFbR/AYzEVoajRCQ3r/nrO/jxMwXvyAfIvPNZ1JHFIOSnmTT2
	 PUUBAHfvwhLC45fQ3qaOCBZrEzFbOAderb5O1lk8pRgZoTWC2qgSKim8CRxK0FZvOU
	 cRoPxUqDTT0Ja1toiKCDuppk6x4KxqDnG6a7Iq4Pdt+sVQAo4gyUFfmRVZoOcifbdz
	 GiKgEzS4Yt0mQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/22] rust: init: disable doctests
In-Reply-To: <D88CITPM946W.1O2W73CGF7L6G@proton.me> (Benno Lossin's message of
	"Wed, 05 Mar 2025 12:53:49 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<sIa0gEFObIVkQIOds6BkLjVFyVpGcJ70lKQ6CC6zAjpKS4xGB0hcKqo170yhITiDQfjg7s2CigwRoJfJ2fFvmA==@protonmail.internalid>
	<20250304225245.2033120-2-benno.lossin@proton.me>
	<87plivg8s7.fsf@kernel.org>
	<LACr2ZSOM2qo2DCApO6HPm_ESyWi3a8IxriVkayJJqTsEftAekzbNB1-Jwq2RxlubW_IlnsfB07ylWy_xU_ftw==@protonmail.internalid>
	<D88CITPM946W.1O2W73CGF7L6G@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 15:09:58 +0100
Message-ID: <87h647a7rd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Wed Mar 5, 2025 at 9:51 AM CET, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> This is the first commit in a series that splits off the pin-init crate
>>> from the kernel crate.
>>
>> I recently learned that using imperative mode in the commit message is
>> preferred [1]. You might want to consider that for next spin.
>
> Thanks for pointing that out, any suggestions for this concrete case? I
> wasn't able to come up with an imperative statement.

I would drop the first paragraph entirely, since the subject is 01/22
and the cover letter provides plenty of context.

  The build system cannot handle doctests in the kernel crate in files
  outside of `rust/kernel/`. Subsequent commits will move files out
  of that directory, but will still compile them as part of the kernel
  crate. Thus, ignore all doctests in the to-be-moved files.

  Leave tests disabled until they are separated into their
  own crate and they stop causing breakage.

Not sure if it is better? More robot for sure =F0=9F=A4=96

This part from the original is not correct:?

  since then the doctests of that new crate will be handled as normal
  host doctests.

The build system will not run those tests when they are not in the
kernel crate?


Best regards,
Andreas Hindborg



