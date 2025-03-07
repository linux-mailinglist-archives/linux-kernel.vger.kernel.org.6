Return-Path: <linux-kernel+bounces-551800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2AFA57116
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832333B8C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419024BBFA;
	Fri,  7 Mar 2025 19:06:53 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC517B500
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374413; cv=none; b=NdJExlFaKFilXl3t53rCoELggkbqPa4tOcRClC27LrbYnD4+yDFU1O/IpEVDQcQ1GNCdHU2UP3qusrlDj9bBDno3aaT9FfTEh2Ax/7XOVMfGr+oZuAzcJKEZFDInzapzlZXXXCuJ75F2NUBqgq46VuPFwDboB7EukMcwQkzszv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374413; c=relaxed/simple;
	bh=WQSFPh2zicA/PXjMw9JHWU0DMFza0F45XiMt1DvM+lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsAUMbEY1ZJ5QIHQpID/zjrrsxBC0yCsf/393jYBkuEWhv1nJCPqEVoexL4ZLeBVM4SgCHNG8l4W72FKTwLrLfpmXBNMQQzXerYuh+NxhpXOXoH/CnZh+lrYdhovssOh/cNtBHBPJ6ABH8miIh/+SOQ6tY4spv2wy+bHDNCCo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-860f0e91121so3405889241.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 11:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741374410; x=1741979210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpMUUfrBMHHlX0w3ub+fTjcN6MAy6ST8zgJT13ufeuw=;
        b=RW8iKtPh80dUC0ahyIcinBEm89uPv4TycLPlHDLokcn4zPAy4f5rpO/eAzbKkjm1k2
         c7fh8Gj27vqTiLcHlyYuHWkAa+p53fW8Sm3FJ8RjBCuN5v9iiKD0PPe7pvCDWfI6Lprm
         EZQel5DHMsLg5B2+8ArbqHl6SXDHab3nqn6lPvKHnQK2WPJer5nLmHFm9PQeyGFSjzF7
         iQuHCKnxa8fR6xD+3vTrkDgUz3l8fuZX1+G1gOj7hyqUhGqib60za6eyo1tRmAGc5JNF
         b4rAvWXfd+vX4lsrwG3+U6KNjNCV6NCeTODpKKMe16F9rDq4zItmq2Kw7lE+Xs/2Xk+c
         KloA==
X-Gm-Message-State: AOJu0YxqrB5FzVldPjeSBNE9rQC9ksGntTfYGDJScNOEc5aoHQyC0LFd
	DY2Cg6cA4NSNw/yqxshEkEq7J+dA0AnUNJhmc09NoWIit9MV9RrPaTSKaiBgDPM=
X-Gm-Gg: ASbGncsQcomKQGcl8pDG5uRBG5UoFAxpPfDaGDB+pJqFRRth3aUPrMyZoyReKpFdYqc
	9KfT/1uxDoxDm3nGfe95Axaqhy44b++E7eVW7neRGxGWkWAyFywjkKdB1bndVe8BTrI6oSCTwWB
	4VbtLwn68ASrh4AOPRZFgefjnMR6YBaNN/cqUT1bDewaJbEuhHF2i0OfPruaEEOCmjpqmsQW5NJ
	2390pyr7J0CtEKCnzjDPaYH2wmUgYY6um8E4HlnzI6ZYfPySS7+W2w76D1Vv/Uj1Yxs7P53rBJA
	Z3xuikKn3Avun/+D1ErkVIz4K0kFoHKqdP4j2Id/zBF4WzpfLTiyDZ6VJKUNBCrx/n84SFcIt7p
	THvWasVsvTDc=
X-Google-Smtp-Source: AGHT+IEAPvqWqNr5REi2mgHz4+inb0FWkdzF35zVeBHymROgCLsf+WYLMdoW2oE2ZpOxMAHHv0cKeg==
X-Received: by 2002:a05:6102:374a:b0:4bd:39c7:804d with SMTP id ada2fe7eead31-4c31b2cda7emr618807137.0.1741374409731;
        Fri, 07 Mar 2025 11:06:49 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fbcec740sm828682137.30.2025.03.07.11.06.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 11:06:49 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523de79f3b0so1200149e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 11:06:49 -0800 (PST)
X-Received: by 2002:a05:6122:8c1c:b0:523:771e:8b81 with SMTP id
 71dfb90a1353d-523f29e38d9mr662242e0c.7.1741374408949; Fri, 07 Mar 2025
 11:06:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-7-andriy.shevchenko@linux.intel.com>
 <CAMuHMdXP1=7YJzYp=_WJsqx2mtBYcwAjpOGK2_9SH+r4w6v2Ug@mail.gmail.com>
 <Z8soDV0U2LG2KX9J@smile.fi.intel.com> <CAMuHMdV1+ftjpEcg4xYjBLH1BRJHkZcYB5W+p8WUWWLXT3DnUQ@mail.gmail.com>
 <Z8tCbjJk24ryV0DJ@smile.fi.intel.com>
In-Reply-To: <Z8tCbjJk24ryV0DJ@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 20:06:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU3KKSFhN8hD_ZoyNfBUV4ZWa5=zxUPfmpivjmVhW8__Q@mail.gmail.com>
X-Gm-Features: AQ5f1JqCBHM9KLJTTP6KNcJYNps8ej3g0bdp8_nOambiKE5SPcUYy2Dck9ESVBM
Message-ID: <CAMuHMdU3KKSFhN8hD_ZoyNfBUV4ZWa5=zxUPfmpivjmVhW8__Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] auxdisplay: hd44780: Call charlcd_alloc() from hd44780_common_alloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>, 
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Fri, 7 Mar 2025 at 20:01, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Mar 07, 2025 at 07:19:57PM +0100, Geert Uytterhoeven wrote:
> > On Fri, 7 Mar 2025 at 18:08, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Mar 07, 2025 at 10:14:48AM +0100, Geert Uytterhoeven wrote:
> > > > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > > While I like the general idea, there are two things in the API I do
> > > > not like:
> > > >   1. The function is called "hd44780_common_alloc()", but returns
> > > >      a pointer to a different struct type than the name suggests,
> > > >   2. The real "struct hd44780_common" must be obtained by the caller
> > > >      from charlcd.drvdata, which is of type "void *", i.e. unsafe.
> > > >
> > > > What about changing it to e.g.?
> > > >
> > > >     struct hd44780_common *hd44780_common_alloc(struct charlcd **lcd)
> > > >
> > > > so you can return pointers to both structs?
> > >
> > > I don't like this prototype as it seems and feels confusing. Also note,
> > > the APIs are using struct charlcd while being in the hd44780 namespace.
> > > perhaps better to rename the function to hd44780_common_and_lcd_alloc()?
> >
> > That is one option.
> >
> > Another option would be to add a "charlcd *lcd" member to
> > struct hd44780_common.
> >
> > That would allow to fix the other odd part in the API:
> >
> >     -void hd44780_common_free(struct charlcd *lcd)
> >     +void hd44780_common_free(struct hd4480_common *hd)
>
> This I like better. In a separate patch I think?

Fine for me...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

