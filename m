Return-Path: <linux-kernel+bounces-539257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A84BA4A286
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114AE164B79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AD01B87FB;
	Fri, 28 Feb 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="MRcgRCOr"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492A277030
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770212; cv=none; b=WQlA/c5mTma6a+IluqUbsrPPRPK0XEskehLl2YyqGk6uGPffDU/84oH3Rm1Le+QADHBNBbJoWrdLMJSiq+5Gd2snlJTmJy9r/EmUOPT7hci4O6woPHUxz58fe8eu10ZEDl/UrAfK+3ECp0tnN4AciWv1jFSeqVOJ4/3gEo2+sfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770212; c=relaxed/simple;
	bh=beHI5Po5p0RjCoxuB16ei45Efw+qOgFITPlrDu9pqv4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDeHVNh/nurQT3pFJoXow8xu2egCwPCc21bKmgb+rHkc9ma6MKG03370vFW39MRhQNav7ACbS3LK20kIDPkVGsqQ+OeddSNGvAkta8DnB2TaPw34mJmxd8W7mrSqaKZuJcu9h12264ekALSUhQPDwJxK3EzTPthCzdmXXt6A7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=MRcgRCOr; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740770208; x=1741029408;
	bh=beHI5Po5p0RjCoxuB16ei45Efw+qOgFITPlrDu9pqv4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=MRcgRCOrQZKKvfwk08CLkR0LUnLviGiOrQLJWTDfG4MG0/5VjnhIzr2XFHRqmvSgd
	 ZXIHleeLf89/HMcsgObHVCdn+awV6igMLeyPz/qgXNh2ri98S9u2VucCbtrff/SJ72
	 IRlVsv6mvHr3Qpmou2YNyFtST871fNv7rSgH9NFfulmOkvdLn8b/Ff17SFCyiZ2DiO
	 6V6eXF7sInJ9jsvGLXMfJOa7muPDb1eANW/aQNJ+MNvhpVTAGOWqQmnNEQ9kl5IObF
	 zjcvWnwjN+rmQKeMyc+MKrEOqNJ1v8Ml0mPNYiCMouK96qGkday1Bin80ONhfuXh0/
	 DOB3Whkel9eig==
Date: Fri, 28 Feb 2025 19:16:41 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8ILlUMGQ221hLJY@laptop>
In-Reply-To: <Z8IJPzlvioBZaV5M@boqun-archlinux>
References: <I2EuahEO9YG75qdfIlsanLJ9iOfr0OlKJr6nw_cqOG0rVrZUEZGhdfENkLawNCpSqP8uSGMODCeEmsYv6clgYg==@protonmail.internalid> <sOipp6LTmtfq5A37VN_kCA4Kw9zfclZ2HLIMSJYnOdG4ebnuTKUlXIlT4X3GVRLMXFmwT4IwyIA-eqF69yOhSQ==@protonmail.internalid> <Z8IBiBi6CSRxfxiE@boqun-archlinux> <87senxlwpo.fsf@kernel.org> <Z8IJPzlvioBZaV5M@boqun-archlinux>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 9aea20535d7a6fffc5684da12ed58c2fb2461fb4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250228 1106, Boqun Feng wrote:
>=20
> Probably because some of Oliver's replys don't have the "in-reply-to"
> field in the email header. Maybe it's a known issue of protonmail?
>=20
I think you are right.

Google couldn't tell what to do about it during the last 5 min, though.
I'm using mutt through protonmail-bridge for mailing.

I will look into it, but if someone has an advice, it would also be
welcome.

Oliver


