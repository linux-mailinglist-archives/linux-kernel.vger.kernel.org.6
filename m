Return-Path: <linux-kernel+bounces-322096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E1C9723E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7294CB21278
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487F18B475;
	Mon,  9 Sep 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t34Pf42b"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8718A937
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914703; cv=none; b=NhAsJwEdjUiAVVWsT83f7nfjaAxE/a7EZe4PSvklYZtuSUvaGRw5WpA81BHBnOjI5HS6EgDuXpqA2UfExwiHi7xl8k2Bw+tYDeYnFKV4+5sjRRnNBCcok2mrhf11k+bkI9rrzFB9ziI73dlGgKbbbMU72Yd/vQi9Cm/ka5Iwfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914703; c=relaxed/simple;
	bh=L7XvJSzr1QAJd6cZJsrqg91+BrDu1CGj5lNlq+nGD1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQYlaYpB6zX7//WBrp9y89ewJ0yygcHzEPqLFmO7Y8+fqFFgGwREtMca6raezxx0HaVdj1YY+p6aa2c8KEtfDaIZ0QoTWqjTo1Vstcw4Jnrt3rDwusf0yl1JfK1/jivd/iqiuvrnozxiWWq4bIMR6yvff2wHEZTOr70Sn0Y1xME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t34Pf42b; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa086b077so432302166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 13:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725914700; x=1726519500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y28KVwZM5713wIABpPiFiUqwyB36UAsbyqOCul1ZAls=;
        b=t34Pf42bEGSiobFcg+RkTRNuE8c40lNPDWhVknEwJNOsuP10oTnbYXAfH3ImyVNFvn
         XHkQCmqxpKLRPTvUey/EOVDPUxrp+8ir847VLwoFNV49LeERbETIh8Ic34r9ZnJw4Wm4
         1ytmZ/XW8aR6lxLGKqccqoDBks2b6d6JpxwtuMNY+45CcRL5EiT3gHhSruaaKoPKD+4r
         5oze4DO7tsn08SSYM4Cmu2kP6r1WJSGR2mvm+RXCZRABPq9ea8hNTS7uEImziXa8Lx62
         Z0yhc7w60MwXJKvY1BLh/X4dqeH0HI+YfFtJrsL98p7IZr7kkUv2TkW3F4BnVxeXQN8b
         YUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725914700; x=1726519500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y28KVwZM5713wIABpPiFiUqwyB36UAsbyqOCul1ZAls=;
        b=kEcnbBTZS84H4yZdj93T9mTzBk5VQg5lM1qaVX/7LSeGZUZDU51QfeIN7BeoyqxIYu
         6eoU8uWKdUqst+zlHc2njzhYs5VSSwTg4ADRRRMT7/m2FaMDD+At2G6W8WnItC6iv6TV
         VCrDVE2ueNv/drY0HUdsOt5RYhLxdHy5JiDIsn08cmsXajDvyY3bdb8HwlcC9wXvi0Zi
         Cp7uWulXByx2mrg/2xSD1zE2v8yNRt1lqjxeUy3XwTDAALqypm5lRXhYzU1sw3JwOll/
         DVxjewTKnMUYB9sgGCYyUNYF9EVExlh6uTpYiUtYDdAv6AyjKVTGwQpO4I0SlEkjmxva
         SXhw==
X-Forwarded-Encrypted: i=1; AJvYcCWcLnk68zBfF9TRNwT2Xg8BqU69c3Jz6GJmRP8JMEnoEOASZd5Xds3UNdSD7zIsI3lp3pRgHxYctBGTpT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOW40R8Ds8XHvJnh66d12BcOLUbd2aoYpmoEhhsyRSZkfvtGjx
	J3VBgX5rGI6D/W6zV/vJIARS/RosXfKveVYLr/HCgHYSDy574gam2J9aI5hiGwAGC1NRe6I7mf+
	WGoH/BtrvPjrFE6WFjFWuttwNhzieLLL/fdZt
X-Google-Smtp-Source: AGHT+IHUOhpj2xyrKzGrMnUTxW2VUXqTfgRqFsZ7Q6h5I6U2jYCG15EHSZWlAdAwUqiQ4R3s2tR81G50b+7cttWuTZY=
X-Received: by 2002:a17:907:3f1d:b0:a86:82e2:8c6d with SMTP id
 a640c23a62f3a-a8a88870e91mr932920066b.62.1725914699445; Mon, 09 Sep 2024
 13:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909202625.1054880-1-arnd@kernel.org> <CAJD7tkb9q-_MHFWdM7+KueFS9LJUWsvqHdDmFnpgNahyjv+8+A@mail.gmail.com>
 <85524814-6256-4f83-bb59-879debf26646@app.fastmail.com>
In-Reply-To: <85524814-6256-4f83-bb59-879debf26646@app.fastmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 9 Sep 2024 13:44:23 -0700
Message-ID: <CAJD7tkbLfKPLJb0_eiXjjfxaDZSKHCKfTJrWrnw0stNhzDh=gw@mail.gmail.com>
Subject: Re: [PATCH] mm: z3fold: deprecated ZSWAP_ZPOOL_DEFAULT_Z3FOLD as well
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chris Down <chris@chrisdown.name>, David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
	peterx <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 1:43=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Sep 9, 2024, at 20:29, Yosry Ahmed wrote:
> > On Mon, Sep 9, 2024 at 1:26=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> =
wrote:
> >>
> >> -config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
> >> -       bool "z3fold"
> >> -       select Z3FOLD
> >> +config ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
> >> +       bool "z3foldi (DEPRECATED)"
> >> +       select Z3FOLD_DEPRECATED
> >
> > Thanks for looking into this!
> >
> > I was going to fix this by changing "select Z3FOLD" to "depends on
> > Z3FOLD" instead. It makes the warning go away in my builds. Does this
> > work for you?
>
> I had also thought about this but decided that this would
> make less sense from a user perspective.

I doubt there are any actual users who care :)

>
> If it builds in all configs, I won't complain though.

I will use "depends on Z3FOLD" in v3 just because it's simpler. If
bots complain, I will fallback to your approach.

Thanks!

