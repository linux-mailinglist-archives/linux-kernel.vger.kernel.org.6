Return-Path: <linux-kernel+bounces-441266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B90AD9ECC10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35B01882BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABAB225A55;
	Wed, 11 Dec 2024 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDQEoHGA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B62210EE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920052; cv=none; b=bXsGJRY7HApm6Yr6zd0sBYYKMt7c6T9BBhTYV8TRQvTFXKwhSYBvrE0ARrRruOvpW4Ke0OVLYDC1hpokY+l2Z9JTjHMHSyNNXNmRNujhtgephAVNOnYrButop1OJ3Gsow06uIkFh5I/J1f9zden88y5k3J97fVrndtv4NDMH/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920052; c=relaxed/simple;
	bh=aXBC5p/+XWKyhcFKaygZgRIxYhNynRERg2JSSPENA4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oVtfK+83HS0nkJs7LJWNk+Tbm/0KqUsOYBRtAnc4tP5ff1dOGbXLb20y0/Gwj2U6nwKxwJFCAlTPOFRaelbtqaKYG9+W5frb8YFhx9bk5hTFATHvLXHmcdRr/ZwlJsqI+UtygNpS/oUI9TVasxppV2N4QK4GtvEse9jhkcfdWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDQEoHGA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733920049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d1ZyiF0PPVacR4Sm9Um7cG+VxQE6JPvFx38FzXtDVvw=;
	b=BDQEoHGAkwQ0Cm+uPiKK606MUusKIF+o5nu510s7WoNQ/tl2aYnBQUV53zyVTHSBeB619V
	Ny6sMcYCdWbd38PkeiESadkZ6x8NF+pbKZ3nKvm9NIqTypvvpyF3cLFfxm/Rm4Irb+uPFP
	FGvIjpMrtQGcOx+EU1XVP1Bw49r6Jr4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-T2zjFXSTNyKGYtFpQsUECA-1; Wed, 11 Dec 2024 07:27:28 -0500
X-MC-Unique: T2zjFXSTNyKGYtFpQsUECA-1
X-Mimecast-MFC-AGG-ID: T2zjFXSTNyKGYtFpQsUECA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6d183bc57so514494485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733920047; x=1734524847;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1ZyiF0PPVacR4Sm9Um7cG+VxQE6JPvFx38FzXtDVvw=;
        b=lIME0fMNYnBVK5w5kxrUqeh2++kvQKNUIEXUjHcFrqMa5Eu1vhDEr5Mc9lxx84ydEg
         RRdhEb+LDFRy+J7SE88VntksMQeVcfZ4Pn1Te5hFEHm+FKCy0xHVeHBf6klBlLNYOPcW
         9SC4DA5Zua0jDPnIvxT8fa5dAP/lBgcXfoJtt1hI4bJsHKzEtvrxaDI5s/G0u/VjtgVH
         dEFSUBPmPLNH3yB9Em9M/zLZSN5+XKC2G8hz4LqAqf6V1wyAE+uJ75ucF49zUqtIKLKH
         551K8H3X7Ceg0xT2dbyhlTJq5WApa+k4ZuoSrknS2vkVNLY8cdyXYMLuFRCtnEEHL4tF
         LeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3vnm15FFZhRAGGTETTA5ZjGmjdg0onUYIZZoFgUv5A6SXp51HYS/X2b1/SlRFtqPN1Ac19ulloOCWVp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPISJtZWMReomyf7D0VG7vF5vdUjXiyEku9VApTG8yrfiW3wWR
	gLGzk23/Omh/5JLkwlIoFUS5nHmZ9Ky6Yx0/50EWkwqzoyrXGmVHawTWmGw3v3yJFdhTtHPnUEO
	3NKQShSFmNExiYG34ft8aM5KpzSBiCWxVXtoODtI5HJvLYd+dDrAFI2sKWAlwbA==
X-Gm-Gg: ASbGncsgIVHaqY38wepofPJu5CvlwzPJ6DIIukSgodTpTGYW22AYViYHPjvSvmVXl9T
	47v0nZLjvU7w5EXxpNPiV9y4vD1Z8w99ni46VcFfiexrjKkKptatsFenkmYTwPJCGYVZvd7T2Ci
	WiMx0PzQlBh8eb/MeSEe2Al8frJDOdHE3+9btRePUcfOHDtPNmuGDoyDMOW5wiNZg05eg12NaZO
	lenjiV8VRWGvizydI/TXy+bLbzSU/hUJgNlc46+w+ytSg//tjiaB6Yb/lUhHf3Kc00TGURGzFV1
	FYzB
X-Received: by 2002:a05:620a:370d:b0:7a9:b9dc:1b72 with SMTP id af79cd13be357-7b6eb4d6197mr382170685a.23.1733920047384;
        Wed, 11 Dec 2024 04:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjDXzoWUkjZKCbFFDGo21KMUbmeYO/q6FEaI+b/L0BtGt/P1Ln3jR27IYeeyUpSvh9EWg1kw==
X-Received: by 2002:a05:620a:370d:b0:7a9:b9dc:1b72 with SMTP id af79cd13be357-7b6eb4d6197mr382166685a.23.1733920046971;
        Wed, 11 Dec 2024 04:27:26 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a5c5f1sm629735185a.44.2024.12.11.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 04:27:26 -0800 (PST)
Message-ID: <7c4d0c6800a4bd7a5cf4928e28d59fb469c944b9.camel@redhat.com>
Subject: Re: [PATCH] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton	
 <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 linux-mm@kvack.org, 	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	 <vincent.guittot@linaro.org>
Date: Wed, 11 Dec 2024 13:27:22 +0100
In-Reply-To: <1f4a8928-8450-48e2-bf40-e75967240d79@efficios.com>
References: <20241205083110.180134-2-gmonaco@redhat.com>
	 <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
	 <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
	 <ead55d690448cbf23677bcc1b4c1a5c129240c90.camel@redhat.com>
	 <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
	 <481a7b7716cf4eb2d592b08558d297d343d9aa25.camel@redhat.com>
	 <cbc0a3c5-2ae5-439e-ae5d-7fb68ea49aec@efficios.com>
	 <1f4a8928-8450-48e2-bf40-e75967240d79@efficios.com>
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


On Mon, 2024-12-09 at 10:48 -0500, Mathieu Desnoyers wrote:
> On 2024-12-09 10:33, Mathieu Desnoyers wrote:
> > A small tweak on your proposed approach: in phase 1, get each
> > thread
> > to publish which mm_cid they observe, and select one thread which
> > has observed mm_cid > 1 (possibly the largest mm_cid) as the thread
> > that will keep running in phase 2 (in addition to the main thread).
> >=20
> > All threads other than the main thread and that selected thread
> > exit
> > and are joined before phase 2.
> >=20
> > So you end up in phase 2 with:
> >=20
> > - main (observed any mm_cid)
> > - selected thread (observed mm_cid > 1, possibly largest)
> >=20
> > Then after a while, the selected thread should observe a
> > mm_cid <=3D 1.
> >=20
> > This test should be skipped if there are less than 3 CPUs in
> > allowed cpumask (sched_getaffinity).
>=20
> Even better:
>=20
> For a sched_getaffinity with N cpus:
>=20
> - If N =3D=3D 1 -> skip (we cannot validate anything)
>=20
> Phase 1: create N - 1 pthreads, each pinned to a CPU. main thread
> also pinned to a cpu.
>=20
> Publish the mm_cids observed by each thread, including main thread.
>=20
> Select a new leader for phase 2: a thread which has observed nonzero
> mm_cid. Each other thread including possibly main thread issue
> pthread_exit, and the new leader does pthread join on each other.
>=20
> Then check that the new leader eventually observe mm_cid =3D=3D 0.
>=20
> And it works with an allowed cpu mask that has only 2 cpus.

Sounds even neater, thanks for the tips, I'll try this last one out!

Coming back to the implementation, I have been trying to validate my
approach with this test, wrapped my head around it, and found out that
the test can't actually pass on the latest upstream.

When an mm_cid is lazy dropped to compact the mask, it is again re-
assigned while switching in.
The  the change introduced in "sched: Improve cache locality of RSEQ
concurrency IDs for intermittent workloads" adds a recent_cid and it
seems that is never unset during the test (nothing migrates).

Now, I'm still running my first version of the test, so I have a thread
running on CPU0 with mm_cid=3D0 and another running on CPU127 with
mm_cid, say, 127 (weight=3D2).
In practice, the test is expecting 127 to be dropped (>2) but this is
not the case since 127 could exhibit better cache locality, so it is
selected on the next round.

Here's where I'm in doubt, is a compact map more desirable than reusing
the same mm_cids for cache locality?
If not, should we perhaps ignore the recent_cid if it's larger than the
map weight?
It seems the only way the recent_cid is unset is with migrations, but
I'm not sure if forcing one would make the test vain as the cid could
be dropped outside of task_mm_cid_work.

What do you think?

Thanks,
Gabriele


