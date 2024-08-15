Return-Path: <linux-kernel+bounces-288646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB1953CED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8161F251AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8E2154456;
	Thu, 15 Aug 2024 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aWo7E03j"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098F14BF9B;
	Thu, 15 Aug 2024 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758516; cv=none; b=RiReSOIFr+qDavKihy5Awr4D6DtLPo8IoDdJNob0iTFGb1xhe9u6p8uPoUzgNdpYS6gJfOA02MRKElGUeKAOKb/drEaGF48/8XqMoC+aPWWj+PDX1JOxruRJ8V25suZZ2FN9N+lxTBIdrcGQ9lOLqDZbooYVLVAdBLtVMPro+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758516; c=relaxed/simple;
	bh=6JWSEjE+0cfQb1CHroqIFEm2kljNfmsr8eOyWsafBoo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLiYblmRflvcT4lGjhf5ZpJMIp3AUdeY3FJh75svmyA0UN5UBEB8DsuyjQh5GAM/iBZ15Q43GNwoekZiuhXl1VwzRw9bv4UyBDx7fyHKXOBxJUvy97vuYY9+WBfTCfA84Ng1xMWL+K+OrS8plki2dS++3ChOrBmH1pfF0d5AC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aWo7E03j; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723758512; x=1724017712;
	bh=6JWSEjE+0cfQb1CHroqIFEm2kljNfmsr8eOyWsafBoo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aWo7E03jL7/2D8MSBczYSzQ8i67q8LXCKKHMs2fUZg05OeCoQiLTCjRtw+wA8zpPb
	 V6iTu68U3K5uwn9ipz3/TYNOeCEND+BwY6EKYgV+l5rkjTU0I3YbyBoDcBVDeHZ/jV
	 eMaGSkNeWECPxQclhTx9KPWTSiN/WVx8cOe9HcVjCQG/8/Wb+u/GoIKte8TC5KYGxO
	 l3bfIXdFtLwosbCXqk15PsfXvoUlOlD4ZTjKNDRmdYYnYPjEtYUBi83uPG5R3Xc7ud
	 TgZ4TPMDwvi0N4WHFpVJhXV4DyTz6IGBLCUUiWsbKI1Li49jPceNiYKKe2HLQHINeG
	 3pJ26c0Rf3bfw==
Date: Thu, 15 Aug 2024 21:48:29 +0000
To: Lyude Paul <lyude@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Aakash Sen Sharma <aakashsensharma@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
Message-ID: <e83779e6-76e4-4d6a-8019-ae853e508da7@proton.me>
In-Reply-To: <9a4555f09c6af633ffae0feaf9ada66d01eec876.camel@redhat.com>
References: <20240802001452.464985-1-lyude@redhat.com> <20240802001452.464985-2-lyude@redhat.com> <Zrzq8su-LhUIoavm@boqun-archlinux> <1bcae676ec4751ae137782c4ced8aad505ec1bb9.camel@redhat.com> <Zr0QyN8sQ6W2hPoJ@boqun-archlinux> <9a4555f09c6af633ffae0feaf9ada66d01eec876.camel@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 85b2537ed7ad1b7131bc6d68ab8e1b860b715068
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 22:31, Lyude Paul wrote:
> On Wed, 2024-08-14 at 13:17 -0700, Boqun Feng wrote:
>> On Wed, Aug 14, 2024 at 03:38:47PM -0400, Lyude Paul wrote:
>>> On Wed, 2024-08-14 at 10:35 -0700, Boqun Feng wrote:
>>>> note that `cb` is a `-> T` function, other than `-> (IrqDisabled<'a>,
>>>> T)`, so semantically, it doesn't require IRQ still disabled after
>>>> return.
>>>
>>> This was the reason I originally had us pass IrqDisabled as a reference=
 and
>>> not a value - specifically since it seemed to make more sense to treat
>>> IrqDisabled as an object which exists throughout the lifetime of the cl=
osure
>>> regardless of whether we drop our reference to it or not - since it's a=
 no-op.
>>>
>>
>> I haven't found a problem with `&IrqDisabled` as the closure parameter,
>> but I may miss something.
>=20
> I had been asked by Benno to change it to by-value but it wasn't totally =
clear
> to me either what the reasoning was.

I wanted to avoid reborrows. The parameter of the closure has always
been `IrqDisabled`, but functions that required IRQs to be disabled took
`&IrqDisabled<'a>`.

---
Cheers,
Benno


