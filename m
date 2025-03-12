Return-Path: <linux-kernel+bounces-557323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69CA5D758
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8C53B8FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5621EFFAC;
	Wed, 12 Mar 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMyxjNkx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4751EFF93
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764854; cv=none; b=O3zJsQ5qmgyIFSQxB81cPdVvmlfPTpXUPLOVzDRgDtuuNggiqApayU5GGoKfvv94lAD7kRsZZ7tkdCjKu2vvZpsuiTEqFSbO00B4/dTZxL9SEKMEHbBUBT8UtzE552bHx+hnduL2uBiOYyl0wYofcjtcMbDjOO7KQtEpi+3wQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764854; c=relaxed/simple;
	bh=BrTF15AvH13d63zy/vLAqqUXsKV0xk4nSS0WGumaVkk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbJmWOTnUcEvg6bGUi8vrOA34gtMI2sXFkcUWV6dToHad0xDMLjBWRaVvgbfrAeQXqUZJQ3/lAMxJDIvYBVCLvAJeNzRlmjeWlxfA6Dsb4HN9iTDQWG7ulWFu81eeDn5Okv7xL4jFWOyEGahtbTZwDp1f3A5+Y8P3QJVK0P3qAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMyxjNkx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741764850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WtPBAnx7Hs4Uba/pRGLu260H1NcJqtDvQTP8rvegdd0=;
	b=QMyxjNkxL+YxfIOMh6t5D6pXT7juQNU54TF/4AcCrsN1ojZ5P94YwAf1I69B4Ca8ZgR0+c
	zzpkPUHaAqvFHqtdteN2ymPhZ1kxfojTrvlKVHQKYboVmuYA43x/OtjYzeGagDv2Aj/vI/
	zDHf3UVxBdLwcFwW56RwH8L8CsURTac=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Vmdvg5ZMO-uhufAjNvnA-Q-1; Wed, 12 Mar 2025 03:34:08 -0400
X-MC-Unique: Vmdvg5ZMO-uhufAjNvnA-Q-1
X-Mimecast-MFC-AGG-ID: Vmdvg5ZMO-uhufAjNvnA-Q_1741764848
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so17600025e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741764848; x=1742369648;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtPBAnx7Hs4Uba/pRGLu260H1NcJqtDvQTP8rvegdd0=;
        b=escxvwzO+O8LyDjZZu83zhlK5hN/V2N492ggxG+8j1GNPwGwItfaISqArwvYdINvtp
         zV60kSwAmozPtKmT/KgJZ8J1x88TRsoM6HS5/+9RBphDXZUM5Lt85sM9q31D8AA93CSm
         Ad+eT26ywNF90JDEl9QL3wQoumfVjfgWFEuSdp3Ww4+AorWkrP2YGIQPFBHzUZlImX4D
         gwvQgp4jUxbZC69idkrOBJwygKxjKh19zrl9EtC9wfGdhJx6F2r4C0PtLCJnMH9kJHfn
         f8lAW/A4x7vNCmn1eJv6j2rkPRY9iIOWq43ozgys8gm+s4FcUxb/COF/C3gHyYLoC9/p
         Cqfg==
X-Forwarded-Encrypted: i=1; AJvYcCVMisdpcAr+WXqqd8/oEThq5ocgVQHIiON54Coajod0mjB+ZkuLUs6gUThFj/YXkBpbeaSmCnoHz96Q8ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAehlN5GQRar+nniF8qOhgdbScoCu4LawCmXF01NbxENOKKjpk
	QKJEkdc+Pkhdm7hnVBhWQ8MLcMV6HG2XalcKjWi0uJEaOutF78t1+CtJJLWHN4HXGRih2Gz8kpt
	7/8toSzlLvTTXLc1pWt6lHaieudPTTF1b1aVwrUiJuELq8JMHrU3+2NgW9NNsfw==
X-Gm-Gg: ASbGncsSPvn779GQG72ZLIYMoyO4/bx8lqWHH/8Xo+LKzqHHsZN6dBK2rkKl2/SWaNA
	gRrMTl6ZxbAqJ2njyN2x7acoOBt4Yz/wr9f+UtylM427em17J8TBQtFyf51zRFibF3YcW/eGT7F
	v0XqwPDX4v6uzRh534pLOPyqtxlAvEmrkyNgQcX1FXLEdAr2rkgFZkNK7EaE9XRAHpNuXTWXmRB
	7CcN7CKpjXDdTYdRlkuDA88L7s21uJBehSAAlOFCpLHNsrdHYOR8EhkR47mRxz49gCIWDCqdZM8
	DPjV/lgPvPU5AJe2Mo+/miydHHK4GH2bpVW2ws2C5A==
X-Received: by 2002:a05:600c:154a:b0:43d:526:e0ce with SMTP id 5b1f17b1804b1-43d0526e41emr38289595e9.21.1741764847703;
        Wed, 12 Mar 2025 00:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyaE6aWypnT1yowUbn7eXOwfbXdedrJPjEjbbpMyAohE1BhqSz+E9IIQygt3KKHJyHXfpyMQ==
X-Received: by 2002:a05:600c:154a:b0:43d:526:e0ce with SMTP id 5b1f17b1804b1-43d0526e41emr38289405e9.21.1741764847192;
        Wed, 12 Mar 2025 00:34:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a78cc79sm12362525e9.27.2025.03.12.00.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:34:06 -0700 (PDT)
Message-ID: <70e7e51882ed0ab8f8dd0b0f93de77e7aaea69f7.camel@redhat.com>
Subject: Re: [PATCH 04/10] rv: Add rtapp_block monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	john.ogness@linutronix.de, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman
 Long <longman@redhat.com>
Date: Wed, 12 Mar 2025 08:34:03 +0100
In-Reply-To: <c8a1658c6da343b6055cbfcd6ee5ddea48335d31.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
	 <c8a1658c6da343b6055cbfcd6ee5ddea48335d31.1741708239.git.namcao@linutronix.de>
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

On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> Add an RV monitor to detect realtime tasks getting blocked. For the
> full
> description, see Documentation/trace/rv/monitor_rtapp_block.rst.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Waiman Long <longman@redhat.com>
> ---
> =C2=A0.../trace/rv/monitor_rtapp_block.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 34 +++
> =C2=A0include/trace/events/lock.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 12 +
> =C2=A0kernel/locking/rtmutex.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 12 +-
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0kernel/trace/rv/monitors/rtapp_block/ba.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 146 +++++++++++
> =C2=A0kernel/trace/rv/monitors/rtapp_block/ba.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
 166 +++++++++++++
> =C2=A0kernel/trace/rv/monitors/rtapp_block/ltl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 9 +
> =C2=A0.../rv/monitors/rtapp_block/rtapp_block.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 232
> ++++++++++++++++++

I see the creation of this type of monitor requires a bit more steps,
but are you considering automatic generation of Kconfig and
rtapp_block.c ?
We could reuse (export) some code from dot2k for that since the
skeleton could be the same.

Not needed for this series but it would be very nice to experiment
further.

I see the tracepoint generation is a bit complicated to generalise.
Da monitors currently don't give much data, besides pointing to what
failed in the model. If the user wants more, they can enable the
triggering tracepoints (e.g. I want to see the exact details of a
context switch, I enable that in the trace).

I get it isn't the quickest thing to do but makes the monitors very
general. Do you think something like this could be done here too?
Perhaps storing possible error messages in the monitor's header file
(like the state names in a da monitor).

> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 44 ++++
> =C2=A0lib/Kconfig.debug=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A011 files changed, 663 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 Documentation/trace/rv/monitor_rtapp_block.rst
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rtapp_block/ba.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rtapp_block/ba.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rtapp_block/ltl
> =C2=A0create mode 100644
> kernel/trace/rv/monitors/rtapp_block/rtapp_block.c
>=20
> diff --git a/Documentation/trace/rv/monitor_rtapp_block.rst
> b/Documentation/trace/rv/monitor_rtapp_block.rst
> new file mode 100644
> index 000000000000..9cabbe66fa4a
> --- /dev/null
> +++ b/Documentation/trace/rv/monitor_rtapp_block.rst
> @@ -0,0 +1,34 @@
> +Monitor rtapp_block
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Name: rtapp_block - real time applications are undesirably blocked
> +- Type: per-task linear temporal logic monitor
> +- Author: Nam Cao <namcao@linutronix.de>
> +
> +Introduction
> +------------
> +
> +Real time threads could be blocked and fail to finish their
> execution timely. For instance, they
> +need to access shared resources which are already acquired by other
> threads. Or they could be
> +waiting for non-realtime threads to signal them to proceed: as the
> non-realtime threads are not
> +prioritized by the scheduler, the execution of realtime threads
> could be delayed indefinitely.
> +These scenarios are often unintentional, and cause unexpected
> latency to the realtime application.
> +
> +The rtapp_block monitor reports this type of scenario, by monitoring
> for:
> +
> +=C2=A0 * Realtime threads going to sleep without explicitly asking for i=
t
> (namely, with nanosleep
> +=C2=A0=C2=A0=C2=A0 syscall).
> +=C2=A0 * Realtime threads are woken up by non-realtime threads.
> +
> +How to fix the monitor's warnings?
> +----------------------------------
> +
> +There is no single answer, the solution needs to be evaluated
> depending on the specific cases.
> +
> +If the realtime thread is blocked trying to take a `pthread_mutex_t`
> which is already taken by a
> +non-realtime thread, the solution could be enabling priority
> inheritance for the mutex, so that the
> +blocking non-realtime thread would be priority-boosted to run at
> realtime priority.
> +
> +If realtime thread needs to wait for non-realtime thread to signal
> it to proceed, perhaps the design
> +needs to be reconsidered to remove this dependency. Often, the work
> executed by the realtime thread
> +needs not to be realtime at all.
> diff --git a/include/trace/events/lock.h
> b/include/trace/events/lock.h
> index 8e89baa3775f..d4b32194d47f 100644
> --- a/include/trace/events/lock.h
> +++ b/include/trace/events/lock.h
> @@ -138,6 +138,18 @@ TRACE_EVENT(contention_end,
> =C2=A0	TP_printk("%p (ret=3D%d)", __entry->lock_addr, __entry->ret)
> =C2=A0);
> =C2=A0
> +#ifdef CONFIG_TRACE_RT_MUTEX_WAKE_WAITER
> +DECLARE_TRACE(rt_mutex_wake_waiter_begin,
> +		TP_PROTO(struct task_struct *task),
> +		TP_ARGS(task))
> +DECLARE_TRACE(rt_mutex_wake_waiter_end,
> +		TP_PROTO(struct task_struct *task),
> +		TP_ARGS(task))
> +#else
> +#define trace_rt_mutex_wake_waiter_begin(...)
> +#define trace_rt_mutex_wake_waiter_end(...)
> +#endif /* CONFIG_TRACE_RT_MUTEX */
> +
> =C2=A0#endif /* _TRACE_LOCK_H */
> =C2=A0
> =C2=A0/* This part must be outside protection */
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 4a8df1800cbb..fc9cf4a2cf75 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> [...]
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 8226352a0062..d65bf9bda2f2 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> [...]
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 188b64668e1f..6570a3116127 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> [...]
> diff --git a/kernel/trace/rv/monitors/rtapp_block/ba.c
> b/kernel/trace/rv/monitors/rtapp_block/ba.c
> new file mode 100644
> index 000000000000..5e99f79d5e74
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp_block/ba.c
> @@ -0,0 +1,146 @@
> [...]
> diff --git a/kernel/trace/rv/monitors/rtapp_block/ba.h
> b/kernel/trace/rv/monitors/rtapp_block/ba.h
> new file mode 100644
> index 000000000000..c1ba88f6779a
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp_block/ba.h
> @@ -0,0 +1,166 @@
> [...]
> +
> +/**
> + * rv_rtapp_block_atoms_fetch - fetch the atomic propositions
> + * @task:	the task
> + * @mon:	the LTL monitor
> + *
> + * Must be implemented. This function is called anytime the Buchi
> automaton is triggered. Its
> + * intended purpose is to update the atomic propositions which are
> expensive to trace and can be
> + * easily read from @task. rv_rtapp_block_atom_set() should be used
> to implement this function.
> + *
> + * Using this function may cause incorrect verification result if it
> is important for the LTL that
> + * the atomic propositions must be updated at the correct time.
> Therefore, if it is possible,
> + * updating atomic propositions should be done with
> rv_rtapp_block_atom_update() instead.
> + *
> + * An example where this function is useful is with the LTL
> property:
> + *=C2=A0=C2=A0=C2=A0 always (RT imply not PAGEFAULT)
> + * (a realtime task does not raise page faults)
> + *
> + * In this example, adding tracepoints to track RT is complicated,
> because it is changed in
> + * differrent places (mutex's priority boosting,
> sched_setscheduler). Furthermore, for this LTL
> + * property, we don't care exactly when RT changes, as long as we
> have its correct value when
> + * PAGEFAULT=3D=3Dtrue. Therefore, it is better to update RT in
> rv_rtapp_block_atoms_fetch(), as it
> + * can easily be retrieved from task_struct.
> + *
> + * This function can be empty.

Personal preference, but what about having the examples only in the
docs and point to those from here? Just to keep the code a bit slimmer.

> + */
> +void rv_rtapp_block_atoms_fetch(struct task_struct *task, struct
> ltl_monitor *mon);
> +
> +/**
> + * rv_rtapp_block_atom_update - update an atomic proposition
> + * @task:	the task
> + * @atom:	the atomic proposition, one of enum rtapp_block_atom
> + * @value:	the new value for @atom
> + *
> + * Update an atomic proposition and trigger the Buchi atomaton to
> check for violation of the LTL
> + * property. This function can be called in tracepoints' handler,
> for example.
> + */
> +void rv_rtapp_block_atom_update(struct task_struct *task, unsigned
> int atom, bool value);
> +
> +/**
> + * rv_rtapp_block_atom_get - get an atomic proposition
> + * @mon:	the monitor
> + * @atom:	the atomic proposition, one of enum rtapp_block_atom
> + *
> + * Returns the value of an atomic proposition.
> + */
> +static inline
> +enum ltl_truth_value rv_rtapp_block_atom_get(struct ltl_monitor
> *mon, unsigned int atom)
> +{
> +	return mon->atoms[atom];
> +}
> +
> +/**
> + * rv_rtapp_block_atom_set - set an atomic proposition
> + * @mon:	the monitor
> + * @atom:	the atomic proposition, one of enum rtapp_block_atom
> + * @value:	the new value for @atom
> + *
> + * Update an atomic proposition without triggering the Buchi
> automaton. This can be useful to
> + * implement rv_rtapp_block_atoms_fetch() and
> rv_rtapp_block_atoms_init().
> + *
> + * Another use case for this function is when multiple atomic
> propositions change at the same time,
> + * because calling rv_rtapp_block_atom_update() (and thus triggering
> the Buchi automaton)
> + * multiple times may be incorrect. In that case,
> rv_rtapp_block_atom_set() can be used to avoid
> + * triggering the Buchi automaton, and rv_rtapp_block_atom_update()
> is only used for the last
> + * atomic proposition.
> + */
> +static inline
> +void rv_rtapp_block_atom_set(struct ltl_monitor *mon, unsigned int
> atom, bool value)
> +{
> +	mon->atoms[atom] =3D value;
> +}
> +
> +/**
> + * rv_rtapp_block_get_data - get the custom data of this monitor.
> + * @mon: the monitor
> + *
> + * If this function is used, rv_rtapp_block_init() must have been
> called with a positive
> + * data_size.
> + */
> +static inline void *rv_rtapp_block_get_data(struct ltl_monitor *mon)
> +{
> +	return &mon->data;
> +}
> diff --git a/kernel/trace/rv/monitors/rtapp_block/ltl
> b/kernel/trace/rv/monitors/rtapp_block/ltl
> new file mode 100644
> index 000000000000..781f0144a222
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp_block/ltl
> @@ -0,0 +1,9 @@
> +RULE =3D always (WAKEUP_RT_TASK imply (RT or WAKEUP_WHITELIST))
> +=C2=A0=C2=A0 and always ((USER_TASK and RT) imply (SLEEP imply
> INTENTIONAL_SLEEP))
> +
> +INTENTIONAL_SLEEP =3D DO_NANOSLEEP or FUTEX_LOCK_WITH_PI
> +
> +WAKEUP_WHITELIST =3D RT_MUTEX_WAKING_WAITER
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or STOPPING_WOKEN_TASK
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or WOKEN_TASK_IS_MIGRATION
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or WOKEN_TASK_IS_RCU
> diff --git a/kernel/trace/rv/monitors/rtapp_block/rtapp_block.c
> b/kernel/trace/rv/monitors/rtapp_block/rtapp_block.c
> new file mode 100644
> index 000000000000..3f5b1efb7af0

I'm wondering if it would be cleaner to keep the specifications under tools=
/
(just like the dot files for da monitors).
Nevertheless we should be consistent with what we choose.

Thanks,
Gabriele

> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp_block/rtapp_block.c
> [...]
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index 96264233cac5..79a7388b5c55 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> [...]
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06..942318ef3f62 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1638,6 +1638,9 @@ config TRACE_IRQFLAGS
> =C2=A0	=C2=A0 Enables hooks to interrupt enabling and disabling for
> =C2=A0	=C2=A0 either tracing or lock debugging.
> =C2=A0
> +config TRACE_RT_MUTEX_WAKE_WAITER
> +	bool
> +
> =C2=A0config TRACE_IRQFLAGS_NMI
> =C2=A0	def_bool y
> =C2=A0	depends on TRACE_IRQFLAGS



