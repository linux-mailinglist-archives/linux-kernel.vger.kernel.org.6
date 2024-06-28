Return-Path: <linux-kernel+bounces-233632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E277B91BA76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FF41F2303A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8514E2CB;
	Fri, 28 Jun 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDERvh/6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7F14D422
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564937; cv=none; b=aGVShiQf0qvLWgqnhqkbHMSbvrzlMImZPP/NwBHDcYLip1X4tNWhBC5z4ouJfxhff0FCIH4132B7Jz/iCPWtS01VK8AO9kAfFyaAZ7uWeQ6sdQhbKf8nphwjGwatNVN+8mx6uE5QUAUqhddfjqHz/bPB4B6O9sMDmxe+Q0gHEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564937; c=relaxed/simple;
	bh=qNT24P69oZExcdybuxkfRZexZp2GF5cn+DnHmLdaWTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHDj3eStnMMfekTYsa9YRgFpBLKpolfjUDvB+o26HRKSWl95s+tn9rVRblVWIjAzRYvjPnJdNeEgPkJTcRYvkZkErj91A8OX+IIwp4zh8W3Sg6tniaia5HYS2vWLxLCApk2z6coZMpt3v3fglPKvE76Y84kJqKJXLW8gUh53IXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDERvh/6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4256f102e89so1899555e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719564934; x=1720169734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNT24P69oZExcdybuxkfRZexZp2GF5cn+DnHmLdaWTw=;
        b=sDERvh/6LV89l7xKiPO8KcN5+doDSnLjYn+9F8AwvWIoprno4NYEAB9QLRGvi7JYpM
         7L/u2qHCGSnFiMlWhl04GbkOAG9wTbdDLlx1mJMEzL68mRAKFkY39wpd1rhNDSucSIjI
         3wuI07c4DVxuFECRHFyfed6V2ZVL3KxambDzMo1o3R3tw/glrEY74qZloXAoyYgyJlMN
         NyvFX4ZWPQZqUohcZG7i+IS7ALZnZ8y5CxGosWN59WbIgSMUfa8D/KBQRRBf3DKKAcTK
         ETdJBcUxQ2w0Y9UFG58KSRneWI1XN6JBAxzHly4bcAX7ba6nAK2+LymeEHhXSzE0uSV8
         cQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719564934; x=1720169734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNT24P69oZExcdybuxkfRZexZp2GF5cn+DnHmLdaWTw=;
        b=C5oDPR0GEiv8OQCuJPWZmq7ovVRO8w9opc7yioia2K4bnHmi2sbyqCgYjTRAg7aKeG
         mb9sgnxWUSTlgH/8qq+qr1jc0HLZeIGtGH5UXRcUUXDRlpy8PElop9YtdYU0AWA51hnd
         74cr5sO39P9MVQ0j8IU/y5my2ifBwbY/GI5YN5HrTL+kmS8SBmV2sjHQ+PFNXAwQTdDJ
         KCzK45e3ig6PS0ITgJYhPVqzGzR9QJghGdb4DD0TOCUn9EuC+pROSRDkHmPfZlre1RHP
         WA28suO12XtGvtlq/TVF4pCQCrMGuEdeKiLWQf0VOU4E7yRtHKkmNcKQuvGmbcJCbhbe
         7fdg==
X-Forwarded-Encrypted: i=1; AJvYcCWNKvh2FEbwwevxAWeRQY/oYqAp6F47doYItKAT5PYrGSK+as3g93jA3WNpReBNRErJ2TWXZNguz3XpeF0eCzCLhgjy1GZVbKyJ1XGN
X-Gm-Message-State: AOJu0Yzqnrgq5x7I8EOPlv/muSIPODXHfDZczAAqiY/k7UMfx9W+M1oO
	ca/CR18ckNzHRdgdUei/AZGlQcuMij5nxtzpVce1YfoTvargz1IO7FmHYqogX/MIFvaNjaB+1EP
	ugwTRP18UugFfJJ58mWKi4rtVoBcbfXQndisw
X-Google-Smtp-Source: AGHT+IFEk7Cod2Hp9SvJIIWpoKIKJrvmi1ZmyTwUyea0Fir04rTr9IxaSmMdVqorrv7lReztOBBKgFNhP71zEk8/XfA=
X-Received: by 2002:a05:6000:ac4:b0:362:c237:5569 with SMTP id
 ffacd0b85a97d-366e94d8815mr9649639f8f.2.1719564934113; Fri, 28 Jun 2024
 01:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628004356.1384486-1-jhubbard@nvidia.com> <20240628004356.1384486-3-jhubbard@nvidia.com>
In-Reply-To: <20240628004356.1384486-3-jhubbard@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Jun 2024 10:55:20 +0200
Message-ID: <CAH5fLgjxd+nT4MzgY_DBj8STffAFETaqJZXjMP-_Zw5tqkbz=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Makefile: improve comment documentation for the
 rust-analyzer target
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg KH <greg@kroah.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Finn Behrens <me@kloenk.dev>, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 2:44=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> Replace the cryptic phrase ("IDE support targets") that initially
> appears to be about how to support old hard drives, with a few sentences
> that explain what "make rust-analyzer" provides.
>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Finn Behrens <me@kloenk.dev>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

