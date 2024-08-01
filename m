Return-Path: <linux-kernel+bounces-270907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D329446DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1629B23E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12EC16EBE9;
	Thu,  1 Aug 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJoQeVFq"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603916F8FE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501840; cv=none; b=hHoiBfclr1G4z+NVM6wXAv3r1xOZg5lVNib8CK0Pey6ar6KcDyxVEKkIePhEiW+pJIE0c9hzxRhuRFOj9K5BhNpBz+BykR2/cbZGifxGPEjSePdjds5vcXm1tVLJLzJGtaGixhFR8TrWISNxXhQZoc8rd30ouS7m6AjUhdimTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501840; c=relaxed/simple;
	bh=iP+wXHnrUpcj585wjD/GGe/CFFp7MnVySfl/FL8dnoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+fx8iFsXqSXP/r9uqWfYgsZ07zo4eqht8267+0OEz2wPA6Nl+XP6sSbYdQ/PFrmE676Hxe1cU3DZxJQMDbtxiu9trFQ9srtky5bsn01HZlWaC+53CVXjhz89IXx8gd0h8+MRRsxN3kvlfF9ZywMonPBJ3gAhY5Mgv1CGPeWYFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJoQeVFq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52fc14d6689so7075611e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722501836; x=1723106636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP+wXHnrUpcj585wjD/GGe/CFFp7MnVySfl/FL8dnoQ=;
        b=NJoQeVFqQU1ZFfu1azNimdeY6Hei7p6s0HUG7nqsQHsha3virRGljJXAvYPJD4sRiF
         TegEfiyoGqzfZQGhooQ9M+5z0G4pSjsSKcXT8DOGgOZvWT9FnBRZiaHaYIki7VTo2hK5
         qQ4QWG0RoB7Lq0W3S5UGk0UfBSi14lphvtEqgn78fqbsxcE67nIde4eY3UIYXod8hpBN
         BVhm+WTq/rZ/cIjW5gQOhodFEJSp+Vav2b+40goZ7/KvNFXKZgKx4ksJyHaMFlPx0aQJ
         S93K5BhzXZnchN/hGGav4icOqiX2JHTRQ2CdOab2j6BX/QGu3k+yyhacjVaAhPpnIljr
         XIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501836; x=1723106636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iP+wXHnrUpcj585wjD/GGe/CFFp7MnVySfl/FL8dnoQ=;
        b=wsa8sZt+nVanT54m5oDyf4aKbapoG9gOUb3qgLiyZMuyFdPHSBLCg297oN41kp1nTQ
         FT61abY3873xQWJ0PlKcTWEUlByefp1I2kS3obmSwfB55TZY++PC37ZGrFvuqPDUR2pL
         rSxToWLQDjmW83y4rVChvqt8rrTTOwexa5YFUKwp/qdF5zL2fX/M35mdi0x6ht3KayZz
         9esEmKS2MYE7OCRH73Nek1BS5vlS5Jhhjrj/vZRCRu2tpK3yrBew6L8fYH14WLKM+UWI
         Ls2tSRJXHsM/btAQEfqIyeeJCSHJKBCaxxq8VAO8S4Bc466ALpRLh+c2bCi4u0BtnzPE
         +HlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVttUMAdUU3Q3arouwntxZepz3wGwTq1+rmM+slD+NmwX5Q5f3XofEBx06yiJMgB/THeX0AO5zFj4EEciFjeacu7hTQYXoJVYpYj1ns
X-Gm-Message-State: AOJu0Yx3Wb+S5Of7q+Jd0cvRiuTJBppeXX1xkzg8uDYxUfmUV7GpN9mI
	XOhqA8+r6sDsUjH+rEkKJ8jvPS4NZ2F5kO0iYihtBMubop40XzwWky4gMoQx4quv5c6MgxnRCW5
	6wdiFVGeu48lAm5ydrl9RFYBZ4WAMaEbIV99M
X-Google-Smtp-Source: AGHT+IGdDsuI1EafN+ofyqULjxuCJRqqfXvKATrAaEwxr7DoXVNIozm//LiG1UZg7xqVBwAwG8F1llz4J7Ksp/P1ric=
X-Received: by 2002:ac2:4309:0:b0:52f:cd03:a850 with SMTP id
 2adb3069b0e04-530b61b8418mr887803e87.32.1722501836401; Thu, 01 Aug 2024
 01:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-8-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-8-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 10:43:44 +0200
Message-ID: <CAH5fLggy5ngdaEFe1oqO4wgZHTNsx=2A9a+5HNeA6GiUKrHPOw@mail.gmail.com>
Subject: Re: [PATCH v3 07/25] rust: alloc: implement `KVmalloc` allocator
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:07=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Implement `Allocator` for `KVmalloc`, an `Allocator` that tries to
> allocate memory wth `kmalloc` first and, on failure, falls back to
> `vmalloc`.
>
> All memory allocations made with `KVmalloc` end up in
> `kvrealloc_noprof()`; all frees in `kvfree()`.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

The nit from vrealloc also applies here, but:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

