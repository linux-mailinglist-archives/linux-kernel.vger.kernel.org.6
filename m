Return-Path: <linux-kernel+bounces-316538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61796D0DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3951C22C34
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001631946B8;
	Thu,  5 Sep 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqlqSlxM"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC8194096
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522763; cv=none; b=OncHwywVxVxTk9Fu7iSVzgWNVAGYtix9ICjWEIrb700ylYu7bzBPPQ0A6P4wyzYB+XpY3oJNkjoPFficEBX6OX6rUv90yOz8Wu9RC2Hv5hzv2yam+kw3K61OgrVykxjSqPhuD24jYUhlOnDoNXcsLnG4xvOb+GCXeqMDX4hLggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522763; c=relaxed/simple;
	bh=edlhfocYTBb5RSXGKhxyCJoY2mjSJV4yCAz+HGPdhB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ljl3Cae8ilza2SPt9tAY3PYFuC+Uz13vjTvXz4lP6kHZq8V4cX1nXQHJgXiecid686vH0cZAiZPtqaIQlWEq/BwseHT5CBt5msXNyYP+ZrzADCAMC8nNYLb41KUL4uONV1gc7sn50+K83ZhX6+qA/Z5PTZN7d2mYl/QP9kyahGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqlqSlxM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374c180d123so212080f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725522760; x=1726127560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edlhfocYTBb5RSXGKhxyCJoY2mjSJV4yCAz+HGPdhB4=;
        b=LqlqSlxMetbqgCeOuKJUUaWRw+brrRsqjEv2VyCniz+CpWYugqZy0C4VQRrwmysfYX
         lNdv48eduzzsSrwUxDrHovViv5gO3y4S+zQnezEe/jMXnIPFvF5yCUWqULvbJyAzRqnC
         e8szkRZQEcqFbbjsqLkKKf3+I5eRhqcKbDBpQowHaXR/nXq2fxazuUTfY8h/4d75AxPL
         A1PQXnRXQe08K44rczz6/uxq9gm6jvV3bin+fdHBdv7a3uGi9gZT77gRpc5/n1jeM1bG
         69tqZvtmizGWrrt4FMb3zAARFb5E18x7JQEXGofQs0GuRpFP5QlB16mc0mbEgh7AjbYn
         7IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725522760; x=1726127560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edlhfocYTBb5RSXGKhxyCJoY2mjSJV4yCAz+HGPdhB4=;
        b=s/pK9XATAdTowX37vDF4pob3P+phObrWF2NjxbvKea9cO8lvBT147NsFRgpQHydNkN
         oNE/a+CE9ZTbPaM5XA2H9sRY3llQihpxNFW0Ky17VskMocnXPMBanUMvdGIef7+PaAHy
         dte66iwzrAwrONVE/tuhTHgtad1ffo5bPWrpnoJQLwO8UadWUY8UX2F5LwEkA1Hi2/XI
         Tug/tD7vKyRPrgADLlehwVmSszlTnS/003sL38+ljeSeNe5eJYgsANtWQz9PvuFDTUEF
         MUSrLTLHovRVptiI916n79PoPM6PYSD8H1QWdtz/2MjTROjF4Z4dsV7jzhOvPLF/Ckj2
         l5uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD23dVVOQ9OIIbiseIBLmNIoWz+HlW/R3uYLEgB9IcjTpxuXDA9D6+OfDwBRmnVb3C6Z334cwuIucn3t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/7pgOKyzwicUKX0QiRfVjqxNa8scbkjjiPFObQGxshIDEXHM
	WnLQW6lJwcN4bitA3swKOlyrratXR346utdkqW5P4a/CiYv+fqIeiprAawo1lAJkMZkTXPNhEu+
	+t8PMfPOLGbDPCKI8Su4hRyXJMU95TMV/PFmz
X-Google-Smtp-Source: AGHT+IFK43pFnPLGUXRCs6+/ppb+2QpfbK6ADGGjBpmf0Lo7PhrrA57wrAnEXXwtIovQ4N0HLObZaRzV3HTp0jsNSrg=
X-Received: by 2002:adf:a351:0:b0:374:baeb:2fb with SMTP id
 ffacd0b85a97d-374baeb0c2amr10826925f8f.35.1725522759687; Thu, 05 Sep 2024
 00:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905061214.3954271-1-davidgow@google.com>
In-Reply-To: <20240905061214.3954271-1-davidgow@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 09:52:27 +0200
Message-ID: <CAH5fLgjqdchRvVGTMLYPTZ6erakKg3sNhbSA4dLq0kLAXLWxQA@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: block: Use 32-bit atomics
To: David Gow <davidgow@google.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 8:12=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> Not all architectures have core::sync::atomic::AtomicU64 available. In
> particular, 32-bit x86 doesn't support it. AtomicU32 is available
> everywhere, so use that instead.
>
> Hopefully we can add AtomicU64 to Rust-for-Linux more broadly, so this
> won't be an issue, but it's not supported in core from upstream Rust:
> https://doc.rust-lang.org/std/sync/atomic/#portability
>
> This can be tested on 32-bit x86 UML via:
> ./tools/testing/kunit/kunit.py run --make_options LLVM=3D1 --kconfig_add =
CONFIG_RUST=3Dy --kconfig_add CONFIG_64BIT=3Dn --kconfig_add CONFIG_FORTIFY=
_SOURCE=3Dn
>
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Hi all,
>
> I encountered this build error with Rust/UML since the kernel::block::mq
> stuff landed. I'm not 100% sure just swapping AtomicU64 with AtomicU32
> is correct -- please correct me if not -- but this does at least get the
> Rust/UML/x86-32 builds here compiling and running again.
>
> (And gives me more encouragement to go to the Rust atomics talk at
> Plumbers.)

I would probably go with AtomicUsize over AtomicU32 in this case.

Alice

