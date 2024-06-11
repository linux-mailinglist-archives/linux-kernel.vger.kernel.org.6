Return-Path: <linux-kernel+bounces-209245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E1902F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A391F23669
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE1616FF37;
	Tue, 11 Jun 2024 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l8fthV5o"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382A16F915
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718079687; cv=none; b=AGq0CKtfC+QL/LSCnTkmFITfAcvGLv5kZky7KFXKJp7XhwP637X4lRJA0dh9QDS4a/7xbtpFbgJqFtTSPoi6jAGBo3U7Wp7HyuDj3Umg2FGxFO0T0+ILYrZkvc6sdbV9wJ3zAJki1slRhgrwzt+NIwqQRMEPUnlosslmEw9b8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718079687; c=relaxed/simple;
	bh=b44GjkyNBqeujCH+NPzsvRUdiEqakkwjTTaJH94UXZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVLZxe5gxaeIFv1jquOgOJsqHtN7wLzbvG6M5teuglq/X6panhv8fqTTbiKJrQY3EcmlDo6Jltvvv90uxURoMySn2f5MgiN1WtA8fhIXdzPTZjo1+oPq+d862Po6JM53EbfdOIRq7ezY0x2ltaLzARSHAd0RGVnOeKlq32bWjlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l8fthV5o; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f971cb3c9cso404194a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718079685; x=1718684485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EklVdHyvDTr3/lo2FpeHs1y2+JvBE7tPTVB+SmPAdQ4=;
        b=l8fthV5odZYqGeWe6LixQUjf3z2WeX1cN7e9dRUbkeoIv/YhzHonPGj8fqTqNXX2ft
         k8UUV7KE4GuYtBhMIlrj5s0ZDCsY8ymYq24cF+aB2HNJN6yNbZ3LxDe9830sIcQeTRQg
         TLWHgHwVDtrBWYCgo4ldSP5a9ELMbXoDFAItA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718079685; x=1718684485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EklVdHyvDTr3/lo2FpeHs1y2+JvBE7tPTVB+SmPAdQ4=;
        b=ZrE7PqvZeUyrNsdYDsgjuPsknpAqSF5N3TLjxg5VJeX1CuoOar1seGCJsAxOi7f57D
         fx6VMq5FlDUlora2HlTz3/Iyp5r4KaCVL3w8ZPm10PWYNEz6YXJ6QS6SVaCSIaSPx333
         pBIR8fpCwHXRT9ewubqbhemz77DMbLLwTvCSfzNwDOR/oaJO0b6bwhyfLhWCYJbVZUwn
         LdZpI8Hse7GhOUTC4Q+duAucLkzuS9zMzbneS7VOIiChBfC200Il7o9vEKIvkzugxZpJ
         53jLN6QuDwmaAWysmtGXdxfAC/CFjAGA7vFJYCkt91blq050/1g/3T1zFM4Nqax7UJq1
         iYHg==
X-Forwarded-Encrypted: i=1; AJvYcCWP+rdxabUt2KjJ+JRuQHXsGAK/2BNrp3DQUYPMsRkbAyM2m4jaJep00CeQZQGNR1M4Nq5nODEgomfII+F2U37CJuLpkXfjFxYqXEUz
X-Gm-Message-State: AOJu0YxZ4flIGr0uYikC2iiz16s2B9x7PGutRA+NWXdGCO0ubYLLIFW4
	FJmHWKWTax48+2XmruaPxJNYA4HZ4QsB0HfJOU7oH3mNL9YyewzPKp/VNV76Bckf8mlcN5JpWzL
	OCkYidWGCvrUJ8+dvzQ+Tlj1jIck6XJpjiL+A
X-Google-Smtp-Source: AGHT+IEeRKtmtjxMmre/EUaXcUHS9SCDfRXDteIausMJyVW1Gdf5SYIeYK/MjKfHWpWWOOhhqHhMBUFCuUsJFlAg34E=
X-Received: by 2002:a05:6870:231a:b0:24f:c9e3:b76f with SMTP id
 586e51a60fabf-2546441a4e7mr13254702fac.19.1718079685006; Mon, 10 Jun 2024
 21:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608021023.176027-1-jhubbard@nvidia.com>
In-Reply-To: <20240608021023.176027-1-jhubbard@nvidia.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 10 Jun 2024 21:21:13 -0700
Message-ID: <CABi2SkVoNyXLrfU71gnv1qVUAADpUmFXiDoKKPc54MLb5JpB+Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make headers"
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, 
	Rich Felker <dalias@libc.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi


On Fri, Jun 7, 2024 at 7:10=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> Eventually, once the build succeeds on a sufficiently old distro, the
> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
> after that, from selftests/lib.mk and all of the other selftest builds.
>
> For now, this series merely achieves a clean build of selftests/mm on a
> not-so-old distro: Ubuntu 23.04:
>
> 1. Add __NR_mseal.
>
> 2. Add fs.h, taken as usual from a snapshot of ./usr/include/linux/fs.h
> after running "make headers". This is how we have agreed to do this sort
> of thing, see [1].
>
What is the "official" way to build selftests/mm ?
I tried a few ways, but it never worked, i.e. due to head missing.

1>
cd tools/testing/selftests/mm
make

migration.c:10:10: fatal error: numa.h: No such file or directory
   10 | #include <numa.h>
      |          ^~~~~~~~
compilation terminated.

2>
make headers
make -C tools/testing/selftests

make[1]: Entering directory
'/usr/local/google/home/jeffxu/mm/tools/testing/selftests/mm'
  CC       migration
migration.c:10:10: fatal error: numa.h: No such file or directory
   10 | #include <numa.h>

Thanks!
-Jeff

