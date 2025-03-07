Return-Path: <linux-kernel+bounces-551799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121BEA57114
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE153B8A98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86124BBFA;
	Fri,  7 Mar 2025 19:06:14 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B617B500
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374374; cv=none; b=u7ANWSeLjHbbm9OxFngQMtMW2HOTfxTY766crVLBGfoj4y2nDGUwKM1U/7fbauZuvsvh87lojzQtbluBw0jMkFwjtT/jCUJUCsTh7R9QkCVXyQOEiCtoT0dPGIYYIFpCUkbpTCILKek7SK4rflllBH28yHUKK6yo8iZ4HnPYndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374374; c=relaxed/simple;
	bh=KQcgaJCiBtQ/TxcW6jMDnPp3L1mrguFcs+VmCvfwuXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISpNLYlcGyV/mTWT8m/MoogYPRv/Dqbji9G8rjvo6AWMMslv4LwVfJmSqWJSEkSig4I4MQcwTgHsQovjvXsIfN0hxrjhamTIrDpOoGKGAx/QIFg1+B10+JpL9wfd+9eI8PV/S23ydlrT4M7rrLqdH/DTuvP+ewpfefgBYGcTFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c08b14baa9so206623085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 11:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741374370; x=1741979170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1kmiGF7uO1vlI4RGhEH0NGmlztmEAIUcGva+o+3j30=;
        b=fpDcTnPiLAUVahkI10uwnS53XbIoU2CMwEnTTyvsGrPQ5u896Qh5FHanIMUPCR2OUw
         Z0MsvvdQTSg0ZSt8OQQuVlj/Ov/cKtdk/ygMIiehQB9s+MBjPHmCacZlAbYSSgGWKSis
         EayZ/EMq3bCaL4qpg+711enqxCvvTx5NReYVE6RKsECbsfHefLEYcThvw38AIeTj6267
         kUZLNgwXdQ8rM4kD7DHa92E0RL0HOTToqtLbSqLzxIGFyFL2PGQVXSq2kgc5HdRAQ4rE
         VlP43iD/nHPx9lI6n4DAcCmOAFhOKmFjbguz2XbbEPIcTdal/SkPwCTJvuRswZQe2X/5
         Q7Jg==
X-Gm-Message-State: AOJu0YzhZtp98VNsnnII3TzaMZ6G0XN/+SnVYuW82Y2dHh0mMbnXCUuW
	p2nkyDMsDPBOTNbMNp/qgS7OFwyNAlvz2mtr9KmbKrrLiAkhCDZ+jEqzrSCkNC0=
X-Gm-Gg: ASbGncvkIcJuAF9fuN33ciVfdZWeeznLJOjykIw5+j+o93DddWJHOI4GVKBuDTZjWOk
	0hgABPOd24v4c6Qsa86c+UfUcoYxgcBmghkOgyYuvD+2UnROgCZ771GuKIM2jrO2r/uTY3o+b+9
	iFDuozBTA77EEF1qvxFuCA9TEr9kS0mcuhRyTgWs1dwQ/UBp7cNhuyWVmikHyi82vRRRZRvOi2x
	+wfNqMD+Or4hG38XJSTiIFoYMl4fVIFD4gYD8ngst2wR49m9xO2stP82CQonV1Bi795GuZmdul1
	gmTP6QocJOJ86ljpHUwR71KtaIWrtvFtAsmeRy/zT49h4NjDzhvQfheIaAiJu+QVex6Ds/VcHM7
	a7nfgYbrb394=
X-Google-Smtp-Source: AGHT+IE+QVj00PxhjOgJn3N3JLGD+xUH6eGBoGSrDi5+jZ6D8xjDSqPld8QSZVci8IrAmLWJn50ffQ==
X-Received: by 2002:a05:620a:2609:b0:7c0:9df3:a0d7 with SMTP id af79cd13be357-7c4e61763aamr644358385a.41.1741374369663;
        Fri, 07 Mar 2025 11:06:09 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d9a3e02sm23269461cf.37.2025.03.07.11.06.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 11:06:09 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c3d1664ed5so269891685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 11:06:09 -0800 (PST)
X-Received: by 2002:a05:620a:2855:b0:7c3:c13f:ae04 with SMTP id
 af79cd13be357-7c4e61763dcmr883907685a.36.1741374368990; Fri, 07 Mar 2025
 11:06:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWBGb5AXv8Ch3XhPPHc0CVYHf31tx1Feh87OU5MDUCdPQ@mail.gmail.com>
 <Z8slexKyo7VFkSKW@smile.fi.intel.com> <CAMuHMdVmg=kuPWCN6rRTxP1LSZFtK=gagd0x092kxzif8Tav2Q@mail.gmail.com>
 <Z8tBnq-j7gKrzlpk@smile.fi.intel.com>
In-Reply-To: <Z8tBnq-j7gKrzlpk@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 20:05:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWeFhqf-A-71pCZ+eFMh+ibGudMwiE5hPrdkfCYwVXHCA@mail.gmail.com>
X-Gm-Features: AQ5f1JrQEvhAt4IqUMeWu0-h08uB-wRDF7FxywhqQS0iiAUXiXsK145uwgWA3fA
Message-ID: <CAMuHMdWeFhqf-A-71pCZ+eFMh+ibGudMwiE5hPrdkfCYwVXHCA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] auxdisplay: charlcd: Partially revert "Move hwidth
 and bwidth to struct hd44780_common"
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>, 
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Fri, 7 Mar 2025 at 19:57, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Mar 07, 2025 at 07:14:02PM +0100, Geert Uytterhoeven wrote:
> > On Fri, 7 Mar 2025 at 17:57, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Mar 07, 2025 at 10:03:31AM +0100, Geert Uytterhoeven wrote:
> > > > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > The commit 2545c1c948a6 ("auxdisplay: Move hwidth and bwidth to struct
> > > >
> > > > s/The commit/Commit/
> > >
> > > Why? We know that we are talking about the very specific commit.
> >
> > You can have a noun with or without an article:
>
> This is not so simple :-), esp. if a noun is a weekday or a toponym.
>
> >   - "a commit": an unspecified commit,
> >   - "the commit": a specific commit, specified by context.
> >   - "commit 1234abcd": a specific commit, specified by what follows.
> >
> > > My English is not native I would appreciate a link to a material to study
> > > the case you pointed out.
> >
> > Neither is mine, but the use of articles is similar in English and Dutch.
> > (I am aware your mother tongue does not have articles ;-)
> >
> > I found plenty of articles explaining cases 1 and 2.
> > Case 3 can be considered equivalent to "Mount Everest" in
> > https://learnenglish.britishcouncil.org/grammar/a1-a2-grammar/articles-the-or-no-article
>
> Okay, so you actually think that the hash and the title can be considered as
> "name of a place". Hmm... I don't think it applies here. It's not a place.
> Moreover some places require "the" article.

Only if they are a region, not if they are a country (yes, that's
unrelated here).

> Here https://www.butte.edu/departments/cas/tipsheets/grammar/articles.html,
> for example, the sentence "The 2003 federal budget" sounds to me closer to
> our case. Every year there is a federal budget, but we explicitly point out
> to one and reader knows what is this. The same with the commit.
>
> Sorry, but I am still not convinced.

In "The 2003 federal budget", both "2003" and "federal" are adjectives.
In "commit 1234abcd", "1234abcd" is a name.

Cfr. "King Charles".  "The King Charles" would be used only when
putting a very special emphasis on "king".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

