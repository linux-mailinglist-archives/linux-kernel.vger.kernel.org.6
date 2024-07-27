Return-Path: <linux-kernel+bounces-263960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB693DD33
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 06:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B52B21F97
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F46538A;
	Sat, 27 Jul 2024 04:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CTo3nRCZ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30782F2F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722053614; cv=none; b=Su2D5bE/FAzGeeO3xjom7nwin7nHI157K4M6rIceiZ6O7g/TlAu3e6ITkBIzlAw1GIfBUzS8wHorUvZkCEFQhfliu0m1bX7Sald3cS3IAx/RNItSPlJtKJ0fgZmPmHaJ1/5FtBKn0R83adH5EK6CCtWEuOdOb8Lk4f7b2KErz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722053614; c=relaxed/simple;
	bh=iDNhowt8vKdyFWPMwp/w5aKr07aYe2zH+1sDl+8cPwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lh50CIwusyFkPoEHV8I53sqbT6qR/RiodhsXByR1gY4Z2V6sYqw646mIrGT+OBiDk1Qt80lQPIUiwZsUUKxcp1/cA6u8Ula2zNpFbAiGqoKb3TfDekt3IQwPKlWeQomdT2Mz2Lyr8jLNwkvSvGlXd7TFIMgwhqLieKl4/MGLLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CTo3nRCZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04c29588so3221104e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722053610; x=1722658410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K/uMPyIfeG0/RXKUSrI0lPwnMKxDEbhvNoitLBIIiHA=;
        b=CTo3nRCZcQdY8pC7LbCv5+O9FPAaud1QE3ULvK4yB7305hqFqFOu6Hrv0XlnSIvFCb
         n+rUKTgihDd6M9LDw9pWk8lrtMmQ1edx9A4GYZp07layJ2RXJKwyuFX9l8V/csz1MeHp
         VAxS7Evo6Te87GhWAk/oxv39osBALQD/PSa08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722053610; x=1722658410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/uMPyIfeG0/RXKUSrI0lPwnMKxDEbhvNoitLBIIiHA=;
        b=wAWBd522jfy/OoJOokwDW8HLkZblWOrwrlnKsfxK62harqZRXARb+xpGYaloObDQUj
         A6zyNyZipYmmL1WnTWqo0EcWQz/JL4ZX0oC/4oBg/lFelzpF81I5ZR6mCAojrXev0clE
         3hxTVsbvrjNpBAZ9Fc6jN/eEwIkqI0hAU8Tbjr7Ifhn+pf4tMmngpU55SLWR/y1a2scu
         1Qsm9PYJ23x0DbJg4+c4BC6FAqSTKrjdMOpbWqla2EnjJjN4mLasEwbYK7utVw1HQttU
         Yk24VR4kdYzlZai/xxOlolDza1qcKiqk67h4m4dRXm/V4KuhX+dtZSIkcL/0THlxFVOi
         Md6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnyKbR5T091y0R8kh/Yg1eGUvZDxwbYR6Yyjb/SxVtMqpGrfGhCoAxzJMBQZ4Lc09+G1J8TwD2OqTe33vTBoM8NKLwowDkNWXyTFwQ
X-Gm-Message-State: AOJu0YyARXM8Lgc2zEQnHuJUWO9Z72wiqAwGrqzC6FNLDYqKzdh1SQCB
	opgthA1bO1/hTl3bLHx+yaslxjkvfVcGUi24YTX8LVLiCtJvtJPno5w5gJqUHSYs7RhT7Mls/sc
	nc1Aq4A==
X-Google-Smtp-Source: AGHT+IGaSunA4Bzi3tDRTik7or2HxQUfIQ8dpN0P3ma9LxeLkA1Md4UKACVcs1FU1bIatdaXMLH9Ug==
X-Received: by 2002:ac2:51cf:0:b0:52e:9b92:49ad with SMTP id 2adb3069b0e04-5309b1ee488mr1148778e87.0.1722053610559;
        Fri, 26 Jul 2024 21:13:30 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9a12sm239754666b.213.2024.07.26.21.13.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 21:13:29 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so3564379a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:13:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbjrcyayLKIVJ33j+4SyP4WVRhJDDfl7nZdyB8MxhaToN5W1+H+aGeVDAJGopLLTChli6fylkqooD90mk5pZeEhg+jh5jYDUi66FL2
X-Received: by 2002:a50:950d:0:b0:57d:3df:f882 with SMTP id
 4fb4d7f45d1cf-5b0202ef9admr704512a12.7.1722053608884; Fri, 26 Jul 2024
 21:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local> <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local> <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local> <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
In-Reply-To: <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 26 Jul 2024 21:13:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
Message-ID: <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 14:36, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> Now, fixing that, and you end up with
>
>   Longest line is 61861 (82kB)
>
> so it's now "only" 82kB in size, and that actually comes from
> <linux/bio.h>, which has this:
>
>    static inline unsigned bio_segments(struct bio *bio)
>    {
>    ...
>         bio_for_each_segment(bv, bio, iter)
>                 segs++;

Ok, so I was playing around with this some more, and got really fed up
with manually matching up where the longest line actually came from in
the preprocessor output, so I updated my stupid "longest-line.c"
program to just track the original file and line number as it was
walking through the preprocessor file.

And yes, I realize that nobody sane would do this in C, and this all
should be done in some sane language that is actually meant for string
parsing, and me writing scripts in C shows that there's something
seriously wrong with me.

I'm aware.

But anyway, it works. At least to some degree.

So I can do things like this:

  $ make drivers/net/ethernet/marvell/mvpp2/mvpp2_main.i
  $ ~/longest-line drivers/net/ethernet/marvell/mvpp2/mvpp2_main.i

and it will spit out

  Longest line is drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:1136 (2346kB)
     '   ((((((pkt_size) + __builtin_choose_expr((sizeof(int) ==
sizeof(*(8 ? ((void *)((long)((__builtin_...'

to tell me that we have that insane 2.2 *megabyte* line due to the
MVPP2_SKB_HEADROOM thing, and I should apply this patch:

-#define MVPP2_SKB_HEADROOM     min(max(XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
+#define MVPP2_SKB_HEADROOM
MIN_T(int,MAX_T(int,XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)

to fix it.

At which point the above incantation starts giving Jens the evil eye again:

  Longest line is include/linux/bio.h:194 (82kB)
     ' for (iter = ((bio)->bi_iter); (iter).bi_size && ((bv = ((struct
bio_vec) { .bv_page = (((&((((((bio...'

but while that is certainly an impressive 82kB line, we have some good
company in code VM header files, and I've also seen

  Longest line is include/linux/page-flags.h:507 (27kB)
     'static inline __attribute__((__gnu_inline__))
__attribute__((__unused__)) __attribute__((no_instrume...'

because the expansion from

    __PAGEFLAG(Locked, locked, PF_NO_TAIL)

does indeed generate some impressive stuff. It's all the functions for
the locked bit handling generated from one line.

But my C scripting may be buggy.

Anyway, I'm throwing this out in the hopes that somebody will use this
to go "look, file XYZ generates a ridiculous X-megabyte line".

I found that 2.2MB expansion in mvpp2_main.c by basically just
randomly grepping for nested min/max use. There may be worse things
hiding.

             Linus

