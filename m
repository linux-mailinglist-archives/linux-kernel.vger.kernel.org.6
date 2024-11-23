Return-Path: <linux-kernel+bounces-419197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41349D6AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 18:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9625B161962
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2BA1422D4;
	Sat, 23 Nov 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fov686rr"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAE17C2;
	Sat, 23 Nov 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732384176; cv=none; b=pzX3lgLsZyK7FTr+rFgPgbg1jPrsDucoclVjqAiaRMVRBk6UMU6gWQgQRAGAekRyZOmM/0IIm+uQruZ84V7QRAFp1LJtuEcJ/QMKQXL/pLzkTusS6H6h0dP4epE9PkdhQpPsyojOual1GvlZ9wIl3ksR5NnMYlZG3JBpCrvizf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732384176; c=relaxed/simple;
	bh=Mtp8FUi5/gxlqwjRBdfVLsB1XG5TJYsg0hjbR9M1rO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHnwmAS1X8ossOsioTlY2SY1Y+GpLGTRffijflSFTDZafpz8EE2uvr27U1T3oFD5WFKMc0pUq6nybpeMiHGnr9fHLO6RB67nyIHz7XOescNASty3QolYsVpQV74zN1GSFKu02SziQpWfPvKQPa7l+xkAi2FWV55w6mELE8Mqktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fov686rr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e9c1e7268eso380200a91.1;
        Sat, 23 Nov 2024 09:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732384174; x=1732988974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtp8FUi5/gxlqwjRBdfVLsB1XG5TJYsg0hjbR9M1rO0=;
        b=fov686rravrxn2fATHTr2ex75W3wRMOWcEn2nxKrdKpvHx6aY3o9QnGh8zx1ptpcWh
         inje5Pcqz/rn0g0o6mX1lPhmZnIE7RHPV/MfsaqtqUzwIdPq4VTI+7yAQjWNhv0XVLVb
         8H4swgJQir7UAcfhaVzlfHCc+OHJZv1H9rwelXlTckg/ZWfF0MUSXU86qvyXxQRjkXox
         8B5OfjVrYSzUGEt4AE6EQcvBVm2R9ZJ6qU5Dgrs/dhk1WPCa7woTJldCCQICS3omrVM7
         UDjmVALTlA+iI16xUH0g1ggl4QcVhbADbOIUxVmk2tugMYzAUvz87Qh+1DsSdyl93FEy
         Q6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732384174; x=1732988974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mtp8FUi5/gxlqwjRBdfVLsB1XG5TJYsg0hjbR9M1rO0=;
        b=p5eCzz18y4DGiCsGHyPrA0d9eyM0MIBU3uPE0hT0HCOAHvBt8SCthggCU2V7pxZMc0
         mdHDh+OYw0pAM93qmasgi5wYrR7Sh/rVe9PvOoNJ0TrAekEpijTkQ43jv155luSIORZz
         J1Z0QWDeNLyfjgSlQpXg7KtqxppSdTyR5+XR/ZU/wDxZz2V55lTA5DL1j8bDDNQ17inr
         GdlHVYQK3dAio1U/OI9a0kK+c4j7veHP6jEGBddWA5tdZlrD6gkMJGD/RhUPZqNbNkXK
         rydDIsKqkLHcrwMQvLYMvmkuBL7fuZ4hi7qNq9sJhS+iebNd9xP+YWxvRZvnfL777G8H
         LN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJhNQWpCwKKlax/Q8bJldNqABgXF4tOG8zkc6ul0jLSNCl9NAhwH+kD++h80bvlTHX9pmGANqZOje+3Ts=@vger.kernel.org, AJvYcCWhUIq4Mqsz2d7lITBPT0ZGfg18XuRodK/Z5jBEVqBZaJEY6UzWJdH1VErAVgo6w3Ntbs+WwxkHZ3DVJQTwDIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrFIaMUCWgPaeagNd3dHdiFniRtmgFyfhBQ1O3EGKExfFSHzQ
	nwcwNkKVt0hUR2uee+R3htr9UJRJXCMeMWt1Ves9XSxlCyKeLC3c8//PzKKS0kcReSQ83X33oHb
	jTcgbgl9qVMxDCcCkfWIEG1KQM5c=
X-Gm-Gg: ASbGncsKAZrTUegqnHruYNOczx/FFKvTf2T8ERX9n7JwvaZrk+lYLezdr16H4j5Bisa
	rS7vO+/P5IzsRI5DivwWKwTQ/pvmd6g==
X-Google-Smtp-Source: AGHT+IHCehXXGlMtIxdivTgLYkpRePIeVeEWaX1a1Pny2+jeeCC5ffRcjrzZZSWY0n2E3esmRDTg/lomQT9MHL05cPM=
X-Received: by 2002:a17:90b:4b42:b0:2ea:a9ac:eeea with SMTP id
 98e67ed59e1d1-2eb0e025c93mr3757582a91.2.1732384173993; Sat, 23 Nov 2024
 09:49:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net> <CANiq72=axLe_WvPohRRpAnmmPOHtwSK1W3e86n7FMF2mao8HUg@mail.gmail.com>
In-Reply-To: <CANiq72=axLe_WvPohRRpAnmmPOHtwSK1W3e86n7FMF2mao8HUg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 23 Nov 2024 18:49:22 +0100
Message-ID: <CANiq72mZnF4kMYEUsLZs0KSi8PrO1L6BzFZ6f4B7W3+KiyNuRw@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: Fix `ArrayLayout` allocations
To: Asahi Lina <lina@asahilina.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Janne Grunau <j@jannau.net>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 6:39=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> (Square?)

Ah, you mean eventually on the actual allocation, never mind!

Cheers,
Miguel

