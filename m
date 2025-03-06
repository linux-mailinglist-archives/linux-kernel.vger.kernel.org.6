Return-Path: <linux-kernel+bounces-548643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29957A5476E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719291893112
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8D1FCFE6;
	Thu,  6 Mar 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SB6szdr7"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0419DF49;
	Thu,  6 Mar 2025 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256056; cv=none; b=rL31/x2+EpLLXpt1L2cSPBGmO9MiLrbMlrjKwTVPIgcKZHSI5+Xt4sX+HrKxt4SY8vQlMnNfmlu+Y419hDb/d/Uc+e/cqrtpe9zZM3YpQi8R/T9cVKSY5+Zv9AK1CLYxG/nWF7K1+7xGe0kK300BN8LazuTtNNc1jbKjBQi12MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256056; c=relaxed/simple;
	bh=Ji84DnUxZPaZjWugH0NqsXEiI73Lt2LMDG3qx2jTb9o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xdgc/sX+AVNlosUD+tfOpgYutc3v1CC0wepWUeR+1JD9++d5XheaUlgmwaIjYMOpt6H+VZpn/gHPTiBKHw2CtgSENShcvhaoKIn6w795kf2sbhhW0lF30wiJfwIfWhP7eX3zdDpJAZf2k/bxwSI0+KEzvvg0qpGr4skQay1U9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SB6szdr7; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741256052; x=1741515252;
	bh=Ji84DnUxZPaZjWugH0NqsXEiI73Lt2LMDG3qx2jTb9o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=SB6szdr7Gp6dUs8hgrPjccFk3qFPln2m29hwmDy4SPD1aYSGtxaEQVy0H50uYX9Im
	 omEMsdu+iJL3sovHiPicLlaZEMJotcFs2amy7X2aRPf5hcz1Mbt+XxzuqSZe3XH1yt
	 qFLuRmaZErzuK6HH/6S267rJioKx91DwNV3UgDkD4B1eKuDYfn5Bc1Rxfq64BEK++V
	 qN33UFkeBXIuw4O0dWiaHAZqdiWOqTmDFiQzcvZGIgocGpkSZkPV7Qr0Y/tvSRbAUi
	 sJ706qktR/buQoe/h67z6Xc/E7080XFHyWx5Pax3hUlgkWilu5QcRt3tqkluvqo9mt
	 Gb+FhqiAnxwAg==
Date: Thu, 06 Mar 2025 10:14:05 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8l1Zt3ibanzBhnX@mango>
In-Reply-To: <Z8lsetLbHvn-6cai@google.com>
References: <20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me> <Z8hUIPtE_9P60fAf@google.com> <Z8hmCkeZGPwc5MuU@mango> <mE_To6ll96gFJQD9YKkT-mwa2KCHFCgOaZFxxczeDVJd0hr1rZCKFHD-vHQfm6deCjlUJIu4U-reNMtrwfyT7w==@protonmail.internalid> <CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com> <87ldtj8p2m.fsf@kernel.org> <JPqvzrz3Zy0HgwNoHh2psup7imFItiN_j_VmmjVPBfwJzf040DTvZAwUDjNv1FQiLXFiSAANIxc2IegeKGCJvA==@protonmail.internalid> <CAH5fLgirYTV6K2QoH9LLwhHxJzz=h1R0jB4G2kpKQ_pBtBgePg@mail.gmail.com> <875xkn8k5z.fsf@kernel.org> <Z8lsetLbHvn-6cai@google.com>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: e40e2afc114c2974bd3c93371cd758f2bc37229b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250306 0935, Alice Ryhl wrote:
>=20
> Ultimately, if a struct implements AlwaysRefcounted, then you can always
> increments its refcount.

> If you want a version of the struct where that
> is not the case, then you need a different struct that does *not*
> implement AlwaysRefcounted.
>
I guess so, but it would be possible to make 'From<&T> for ARef<T>' opt-in,
by requiring a separate marker trait.

That you can call 'AlwaysRefCounted::inc_ref()' directly doesn't seem a
problem to me, as it will only leak the object, not create a reference.

A quick grep shows me that there are currently 7 implementers:

unsafe impl AlwaysRefCounted for Credential {
unsafe impl AlwaysRefCounted for File {
unsafe impl AlwaysRefCounted for LocalFile {
unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
unsafe impl crate::types::AlwaysRefCounted for Device {
unsafe impl crate::types::AlwaysRefCounted for Task {
unsafe impl AlwaysRefCounted for PidNamespace {

So it looks doable to me.

Oliver


