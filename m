Return-Path: <linux-kernel+bounces-277988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A736C94A917
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE581F29166
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095E61EB4BC;
	Wed,  7 Aug 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEWpu9Ry"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652120011B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038806; cv=none; b=FY37P5W8Rwye439CuPOVlH/5lw5Gjm0kjErbSOn4Skgz/xkOw5GIDsNlaWK5DKtVav5ni0Cv9lpm4YGZsuQ9DICMQkdT9isZo+pDR5WgHVliC1f8/K6yhDqoWUEeepvPPnB1RtiG7Mo631Td1w0YWK7g8UrXoqw+Uc9hJxHSKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038806; c=relaxed/simple;
	bh=VEx+gTRUozzkb9aDK+3Qxmehk1V/qGaFawiziYdyVoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mIOnkFI6Jd+Jz8qoZmCK5nQXFdcLylorGIIRfSa9L/c3zbz2THKA4JyzOsV6D7peL6ka76iXoWw8R3Y6ElK1qNFR2ZnG2gG00M9HkWkoNWXISVTfzUkn32T6Em6yniwqqFcE/tYM7U3WKec6+BIS/0jpTa6T+86S3ixRlS8qMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEWpu9Ry; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723038803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4qxjXGvQ0W955W8GQjZ2uMxLZCuuukJIcZbSTgkfWBc=;
	b=XEWpu9RyeYp2F6rOB/TjqBE4I14LqcHuMFlF/8R/JcRxS2VOSg9gehKfKCG/mtHial0TeX
	S0mP/ghUJA13ck4+LsNW3LVhWDsL9OHdhpOvw4W9OgoJCoqKzrqWNmT0eeZa6kz52Zfd3j
	tEnsCyexzppbXacAorwcRfGrgoxY0J0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-GBVXvK2IP8Gqs4y_xndLuA-1; Wed, 07 Aug 2024 09:53:22 -0400
X-MC-Unique: GBVXvK2IP8Gqs4y_xndLuA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280f233115so12769245e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038800; x=1723643600;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qxjXGvQ0W955W8GQjZ2uMxLZCuuukJIcZbSTgkfWBc=;
        b=YUKaIrIPIGyFSTYNLnVGBtLUZgE6W/6+szNXML+FDCvEQCaH13xhoIYk6VgMELqkgJ
         RUCFqWC9mYFWLONcZ4cSXK8KSdaDFI5em1GYVZ7/J7V+dRjDJ4blwyFrxTGn51ShRaha
         xvEcn3tXVtfJzCQaE0pgKIgyA3MuqtJ1cOnMo0/ceihpXqFZjLT+o0h87ieNrws1XzmL
         9Za3i1TLKo3+0m7oxNzQr5ORcntuSchCKeZK4sawTcSt9UvvO+mBhdWZLO6UVuiY0gE5
         OINpkRXXNaGO5EhBzZbpo1a6RmIwHEwj/fKrvXIqxBeFyFSPGLFbirUtfy3iMshGZSeE
         1gTw==
X-Gm-Message-State: AOJu0YwrVS3ntjORPalqo7Qdjrtk5AvC1s2Al+gy5fDQpVk4fzAlf5hO
	KmjAmbVv6IwmSJeyhRqrxG0lwJHHyzDNOnGhvBr1eghedx9K0p7nXPxkrNED4K2X7ma0f1rs9bO
	mm0S734oAosIjvfD1uHtJQW891ven8vX8EceGijcVTKYPAsCy/ybkqgGR/6/DBQ==
X-Received: by 2002:a05:600c:4e90:b0:428:314:f08e with SMTP id 5b1f17b1804b1-428e6af4c75mr111032375e9.5.1723038800608;
        Wed, 07 Aug 2024 06:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPohOk+R6sV6StCPIir8wVIX69dH7Iw2ACEifkYFyk5+G04HbCdO3exqWERcHMqwMCIiUpbw==
X-Received: by 2002:a05:600c:4e90:b0:428:314:f08e with SMTP id 5b1f17b1804b1-428e6af4c75mr111032005e9.5.1723038799962;
        Wed, 07 Aug 2024 06:53:19 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905991434sm31207445e9.30.2024.08.07.06.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:53:19 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Leonardo Bras <leobras@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched/topology: optimize topology_span_sane()
In-Reply-To: <ZrJk00cmVaUIAr4G@yury-ThinkPad>
References: <20240802175750.1152788-1-yury.norov@gmail.com>
 <20240802175750.1152788-3-yury.norov@gmail.com>
 <xhsmhy159mz0g.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZrJk00cmVaUIAr4G@yury-ThinkPad>
Date: Wed, 07 Aug 2024 15:53:18 +0200
Message-ID: <xhsmhv80cmoc1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/08/24 11:00, Yury Norov wrote:
> On Tue, Aug 06, 2024 at 05:50:23PM +0200, Valentin Schneider wrote:
>> On 02/08/24 10:57, Yury Norov wrote:
>> > The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
>> > even when cpu != i.
>>
>> For which architecture have you observed this? AFAIA all implementations of
>> tl->sched_domain_mask_f are built on a per-CPU cpumask.
>
> x86_64, qemu emulating 16 CPUs in 4 nodes, Linux 6.10, approximately
> defconfig.

For the default_topology:
cpu_smt_mask() # SMT
  (per_cpu(cpu_sibling_map, cpu))

cpu_clustergroup_mask() # CLS
  per_cpu(cpu_l2c_shared_map, cpu);

cpu_coregroup_mask() # MC
  per_cpu(cpu_llc_shared_map, cpu);

cpu_cpu_mask() # PKG
  cpumask_of_node(cpu_to_node(cpu));

Ok so PKG can potentially hit that condition, and so can any
sched_domain_mask_f that relies on the node masks...

I'm thinking ideally we should have checks in place to ensure all
node_to_cpumask_map[] masks are disjoint, then we could entirely skip the levels
that use these masks in topology_span_sane(), but there's unfortunately no
nice way to flag them... Also there would cases where there's no real
difference between PKG and NODE other than NODE is still based on a per-cpu
cpumask and PKG isn't, so I don't see a nicer way to go about this.

Please add something like the following to the changelog, and with that:
Reviewed-by: Valentin Schneider <vschneid@redhat.com>

"""
Some topology levels (e.g. PKG in default_topology[]) have a
sched_domain_mask_f implementation that reuses the same mask for several
CPUs (in PKG's case, one mask for all CPUs in the same NUMA node).

For such topology levels, repeating cpumask_equal() checks is wasteful -
check that the tl->mask(i) pointers aren't the same first.
"""


