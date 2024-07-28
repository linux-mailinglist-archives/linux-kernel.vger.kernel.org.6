Return-Path: <linux-kernel+bounces-264853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC1B93E933
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9564FB2107E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169616F2F7;
	Sun, 28 Jul 2024 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="qY35M8mA"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17CE78B4E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722197673; cv=none; b=j/Pnspuutdj0a49alMFVnuFxt0AlTZOIFP1ONLb1yba+4PrGM2C590AIk1HqAzKheXU0MAhO40abW8g96C1DF50TekAmMmVVuHs8Nl6pNGr3s8JrfyZmoMe8+5yvCty8r9CRLL0a9DMPxXLLWKwL2OhKNSx8c4YXb8SeTWjYxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722197673; c=relaxed/simple;
	bh=DJWelLH4jtYLTPzwKdilgGWSPMlhtLyYrl1ZKhZUWrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bqa9tvDdVFjDb7MbDGsQGZK71j8fc7Yys6GDpihl4hJQRL9ThfJbeHboWHIlx2icEJQB7DQFlsm3xRo0GTLTLX/qwzN/WdXtA/eBKmw5QxeWe+23Kwe9ia2uHQE5uf4UERk+CaBBv0fUN1+Qlw9Y3ZKT+50t9hf2a5nh4GlBFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=qY35M8mA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36844375001so821799f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722197669; x=1722802469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ycu1zril1uFCDomaUeMMQCMb5QuOumtW+ynkKw0kdUI=;
        b=qY35M8mADpYYDmbbYguyV3dT8fBdVOcKPE/QaBOQ5FVAJOn1qVleCSpGMhPCoz9GZV
         ZsFsI++5engyCn/U9H0ujYYNxOz1fsTq+r416nXzQt22ADZkHiVLD+RfGz82516uBQVA
         wqtf/v5HC/CaVfUe1XiuDiWw1ikP5YZbjPZ7V5VNk/dB2uTyqWgMXN3a2NvsCvX4HZNz
         8CqedRS0HE7Wd4wQJEF4/qyNwCRIJ2TjV+SBKrALN48nbvm0lurVPmeBM0MW8ljz48vw
         BkWHD4tsqxLoUaZbX18SosbXCEuxavDCXvSQyRwVh0umdnxrasMfdYm2opv66768yygv
         xmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722197669; x=1722802469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycu1zril1uFCDomaUeMMQCMb5QuOumtW+ynkKw0kdUI=;
        b=HtUfG1ReveL8z9JRPGnJ2FqBbnfs4SFTpHHilCXSnd6bM7JFsgpswa5jPhQUX6C2D+
         +mG/lPQw7oBuoi4PHQZ1E6Np+07OUPmY6D8WDiY/mPxcrySFw10lwhvAgUJziJeT/zvB
         D5FwnuATbdyS7dp7gPZWycl6WfeRc//1qV+mgaYocGnsbO1qhsUursrw2Dkc4rpbhOBi
         rU1m5swTWniJ5JdQj0AZSsjjb6LPTA2kBi6t9RYs4ZI+noTLJh75wDqsY6DhKb6LPLw7
         nNZUG4q1GtDsGlDkhZMdutHI2t28mwZPLMxZcxZS3bevQaZpp/DMnRulKHamSmQgM6Q7
         Giow==
X-Forwarded-Encrypted: i=1; AJvYcCWLSM2qnAF1NAYBCKoTbfGATo9wYxhPwyuOBldge9j3egjQ+YZ+mblnTCwM/ZbkPKTsxr5XDLdBM6mZIytzM/yaGXoPxPqunD8qmMvs
X-Gm-Message-State: AOJu0YxSlP2vmc1799+MYKWkr4ydzpxJ2MZpXZQJ8/xGes+1KtxT+mNk
	7jP/RyJ5HL5pXhc8i5Q7T8H3wFbjvWDsuEHPlgCZXSTXLO8E2aKYRTkJ1s/Buig=
X-Google-Smtp-Source: AGHT+IEnlAE+8tBV7AWZ2CtEfcqrDJFOv9WfLMKpcrwKomD6Ci+u24jdxd67ZwaGw/qrTRheabkOcg==
X-Received: by 2002:adf:e98d:0:b0:367:9854:791d with SMTP id ffacd0b85a97d-36b5d0bca31mr3694510f8f.43.1722197668837;
        Sun, 28 Jul 2024 13:14:28 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9859sm10460031f8f.28.2024.07.28.13.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 13:14:28 -0700 (PDT)
Date: Sun, 28 Jul 2024 21:14:27 +0100
From: Qais Yousef <qyousef@layalina.io>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
Message-ID: <20240728201427.kxzn53vurpf7ij3i@airbuntu>
References: <20240720051248.59608-1-zhouchuyi@bytedance.com>
 <3e88f113-e7b9-9b26-a4c1-52cf92b820c5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e88f113-e7b9-9b26-a4c1-52cf92b820c5@amd.com>

On 07/22/24 10:47, K Prateek Nayak wrote:
> (+ Qais)
> 
> Hello Chuyi,
> 
> On 7/20/2024 10:42 AM, Chuyi Zhou wrote:
> > In reweight_task(), there are two situations:
> > 
> > 1. The task was on_rq, then the task's load_avg is accurate because we
> > synchronized it with cfs_rq through update_load_avg() in dequeue_task().
> > 
> > 2. The task is sleeping, its load_avg might not have been updated for some
> > time, which can result in inaccurate dequeue_load_avg() in
> > reweight_entity().
> > 
> > This patch solves this by using update_load_avg() to synchronize the
> > load_avg of se with cfs_rq. For tasks were on_rq, since we already update
> > load_avg to accurate values in dequeue_task(), this change will not have
> > other effects due to the short time interval between the two updates.
> > 
> > Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> > ---
> > Changes in v2:
> > - change the description in commit log.
> > - use update_load_avg() in reweight_task() rather than in reweight_entity
> > suggested by chengming.
> > - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
> > ---
> >   kernel/sched/fair.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9057584ec06d..b1e07ce90284 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3835,12 +3835,15 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
> >   	}
> >   }
> > +static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
> > +
> >   void reweight_task(struct task_struct *p, const struct load_weight *lw)
> >   {
> >   	struct sched_entity *se = &p->se;
> >   	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >   	struct load_weight *load = &se->load;
> > +	update_load_avg(cfs_rq, se, 0);

White space and a comment perhaps?

LGTM anyway.

