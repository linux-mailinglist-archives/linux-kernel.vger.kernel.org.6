Return-Path: <linux-kernel+bounces-424814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE409DB9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E6FB22631
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3D1B2190;
	Thu, 28 Nov 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="27CrapXO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A81531E3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804869; cv=none; b=sp6S+VxHfrAgUQdCFup0hH08x6RLQP+7Ckrmd6akL3IYJreTkZXeScD2D0qSk8PXRT4rM/RWbMuQu8H40ZXC4Xxx9oW9CastBlOE3OBgbwQZyDT+yiZTfdK21g0JB9PxTXcAcpALI8BfsgVv6MbF/AxP4mQIftzv7979dPW1lKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804869; c=relaxed/simple;
	bh=tdMDYqpf3IuC59bE6nkIkaoxj2BSW7f0BxFAiJEyjlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+BM6rQ26x5QC3mAentTijgwI+9bl9KoGRjlbW9vh3TwwWbHdUGa1tkrBpcbdd5TaFAWCCVDu2OUC4Cg9gRUT9FAs7qk9iL9qvZa5iCNKHUDbiuUiOfHYSohyYuAx7jw4ursXLJJCuMzF7FRKti73v1OwG6Kkz61c4lS+iincfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=27CrapXO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43497839b80so5600585e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732804866; x=1733409666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwBwmc6DwE9wExuP36Thcn5CpMbyaudiqRqKVp5a+jc=;
        b=27CrapXOqkaBfuZRrAu8l9NPup+xksoPBwUXWGSu60+bhJVeJF7U9MAx4tQE1k0pgU
         5++puM0KW2kLGPU/djTnvQWPPvpTb8Qo2fz+q9aBTxe9hyJxdg9DwhZcJ8GH/H53C9j8
         Uv4qtbLLHo1A7wtRlJ94Kjr2jEAuqTqT88kje4cj8XB1sa8uJ6qPQRBbXHyPTl0AWZFW
         Y7mJ5hUnhgroeMwkaQGVFflM5Pna5++AOIBlwDQEJrTDqUYz7h9cM7OWMzAS74PUncWT
         txQwtIKL8ydUhTeM/2+oIRU45ZYrEzRI8tLwPcDPp33rLdRTYXvcFvBz3a/l3ycOTg9H
         dtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732804866; x=1733409666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwBwmc6DwE9wExuP36Thcn5CpMbyaudiqRqKVp5a+jc=;
        b=OtBAX+O3af2O6EGRAiuDb+0Ic1oLwKeEx4tUwRIxgNb56IEzJU7AVJuGLQ5CTcqFnn
         O5LBhNtrIV2p0y9NHfKpzCOkQV2dK37Oyv4wfpaDqImCo53MJFm+h85Yh1Hw00D4fN/5
         /7SFj2aQd6xn3ES8s0WHGcsuultBkiyWWgylobEVWjDESAqLqmMIAyHPYTU9dWuom8uN
         LS7SQBZzcX7AhsWUAhnBQLlUlxwZ7P4E1ef2KwIHfJiwJC/PZWY26tFZqR7ezV9+5wYt
         yVcGtJO35ZZhcMee0J3ioCDq8y8NZSdQHQta9H9l0ah3Sg39RnRbRh8boT+pRpP+VBC8
         VQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwIF1WoUKRXo75ln8TpR/vtrUqlpXQa8Vk1AIRTj5pHd6JI0EuIYR364fFgBNDuyZur6c5jx4j5WUOp1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmQs2cf0a/tz1dlftCevOqd4ytuItegw90hd5DFzc41BFl6+g
	C6KGf86Ib/wlDl4Q2gPyNYiKQIXYWRshRDWtbKYOynmW9Bhbwsxmir74aJjmanavSb8ONbSxdrF
	TYR4laaEE7fcNxElEC06xoS/9Y9HRIZ4wjGG6
X-Gm-Gg: ASbGncvOEMZCxml12vIo/r4Ad6zWkwaHFyL3OtXWSSv35XP79CSBlZOHSMvZQQEQyaJ
	pTrTWC4lET9VJdDtT6oBYo3vph+C/U5d44rX7AuRVVUEOqsbKnDRMO+uydzGN
X-Google-Smtp-Source: AGHT+IGQuu3FpJRv1GRJAM93QH1pl0e2+J9DOMDr5xMd1RLfVGwI0OX1F/tLzRv0A5j1Ykw3kEo2peafOSkPqXsMNvw=
X-Received: by 2002:a05:6000:389:b0:382:5016:fd0b with SMTP id
 ffacd0b85a97d-385c6ee2190mr6139158f8f.50.1732804866470; Thu, 28 Nov 2024
 06:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128141323.481033-1-pbonzini@redhat.com> <20241128141323.481033-2-pbonzini@redhat.com>
In-Reply-To: <20241128141323.481033-2-pbonzini@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 28 Nov 2024 15:40:54 +0100
Message-ID: <CAH5fLgjJbzAbf5CO3xjHxcThpqju3j0tNdo+QiGupARVmoThYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Zeroable: allow struct update syntax outside
 init macros
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	boqun.feng@gmail.com, ojeda@kernel.org, benno.lossin@proton.me, 
	axboe@kernel.dk, tmgross@umich.edu, bjorn3_gh@protonmail.com, 
	gary@garyguo.net, alex.gaynor@gmail.com, a.hindborg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 3:13=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The Zeroable trait is a marker trait, even though the various init macros
> use a "fake" struct update syntax.  Sometimes, such a struct update
> syntax can be useful even outside the init macros.  Add an associated
> const that returns an all-zero instance of a Zeroable type.
>
> The exact syntax used by the init macros cannot be reproduced without
> forgoing the ability to use Zeroable::ZERO in const context.  However,
> it might not be a good idea to add a fn zeroed() inside the
> Zeroable trait, to avoid confusion with the init::zeroed() function
> and because Zeroable::ZERO is unrelated to the Init and PinInit
> traits.  In other words, let's treat this difference as a
> feature rather than a bug.
>
> The definition of the ZERO constant requires adding a Sized boundary, but
> this is not a problem either because neither slices nor trait objects
> are zeroable.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Slices are zeroable. I know they don't implement the trait, but they
could implement it, and this could be used to implement e.g.:

pub fn write_zero<T: Zeroed + ?Sized>(value: &mut T) {
    memset(0, ...);
}

Alice

