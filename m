Return-Path: <linux-kernel+bounces-284810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9F8950564
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5802AB29F13
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2252319CD13;
	Tue, 13 Aug 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqErMFEf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60DD19AA41
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553035; cv=none; b=apP09OYMKFkheN92cWgY5d7trdWlxKOg7gqh0nK0S9/e7fcMq9uFaymm9FdaHELH5XnaEcQV1TBu1dPt99OOPvfcTrLJmUr5iWfe5MuZY1JXuxaYRnReHBG5dOQkT8wOZ+zl0DP1Kd2b2FvKFzoAHT/u3dAw37IZ6nWDqj6wFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553035; c=relaxed/simple;
	bh=ypkwFJbA2EBg/iTZYTklZsMBlZNJ29xFvjJnZK/y8MM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DQcOvJd56BHdHY36js8a9984qvbVL4iinhXIgKv9I1PKVXT0X07oI5nmnHRIdduO6FGxL19j7lZLun25nzcTLGCDeVLBcrW8tssCYjyn2cnEUJXfZMlM+/1/u1gxPEkxmr3NDuLwgEObyCogpvtl6AzyUdmEGMfruydnno9p0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqErMFEf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723553032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTKbJta3cNLZLwrMQ87mBPsFeP6LoozFwd0U4pqVBgI=;
	b=TqErMFEfMWQbiChWe2t2JS0cZy987FKGmot52pZqOjtGfa7AdHb+J7HPNwsdhlMn7btxSp
	kfJmbx6wv4+MPA4pedFmPgmGs6xZtb4wf8T0O9YtsQZnGZdRf/oI7L0L/YwJGwSquSeqnr
	uIxquQAaSsSepLNydRsxoZFYVtRDsbM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-ABOb_MKvOUuHNio5AAFfPA-1; Tue, 13 Aug 2024 08:43:51 -0400
X-MC-Unique: ABOb_MKvOUuHNio5AAFfPA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efdae5be6so6096091e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723553030; x=1724157830;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTKbJta3cNLZLwrMQ87mBPsFeP6LoozFwd0U4pqVBgI=;
        b=ns5b7WOrwDDBYDT+ockd2veKIzGOCU13eiS73qrQwM0pLJo6NmP53sVRWlfXwSnhqL
         mEtqPizGoMO12ucim59smJBKwcPYjxRfKEMYOoXIbWzz4mQLDX71nsgheY5bGsHnIIUo
         0NuMgCCHgsAhnClu+HX9jbz150XXviJTH+fpisnkqlBMtQwdMJT2tIdTkCeW+qwUAeP2
         X00rLFgWI3ngXy4qL8bUocBNfxtrXoX/rht68ArMEvRZfF73QZ3VS0YVvTnWj/k4ktHz
         JlF3mYEDBvtiswS8+w1ePSao36v3vC2v+lmcbPdHTmxj+Tp7kTdII+8gQ+kdTzWk/K0F
         c90g==
X-Forwarded-Encrypted: i=1; AJvYcCXlGfS2k1mR5QIbXycQ5Rixa4NI7XcII0NrMB4egs2ZmViFHwO1WbvN+rs34gybWCK/QllCdk6pMNOhJIags3IQujQCq7dCyOgbBhk3
X-Gm-Message-State: AOJu0YxaV3+vzBGGS28JDyYaK9GXs29GP+7ltpwZ3epzzko8SSovoi8k
	MCddVDtd9P9qHoGXqNSv3n8DJtrVHIIobA61WOcGoU+GvkxL6HkdaHkSQo+gL5FAw/qiojZpf5R
	WRSMBuFzTWDMNvJw5sj82fmTaY/JsjYdQmfaZstTXm6YR3CQaKy1AOoLIqQI25Q==
X-Received: by 2002:a05:6512:3b91:b0:52c:e5ac:ecd2 with SMTP id 2adb3069b0e04-53213694532mr2230698e87.51.1723553029685;
        Tue, 13 Aug 2024 05:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6GrKGmFfam2gDb5xc9X5PFsllN1TEBBUnw6y9JdjRPEWaOOJZVZxKIN+QD+SeVjAwBJlkvQ==
X-Received: by 2002:a05:6512:3b91:b0:52c:e5ac:ecd2 with SMTP id 2adb3069b0e04-53213694532mr2230672e87.51.1723553029106;
        Tue, 13 Aug 2024 05:43:49 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7736b05sm142652355e9.29.2024.08.13.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:43:48 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 12/24] sched/fair: Prepare exit/cleanup paths for
 delayed_dequeue
In-Reply-To: <20240727105029.631948434@infradead.org>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.631948434@infradead.org>
Date: Tue, 13 Aug 2024 14:43:47 +0200
Message-ID: <xhsmh8qx0y4n0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 27/07/24 12:27, Peter Zijlstra wrote:
> @@ -12817,10 +12830,26 @@ static void attach_task_cfs_rq(struct ta
>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
>  {
>       detach_task_cfs_rq(p);
> +	/*
> +	 * Since this is called after changing class, this isn't quite right.
> +	 * Specifically, this causes the task to get queued in the target class
> +	 * and experience a 'spurious' wakeup.
> +	 *
> +	 * However, since 'spurious' wakeups are harmless, this shouldn't be a
> +	 * problem.
> +	 */
> +	p->se.sched_delayed = 0;
> +	/*
> +	 * While here, also clear the vlag, it makes little sense to carry that
> +	 * over the excursion into the new class.
> +	 */
> +	p->se.vlag = 0;

RQ lock is held, the task can't be current if it's ->sched_delayed; is a
dequeue_task() not possible at this point?  Or just not worth it?


