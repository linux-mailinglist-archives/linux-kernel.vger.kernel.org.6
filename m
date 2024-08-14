Return-Path: <linux-kernel+bounces-286845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4BD951FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777C61F217FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED6D1B86D6;
	Wed, 14 Aug 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhvFhXtu"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098ED1B583E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652332; cv=none; b=dbB2QEeBKyFkN13gzN0oSbsEf0oTzAHhu6+soAa9aiS2OderYFsCEgIxF8TSct/Ars7lWtC0Nva0hHw+C9Xr9RieaZeXxmZubbNGrTQ7u2G6IuDjG4tu7B82F//AjGt0/k4zBgtvz2+pVHpFZKTjHeMgwrQD9z/6bA6JZnkRqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652332; c=relaxed/simple;
	bh=PB5dkBysx9T6fJTBpImmumJYpuaHzNjh7FBAg1c/aXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYKI/jIKlFIrUMnl90BrSbS3vS/AWwAEKlok7OD3buAuCwaalTs9dDBD76qwUOQA9SVC6wcP3JtsumLJMBnaMZxp0eazFNllmebJykDmoIRoY+M597q7R2lyj8h5ROF4C1u5BXxMpHlhr1nqAFi1jkU9jkhWAXO3pkOdUMjfFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhvFhXtu; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso670461fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723652329; x=1724257129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB5dkBysx9T6fJTBpImmumJYpuaHzNjh7FBAg1c/aXU=;
        b=UhvFhXtu/U14ZsRN7z6Qlr3NZts+pe9/ztUEPBlAWEpDnjs+iXYZFL5ITH77/TFSzc
         RIC9BcYaxgNJ8m8xtt/NhgmRHXq1saPm0oYIIlZH6vx+EDM32nGBOsOh0Tl8seud0sCx
         9PJ/vNUvPJr6/b1Wrl4VZj1sw3vbAiQgT/JkNSeCyP0G8P5v8G1ZwCbBET2xLiKZ7t6s
         tltdS0ifJbeE05NO1rzaMHFADBnbY3f4t+apFxfpEcA30fc3mP9ew71nJuCbGABqhTYa
         1Y9rwAe3oSgPpQqsv+3vqdU1LDoOHIO7c5MJc7O8Nywu5zd+Bf6DfJd/hOhO+4IWUzM7
         8rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723652329; x=1724257129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB5dkBysx9T6fJTBpImmumJYpuaHzNjh7FBAg1c/aXU=;
        b=JQjHicjn1SkrpdPcXD6VaHc8L+T3OGrnflF2mTP506PCi8hPlhbxIgTal5v03D3FjP
         aIxmJkcKT48sQnC4ukziPAz7+2VteTMoi+c7ErtxMLH7iEoLw1+KKvYJ2lVG6XPHuhrU
         aLtFJ5gOITIyBn926HFuhiztFiaz2HtO38qh+OT12ixQgPwTUljNq5ztJ26gVlKrIhje
         DsdHvaV2DAv62VhF0ykG4VUc0SmoJjQfHIjVGiqXwV1VdA7DmqswjnSaizUPcddUB46p
         y5nuHgHsy8mA7Cn7M6APbKZA+4BwAAXTHW0EzJFv3dvGvOoOnjt3AixEhj1JUiI8jHu7
         Tp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnzsLQ29q/l2CGWlzcyu5DgFrJfMn6J9PwIUL309UMiZIWm4+YHa8zN6bmskI7YdHcZjDk0tKZYDmeMH5Ef97pq9OXpYKW/DOLlx+o
X-Gm-Message-State: AOJu0YyxlIh1uQz2Di7SZ00tkE66gr2tcj0CqJGJtqSgYlXPfvx3i0Cr
	B13RO/gm+j3S7K8ztGL24Smo7Fv0Ykksa+t/NyHSg4ZpzQXOeor2/klorr8p43BWxabY0xyrl83
	XpmD4r74/oxvLMia4E6FLIkt+xdc=
X-Google-Smtp-Source: AGHT+IFdJJ9Ga94FBFog8/Rs/M01x5LqjaXMvJcUJF2wIIPlOEq5QOPwKCyibrm2Nbrd4U6tH1VD27icCgoXLwh3u20=
X-Received: by 2002:a2e:743:0:b0:2ef:1b64:5319 with SMTP id
 38308e7fff4ca-2f3aa1bcbf6mr19089351fa.11.1723652328498; Wed, 14 Aug 2024
 09:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814161052.10374-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240814161052.10374-1-andrey.konovalov@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Aug 2024 18:18:33 +0200
Message-ID: <CANiq72mAce+-NCgBTE8FsaKC=87x+tGJ6xWU=BTiOLPGYObOFw@mail.gmail.com>
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
> From: Andrey Konovalov <andreyknvl@gmail.com>
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

Looks good to me! (I didn't actually test it, though!)

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

