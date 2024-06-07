Return-Path: <linux-kernel+bounces-206832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB97900E66
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 01:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6560CB23A52
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F7130E20;
	Fri,  7 Jun 2024 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULru72rS"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222438DE8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717802271; cv=none; b=Vttnv+d7zLAAkxJaHUFOWrAAI/WxASkWtr7avup+8oDbQ+LJ8HUtA3AGCgW1Hd8AAcp55pIlTdNd8BLggmSEFBCSoxIxZPWP091IKBN4ZuibWUfij9m2L/ZhScGkOVWAhMZdEGiXMVJ0lWL/h3FB9IsckXuVgInM7QVRLE6eISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717802271; c=relaxed/simple;
	bh=MAOu3r5TjNnaMsR0npAw2WjHsVUBpHA2CVLbSqT4c+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcbTA8CAuHnezQhoy8Q7HcFeyFYUMPTcLs3VX7d/9aqW4b2Ru2NvS7luekq2sVR+a3SH13Yblp3g1X+Ja95eJgT2n/0/Njfq1liSXWc1wc+KZhqdTq1+K2ldPNObZ4kvcmOYh8MFHTNXvQeLyN/lkaRr7sBCDRyVBDEUJ/bqOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULru72rS; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b93370ad0so3633932e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 16:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717802268; x=1718407068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MAOu3r5TjNnaMsR0npAw2WjHsVUBpHA2CVLbSqT4c+8=;
        b=ULru72rSuj7M4wpZnsT34Bnjh4GJ+JZ62BhUU1MGVKkLNLZiXRE1bfH84SYGuUJr/q
         7sMgJJ+EDLxL/IsSJyivmPBG6VrBuHP7mLnnEUJLIOALfKxKefYl7cXtTJzSxztlVqFV
         TYtPviOqqNpHKmHJYZcxlwMEwVfqU/x1k/3ezk5qAi8CnRurqWnvDQBrcdvfXMcXfT/6
         n9j1D6UocAENXNEt0KhWUd/AIeyzozygJrhmZMhhBL7UGdiqjeiQ5u9g+K1wcmpZMMHd
         8XS+AKz/Ouj2pERI0R43lTeh88RTxezQDDk//rn6wmlXzYjmIgUItu8p306zQUl39rR+
         Dyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717802268; x=1718407068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAOu3r5TjNnaMsR0npAw2WjHsVUBpHA2CVLbSqT4c+8=;
        b=iKDKxsy/J1jlca79E1NWqlAGrDb9TIZrwGgjgyBUNNPNp/l9Sex8YoIdeqHPb7hkYD
         sz52aMXuSuPIRXq1tZZE0EbOocg3+JOLU5S/2SBgE4E5cRXO9KyQgjHlz0NC8HhQsh7G
         PDEoBkJEHZg/P6pb01XZkEIIjz1lYCxQMJJlY907EcES3oQGGWGG3L64dc8xq+0GnD27
         rEIo0fgzZitLJ7U6Ukge/J5/DO39vXgSPwVOd78lrJA8jIUYMAYwCKkaJXGNGedpQTGi
         sJbSYLEZRJHoRFRQT10iImxN40cp2CYxA96xaxwHu1exe/Dvd/+auVodhnMXFbDcGM6x
         90Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVwxx8k8Q4C5BxYY/ELUheQ/P/MwZ9FjUEf/FM8wdtyTLH6bfLIOkU+mojag8g7I7xJTQ33cgNSmBqS9tj+eedslAQQsI63wOxziWYl
X-Gm-Message-State: AOJu0YxVFaqHxymUJ1TiWm3jQbUN8JQEzAP5ZFMxroDkHmcB/x+IbBCC
	tMl1YxMuboEe3Y6CY5sr4zR3uRuQ8v32as4tYxcxIH5WsCkiXLHSxTcas4qiIriV7ExITJORAah
	Ec2wBtmP8sL3gGlkynt20/gKicmop5chSOwny
X-Google-Smtp-Source: AGHT+IE2hnTLk1weXhgvCaoD9PboDDewAunIdxaM21zkp3VonPAB2Ox/0fQtE9F/UFsPqRJcNElvIXq0CsHgR7+MzZs=
X-Received: by 2002:a05:6512:201b:b0:52b:c88e:cec1 with SMTP id
 2adb3069b0e04-52bc88ed2d5mr1115634e87.33.1717802268046; Fri, 07 Jun 2024
 16:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com> <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
 <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com> <CAGsJ_4w_dEyLsPhdJCtRMReXDD116p+U979Yk-8EBu=zx5FWgQ@mail.gmail.com>
 <CAJD7tkYnZCvwUSTAx-N-08b+mVF4yHEdDTbp9oqYrVQXX8M1Cw@mail.gmail.com>
 <CAGsJ_4wAYbofjg99iEr7cEAptH9Ve9WcrSXho8A-Sw54vb8Msw@mail.gmail.com>
 <9374758d-9f81-4e4f-8405-1f972234173e@redhat.com> <CAJD7tkZBzSB_6pAZP0n0nq+W=J1XKQGFzZZLzPmSH0apwaqTNg@mail.gmail.com>
 <CAGsJ_4ywmVbO+nrbcxz9YMdzi_y5qSUG3Cg=3oz3kNpQ6gg6iA@mail.gmail.com>
In-Reply-To: <CAGsJ_4ywmVbO+nrbcxz9YMdzi_y5qSUG3Cg=3oz3kNpQ6gg6iA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 7 Jun 2024 16:17:11 -0700
Message-ID: <CAJD7tkZkChE_bGJCnf3u0493PZOe1=+Y8S_nq2=j1uP-BtZ9Mg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> > One problem is that even if zswap was never enabled, the warning will
> > be emitted just if CONFIG_ZSWAP is on. Perhaps we need a variable or
> > static key if zswap was "ever" enabled.
> >
> > Barry, I suspect your is_zswap_enabled() check is deficient for
> > similar reasons, zswap could have been enabled before then became
> > disabled.
>
> I don't understand this. if zswap was enabled before but is disabled when
> I am loading data, will I get corrupted data before zswap was once enabled?
> If not, it seems nothing important.

If zswap was enabled and then disabled, some pages may still be in
zswap. We do not load the pages from zswap when it is disabled, we
just stop storing new pages.

So if you just rely in checking whether zswap is enabled at swapin
time to decide whether to use large folios, you may end up with a
situation where zswap is disabled, yet parts of the large folio you
are trying to swapin (or all of it) is in zswap.

This is why I think we'll need to track whether zswap was ever enabled
instead (or if a page was ever stored).

>
> Thanks
> Barry

