Return-Path: <linux-kernel+bounces-420552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B699D7C46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1578AB22D22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A265C18787F;
	Mon, 25 Nov 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKxiygkJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996116631C;
	Mon, 25 Nov 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521498; cv=none; b=nL/osyFc0BG1A09FfIj44lnclIfjveZyPyZk++iuXH+lj/QxlETg5/vPadMZUlQPKXQrjHc+FkmTc+zI74k4P34pT7KRGuAoE8VUbhwKDAntvgbEDW6Ac/HbJ4MXrthD/IVJmLClzi6I12cDZgWvRZySR2rFvbMW18YsD6PVcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521498; c=relaxed/simple;
	bh=Y0UArdCUCqp1jXWTuN8I++4DqpKkqwf/0IT9xVTiTMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NFYCjDbsHNO4tydfauWPZ4MXkF8JXVu5nBZ/qSvRPTv+8y7z2e8gKe/FVADuVCHQ2ksVlV21cNQZEVIVvkxlJxnwT9VyAK4vBwEeG9iuHwr7IiShLaxtCXBKLVSeY72pZqj7tYLknMaWV4XHzTEFLT45CAp36P3GeR/qloC87AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKxiygkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A4DC4CECE;
	Mon, 25 Nov 2024 07:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732521497;
	bh=Y0UArdCUCqp1jXWTuN8I++4DqpKkqwf/0IT9xVTiTMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IKxiygkJT3a+ZOguem8SB/mP8JTzLGsoxm/mspn+AmiHm5UQg0nmASr/gP8XEWiV7
	 pd/a3L+pB1oY4KfKDwQ3Nz2uONB5cJk5/vvKO7nSgfXGo2WsRVVdX2OO0XIFIskNk5
	 Dqc6TvEEiuz7O5bRDtnUs3Aqb7zX51mGlCwEE2qfBbpSqz584ORhxMR024kacjFPx/
	 Ul+GF4H//n4gBodlcFqxSQtlammembHOlEsenx/+7xQehkgDpNDsOdSbInXvXVEt78
	 jXuuFDlZV3VFfXJf+/vkfdQ2Us0jqV/QlrWBzP63SVvI+FSfKj/0P7BeVOtzrSjOix
	 FvQBvi3ZFPPEg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 0/2] rust: xarray: Add a minimal abstraction for XArray
In-Reply-To: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
	(Tamir Duberstein's message of "Wed, 20 Nov 2024 06:48:16 -0500")
References: <8afOg1gqssfIosuFD71f-eCLAHFSeGtzFU9qi-FzHX2T8kEkLMkk56HrWwUfVxoMCo8UlbKPaxjcJoixKhT8_g==@protonmail.internalid>
	<20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
Date: Mon, 25 Nov 2024 08:58:07 +0100
Message-ID: <87iksb3fu8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Tamir,

"Tamir Duberstein" <tamird@gmail.com> writes:

> This is a reimagining relative to earlier versions[0] by Asahi Lina and
> Ma=C3=ADra Canal.
>
> It is needed to support rust-binder, though this version only provides
> enough machinery to support rnull.
>
> Link: https://lore.kernel.org/rust-for-linux/20240309235927.168915-2-mcan=
al@igalia.com/ [0]

Thanks for picking this up!

I am having some trouble with my benchmark system. When it comes back
online, I'll run the `rnull` suite with these patches.

Sorry for the delay.


Best regards,
Andreas Hindborg



