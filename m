Return-Path: <linux-kernel+bounces-286765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4696951EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E31F23328
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBBA1B5816;
	Wed, 14 Aug 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffbum6QM"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158811B4C3D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649831; cv=none; b=mnR4VasrZiYjdyJSu+ByFMJvtTLouT4KF4UZ9tpbQbSHYmZH4/yKqk/7z0OQ3OlUhlXIOPAhtuJPre0PXfg+hIoL2dryEHt8nu7Z/VN8iadlXZP0l92A+zh2Qb7n3D5qyO5gRxcumZ5MUUBc4oNDSjV/Ms5QppiQvJn/dXmwr8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649831; c=relaxed/simple;
	bh=cqf02PglwzMnUewsw7C/MM2gxFs0r5loGQKEe2O/En8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G93w2ss6GIyu+6ztDgMCycWJv5Go7vu7l3TM95SCme98vWXAstJKy0Tu2fN/mIKYhg0W7quBBTArDOnQqe9Ob57Mswx5IU9JhJomZIOmfnRiep40fJdiQasUoxg8NcMq+qnZQAbdGDrMpF8ZnprTXIsTyACimLyTRI1Bu09XKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ffbum6QM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a115c427f1so47305a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723649829; x=1724254629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqf02PglwzMnUewsw7C/MM2gxFs0r5loGQKEe2O/En8=;
        b=Ffbum6QMbnvldNV4JP4s5gKGNL24ZONSWBvRMbaXuPI1+Axe3kcr9hDa2BGheYOs6z
         aB6g0VJLPIVs+qDkX9defJ5cmVltJ0wQ9eLPnRQPRPhz+gjDobNso7P7NsuJwSrW7SN6
         id9zvc2DuYJCk4zQXO24RpbXTjBk1gf4O4zzXyoGn8P4OEw4OITI5VtWBa0RXLEYT5v9
         c/d9UcmYX1oZ6gvsfr3RGMYiuYmuzjIaZBY8Q3+NwaQ/cGCtRd4ODALmcWUFWNhe7SQF
         HqItrqrr112h5GVWu4B/aUmdQrWg1tAVzY+3oQgRXqObqmcT100VNJ185IIObzzD1leE
         NokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649829; x=1724254629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqf02PglwzMnUewsw7C/MM2gxFs0r5loGQKEe2O/En8=;
        b=I8KGAqBkwbCd5LcL7SOBhc3Q2ksSAnQGv3LxBbXXKlIaHiVRhtI458ljWI3zK6b8VW
         RzKxwiTerkzVu8WsiZ1jCRcMqpL7agFJ/f6l1wKRTzaABCXcxl34+Hrjdp7syPIn8WOO
         q6W0Yd6PfPwpMUEg8Xz210qdS+LzoLye4Pk6flzAEHnjdAd/4VaFoXya5IOExCGVyvmX
         4S7cLUxE/bLcl37XMx5HzSVBdXXAlHwYBQj8e8LkGQhZ8XQ3WLy8xn4UppKKtR9Q3bwV
         mbp5R+2gCOtTJohiaJ8jTccOARMDOqYuqeBfGERbdRFcUncP42WKSmK7wmIMxmzCWrvx
         YDZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpOZyIED92uOW4x+EcyUbrc5h/NrMzxK6qVed2vFeZJCfZ9mOATPRo3U4wA6wBZ35G/9+XOZ3/GrpUnUZU1FKxMUcz6OMfWVgRPJtE
X-Gm-Message-State: AOJu0Yz06bRvQXcb9hFXZ5B/GgkSH9tktNLU/fluHy7J+KrehxktQ3ki
	9uKAVG28IjcJzl38O6r0tPPgMRECgJYHzYpYmRkbCyDd+QpkZ2Wg+blNZ9YQrRqFU/OEqWRlqBX
	jQHc2Tm0XhWP2nYZJ60jWVyqWrbM=
X-Google-Smtp-Source: AGHT+IFDBONZW0uAyZZcOL0emyNtvuyvo9UQfc/vnpEfY8xrJ1IHvo6JR+e3rtaebfSBwGdTBBl8COcr1zrbck6P8to=
X-Received: by 2002:a17:90a:ba8f:b0:2cf:fcce:5a0d with SMTP id
 98e67ed59e1d1-2d3aab87063mr3577203a91.35.1723649829061; Wed, 14 Aug 2024
 08:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813224027.84503-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240813224027.84503-1-andrey.konovalov@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Aug 2024 17:36:56 +0200
Message-ID: <CANiq72mCscukQTu7tnK0kXHg05AiMtB8sHRDTvgjWgcMySbhvQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: simplify and clarify Makefile
To: andrey.konovalov@linux.dev
Cc: Marco Elver <elver@google.com>, Matthew Maurer <mmaurer@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:40=E2=80=AFAM <andrey.konovalov@linux.dev> wrote=
:
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

It is easier to read now, and indeed GCC 5.1+ and LLVM 13+ both
support the flags, so `CFLAGS_KASAN_SHADOW` can't be empty.

> +# First, enable -fsanitize=3Dkernel-address together with providing the =
shadow
> +# mapping offset, as for GCC, -fasan-shadow-offset fails without -fsanit=
ize
> +# (GCC accepts the shadow mapping offset via -fasan-shadow-offset instea=
d of
> +# a normal --param). Instead of ifdef-checking the compiler, rely on cc-=
option.

I guess "a normal --param" means here that it is the usual way to
tweak the rest of the KASAN parameters, right?

> +# Now, add other parameters enabled in a similar way with GCC and Clang.

I think the "with" sounds strange, but I am not a native speaker.
Perhaps "in a similar way with" -> "similarly in both"?

Thanks!

Cheers,
Miguel

