Return-Path: <linux-kernel+bounces-264245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C182D93E0B1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF5D1F21807
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF607186E4B;
	Sat, 27 Jul 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gy+X+vrC"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343911C83
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722108137; cv=none; b=IFddDbPUcka3T2wnMNdxGQsgQZU+vZh198MUvk4a+pfsXesXNo69EneMi+t4EvBRUueDS8zXLmyYveDUJFKQA3/UojQvlN9E2K4PoqVRiJEfmpQ/qFH8SgImDVKQYz8OWwJqXMHEoA0qE8vwOvQ7g89UHEGBklxPMgWZ+ODGVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722108137; c=relaxed/simple;
	bh=XH7QXN+2y7hO8/JJz9910xatXSDCkspLYbGWcH+J/yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqo8ofby8HDJClW539fhUN6508IDyKdNxZD1ZedRx+t+DGWfyQT+WJxA70cD9RXd73HM+8U+XIvTtobwhOa1bYkb/GZi57BP34xXkZZNz4AnZfBP2eMdaqCacj+Tx74gJrWbPoqQvWoXrg4to+AQHLjIXyp9ZIHbHfQhNzMsQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gy+X+vrC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so307882466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722108134; x=1722712934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/KGqVB/57I9KELw43F3w/OzLTiYGnfik0UvJkjuipds=;
        b=gy+X+vrCkhgfXQXn2/4IB7MvPkmg9lmQoUPHYhGCBRGrUPCdg065h5Mr/aaW4aKDj6
         DGreYej3c1cRZweZX8Ds10Y44u5nsXqOpn8xuNV4L9xdOtI8JxCpymO2etyDLW3pJeIu
         fZNM8EVeDbINIywxhZdTiDBomsRc2k+O+Qwhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722108134; x=1722712934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KGqVB/57I9KELw43F3w/OzLTiYGnfik0UvJkjuipds=;
        b=CMKKGQSCR0BQQGitrIFPARc2JH/TnCXH10FWz8++wuwLexSjR9Y3CjTjfF1j8n996c
         jcTQZCClURvCdFe5WysXtocYHSsFSk8b6Ayzkh9e5DZRniYGod3sV8uH5oxUbbwL7+Rh
         FMpZwcodWEyELesDfscFcatWrnMjM2n953wTxWU7GQU5HhY98YYaniIsU9MHwvboasS8
         nPtSJg2kr72vx+JOhoe8hKEe56scLe//KsZfjsfhU5wwEFpIXYbjPxmP9TjeBxjqm7PQ
         qLJG6WiaVNi9MyG9X0Xf6gi8i1UAwrYammlmfWSvIZuOR184hza7/oN0m71f/ehvavMs
         S5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbwiUDYvHYW/SmOo38aWZZVUd4SPD9pLFIh/BKc++w5nTiDEzwaHRPEBKb42AWZj05jXaiiU/A39ybru/l69E6avqC/1EAJcgyIuQl
X-Gm-Message-State: AOJu0YxFWe/tA3Q2uasAnUsVRbRJvNKUPZ1x1OJ1g1Bt13dQmyidCoPp
	0r6FKm7lMvqc8qu2WPCj6/MPcwY5GZYOOMfAStNpUiIKo46794fBKQm/m1HrmRCWwV1fcaYlP/0
	61aklnQ==
X-Google-Smtp-Source: AGHT+IHSvCANo2QibfmMGEohA75I8zqwk7NSt8/xb41zC0K/to/osXrwG0tGSbCMAtK4bmsBmEcZGw==
X-Received: by 2002:a17:907:3203:b0:a7a:ca07:1de3 with SMTP id a640c23a62f3a-a7d4014c5camr228300266b.56.1722108134310;
        Sat, 27 Jul 2024 12:22:14 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad416basm308254266b.104.2024.07.27.12.22.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 12:22:13 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso1610913a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 12:22:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUau5vCO5nU/FwN6pCtusN8QAGcc/kuR5idxQGKc10GR4FQr5e3UwXcEX/2aiH4Aoio/yVdzy5MNFfVzihIPYHc7dCTr2tO8HpsM1Qm
X-Received: by 2002:a05:6402:2546:b0:5a7:464a:abd with SMTP id
 4fb4d7f45d1cf-5b021d2243bmr1942089a12.30.1722108132482; Sat, 27 Jul 2024
 12:22:12 -0700 (PDT)
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
 <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
 <40369e153bd447e5b597c31e7bc9a2b1@AcuMS.aculab.com> <eea5d9a4-fcb4-4076-8222-fcff668a2bfa@lucifer.local>
In-Reply-To: <eea5d9a4-fcb4-4076-8222-fcff668a2bfa@lucifer.local>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sat, 27 Jul 2024 12:21:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1+7iNaq7wvxgw=2NEWvgj5SMrvFUZEw8C42zKbzsUBg@mail.gmail.com>
Message-ID: <CAHk-=wh1+7iNaq7wvxgw=2NEWvgj5SMrvFUZEw8C42zKbzsUBg@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Laight <David.Laight@aculab.com>, Jens Axboe <axboe@kernel.dk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 12:01, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> > > -#define MVPP2_SKB_HEADROOM     min(max(XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
> > > +#define MVPP2_SKB_HEADROOM
> > > MIN_T(int,MAX_T(int,XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
>
> Yeah sorry just saw you had already addresed this Linus... I just went with a
> clamp()_t in my patch.

I think your patch is better. I threw away my disgusting MIN_T() thing
here. It made more sense in pageblock-flags.h where it replaced
"min_t()".

               Linus

