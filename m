Return-Path: <linux-kernel+bounces-445181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359559F125D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4632B16AABE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F301E22FC;
	Fri, 13 Dec 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBQuaRs+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06D15573A;
	Fri, 13 Dec 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108002; cv=none; b=WT7GDLVLoy3rRXKfC8I0ldha8wR8bpW4iN4+qqLY/QCn9Bu9rdekR0O1slOWTt1ju+3JZoCEol3eaEQu4REiloLBtZco2P7KrkqcXwwB13TXi3eujrZWrwd/opQFw8tQilQDtZ/J5lzl421lUFxARyPDwx0TZOkmu/fLM4KGDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108002; c=relaxed/simple;
	bh=sjqCMbMJc98MevvBnx5a00VZZWLis91KiqX5KkIFSWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fDztGXFC2URvoQigpD8z3urhVzvaRksQn5q1jnmNGaKE/uZy9JbKIbTqCbQeAErH9Gee1suixn0HtzBnbxP9a9ANiXniKl12IMJ6Zf7FTspfrwlvbQAvIJ0Kb15bPRBSXA+LnTAIqL/3CFlc0YxvSVWYu5RVcQVOEvCsxmKcD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBQuaRs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C026C4CED0;
	Fri, 13 Dec 2024 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734108001;
	bh=sjqCMbMJc98MevvBnx5a00VZZWLis91KiqX5KkIFSWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XBQuaRs+fnbfszjUfkl5I/oxgRtN2Y2P2Iww6E7kpEXRNhkK8N0ZDlE/nty6FaxzM
	 g2nxiy1jlYDnjDmLLZvZNoHItnVz0x9fFoTVdLWkGwx+4KbEKuUbyOKuKwhV9nRDW6
	 JaxRwdphO6DEbhs0Vir9Dhq/xjQR2NzkRPDrZO5w6iYFpu+tEO+78lnyAE8vhLTEO5
	 Aix5gB7T+JDT4nr8ar9Os/88x1nMyfsa5Wnp0cVw1Q0HVd1Ot/n/S3e0bt/gg19Fph
	 o7JB4L55PmfIpKGsUaV30TULP5ewoV0XFAJj6rIPvtVfYtGskVowE2bg/NI8cmhOpT
	 Eqz8CcVz2G2XQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 2/2] rust: xarray: Add an abstraction for XArray
In-Reply-To: <CAJ-ks9mTEcRg6=ZiYFX3ebHSYgMwTv692ufUdTCoA1vX5E1nNg@mail.gmail.com>
 (Tamir
	Duberstein's message of "Fri, 13 Dec 2024 11:24:44 -0500")
References: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
	<20241212-rust-xarray-bindings-v12-2-59ab9b1f4d2e@gmail.com>
	<CAH5fLggwK0LXAsBnP3FtFHCnEzzBNNZfsCy3iJ6w=nT07CHgVg@mail.gmail.com>
	<L-1MAJJDE02BClBz6dbLWTKAz6RM33gupqt5fPEyX9tYoW43aDrrH4oY-OerHc17mpVTgy6j4e6_EauQQY8Viw==@protonmail.internalid>
	<CAJ-ks9mTEcRg6=ZiYFX3ebHSYgMwTv692ufUdTCoA1vX5E1nNg@mail.gmail.com>
Date: Fri, 13 Dec 2024 17:39:51 +0100
Message-ID: <87pllvczag.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Fri, Dec 13, 2024 at 8:40=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>>
>> This coding style is pretty far in the functional programming camp
>> compared to the rest of Rust code in the kernel. I tend to stick with
>> a more imperative style to be more familiar to C folks.
>
> That's a fair assessment, but it's a subjective area -- Andreas was
> fond of the approach (in a preview review).

I am! Let's not restrict ourselves to a subset of rust that mimics a
language invented 40 years ago.

Best regards,
Andreas Hindborg



