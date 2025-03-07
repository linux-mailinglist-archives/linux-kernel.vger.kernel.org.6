Return-Path: <linux-kernel+bounces-551751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD33A57056
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465851896B9C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ECA23F411;
	Fri,  7 Mar 2025 18:20:14 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD251A7AF7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371614; cv=none; b=glJBehMJHTPyCrT4SkfGsdxTQXREmVc+zYDgO1CHS1mq/r7kuq8H7DQgjk1gjwgIVRfLmdIw8DZe1HnpZ1RtBwtcOczCoRjLMWJnec5e0tS+/arKkJ/jmTG2lu0/v0LYLiXqogc51wLiFT59Y0dJsEg99cU6e36T+fQaZAFaF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371614; c=relaxed/simple;
	bh=Hhw5T1wEb+xVZ4n3lP57Ca8my2QE1/G0kI7gnZD5tjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnTlhg11O6DwAbG8lg0XfPKOe96ehBEpo8AWwwzlPDwqJO7ojykEN1pptEDvdtOhU241fatYEGXM2r5StKtuUXdfunllRAaM3LS6Ljg60y2e5ckhk2lMT+fq8vpKIqFueofLHQuek6bcu4faC8AD8fJWx68ANYrA7hfIEMxIQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523de5611a3so836162e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 10:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741371610; x=1741976410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvPij45MkHD6jH6urWpxBYb71dSRN0xmKbFnFlZVi4A=;
        b=LRfbZA6B86hUnpe392kbkgchxxuNED41GkXiTI1TELPALZOW3hMeXJXL45ACPYGNlt
         OxMeHmYB+VTSWywrMfCdb1XKGNzbrtdFt4pVdInF/2fE03xWUr4xlLBIh0w2ezV3DpWi
         l2GVC4thKkcCjlu+G8oq8rHe7XA9jPYYxeSWdRGRH5kTgNL34oUslDJMVF8c9YczaLm2
         AgnbDVdbQkUKkQsIBzkkFRZg9mEhxSanTW3uPBm6v5/DQCNT8u2OFAGLWXaGSQPZv5nS
         y3v5MXIwCufsr1VETu+XIJ8F4wydGMLulH9tEjADaQAdtrXxtISoq3xkrnw3JADKUEdT
         9yzg==
X-Gm-Message-State: AOJu0Yw9q6q1aTPjMDgFkQVUz2ObVM/UfwYk78bnXBOq38PSAyVCxz3w
	768eaPnmnnvkM9iEE07HBvwcCWJm6nvgwZYxVjd6sJQI+vLTMv+njJjfYKWhI4k=
X-Gm-Gg: ASbGncugvv6TXaUXFQDAZgOEfHiiPnQvQS2KNdKecQvnS524y1t4m6R+KctNu6JyqBw
	yPIGBkPfSklfJ9lJFJcR9Ve8PdfO9bHDtTEm0cVzDOeWuI6kaHlqcPOESV9GCOT8jH96VV9OwKf
	6fwthH0qm48ddWMIfKxv46AN5uR0HUTINcX/veY8m2cppbBR+s4aADBkXa7tlHGMOdYFURc1pkV
	zaDIyFZcba6ocQJEX4LqwvKv3q1VvZ6ASofGiaHSXSd79STSSa3rIpl6NNfzKc4QH5hY5/dKdWA
	DtRLvJHn1/TJvOBriou7jpQPQXrtRZIYeP3zB5TI+qROunrB+bYCm7dDvcqrrohf4vIWLHwJQq4
	85rYDddyArVU=
X-Google-Smtp-Source: AGHT+IFcdllaarSErVen2g1y02DsXxbK5DSX1kFk+fL89JK3jEe4TWPYK07EuPg1SooP+C7jkjahMQ==
X-Received: by 2002:a05:6122:54b:b0:520:420a:a07a with SMTP id 71dfb90a1353d-523e414404cmr3709064e0c.8.1741371609751;
        Fri, 07 Mar 2025 10:20:09 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523e9a0802csm249838e0c.27.2025.03.07.10.20.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 10:20:09 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523de5611a3so836137e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 10:20:09 -0800 (PST)
X-Received: by 2002:a05:6122:3c8e:b0:51f:4154:c1b2 with SMTP id
 71dfb90a1353d-523e4030d4dmr3908527e0c.2.1741371609324; Fri, 07 Mar 2025
 10:20:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-7-andriy.shevchenko@linux.intel.com>
 <CAMuHMdXP1=7YJzYp=_WJsqx2mtBYcwAjpOGK2_9SH+r4w6v2Ug@mail.gmail.com> <Z8soDV0U2LG2KX9J@smile.fi.intel.com>
In-Reply-To: <Z8soDV0U2LG2KX9J@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 19:19:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV1+ftjpEcg4xYjBLH1BRJHkZcYB5W+p8WUWWLXT3DnUQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqrBIBhkNlFJDUH_SdoDsEvxpWHkiPSHeJK0yckPiHBvmMqg3yRYehWhls
Message-ID: <CAMuHMdV1+ftjpEcg4xYjBLH1BRJHkZcYB5W+p8WUWWLXT3DnUQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] auxdisplay: hd44780: Call charlcd_alloc() from hd44780_common_alloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>, 
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Fri, 7 Mar 2025 at 18:08, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Mar 07, 2025 at 10:14:48AM +0100, Geert Uytterhoeven wrote:
> > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > HD44780 APIs are operate on struct charlcd object. Moreover, the current users
> >
> > s/are/all/
> > s/object/objects/
> >
> > > always call charlcd_alloc() and hd44780_common_alloc(). Make the latter call
> > > the former, so eliminate the additional allocation, make it consistent with
> >
> > either s/make/making/, or s/make/to make/
> >
> > > the rest of API and avoid duplication.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > As the code looks correct to me:
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Thanks I have corrected all grammar issues in the commit messages except one in
> the first patch which I do not understand.
>
> ...
>
> > While I like the general idea, there are two things in the API I do
> > not like:
> >   1. The function is called "hd44780_common_alloc()", but returns
> >      a pointer to a different struct type than the name suggests,
> >   2. The real "struct hd44780_common" must be obtained by the caller
> >      from charlcd.drvdata, which is of type "void *", i.e. unsafe.
> >
> > What about changing it to e.g.?
> >
> >     struct hd44780_common *hd44780_common_alloc(struct charlcd **lcd)
> >
> > so you can return pointers to both structs?
>
> I don't like this prototype as it seems and feels confusing. Also note,
> the APIs are using struct charlcd while being in the hd44780 namespace.
> perhaps better to rename the function to hd44780_common_and_lcd_alloc()?

That is one option.

Another option would be to add a "charlcd *lcd" member to
struct hd44780_common.

That would allow to fix the other odd part in the API:

    -void hd44780_common_free(struct charlcd *lcd)
    +void hd44780_common_free(struct hd4480_common *hd)


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

