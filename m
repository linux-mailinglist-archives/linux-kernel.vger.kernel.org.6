Return-Path: <linux-kernel+bounces-523843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9860BA3DBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924863BFF73
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351AE1F63F5;
	Thu, 20 Feb 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+RIB3Cx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F61F9ED2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059866; cv=none; b=cnkJqNjWTDFvFkmfHktoAJV0ycBJRdEUv6+Cxb3B/BqVIxTBPbFGyzQlHbSgngpba+Vs9TsW1tTq2HkBoDwVSCW4eb5Q3xkuGf77a60yuu4XieirWXGVXw0UWQ7X9BHNh2Y/n/lqSjlr6si1HloqJxKZZVCijZfdcN7gab+YWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059866; c=relaxed/simple;
	bh=zAaw7TSBKPS4D23Z/LaUwA9UKB+rY+vBnDdyES3CAN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHcAVAa0Ii4EYCILqckeDCUBJcTUXvoEQOI8OWDBMGocxG3HGFoOfMYwUlGDN1TxSYenZu+sDBdA74aO9+dm6xXVGPU57MxAsm1yWUjPLUks8C/5jfwuVji0qU9Z3psyscXdm3lg072OzWpfxEgGTvMtrIxj/5JP942bqbHdJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+RIB3Cx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740059863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GbsNh5jLWiTAFgo/FZTl4eCODFMMC/utoFBLfGp7ZI=;
	b=a+RIB3CxoEbYcgplokOdpHfQgGRCqM2RsqNAK7Ucc2y0JwicMp0euhrVJm3g+jxVAYPtPK
	jidcDsjzWu3ui4J+Zmj8CurjwtU7Ess9dqc4ssXX2fPMglNDhkcUOikFvo+/qS5NOO3ROy
	OuhaDKtS01lYZ/iVa8A6jEwmnptFkG0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-ARc7UkQrNwKCod8wo0PEZw-1; Thu, 20 Feb 2025 08:57:42 -0500
X-MC-Unique: ARc7UkQrNwKCod8wo0PEZw-1
X-Mimecast-MFC-AGG-ID: ARc7UkQrNwKCod8wo0PEZw_1740059861
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d9fcb4a122so1038304a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740059860; x=1740664660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GbsNh5jLWiTAFgo/FZTl4eCODFMMC/utoFBLfGp7ZI=;
        b=nhe423gZoFveKd6jJCE1YjiQAZPDO/9tsdaqGWPG8ZCfowkxePDM2vtCCDsa+znAmf
         xmOOilTGva6dHaIYVDaeMK3WQAEiSRc1mph9mM5jr4C9BVKEOyFqy/x7D+gfJa8v+Sok
         B2Zfh/QmWecpkNRH26rMrgv96099YFqFyCyHo2G0IuMoVwuAsqGNAvLrkJ6J+ScIMWEh
         h0aNyrxPbQB3Ze7w1Lg4Q+lQKxyB+MRtdcc4NVlgMOgyUw+F73RHBVD2FnkQW0+G+npf
         cvSbgZyA71GY75YrUSMSlcegtmRy3Gh2OGBfajSTKs2Ef2TGVM52+EI7t7UMWvEWPTLS
         EGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrTu2Jkyf+Vg4CYYKugPglYpW2H+HSedXE/wHBdODjIfDnSmzMaH+aNKFZwNIWfBtFzYbloDo0vtGFO3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx34zClFtQYlXMUUPxZ/9GewUAMSOqOh2tnkbH2cPlA9j6jAsdq
	gzlBJUMjoBqwo9CaeFpRFOfVPlZS8xWT0x7ZnzZbCK+KZQC3jz8puoBxUv+xZ2nsArkQFkdgD3J
	V4xHy/HaWV+7dTBvG3lo7mI8aZnn9tLVlrnq0w7yFrCUJUPVRP3u6ZvIs3ds9PNKmkbeHm4H+yI
	9SlloCLFfMUrwTugWCVhhMth4+/0p1A1F2zAiF7vhc23Z2daI9XQ==
X-Gm-Gg: ASbGncuYopvvaVHyaFrS88pxy6ySK5YsyUC/0g8FcUhaUZELAi3zwO7NFycZH7nZpm7
	8NDZ6Pc4V9Nnqo0GVVR68wiK2OTmFkx4Dhh9dK8QLzpBk5oGIXu3uRyOID92HqxmLbygbhY0axb
	acgXoAgukOGURI8Qv+YHVV
X-Received: by 2002:a05:6402:460a:b0:5e0:9f31:a27a with SMTP id 4fb4d7f45d1cf-5e09f31a801mr3841250a12.5.1740059860685;
        Thu, 20 Feb 2025 05:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ+HSoxaX4rgKgD2byWHvvYbCPJjojznGobqymjwiQmeynvrU3zlKQt2bAZTWEv659d9UlR7HukDtxZzIxLws=
X-Received: by 2002:a05:6402:460a:b0:5e0:9f31:a27a with SMTP id
 4fb4d7f45d1cf-5e09f31a801mr3841226a12.5.1740059860356; Thu, 20 Feb 2025
 05:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113190911.800623-1-costa.shul@redhat.com> <Z5EmtNh_lryVj0S3@localhost.localdomain>
In-Reply-To: <Z5EmtNh_lryVj0S3@localhost.localdomain>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Thu, 20 Feb 2025 15:57:04 +0200
X-Gm-Features: AWEUYZmgTIAbbHosP3KBusFPXm12J57Mr1T2iuZFofHgH8azDvEd3DyReff4XjM
Message-ID: <CADDUTFyoc5ecrYd-DAoMOndy_TMGy+D_UiH5M8UR6F6pjZcA2g@mail.gmail.com>
Subject: Re: [RFC PATCH v1] Add kthreads_update_affinity()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Yu <yu.c.chen@intel.com>, 
	Kees Cook <kees@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Wed, 22 Jan 2025 at 19:11, Frederic Weisbecker <frederic@kernel.org> wro=
te:
> > @@ -1355,6 +1355,7 @@ static void update_isolation_cpumasks(bool isolcp=
us_updated)
...
> > +     kthreads_update_affinity();
>
> A few things to consider:
>
> 1) update_isolation_cpumasks() will be called with cpus_read_lock()
>   (cf: sched_partition_write() and cpuset_write_resmask()), therefore
>   kthreads_online_cpu() can't run concurrently.

Sorry, but I don't understand what you mean by =E2=80=9Ckthreads_online_cpu=
()
can't run concurrently.=E2=80=9D Could you clarify please?

> 2) The constraint to turn on/off a CPU as nohz_full will be that the
>    target CPU is offline.

The final goal of CPU isolation is to isolate real-time applications from
disturbances and ensure low latency. However, CPU hotplug disrupts
real-time tasks including the oslat test, which measures latency using RDTS=
C.
While performing a full CPU offline-online cycle at runtime can help avoid
long reboots and reduce downtime, it does not achieve the goal of
maintaining consistently low latency for real-time applications.

> * scheduler (see the housekeeping_mask() references, especially the ilb w=
hich is
>   my biggest worry, get_nohz_timer_target() shouldn't be an issue)

Are you referring to find_new_ilb()? What are your concerns?

> * posix cpu timers (make tick_dep unconditional ?)
Do you refer to the arm_timer()?
Could you please clarify which condition you are referring to?

> But we are getting closer!
Thank you very much for the detailed review!

Thanks,
Costa


