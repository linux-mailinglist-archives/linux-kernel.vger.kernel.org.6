Return-Path: <linux-kernel+bounces-551222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05703A5698A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262661891AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4021B90B;
	Fri,  7 Mar 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6RPpifQ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4421ADC1;
	Fri,  7 Mar 2025 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355625; cv=none; b=Aj3SeS7ZjtT/sCB3Ns0ieVuWmqvo6CgpLHjyt9mM8F5/w7via6cPB7tOYV7xZAeOUtdgxPH72YwLFZc4eYcylHPRN4n7FbaxewfN9Wwu2hUk8XtvuXU6uxG/TMeX/nrrygnETRq10tS14v0ivfDPaOkLYKLtfrtH4XeUQEP1ypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355625; c=relaxed/simple;
	bh=ICxiMibbj7/tKhMbuP5/fz3kSyF+kvyKF+wZm6FMOLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ahn7JAZouC1tpiGPpJB2zD5tsDCrIvChYgLU1o8feNQESUIG39im4ZWDXaX+S2u6rQBzVjhapjU9i5wcNTojoUmXkIrPdrTYC3y5smE2d8MDWYmwJuCsuKXNdKfrwlKIX/pwN1iFGKQDPoYeeaEmxpk5xtWRnezJuBz0+WRTu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6RPpifQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so347778a91.0;
        Fri, 07 Mar 2025 05:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741355623; x=1741960423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICxiMibbj7/tKhMbuP5/fz3kSyF+kvyKF+wZm6FMOLk=;
        b=Y6RPpifQFCJeoqs1lc+ka/LdW2wir3vqRuqwv5UYeBakI7h5a3etCPO2aYl/v+WXml
         Dy39dL8BsQV+jGgI1kvSFN45KeiVuWVXaRN/8LuIImfpHHQ95AmUrd3T7ZLebRbhxFRa
         LZkU5HY/8wouvYeYFlrveePxN6QJ4WHcugU4K0s6tVJcXCo3dvSJOtwpDeNssaLp+tdn
         6nAM1dyn67QSoqgT5miMFZyL/XMFa0hOeN8Bt4/DyRlZRtGKpuFQCDgoRYy4XwcIt623
         ipAf6ePU14BTeXBOdu7AhHPWh/tRQjyJpFXAOmrDmVsExloN4Zr+Vh9ceLqvtVHvJ4df
         0mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355623; x=1741960423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICxiMibbj7/tKhMbuP5/fz3kSyF+kvyKF+wZm6FMOLk=;
        b=LpGHO+t8wFKu3VmN39sRYZqwnTWc0leu7Kp+AmXBNdTFM9QweB3K9XcWwUaT+B269n
         dhTKmbHTtnTFZ+f2R6aKDCflcM5U2j2YOJiTHOWYiujTpuvttBI453hHFeyo9ZrRSmEp
         b3E6akYXPHNyvm+UKnO/fiFqmfr9faWx7M+QeHq33bcMLpIBKFqz2De64rF9jQlMT+Cb
         zGsXUH9UCaJB2VpFqXWXgYS6Wx2OhzdlLyJSaJC66sPjhy2WdWNkkrRc0IOz3htZqtCR
         p3yuuCtlhqlqGM2qi6gLP77hvxbrP6BPgvFz4znZPh+h06VBL1b7DdOyzGRY2fCsmq7Q
         nFZw==
X-Forwarded-Encrypted: i=1; AJvYcCVOaH17jMNBkXoQUcn1ga8Xus257VT5jIWucFpr1Fi9VKrWpfXHElxG2cMf9M+A/V8MaNGO9Qo06qY6fCY=@vger.kernel.org, AJvYcCXnnTUsQQVFMoYhb/rcgArE/GqO8rPWLaLFKLB59Btsf0mm3pedkiYZUg1wTJ3Pw/EB18xuCiZJrXAwlaYP1wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAI8O4JwFiURmQX9mLsy58bGzmJNXaSjR4eiqMZsvbUIiyUv5m
	2hKEmCaHtDRU3qmQZEpUKVm+iPGCluxkdyf2wq0GRK2DmVDsmNtu8jcuubLCA6uUZEnMfTKUObN
	iFgaQKZ6WrZbzq96aARtE2WbBsF4=
X-Gm-Gg: ASbGncvri/MY8JhX9oLwEmS2xvau9JOi1t5eSTo/IMAzXgkJfpXWrhsF56rWPOZr4X9
	UW9n547bd0XybELANS94pOU/2wE2S6FWalej4lPpIBCq7aFONTS+nldLBPovQPmjt0UmHGTgL5R
	O64Fg1DV6lSeVrAI/SBj2HWtTnow==
X-Google-Smtp-Source: AGHT+IFQbcKjUi2+xJZx4EkN+BspY5NHugd3fzYVMpj+dJXJ3xySIPBfObitihnepytnRmP5lK+vkym6p1cjkBcfvvY=
X-Received: by 2002:a17:90b:3ec9:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-2ff7cd6f5bemr2128991a91.0.1741355623295; Fri, 07 Mar 2025
 05:53:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-unique-ref-v5-0-bffeb633277e@pm.me> <20250307-unique-ref-v5-4-bffeb633277e@pm.me>
 <CANiq72mYfhuRWkjomb1vOMMPOaxvdS6qjfVLAwxUw6ecdqyh2A@mail.gmail.com> <Z8r0lVu1iwc9GG2t@google.com>
In-Reply-To: <Z8r0lVu1iwc9GG2t@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Mar 2025 14:53:30 +0100
X-Gm-Features: AQ5f1JoQTL9Pdvi4rbt5tbARnPPsHx1yP0hj_YtrcqnCuu_AF579F4IENsrqsfE
Message-ID: <CANiq72ktwWOEBFB=y7xun-CDurwsSRe2_PE6RqGS4OhEyPGFkQ@mail.gmail.com>
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

On Fri, Mar 7, 2025 at 2:28=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> It's only a warning on older compilers. We could just add this in
> lib.rs:
>
> #![allow(unknown_or_malformed_diagnostic_attributes)]

That is OK too, though we would lose the check for typos until we
upgrade the minimum.

Hmm... Since we have nowadays the way to create those conditions
easily, I think it is fine to do it conditionally.

Cheers,
Miguel

