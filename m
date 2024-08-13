Return-Path: <linux-kernel+bounces-284490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F397E95018B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327231C21A29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1721017D346;
	Tue, 13 Aug 2024 09:49:54 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC4210E7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542593; cv=none; b=Zi3mESeGf915tbCF47+6+ik8S/JIaRbORWicoz56qjwe7dS+O/ahQEYgdorn2nUcNKAM+DfNAdd1+hERrBeYTghgNkwFT8sdNffBOIRISzQGyPiph0sELl2sCsrt3Iu1eNAQsl7FfdBMb1rESQIUsLdezAxgDL+5PF1K2dmRqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542593; c=relaxed/simple;
	bh=emRIzJsZhh3UYsXeaSEtOX3q55v5ATxqHpGDcVsYc6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9QhD+ebqiS5kqpmPpYYcAcQnJt6qyxQAoRdJLL+EgrzgOQZUuUy/cjERs1Zcx15jz3ZYtRH6X6ha4Nx+j6hQj+Fyv0Itfwhp1V7eu/k5M+W3o10gpOhdeuZ72JtKDiFj9nv0958u78gAWsCWh1td+D9PK47GXgWUS1BO9LMtKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a83a968ddso514008566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 02:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723542590; x=1724147390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbqSnnhU9hTXfKatLvVtC315COj3Ikq+Kw2F310p32M=;
        b=h4hTV58lLtPI+YEiWO4ylyl2BNWQ5mi+1wVYlikig3RH2cTP1fi0OSWIlJCIDXONp3
         rx/jeh2bWZmMSlljnn9T4cm0YsDF/PduE2moas2HJ/u3RAhc6uHb5nnLU8nvvABjuVx5
         Plj7EjW2wn7cB5fFuSoebaj1bK2XmJZN+JIigmwvZf+WA66iI3wuE1G/q03W0dGpo0kw
         3aqLKS9pMMImhV+Be0I7Ws+k4kBPvMMLO+KKub2ZKsC927Ii1TP9uJ6eIQ1ZswH7dfdt
         V7AwmXd6D1o8b/591r2GKLRUYB383zfwCr2kBljTmJexNsGzZRVvl/lK+6J+m7CZUU8g
         QFLg==
X-Forwarded-Encrypted: i=1; AJvYcCVsrnrInx/e9xHZojUGwLLA28rr/+8L+Y3xf9Cs2VmOXyeAVorLXLYCjwRGO8aZdrcLLadHa4Kfg8JrTIuAI52Jcv2nEuHBZUQK3Rk9
X-Gm-Message-State: AOJu0YzhCI8ww8b2FFm5DdHJH+uWYqsaKWHd2aPejohvcRvB9hBDE1Ty
	XZzQ8LLJZCnnCUDJ50oIhRFmNjtQBf1Lb7nc1n71EUxDOLf1mkNZJQCs4g==
X-Google-Smtp-Source: AGHT+IF2hWJHoMLs1hIwGm6kNwLPGYBD/pRH5khWiBaBIGwyKPbl1wBOloRX+ZvW7jVB556SJCfi0A==
X-Received: by 2002:a17:907:608a:b0:a7d:391f:17af with SMTP id a640c23a62f3a-a80ed2c4690mr183106966b.51.1723542589170;
        Tue, 13 Aug 2024 02:49:49 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414bbf3sm55291766b.145.2024.08.13.02.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 02:49:48 -0700 (PDT)
Date: Tue, 13 Aug 2024 02:49:46 -0700
From: Breno Leitao <leitao@debian.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com,
	usamaarif642@gmail.com, riel@surriel.com, hannes@cmpxchg.org,
	nphamcs@gmail.com
Subject: Re: [PATCHv5] mm: skip CMA pages when they are not available
Message-ID: <ZrssOrcJIDy8hacI@gmail.com>
References: <1685501461-19290-1-git-send-email-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685501461-19290-1-git-send-email-zhaoyang.huang@unisoc.com>

On Wed, May 31, 2023 at 10:51:01AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> This patch fixes unproductive reclaiming of CMA pages by skipping them when they
> are not available for current context. It is arise from bellowing OOM issue, which
> caused by large proportion of MIGRATE_CMA pages among free pages.

Hello,

I've been looking into a problem with high memory pressure causing OOMs
in some of our workloads, and it seems that this change may have
introduced lock contention when there is high memory pressure. 

I've collected some metrics for my specific workload that suggest this
change has increased the lruvec->lru_lock waittime-max by 500x and the
waittime-avg by 20x.

Experiment
==========

The experiment involved 100 hosts, each with 64GB of memory and a single
Xeon 8321HC CPU. The experiment ran for over 80 hours.

Half of the hosts (50) were configured with the patch reverted and lock
stat enabled, while the other half was run against the upstream version.
All machines had hugetlb_cma=6G set as a command-line argument.

In this context, "upstream" refers to kernel release 6.9 with some minor
changes that should not impact the results.

Workload
========

The workload is a Java based application that fully utilized the memory,
in fact, the JVM runs with `-Xms50735m -Xmx50735m` arguments.

Results:
=======

A few values from lockstat:

		  waittime-max   waittime-total  waittime-avg  holdtime-max 
6.9:                    242889      15618873933           715         17485
6.9-with-revert:           487        688563299            34           464

The full data could be seen at:
https://docs.google.com/spreadsheets/d/1Dl-8ImlE4OZrfKjbyWAIWWuQtgD3fwEEl9INaZQZ4e8/edit?usp=sharing

Possible causes:
================

I've been discussing this with colleagues and we're speculating that the
high contention might be linked to the fact that CMA regions are now
being skipped. This could potentially extend the duration of the
isolate_lru_folios() 'while' loop, resulting in increased pressure on
the lock.

However, I want to emphasize that I'm not an expert in this
area and I am simply sharing the data I collected.

