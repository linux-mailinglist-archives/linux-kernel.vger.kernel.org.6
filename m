Return-Path: <linux-kernel+bounces-236356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0573491E103
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B655928214E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFE415ECC5;
	Mon,  1 Jul 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4e5htErC"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F51E49B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841377; cv=none; b=F+NoZcGiL7lvd03poDZgEw2hdVz4MKbVtL8mz5AJpH7u+s+y6I34h7PjEuRV+O6WxqYNsjFFNEByQJ5tIetKaPvvojvLn1xC8osf5Tp2EraQGnlxuyc+T/xfc7BpDKupP72rDOM6f8cH8Wl5ya2JFBxioRqNNaKtSbMG8Hs90bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841377; c=relaxed/simple;
	bh=AxRzN7fHTVxWFbg84u/qgzpVKfY1AVTvfiXp5T9RQSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeSCj2RiM7T8LHb066KPIQJbmYdUaheDO+uUWdIT7mBX7l9ITcUUrK1AJRdva+yBknp5FxuqRhrYEHakpdFgqIdMVik0KVG1jU6erxHi5nzM25fMrQ7Wu1FMi+juNUdH+Kpyq3EUTUc5Ydl3Bm7rDbaw+DcD2zXOLjtO1o4tyyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4e5htErC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a724a8097deso359785366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719841374; x=1720446174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6+ROQuG9R9V4/iqWZBWFHNOUOamNJ5L/2g9UTxcB7A=;
        b=4e5htErCYqCU7O/3A6wyl0yEoM93Z9EMwbusanbgf+3hSdqhLBugSsxzl3KJEyjKxP
         Tmmi62HqudGMG5vnmH7sOyUMD8ZsIVRQcdrKIY3niGPdEgazpgFToREWE0GEcRb5a/iH
         m7cevmV6uYj/GVLOQaGc+lq6N6AnnPcV6SA1VeKzgAdKUp9nanFMNO1vnYzAopg1jplH
         jdIQy+dUFz1u42GNHmNP7AQ0CIx9JFDgCROxbH5gGUYQTMH8WF3ZePxbHpBpZ8txYN2C
         DitvIryPe65duPUmYjyyGo9j/rxbRIJ4fJsNI50nja8Kz8Yn4cllD6m7bwENqGiSjOPW
         rx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841374; x=1720446174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6+ROQuG9R9V4/iqWZBWFHNOUOamNJ5L/2g9UTxcB7A=;
        b=w/mwBm4Do9UGSUI2pAI/ZFv0IP2uQdnpA+2XMDnE1QNB/RpFHn8/2D/7G9I7jmfh2M
         NSP/m5G9N2iqhYiivtLK2DBn4PLRPfblYn4q7RJItA8XBuERtdfTA6IdeQPj/jQzDOci
         TrQAQfJv8faWv4iqmSKD3of9adeo9oYeGmTbpj28iuY0VBV/IYF7iUgf4tz5E4X3CX9Y
         8hZI+APlfw+QwamlXEYaknAEylOHgRatfFYtj5E2rUfeOu/vMzyxCXmNPAtkPHeP6Ovh
         iYLvPkXLuzLfgc+oclZ2iwhAaNbm727k3N3uAVapahw4f7FsZIFtYYRztXAFDnuvuTqa
         eJEA==
X-Forwarded-Encrypted: i=1; AJvYcCWLAQVP9CWYfAuyj73yhCY9cbvG6WXVx2mz4jln48Us6nKxP89pi2YQeUezPOWxwCKyI+r5zeqNSXJ97t6UaNgG+W1UlR1mWynjxAbx
X-Gm-Message-State: AOJu0YxQ+djzZNT4Z2SXsp18SlWoXlIDBznwwQyu9DHAAuSxzrahkRkh
	Y9mb849edcwtOwnTDIZ8hkKoqeb9RfDoUJBmcAwaAKPkC74HUIHjxG1CONh9AFgVTLn8LlCrENb
	KRd1LGObTaQDKx2gTQaJN9MFMUPJKKEeXqEPN
X-Google-Smtp-Source: AGHT+IFV4dTRI3P8iNIhdPexKZlB2wwYXOVVqOfVMChmuGqyN6r7izGH9FX3cKQeHPJ+zswbhWGGkzb1Wqq4fa4HaGw=
X-Received: by 2002:a17:906:b756:b0:a72:8631:2e01 with SMTP id
 a640c23a62f3a-a7514498a41mr332947666b.64.1719841373635; Mon, 01 Jul 2024
 06:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628031138.429622-1-alexs@kernel.org> <20240628031138.429622-2-alexs@kernel.org>
 <CAB=+i9RSCkYyqo-qXJNRKjUig7s5ZMGWCKmur1nNcD3KkFnhUg@mail.gmail.com> <4418c5c6-60f3-408f-a4ea-8d8ba1cc8afd@gmail.com>
In-Reply-To: <4418c5c6-60f3-408f-a4ea-8d8ba1cc8afd@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 1 Jul 2024 06:42:17 -0700
Message-ID: <CAJD7tkZebGv1Bd+T6u3UL5buf8J9RFh0y_kC0ZJjBRT3NdNOBA@mail.gmail.com>
Subject: Re: [PATCH 01/20] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
To: Alex Shi <seakeel@gmail.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, alexs@kernel.org, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org, 
	senozhatsky@chromium.org, david@redhat.com
Content-Type: text/plain; charset="UTF-8"

[..]
> >> +       union {
> >> +               /* Next zpdescs in a zspage in zsmalloc zpool */
> >> +               struct zpdesc *next;
> >> +               /* For huge zspage in zsmalloc zpool */
> >> +               unsigned long handle;
> >> +       };
> >> +       struct zspage *zspage;
> >
> > There was a discussion with Yosry on including memcg_data on zpdesc
> > even if it's not used at the moment.
> >
> > Maybe you can look at:
> > https://lore.kernel.org/linux-mm/CAB=+i9Quz9iP2-Lq=oQfKVVnzPDtOaKMm=hUPbnRg5hRxH+qaA@mail.gmail.com/
>
> Thanks for notice.
> The memcg_data isn't used for zpdesc. And I have a bit confusion since Yosry said: "I think to drop memcg_data we need to enlighten the code that ...". So we actually don't need to have this unused member, is this right, Yosry?

I think we need to have it, at least for now. When the pages are
freed, put_page() -> folio_put() -> __folio_put() will call
mem_cgroup_uncharge(). The latter will call folio_memcg() (which reads
folio->memcg_data) to figure out if uncharging needs to be done.

There are also other similar code paths that will check
folio->memcg_data. It is currently expected to be present for all
folios. So until we have custom code paths per-folio type for
allocation/freeing/etc, we need to keep folio->memcg_data present and
properly initialized.

