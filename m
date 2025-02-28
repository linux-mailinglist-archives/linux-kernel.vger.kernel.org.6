Return-Path: <linux-kernel+bounces-539289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1675A4A2F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C8D189B060
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49377230BF4;
	Fri, 28 Feb 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ORgVt3xM"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6F1F4C9E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772041; cv=none; b=QIBxMJlLGOk5JgkABGROQEm7Ai9n32YDHIA7OqRz5IxQQ5osThYGO6/3W2Ae0dMvk2FE9phdIfBd8U0YDvxCygMbnUcAMtVxhKIF/9Th1JxvVJwO5qBWHaXJhc/i9Spm0d4cNJOS+X3zTv3D7OCeHSMgRcrCOyL8dfRyNSkcYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772041; c=relaxed/simple;
	bh=0V7VFFDKsR9K+cMYlllRrgZs/WbrhtpiPzqJdOwkmZE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InxkSGzY6slhOBC1aFFNYzVEHukmeVDLO+SC/GziKG9wKbGjuO4HKxbuIwOfVkEVDEOySnZF8fBsUUaIecaq8lW96P3QHxpQH/SaXnJY/cU68FN4lasfMZmSeF1QXft9IW13QDaZnlObMxyAKhL85qF/CllF8d8EnAA4wkIAGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ORgVt3xM; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740772038; x=1741031238;
	bh=0V7VFFDKsR9K+cMYlllRrgZs/WbrhtpiPzqJdOwkmZE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ORgVt3xMPIYqlkIO5vWlzI6IVC5nsqrbsasf3dbAb8A+qxfOTLC9aggp7SSS2rjy8
	 Ub80OnAdPj/HMXfUzapp69a7we+gezciLAKWJgM9ktsEMUUtAfmJnPeCBFwpg21K/X
	 iIjrvINIfjUZiQdH5Hj7Ha0r132p0HV+LDUxkUMZodwASEFVIlLvLiu6Z3wwrAQ98V
	 k3p7mof0gk8RTa96no8d7dK8x3xQ2a+xcaszYR0NsIKlSWqukP0nQBVK2om+Txd/uC
	 Cw1aSVpB8uC+TCgnPhGDJ+89Od+ls520Z0UVMqXewhNFEh8Ks4OLGfS1cKsg8oQaCj
	 JCBTXYkA2806A==
Date: Fri, 28 Feb 2025 19:47:16 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8ISv6QfyLnU78K_@laptop>
In-Reply-To: <87mse5lvlq.fsf@kernel.org>
References: <I2EuahEO9YG75qdfIlsanLJ9iOfr0OlKJr6nw_cqOG0rVrZUEZGhdfENkLawNCpSqP8uSGMODCeEmsYv6clgYg==@protonmail.internalid> <sOipp6LTmtfq5A37VN_kCA4Kw9zfclZ2HLIMSJYnOdG4ebnuTKUlXIlT4X3GVRLMXFmwT4IwyIA-eqF69yOhSQ==@protonmail.internalid> <Z8IBiBi6CSRxfxiE@boqun-archlinux> <87senxlwpo.fsf@kernel.org> <Z8IJPzlvioBZaV5M@boqun-archlinux> <IKv622yLvPB8cQqazDuceWqKbX5PKmf2VTjx5wG-nj0X16d3B-xJBwvbDR_bt5EzerCjmCY6aLZM4emv07saVw==@protonmail.internalid> <Z8ILlUMGQ221hLJY@laptop> <87mse5lvlq.fsf@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 0f0caa06208e0024cfd0b9e55bbfc74c76700ba3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250228 2025, Andreas Hindborg wrote:
>=20
> I am using protonmail-bridge for sending as well. I don't think the
> issue is in the bridge, it must be in the way you compose/reply in mutt.
> I am not a mutt user, so I don't know how that works.
>=20
I'm usually just doing group-reply. What I read is that protonmail-bridge
drops 'in-reply-to' if there is no 'references', which looks about right,
when I check last mails. Need to find out, why the 'references' vanishes
sometimes, though.

Oliver


