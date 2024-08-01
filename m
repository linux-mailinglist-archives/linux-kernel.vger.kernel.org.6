Return-Path: <linux-kernel+bounces-271565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B480A945019
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F1289EDD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12C61BA879;
	Thu,  1 Aug 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="v6cwg5u3"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A91B3F28
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528344; cv=none; b=JcRLyGzBYHn8wMQrECFzFBj4shFMsyajiaObB5TpYwC7AeCOdVSXFXJWwP9M3z0Kz6nVbbZOeoTkmv6q3gu7YSnqfcJprAOdS4RSdo5Jo7QSPBiDpPodlygsy5f4toRjcyW/uSnBQQbUtUY3aad/F1ReJpY3pKEy9iyRwcdEVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528344; c=relaxed/simple;
	bh=W0bdeForQv6QKPsVnNeruCsx9lZBQ+WVsaGoDd2lbcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWa3rsymV//Q4J0mwvfgiZmpYHA+OmewvNC5R0Yti9weHLEDro4zOKXplNX5kjcxA1dE/shcTGX6St9AUEsT45Qoyamw/sTYhlTJMyYPm7KRumpbLRdhUjeMb7+wDtdE5Fx8pm/hpN69mM3yWqqBb6TwyO5tBj0vkhILjhoQNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=v6cwg5u3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f0407330a3so5389271fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722528340; x=1723133140; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pmyBtMLAvKKc/g2gbrx5+dBgFoc+eVPA3RV1j9P+NdM=;
        b=v6cwg5u3PIYTi8hCMpMZr6dGvr3AV7jD3hSBut1Vfzy4h8SRRMOxEBEQ+42MMALZ/U
         uRDyQGmgKjN6XciK790gVgaJgED7YmdEQh4cVVCvKu16g4jijKCItXXAjYGDHw2Bcd0U
         0hyLh8EA3bKLqMnxqi5QpPVUIxnO3ZF7wo/9hoiLi3I+Akgv7Xj/VmUxrq0NqOYqNP1Y
         7WAeaIrQjWGeGU7i2HNF4CaNsMtKkSXXWEkDS8gDk317PIGD3hDZMwu2j4/zAdDg62eO
         twtjv1K1Y3RoW1F+Ykf/pnHCmi/fOaoLb2afayFoVkA7vVitCRNtye+Ey8qzBLw2Dh0k
         vNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528340; x=1723133140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmyBtMLAvKKc/g2gbrx5+dBgFoc+eVPA3RV1j9P+NdM=;
        b=uAR8u8n3O0pESsQVURctsQpojXsjmsrO8IDZMIiInsFgtg8xiUoTzXCzU8p/AnkNyf
         /BAe6YGRUAI+XtFZRG1kEijyWnnFsrdmca4kl1PLVbQADIF21vSS5yvCgqnLSav7Chax
         ebRth1zDV5X7cW1xdL3o+cDEjK8hTxhaHMAW1m7QJP3fItLw7XWlvwEt32jV2NUJk426
         wk63OA1UY+a34x7f+ggFJf5PY/goefD6DeFygRDo8Ob7GWxTCt8jBKBQ4uTZKc6jSCWW
         v2QeBm41IlFJ74d/4if0uiZEOGiNfF6mGO0mLQbnofg/919z22Gp7xh+kU5Lg22sfxu8
         KzpA==
X-Forwarded-Encrypted: i=1; AJvYcCWq0clNOJG0ccCHuPNVwEz9pU+RJ9V+yvFDrA99wQWovmVABzNoFFwY5zRPK/4uRvEv0KWz4/qohNjaTIx8TQDUDlMW7domQHVmltWc
X-Gm-Message-State: AOJu0YzMmiGUPaNAQqR9smGIaQZf8dOUKCTveP4hsKEo8oAzFIKs7oEc
	RE2IOhpbKAG5gLwTQmtXcdkOF7GvQ4xZpJ+ADE9MU4YouCdheU3ax29GqHA5uUE=
X-Google-Smtp-Source: AGHT+IEp1PwFbanwLIIM1AuKEedIZhFMMTemRNxUspEvnFs1UiGExdZMGyfbsV0gon9vLaKYg2uwbA==
X-Received: by 2002:a2e:9cda:0:b0:2ef:1d8d:2201 with SMTP id 38308e7fff4ca-2f15aaa71dfmr5802441fa.23.1722528340036;
        Thu, 01 Aug 2024 09:05:40 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e11356sm1650825e9.19.2024.08.01.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:05:38 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:05:37 +0100
From: Qais Yousef <qyousef@layalina.io>
To: MANISH PANDEY <quic_mapa@quicinc.com>
Cc: axboe@kernel.dk, mingo@kernel.org, peterz@infradead.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	linux-block@vger.kernel.org, sudeep.holla@arm.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>, kailash@google.com,
	tkjos@google.com, dhavale@google.com, bvanassche@google.com,
	quic_nitirawa@quicinc.com, quic_cang@quicinc.com,
	quic_rampraka@quicinc.com, quic_narepall@quicinc.com,
	linux-kernel@vger.kernel.org
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
Message-ID: <20240801160537.ux4eg6p42disuqur@airbuntu>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <d2009fca-57db-49e6-a874-e8291c3e27f5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2009fca-57db-49e6-a874-e8291c3e27f5@quicinc.com>

On 08/01/24 14:55, MANISH PANDEY wrote:
> ++ adding linux-kernel group
> 
> On 7/31/2024 7:16 PM, MANISH PANDEY wrote:
> > Hi Qais Yousef,
> > Recently we observed below patch has been merged
> > https://lore.kernel.org/all/20240223155749.2958009-3-qyousef@layalina.io
> > 
> > This patch is causing performance degradation ~20% in Random IO along
> > with significant drop in Sequential IO performance. So we would like to
> > revert this patch as it impacts MCQ UFS devices heavily. Though Non MCQ
> > devices are also getting impacted due to this.

Could you provide more info about your systems' topology and irq setup please?

> > 
> > We have several concerns with the patch
> > 1. This patch takes away the luxury of affining best possible cpus from
> >   device drivers and limits driver to fall in same group of CPUs.

I don't think it does. If rq_affinity is set to 1, then it is set to match the
performance of the requester to do the completion.

> > 
> > 2. Why can't device driver use irq affinity to use desired CPUs to
> > complete the IO request, instead of forcing it from block layer.

If you set the sysfs rq_affinity to 0, you should be able to distribute things
without block layer trying to match anything?

> > 
> > 3. Already CPUs are grouped based on LLC, then if a new categorization
> > is required ?

rq_affinity = 1 is asking to match the performance of the
requester/orginitaor. On HMP system, this means looking at grouping based on
capacity, not just LLC.

> > 
> > > big performance impact if the IO request
> > > was done from a CPU with higher capacity but the interrupt is serviced
> > > on a lower capacity CPU.
> > 
> > This patch doesn't considers the issue of contention in submission path

What is the issue of contention? Could you please explain it in more details?

> > and completion path. Also what if we want to complete the request of
> > smaller capacity CPU to Higher capacity CPU?

Assuming you want to use rq_affinity = 1 to match based on LLC but not
capacity. I'm curious why you want to match on LLC only but not capacity.

Is this on 6.1 kernel and beyond? Arm systems should have a shared LLC based on
DSU that is enforced in topology in 6.1. So can't see why you want to match
based on LLC but not capacity. Could you provide more info please?

If you don't want block layer to do any affinity, isn't it better to set
rq_affinity = 0?

> > Shouldn't a device driver take care of this and allow the vendors to use
> > the best possible combination they want to use?
> > Does it considers MCQ devices and different SQ<->CQ mappings?

Why this consideration matters when matching the perf based on capacity but it
doesn't matter when matching it based on LLC?

> > 
> > > Without the patch I see the BLOCK softirq always running on little cores
> > > (where the hardirq is serviced). With it I can see it running on all
> > > cores.
> > 
> > why we can't use echo 2 > rq_affinity to force complete on the same
> > group of CPUs from where request was initiated?

They are not the samae. rq_affinity = 1 means match. So if both are on the same
LLC or capacity, no need to force anything. rq_affinity = 2 means always match.
It's not the same thing, is it?


Thanks

--
Qais Yousef

> > Also why to force vendors to always use SOFTIRQ for completion?
> > We should be flexible to either complete the IO request via IPI, HARDIRQ
> > or SOFTIRQ.
> > 
> > 
> > An SoC can have different CPU configuration possible and this patch
> > forces a restriction on the completion path. This problem is more worse
> > in MCQ devices as we can have different SQ<->CQ mapping.
> > 
> > So we would like to revert the patch. Please let us know if any concerns?
> > 
> > Regards
> > Manish Pandey

