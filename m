Return-Path: <linux-kernel+bounces-277675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8A294A4A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27910283BF7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391EA1CB325;
	Wed,  7 Aug 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0jHitge"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A47157A43
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023983; cv=none; b=h28hjthMxbI7F/F6jyfQ8lCzzsZkxT3+jfY/WLV7rJ07KvJCYCyhFQkhT/4gheA4wmNsYAbsQTCUxc3hD37qnWcp/6RgYC9AtZ0AD9Sc0yJewpAeZOfvuM1ghrR7Q89r9zmkpwBFGsXwl30uAwBhJiveW+Y17AnJS8QMnPgxHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023983; c=relaxed/simple;
	bh=rDtWpbGy01R/3JhqOpu1YlaXnZUBB7zPAmp53F087oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY/TbLElcltU6ya705Yo/qXQGnS1wYZ+Mi7vDxZbNvwoKvtLl92HdieTHR4+lR53vganOMJK9othjY2TnMxhtaOKxfkuv1JrrYhNCTkeEHwoTDQH8XMkmRo66+ZRVxCTlBgwsX+bYMALz2aiavi9QXHpDFwNRtBOsdVHx/O+Y90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0jHitge; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723023980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b45FMAWJorW7RemAgRMyDUmAMwSI3oah4WYJtLDSke8=;
	b=S0jHitgeM/2QdlQLLZ69CKMKKpG9wG1EODE0PV7OkMMgQsrAj62VamDpfpRrElHTlWQv7P
	ge7+iQwfXsiZMQf9wmCJQevqBR4Ceo4ZjouQ570U8Uu1udlECO5GZD1koW9EwHbk4yfLFf
	wMBp5PaCO8su4edQ+E35JVIbxpoicrY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-DzmHbn0kPkOFdVPt5BkEAA-1; Wed, 07 Aug 2024 05:46:18 -0400
X-MC-Unique: DzmHbn0kPkOFdVPt5BkEAA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36835daf8b7so1185471f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723023977; x=1723628777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b45FMAWJorW7RemAgRMyDUmAMwSI3oah4WYJtLDSke8=;
        b=vPAgdbLH4SmXBdXMBy83OfYL2MvpG72qQAT49fSSa5jXPBhiCDZ4A5Qs0Cr65cQICe
         FWm0kFg72xN75dtSh9SjbqSCExUj4so8Mozd9DCoYjtVfmU/dNEN8snzliwxQht6HkSw
         9xUtGr+xgE2EybOaxZYo2CFI1A5lr5EXJVZb70d/G2enSnqrnhvax5yZbYrgF37N8c5R
         dvtbZevH/mtXzeZ2al9yqg7HT+vCf8NHqmrgdFwOhuErYRn6vBKGnDrYwVqPCG1KbZJR
         vHdsWz7mtnYotfrOYIfaJBwUMVkT6hq7DXwt2Ggo330yHmf4PNueCl7byNfFG6BALBG9
         27Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWuKacUeRpj7o9sMYzMYsyKvS5ko1FwqeSiutXJ21mZmVvrcGP5W46IcEMxiM4f1+/HcwxXTnG+W9mL8uS+xtqMt7Yun2kKNFb72sGk
X-Gm-Message-State: AOJu0YyN6EcUn4n9g+1Evj5xaLgaopEq73SXE6+O5qKeTyfu0u5UDSZM
	LD+Sj7OQU5NCjBngfVpwnKpFRWwLhUheHH+IzYSDvQ+IO5Id2BBFNjGsFcK+Wb39+zReNE52khe
	TR5u4+CclFRKhqXpEPH55wCHy0wxpcLSzEtHkEunw60a8CDF6Q6+Lf48oqWxCiA==
X-Received: by 2002:a05:6000:1a8f:b0:368:3384:e9da with SMTP id ffacd0b85a97d-36bbc1ddfdfmr14836013f8f.62.1723023977610;
        Wed, 07 Aug 2024 02:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5lTIyhSNk9XP3oYYdvntIQeNDVhBbrw5l5UOwY8GlminrjTmCXKhDAtlwHGMRb10WrVaR0w==
X-Received: by 2002:a05:6000:1a8f:b0:368:3384:e9da with SMTP id ffacd0b85a97d-36bbc1ddfdfmr14835987f8f.62.1723023977122;
        Wed, 07 Aug 2024 02:46:17 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.159.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905971d1dsm20634745e9.20.2024.08.07.02.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:46:16 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:46:14 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Wander Costa <wcosta@redhat.com>
Subject: Re: [PATCH] sched/deadline: Fix imbalanced task reference
Message-ID: <ZrNCZtwPB4rignE3@jlelli-thinkpadt14gen4.remote.csb>
References: <20240807083015.1385303-1-zhangqiao22@huawei.com>
 <ZrM3rZFGg_nPEjjV@jlelli-thinkpadt14gen4.remote.csb>
 <7ae6fa16-80d3-4478-baae-b5bc06531e0c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ae6fa16-80d3-4478-baae-b5bc06531e0c@huawei.com>

On 07/08/24 17:39, Zhang Qiao wrote:
> 
> 
> Hi,
> 在 2024/8/7 17:00, Juri Lelli 写道:
> > Hi,
> > 
> > On 07/08/24 16:30, Zhang Qiao wrote:
> >> When starting a deadline inactive_timer, the task_struct refs will
> >> be incremented only if dl_server is not set. But when canceling the
> >> inactive_timer, the task refs will be decremented whether dl_server is
> >> set or not, leading to a task reference imbalance issue.
> >>
> >> This patch fixes the imbalanced reference by adding a '!dl_server()'
> >> checker before calling put_task_struct().
> >>
> >> Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
> >> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> > 
> > Isn't this equivalent to Wander's patch below?
> > 
> 
> Yeah, i didn't notice it.

Thanks for confirming!


