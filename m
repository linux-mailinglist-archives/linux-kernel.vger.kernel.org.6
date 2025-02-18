Return-Path: <linux-kernel+bounces-519081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E2AA397B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525B1189515F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CAD233D7B;
	Tue, 18 Feb 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZ3f9UVH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE8233158
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872341; cv=none; b=hcChRALii5ijJDSHgNayFOb9IhBx8rN1VcvvRqhpdU5gORD6TLPEMvywlLRiVSdqYldJgAwezCrtwz6F6ONzUsM/GgNyUEHvuT26TgsqJaA/U26aeBIokT/nH7iC+JYQUU7aivBNQeeSsFR1DKSRNp7PIMfwyAwD9n/kxPU3+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872341; c=relaxed/simple;
	bh=khxs5MDuNJ8C3QgRiG/9uuormKvIFPEem/xTwNTN2R8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=skoc/bJtCuGy7Hx9aYzfM/WbGJwxV550WwGPnOrNlK0DoOtwEohVZ6cVnHKrSazcUi3ngoapQnDbmBKr6kv9F8UPW2MxATYE+Z7TfpBcBPKLgG/Ra2CkmkuIzzqjMKNVXivGzOJi3k6IEVSkVitb3TlQKaVJ7/axKmnWpV1JlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZ3f9UVH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739872338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cpvc/eE6btvdapL2knMvKNNFyASasB/O3RXv/FeBYZE=;
	b=VZ3f9UVH3082j63MfbsIuhOM92BhCLvKyvL2881vmX65SiYoPc21Z60SxqsYIlUYKRgySm
	dYZ9gfEh++pYytaS/71hagPDo6/VJ/sqTRsoEVyWXV/G+CkUTPhI+lTgkrEtneX4MvAUIY
	UBoZuzVtEc6+ma5JGCZ/XZVZpZvPOBE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-YbLqGWOKPYO-ip0p4_1Dbg-1; Tue, 18 Feb 2025 04:52:16 -0500
X-MC-Unique: YbLqGWOKPYO-ip0p4_1Dbg-1
X-Mimecast-MFC-AGG-ID: YbLqGWOKPYO-ip0p4_1Dbg_1739872335
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393535043bso30118555e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739872335; x=1740477135;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpvc/eE6btvdapL2knMvKNNFyASasB/O3RXv/FeBYZE=;
        b=wLWPGspcuQwk1seY6EQiqdHDGVP1y0a8l/TNhMyparH/2XEYHa8DqiQvG+o96wyktU
         FcJw8igKAJ7nmtwiPN70k4Qw9p5c1lWJhYyL10do8sfs6hggm+o23RP2dFpXlBLwXsLm
         4Q0szAEyldw8Kz3VHU97TaO239o7fvihURFs+xZJMnE20Q3pOEoxRQsFKvHkESm407Rj
         jTOZTxiVLMMsi27F/9F2O6549kibh/MzzV+nPt4cg+sSvIxgTnpYlffZePiso/jVYXLn
         sNqbAOA1UtSGYoFkJzZpMWE3cyoFY6nczSHUOK2LU0oBboUM7hGDMqUPnSXoLsRvGqwP
         4b7w==
X-Forwarded-Encrypted: i=1; AJvYcCXdfndWy0nECv8CZktJAb5GwZhp6dN7wM32SNBnOn9IHe49MOEsGUGzJl6WUE6dAWaZnmv5iRm6Ar7j+pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmRQ2JwaA/rTblAoye6FpilG2zPkx1rAVSqsrUyPkdB1ysNW5
	sPkg5SWL1zTz+vue4uI5wUnV5PKf8Azp/E5/NekQhptAXCJ8CkzGORNx7AKgndFOWpHcJYlMkWv
	4oOC2rn/FQ8Adblaps5oI9AVtB5WgURs22IeBiFCwIBbXYeivrMuVUM50docHjrFjj7BOIUdh
X-Gm-Gg: ASbGncshV3fcJ0sIaW5SUtlEo6sx18emgwjtbqFY6lJyx27AUd+3GBTTWW3P2cieosz
	Q3Yh6y/FXhQIr56sXhPeyG+ShX1Do4gOdgD+Bw23UHH0YAWORRPt6pKUuRjiiHTzw3ADu7gNKVK
	h2WCvBFQmuk1X02Z6Y72GDQrFCs99EUiDHEHjqBHwv9oj5zutMeVX11LsxzwAtN5e7c4zyB9l5J
	lTQ5EjcFif/9XcdfSXF4Sa6eMH6VLtitYdUHI5g8poOB3iztpDHYUxCuQZptP/4MHhAyiWhQJrm
	8RQ97FsZU2OEj7g6BVNnNCVChocmDLI=
X-Received: by 2002:a05:600c:1989:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-439873a1338mr45119465e9.6.1739872335213;
        Tue, 18 Feb 2025 01:52:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLaAAyNfjFduPuw7TtO8xEnzr7M4Zuxk5o6P8CcOEujVHVwixlj2Q0pvGuqNUIvFqjjJ9xVA==
X-Received: by 2002:a05:600c:1989:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-439873a1338mr45119235e9.6.1739872334756;
        Tue, 18 Feb 2025 01:52:14 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987d1865asm45771735e9.3.2025.02.18.01.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 01:52:14 -0800 (PST)
Message-ID: <f01065a00c37892dd923985ffe8d557bbaffd84d.camel@redhat.com>
Subject: Re: [PATCH 1/2] sched: Compact RSEQ concurrency IDs in batches
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, 	linux-mm@kvack.org
Date: Tue, 18 Feb 2025 10:52:12 +0100
In-Reply-To: <6a86f095-4f3b-46e8-8a42-51bff3d03405@efficios.com>
References: <20250217112317.258716-1-gmonaco@redhat.com>
	 <20250217112317.258716-2-gmonaco@redhat.com>
	 <6a86f095-4f3b-46e8-8a42-51bff3d03405@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 14:46 -0500, Mathieu Desnoyers wrote:
> On 2025-02-17 06:23, Gabriele Monaco wrote:
> > Currently, the task_mm_cid_work function is called in a task work
> > triggered by a scheduler tick to frequently compact the mm_cids of
> > each
> > process for each core. This can delay the execution of the
> > corresponding
> > thread for the entire duration of the function, negatively
> > affecting the
> > response in case of real time tasks. In practice, we observe
> > task_mm_cid_work increasing the latency of 30-35us on a 128 cores
> > system, this order of magnitude is meaningful under PREEMPT_RT.
> >=20
> > Run the task_mm_cid_work in batches of up to
> > CONFIG_RSEQ_CID_SCAN_BATCH
> > cpus, this contains the duration of the delay for each scan.
> > Also improve the duration by iterating for all present cpus and not
> > for
> > all possible.
>=20
> Iterating only on present cpus is not enough on CONFIG_HOTPLUG=3Dy,
> because ACPI can dynamically add/remove CPUs from the set. If we end
> up iterating only on present cpus, then we need to add a cpu hotplug
> callback to handle the removal case, and I'm not sure the added
> complexity is worth it here.
>=20

Got it, didn't think of that..

> >=20
> > The task_mm_cid_work already contains a mechanism to avoid running
> > more
> > frequently than every 100ms, considering the function runs at every
> > tick, assuming ticks every 1ms (HZ=3D1000 is common on distros) and
> > assuming an unfavorable scenario of 1/10 ticks during task T
> > runtime, we
> > can compact the CIDs for task T in about 130ms by setting
> > CONFIG_RSEQ_CID_SCAN_BATCH to 10 on a 128 cores machine.
> > This value also drastically reduces the task work duration and is a
> > more
> > acceptable latency for the aforementioned machine.
> >=20
> > Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced
> > by mm_cid")
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0 include/linux/mm_types.h |=C2=A0 8 ++++++++
> > =C2=A0 init/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++++++++
> > =C2=A0 kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 27 +++++++++=
+++++++++++++++---
> > =C2=A0 3 files changed, 44 insertions(+), 3 deletions(-)
> > =C2=A0=20
> > @@ -10546,6 +10546,15 @@ static void task_mm_cid_work(struct
> > callback_head *work)
> > =C2=A0=C2=A0	mm =3D t->mm;
> > =C2=A0=C2=A0	if (!mm)
> > =C2=A0=C2=A0		return;
> > +	cpu =3D from_cpu =3D READ_ONCE(mm->mm_cid_scan_cpu);
> > +	to_cpu =3D from_cpu + CONFIG_RSEQ_CID_SCAN_BATCH;
> > +	if (from_cpu > cpumask_last(cpu_present_mask)) {
>=20
> See explanation about using possible rather than present.
>=20
> > +		from_cpu =3D 0;
> > +		to_cpu =3D CONFIG_RSEQ_CID_SCAN_BATCH;
>=20
> If the cpu_possible_mask is sparsely populated, this will end
> up doing batches that hit very few cpus. Instead, we should
> count how many cpus are handled within each
> for_each_cpu_from(cpu, cpu_possible_mask) loops below and break
> when reaching CONFIG_RSEQ_CID_SCAN_BATCH.
>=20
> > +	}
> > [...]
> > +	for_each_cpu_from(cpu, cpu_present_mask) {
> > +		if (cpu =3D=3D to_cpu)
> > +			break;
> > =C2=A0=C2=A0		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
> > +	}
>=20
> Here set mm->mm_cid_scan_cpu to the new next position which is
> the result from the "for each" loop.
>=20

Mmh, good point, I wonder though if we need to care for multiple
threads scanning the same mm concurrently. In my patch it shouldn't
happen (threads /book/ up to to_cpu writing it before scanning).
To do so, I'd probably need to create a map with N elements starting
from from_cpu and use that, or have a dry loop before actually
scanning.

Thanks,
Gabriele


