Return-Path: <linux-kernel+bounces-442971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8799EE4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9366F18870A8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A96C2116F8;
	Thu, 12 Dec 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRjobKog"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBD211A0B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001761; cv=none; b=QrsrVtnFYTkSrTOL6gzjF8lFrRlMwEGxHZGcIZ/ekl4PNegTRLscaRSbImiWaS/52LC9KJGvsCeRGl/5tCGyqjh1ScKUzXY+wNiIxnuff27zFK9BD4tCXSU29Pbj2KKvZriczTWh2u9kQZCD1It2xXWHgaDvJCBb/bE595tUi3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001761; c=relaxed/simple;
	bh=NVCzg2aQMKAJiIzGPvWwj8kbPMgicpJ+TDwewG2vM1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PLD7rfmehEQmBm+iDtMWHRdBqBoohMq6J55FOnAJzay4fjAYyr4kIA/h+i4mEFaQu8uWmuyPbDR06ybuwKhWObCi2KuLu82y1CMNECDkkza5m7J81XwwbJnIFZHHGIEV0BAEVHpavThIHCNTe6XFiHS2hQxGkStZ5LE+Tb7MnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRjobKog; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734001758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NVCzg2aQMKAJiIzGPvWwj8kbPMgicpJ+TDwewG2vM1M=;
	b=VRjobKogR895b0yjaQ7aA0YM8CY/AMDmLK+nPS7h5oRxjdfKaPLac2KLRLC7SWxgoGpicD
	EsTAOPJUPWjqx/hUZd9OxUelaw0rTQlf4VJ184wpNiTLUZNiyfW+e8CvtS3XjV2L2zwn75
	fR/5tuHTcUFQ+PlLs0nxO5Cqh2gm6sg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-RStWhyYfOhiUQO-qf0EM1A-1; Thu, 12 Dec 2024 06:09:17 -0500
X-MC-Unique: RStWhyYfOhiUQO-qf0EM1A-1
X-Mimecast-MFC-AGG-ID: RStWhyYfOhiUQO-qf0EM1A
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so4409215e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001756; x=1734606556;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVCzg2aQMKAJiIzGPvWwj8kbPMgicpJ+TDwewG2vM1M=;
        b=Rpelq6sT3J9u8vJJD6IsLVMW72d9h+C4hvPQGAxC6khpLnm2Z8Fy3x2WSadvhYAIFk
         6bXIqgxiQHtsUdJBHamEwjJ216UcF5jlViVktls6o+EaicCbB+ZntB8cUJ+i9RlGd7qf
         Nu/o2HV2Hp9VNjK4yCuzCGv8RHcEVxYmRygMZaOBXvfsdYyZc5WpkjCnPav3GRFy1Zff
         NSNiMPsKTfpUIQH9oDnud/fgoGB7G5ko3+5o9fsrY0/pCXp5+zNPV0/ffxkrHGURg1TI
         D8WynvJ/YQrFOOjlHgY6KHEiR7UKOcYQKOdhh0UNufhIS7kZxTgX1/JdwSpUnztMuPis
         DD+g==
X-Forwarded-Encrypted: i=1; AJvYcCVM+ypH5mhSltr5BBUAaKK6ETfbwUDPg0/O+dxgoWshVRU4MxLlNb/FV+YXqZkU3AyhBtSBEBaBoc8liEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VQvCfd57jlFRHOUB1NwdvboJzz7GeuSdVnbNVdvj0QZCLrrT
	gOWrsF0CCfuhBThpUua0iF7317NtNZWTS2OKH8pNyu0tdxzhp3ErR9WEBsONUFezMrD/PMq+fox
	3rDz59KjXvRctH2KAwMHozN+HtJsJjlakyUeYU5TedqlOLVae+2LYZCrDfQg8Bw==
X-Gm-Gg: ASbGnctNnIO17YycLGPlT/G89b1ThR00OkqOtKbKbCb1AmMjAuPwZEupun9mkDE7xKS
	BoUxnFGlQdbb7UBCWU2RdoP+F6cAMNwZqBcWV67mE8wGaQRfq1QfKh6daQFKo7Yy7cN4Tzi88Vt
	jI2Se5Sp+fPR/POjUbh+ZOqKb5AMUQP1d0v9YVgUgovugxjLrHXhsNLJFFVlbObp6nAxsiI7J1r
	nmH+H4uW2lRUF5eVpZedrgZmLL6bXzSBEggDX6FyuvUJ83Ann2yw8kw6IT+RoXhPs6yf2y39yke
	0SMEujc=
X-Received: by 2002:a05:600c:3b18:b0:434:fd77:5436 with SMTP id 5b1f17b1804b1-4361c38d24fmr55270095e9.15.1734001756125;
        Thu, 12 Dec 2024 03:09:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8ap1IbGcgEu+lVxAQWA0eS/jI89kYifdBDCdLvLY0jc5l1y7TOiHLyavz5avNPpBRcPwp9Q==
X-Received: by 2002:a05:600c:3b18:b0:434:fd77:5436 with SMTP id 5b1f17b1804b1-4361c38d24fmr55269825e9.15.1734001755714;
        Thu, 12 Dec 2024 03:09:15 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706595sm13537165e9.33.2024.12.12.03.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 03:09:14 -0800 (PST)
Message-ID: <7e9082361b5b98f1824301c92cde929725db0db6.camel@redhat.com>
Subject: Re: [PATCH] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot	
 <vincent.guittot@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra	 <peterz@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mel Gorman	 <mgorman@suse.de>
Date: Thu, 12 Dec 2024 12:09:11 +0100
In-Reply-To: <eee21fae-dc64-40bf-90ac-c7228ae7ef48@efficios.com>
References: <20241205083110.180134-2-gmonaco@redhat.com>
			 <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
			 <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
			 <ead55d690448cbf23677bcc1b4c1a5c129240c90.camel@redhat.com>
			 <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
			 <481a7b7716cf4eb2d592b08558d297d343d9aa25.camel@redhat.com>
			 <cbc0a3c5-2ae5-439e-ae5d-7fb68ea49aec@efficios.com>
			 <1f4a8928-8450-48e2-bf40-e75967240d79@efficios.com>
			 <7c4d0c6800a4bd7a5cf4928e28d59fb469c944b9.camel@redhat.com>
			 <eee21fae-dc64-40bf-90ac-c7228ae7ef48@efficios.com>
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


On Wed, 2024-12-11 at 12:07 -0500, Mathieu Desnoyers wrote:
> > Here's where I'm in doubt, is a compact map more desirable than
> > reusing
> > the same mm_cids for cache locality?
>=20
> This is a tradeoff between:
>=20
> A) Preserving cache locality after a transition from many threads to
> few
> =C2=A0=C2=A0=C2=A0 threads, or after reducing the hamming weight of the a=
llowed cpu
> mask.
>=20
> B) Making the mm_cid guarantees wrt nr threads and allowed cpu mask
> easy
> =C2=A0=C2=A0=C2=A0 to document and understand.
>=20
> C) Allowing applications to eventually react to mm_cid compaction
> after
> =C2=A0=C2=A0=C2=A0 reduction of the nr threads or allowed cpu mask, makin=
g the
> tracking
> =C2=A0=C2=A0=C2=A0 of mm_cid compaction easier by shrinking it back towar=
ds 0 or
> not.
>=20
> D) Making sure applications that periodically reduce and then
> increase
> =C2=A0=C2=A0=C2=A0 again the nr threads or allowed cpu mask still benefit=
 from good
> =C2=A0=C2=A0=C2=A0 cache locality with mm_cid.
>=20
>=20
> > If not, should we perhaps ignore the recent_cid if it's larger than
> > the
> > map weight?
> > It seems the only way the recent_cid is unset is with migrations,
> > but
> > I'm not sure if forcing one would make the test vain as the cid
> > could
> > be dropped outside of task_mm_cid_work.
> >=20
> > What do you think?
>=20
> Can you try this patch ? (compile-tested only)
>=20
> commit 500649e03c5c28443f431829732c580750657326
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:=C2=A0=C2=A0 Wed Dec 11 11:53:01 2024 -0500
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 sched: shrink mm_cid allocation with nr thread/a=
ffinity
>=20
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 76f5f53a645f..b92e79770a93 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3657,10 +3657,24 @@ static inline int __mm_cid_try_get(struct
> task_struct *t, struct mm_struct *mm)
> =C2=A0 {
> =C2=A0=C2=A0 struct cpumask *cidmask =3D mm_cidmask(mm);
> =C2=A0=C2=A0 struct mm_cid __percpu *pcpu_cid =3D mm->pcpu_cid;
> - int cid =3D __this_cpu_read(pcpu_cid->recent_cid);
> + int cid, max_nr_cid, allowed_max_nr_cid;
> =C2=A0=20
> + /*
> + * After shrinking the number of threads or reducing the number
> + * of allowed cpus, reduce the value of max_nr_cid so expansion
> + * of cid allocation will preserve cache locality if the number
> + * of threads or allowed cpus increase again.
> + */
> + max_nr_cid =3D atomic_read(&mm->max_nr_cid);
> + while ((allowed_max_nr_cid =3D min_t(int, READ_ONCE(mm-
> >nr_cpus_allowed), atomic_read(&mm->mm_users))),
> + max_nr_cid > allowed_max_nr_cid) {
> + if (atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid,
> allowed_max_nr_cid))
> + break;
> + }
> =C2=A0=C2=A0 /* Try to re-use recent cid. This improves cache locality. *=
/
> - if (!mm_cid_is_unset(cid) && !cpumask_test_and_set_cpu(cid,
> cidmask))
> + cid =3D __this_cpu_read(pcpu_cid->recent_cid);
> + if (!mm_cid_is_unset(cid) && cid < max_nr_cid &&
> + =C2=A0=C2=A0=C2=A0 !cpumask_test_and_set_cpu(cid, cidmask))
> =C2=A0=C2=A0 return cid;
> =C2=A0=C2=A0 /*
> =C2=A0=C2=A0 * Expand cid allocation if the maximum number of concurrency
> @@ -3668,12 +3682,11 @@ static inline int __mm_cid_try_get(struct
> task_struct *t, struct mm_struct *mm)
> =C2=A0=C2=A0 * and number of threads. Expanding cid allocation as much as
> =C2=A0=C2=A0 * possible improves cache locality.
> =C2=A0=C2=A0 */
> - cid =3D atomic_read(&mm->max_nr_cid);
> - while (cid < READ_ONCE(mm->nr_cpus_allowed) && cid <
> atomic_read(&mm->mm_users)) {
> - if (!atomic_try_cmpxchg(&mm->max_nr_cid, &cid, cid + 1))
> + while (max_nr_cid < allowed_max_nr_cid) {
> + if (!atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid, max_nr_cid +
> 1))
> =C2=A0=C2=A0 continue;
> - if (!cpumask_test_and_set_cpu(cid, cidmask))
> - return cid;
> + if (!cpumask_test_and_set_cpu(max_nr_cid, cidmask))
> + return max_nr_cid;
> =C2=A0=C2=A0 }
> =C2=A0=C2=A0 /*
> =C2=A0=C2=A0 * Find the first available concurrency id.

Thanks for the patch, it seems much more robust than my simple
condition on the weight. It passes the test (both versions) we
previously discussed and doesn't seem to interfere with the general
rseq functionality as checked by the other selftests.
I'm not sure if I should run more tests on this one.
I will come up with a V2 shortly and attach some performance
evaluations.

Do you want to keep your patch separate or do I submit it together with
V2?

Thanks,
Gabriele


