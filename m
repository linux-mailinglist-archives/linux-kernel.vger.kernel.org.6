Return-Path: <linux-kernel+bounces-357489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC3B9971D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D7C1F2B29D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804A1A704B;
	Wed,  9 Oct 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bCup32UD"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6E126C17
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491764; cv=none; b=bOBlODv593vdbVv+sM8pWXIO3C5Fy3AjUHx5/tyel0w6GQ2h6LBcrJ5u6HKqV4wOqWM/pzMjs5c7KDN0ckNU3NCmd1G1pk66ewOvHqIb8EwrbeDu/NC10PTIKlp4DeuwKmt0C2JKEHdfDbCL10LKGeA9htVNhTq5LbNxXkty8Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491764; c=relaxed/simple;
	bh=8HKJlWSSCHdy6qITFYkhu5cddwy+nQ1ZeYduwDm6hjo=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlTwjaQQbWJk6CaJ8CFnlKsSDzACJvazPUb+EI/9bf8j3vGZKyadg5I/i2DMTMgCRc2ji+kR48eBakTPFOE7STST7Yp2k6QoD4Yrfhc2p3NqmPjAGz/53+r5lOYutjwowT+Wb6SCNnd8oeLPLLoPkzPLYiJjBqkFiegjAcawobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bCup32UD; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1728491760; x=1728750960;
	bh=zmN7XVnDiHBQMiossOz4+ICOWo+68Q9zVw+WfEF1/vU=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bCup32UDoeCdBJCu6ZCjcNjQ2Hsq5Weuaqt6jIOUGZnszZJXqPveUf1xNVnfHL+bB
	 c7dfkT0j5/G3rWv1kb4tpYwly7HEaAByfw5LDpbZ27L4V2GiUALqvZuvTQT4PSFnVp
	 BIa53l8rtBNRugCCh21l4xn4OR/Lbm9jTWCrmbBtj0j/ty9o8zrXybtgc6ZLODorqk
	 iqvEOlPPTxIQPstp8hy2aJzk4oGvs/fDlldTqyO0p6ngBCGcdB++zJsu3c8mWAFkhD
	 vQ+hLahEMGNn9Ip0MCcIfeQGUdIbVWO3smVT7GNWBuoFUlaYeSGLJywRScNAca1R5j
	 XLSq/e3ZqJkMw==
Date: Wed, 09 Oct 2024 16:35:55 +0000
To: Dirk Behme <dirk.behme@gmail.com>, Christian dos Santos de Lima <christiansantoslima21@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH] rust: transmute: Add implementation for FromBytes trait
Message-ID: <cf317f8a-e67c-4c33-a16e-74f7ef9ef96f@proton.me>
In-Reply-To: <da18f77e-3ac3-4222-9ceb-72e2955472a7@gmail.com>
References: <20241009014810.23279-1-christiansantoslima21@gmail.com> <da18f77e-3ac3-4222-9ceb-72e2955472a7@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f7b7b0c10724306e0770a16aea16d3835fcdcb90
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.10.24 15:03, Dirk Behme wrote:
> Am 09.10.24 um 03:47 schrieb Christian dos Santos de Lima:
>> Add implementation and documentation for FromBytes trait.
>>
>> Add new feature block in order to allow using ToBytes
>> and bound to from_bytes_mut function.
>>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1119
>> Signed-off-by: Christian dos Santos de Lima <christiansantoslima21@gmail=
.com>
>> ---
>>   rust/kernel/lib.rs       |   2 +
>>   rust/kernel/transmute.rs | 302 +++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 290 insertions(+), 14 deletions(-)
>>
> ...
>> --- a/rust/kernel/transmute.rs
>> +++ b/rust/kernel/transmute.rs
> ...
>> +unsafe impl FromBytes for u8 {
> ...
>> +unsafe impl FromBytes for u16 {
> ...
>> +unsafe impl FromBytes for u32 {
> ...
>> +unsafe impl FromBytes for u64 {
> ...
>> +unsafe impl FromBytes for usize {
> ...
>> +unsafe impl FromBytes for i8 {
> ...
>> +unsafe impl FromBytes for i16 {
> ...
>> +unsafe impl FromBytes for i32 {
> ...
>> +unsafe impl FromBytes for i64 {
> ...
>> +unsafe impl FromBytes for isize {
> ...
>=20
> Asahi Lina's device tree code which reads the device tree node's data
> as a byte slice and then has to convert it
>=20
> https://github.com/Fabo/linux/blob/9e496b356ee8e25f9bee9258491aa6ae3a4f1d=
df/rust/kernel/of.rs#L390
>=20
> uses macros to avoid code dublication:
>=20
> prop_int_type!(u8);
> prop_int_type!(u16);
> prop_int_type!(u32);
> prop_int_type!(u64);
> prop_int_type!(i8);
> prop_int_type!(i16);
> prop_int_type!(i32);
> prop_int_type!(i64);
>=20
> Would anything like this be possible here, as well? To avoid code
> dublication?

Yes please, create a macro.

---
Cheers,
Benno


