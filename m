Return-Path: <linux-kernel+bounces-390484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED869B7A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE836B215BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475E619CC1D;
	Thu, 31 Oct 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA+KhHMa"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E682198A0E;
	Thu, 31 Oct 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377664; cv=none; b=iwdjdn72np8CRsphQjA5r3Ydzv7p6uCVGBgu8muoXiKIi1TEKzYoxxjddX/hfwwviqa33K3dEZePxJ31yhs+oKibidTJjV1DMvcwZuSdpipHWHfqYesrAn/2vSqCbj4jdzmm3mKS4BldDvMoRvGFOlq5TrSvgTJOPjDcpNevXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377664; c=relaxed/simple;
	bh=2f2FwjVS9onJufta/g0XnwYWiZbQ2E5zbbWuSemr7dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLrd2Ii4BA9WV9mAVvtbZo8M3Lxa475PLiZ0KwRYpU1n08uOjytjJwIkzrWl5JIX1DtaZ4xynbfo2/DOflxEzaXl1SZ7e11+BpJv0AsUeug2tWyflqWhmqZ4QwMQvNeSf9mOIy1VfrboDR5elbSTPm02djeHRtPdCDusa7ZbB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA+KhHMa; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso101213a91.3;
        Thu, 31 Oct 2024 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730377662; x=1730982462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odcUYvsYLdeICior6+6tFe2Km+FAg+O9mLlpAee680Y=;
        b=YA+KhHMa3Hm5Zx+lsh0HLsGzi/OUh0Scyp1xO2YnqqL1QaLKSfPMPDNdZFzz7L06qd
         bWQLwuN1Ckat9j2CAq7vxarWScY3GU7dMBKiAZo8R+jyZuHKDO3sX++X45LaxgXQxU77
         thh/zGAOuk5WuPhkDKX3GW234JV9wB+jY7GteDlMvVMOFWRhONSxhQcdh5zB61JmnWYs
         6jnuvZdEnZiJWXLoojD15BL8qd6esCd8XGlF7PVVlJdGR7yNKR8XwYZzEkqARkwjyYXe
         7xXHRYdP6HhqIdHghZUHDk08s6G4XTonQ38TazkbAxCWzPdybA5rRoqHRnWlManD2FIH
         zKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377662; x=1730982462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odcUYvsYLdeICior6+6tFe2Km+FAg+O9mLlpAee680Y=;
        b=cmhpdJBHWsaHkHQXGmApAKfs3pIBMhiMqfKxi5uJkh/1Cjhzh7p3KcZEjrKsQyldrf
         jljfVDvC/XCOesRKOWTQJUNsgqxcl0s+4YypkAxy0JPMalpgYbXxLudf+ygJc1Ticot8
         qr1XMfPCA36+CKUcvjt1Y8xsHwO6NUs6vEtOUj/+gsZoxMloQHhnameQtUzeCpvMMl+/
         sUwxJAq93Nk2VX/DEC/eA6kFlfuWLwILLdZj5YoiTtJ5QIk+oBXpRezeSb7iQyBqeFRW
         yaqyKEdi/hcgatGBFTnfBmkuUv9JH9AgSdSkmfB8NsYGstV0v9OtZ1+TXBcx+Gj13OYX
         4fYA==
X-Forwarded-Encrypted: i=1; AJvYcCV+X0Z+eCReKoqLXgjDAWPqOanyIcjHtneS1k8VjKw5mt/FBwdfLc+K3umFegqSedqMOziVd694LX8qZDLL2+Q=@vger.kernel.org, AJvYcCXGPxs36GHUycv0QACLBUHrQA0D5VgbM1dKPOXxeig2377Hqd2N55vwjXA64KvpWrZYgpGYHlvwLLSiUTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6LZX4Cc64OKt2zAl2fciZCyFMjbMRetzFwqwO2Z45OT4DVysR
	pZzw804nsK09yd71IfaQAOgonaFuVwTQ/iiVdDLxX3VVCn/B8JKDAdgXAjvpjrjiM9pQZcrtPpu
	mfh19AQk865vQyvjyPCOwCMVz+/liHGmAJXg=
X-Google-Smtp-Source: AGHT+IG8tgiQfVWD6reNJmxRYR9C5VqhfOefz6CNHCp9HaJcC0OjVs6ddI1ocUDyqwnbuyGAyvdH36ndBd2cTuaFbjQ=
X-Received: by 2002:a17:90a:d808:b0:2e7:8a36:a9ad with SMTP id
 98e67ed59e1d1-2e8f11e864emr9305765a91.9.1730377662312; Thu, 31 Oct 2024
 05:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
 <20241030-borrow-mut-v1-5-8f0ceaf78eaf@gmail.com> <CAH5fLggeAm1qobKzUkjw-+oNQRnCaDH2f2TTiRvmrRMg417LCA@mail.gmail.com>
 <CAJ-ks9mHp=uZUq0BN6D33+s-eEO1vN+1a4_mZahuqLD9-A1UeQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9mHp=uZUq0BN6D33+s-eEO1vN+1a4_mZahuqLD9-A1UeQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 31 Oct 2024 13:27:29 +0100
Message-ID: <CANiq72meJWYH+45xhZf5abOqSwnWAaDVOeKG7ahLtOUa3w_8ug@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: add improved version of `ForeignOwnable::borrow_mut`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:23=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Thanks, I'll add it in v2. Does the order matter?

Yes, please add it after the reviews you picked up, i.e. the latest
thing in your commit message. Please see:

    https://docs.kernel.org/process/submitting-patches.html

Thanks!

Cheers,
Miguel

