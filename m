Return-Path: <linux-kernel+bounces-365349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D26599E0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77C0B23D94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99C71C7B99;
	Tue, 15 Oct 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcJ7xyR3"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE001AF4EE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980600; cv=none; b=MuFDyaO4p7kB6jvCxc9j0WuULjBB+UL+CWY8Bn196+3W4DAOGq/a2MuyYSouD53irI6coQ7Vln9DVWNUdZcpHR8tFTeEhIxLm2qNP5iIcm1qbH6MsRS4E4FdWs2imYIg3gEQpPlwNUviIg9HD47QBjX2Q1pD3qV/9Wsg92OjBvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980600; c=relaxed/simple;
	bh=mCCrlw/yEpLXZ1vbGLNLrI1tt3ulJTMqY+P+85p8RWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6lPx32L2Mn3q17Am4G889WmBLiLaUiLK9ViTH/X94Vkz7xMfsOYXJufOSKs71H3CaoyF4eBsTWd/5gTRBUX5n9Qo8UwRmHEA5iJB+1cAwMfGq12zfZymreA+5yt8V4EdKVIjpf/KxX9fWu7tPKDcSdr160c5XjVUfIsG890Yzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcJ7xyR3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so1393528f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728980596; x=1729585396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCCrlw/yEpLXZ1vbGLNLrI1tt3ulJTMqY+P+85p8RWU=;
        b=XcJ7xyR3e9t0F7X9nq2IPcvdeyYiAeJV/UnNn4Emag33GhJo2dLDemS7VJSetBMava
         psE3k7DESJxCge4Z0PKvA80u8ZqBBq47m2matNtIQ85D1tP/oAeSKtzISqwhZLlGuDIr
         RGMXJBN/eMY5bchXheeZrmfQUlLf+gFpqRv8WRrYytAqxr8J3i23uWGXRRxr+zmm6KvC
         DO85pvoNTRbZv2W7kmXPcyW1Wl73fj3/R88aPDfCOcM1PFMWcf+kTBjJ3d60MEjBcsM+
         SEAp4YetcK5VPn1DE3GhDKBwiiFSiHy5dmaaxadpnq/KeLRVxFV01W19iC+hCdN3At0C
         GLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980596; x=1729585396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCCrlw/yEpLXZ1vbGLNLrI1tt3ulJTMqY+P+85p8RWU=;
        b=c5YqCPjDiOFgR5i+wkQUwzVXFxGHPDLSbyEP6fepODNR3rUGFdwRH+BdNqx1jnygZu
         dEu5nd1qHSRxpqiMTZdoPzsDOOenwBFk3wDJA86l6Lg307MrCtE6FY08+6aUbKOUDuZR
         FF8KRZvgpCAb6jKaP9Swt5URbG7V7gPcIYsJLtLcIjR83g0fo0z8W0okzelRmxbe6/C3
         bU4+NtU0fwphqCBjlAKYWFgXXEumFytD3c1HbHhVQZ2qu1BYTKPKeqqMu8pqBSjR3jkb
         G5K/aGQoBqLx//HorcyJ+pSXnc5ugR38kcLmC8NU4BawdXgLlSRb2e1fK5aFiXpd7q7c
         r/og==
X-Forwarded-Encrypted: i=1; AJvYcCWAXV/dp7jvxdOwjSIL6JbrX4Ei8lyvLTl6NB0uNk3VO4451VchiYWQ09mjXk0o9LVgBQMmoZxnINLskdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYLRZQtIit9vQDOc6Wx3XW/UHSIRkX+dfL7zCuWb+LWUiOVM+i
	tif6ZT4ehrx2j1ck9e2vxgl9A3a/um9kfzGxibkAvMh60WNi7XBqvq8uu0UZxYY3IfGXW+YzqxF
	ubMa6oxDcmZWkcj1uI9FSHU2V4SdOXDzFnSxU
X-Google-Smtp-Source: AGHT+IG02K4eUCM+WT5wVbI7W+sQfu30CmI+/4/ytZ4rrCCw1rQADfDrq9S1SteuyO5So2/j3Q5bGNYihWcFQHmjVmI=
X-Received: by 2002:a5d:452e:0:b0:37d:498a:a23f with SMTP id
 ffacd0b85a97d-37d600ca0b5mr8444900f8f.53.1728980595829; Tue, 15 Oct 2024
 01:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-vma-v7-0-01e32f861195@google.com>
In-Reply-To: <20241014-vma-v7-0-01e32f861195@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Oct 2024 10:23:03 +0200
Message-ID: <CAH5fLgg8NDEynr_dgrUQABZAOoSfsBajDRnipiuGu8tH3bFqzA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Rust support for mm_struct, vm_area_struct, and
 mmap for miscdevice
To: Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <liam.howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> The first patch introduces mm_struct and vm_area_struct abstractions,
> and the second patch uses them for miscdevice.
>
> This updates the vm_area_struct support to use the approach we discussed
> at LPC where there are three different types depending on the kind of
> access you have to the vma. You either have read access, write access,
> or you are initializing it. Each case allows a larger set of operations
> on the vma.
>
> The first patch in this series depends on vfs.rust.file for
> NotThreadSafe. The second patch in this series depends on char-misc-next
> for the base miscdevice implementation.

Adding Christian as FYI due to the vfs.rust.file dependency.

Alice

