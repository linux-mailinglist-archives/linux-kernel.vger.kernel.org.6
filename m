Return-Path: <linux-kernel+bounces-516578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F4DA37439
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53457A2120
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C7193086;
	Sun, 16 Feb 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Rzb0CxzJ"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EAE1917F0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739709654; cv=none; b=JRvaTmui+T4s6C9Ys3HdRMVfSaxk4ZLcMyLtPw1pUVF8c+vuHIlVnEE3gvzeLXiCTsBmd0R5uMpbl0H2+AySP9hJnjBmP6m9Cy2d9DirQRaXffsKOcDh3clwRH12T4JGy9xwaERaEj11o/uW+Uw4AumwPcEXIS335UH9Yb4GY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739709654; c=relaxed/simple;
	bh=Sc85HGzsFWfaGk/iyYFW84nqwWegZPXqD9lfA1Wbgl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eXk9BIheGirBq9GQBoc/dp0ffK4RpoDwZAHFr8F3g+zqaI/LRW6EkWLbTF6tJZFgud4VbPB8P4pIZrVG1wt8vy0E04DflVhvr+3sAmwYXR/1kEvBXWJ/QBv1raWCzsV9yD9ya7K7+H8PyXcB8ljGaFgAw7shWjm4w9e3YfI50RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Rzb0CxzJ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 60D4C240028
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 13:40:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739709650; bh=Sc85HGzsFWfaGk/iyYFW84nqwWegZPXqD9lfA1Wbgl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=Rzb0CxzJve8CE/LMVHheOE4GraSzgepj/E2ebT0GYsSIZVVTcdCi7b0wbSudZxR1a
	 qA0LDn0ZXcu8pvVFj2Ew8MSY9XTE/3W3bMDad1RWiNYvzw6C3dV1PlEXKJAvDljrEp
	 z1fgcf42F0nr/JMso5utMo1wevL2ZlPXSzGzzutMrvhLaBcWZiM3mBpA4VOXg7sUEu
	 UpFFSabVH/Pkj4sKF8SKJFTg6JYZ1uTncFduumBS6gBQZHXslNzJjFgBO9+GLvgLWO
	 wos7+ASA7DNPCyqSkD7gWCOzAVWNLA4T/ONXJ3jDp7plszo/fHhRXaFBsszi6hU10Y
	 RonxCxr+2tclw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ywlkl1pHmz6tvq;
	Sun, 16 Feb 2025 13:40:47 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Miguel Ojeda
 <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
 <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Nathan Chancellor <nathan@kernel.org>,  Nick Desaulniers
 <ndesaulniers@google.com>,  Bill Wendling <morbo@google.com>,  Justin
 Stitt <justinstitt@google.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org,  llvm@lists.linux.dev
Subject: Re: [PATCH] rust: fix clippy::too-long-first-doc-paragraph
In-Reply-To: <10690211-eb3b-4b95-8d9d-35c62930d924@proton.me>
References: <20250215223106.2346285-1-benno.lossin@proton.me>
	<m21pvy927w.fsf@posteo.net>
	<10690211-eb3b-4b95-8d9d-35c62930d924@proton.me>
Date: Sun, 16 Feb 2025 12:40:46 +0000
Message-ID: <m2v7ta6p0x.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> On 16.02.25 01:12, Charalampos Mitrodimas wrote:
>> Benno Lossin <benno.lossin@proton.me> writes:
>> 
[..snip..]
>> Hi,
>> 
>> I cannot reproduce this as-is, but adding
>> "-Wclippy::too_long_first_doc_paragraph" to the "rust_common_flags" in
>> the Makefile reproduces it. Maybe try adding it there in your patch?
>
> I have done some more digging and bisected my Rust version. It turns out
> I was on a rather old nightly from last September. I also don't get the
> error on a newer compiler version. My bisection identified that the
> error last occurs in nightly 2024-10-18, so from 2024-10-19 onwards it
> compiles without the error.
> So probably `-Wclippy::all` implied the `too_long_first_doc_paragraph`
> lint in that version. That is probably because of [1]. It changes the
> lint from style to nursery.
>
> [1]: https://github.com/rust-lang/rust-clippy/pull/13551
>
> So we don't need this patch, as it seems this never hit stable. However,
> there is already a patch fixing what this lint reports: 2f390cc58943
> ("rust: provide proper code documentation titles").
>
> I think it's a good lint, so maybe we should turn it on?

Given the critical importance of readable documentation, I agree.

>
> ---
> Cheers,
> Benno

