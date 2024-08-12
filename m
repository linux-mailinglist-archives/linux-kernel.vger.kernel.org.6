Return-Path: <linux-kernel+bounces-283700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745B094F7EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75841C222F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300D194C8F;
	Mon, 12 Aug 2024 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGhcbeXN"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ABC192B8A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493144; cv=none; b=sIAmT+xwYYlu4v0yp69gSgWISBAQgLJDS1njshlxnyRnEKS6BzbFb8M6GJqZ90Uqw/30KylIgkOCBFF6bAfI3GH2JItkWxOAaXVXrixl1b/Gc/l/4CgqEZpF8yHwevJHmoywcJaKruVxMjQ+DFcyXWYT81OKDrkLLo/LHFIZ0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493144; c=relaxed/simple;
	bh=HC/HkWyioaVWnOz3y9LbjBN5t/NvM6PBmTS6jLGhths=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7CrJev3ULrBcMnVRYjmz1/lev8x6hY6DRZcYGSQ+GDqdC++AUrcy/Dmf3hIx1OgU93t6S7ergXRcY0FdbgxXxB4j/IuemdXFEGwLEd57ek2Yyl/VUqXjQuw+s9M8fOCJPKCBQfdjPYYBDT9VRSG6Q/ZWmlhlMLRCEHWk3LfNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGhcbeXN; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4928d2f45e2so1737849137.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723493142; x=1724097942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnjAXFWaZgCI0dpAs+P5rMgjpQhkOPkxKEtIirlNQ1c=;
        b=zGhcbeXNH0y0qYXQYvGU/FmNu/MJMyKH4lK2R9CNKi9AYUVpjMBvayZ/1SqG2C7nK+
         GLH5H2M9ypXwOBqdp8pRjuFHXvYsy/4FcOJaMp497obpfQA0/ez7LEOiysqRh7DnBDv+
         t/sM8eIjPNG4jw0iloJe5z33/SAEvH+MxS35+kVYYtb2aDDZAjJ9UrUU2CWcauAEEJyc
         dbs1c6JaI9ZBKO6ysGLg8vmqpf39x1VhDrZuP3CpX5dHLKnJIPhAAxX1orkc4TH2+EOy
         creJdPKd+Vm00O0NePjJcMc4rQJVZ2/cHw5VePGC+905+ETRq1+0JzVQS3gNADGkC2YS
         q+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493142; x=1724097942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnjAXFWaZgCI0dpAs+P5rMgjpQhkOPkxKEtIirlNQ1c=;
        b=hoXShCQLOdv1DvS8QExU2doQKLtWpn8Vw0CDB2tJ+VtwP2h1oupJplFmmnwBZe12R+
         ikvvsQJcWaKWwWS9k+C9Q0aV+ATucrcjxqwW6Xwu5lQhjkOnF9PMKGKuDBwdvijnOrYk
         MPonRxVd6q0EEn0yf1Wf+T3y/xmY/hXNSKMj71jYPm57P7AHnSQzH4kUNiUX7CEkYDme
         8P1o0vTTjy3QoLmehU92l8Hd+b/epEeydX5QLNHVq2gwob03+E5yy3st4VnEu3ZOU709
         N4JFod2qbdqJfFpypakKfENacSCSHX90UsK/MBN7D0ktQPTFAEwLXquJrDX2vWwNEYBo
         ETsA==
X-Forwarded-Encrypted: i=1; AJvYcCVbfKY2+JydK6RNaglZDf6pQKbWXNk+A8wikk4fRTYw+Ifr5zwwZSW6SEnRj9U23T9ADoWaZcCeDG1LFYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwrX2L2xpjcdtbeQN4x7aFuHcgmFh6HXvjd8b5QYrfZzmvI+a
	fTHd8TKhyXt/powChnP1gq35Sm+PU/BhyPLufPGpzy8ywOFVugBgsRCaOe1KE5xxWlxTHZHwv4u
	kMWdrkreINwy6bitMAjoYqaDqK6X4QHMTY0/t
X-Google-Smtp-Source: AGHT+IG31k6RccFznpnDkUx0m1O+jpzSukTGwRy5LjT7DRyewgvZIkMnuGNZ5xTP33CvjDzt7YVKEu4yj3kt0flHHsI=
X-Received: by 2002:a05:6102:b14:b0:493:c3b2:b5ba with SMTP id
 ada2fe7eead31-497439ee096mr1934349137.6.1723493141891; Mon, 12 Aug 2024
 13:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com> <172348819834.2826487.9112203772355447388.b4-ty@kernel.org>
In-Reply-To: <172348819834.2826487.9112203772355447388.b4-ty@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 12 Aug 2024 13:05:30 -0700
Message-ID: <CAFhGd8qz3YT=fC3XKkD1ydwijps=7hzhLhvVrNpzyNxfXM0XKg@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:44=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, 08 Aug 2024 14:43:56 -0700, Justin Stitt wrote:
> > When @size is 0, the desired behavior is to allow unlimited bytes to be
> > parsed. Currently, this relies on some intentional arithmetic overflow
> > where --size gives us SIZE_MAX when size is 0.
> >
> > Explicitly spell out the desired behavior without relying on intentiona=
l
> > overflow/underflow.
> >
> > [...]
>
> Since we can't have allocations larger than INT_MAX, SIZE_MAX is
> sufficiently large for this use-case, and the "off by one" introduce
> here isn't meaningful. I prefer the improved readability and lack of
> wrapping pre-decrement.

Great! Thanks.

>
> Applied to for-next/hardening, thanks!
>
> [1/1] lib/string_helpers: rework overflow-dependent code
>       https://git.kernel.org/kees/c/5d6b91b74ccd
>
> Take care,
>
> --
> Kees Cook
>

