Return-Path: <linux-kernel+bounces-264863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F260993E962
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A871D1F21833
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4724E768EE;
	Sun, 28 Jul 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XbVKYgRf"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A99768E1
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198729; cv=none; b=oPKqzyxzSA8eFaWENmZyWHlHfFhfpbzHCmAqEsyZBW0x7z7Ac3lGD5FNQfd6KYiE9JKPVITk+ff4KZWsQM0yt47c+NL5vDD40ClLqT2YCU/iFURPlrs2ZoOm0mk9zeicCqD19vt1ahDfAyTY/NJYUxGgdOKKF10nSHNzpbqXjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198729; c=relaxed/simple;
	bh=PZ6qzNZGWn8C9KxH7s+DQRCxNB0Hvlde5ccd3n9QFWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gB8UFd6VoLZ/j7x0esvDthryzsPpRGhtDqGvr07pGWDqvr9RrVrOCf7IkAYeTvGE+KjgS1EhtUB7mNc3m1GDOxZS7Fme8tr6ZfWPIjrw0ssCslGOaRtZXmdOcdWHmijdFg1RGtLkn02HFMUBgnbbNcqkhv4fhxLfBWk2+BU/rrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XbVKYgRf; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so3062098e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722198725; x=1722803525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=31T/wcyGC0a1619yO1onf7qadmsMMm37OcICHwdLOJQ=;
        b=XbVKYgRfcgJJN4fCXV7Sr/Ilr8PeBWO0l2JVoHVdR8OFUMz3FC3Xqy8bYKN+4wxHON
         s2Rqy5dhOb/QgJ3HLgtmfKhqf0G4mfEH8WNMOo4Mb59Wr34RZN4tbm/ogkZNurtb3nSc
         TnOS7RS1aye5cf0mbX0652UM4r5TXO1PFP1N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198725; x=1722803525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31T/wcyGC0a1619yO1onf7qadmsMMm37OcICHwdLOJQ=;
        b=RnMwItzReFHWbppsPMcfqMjlJCElKk5knW7flDH8pkrAx6i0dHt71ZNeprSOPXOuwH
         LZPpx2o6vDIHgg4og/RvKtWFzHEt4L6+t8Qadj9v8ysZVZvqtavBQ25Uv90awMPkLFwN
         6gjfsZZwsUHWcJkvqPoAbw+NcEC6G52Y3dt292ltaSIfHVseU/bHEMPvlrFmMf/18XfR
         Vsyu1ZLqcsKMQ15Av3Io0ZPw0ODB36mjk4ZBv2ovph37UlQ49i5R6Oo+sTQHuUjtvDKd
         ESh5MUB42SFsZH3ztzkzuStV+vCXyigSy03eQ9EphoIou5wQcoJiNfZof5UkFTZd+JmO
         WnEA==
X-Gm-Message-State: AOJu0YykhU+LyhDKD3P5+GvScmv+FTUpPQtOofjvNRKTUqIhONK3ucD/
	GqN1n+GHQu7QqNUcZN3g34cql4nbuRnvOywnggXnkAQbqAWYgJ5rkTYGk/zPKHK8G3n4KA6AlkC
	IGyT3qw==
X-Google-Smtp-Source: AGHT+IGZRgo8vWFk3sU7BdgA1MLpbGFAankrDj5OSJPuKw86FlPgI9uR5fmXgn1TyGvwi4601HbX/w==
X-Received: by 2002:a05:6512:250d:b0:52d:9ad6:f43f with SMTP id 2adb3069b0e04-5309b259b14mr4514551e87.5.1722198725380;
        Sun, 28 Jul 2024 13:32:05 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab53704sm423002466b.86.2024.07.28.13.32.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 13:32:04 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso1057209f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 13:32:04 -0700 (PDT)
X-Received: by 2002:a05:6000:10cb:b0:367:8e53:7fd7 with SMTP id
 ffacd0b85a97d-36b5d0d10femr3393613f8f.28.1722198723859; Sun, 28 Jul 2024
 13:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com> <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com> <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com> <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <d949045abc78462ab443b38340ce5c20@AcuMS.aculab.com>
In-Reply-To: <d949045abc78462ab443b38340ce5c20@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 28 Jul 2024 13:31:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigkg43sZJKuRuYOzWzj9bxczE2toHNc=yxfyMM3m_kcA@mail.gmail.com>
Message-ID: <CAHk-=wigkg43sZJKuRuYOzWzj9bxczE2toHNc=yxfyMM3m_kcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 13:23, David Laight <David.Laight@aculab.com> wrote:
>
> MIN() (and probably your MIN_T()) ought to have a check for
> being a constant in order to stop misuse.

No, we have a number of "runtime constants" that are basically
"constants" set up at boot-time for the architecture,as pointed out by
the powerpc people in private:

Ie, we have arch/powerpc/include/asm/page.h:

   #define HPAGE_SHIFT hpage_shift

and then

  #define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)

and then

   #define pageblock_order         MIN_T(unsigned int,
HUGETLB_PAGE_ORDER, MAX_PAGE_ORDER)

and we really *REALLY* don't want to force the complicated "min_t()"
(or, worse yet, "min()") functions here just because there's actually
a variable involved.

That variable gets initialized early in
hugetlbpage_init_defaultsize(), so it's *effectively* a constant, but
not as far as the compiler is concerned.

           Linus

