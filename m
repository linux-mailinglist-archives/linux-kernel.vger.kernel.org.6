Return-Path: <linux-kernel+bounces-266757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01794065E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF041F2320B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C4190499;
	Tue, 30 Jul 2024 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RKaBtrXY"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15547190041
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312634; cv=none; b=e3DuzTg1+x4HD8ZgO3S60nQHqa+L9Jjk5arP9p/ovpqaHQeFBY0HkPfh9+f6RKM2Cd+jvXbGvsWCoMJwVYIRVa0PewGreljyTM+Vi3YmnXjKreqpUipsTV4GudhoFOizSZwFqeSPgPk4bzkOVFcN1QEITDGOM/rrHNZoaOczkso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312634; c=relaxed/simple;
	bh=pg1/oju2Qd5RZC/VthTfC1CJb5hwlQaJPxJxrKvYvN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isNuhipEywTJ6YR7jwBW/kEMx3IYaOzy+ni5lyNefOSRiB9Z/HBx8xBwFTugUMhSw+hPCN8s1e+jsDbmUGj0xws6ijqFLvFupwZ3eDfdr4NIg2qJGGwLEkBIwj8IHCCnIFkYj6BuS28Ey/WV66k4T9pXapmRKWR6uvGq8DPXUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RKaBtrXY; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a8caef11fso455041066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722312630; x=1722917430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXa9bufO4QoTVzOfdBHgkq9nJ6lZTCxYBpwj3AeX9M4=;
        b=RKaBtrXY0C7dVWnJZthDwBA6DiR2iTuLSWus0XndVvecOaEB5Q7ZXlMA8wMdacNiL7
         NX/uTs3t1Qj3CpmXkQL27pdM0kZHp49Z1vW/0ljmsXvPpYItfJlvvaWzPQF3Xq4qdmRy
         l9GroDeoYeSWjGIAIbJ7FgwYsbv1+Q27t59lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722312630; x=1722917430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXa9bufO4QoTVzOfdBHgkq9nJ6lZTCxYBpwj3AeX9M4=;
        b=pC5LSCOpwHi2cVU4xKl3QCzXZZPq4qsjE8Gb9owgHvqEMOJ++HIdFddYzdDUNW0egY
         SXlo1ZMGKcrJCth/q+6fcMAEZ8pm2gdfYwoiIFVnvtDMhFgecTw6MqS6yGQJvSsR7ccl
         ZZdMrR2LdIAQBYj0jiv0K5BNVfO+qL1yHlFyj99qNGkUkiqbXS2pThaJCjDpTlLVJtV1
         Qw7Fdupgbx4o+Z4WYsvZP1z3++E56g2RakDgpEditheudRZ+iw6CYMZjYfPw7vQ8wrG2
         yHYl3W0BoP3kTGE46EsWZ5crhwr/RjcMeZZBANMXukTtLQB0Y6ytSfP4/pXLo723o8QJ
         ly0A==
X-Forwarded-Encrypted: i=1; AJvYcCXcBuMQAQuMJNK/sEjG3L+MoYTXdjRPMBYZYknr2Ws2XEYvgH4ttxdgxWI03I1+SqJvMbVoXpNxWG45xtVQCAfkC4TX2qaBdGDobT8e
X-Gm-Message-State: AOJu0YyKiWQ2RcSz5o7mzmIOfls6dwmVM/NIa1N8dL4tedl6iGtXgKo1
	5fMMsgX48zeuvX4hBg4i5jiey3T6LqQDwxCIL2m56hlYEj0osSjmQI/g8WuJ5K6nSY6pYIMjRan
	uypzD5g==
X-Google-Smtp-Source: AGHT+IGWzSP2hzOxfwyksICjuuowesif2tyas0F7Zd9Jlh9E0Z5ybHQYwwJc3Qht+eso0JgDWPtrFQ==
X-Received: by 2002:a17:907:7286:b0:a77:f2c5:84a9 with SMTP id a640c23a62f3a-a7d3fffb6f5mr730671966b.18.1722312630029;
        Mon, 29 Jul 2024 21:10:30 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb8361sm583945466b.207.2024.07.29.21.10.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 21:10:28 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so6162644a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:10:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsZy22WLWHDKz+nx4ykh7TCxetUxxllLHAKihjt/hTPFRVknYkb/8P2penLaI8xu3yqVWPKjsQFwz0+7S0EAE1HbJwMU8SmoQSjuQl
X-Received: by 2002:a05:6402:5254:b0:5a3:5218:5d82 with SMTP id
 4fb4d7f45d1cf-5b020cb9510mr6968944a12.18.1722312627923; Mon, 29 Jul 2024
 21:10:27 -0700 (PDT)
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
 <2f1be7ee-2d70-4dd3-bfa2-1b94a4fc5a66@lucifer.local> <CAHk-=wj9GLHpMo=ikVYzXtnNBpFwG3YeCZHfWndj5_xm=19szg@mail.gmail.com>
In-Reply-To: <CAHk-=wj9GLHpMo=ikVYzXtnNBpFwG3YeCZHfWndj5_xm=19szg@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 29 Jul 2024 21:10:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7ip=Uu+xg+d7-vKS1Yt_hJHg+fJKDYgp-8W0BncUncw@mail.gmail.com>
Message-ID: <CAHk-=wg7ip=Uu+xg+d7-vKS1Yt_hJHg+fJKDYgp-8W0BncUncw@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 09:26, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
>   Longest line is drivers/.../ia_css_ynr.host.c:71 (27785kB)

So that 27MB shrank to 23MB and then to "only" 1.4MB with the patches
that are now in mainline.

Now with the patch I just posted at

  https://lore.kernel.org/all/CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com/

that nasty line expands to "just" 82kB, and the file builds quickly.

Still not exactly small, but hey, two and a half orders of magnitude isn't bad.

And yes, that one driver is disgusting and Lorenzo had a nice patch to
change some macros to inline functions which just made the whole
problem go away, but as a test-case for horrid macro expansion of
min()/max() it was lovely.

Of course, I never did any build timings. I'm not sure how much it
actually shows up on that level. A couple of bad cases won't be *that*
noticeable when most cases aren't too horrid.

              Linus

