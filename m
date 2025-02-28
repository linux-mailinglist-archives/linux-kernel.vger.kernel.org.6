Return-Path: <linux-kernel+bounces-538084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C165FA49469
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A503B4423
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B264D255E54;
	Fri, 28 Feb 2025 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QEyuBrn"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E52276D3B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733689; cv=none; b=QSzP4EoWl2zY3q+eXweC+4zhxbFIx5dgZf0mqjd8CF9EDuv/7UiDTD48QzuWVwIm8mlvEEE4gadZS71qnslSWP315SG74getPZ2ogUo8/Y+WNXoXe8+5eojlQ/V5zAL3R/K1aySfdIYMppkGz5M5g6WbEr9dweBQkMpz26osELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733689; c=relaxed/simple;
	bh=B8Nw0Zg5POwoCggGay7I0k6JTFuZ0SJhXyxKpcrWTp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCRd78rbgLXESSoB1K1q/UNZoH/quEU9Yb78eWTWtz1zQiyvZcOnqNsdzv9GPYt9H6p+ZKNYzwooZwG6EEvV1mlUH1zCk9yruIfuA4zmm4Lg3LzW+JUNexHU7AHqlSNJ5MLMjEXmFYTaYKZV7vOFsOyJDuSZNoi0g06LNvs+T80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QEyuBrn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so11934665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740733686; x=1741338486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8Nw0Zg5POwoCggGay7I0k6JTFuZ0SJhXyxKpcrWTp4=;
        b=2QEyuBrnSCQAu75DDn2+0WE4quBBci3oPWsUTTG/QtfYsumSE7EuBJeTGNopqoFFxV
         a72JovdUrDVQfzWoMRn08th66tQcRLkQtss0QeJjMus6HGKhSDuNnUiIjNeYhX5pQNZo
         7z1lt+acdkwa+KZaSqEotZpePf6O9uZh2RCuVOVdUB9TNX9ncX30JK01C3JYhG2fFxvt
         eEm12NUbw5xohEocH8l9+DQ+qZyz3r8Xd57W/AX87MgiPUsP8qwoZW/tSh79BGhZmEnz
         nSPurF7xDrpk5qu6ztD239Y0xWxV2ep/pHtyZzTaLrKkPxRY75pL/wF0m/IAVC7cF/Jl
         Y94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733686; x=1741338486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8Nw0Zg5POwoCggGay7I0k6JTFuZ0SJhXyxKpcrWTp4=;
        b=dxDsPSUlZfKV52CVEKSA51IkYs4JbGX1/9p/4dV6jd2gtPKJU9edXTCIV7/j/PjcHK
         qmpnBbgHSkPXXEhMysHIdRKXkIuNKQHHnhyEjw0wqo6OHe4pVKHWtL5/zhmNpifvln3B
         LkT6TMOVqP4H+9pJHF8GVTp45PYyiWEN0B0kKjR3kaElxwB+WXzQdpAWZrcH5V1GkX/C
         uiVtj5Cx/mSnN6p+KF0aY/0IMYYTCmSY05RJBevIoyo9J35j6sL8nO4tG1Cm5GZ7e1CA
         67hTk9hXF7Px8Kr5wnARDaBJe4LG415eG7W7YC9F2pRG9QFXiVbL7lS9JJR39dDdNAaV
         IkrA==
X-Forwarded-Encrypted: i=1; AJvYcCX5AFQbTcX/Q8Xf1gbi7Ri+ShUeO5Bxga8Pfqjqsd/BC9YDqbM4OdzvOIO/B3ru4Bjn66XfV6T5CXnrFh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKC+jYJ6YhMeGL8giqky/PxL4Vvu7CEoOmuXaggvEBmgMDppua
	sAC+N6JCHGDcNYAn4p8aFiclta9ILEzbX+UEjwD1ahL/db/zCPaRmXt5Qt/qnX+Tz7lajA6EPMP
	c0tXtklt6oKrJjvjCj6wNJxHPax3CFPY5YxmM
X-Gm-Gg: ASbGncsa8IyYT1Ek8zoHh3NafXLvhOR7Auf97ZRrNiR9VSQ3ziRpRyw/C/mUc751oE3
	FfUSN2Ot3mtFvCjZ1YSJ17bVJhgFoK4neAWs/OsC/7AmjYmZ1o9Nhjdcne+L9WrGLqRi7FKEpSU
	B2sgVYc2oYBRYER676NeZROP+GbCgX1WzBs8D0
X-Google-Smtp-Source: AGHT+IE80qC3ASXZ1RmhTrY39qoKGqVIZ7x7t8hAZgq1bGKdO/fbDuqOX/rULKVYWxaD9Nc/GWhFTtikbAUeJs9LE3w=
X-Received: by 2002:a5d:64c7:0:b0:38d:e61a:bc7 with SMTP id
 ffacd0b85a97d-390eca204fbmr2206828f8f.40.1740733685688; Fri, 28 Feb 2025
 01:08:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227193522.198344-1-lyude@redhat.com>
In-Reply-To: <20250227193522.198344-1-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 10:07:54 +0100
X-Gm-Features: AQ5f1JqnoJIDiLqVA7PEKKcyNm4ciCBp4S5KCEfAVq2GSvT2nGYfPum-JBNWBUE
Message-ID: <CAH5fLghbJL=WVD0WFeRJMddfMQQUe2+xtLtenb-Ok7hSjCWq0A@mail.gmail.com>
Subject: Re: [PATCH v2] rust/faux: Add missing parent argument to Registration::new()
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 8:35=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> A little late in the review of the faux device interface, we added the
> ability to specify a parent device when creating new faux devices - but
> this never got ported over to the rust bindings. So, let's add the missin=
g
> argument now so we don't have to convert other users later down the line.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

