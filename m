Return-Path: <linux-kernel+bounces-548816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F86A549A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0E616BC43
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8682D20B80B;
	Thu,  6 Mar 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nw30Q9BE"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756F20B7F3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260680; cv=none; b=QRTW6iciy+2ET41VX5uqQd/Qa6CT2//2YWZ35qJ1UtjoAxjekgzgxxYHNQDER+xbrpCKVRbtHKA6UCFse4ipee99T1UbsK0a7fjlIBty6jLNqN+iy6XiK8mXupX9iS3mboTvSt153pxc+8UJNg9y5k2Vg7PUdl8oTpHZOcQFtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260680; c=relaxed/simple;
	bh=FqGWKIYIxEEdI6TEmmKXSitgZ63vn7LwRjV3OTJakKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oe7nVRP57A3iAPysNG6p64tezVlyTvVDAySWh08AAaMmvuzIgp9R7i8IcHbpJMgyg8W8GxjLB0xRDPcqudGf18jkleHnbnn0suHHE5RqTxmNJG+2OmHGE+p95A37kz0X7/Tr6mXZWtP0zXRPbL9SGkiFAC9xjTxhocQij4eXmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nw30Q9BE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bce8882d4so2469795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741260677; x=1741865477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0tCVb3iIaIyBkkkekA7WO/rmW0W0Zi+Itg16RAYECk=;
        b=nw30Q9BEry2n1s+28/uPk0Exscj+ujDektiZesvF03SnmIJJ9JItYNBvTgr0eYpEvq
         HfnNjJ0teiHfRGpm4FH5CDoouNcuEFztR1Kze/f14F9Sk7ye7Os8nYUpV0dp8wzV69+2
         AdEwVHIqol3hVLTIvPf6AL1is+Eu82a4m2lvuBamCfGd6voSLKbWQrOvwdykHm/qIGgW
         t4oC9GpBu6BJmB5+D80hGWF7wVbiFpr/6GaKnVFNzse3H1mZGst5R8kQB3tB0Zn0/6/x
         hjVXvmioleXCYegPDFqaUguRtQeADkjcqn/PO1BauZuuF/ke3QDY0bkFD/q3KbvgV8CS
         AI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260677; x=1741865477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0tCVb3iIaIyBkkkekA7WO/rmW0W0Zi+Itg16RAYECk=;
        b=ATIsoVrQg9AjQrlYU/ORT07Gb+XiJmKt5SjUwjmrNxmwqsHac1SfMIXnFFORCtQ72i
         c9nfXXXGP561BsJlUl5jGEV49ZY2DpTJ+tflwmgUUsWudwTKlJ1xarvMo8bcP1p1h6rj
         FGW1Euv1/E3fwg/fVuktlmlSDMz6xb+FkHxwJmt+Dfg4219UtQL+N/AJYVYAloEyDKy4
         /Q7hYs+A3dVwA4b5fKNAs4E9Nit5UMY2Nwr4qGqRL4GXZBF3db+lBvwE1/AV1k+aZ/Rf
         5G58apDcLG34acbaNg+niqxdm901MiH25Gz/OntQSbM6FdfwkpMa78BUqgBkRn+UvgQD
         3B/A==
X-Forwarded-Encrypted: i=1; AJvYcCWqmRBbly8SQisaCsXbMhIa4fii9ERKZ21OfFb9di4M/ZaC8+nr7WXpAGEBC3TYFQ6q5kjTkK2lkhYh7Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzyq69sUmDFusOuJy3w8W8Qi5zBiacGiX8vh9nC8u8T43W7TPR
	Lydq/C5btir7exVM2shT07UYXHV9Spdic4keDB7kNVn1rW0btaUAteIQSjGbNgRYL4Z9oJyHKmE
	t4koYptnEiON+9Q==
X-Google-Smtp-Source: AGHT+IGbjIxQ+LXn3IimoRkTh08izP5tV0mAeGWCiKncwsCuPuVt5SSfdtPUELb1s0fR5mdTrGN0Vdo8WYa1GGU=
X-Received: from wmrs15.prod.google.com ([2002:a05:600c:384f:b0:43b:cacd:235e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f84:b0:439:a138:1d with SMTP id 5b1f17b1804b1-43bd29b8545mr46277695e9.22.1741260677638;
 Thu, 06 Mar 2025 03:31:17 -0800 (PST)
Date: Thu, 6 Mar 2025 11:31:15 +0000
In-Reply-To: <Z8l1Zt3ibanzBhnX@mango>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z8hUIPtE_9P60fAf@google.com> <Z8hmCkeZGPwc5MuU@mango>
 <mE_To6ll96gFJQD9YKkT-mwa2KCHFCgOaZFxxczeDVJd0hr1rZCKFHD-vHQfm6deCjlUJIu4U-reNMtrwfyT7w==@protonmail.internalid>
 <CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
 <87ldtj8p2m.fsf@kernel.org> <JPqvzrz3Zy0HgwNoHh2psup7imFItiN_j_VmmjVPBfwJzf040DTvZAwUDjNv1FQiLXFiSAANIxc2IegeKGCJvA==@protonmail.internalid>
 <CAH5fLgirYTV6K2QoH9LLwhHxJzz=h1R0jB4G2kpKQ_pBtBgePg@mail.gmail.com>
 <875xkn8k5z.fsf@kernel.org> <Z8lsetLbHvn-6cai@google.com> <Z8l1Zt3ibanzBhnX@mango>
Message-ID: <Z8mHgyNxb6rv6Vhm@google.com>
Subject: Re: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
From: Alice Ryhl <aliceryhl@google.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Mar 06, 2025 at 10:14:05AM +0000, Oliver Mangold wrote:
> On 250306 0935, Alice Ryhl wrote:
> > 
> > Ultimately, if a struct implements AlwaysRefcounted, then you can always
> > increments its refcount.
> 
> > If you want a version of the struct where that
> > is not the case, then you need a different struct that does *not*
> > implement AlwaysRefcounted.
> >
> I guess so, but it would be possible to make 'From<&T> for ARef<T>' opt-in,
> by requiring a separate marker trait.
> 
> That you can call 'AlwaysRefCounted::inc_ref()' directly doesn't seem a
> problem to me, as it will only leak the object, not create a reference.
> 
> A quick grep shows me that there are currently 7 implementers:
> 
> unsafe impl AlwaysRefCounted for Credential {
> unsafe impl AlwaysRefCounted for File {
> unsafe impl AlwaysRefCounted for LocalFile {
> unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
> unsafe impl crate::types::AlwaysRefCounted for Device {
> unsafe impl crate::types::AlwaysRefCounted for Task {
> unsafe impl AlwaysRefCounted for PidNamespace {
> 
> So it looks doable to me.

How about this:

* Rename AlwaysRefCounted to RefCounted.
* Introduce a new AlwaysRefCounted trait with no methods and gate
  `From<&T>` on it. It has RefCounted as a sub-trait.
* Introduce an Ownable trait with an Owned type like in [1].
* Given an Owned<T> where T:RefCounted you can convert from Owned<T> to
  ARef<T>.

And there needs to be a safety requirement on Ownable or
AlwaysRefCounted which requires that a type cannot implement both
traits. Alternatively, if a type implements both, it needs to be safe to
have both Owned<T> and ARef<T> references at the same time, which could
make sense for a type that has one "special" reference and many normal
references.

If you want conversions ARef<T> to Owned<T>, you should add a new trait
TryIntoOwned that's a super-trait of both RefCounted and Owned and has
the `try` method for the conversion.

Thoughts?

Alice

[1]: https://lore.kernel.org/rust-for-linux/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/

