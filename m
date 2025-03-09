Return-Path: <linux-kernel+bounces-553391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB0EA5889C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 22:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3BB3AB7CC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29821C182;
	Sun,  9 Mar 2025 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ4CNuWE"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A916B3B7;
	Sun,  9 Mar 2025 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741556852; cv=none; b=AG4pakGgIaAOuFpT1zvTXuTaNplYnUVCForKjUVN8U19faVKc7KXNFt+wv3EMH1XrKS8kFw5zFyedOjdMggcUHHLBR3bnfQ9dOc0W7wOUOwgrSSzkfDN4YoEEJgVhT5PxgYDxPuIaup10VURIhQoBVg7bol2HPMyeGJ5Axx7Cv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741556852; c=relaxed/simple;
	bh=he9CkGex1CvbnwtSXTNpqIGf8U9HbJfmNTWoQRIXvkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQg1HW9+A3zkPyhXzhNDBr416rZDXGxQ3WMSJgDfbeWf3+Hf8yGF+xzL6cMKNMDTjwNtIjjhmCaAO0IY3ZgJrIzgsIPOs6lV7fYOL3gcJZk5fjEzi/8VbgSKn1MxkROK7UWLcVrqt+EDf62m4iIPtulLwyq7RZUbM5pX2sjgczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQ4CNuWE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240b4de10eso7533955ad.1;
        Sun, 09 Mar 2025 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741556851; x=1742161651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he9CkGex1CvbnwtSXTNpqIGf8U9HbJfmNTWoQRIXvkM=;
        b=OQ4CNuWEvl4NgahBsAXuiyGRKyoFZ+gWSXzC8vMAexbHQN/LovMcSuGCXUweXqJE1c
         D7GVgyW8DMdtFsoYXXvjN2IwGNoh2H47WtguZGAibh1kasGKsY7d7uJU8uMp/+04eYf3
         dYnxpyJA+kt9RlNrWvpzbvWdB2a6WKA4TTjWqxNCpQx2hkGGvvn8uQwf//DQo82F0ZbS
         S2Zl8JciIsZJKuFzIFjigpylnypOHBU+/k9+K9Pro4cDOfq5Cik4Kag0xwfH+/aJJLpr
         zWFGX503MjdEPScxXICHvjSwC+NN4IHM48Q4deoDcR1ldsKMLe2RYD3pepYh2SI957OI
         66Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741556851; x=1742161651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he9CkGex1CvbnwtSXTNpqIGf8U9HbJfmNTWoQRIXvkM=;
        b=jLyaZ5qZnI8+wTMxL/EdYRAz2XSZHNe8gC+NQLraSuRJPiSCUw6jvRKIAMiGVDtRDi
         /CKYdcs6PI3vbxSowb7gBGRoY2TXVAVFGsd9ZJJNHSgWwU8zhSNmOC36lDg1gMrio3ju
         lLJXN6IroQtabrpDCMLnbHhJiifYVxDb8gmOZcuqUnvwA0qRQ/AlinMZhSXH9SE011Jt
         RXYlTbRbrW3z79bvSWql6OEc5YmAh3EUiECWrh2MhQk5mrMWNgPiy/aLSuFkEAqnypdl
         KALB27wcs6ndTWaEQfwlA3hAt943zyQOc5xjp+DdMZk8HcigJN1QI1Ph/ft9peHIpA9m
         GoMA==
X-Forwarded-Encrypted: i=1; AJvYcCUmf6qQ7o21SZGL1NU9wuZYQLIg4ga143m72hougA4hiRmHg5WuTNCIqWTZ2MZpfWJBukoaTukHMyLcS28=@vger.kernel.org, AJvYcCWKHVctKZ4kP5Avx7zpQv7OqQfar0AcZ+WoDGjSoTeyoyxeYAwZaLfdRMtwJZWNDDn5d5/FW5oDkU04h/+nww8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcvMrOeq8P5tBwFyFFrgUipEl6MgPZy9L89yqxjqpmNSiMeuSb
	8CJUQg2p0a62YWriEfUu04L8I5HeaVrMcDe+oiijvr1Yx18tlmRf9Lr6mxPcp9ZfY0j3xtYnDY4
	oRi5AZ9HLWjuwW076gzdJmteG+ZA=
X-Gm-Gg: ASbGncvBZACt+uCzR5AsF5uy76fwHi7mUpYqv0TssFjHqcYoU7IW048J+VHIDkIC3gJ
	RXxhIKq3Axaz3hDw64sOUpUb+Drcr6NsKFO3RtYaUtvU2rE2DwE8Ddeiyarg/gm3kxXhybd2joU
	BbuYEh/wQPJomR9c0tz0BGBoxc1w==
X-Google-Smtp-Source: AGHT+IHHuxqdSHS1K007A6kfxOz1wN53s+N9zAlCcZu0Yp6BrZLNmE2QYz9pO7i9GPx6QTvuF3tfqaTRL1IAnkpUGuI=
X-Received: by 2002:a17:902:cf04:b0:224:18fd:6e09 with SMTP id
 d9443c01a7336-22541626418mr40404735ad.0.1741556850650; Sun, 09 Mar 2025
 14:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-unique-ref-v5-0-bffeb633277e@pm.me> <20250307-unique-ref-v5-4-bffeb633277e@pm.me>
 <CANiq72mYfhuRWkjomb1vOMMPOaxvdS6qjfVLAwxUw6ecdqyh2A@mail.gmail.com>
 <Z8r0lVu1iwc9GG2t@google.com> <CANiq72ktwWOEBFB=y7xun-CDurwsSRe2_PE6RqGS4OhEyPGFkQ@mail.gmail.com>
 <Z8sXqXgfhHbNpG6B@google.com>
In-Reply-To: <Z8sXqXgfhHbNpG6B@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Mar 2025 22:47:18 +0100
X-Gm-Features: AQ5f1JrydlgDFPQEeacV3-j3XtmNEZQKWfK3gr2KGwr2o-DGhzCeg5JAqT5_dZs
Message-ID: <CANiq72k9S+E-Rfym0fPCrL7qjJR4xQLcjniEGfuVhA7v3Dx2Lw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] rust: adding OwnableRefCounted and SimpleOwnableRefCounted
To: Alice Ryhl <aliceryhl@google.com>
Cc: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Another possibility is to make the allow conditional.

That sounds fine to me -- we would lose checking for those not in the
latest version, but we would catch the mistakes on our side
eventually.

The advantage of using the `allow` is mostly less churn later on, and
perhaps fewer mistakes due to that. In terms of lines, it would still
be the same since they are single lines.

Oliver: I am sending a quick patch explaining this -- please feel free
to pick it up in your series.

Thanks!

Cheers,
Miguel

