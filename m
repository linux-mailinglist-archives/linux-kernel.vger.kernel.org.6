Return-Path: <linux-kernel+bounces-367559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D719E9A03D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007521C290B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDE41D1E75;
	Wed, 16 Oct 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuqlfTSo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7D1D1748
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066220; cv=none; b=JqmNBN2ejhR+TVrZESSDKuCOUlflTR/4ZYkNO0RAfyVD4B3p2eQaKzVM+JztHSLs8KRlD3FcowmRa3gFKB9uJ87P3aK00dIC8EpkfrsXYadi4zd6K2BpGvJepS0JaXe31xWHPuGWDvFhxm/ngqzXSMyO9mUA3wWTSaeHEKmxANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066220; c=relaxed/simple;
	bh=dzrQDxbXr0pWQUuhP5LERCbSciFMl8XXX8VoRyV4O4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l/lwcbh7r/TBRk3rMpMkYSUJca9BK4S038S6nC3SmW+DwH1qxk1JoBOXKqhHo2GskRY4yrL5rDwIRNVW1X3AYz02JyqOjvyLKHBRnjtbRTbrxHzXRoRTIAIEfx8Cgki3O/GSpN1gW2kppKpWJYu+3fR4nU5qD+uYa1cGff/CcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuqlfTSo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729066216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h31PYOOOt1H7fXU5GXvC8jncy2JRlZh9FRP7H3gJhc4=;
	b=GuqlfTSoGojJR06VjYsy2F4sHnFhP9fyS5pK97Pxt3caYvfl6aIuztaPSLblepWMI5Iu5W
	9QA3LUXDG5DuuQ4GtofYkgPNih8UlJPKBrHgX/sRPRBsf3ypoUzdKCBU3y9yoPYNg8d1AB
	vhruRrnJeVU8qrL9T+INEl/cKipFsFA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-pJ2kwSbONqO8TODovhl1_Q-1; Wed, 16 Oct 2024 04:10:15 -0400
X-MC-Unique: pJ2kwSbONqO8TODovhl1_Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4312731c7bfso22183245e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066214; x=1729671014;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h31PYOOOt1H7fXU5GXvC8jncy2JRlZh9FRP7H3gJhc4=;
        b=Gi1wdYGpjJfOBI/pTGvlFeBW+5U5tCNkgbbbwe+mph3j4HH4JluWAyYLSooiCkUerv
         /8KWTX6lDhaeRfafA6g6IwBBwX1i9wyuv9mqcHq8JpPmjypjEwjzS68MzA3d2RWRd4DG
         m5i95w5JAl5Eay/dJmdOXuAmprn7zjdQKbfUcTlt0IxzxmDV/d09iX9JTz3gDMAiFY/V
         uRQ3hOEN3ZBWIbbu6Uz1jZUHnEmKCq3ZibCgll5KtU7HVO+iCnuOx2bEzEyKn/RVQrT4
         wTAJFd+xIrW4GKgTaRH1/KUt6zvjhXJOtEGcFToe5ttyZuq9BMmFL23di1pNNliwm8AC
         g+nA==
X-Forwarded-Encrypted: i=1; AJvYcCUygnyYwm801FMo9X59axhZIazv5VlSXv+mlNZjSw7kTzw99OqF1Iz+9P0xEGOKJoyu/RpEI9h/2DtbbfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhF0yVNY3hyhYT+iqUT3/fyN1iET2RfcUU8IE8brF4eFfcd7Pc
	3NazZ/fhU9iIAZsr+VxQCo/rxusHzb01wq/xBX5H9AazfchJkTpxfckw84FR1MkdAM2c32iqFRB
	oljQm+4iA4x75UH5SXLrSHbbp53KCG2dymjTFG713xbQRrg8LjjRMbtKZjKhabA==
X-Received: by 2002:a05:600c:a55:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-4314a38454cmr25746805e9.29.1729066213835;
        Wed, 16 Oct 2024 01:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPv2DjAnHKFSLb/qtvgccoc3CXTw9Jjy5BjENEfOGhL7p021Nhrr2+J2i0aWaSMVMYeTbCyg==
X-Received: by 2002:a05:600c:a55:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-4314a38454cmr25746505e9.29.1729066213420;
        Wed, 16 Oct 2024 01:10:13 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a2a8sm3647385f8f.3.2024.10.16.01.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:10:12 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>, Steve Wahl <steve.wahl@hpe.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
In-Reply-To: <xhsmh34kxv3dc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
 <xhsmh34kxv3dc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Wed, 16 Oct 2024 10:10:11 +0200
Message-ID: <xhsmhv7xstqn0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/10/24 16:37, Valentin Schneider wrote:
> On 10/10/24 10:51, Steve Wahl wrote:
>> Use a different approach to topology_span_sane(), that checks for the
>> same constraint of no partial overlaps for any two CPU sets for
>> non-NUMA topology levels, but does so in a way that is O(N) rather
>> than O(N^2).
>>
>> Instead of comparing with all other masks to detect collisions, keep
>> one mask that includes all CPUs seen so far and detect collisions with
>> a single cpumask_intersects test.
>>
>> If the current mask has no collisions with previously seen masks, it
>> should be a new mask, which can be uniquely identified by the lowest
>> bit set in this mask.  Keep a pointer to this mask for future
>> reference (in an array indexed by the lowest bit set), and add the
>> CPUs in this mask to the list of those seen.
>>
>> If the current mask does collide with previously seen masks, it should
>> be exactly equal to a mask seen before, looked up in the same array
>> indexed by the lowest bit set in the mask, a single comparison.
>>
>> Move the topology_span_sane() check out of the existing topology level
>> loop, let it use its own loop so that the array allocation can be done
>> only once, shared across levels.
>>
>> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
>> the average time to take one processor offline is reduced from 2.18
>> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
>> 34m49.765s without this change, 16m10.038s with this change in place.)
>>
>
> This isn't the first complaint about topology_span_sane() vs big
> systems. It might be worth to disable the check once it has scanned all
> CPUs once - not necessarily at init, since some folks have their systems
> boot with only a subset of the available CPUs and online them later on.
>
> I'd have to think more about how this behaves vs the dynamic NUMA topology
> code we got as of
>
>   0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
>
> (i.e. is scanning all possible CPUs enough to guarantee no overlaps when
> having only a subset of online CPUs? I think so...)
>
> but maybe something like so?


I'd also be tempted to shove this under SCHED_DEBUG + sched_verbose, like
the sched_domain debug fluff. Most distros ship with SCHED_DEBUG anyway, so
if there is suspicion of topology mask fail, they can slap the extra
cmdline argument and have it checked.


