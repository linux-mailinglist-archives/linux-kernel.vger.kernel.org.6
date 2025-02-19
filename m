Return-Path: <linux-kernel+bounces-521853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6FEA3C32A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60A21750AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45571F417A;
	Wed, 19 Feb 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzGlbqPu"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CEB1DE3DB;
	Wed, 19 Feb 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977725; cv=none; b=VmuIPRHXGO3lUoLLynxsbppq08jVb6S/49gqJRztpbGd8CXiZHO2Pyj9OyxgCODHFItp8m1ItvLd9Mw3ljwwxhuvq1dTUHa0eOIPKY6FfHVGdnidU8r4isW1L0k2cr9gE2zb/KluG3WEE94RD//P60QCNEud5Gf+U+hscCCHPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977725; c=relaxed/simple;
	bh=YlhF6ctvtEWQSP6s0OMQfJh4WMP7w3RXqHU+Ce5NlNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9DXVxs3+lOPZeC4JAYct0DyCjwkARBe2VZYwLQ8LZCf1JTjQdV1pvOrTGp1qncfKcVbkQHsY4YewnhZ04OWLXZiin5cg+T7VN48ZHq9yRqGGpM9WDbOO9/6miF4Jbv/JEQO9GuKPaPShabdUsGlC1s8dOYg+UX/+lTYrRg3Iu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzGlbqPu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f7d35de32dso1547514a91.3;
        Wed, 19 Feb 2025 07:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739977723; x=1740582523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyrCL7AExcqf2mJIChj6omMmtS/RWri2tSbYlvAvrAk=;
        b=QzGlbqPuW9Dxy833rQ85P3NhvFvmItDXwfsJk8D+4tr3I/fWGlgCJb6Lo46oKOAW7q
         nlvW1B+lwput94Y3rPK8QJBrDOC/ADHWjHTHYtYX77xT+CRqWg/5S3VGc11j5j/hestF
         jlShk6vIpbyaiZz+N2WT3fJl30iKItqDarC46rwQiosbpHzjJE/D8QbsxIvJt6AfYfLq
         iwdBxU/OPC1cRH+rV76QDcPgiquxHVZifcHFuU72N/fo+m1sq3ip+p+rlCFDw43oWx86
         oAzRYghJkJAniHq+XNsKzkD5Gyk/jLBcGuzrw14Vu4A8nDOluvK6sdHX923tb8EfgDTH
         eD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977723; x=1740582523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyrCL7AExcqf2mJIChj6omMmtS/RWri2tSbYlvAvrAk=;
        b=EG6byuYEhNUMSuF3BzY+wZ+kzVoWVm0bqU9K9r1PcHHrp48xv/GfQOYR83tWaFBVFX
         /qRx7I9dB9DJ012hbp/tvXuMb4RvWSMSUjoVFLVGdO9xPq2Uvi28qb/vwWNTYporN5kd
         oTGavDHP28M2HtSrbqGPXFZVbvtdm0z0NQREcMf7t5vMScUCHFX9t43E2lQzDrsGij2a
         qWKlMrNnULcrli+e5xrRaj+ph5EqdzE+JmZJ2UIIW2SYl/6VzLrIuUkuqFiSpm0sXYdW
         Y8qM8g5XvSjAPC68TPTAV4uVMfsyo1VlCF0017NSQT4qXbgOWZLS0BzeLcTmDhU5mO8P
         5tKg==
X-Forwarded-Encrypted: i=1; AJvYcCW6G342TfZJhHfDoP7pwwP3Tg3TbQpMoZjVKzzV8FUXoVB5sS3TEj5b6sKGPbaYEzqLMqyUehgcxlcovlIjLcU=@vger.kernel.org, AJvYcCXauzBqc7MjZUIxIMjWjNHdFTxsL5RQSTVvWhAE2ib3BbrYO5uxCeWqfkZhxbNYsnDOcz4m8esqKWH3xXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4m1tBRvtxVvD43SIVkOi3nOsj+3etr0cW2LxVdjauIAp96E0n
	/MFuMpvX7LdEyDEDy9nJHKWJUDZ5P0GQyWP4fjquBorIVLQm4MP/zkLN/Es+1zosVrSdiWsolh/
	pQ6vyjmiMkyJijhJcWlfo/sZW7xpIeIuC
X-Gm-Gg: ASbGnctm6lGOzJ+SIdD/X7lJ55nyJ83VYO6kldR6Pti2TEJanhLIfF/HAVf411sMoaV
	nuHOxSyBdYmuvspCfihxtvAS3v8r0pJKZmzxaOmDSLuWGckeZ9RIuP8idaNKKS8gTdkc5IV3b
X-Google-Smtp-Source: AGHT+IH+XXFFqREGae+Jscoz9PXcdZChejs86ET9tFEqvQY7Kg77JAOIP1felOCfWJc/ETpOt6vTAb5nokAsDncHqZQ=
X-Received: by 2002:a17:90a:ec8d:b0:2fc:25b3:6a91 with SMTP id
 98e67ed59e1d1-2fc41150517mr11101501a91.5.1739977722483; Wed, 19 Feb 2025
 07:08:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7SwcnUzjZYfuJ4-@infradead.org> <b0a8ee53b767b7684de91eeb6924ecdf5929d31e.camel@HansenPartnership.com>
In-Reply-To: <b0a8ee53b767b7684de91eeb6924ecdf5929d31e.camel@HansenPartnership.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 19 Feb 2025 16:08:30 +0100
X-Gm-Features: AWEUYZkyIVWX61WED-R_1ZbnvG_dmuQ0gYKwzOWG8-HIy6fPvnyinMwk_TWfF8g
Message-ID: <CANiq72nnnOsGZDrPDm8iWxYn2FL=wJqx-P8aS63dFYez3_FEOg@mail.gmail.com>
Subject: Re: Rust kernel policy
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:05=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> So here's a proposal to fix this: could we not annotate the C headers
> with the API information in such a way that a much improved rust
> bindgen can simply generate the whole cloth API binding from the C
> code?  We would also need an enhanced sparse like tool for C that
> checked the annotations and made sure they got updated.  Something like
> this wouldn't solve every unintentional rust build break, but it would
> fix quite a few of them.  And more to the point, it would allow non-
> rust developers to update the kernel API with much less fear of
> breaking rust.

This has come up a few times, and we indeed would like to have some
annotations in the C headers so that we can generate more (and to keep
the information local).

For instance, it would be nice to have bindgen's `__opaque` near the C
items, or being able to mark functions as `__safe`, or to have other
`enum`s-related annotations, or even custom attributes, as well as
"formatted-formally-enough" docs so that can be rendered properly on
the Rust side, or even references/lifetimes with an eventual "Safe
C"-like approach, and so on and so forth.

However, even if we automate more and even reach a point where most C
APIs are e.g. "safe" (which would be great), it wouldn't prevent
breakage -- the C APIs would still need to be stable enough so that
you don't break callers, including C ones. It would still be great to
have that information formally expressed, though, of course, and it
would help maintain the Rust side.

We have also discussed at times is documenting the C side more, e.g.
the pre/post/invariants we use on the Rust side. That would be useful
for the C side to know something is being relied upon from Rust (and
other C callers) and for the Rust side to document why something is
sound. Of course, it is a lot of work, and the more we can express as
code instead of as documentation, the better.

Cheers,
Miguel

