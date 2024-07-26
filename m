Return-Path: <linux-kernel+bounces-263761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5125093DA3B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8B8284728
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD2149E16;
	Fri, 26 Jul 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2lscdxw"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8911C83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029933; cv=none; b=MiZ1LtEf2mLTc24ryo2dRNDxdl8daYe9IPlh+IF86zBtorjR509F2WoRZ1qKIXVHcC5kdzUBR5yLzJlR0iFx8x4rqfx3ahahYtDlQ5hiffc1FpAG3wYKG9PfFqKePFPg+FFXoBvRw0/DYV4htk/bp17hSkGl0h8W6XsJGk6Hou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029933; c=relaxed/simple;
	bh=CCf/9Ky5FjSDgfoOPmTWv4kV7OyDW88/nI5Qzc7BiGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDBs7ZHbx4psKjzK+y+FXnpwm7W5ZgvGAINtU7FxUs/xhOHtB0GmMcFjcrIAuvYW3goZIfVR/0Kk9BS838BwaoTcNzjGY07jv/EqKfXAkPmPqAadGHVaI97K4AHsqGsH6oyVcPwNpJxUknFhNBBF1qhiT5m5GO3JE+LSYNES7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2lscdxw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso235762966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722029930; x=1722634730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bkedeLk8fhK9O3PQ3pqqo7U7kJaAE7vHl3F7D3P/h4E=;
        b=N2lscdxwQutWsUK7m0EgzHjE8epQ/+Njio+bLmGgX/orGJI6Z8VOJY3Wj6IPu7ikYN
         gGh1yHiXVDlIqBHlob12GuP4VP6cN3sbgo8o1uii8Xj0YpcQTpE4St4Zqogvr6iIu+GN
         Qvwma663x+T5OgHruO/wji9YeluAgnwVOxuBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722029930; x=1722634730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkedeLk8fhK9O3PQ3pqqo7U7kJaAE7vHl3F7D3P/h4E=;
        b=MhsQDSHPcU3hS0E0CVvqsxBRqhmldsADtEXe2KCKRzlBVy1dR3YmW0wyIjECqL42rr
         1au6oJLtx9tfbhtH9pjVOOUQEDWkpkjm07kdSdu7m5TKmnT3/0S1NMC4RFrw7HvCNTlc
         a8RXy4O6l0SAHLi60HOA4DomQhy30RuvRGSLK0Pg8/vBZ+tko28nYT//DviaB4jeZsdC
         o8HkZWbA15db34fdQNqcfbT6nC0ptwLqU7hoQ/L+LGObki7i8EgonbvC1+oHCu726n1q
         L75CSkDh7i4iOKRfpV+JMF8q39HqZX9EZsaqR8Z8Kyjx2k6zetgGOPaMejgYyjxlvSLR
         HHOw==
X-Forwarded-Encrypted: i=1; AJvYcCXxIy3M5nl8H/od9puedoam8NWu1nsCzdgQmeuoilp2pqEBnOP0lXuNYScc3n9jCyQUmw5utm0P7z08emKVQ7HwSLqXuDJ5duiiqqFD
X-Gm-Message-State: AOJu0YxMETXMXucNEOv+lXmtwgPx0Z9NK59NGNe4hEvQv1fho21B5nFE
	opmXr7pxwICxE3f6YPzfH0ay1taPI22N10KJxZAXVDV9SrBRwDD02ZoglBnRkfcMcGxmCIONGHl
	Qz5PveQ==
X-Google-Smtp-Source: AGHT+IE7snfWnyfEPdEwgWz0+OEqxz4HK3EaL7wHsJqfrXttOc7YuKLscs4jl1nVYIW/8CUn8EWpiw==
X-Received: by 2002:a17:907:6092:b0:a7a:a06b:eebf with SMTP id a640c23a62f3a-a7d3ffb76bamr50719866b.22.1722029929763;
        Fri, 26 Jul 2024 14:38:49 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9046fsm219715366b.147.2024.07.26.14.38.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 14:38:48 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so1133919a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:38:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKQv0B+aILb8UnFZ87IDtIbKxLUnuRwq/+lWY2vBoK63E7zJfm7zfzk7CE/ZGl4AvRFqBbrqGd1J7q6V/cyGsBqqx8gaSK+WA2RLqo
X-Received: by 2002:a50:8d14:0:b0:5a7:48de:deb7 with SMTP id
 4fb4d7f45d1cf-5b0208c46edmr385441a12.14.1722029927975; Fri, 26 Jul 2024
 14:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local> <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local> <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <20e5a0db0ebf4bbb991b13a1d8951137@AcuMS.aculab.com>
In-Reply-To: <20e5a0db0ebf4bbb991b13a1d8951137@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 26 Jul 2024 14:38:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYnBZzMkOOjHjhxCUmAcYVU007qhAsxDcJQc1PvEs8YA@mail.gmail.com>
Message-ID: <CAHk-=whYnBZzMkOOjHjhxCUmAcYVU007qhAsxDcJQc1PvEs8YA@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: David Laight <David.Laight@aculab.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 14:33, David Laight <David.Laight@aculab.com> wrote:
>
> I suspect just reordering to:
>         extra_pages = min3(extra_pages, max_pages - max_pfn,
>                 EXTRA_MEM_RATIO * min(max_pfn, PFN_DOWN(MAXMEM)));
> will have a similar effect.

That's disgusting.

No, we're not adding random "the ordering of min3() matters subtly for
expansion size" crap.

We're simplifying the sub-expressions, and fixing the problem that way.

               Linus

