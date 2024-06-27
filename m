Return-Path: <linux-kernel+bounces-232262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D317891A5EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CD81F26B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5097515217A;
	Thu, 27 Jun 2024 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fKHV+U0H"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAF14EC61
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489415; cv=none; b=VUUWLedyW06i1khgoxiMvY+Ni0xUHQaaDCkdjd8K/hhsgakCM9LvVakDU6iRS6QM47gTdBXHSHQhbiIH50ht7MQx0SifUfPy+KLhxlRb+A3vJV/OXR5vjGXTcpKmsJdlWLel1kb01mLcyguL+E9Kacz3e06GtFpYE4Z5MxOjnTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489415; c=relaxed/simple;
	bh=Hjb6Y9xufXv6W4XRLObCOevOAhOQJDuYsB67oNNqo8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTsA0MaIHw4h3VN1/bDwHbNqOylg2m6c1wLoxtNtEXJEQVrJy2ch8TwV4ti4qV02+uiwFDAk+Z5WnRq+88lMsvHr8EMCRIKOjS61qfxH8+pzvynuMGFi4DHyqa8HvyAVjGU0zqK/XU9kdbJ5LhLLrfDZIBZx+i52rhp6d5dAeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fKHV+U0H; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso93669011fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719489412; x=1720094212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RTscV93mnU/sdtKW3g3pscHnzbtMVWx7thKuq6j5iWA=;
        b=fKHV+U0HHhYM+bS6fvQVZzUX/sOfqyEuyDc+RLcLRMlaM7h+wz3/df9juKVCuBik0j
         q7a3lLTtC2ocF+VwBEmc/wDNLdyi1wWc2e2whQDZ/5FVp6rxko3TiLClURVmETRunmP7
         4Dscx6xO2yMC8blc6PTdTIZcisZTIzRqI6zCGq79Qshm90H5iTMYp5WBqMBN1D1g6w7/
         v0yyJHteW6UffWK9OC+m/nKOMNyqYe/LVzTDzzfE3r6v3IIRWDg/fA1i5hLwppmwaotj
         QpWlkX5m9UbEvr909uqEj2rw9WmB0RCAUG4grsHgwjZNISjw8UdJyH4nSPf2Upu43F72
         /0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489412; x=1720094212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTscV93mnU/sdtKW3g3pscHnzbtMVWx7thKuq6j5iWA=;
        b=o7Sq6tAXOVd0F/ZsryQBWBcC1YCGdh+lJtg7GjAOl2ebDbMVOshu2oMvhsashNsbwO
         qXR0KGHlqxK/1QJZMst+d475NoErgFgopJL4Gg+BHrAp0CVuBNm2czqL5tG9StaFjJR/
         oBIv+41/1oswYp8ZNoLynBUwfs/ykNaG1JjB9r6ay3p6gVCJoafI9L15waYsdxRCUDJN
         XO451wiqWaDoYn7jx+tJRLgNKI2KIfaVSDn40k1VWOYAdGGxoE0+Llx/bv2DLwSz4Td6
         IZ1Xj/LvFn/N8P7axRxs0IMa2GGMzn55qgHr9ptU7pmAFSadE3oATGjK1SUStHrUmPq3
         QslQ==
X-Forwarded-Encrypted: i=1; AJvYcCULfndPgSY81fo8wChe02UMQ/0CvGEVmJhLND0n0uVr1LKDCUV9WQM3wGnfFwXt5wA3mTyBd809enX2pPXpDBNFyhvw2lC/xwuzF2tx
X-Gm-Message-State: AOJu0YzsVsOa+FPJPPNnN1G43SIF/qrmZfW6mwdHU7S9iQntgc1SScUt
	z6qyYNm47VQyQLkMWoHC5OHnK5ZWjCjT1HFI1++kbJUzSha0n798q9+at0pboeE=
X-Google-Smtp-Source: AGHT+IFBhzD4ba4RxYT7GBZHeb8AVWfuDT9QQmIqhnkzesUOrfSDBtxMVU19upAdp0geCUqhs/QOCg==
X-Received: by 2002:a2e:7303:0:b0:2ec:4fec:8bda with SMTP id 38308e7fff4ca-2ec594cfe83mr87404851fa.36.1719489411987;
        Thu, 27 Jun 2024 04:56:51 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d17b03f3sm779936a12.47.2024.06.27.04.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:56:51 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:56:51 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: remove redundant
 seq_buf_has_overflowed()
Message-ID: <Zn1Tg6_9NyxJE7Tk@tiehlicka>
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka>
 <CAJD7tkZfkE6EyDAXetjSAKb7Zx2Mw-2naUNHRK=ihegZyZ2mHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZfkE6EyDAXetjSAKb7Zx2Mw-2naUNHRK=ihegZyZ2mHA@mail.gmail.com>

On Thu 27-06-24 04:33:50, Yosry Ahmed wrote:
> On Thu, Jun 27, 2024 at 12:13 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
> > > Both the end of memory_stat_format() and memcg_stat_format() will call
> > > WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
> > > is the only caller of memcg_stat_format(), when memcg is on the default
> > > hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
> > > the reduntant one.
> >
> > Shouldn't we rather remove both? Are they giving us anything useful
> > actually? Would a simpl pr_warn be sufficient? Afterall all we care
> > about is to learn that we need to grow the buffer size because our stats
> > do not fit anymore. It is not really important whether that is an OOM or
> > cgroupfs interface path.
> 
> Is it possible for userspace readers to break if the stats are
> incomplete?

They will certainly get an imprecise picture. Sufficient to break I
dunno.

> If yes, I think WARN_ON_ONCE() may be prompted to make it
> easier to catch and fix before deployment.

The only advantage of WARN_ON_ONCE is that the splat is so verbose that
it gets noticed. And also it panics the system if panic_on_warn is
enabled. I do not particularly care about the latter but to me it seems
like the warning is just an over reaction and a simple pr_warn should
just achieve the similar effect - see my other reply
-- 
Michal Hocko
SUSE Labs

