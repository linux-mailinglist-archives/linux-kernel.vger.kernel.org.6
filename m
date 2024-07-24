Return-Path: <linux-kernel+bounces-260698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2780F93AD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C091F2289E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE8B6A357;
	Wed, 24 Jul 2024 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F73uRXPN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7250269
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805739; cv=none; b=GDtnPn9uIKE1fUX0c8RWnHmnYI49Nbhybm3XyI0RzHJrcHFH/E4LelSxux3kCHgL85Dhppqq6q8TdDIK5ZrlSOPzsi83577/hElaE0Y+J1+XiDsPEDicnZ7eM3FSXPO2CSKFywmCR4qJ/cN4PVGBsdkFVfz4gTMRjjP1aR8d/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805739; c=relaxed/simple;
	bh=i+3Dw5TJO9f+FsTkSAq+Gt5Tp0i9wBPk/hzAx7812HA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DaTfbT0MJHV632ZR2GaPk6078qtlLaPV8QcFdgKfCVc6Y4eUVBeki4f/mtCnk7q9c5/SvbTXGMDqblabUxOFhfFGKM10MBqr8JOmIoSQXk6xUcvWHLoQ7Jsr9gYeDe8XDOlaBvVSTwGurn55NXywoVYGf5Hx8Qboc0cgE2Hce10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F73uRXPN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721805736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i+3Dw5TJO9f+FsTkSAq+Gt5Tp0i9wBPk/hzAx7812HA=;
	b=F73uRXPNoX/P2+TECWJNLY3w8LANJHf59XkQYAfN4ztj+8MiBrjfHq7qh65ib5KaruOBYb
	5szK4KXUP4tUeFdKMFtwrNYmlB8uX5I5cbyq4SX4fynVww/7EgGmB1c26gR44DqWYZepOP
	NTCBS5hdaWuB/egi8U2OoDSZk64wmrc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-seBNStFEMIC8QbnIzjXkVw-1; Wed, 24 Jul 2024 03:20:47 -0400
X-MC-Unique: seBNStFEMIC8QbnIzjXkVw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44f4e1569fcso83804531cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721805647; x=1722410447;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+3Dw5TJO9f+FsTkSAq+Gt5Tp0i9wBPk/hzAx7812HA=;
        b=rGe2IYdj3jpaCzTrI6k35APi03P2dIRAZJd7B9DlK7fcAORW/vQQdlXG9J/dl9HkBW
         n5aVHfDzx2zyEvG4dh6w8cqyMHrUphIEyQBAJbU9c0eA9+2P7B81DM0SR0M3DnvUBtXq
         miLj4YF/JLysBpQ1flmkktPXX8Fy6j34od5FG8RGK25GY1rdpQ8NMw3Z9jomuH6L6Ip1
         FPxj7Uz7KtPUQBXXdj5I2KvGfWW0bKNBjqW/RSvHSy0N4T88TXnRaY21HpwxpfPPT8ML
         /Cyk0Bd02+aZa1BaNax7XvSVxdVV7PiCDRKkJ0JCSOH+D05pzQ2bipuV3Cb3a2LBhsVg
         iPbw==
X-Gm-Message-State: AOJu0YwAhC5uv2ks8sLUUG2tgXMulmZ/C/5GFeQ5qbXkPuZGzi0h/jYf
	PkWMFF2yIAkSWhArbseJmzwP8GpOkdX+v1qTPnzyPyO73jdjy8I62cfYqfaiTp5yumIM4Pmh/Ga
	iGuusoc2khGXW3i9OIQRR2rbqcTj17sAEgSP5+2masKYynPotSiK+WPqyt1H2yQ==
X-Received: by 2002:ac8:5fd2:0:b0:447:e3a5:27a4 with SMTP id d75a77b69052e-44fd690c70bmr13335111cf.52.1721805646809;
        Wed, 24 Jul 2024 00:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3hwHQDyxNrmuz8DJLgtMTsUP1m4eqMytdEyB3bMxyRU0LAKgTsDlpFKTWSObfLA3s1kZhxA==
X-Received: by 2002:ac8:5fd2:0:b0:447:e3a5:27a4 with SMTP id d75a77b69052e-44fd690c70bmr13334821cf.52.1721805646451;
        Wed, 24 Jul 2024 00:20:46 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdc17f1sm51065571cf.91.2024.07.24.00.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 00:20:45 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Benjamin Segall <bsegall@google.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Phil Auld
 <pauld@redhat.com>, Clark Williams <williams@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Guo Ren
 <guoren@kernel.org>, Palmer
 Dabbelt <palmer@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 10/10] sched/fair: Throttle CFS tasks on return
 to userspace
In-Reply-To: <xm26a5i7zi7g.fsf@google.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-11-vschneid@redhat.com>
 <xm26y15yz0q8.fsf@google.com>
 <xhsmhikwwyw8r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xm26a5i7zi7g.fsf@google.com>
Date: Wed, 24 Jul 2024 09:20:39 +0200
Message-ID: <xhsmhfrrzz260.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 23/07/24 18:34, Benjamin Segall wrote:
> Valentin Schneider <vschneid@redhat.com> writes:
>
>> On 18/07/24 17:25, Benjamin Segall wrote:
>>> Valentin Schneider <vschneid@redhat.com> writes:
>>>
>>>> I've tested a 10ms runtime / 100ms period cgroup with an always running
>>>> task: upstream gets a "clean" periodic pattern of 10ms runtime every 100ms,
>>>> whereas this gets something more like 40ms runtime every 400ms.
>>>
>>> Hmm, this seems a little odd since TWA_RESUME does a kick_process.
>>
>> I didn't ponder too much on the workload used here, but the point I wanted
>> to bring up is: if you give a cgroup X amount of runtime, it may still
>> consume more than that within a single period because execution in
>> kernelspace isn't immediately stopped/throttled.
>>
>> It means the "standard" bandwidth control behaviour becomes a bit more
>> bursty.
>
> Yeah, more bursty behavior when doing cpu-burning syscalls is expected.
> With the check on exit to user I wouldn't expect anything worse than the
> duration of the syscall though, so it depends on what your test was.
>

That would also be my expectations. That was rt-app, so the userspace part
is mostly floating point operations IIRC. I'll do a bit of tracing to make
sure nothing funny is happening in the kernel.


