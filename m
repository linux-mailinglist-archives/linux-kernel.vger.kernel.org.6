Return-Path: <linux-kernel+bounces-396544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 962DF9BCEB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11974B22B11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5881DD0FC;
	Tue,  5 Nov 2024 14:06:22 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44F1D90A2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815581; cv=none; b=HKeM9ChvRARWhlY7TwCEl3KfkPfKLSx37I+5N4a1d39t9B6GU7XXEAWWMfazCl9sPFMQmy/+QhJvWCw/e9zpQBjcV67cAkTkSkuxuaP6U8FJRUe4fzwIUTdd4zj0H5n3pfj7Gh24/GGmYQ076QrKBXDny65+vtTG/ma1KU+7kGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815581; c=relaxed/simple;
	bh=ooqBMyn7IkY1EMB5+dADT7XFmLv2wwYQcv6WMw6VLUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI4M4O+Jv+har5c/vWWQcnLybSZQUzkKNT3flj4X/gpQYyN1soCNMWjvCytOyzS0V521aY04Vn79U9VALJTq5ZG7JgltNtocDP0GcEzL60FNnYL+2fXzjtsmyJx2lY6YOBuh+eo9ZF6nMRhrinRMuXy7DEaPQFYeCZGfXycA98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso5867300276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730815578; x=1731420378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dByBoeMx7u2t6CItkpw3sdIy9gmLIh3WMRbQfsLLyP4=;
        b=SFABPQpJ8YdAvletYGdDaWFOSJuB1+PzhcyWuxXsFZ366hKeoV8zKXsZKjytXtBh8p
         fYx9myIzYW5UG3OyL3PdAkE5lz04nIjI0GXP9mgqP4K34g1SZ6yTjsT65Kcf+chP79k8
         um+Sdk0eXaSOE2R5xLTE4AwIbkKQ2JpoppceV635qks7Ua+YUrUdNe8OyDxvIxoBzq8d
         0ikKUWWncGI3r/1ICL2xiVo68Odx3E3pBVcsC6FU1Dw0dO6tW9ZP6XXwMbudCqE6Zl1S
         LSX1c/tvvYXKrn50UOGAM80FqwUf2IzADumjQYXYZu77JWvriMJWV3ZiqpH6BYIWrdug
         K8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUf4L0Y4KzftwCMYVQYm/Fzdl8+0BfpX1Or5WyVJcp9y65S4GLu5YNzLw8v/XAmitUCnJdHchjtEYlTCwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWT453Ze/uXcQbLyov1zrQ3NJ1FzgcXlRTd34MgJ7SeNrWZjyI
	Mf6eVlHs9Sp2UdCUqvvz0Z4QBudsSiOXNRYdynCNGXJe1UVUoBd62w8Wsu1Y
X-Google-Smtp-Source: AGHT+IH/qwE+8vC8nBqd2e3mT4fDmLr8Tghgx6FMN3ePnGqUuMW7z3MdKU0k0fZt7D7NHW27QU2E0g==
X-Received: by 2002:a05:6902:2b06:b0:e2e:45b2:61cc with SMTP id 3f1490d57ef6-e330269228amr12869286276.54.1730815577367;
        Tue, 05 Nov 2024 06:06:17 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8adffd8sm2394622276.60.2024.11.05.06.06.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 06:06:16 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e5a5a59094so48706667b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:06:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoQnsdsyF7LUNn2JkwUpvdahs6y0eIIuqm1gC2W0S3zoFHHb5fWI343u+XFoDA49I7fJBY9wlFZ19d4a8=@vger.kernel.org
X-Received: by 2002:a05:690c:9c0e:b0:6e3:2ec1:457a with SMTP id
 00721157ae682-6ea64bb23e7mr163000147b3.29.1730815576068; Tue, 05 Nov 2024
 06:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020205758.332095-1-thorsten.blum@linux.dev>
In-Reply-To: <20241020205758.332095-1-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Nov 2024 15:06:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWF_y0dnOBzO5AazXVow0yJs4agFShW=Bk24jsGZgou9A@mail.gmail.com>
Message-ID: <CAMuHMdWF_y0dnOBzO5AazXVow0yJs4agFShW=Bk24jsGZgou9A@mail.gmail.com>
Subject: Re: [PATCH] m68k: kernel: Use str_read_write() helper function
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 10:58=E2=80=AFPM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
> Remove hard-coded strings by using the str_read_write() helper function
> and remove some unnecessary negations.
>
> Compile-tested only.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.13.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

