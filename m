Return-Path: <linux-kernel+bounces-529155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E9AA4207C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44733AFF68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C481254862;
	Mon, 24 Feb 2025 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYL73n9L"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013B254843
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403325; cv=none; b=KhevKYuNnmzv41DYOJaGwFbwUNedm5Z501XULmaR+JZlZFUt/vmkRyWkdTX80jYxfEcC4w0w7iZH3cZlsYVnv8eVHF3AlSyDvy2Ds/kiq4YmUD4bbKJyoumsie8rl4cnu9cnPDqcxtgbijFrtUFFaI3UP2eHoEnMWQ6V2gHfgGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403325; c=relaxed/simple;
	bh=Xj1kzyc2WJ6AjAa3xK3LVX/Vz40HDej/IgKIgDxXOQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tB4yTTxzQ2ElnO5Q9c8CVogXEvIM15UvIUkgW49Sp8DVb0nwlcC5lVQlWSr1l1RiDn+RUds62bRsEsZ6LhGW5L/Hx1HkQ23QbmBq94rlfYO21A5Yk+f/LRKZq2hSUv20rC0ABD4zRg14pX9FsTmYMQwUB0yoZtYMDirx9Xt+rQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYL73n9L; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f3ac22948so2198530f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403321; x=1741008121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/oiaAMAVxmEUGQ/a+kIBTCrAHvCn9ugUOtP/RUtk38=;
        b=uYL73n9LJI1lCB/jwV6l2PmchEVs27RNUisH8kJFYlJ195PFqNdJadfRzrewct50zW
         2JhMkR4Xwfkz7jm56gIQY1uIcvIE//5uy0Kt4U9DWM5jHY29boCEZ0TSYI3XrnP7U0D3
         YsZoGlrQMMUuiWR/lWaAEz9i4GBHNDiNqCgC2hT+XlyW2Yg1WY1eDDr7IF+3tHlIvOxp
         doPd2dPfCO94kGdeebvjjFNYXhFquqqFtgdsWoKdxqc0n+bBjVjJawoCYxvdSPiTv6aH
         Nq523Z/WC329SL5x6hctyCXrh89cOq+0+nOzFDAE9ff1iA1RqBZm6qkoMmxN5kMVY/U9
         ayhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403321; x=1741008121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/oiaAMAVxmEUGQ/a+kIBTCrAHvCn9ugUOtP/RUtk38=;
        b=jKzoWf99ZLfQOd0GcP7Rxp3vULTveo2iJqllqA8fqgxHOmA1jRSqdlnGGBfNdJZe5Y
         YIDbXGAuEAP5P3SryE8r22xVhDbSunHslocxDF4HSC/Gao204p+kNc0tm4vY5UKhI0SO
         WJsiirm30YIpQOtSGU+TSYzz6jgtTMiU2BZ10vOFlUJKzCmbVjCZOUN+2HMhNQBttxac
         t6WGeEjjddT3ZwKWCmKX6hEq8Eyk9BHPnHEaRrlIqp6tCjAmMysbWVy5aCqJxB4gnBak
         YfUNbjRaxtuHijiOfVWfJiDC1KFGZge3czuLZF1v9HGBtTo58GhIYhv3YarvijjmoTWl
         kxgg==
X-Forwarded-Encrypted: i=1; AJvYcCUKe3yUfsE3aHYEvNS6JMe9k1w6+f/ZZzHRHCCh/lNP7zyNDA2I64qEi6e/H4tCHRct5uAlsqjYt4pj0EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycrXXkFcxFPClr1XpTcnuAsSPhpkr23IJuT43/h4dmnXtDkIBz
	53GHnu4po4Qy3+/JJCIo3UVZZOSBGvl6KvG9bKnCyx4IIZ0r0nxcNpDtK2bD/LhvCxrDRFnhNHr
	AvD0aJgT5KqbwLxasHMJ3FLO0VmW+qdZWAi2i
X-Gm-Gg: ASbGncsABtHgxXN2woIik5Mn0hULKVtR1JpbgaQZzjxmE0U0SNLY2ph+0QKAoqG3KdQ
	AWM9pAI8+1hGfRdy4WAAK9qA80FITPk3WXDc9ZxPFhD4kc8iloMidTQ+soc2MsbEMq00wAWL7Zl
	WgYfgiI1YoDgZi9RXl/llb5Np7WjBroc5nkE6L
X-Google-Smtp-Source: AGHT+IFATPleR0RJ6PuqfMEUDzRhsvzlMhaXdbWqxYCjtXu9VzNOnOg+cerl/y4Uo40ThVMEEUAZP+PRp26SoFcKstI=
X-Received: by 2002:a05:6000:2a4:b0:38d:e48b:1766 with SMTP id
 ffacd0b85a97d-38f6e75848cmr10390968f8f.6.1740403320054; Mon, 24 Feb 2025
 05:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com> <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 24 Feb 2025 14:21:47 +0100
X-Gm-Features: AWEUYZmLTsIy1fyUwTzeMd_646qNT7R9svbjnKF5MTp-t9JjPz9vZCjijiRddJM
Message-ID: <CAH5fLggU_sU56dEz6hQvMwjY=G2TuC9GYiVEBZFtE=Tk2QW4Fw@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: dakr@kernel.org, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:50=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
>
> Nacked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

> +    /// Create a duplicate of the `CoherentAllocation` object but preven=
t it from being dropped.
> +    pub fn skip_drop(self) -> CoherentAllocation<T> {
> +        let me =3D core::mem::ManuallyDrop::new(self);
> +        Self {
> +            // SAFETY: The refcount of `dev` will not be decremented bec=
ause this doesn't actually
> +            // duplicafe `ARef` and the use of `ManuallyDrop` forgets th=
e originals.
> +            dev: unsafe { core::ptr::read(&me.dev) },
> +            dma_handle: me.dma_handle,
> +            count: me.count,
> +            cpu_addr: me.cpu_addr,
> +            dma_attrs: me.dma_attrs,
> +        }
> +    }

The skip_drop pattern requires the return value to use a different
struct with the same fields, because otherwise you don't really skip
the destructor. But I don't think you have the user for this method
anymore so maybe just drop it.

> +    /// Retrieve a single entry from the region with bounds checking. `o=
ffset` is in units of `T`,
> +    /// not the number of bytes.
> +    pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
> +        if offset >=3D self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`
> +        // and we've just checked that the range and index is within bou=
nds.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { &mut *self.cpu_addr.add(offset) })

The point of the dma_read/dma_write macros is to avoid creating
references to the dma memory, so don't create a reference here.

Ok(unsafe { self.cpu_addr.add(offset) })

Alice

