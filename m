Return-Path: <linux-kernel+bounces-308844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB3966292
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D36F286DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058631B2EC7;
	Fri, 30 Aug 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="a1cnbXOh"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60B1B252D;
	Fri, 30 Aug 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023167; cv=none; b=pd+huZGaBKGRNI+0uWFiAl6u9ACycP7BKRGMFeAUvrpYKeAn3Rbvqdk9+m+BE1WhnWqrakWMrjmRICc9S6XIrcdoAJqabkCsl5+eP5yj3ve1PhphcwnboO98k9yItCPW0sY+xcflbE3g9qRPi5u9LTaRsLfIFjVyW4qzALFVUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023167; c=relaxed/simple;
	bh=M7hcMuY7XEJQVdhD0HnIkGOs4GZIVZbVHektJcrBosE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3jVN7CHOmVSc1sINSfs6AjFHOy6e9O+qsb5aRUOWfCJlMVFGCsB7mH0QGyFTjbTSQrC8XTw1qQbdEh6N3/PO0+0PcWKNwnTq5mMELBauV2A9/bnJNqTsMgQqVHr4n59qQ+InZ+r1yZrm5oWn+BUZT6DMaw212/JGJat4K1pYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=a1cnbXOh; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725023162; x=1725282362;
	bh=aBe8onPW5ybz1/iMjQay95hHNR5F07fd5YsN+o+D6vE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a1cnbXOhSBDk1Nnb29XFhNCGCpaj4e+NrzusYHi+QnEqKf1L45F4NHDlpTb0z9KBz
	 3q2rGwJY5fbrYAqN3ZuACOEmpy9xl2z/4Jmn1vgr5Q7GjqHJTuvWOVZbr6oKWATEDQ
	 Y83s9yBngzoQ3QQB1T3n5GM3djuqBaKnOC5R5nUM7ESgfIfUmWa7V0++irIyioji1C
	 VP7L0gxJMb1FjoRMJi9h93avmzfQSCP8WIwJuXEccFe93pnh6AxuTw3arND9tsfSgh
	 5bNOEnPPcmHMNkU8GAZ5GI+UP51Iw3X4ggLbWXgIsDbwDeWEOCGOMZaPXdTcLck2FT
	 6uTmIDi2BsZQA==
Date: Fri, 30 Aug 2024 13:06:00 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 01/26] rust: alloc: add `Allocator` trait
Message-ID: <44b80095-8b03-4558-967e-138ea712f780@proton.me>
In-Reply-To: <ZtDuf0QGfhiy5X_I@pollux.localdomain>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-2-dakr@kernel.org> <60253988-37e7-4acb-b2ae-748b30a4ac21@proton.me> <ZtDuf0QGfhiy5X_I@pollux.localdomain>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 53541a418b18778e4e773fc078d8959f34bc6b19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.08.24 23:56, Danilo Krummrich wrote:
> On Thu, Aug 29, 2024 at 06:19:09PM +0000, Benno Lossin wrote:
>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>> Add a kernel specific `Allocator` trait, that in contrast to the one in
>>> Rust's core library doesn't require unstable features and supports GFP
>>> flags.
>>>
>>> Subsequent patches add the following trait implementors: `Kmalloc`,
>>> `Vmalloc` and `KVmalloc`.
>>>
>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>
>> We discussed this in our weekly meeting (I think ~one week ago?). If you
>> give me a draft version of the comment that you plan to add regarding
>> the `old_layout` parameter, I can see if I am happy with it. If I am, I
>> would give you my RB.
>=20
> May I propose you let me know what you would like to see covered, rather =
than
> me trying to guess it. :-)

I was hoping that we put that in our meeting notes, but I failed to find
them... I would put this in a normal comment, so it doesn't show up in the
documentation. Preface it like implementation decision/detail:
- Why do `Allocator::{realloc,free}` not have an `old_layout` parameter
  like in the stdlib? (the reasons you had for that decision, like we
  don't need it etc.)
- Then something along the lines of "Note that no technical reason is
  listed above, so if you need/want to implement an allocator taking
  advantage of that, you can change it"

I don't think we need a lot here. Additionally it would be very useful
to also put this in an issue to not lose track of it.

---
Cheers,
Benno


