Return-Path: <linux-kernel+bounces-171794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920F58BE8CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD3F28455F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F816C43E;
	Tue,  7 May 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L3FruZzs"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311CC16ABD8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099131; cv=none; b=tYsUK4BLvJuViINMo1Ykf9hs/XyOvxJnyfQ2CAtQPACv1scbi72X9j4Q8moKZBpmFE7Mbnwi1nLwa76S7Nc9+iDoES7fSCwQ0BOcbxFwhsovZ78SJK/ZeY+kRyFbubS9MFsA8b0KyjvTLtYN3HuabLL5Myxx7JhJU97huxRCuPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099131; c=relaxed/simple;
	bh=5/4nUFGzVCKyh1B64hVam6vzkGBnCWQpN7HzGYdQUhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTqBXAjEOq+sRLOKGKaK+zOIXn741cq3Ow4ZwWE6pBx/oi6v224ual9Gc1dcwJtSc7svaMctXF09YrbmS8PH11mWzwBvaef0t9fkTwZR4KvqegTY8xrLeLx5TiXQoYvDYSF/gikdWp5p4BP8EHo/j+IAkca0QCxMgtn7Xk4E/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L3FruZzs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59cc765c29so579998366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715099127; x=1715703927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qsg2qiI3lz3EhCF2HZdFnC7wmOTqjTes666QVJJQB9w=;
        b=L3FruZzs0HaKvGnuQxR0jF7PdeALJRIlGBpcLZKx5sBfxRv+ySo1LK/iknCVL889sG
         LRlC0oy/r4BhvJzSwY1b1UKkI0/rr3RuEjYewtz1p3m4FY6wvFzlu3pbwaG3TyRHVKD9
         j3pm3lg06DYdNbM5B796G77pqKRQQ8eEApFBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099127; x=1715703927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsg2qiI3lz3EhCF2HZdFnC7wmOTqjTes666QVJJQB9w=;
        b=IZJ/iovAm8eE7c9M/2C/OEo7Xn0598P4SKzYQEymqhWUUaNw2sa2zw3EuxS31fH/Tr
         y4oJcGwk3PM9YirSRMPEKAIdhG9g3/bJuPPPDH5Cl+MyPp6StnKmlQJBoyKqNjvCWW1q
         RKlbKDLmDy7PtcEESMZdFcn/erGol7Zxq3+OcY5q0/+rwyVYbf3sGPi57wQhPN2vDVqL
         tycLIJGC6Z5bKUE38vlWHi4qzYwOGENJ22/2v29EMXSMzldRMflo+jsZ7kpVrlfcc1vS
         SPUoLbCt0etmCuhQXMAleFpN2otH0diVYyTh8coiwEVnkbOoUEF2jwJ5Nya5MJLYXrps
         7WrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3cwU9kJnNaKUXZ8tL9U+uYKqpzBpRosuLJOcTjDMN6NwmXqd+bG55hrZ6YD4YmkkjGJy4kRDDr+A7Q9xspkUA8EIIeCLfnHD3M1//
X-Gm-Message-State: AOJu0YyjqRvk5eUgtj6izWHAQUCOkiu2+WlZI83/UY9sLYvtxcEs36WH
	yNqsFg/70A3fZW689+oMSIKTrWjE2a1ERV1UE9dRY9PuzeU8HTpZgIXiYkxXq2sAUXBFgrzlEv3
	D7sb1vw==
X-Google-Smtp-Source: AGHT+IHMKQSiQS8NmoukPblHClZUc7lupBU1TnHwMwcYdXz2R6Z9rOH0uw0j8kNI1tiLabYMoMAwgQ==
X-Received: by 2002:a50:8711:0:b0:56e:5735:db2b with SMTP id 4fb4d7f45d1cf-5731da81938mr154899a12.29.1715099127371;
        Tue, 07 May 2024 09:25:27 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id l11-20020a056402028b00b00572bba6745esm6467712edv.81.2024.05.07.09.25.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:25:26 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a0e4b773so804812466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:25:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkqzDGVDE9047kziGr3k9GRDkX/8tZuKtOlJfkCzTatVZlp+Zoj8rDN9OXKuQRrjmnm+bBT4X/6saaPdj35HgwoSUHQyqRH5NXtM1Q
X-Received: by 2002:a17:906:7804:b0:a59:f380:1821 with SMTP id
 u4-20020a170906780400b00a59f3801821mr1149640ejm.69.1715099125946; Tue, 07 May
 2024 09:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507142454.3344-1-konishi.ryusuke@gmail.com>
In-Reply-To: <20240507142454.3344-1-konishi.ryusuke@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 May 2024 09:25:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgogPoSdCYw9jhc2Zm=BaE19nXYwFn_F9SwD2C-DyrmCw@mail.gmail.com>
Message-ID: <CAHk-=wgogPoSdCYw9jhc2Zm=BaE19nXYwFn_F9SwD2C-DyrmCw@mail.gmail.com>
Subject: Re: [PATCH -mm] nilfs2: Use __field_struct() for a bitwise field
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 07:25, Ryusuke Konishi <konishi.ryusuke@gmail.com> wrote:
>
>    Despite that change, sparse complains when
> passing a bitwise type to is_signed_type(). It is not clear to me why.

Bah. The reason is this:

   #define is_signed_type(type) (((type)(-1)) < (__force type)1)

Basically, the way "is_signed_type()" works is that it casts a
negative integer to the type, and checks to see if the value has now
become a large value.

Now, it looks odd, because only one of those casts has a "__force" on
it, but the reason for that is that casting all-ones and all-zeroes is
ok for bitwise types (think of bitwise types as being a "collection of
bits" - so all bits set or all bits clear are sane concepts regardless
of any other semantics).

So it's not the casts themselves that are problematic: that part works fine.

But you cannot compare a random collection of bits for greater than or
lesser than.

Think of things like byte orders: you can compare two values for
_equality_ even if they are in the wrong byte order, but you can't
compare them for "larger than" unless you turn them into the right CPU
byte order.

Basically, a "collection of bits" doesn't have an ordering in itself,
even if equality comparisons are ok.

So yeah, is_signed_type() doesn't work for bitwise types.

And I don't see a sane way to make "is_signed_type()" to work for
bitwise types - the whole concept of signedness of "bunch of bits" is
kind of nonsensical - so I suspect your workaround is the best we can
do (alternatively, tracing would have to figure out a different way to
test for signedness).

                 Linus

