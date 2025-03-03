Return-Path: <linux-kernel+bounces-541911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6CDA4C34A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA17166FF3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E45212FAB;
	Mon,  3 Mar 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJQqg4wk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEAD20E038;
	Mon,  3 Mar 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011773; cv=none; b=PzS8UOWTAJRRU0AAHwUdqaItF6M/3JLa/2MaX4As6+1f3UJ597Vu0AXRYD7m/xrjivS23OwnJ27X7E4LoojJyyIelVwIjqYPaIRu9J1kgzZuFVxmhkyRhynx58fvfDCemo500fG72x2xjM1n+9PWXIUa6c9YxKMzbYABjptn/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011773; c=relaxed/simple;
	bh=0pSso4stqSY8GNGh7LiA8iHnN1/8epjymPS4hvlsWNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H3YoJeYWq8aKh8eRz3Wg3ZSM47uc7HfC8n6/G0Canu9UJK9xfuM45Q14ce/eeVSLe20k52UJKtjfzhPCKptIfoRKYfGtcdn57A5okHHkuM13dgeDrFtHagApJwNBoLvk1rvvp9xEuf8z/XgxOfmSsYzs9uVBAsrXk83XqujiwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJQqg4wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9F8C4CED6;
	Mon,  3 Mar 2025 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011772;
	bh=0pSso4stqSY8GNGh7LiA8iHnN1/8epjymPS4hvlsWNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MJQqg4wkEM7g/DIqPIoXoN31F+upoOphcaTOlE05GS6cHJjlDeYX8gu7R0RpZpyqY
	 klbYZ6EgP90OY1yCv8My6sJr3VTmrbqfQrdFmn91dTj5GRnftEsz7YP54R0CJxTMBi
	 /anxiJkWPG82XwvqVlIG0EYRBu0pX372DsnUgPGMRq/7l6k/mlmXiEdkYJiB2cmnj0
	 3RsphyadZxaXzkWd2QpQXqF1F43SwoshFd0XCD9xmjfJOvLRwnQmJ8SCS7dWlSRfhp
	 yyG35aUhy9+hDsTOXwyeVo9SccCMWa2tPDP0NsF4CyxSQ5hR+U6pLyaurFcM71ZSt7
	 VWc1ECwhdj0/Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3] rust: adding UniqueRefCounted and UniqueRef types
In-Reply-To: <Z8Wuud2UQX6Yukyr@mango> (Oliver Mangold's message of "Mon, 03
	Mar 2025 13:29:36 +0000")
References: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>
	<MFrukGViddXfhKeURDySTWCDW6Pk8Oo5keozdVg9hehiS3P4FVHKv4d-Fwn87yprBUeyTHcY6T1k9htIhPzc9Q==@protonmail.internalid>
	<Z8H6EUy1HqLrzytE@laptop> <87frjxncsx.fsf@kernel.org>
	<R-XaKS9h55NHdh6RYNYWTGw7oDyauYJhAY72W8DAgJJ73VskOhGPlSZP5DC4teo0EdhbDDtLV0Lnd9MMd-jCBg==@protonmail.internalid>
	<Z8Wuud2UQX6Yukyr@mango>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 15:22:43 +0100
Message-ID: <87o6yijirw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> From: Oliver Mangold <oliver.mangold@pm.me>
> Date: Fri, 21 Feb 2025 08:36:46 +0100
> Subject: [PATCH] rust: adding UniqueRefCounted and UniqueRef types
>
> Add `UniqueRef` as a variant of `ARef` that is guaranteed to be unique.
> This is useful when mutable access to the underlying type is required
> and we can guarantee uniqueness, and when APIs that would normally take
> an `ARef` require uniqueness.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>


This part:


    This should address all issues that have been raised with v2:

    - Added a default implementation for unique_to_shared() which does a si=
mple
      rewrap of the underlying object.
    - Added a SimpleUniqueRefCounted trait which requires only to implement
      is_unique() as Beno=C3=AEt asked for. Maybe the feature is not worth
      the extra code, though. For me keeping it or removing would be both f=
ine.
    - Removed the unsound conversion from &T to UniqueRef, as spotted by Be=
no=C3=AEt.
    - Relaxed the requirements for Send and Sync, to be identical to the on=
es
      for Box. See comment below.
    - Added Examples for both UniqueRefCounted and SimpleUniqueRefCounted
      as asked for by Boqun Feng.
      For me they compile and run without errors as KUnits.
    - Changed the commit message like suggested by Andreas.

    @Beno=C3=AEt: I think you are right about Send and Sync.
    What gave me a bit of a headache is if Send really does not require
    the underlying object to be Sync, as the refcount itself -
    which is part of the object - might be touched concurrently in a case
    like with tag_to_req(), but I think one would not implement
    something like that without having a synchronized refcount.

    Best regards,

    Oliver


Goes immedieatly after the cut like so:


    From: Oliver Mangold <oliver.mangold@pm.me>
    Date: Fri, 21 Feb 2025 08:36:46 +0100
    Subject: [PATCH] rust: adding UniqueRefCounted and UniqueRef types

    Add `UniqueRef` as a variant of `ARef` that is guaranteed to be unique.
    This is useful when mutable access to the underlying type is required
    and we can guarantee uniqueness, and when APIs that would normally take
    an `ARef` require uniqueness.

    Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
    ---


    This should address all issues that have been raised with v2:

    - Added a default implementation for unique_to_shared() which does a si=
mple
      rewrap of the underlying object.
    - Added a SimpleUniqueRefCounted trait which requires only to implement
      is_unique() as Beno=C3=AEt asked for. Maybe the feature is not worth
      the extra code, though. For me keeping it or removing would be both f=
ine.
    - Removed the unsound conversion from &T to UniqueRef, as spotted by Be=
no=C3=AEt.
    - Relaxed the requirements for Send and Sync, to be identical to the on=
es
      for Box. See comment below.
    - Added Examples for both UniqueRefCounted and SimpleUniqueRefCounted
      as asked for by Boqun Feng.
      For me they compile and run without errors as KUnits.
    - Changed the commit message like suggested by Andreas.

    @Beno=C3=AEt: I think you are right about Send and Sync.
    What gave me a bit of a headache is if Send really does not require
    the underlying object to be Sync, as the refcount itself -
    which is part of the object - might be touched concurrently in a case
    like with tag_to_req(), but I think one would not implement
    something like that without having a synchronized refcount.

    Best regards,

    Oliver

    ---

    rust/kernel/types.rs | 315 +++++++++++++++++++++++++++++++++++++++++++
    1 file changed, 315 insertions(+)


Again, I'll recommend the use of b4 [1].

Best regards,
Andreas Hindborg


[1] https://b4.docs.kernel.org/en/latest/contributor/prep.html


