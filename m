Return-Path: <linux-kernel+bounces-434648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AFD9E6958
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59DC1884454
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4141DF260;
	Fri,  6 Dec 2024 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqLYUPUi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141411B4122
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475211; cv=none; b=WaPRFYhJdKPejYpDBLN24eIiDPVBJNBCQCAb0NpLrAHyI1ImEk/Q5lZaErNLiiDc12LgtyBH49hkOSew3Pw5vlCfczvAoesWZpc/Qe4F2UOlF2G/pMJkRcmJ2TrT2sPB+XU6Ow1bje6qvllyGO9ffZ6ik1BX2ptHSyjwdBA811k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475211; c=relaxed/simple;
	bh=dQsPkFZWr/tWQwTwc2UOwpKsAv2li1hhpvLNjprhWFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pmy0+S8sEMkF/es2DWQZW2DHQptE1az59pjHfFEVd7MMqVjxAN5KuAfRFN16mF0W9WW8KLimJUjFETjT74lwwknIfdsFmMv7lPSWGZL9+OzXFhN+480DLyXkDoxaeDAmA9qhFNe1iob93elITOjihv5oiLPCPXiaMnY1f6VGHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqLYUPUi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733475208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dQsPkFZWr/tWQwTwc2UOwpKsAv2li1hhpvLNjprhWFc=;
	b=PqLYUPUizkWGmJhH0ZHPG8MNXdARXkLIJM767BQRjdV1fQ3DUnWy/sihZf9Nae/f+TMSzS
	OkSHrSOaWhj+d+WgHk96L0MOw9DohmbNc3oEUfOdShQjrq3XeuRO3rtIEz2lO1JeSfIJcp
	P4vVJvXWFl0+a+ko2906KanToosauuQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-okVU2DFYMYu-LfPZk_MAYw-1; Fri, 06 Dec 2024 03:53:27 -0500
X-MC-Unique: okVU2DFYMYu-LfPZk_MAYw-1
X-Mimecast-MFC-AGG-ID: okVU2DFYMYu-LfPZk_MAYw
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8edc021f9so4371326d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475207; x=1734080007;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQsPkFZWr/tWQwTwc2UOwpKsAv2li1hhpvLNjprhWFc=;
        b=tVnl3N+wL6kDdP6iN6l45v1bL+Lq29UGoZvCa/1dFHEcFABzhYvdD2FfRaOP0eAipJ
         SqEHbYKOnOpFrmalmFNV3NLrtI2QYSXAmQxP1Q98idrzGLrMZ3FV9mcynanaYRL2nYZK
         qa0I61vyPbxfeLjU2JqLTaQPUNvgazXPXa8XcjNCPm/aIDAg5dOl7MGQXgZ3euijb6cp
         eTw3DPLBilQmk8R2pMBB3kI+VsrKOYbOaIVILW/cLdhZGWb4CU01aP9ZSj6F7QrV2hFa
         KrUjRKCHG4PrqkI5S8uLJMaMsSoLd9qXvejqRP0EmFJCOMEwzocP58MgyIrAX5EeOb+a
         3P9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHst+zBc4fucZOMqd+hMnvzR4WRKBqiKogad9v4IJWQE5kWwN3EaSbxIefni4x3EDzz1XTpY8ZTBP+GnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5saeptIE/rGE9ho8Cxs1Ja5qiKQm9yNoNJQ/RTi0kNRdlRba
	iI5ZViQHRQ4VypLv3lystNevSjCdvRZJ2KWrS2XIXdVOwwMgRNqcfTgDMDGLdbivOlREiX3+qgc
	lviHeFMuG/heT6hReP5qZFHTD71CAlKgPhzS9LyKps4+xpiSM3YgNNk8D0E5ytw==
X-Gm-Gg: ASbGncu7CcccGKCXnvI/aqY0G3vjBfC/VfGwxJvIGcnpQGICQnCS1Ev2BzsF3svWNU2
	IkX7Te15PAWuUmgqmoOMUwVUni569dtLodopBNFfiQtMgVoryYeJj3JlLVZgB1XLZN1OJF3L73Y
	UlLr1wNSPfbYqHyNXQgDQyMEq287MLSx9cEVFzxf4uwNR+Dmt7emkNLogvnyp1ttK1rIiKpWCBE
	aF09azlM292Nl9uWMRArxOn39KDnvXZrf3Hc3YppB9f6J8vodjJMgd0FHVkZuQgfMqJA3VhEtkh
X-Received: by 2002:a05:6214:5195:b0:6d8:9e16:d083 with SMTP id 6a1803df08f44-6d8e70d6eb2mr30193016d6.3.1733475206875;
        Fri, 06 Dec 2024 00:53:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuIt3GmOjFHzFyqi2fUZDfOlLKfiJiyAspNyaIfAL0leXUx0zN3aoJ55+2dkoSOqMA86dikg==
X-Received: by 2002:a05:6214:5195:b0:6d8:9e16:d083 with SMTP id 6a1803df08f44-6d8e70d6eb2mr30192766d6.3.1733475206551;
        Fri, 06 Dec 2024 00:53:26 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da66da32sm17004936d6.2.2024.12.06.00.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:53:26 -0800 (PST)
Message-ID: <ead55d690448cbf23677bcc1b4c1a5c129240c90.camel@redhat.com>
Subject: Re: [PATCH] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton	
 <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 linux-mm@kvack.org, 	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	 <vincent.guittot@linaro.org>
Date: Fri, 06 Dec 2024 09:53:20 +0100
In-Reply-To: <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
References: <20241205083110.180134-2-gmonaco@redhat.com>
	 <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
	 <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-05 at 11:25 -0500, Mathieu Desnoyers wrote:
> On 2024-12-05 09:33, Gabriele Monaco wrote:
>=20
> > Before sending a V2, however, I'd like to get some more insights
> > about
> > the requirements of this function.
> >=20
> > The current behaviour upstream is to call task_mm_cid_work for the
> > task
> > running after the scheduler tick. The function checks that we don't
> > run
> > too often for the same mm, but it seems possible that some process
> > with
> > short runtime would rarely run during the tick.
> >=20
>=20
> So your concern is about a mm with threads running in short bursts,
> and those would happen to rarely run while the tick interrupt is
> triggered. We may indeed be missing something here, because the goal
> is to ensure that we periodically do the task_mm_cid_work for each
> mm.
>=20
> The side-effect of missing this work is not compacting the
> mm_cid allocation cpumask. It won't cause rseq to fail per se,
> but it will cause the mm_cid allocation to be less compact than
> it should be.

Yes, that was exactly the case, tasks like timerlat/cyclictest running
periodically but doing very short work.
Makes sense, now it's much clearer.

>=20
> > The behaviour imposed by this patch (at least the intended one) is
> > to
> > run the task_mm_cid_work with the configured periodicity (plus
> > scheduling latency) for each active mm.
>=20
> What you propose looks like a more robust design than running under
> the tick.
>=20
> > This behaviour seem to me more predictable, but would that even be
> > required for rseq or is it just an overkill?
>=20
> Your approach looks more robust, so I would be tempted to introduce
> it as a fix. Is the space/runtime overhead similar between the
> tick/task work approach vs yours ?

I'm going to fix the implementation and come up with some runtime stats
to compare the overhead of both methods.
As for the space overhead, I think I can answer this question already:
* The current approach uses a callback_head per thread (16 bytes)
* Mine relies on a delayed work per mm (88 bytes)

Tasks with 5 threads or less have lower memory footprint with the
current approach.
I checked quickly on some systems I have access to and I'd say my
approach introduces some memory overhead on an average system, but
considering a task_struct can be 7-13 kB and an mm_struct is about 1.4
kB, the overhead should be acceptable.

>=20
> >=20
> > In other words, was the tick chosen out of simplicity or is there
> > some
> > property that has to be preserved?
>=20
> Out of simplicity, and "do like what NUMA has done". But I am not
> particularly attached to it. :-)
>=20
> >=20
> > P.S. I run the rseq self tests on both this and the previous patch
> > (both broken) and saw no failure.
>=20
> That's expected, because the tests do not so much depend on the
> compactness of the mm_cid allocation. They way I validated this
> in the past is by creating a simple multi-threaded program that
> periodically prints the current mm_cid from userspace, and
> sleep for a few seconds between printing, from many threads on
> a many-core system.
>=20
> Then see how it reacts when run: are the mm_cid close to 0, or
> are there large values of mm_cid allocated without compaction
> over time ? I have not found a good way to translate this into
> an automated test though. Ideas are welcome.
>=20
> You can look at the librseq basic_test as a starting point. [1]

Perfect, will try those!

Thanks,
Gabriele


