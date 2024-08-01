Return-Path: <linux-kernel+bounces-270939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD3994475E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB70B244B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C4183CA1;
	Thu,  1 Aug 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlxXRyKR"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D6170A37
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502908; cv=none; b=EJByAEgZeWvISwgLfpN1aVLegU/0i4EvXVEuE9EFcm+I/tlcE9GxN8FFo5wCPGcMOdtPh52qMpcEhucqATpL7nM+UEjxfnhyrQEk5weZ1tlPN1BCSTV2qMjweXtTWk5dDw2Cfz/0gYB/+1vVuLvjUPZ3G0i3mST7dhvSdY0jAoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502908; c=relaxed/simple;
	bh=wxn5DmtvY5tJjxAkykMV8xdmufUHERfyxYUef3tszTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnGQVmtEOFKiyueKouVRcZgzfLf59/p3kWeAil+FvHYVptZ2tD7WAYD7V9sQ3FVABSPqrXLJHoY6HUB2RFLqXrnqUDgEtebXOT9sbFM7u/54vh/+6zRgIurBf9ATu+oTDFoajJdPBVQtc52a81s0eX8SSwRdxsWTSIrJl8+oM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlxXRyKR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3687f91af40so3705665f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722502905; x=1723107705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxn5DmtvY5tJjxAkykMV8xdmufUHERfyxYUef3tszTk=;
        b=JlxXRyKRTG2s9rL14WMtBu2/R96AOZrsRD1Jp/1OJQ0a1HGhHrPKt+wpyNE4+dEGS7
         0FjSnwH+57auGulJ5IpAVfz0gb/T6a+yVW/RbKle8H9S/XaGRPqvZF/dXUKhqJu+6KRT
         jPwu/+5WPGEvTTAj9N6mQ5Cxk6mQjz2/zAh2En2mNiXhBxax58E5l/t1VxjvFGMwfKsS
         JBVn38LcwzvvoZ1dco7UVyMSg0UCG1MtSLbEa3bFlrxhSWR8VYrUj/gudimTfjPb+2CD
         P1GA2qVYkplooGJ7r9WwC7UiEEXXP1Cp6ffDgofXYn6fhhmxwHIdXfBM1WMLn4RK0771
         IFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502905; x=1723107705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxn5DmtvY5tJjxAkykMV8xdmufUHERfyxYUef3tszTk=;
        b=HZMnw2ZClACvVkw4CozR8H84sSIcxoTieDfDHYm7zOq+rDNVry5QNzAjNwJUGHmH6t
         9y+RNwnNCQhUzvIBwUIOF+mvXLUJTcy2LFWcvQNZMGr2qGiDkAIgcQxQDgbQNkmNE/n4
         QA21Bblk0D1U6J8UFnBx1KhQKOO2RTbKCDSj8yRyEZWjhQCGiorkYiU2CXd9pobex+M9
         YqacY8TkpFctkeWh5rOFaKfDc96FbQTliFoQ7jOvMpku79X1jUUssXD2HQgouDLfoTbv
         5dDg448PURT0Mb3kqUpPnBTYIC01iIap8VUKr9juyDQVsEnVXWCaBcmHj2OtOkRw9u5A
         h/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCW9sUiHwzgjkZG878nJ0IAUD7ITFJV6UXlro9U/S7IH3LDM0vnIM9rN5sIFfY+WDYnUR8grLHrFSKtuoQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBg5qVXgkA7ViqMK8O+F57xvSXJY44DMOK8FiqpIClybwoMaNk
	6vu+LMtKxjR+101sySfnqWx68y5qnyRlwbREtuiiNcad8n0opmUkXIzPrsMeyGQAqGFGEzBv22E
	ot+10TAfMpZFUgnC2SrmfeMBb0O1+KLZGPEkW
X-Google-Smtp-Source: AGHT+IEwo7ISwcTUk5BerlDsr2Gba/hr79v5U4FhsjjVg1c+9j0R5sUDJ2vbwzB9a93avQK1HQ+mamY4hBB7YwLmOIw=
X-Received: by 2002:adf:fd8b:0:b0:368:4e38:790c with SMTP id
 ffacd0b85a97d-36baacd1c74mr1390718f8f.14.1722502904273; Thu, 01 Aug 2024
 02:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708205325.1275473-1-benno.lossin@proton.me>
In-Reply-To: <20240708205325.1275473-1-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 11:01:32 +0200
Message-ID: <CAH5fLgg7HNmuzYk260Z1Qv-xYQnCCGwFBCsyoiykSu27nQi-Mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: kernel: add `drop_contents` to `BoxExt`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 10:53=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> Sometimes (see [1]) it is necessary to drop the value inside of a
> `Box<T>`, but retain the allocation. For example to reuse the allocation
> in the future.
> Introduce a new function `drop_contents` that turns a `Box<T>` into
> `Box<MaybeUninit<T>>` by dropping the value.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e=
134390ce@google.com/ [1]

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

