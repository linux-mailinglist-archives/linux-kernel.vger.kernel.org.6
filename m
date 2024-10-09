Return-Path: <linux-kernel+bounces-357538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310C997251
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0DA1F21F76
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1D6198A0D;
	Wed,  9 Oct 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXAKTFte"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803B1922EB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492700; cv=none; b=Vih+4PXhHalzqGZ/JFbRmwsmUwqUEK/dexLrkGiH9DwmmZlp/n8aR8QYh6iyYscHbPb0IQ0Jo8JGpRP3nKso8I3VIrdQ7yBvwkzDGDWFVGswWXFkfQ27TAQfC8xFfhzo8DFiyxuqiUW2prr6izMmIvT7vs/XyabdXawtcGk/DNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492700; c=relaxed/simple;
	bh=KV/cSNhGI4P0Y0AE/y1W065QJ3N1Z9l3U3lj34z2gq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I84DpdYiBlQtjFW7QceP6IiOK84+LlTfZFsJcb0WGRkYVAJOUROhl/vHLv9LMcDdy7KGvlG73C6jfHuzRn3g/zgOE0hjIGewchwCK95phkVxy15Vs1RIC97dlhf/Vn3ABZvtEsj8fdvCq6eCA0jzZWCLFnebGdQZdjtOwicQM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HXAKTFte; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cc8782869so71679145e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728492696; x=1729097496; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JcvhzK/M2OB+8jA9EG3fqKF6d49AM3B/50Z3kYSBu9Q=;
        b=HXAKTFtevWNgW6SJYlvZhXy/+fJNbtCgQ2SgdtvpfhKqojwNwTY7/7q1kKAx0Wv8qD
         Zab4mQtMDS8AVGwzJdFEs6+H0+rc2da+EO3xP7zXd2Yzka4kAVqOgxSkkLhiyj78TJFQ
         b1GLSiHRdUtS7Pfv6jkaQgb8gpnhLJcfURaSt7V22kzoh9csqchTRXTY6sf6QNRtMwSr
         qXm6QhE5lSYDZLMK4WG7upH3ax4sFm1TE3wOoXehP4bRrU9GGt2rAugsnmK5eeGXqQoX
         KRcUyJi4mXZr7lOoWf0UIwIGggIDOT2LCJTLckpGqCU+hH9aGFM1F0eCs8oFJddTsF+3
         bspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728492696; x=1729097496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcvhzK/M2OB+8jA9EG3fqKF6d49AM3B/50Z3kYSBu9Q=;
        b=VFDl/H1t+ri5daSiD+RfLToea/2uUwhPf8MVGHj28nlwDR9Kf84w62fE8xzoJHF5bJ
         rjH2G/N2cXXMEQGOdKSTCACf2cvRgeKBty/HXX3FYvH7VQ8PYkey0crQtQsJXmYGmFG9
         EWJ5pyP+/wmfqCy2OBc5BnFm6B44d+0YuKpn+e4ZQaEYOZBIk+qttEYs5QKefN+TQ7D3
         q0jwyjMVePd6cAlqxBTnU2ZQMLfHVmgugDVxLQdo2DQJncO3lzwrhSINaK+84heC5t4p
         Ft/RGxWprEw+Nn1zc3d0O2o1xqFUKaHH7IjdZZRFT1PGPKGh5EWdWzYPSsgxfrFhZ9yO
         Y/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU0bS22aAgi/+atxFgN4+UQGUOSbop/bm38CCLgMxiw7MNpjWxaYPG45dxSCcfbcVQJRoF7wqOHcoks7Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKaimT694oTwa85Uj/gSWsTErbOteUMqC5UFGsGyyYjHaUY1yE
	9dSUK8wPvveHpW4f5ddt1MDsxvr21XO0bNgRmQC1xXvyxol2Os1aGXekTF3n7eU=
X-Google-Smtp-Source: AGHT+IF0T4FAqQj9qW87fHcjoIgPXQ2XJcxemN8K/sFZeHug+nBirxN9MNXyz33vKxSVnAXSj6ipOQ==
X-Received: by 2002:a05:600c:3b1e:b0:42f:8515:e490 with SMTP id 5b1f17b1804b1-430ccf0ce1emr27481625e9.5.1728492696288;
        Wed, 09 Oct 2024 09:51:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf516f7sm25063995e9.21.2024.10.09.09.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 09:51:35 -0700 (PDT)
Date: Wed, 9 Oct 2024 19:51:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20241001: WARNING: at mm/list_lru.c:77 list_lru_del
 (mm/list_lru.c:212 mm/list_lru.c:200)
Message-ID: <892332fa-e1d0-4581-9c42-045660d7dc80@stanley.mountain>
References: <CA+G9fYvo5npQ3o_vgiOX2guHtgafRoFPL__4O8Kcwg2=ssXmKg@mail.gmail.com>
 <e718bc99-e63b-4adb-9e40-2379f48301f5@stanley.mountain>
 <b22dbfe2-dd29-40de-a4a3-4a0d6b55cd65@stanley.mountain>
 <62a65418-2393-40ec-b462-151605a5efcf@stanley.mountain>
 <CAMgjq7CapiW2h2pzcKQBhwf_5rs5fgMGHw1E2YJYwEiY6zc=LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7CapiW2h2pzcKQBhwf_5rs5fgMGHw1E2YJYwEiY6zc=LQ@mail.gmail.com>

On Thu, Oct 03, 2024 at 02:58:19AM +0800, Kairui Song wrote:
> On Wed, Oct 2, 2024 at 7:28 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Wed, Oct 02, 2024 at 02:25:34PM +0300, Dan Carpenter wrote:
> > > On Wed, Oct 02, 2024 at 02:24:20PM +0300, Dan Carpenter wrote:
> > > > Let's add Kairui Song to the  CC list.
> > > >
> > > > One simple thing is that we should add a READ_ONCE() to the comparison.  Naresh,
> > > > could you test the attached diff?  I don't know that it will fix it but it's
> > > > worth checking the easy stuff first.
> > > >
> > >
> > > Actually that's not right.  Let me write a different patch.
> >
> > Try this one.
> >
> > regards,
> > dan carpenter
> >
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index 79c2d21504a2..2c429578ed31 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -65,6 +65,7 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
> >                        bool irq, bool skip_empty)
> >  {
> >         struct list_lru_one *l;
> > +       long nr_items;
> >         rcu_read_lock();
> >  again:
> >         l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
> > @@ -73,8 +74,9 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
> >                         spin_lock_irq(&l->lock);
> >                 else
> >                         spin_lock(&l->lock);
> > -               if (likely(READ_ONCE(l->nr_items) != LONG_MIN)) {
> > -                       WARN_ON(l->nr_items < 0);
> > +               nr_items = READ_ONCE(l->nr_items);
> > +               if (likely(nr_items != LONG_MIN)) {
> > +                       WARN_ON(nr_items < 0);
> >                         rcu_read_unlock();
> >                         return l;
> >                 }
> >
> 
> Thanks. The warning is a new added sanity check, I'm not sure if this
> WARN_ON triggered by an existing list_lru leak or if it's a new issue.
> 
> And unfortunately so far I can't reproduce it locally on my ARM
> machine, it should be easily reproducible according to the
> description. And if the WARN only triggered once, and only during
> boot, mayce some static data wasn't initialized correctly?

I have a config where it printed twice and the second time wasn't during boot.

https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241009/testrun/25363339/suite/boot/test/gcc-13-lkftconfig-rcutorture/log

> Or the enablement of memcg caused some list_lru leak
> (mem_cgroup_from_slab_obj changed from returning NULL to returning
> actual memcg, so a item added to rootcg before will be attempt removed
> from actual memcg, seems a real race). If it's the latter case, then
> it's an existing issue caught by the new sanity check.
> 
> The READ_ONCE patch may be worth trying, I'll also try to do more
> debugging on this and try to send a fix later.

The READ_ONCE() patch *seemed* to work, but the bug is intermittent so maybe it
just changed the timing or something.  Still, I feel from a correctness
perspective the READ_ONCE() thing is probably correct, right?

regards,
dan carpenter

