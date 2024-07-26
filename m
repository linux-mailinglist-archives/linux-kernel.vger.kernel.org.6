Return-Path: <linux-kernel+bounces-263813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D855793DAD2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0763C1C22FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E252F14C5B0;
	Fri, 26 Jul 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UbDifBAf"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D894143C6A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034153; cv=none; b=Ox4HHAa7UKRgVIDOl9z1wXi7vWE8gDQkDW6DWhtMTHImIlm0j6ltQbwHlPGZXM0iWeUVWjfKkKJW/czJQq6dqKuZKXFao/uaq1Oz5JCISgUuvKI5F3XK/skLVpRv3bqSNiiSqNHxMVmhd7RpExVew5h3cqI8MhDi9JH3MAF7gSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034153; c=relaxed/simple;
	bh=mwN+UMa0EMiP0VaDP2ZqfafocUZAyclWfG1iw9BcLks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHSSxAflhe5CwBi1JuRoDpVqv08n6I5Y/+UAV/4b3BgNDkRmspkJd5VlyXQSEsOAHksj5zGoF+9MEPVYuQjDqmjmjEJMuK5LVsXxkcPIq+j8I+qYrq8baEHPXcyY+5BoUnKZ70JRP6kGKuaAsEgCwUX2eGznBx0dNQTGDoioUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UbDifBAf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef283c58f4so19423681fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722034149; x=1722638949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L8kTffMeNEUYPqB8a6733WBTRK41FhXCH5cIS5+6SWc=;
        b=UbDifBAfjR3zyhZR5cu7gMNgwf7ly4+ieEngzVmlNGV98EdfRt+9Ct3QycMzEaSCu3
         GfLUOR1isV+oD5V1d2A1M94o/Km7aTfozMrOrIcdKgf50H1s4D5BM+qsKJZTNikgZ9HD
         khzCTovjPJleSpWT9lMtl0eUrF/BnddnS2ZwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722034149; x=1722638949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8kTffMeNEUYPqB8a6733WBTRK41FhXCH5cIS5+6SWc=;
        b=j5ITDpv6egEtuzy8gtboweQnYvzV3y0ptANHZdhyxoC0ZnhTeRxsdJqkB9tpq3kMv1
         8boxjpOklr+pdGyxbOULDSz++GWu4hHsdzxOiIKALMnUu5F7pOSIZlyS9poxX9wTMWt/
         FyNC7/VfMeYvTi7LD0l9V9PRqis9HBK5UKZ48/W59Ei604N/5/yOOQAJyAGfs+1cj0sD
         DtfYTUD++fzRDsnbr4RSppCw+wevmWeqHwsr4oUHGa9XMA/cdF1T1Nrcou3zOMH/54Rn
         ZTgLh1sY9Zwunw9EuMkbH1g2IDK50AwLSmy6ZWz5dtMk+KbJ4MDkScaeF5ywiX3xhcjC
         0JJg==
X-Forwarded-Encrypted: i=1; AJvYcCUttTDnvoyy+oG4+ALpKNyswffM0/6dlBXhbyerhM1wq5IC7NdwsgfbfsLtk45Pzz59g8uh1W9KPvqoIU5R8JnFrW3dytOP0+8F4Vwc
X-Gm-Message-State: AOJu0Yxka2/dudenqdBolFRI6SBReMgnE14K7pfsI8UQ0skTYBD9V0JI
	iHQaESbZjeO4KXhwC8up1I3iDXBQcwDxd6FCRRZymfeS7sum/SGROV7v/rIJnRrgY0S1WdID9MN
	avL/xaA==
X-Google-Smtp-Source: AGHT+IEU2vUkr2jVBTHwxJqC3OS3Y4wsKpzHJA/GUrjzof/uAA+rXnObI0U4yoT9zCC6yLglI59kcQ==
X-Received: by 2002:a2e:b607:0:b0:2ef:2bb4:45d with SMTP id 38308e7fff4ca-2f12edf9cefmr6164021fa.9.1722034148981;
        Fri, 26 Jul 2024 15:49:08 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d04e0adsm5576401fa.96.2024.07.26.15.49.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 15:49:08 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efd530a4eso2640157e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:49:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVW82eA3fCE/odbBH3th7bdyBaEK8Ullt7dGBUjPcGv6r2iAbzN1ly4T5lUUV+HkBAY1WcG7qPP46370DX7FApdecH78PqM6T9QahkL
X-Received: by 2002:a19:690c:0:b0:52f:c2fa:b213 with SMTP id
 2adb3069b0e04-5309b2d8a91mr630078e87.55.1722034147514; Fri, 26 Jul 2024
 15:49:07 -0700 (PDT)
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
Date: Fri, 26 Jul 2024 15:48:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whH6rJeo1WxZWQzTeEXS+8MNV=A2c4qrF-uFYjU-J6U-g@mail.gmail.com>
Message-ID: <CAHk-=whH6rJeo1WxZWQzTeEXS+8MNV=A2c4qrF-uFYjU-J6U-g@mail.gmail.com>
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
> LOL. At least some of that is because of 'pageblock_order', which
> expands to 2.5kB of text [..]

Ok, I pushed out my two fixes - one for the xen/setup.c case, and
another for the ridiculous 'pageblock_order' expansion.

They both looked obvious to me, and they definitely make for a notably
smaller preprocessor noise load, but maybe I messed something up.

I didn't even look at what the issue was with the
bio_for_each_segment() expansion, in the hope that Jens will make that
one look better.

There are probably many other cases where we have these kinds of "tens
of kB of macro expansion", I only looked at the xen case and the
mm/compaction.c case based on Lorenzo's list of top offenders.

                  Linus

