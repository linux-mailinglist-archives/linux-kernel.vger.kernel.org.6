Return-Path: <linux-kernel+bounces-330899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B797A5D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DF2B2C7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45F143C63;
	Mon, 16 Sep 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qbf8Ib+t"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E500F1591F1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503302; cv=none; b=Pd5YG8jh9XRPJCcIHqaSUmv3Zg3OFmJswKNeUZTjAJq+ewlYG0F4X1vnmYNyyqnQ3B1pXgLFAoBpVXwoTtZrr07N9wrIqSUwf45IOADIMHaEzdnShxbMPyAeUeh8nlG/GCH+a+MBM/YiF6TtK7w4vymQNgRewXitQCVyqb1JkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503302; c=relaxed/simple;
	bh=wiS1s9vOxm6L7SGZsOGa9cdvA3FRdBWjMI6jegocdTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+OBJEF0QZfx9Jv2oUXMv03o2+nCjS7bppxLJwH33Fad7L+ZMmIlt6qr4rs5Vawbj4jDq87uzfPgd7Z/kUf3dJQtmI48saYH+2lbXXQ1h806FcD+oMUsV+IA3aHmfedMNX74xC7rt+GVJR32rVBcKphLx3SiJHVeWqZgfXEeK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qbf8Ib+t; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d50e844d48so176804a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726503300; x=1727108100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiS1s9vOxm6L7SGZsOGa9cdvA3FRdBWjMI6jegocdTc=;
        b=Qbf8Ib+tBKP4bfZgEgriVHdRC2gCg/a94jEMKdNRdaJDSii1XzXP/nuzuAdRyv2A91
         QshtmSwkrSOEa2pDtzzG3REIR2TbCBiCo3RYfPjbCZEm7niWRSgtzA6QGEzLz1IvjZS1
         G3Ph+pFQ+Is126/BA4qDVkNxHDve/F0rZCaZE/2q+2Nzm0RhsmHx9OHYgbP1HCJfTjhI
         3zxlfyzprCP+tYq0JaAQF5jtjDtxp5g5WbENlK5RmUxsaInSTZp0KrdciJhj0+ge3yzk
         QcG+kExCprvLWyYsZgljCEIB8db49LsB4S92zuARfvC6Ww1olZH59JWt+SF68Kq0/0if
         QqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726503300; x=1727108100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiS1s9vOxm6L7SGZsOGa9cdvA3FRdBWjMI6jegocdTc=;
        b=BJBQRRh5HeSdgrVhLBQVjsTXpqnKzsfMfHKjVlxR1N4Y4zkAmy3ZySjYFoUnWN2vku
         TbyhzzCxI1bxmRok6TM7VmiLx73k/43+kDUHUXC7ImSCPJ9XCHZP5DtTwawjNY4YFzd4
         fkJb8OtCzDiZ+PZqUFjJbWlwEkwyc8pQmcsz9BtLWysm9M2yjnSRQ5yPwtaHTEcofzl6
         gn5QgvfwPOuu20acDM0Fes2/IceELm/Ute/lKpUaMPY8uKrlUqwWVxYYKLWWwufrYEn9
         mC10dE1fNq+snNCSZ4VYrGDxv3rUtheSbTQHQ/hQBGqW45DordCPRZ6lugHtZaNM7nmP
         3y3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJJGLe0akcXyBckkS0cgUsH7gp0FjIqYaMDvIv1SYjBUaiP4C5+zF3Q0y54ljCzCOerbxxDmGf9PjtYmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxohvmDcJ9fCwrBHry4leUyzK3TiJexmMcwS6B0dCk+snio8u
	ylenuf4GzJrOqE8nrq2+7lLQqB2g40RD0FeLrrD+ZAnP6Dh0wwq1gTQBXhc+/IlbSD3aaneSCdQ
	mju1moWq6KWv3jl23KPxD/xoeWls=
X-Google-Smtp-Source: AGHT+IH2c/8wN0ZQCLiGrnVaFRtMAy9hhOJ56G4/Dn7GWPQcdYPiTgGY5zBhl3cdTJF13hGzRpO7UkV6Sw/atGsf1sA=
X-Received: by 2002:a17:90a:5e05:b0:2d8:cc31:6c5b with SMTP id
 98e67ed59e1d1-2dba001867dmr7480536a91.4.1726503300191; Mon, 16 Sep 2024
 09:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814161052.10374-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240814161052.10374-1-andrey.konovalov@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Sep 2024 18:14:47 +0200
Message-ID: <CANiq72=EoDbhyUXaLqdgkDEQNJoXQHWNdBnAmC5uzHCxBrJ+Tw@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: simplify and clarify Makefile
To: andrey.konovalov@linux.dev
Cc: Marco Elver <elver@google.com>, Matthew Maurer <mmaurer@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:11=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> When KASAN support was being added to the Linux kernel, GCC did not yet
> support all of the KASAN-related compiler options. Thus, the KASAN
> Makefile had to probe the compiler for supported options.
>
> Nowadays, the Linux kernel GCC version requirement is 5.1+, and thus we
> don't need the probing of the -fasan-shadow-offset parameter: it exists i=
n
> all 5.1+ GCCs.
>
> Simplify the KASAN Makefile to drop CFLAGS_KASAN_MINIMAL.
>
> Also add a few more comments and unify the indentation.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Applied to `rust-next` for the Rust KASAN patch series. Thanks everyone!

(Andrew is also carrying it, but we agreed to do that).

Cheers,
Miguel

