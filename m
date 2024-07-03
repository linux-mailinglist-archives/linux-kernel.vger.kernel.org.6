Return-Path: <linux-kernel+bounces-240070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B434F9268D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53F61C20FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D5818C35D;
	Wed,  3 Jul 2024 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IWKJMU35"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C75187570
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033527; cv=none; b=l8ZIsYcEbyzJFDoEBiS9Gx9HRodqL9mhuN0VmUKS6XA1PZLjlKjGjNNpxvtUpx8kmltj30IMzGL2IfjX5wn5dDe8LK1TICLhqJRt/hhokfrsG5qdrG1yeS1k+PWzYA357+OPMhSz6wXZlggk9NuNPFdL8Dad/XzISAytIrWQG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033527; c=relaxed/simple;
	bh=yBaVYEswZrvbgKnS47fptzlPQ1fF8FvBjoGLyqFPLwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ahk0Kd7Zr6XAaKgfUQqw3b5LR6vgY7S95yHGSfuR3yuhqF90kJXHDADdXxbGdyD8t4lcKpewNWVZSSl073gJMT+A87OA7YcUSZ/D0nHoLIPjrJtHnVGpqh5rK02OufFLJA2LZCj6Y+NfZBHa4evGF69tu6nG4Qn/0Rc7QuA+vTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IWKJMU35; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so3719963a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720033522; x=1720638322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Kf3K019bVOQK2OWkQy5jBzht4Y9Q+WIcCF0i+S26bo=;
        b=IWKJMU35MMgb8R4OuqhG7VgWgClKuBrGhGHzUQ7LoSnJ1/UjZIk1wcr4U/gUoIXFlq
         SDfU109SwKweM98JxM2ICEdthPW/c1PrBrJBA5rKKHSRw1LRpNsbWu2lGvsylMIgn8vu
         j75gwUWpTpKhY9fGDEdyVlYqwFObKjdaioIfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720033522; x=1720638322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Kf3K019bVOQK2OWkQy5jBzht4Y9Q+WIcCF0i+S26bo=;
        b=ATmTQ8x+g6YXJ6tnN7+YPFEt60/v17bLZQr4igQzhVK47/eIhn+DFfYkN4eS5jIJDy
         K37agVjXNjWxhBTTisoSDG64jRR96dYhjtBopWRGZVr9qSXRy+tabWitV+ouAQ0pgFKz
         UWa49sVizPXl+dNTMIwv+9pflrcfZ2MOU6qFWRHIqMh7XnbxzKcyjDCbvAhBgunvb+5M
         AQB2T6qUE0u4q2obgP81P5jJD96wrlNJyiWmeb8HipJC7vwLmE6FdfWkLkJrrZBooJAx
         sEd6oavOrBrBkZVp814APMNxBgu32yhct0ldNfJxqlAgpz85nwGB//JZWMIxMjO7sK4g
         JOiA==
X-Forwarded-Encrypted: i=1; AJvYcCVLkwJWfveaP6YeWUDYzIAahmQ1L7V/CEc6i/nq/fOTOvRXlieYnlcEOX7f9qHEp/+JBraL8iHpwf7n147bg2zepZPjyE62o/O5rd8X
X-Gm-Message-State: AOJu0Ywrxt0/E8uJC9l9i8NRBjF5T0ZgibZx9wbeN9SIpt00FQTDi2f9
	oOeEZgxMKwghalgg+U62BW5uhoC908r1rDnonQi0dPfZSw/Ivs3ebNKh6aPR3DjpKe4U+pTf57v
	hfsJHcg==
X-Google-Smtp-Source: AGHT+IG/9xdA2N6T2NJsp8fJQs8mvgD/j5HQPQZ6IDpGPt7OAEy/585NkhkaRnLl6rPn1lcyzmKaEw==
X-Received: by 2002:a17:906:ae58:b0:a6f:ddb3:bf2b with SMTP id a640c23a62f3a-a751449f19bmr824715966b.41.1720033522601;
        Wed, 03 Jul 2024 12:05:22 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a754425f2c7sm159410566b.162.2024.07.03.12.05.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:05:21 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77b550128dso1359566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:05:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkq/6B0jqUGHy335IaIB/TbBvV3/LJKktYdZygmQf2cawokaUVqk7hD+41qFxAp/+kuhv7Z1XKuDx9B7km4abKEnUDyZQBqxDedUVk
X-Received: by 2002:a17:907:2daa:b0:a6f:6721:b065 with SMTP id
 a640c23a62f3a-a751448a5a1mr1186982066b.32.1720033521063; Wed, 03 Jul 2024
 12:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625110029.606032-1-mjguzik@gmail.com> <20240625110029.606032-3-mjguzik@gmail.com>
 <CAAhV-H47NiQ2c+7NynVxduJK-yGkgoEnXuXGQvGFG59XOBAqeg@mail.gmail.com>
 <e8db013bf06d2170dc48a8252c7049c6d1ee277a.camel@xry111.site>
 <CAAhV-H7iKyQBvV+J9T1ekxh9OF8h=F9zp_QMyuhFBrFXGHHmTg@mail.gmail.com>
 <30907b42d5eee6d71f40b9fc3d32ae31406fe899.camel@xry111.site>
 <1b5d0840-766b-4c3b-8579-3c2c892c4d74@app.fastmail.com> <CAAhV-H4Z_BCWRJoCOh4Cei3eFCn_wvFWxA7AzWfNxYtNqUwBPA@mail.gmail.com>
 <8f2d356d-9cd6-4b06-8e20-941e187cab43@app.fastmail.com> <20240703-bergwacht-sitzung-ef4f2e63cd70@brauner>
 <CAHk-=wi0ejJ=PCZfCmMKvsFmzvVzAYYt1K9vtwke4=arfHiAdg@mail.gmail.com>
 <8b6d59ffc9baa57fee0f9fa97e72121fd88cf0e4.camel@xry111.site>
 <CAHk-=wif5KJEdvZZfTVX=WjOOK7OqoPwYng6n-uu=VeYUpZysQ@mail.gmail.com>
 <b60a61b8c9171a6106d50346ecd7fba1cfc4dcb0.camel@xry111.site>
 <CAHk-=wjH3F1jTVfADgo0tAnYStuaUZLvz+1NkmtM-TqiuubWcw@mail.gmail.com>
 <CAHk-=wii3qyMW+Ni=S6=cV=ddoWTX+qEkO6Ooxe0Ef2_rvo+kg@mail.gmail.com> <e40b8edeea1d3747fe79a4f9f932ea4a8d891db0.camel@xry111.site>
In-Reply-To: <e40b8edeea1d3747fe79a4f9f932ea4a8d891db0.camel@xry111.site>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 12:05:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJh1egNXJN7AsqpE76D4LCkUQTj+RboO7O=3AFeLGesw@mail.gmail.com>
Message-ID: <CAHk-=wiJh1egNXJN7AsqpE76D4LCkUQTj+RboO7O=3AFeLGesw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>, libc-alpha@sourceware.org, 
	"Andreas K. Huettel" <dilfridge@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 11:48, Xi Ruoyao <xry111@xry111.site> wrote:
>
> Fortunately LoongArch ILP32 ABI is not finalized yet (there's no 32-bit
> kernel and 64-bit kernel does not support 32-bit userspace yet) so we
> can still make it happen to use struct statx as (userspace) struct
> stat...

Oh, no problem then. If there are no existing binaries, then yes,
please do that,

It avoids the compat issues too.

I think 'struct statx' is a horrid bloated thing (clearing those extra
"spare" words is a pain, and yes, the user copy for _regular_ 'stat()'
already shows up in profiles), but for some new 32-bit platform it's
definitely worth the pain just to avoid the compat code or new
structure definitions.

              Linus

