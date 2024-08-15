Return-Path: <linux-kernel+bounces-287645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F30D952AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EE81C21425
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1361A7041;
	Thu, 15 Aug 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLWkDSOp"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0A1A4F20
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723709113; cv=none; b=lMHYYj1L34sGrvW83NM1cF/T9jYcTh+5KwqEne6ZXBir5UNpJY34w0mvfI2ufr9RtVHX7wSU48LXgE4aLSXztc1jRhX++DifrmN6MfL+ryfxJZGVuQfA4PYBY+N9KBZfwGsdJ0JMdHDRbR8cIWogmDybU+N9dyrvMeNAE9euVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723709113; c=relaxed/simple;
	bh=z9gF/rR4YAP9Df3qlVcsOZgH5TMPEw3eQ5J9+Wi9oJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSwtMUPbWHxrLRJmd3GNwcajcGKZ1UIOLlFwVfRqMA1Mq4Qp/xYqSGcsop8xygYHHtq9Bc8udJp+ZxWzpOLW6mAZj24t2HAlpYxcHEPnbt5bX2Q+k7jHGgEw8NeIYmpcmdRgJfPzSqhfQv/juJIYRORPabMWMRyXxvVa47tFrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLWkDSOp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-530c2e5f4feso658648e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723709110; x=1724313910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9gF/rR4YAP9Df3qlVcsOZgH5TMPEw3eQ5J9+Wi9oJY=;
        b=PLWkDSOpMHZFKQsgTm8xgxvd+o5CCb62ZpXxOPO+Bm5p8HnWvl17l4GbzQnYYqQyQ9
         MWG5Bwo6ATSWUJ5zIxmBgNL97NNA/u5HM6cFx5IBiXxd3z1xieX4D7irf19IcfcFyLnt
         SIVDWcgBxV3SPNpt2JxgYsn0NMf0tDhK15+Ro2vbAcLT62U+uDIkMqo+daW27s4f1Lmm
         GKBEGMNJ1+ew9q+ZfFr3PbzlZCfBIQfaO7iJA9wH+CWuKxQvOgvhSOfqBfnxQcnClvfr
         iIVETwdOvJgDZOKKuV4Ltmd4BXVbVKOAvfqpL2PPEhqbcGi6d/lKlXS+cOc1gw4hc6GC
         EphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723709110; x=1724313910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9gF/rR4YAP9Df3qlVcsOZgH5TMPEw3eQ5J9+Wi9oJY=;
        b=vhybFiaY1S6usV8TBKCz87yMMtjjXPIFRopHlZwIqWd/ty8hy2qF62zCr92lkuBf4e
         RVklVAlJDXidvgwZW69ZFAafZD+BsVbLnD6msuA0N7+rqfEmi9A2gBS206yRmeUtfPMV
         9Bp4240nZk90C3M7Sq1jBdacTprMboltOsZ/rYsUAXJaE5INn82sh6H57BDS7AlL3b56
         iw+Zu4FK3RVGddp/t/sbPBfAzrerAdAx/YSzQS6pqLLzc0K1EtSxT5B0x1IoJuhgJHQA
         fA0kcUnBC3PofNl+kuEc5hgLszPsmMLlQxEz7aS1PlNZgBqZMN+FtkSk/HAbJBDR2X5B
         JCLA==
X-Forwarded-Encrypted: i=1; AJvYcCUDps54TrHInbVXWIvG5TRTmw5D6pD/OPsvW32S+VujsfvGG6M/ZLZbMNuN/j2T/3o0YM+uAgnQIX4xVm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWFqHYdoP3lgENSL3jkwWhH4Ijkc9yLyc9Rt8JLNxMdNlOLPy
	Vu1I4VwSbNsJo/r4J+XUBiiyiwDODU8DHirAgHATmLOIEkU1pjJdVtHrg4vaUe5ly48bsJ4dQJE
	hfULkWfENv+kbZPHRVsMsYwrIM2tDEEUYFav6
X-Google-Smtp-Source: AGHT+IGCOOMBdtfFVG7gZ5Ss3y66J/LKGslf+MKrMBKcw1l8XPOfnAgft4zB0125aa1c2yS8DWuc4vWYMO5cotvBUlc=
X-Received: by 2002:a05:6512:6ce:b0:52d:6663:5cbe with SMTP id
 2adb3069b0e04-532eda5ee4bmr2856220e87.12.1723709109517; Thu, 15 Aug 2024
 01:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815074519.2684107-1-nmi@metaspace.dk> <20240815074519.2684107-3-nmi@metaspace.dk>
In-Reply-To: <20240815074519.2684107-3-nmi@metaspace.dk>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 15 Aug 2024 10:04:56 +0200
Message-ID: <CAH5fLgih1QtO-ACyoifNsgqd=VtJimoGV+aD=3iHG0wb+iDGyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, 
	"Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:49=E2=80=AFAM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> When allocating `struct gendisk`, `GenDiskBuilder` is using a dynamic loc=
k
> class key without registering the key. This is incorrect use of the API,
> which causes a `WARN` trace. This patch fixes the issue by using a static
> lock class key, which is more appropriate for the situation anyway.
>
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-Genera=
l/topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctest.20=
lock.20warning
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

LGTM. This makes me wonder if there's some design mistake in how we
handle lock classes in Rust.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

