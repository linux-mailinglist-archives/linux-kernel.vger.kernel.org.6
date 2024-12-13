Return-Path: <linux-kernel+bounces-445039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5038D9F103A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F79E16C597
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887A1E22EF;
	Fri, 13 Dec 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cvr9lYcF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43681DFE08
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102205; cv=none; b=OiC+DlpfWh7YOYZ7kTPdOQi6YAKhPeg/Lmx6baeR9Ojff1zpa4bHr58wKvCvz+WT1i9bdYjirUUSRAZGY2ZXjs/jSaa5rkaQSGkDV3/39eCVnIkwaua2aTL0tWrXXzN4bWpF87hTu99U6bUcRzdMZ/Je7F5RKrDnLHJsH68rOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102205; c=relaxed/simple;
	bh=oBcSJQ2t3grJhtRmAoyfmj/BiN/0ePGUbmAHrkcnY0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LIFkbOc5QdbDow0LrXiyNyjDcsVkwESFkkFDVCyhGRVk3gomPPcc1j0ousdFnHSWojCVMfClWCKZWRBSUEbU0NxGfnNeF3sbknalgMKz56X/xN7SEuhh9WHe/gcr1pkhYn1XAWr1POwgJaCxNsGeMCQms30yj6zL3MaBD2zwoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cvr9lYcF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734102202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oBcSJQ2t3grJhtRmAoyfmj/BiN/0ePGUbmAHrkcnY0k=;
	b=Cvr9lYcFua1VEBfDHdzvLkAIqMeiGkOUCbsaEfVSwoHQ26uHfokpQ3Oz8U6Pk9aJhN/2hS
	DVvxFJ2OW93B4iUWoqch59xquR8wrzyl56m44FdHXIYLnK+jz7gO9E5Z0y5FFfrgvSw2n0
	BywPJV2cD/cFTeUE+px5fGm2jCG+MFI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324--ih0i9_5Pw2gn1uHchVD2g-1; Fri, 13 Dec 2024 10:03:21 -0500
X-MC-Unique: -ih0i9_5Pw2gn1uHchVD2g-1
X-Mimecast-MFC-AGG-ID: -ih0i9_5Pw2gn1uHchVD2g
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so15161645e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102200; x=1734707000;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBcSJQ2t3grJhtRmAoyfmj/BiN/0ePGUbmAHrkcnY0k=;
        b=W/H1knx9h7rRcsj+Xz7P78VL3VcjmAluDOGE8hMbjnkageZmmdTy2rzW1L+QyBc0vm
         gnUhfNycKAqA5oRvuM5ru+1VskLi08ca4lqrusbejPD0XXGwpS1RlFKzYE+bsnDtBrr3
         9RzIcnTUGRNaGHW4r0kg2YtO56vXEnnCNeTkcdkaj9fDPRNYtFGOg7hhwblY1fboLriI
         8ySpR/qgkYp63cQwSufJC1/peDwpwrtRcK71TVnXgt79lb8D7wASLjuhyiJy7in5OQL3
         1V4qYhCmTHhD3HGwR5FQhMM/rTnhO3un1PUCAIWfubVejyHJvY12qJLi8UwHWbeqH8oo
         kMwg==
X-Forwarded-Encrypted: i=1; AJvYcCXWzopWKULwQCcqVkYGP9+1S2LTsQuXnzt4OCJl+LJhznGJ7NMOkCGOIPOLaltIH0YpeaKCtyjccfN3YEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiHXYelCVEpBatI3MQcUOua5aG4jWXSSijve/8R0f3pf8xX/1t
	kxMazNW5zebKv1c0x2DJS1D3ZjxOb7GeQ+HvIKrJlgLc4BRxjiJaBFldia5mrKLqYM+vZBPjzDZ
	NMSu3+ujPzeDGrvAdCnKtbf9aD0AUiyKZG4NxyBI1qCgoWTzGaXyhNUXPdEjD5A==
X-Gm-Gg: ASbGnctcvKfbmVeBk0Xa0D1cOVBCjy/yShU8tQZb7FVa32BB9H6mDPKAr2L+JkX3wxB
	80gTT9kinrU/u8wCYwOL7c9kg7XmFfXEApE8Yu7HurYaoMbmE2PaOUcS19YdIhApDHAQYr10uUr
	9HRWoh6Xf7j33vKjGBs6SZXRCMoOIGtL7UyJZ0aZiTikCLwgqv/puJsM08d/Iy+14ekaIq5VcpE
	9YDBaJzK5J7sRGB8Vrcqgmc5LNxUC026Zq4giRkThV3eX7Spseru8dOiERSs5gUwLI9PQHHTk2R
	Re/BAiM=
X-Received: by 2002:a05:6000:1848:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-3888e0ae4e6mr2179720f8f.24.1734102199455;
        Fri, 13 Dec 2024 07:03:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfmoqcWVGaoAEdxBU9PUF7o693pCscmUutfo3TPGUnwsDrq4ACd1XfMkd86Qb9YrgGD48O2g==
X-Received: by 2002:a05:6000:1848:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-3888e0ae4e6mr2179654f8f.24.1734102198868;
        Fri, 13 Dec 2024 07:03:18 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514beesm7452649f8f.71.2024.12.13.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:03:18 -0800 (PST)
Message-ID: <199437fe21ad5bb47ce81c560fbeb0495b5f9ce3.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] rseq/selftests: Add test for mm_cid compaction
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	 <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>, Shuah Khan
	 <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	 <akpm@linux-foundation.org>
Date: Fri, 13 Dec 2024 16:03:15 +0100
In-Reply-To: <d1e64ae2-9a16-44af-afca-a1940f27d4ef@efficios.com>
References: <20241213095407.271357-1-gmonaco@redhat.com>
	 <20241213095407.271357-5-gmonaco@redhat.com>
	 <d1e64ae2-9a16-44af-afca-a1940f27d4ef@efficios.com>
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


On Fri, 2024-12-13 at 09:29 -0500, Mathieu Desnoyers wrote:
> On 2024-12-13 04:54, Gabriele Monaco wrote:
> > A task in the kernel (task_mm_cid_work) runs somewhat periodically
> > to
> > compact the mm_cid for each process, this test tries to validate
> > that
> > it runs correctly and timely.
> >=20
> > + /*
> > + * We select one thread with high enough mm_cid to be the new
> > leader
> > + * all other threads (including the main thread) will terminate
> > + * After some time, the mm_cid of the only remaining thread should
> > + * converge to 0, if not, the test fails
> > + */
> > + if (curr_mm_cid > args->num_cpus / 2 &&
>=20
> I think we want=C2=A0 curr_mm_cid >=3D args->num_cpus / 2=C2=A0=C2=A0 her=
e,
> otherwise the case with 2 cpus would not match.

Right, good point.

> > + =C2=A0=C2=A0=C2=A0 !pthread_mutex_trylock(&args->token)) {
> > + printf_verbose("cpu%d has %d and will be the new leader\n",
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_getcpu(), curr_mm_cid);
> > + for (i =3D 0; i < args->num_cpus; i++) {
> > + if (args->tinfo[i] =3D=3D pthread_self())
> > + continue;
> > + ret =3D pthread_join(args->tinfo[i], NULL);
>=20
> We'd want a synchronization point to join the main thread. I'm not
> sure
> if the main thread is joinable.
>=20
> Perhaps we could try calling pthread_self() from the main thread, and
> store that in the main thread struct thread_args, and use it to join
> the main thread afterwards ?
> >=20
> > +void test_mm_cid_compaction(void)
> > +{
> > + for (i =3D 0, j =3D 0; i < CPU_SETSIZE && j < num_threads; i++) {
> > + if (CPU_ISSET(i, &affinity)) {
>=20
> Including the main thread, we end up creating nr_cpus + 1 threads.
> I suspect we want to take the main thread into account here, and
> create
> one less thread.
>=20
> We could use tinfo[0] to store the main thread info.

Good idea, that would get two birds with one stone.
I just forgot to pass it but it seems=C2=A0the main thread is perfectly
joinable (just checked), so that should work fairly easily.

>=20
> > + ret =3D pthread_create(&tinfo[j], NULL, thread_runner,
> > + =C2=A0=C2=A0=C2=A0=C2=A0 &args);
> > + if (ret) {
> > + fprintf(stderr,
> > + "Error: failed to create thread(%d): %s\n",
> > + ret, strerror(ret));
> > + assert(ret =3D=3D 0);
> > + }
> > + CPU_SET(i, &test_affinity);
> > + pthread_setaffinity_np(tinfo[j], sizeof(test_affinity),
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &test_affinity);
>=20
> It would be better that each thread set their own affinity when
> they start rather than having the main thread set each created thread
> affinity while they are already running. Otherwise it's racy and
> timing-dependent.
>=20
> And don't forget to set the main thread's affinity.

Sure, will do!

Thanks for the comments, working on V3.
Gabriele


