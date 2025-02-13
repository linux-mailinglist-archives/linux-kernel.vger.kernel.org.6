Return-Path: <linux-kernel+bounces-513166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7478A342DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204003A76BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E909241690;
	Thu, 13 Feb 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUhN9fRu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403972222B1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457476; cv=none; b=tTS9Z3z07Dbl5NogP46Ozx2m0XiGkgK3VN5MOmWkxCZLcm+UyqHnogpwiXx1mZejmCeCtm4b+iI5KRBUk4zqPMzApPR9dLjWrU2q+0tItws2uPedzLaBGtyVHwpbGoh2KwDdMTpLro9gslXp9CV5VlQ8FjeCEpQ5QuSclMBgULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457476; c=relaxed/simple;
	bh=QMsIkRsLOsVXj850WlfngMWu2xehoAAjf9EtoK8GX7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YUz1WnTeD6T5Rk4GxrFDLI/NNBV6XYckQlGGcD92DTvgW+NnzsYdcOEjwvyzS3+8PSelv9AyRvrEy66eCdoJ2bP4acdWuDkHY5CoyOyJtSCN3mRiwKNmosS9YizkLXxrNE2Gm0wVKnfNOYTRswogVF7EFFzFtLKoC/GUpIcxsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUhN9fRu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739457474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QMsIkRsLOsVXj850WlfngMWu2xehoAAjf9EtoK8GX7I=;
	b=NUhN9fRuKfk90pCALV78qKCZlBHDd9bIY5i91zQu0fcoVl+/o+Fw7GdTr691javKhHcUAm
	r9Er3EwSM3ffitmGyL9BQ8CH3LhGtyPbmFNH+ZW05ZW+ZNk3x2adf4NcNoJh5nRSlQWLxv
	lwPfPtarR8BaLQizGjkBs8ZEcgbyM98=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-3pUviAIMNzilej-0zkoJMw-1; Thu, 13 Feb 2025 09:37:51 -0500
X-MC-Unique: 3pUviAIMNzilej-0zkoJMw-1
X-Mimecast-MFC-AGG-ID: 3pUviAIMNzilej-0zkoJMw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38dc88ed9c0so540537f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457470; x=1740062270;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMsIkRsLOsVXj850WlfngMWu2xehoAAjf9EtoK8GX7I=;
        b=MzBwubn/0xVsdiS44g7qczvqWyynOgjNyPQnnyIay+9gVgndwiBimbUfInj45v8v8C
         gs2dR5Pt7emM/XAyA12baiudcYlGW0xt/rR7r40UNzIh3Q/KoI9oFCrZjL89rrZK18Be
         WrK8liS3yn1dwgcOLKG1xQTDwVsvEw9EtJxTYexCL+7igjEXuTRkKCZ5Zi7AdJ65TUuZ
         e4UJ4VnGFRzqcK3Q7GHz2vUl/4YiGnRn8ZYiJNGX89oPoxqVwrWaOyOr/ToZCUQvu1La
         FuSddNMLHs9jWHz8XWdNNUshW352s/2btQ5uU70L1jgmQpD9DOW/q3yGmT3MVI9ngmm5
         T6gw==
X-Forwarded-Encrypted: i=1; AJvYcCVEx4To1gOvFitSNkBcfrmHj2s1LraHijSEFauxEXzdWqrCWyh/V8wWkHRz0hNEK7+XFcdOVpMyeYGzYQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1udBJrG/S4AHHXTiJAdhuyPHQM4lKZmlwaWT8CHQ3fAUo8ZV0
	Cgd5KaOn3IwRFQ5vDH+27uG1/ZhaQcn0K6Ppjn/NWud8rYu+iYK6H2REC4msfFSRZ1CQIsSn23p
	Jxrth3ypK0A5RR/rNssm1e1gw1d+fgjuTcg7zkXPjP134e39sbm1LzgLUiiXBzQ==
X-Gm-Gg: ASbGnctPPBYrVwICl4Gbh96nIvuphRUh9GATPfm4f9uVk8b0ECdc3lCHYj38lYbo7AQ
	thdaNTsjbh5SWQLdkidxHxm7tsLZ/oSusBvkPHPkR5vioP7sij4ElCmP+pyoQPdghrfmjdU83tt
	D61K58ap0ttVytwfjxGiOPH/gRLp9Or1L7BcZ8Tnn/6DYmdqs69UZs0ZOKoiH+P0f3GbdQ3PLqo
	k8sQe+/WTOszMVzwBea1CM26Mg1e6atGGZUzn5LgJlX+X/ZDl8xdhpzo4skRu3JmjZQxkBNSJ34
	lDMNbtGTv3wMS2Qx3R14pQVzxWr92Kg=
X-Received: by 2002:a5d:648f:0:b0:38f:277a:4eb3 with SMTP id ffacd0b85a97d-38f277a5258mr2651024f8f.8.1739457470391;
        Thu, 13 Feb 2025 06:37:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDTqe4qsYtkDP00ujYm7DVHNEfDKKsf9UNHm5PPWdZ5xhGE4IKSeM3/RqB5gJfr7CQu4AvKA==
X-Received: by 2002:a5d:648f:0:b0:38f:277a:4eb3 with SMTP id ffacd0b85a97d-38f277a5258mr2650985f8f.8.1739457469974;
        Thu, 13 Feb 2025 06:37:49 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b44a7sm2119604f8f.12.2025.02.13.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:37:49 -0800 (PST)
Message-ID: <35fe8e74229af24f45954dd27789363dd5c2f8b8.camel@redhat.com>
Subject: Re: [PATCH v6 2/3] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, aubrey.li@linux.intel.com, yu.c.chen@intel.com,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra	 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 "Paul E. McKenney"	 <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>
Date: Thu, 13 Feb 2025 15:37:47 +0100
In-Reply-To: <1a295a1e-08da-4684-81be-9539773a1c94@efficios.com>
References: <202502131405.1ba0803f-lkp@intel.com>
	 <17bda9071b6962414f61668698fa840501819172.camel@redhat.com>
	 <1a295a1e-08da-4684-81be-9539773a1c94@efficios.com>
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



On Thu, 2025-02-13 at 08:55 -0500, Mathieu Desnoyers wrote:
> On 2025-02-13 08:25, Gabriele Monaco wrote:
> > On Thu, 2025-02-13 at 14:52 +0800, kernel test robot wrote:
> > > kernel test robot noticed
> > > "WARNING:at_kernel/workqueue.c:#__queue_delayed_work" on:
> > >=20
> > > [=C2=A0=C2=A0=C2=A0 2.640924][=C2=A0=C2=A0=C2=A0 T0] ------------[ cu=
t here ]------------
> > > [ 2.641646][ T0] WARNING: CPU: 0 PID: 0 at
> > > kernel/workqueue.c:2495
> > > __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9))
> > > [=C2=A0=C2=A0=C2=A0 2.642874][=C2=A0=C2=A0=C2=A0 T0] Modules linked i=
n:
> > > [=C2=A0=C2=A0=C2=A0 2.643381][=C2=A0=C2=A0=C2=A0 T0] CPU: 0 UID: 0 PI=
D: 0 Comm: swapper Not
> > > tainted
> > > 6.14.0-rc2-00002-g287adf9e9c1f #1
> > > [=C2=A0=C2=A0=C2=A0 2.644582][=C2=A0=C2=A0=C2=A0 T0] Hardware name: Q=
EMU Standard PC (i440FX +
> > > PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > [ 2.645943][ T0] RIP: 0010:__queue_delayed_work
> > > (kernel/workqueue.c:2495 (discriminator 9))
> >=20
> > There seem to be major problems with this configuration, I'm trying
> > to
> > understand what's wrong but, for the time being, this patchset is
> > not
> > ready for inclusion.
>=20
> I think there is an issue with the order of init functions at boot.
>=20
> poking_init() calls mm_alloc(), which ends up calling mm_init().
>=20
> The WARN_ON() is about a NULL wq pointer, which I suspect happens
> if poking_init() is called before workqueue_init_early(), which
> allocates system_wq.
>=20
> Indeed, in start_kernel(), poking_init() is called before
> workqueue_init_early().
>=20
> I'm not sure what are the init order dependencies across subsystems
> here.
> There is the following order in start_kernel():
>=20
> [...]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mm_core_init();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 poking_init();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ftrace_init();
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* trace_printk can be e=
nabled here */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 early_trace_init();
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Set up the sched=
uler prior starting any interrupts (such
> as the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * timer interrupt)=
. Full topology setup happens at
> smp_init()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * time - but meanw=
hile we still have a functioning
> scheduler.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_init();
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (WARN(!irqs_disabled(=
),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Interrupts were enabled *very* early, fixin=
g
> it\n"))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 local_irq_disable();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 radix_tree_init();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maple_tree_init();
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Set up housekeep=
ing before setting up workqueues to allow
> the unbound
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue to tak=
e non-housekeeping into account.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 housekeeping_init();
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Allow workqueue =
creation and work item
> queueing/cancelling
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * early.=C2=A0 Wor=
k item execution depends on kthreads and
> starts after
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue_init()=
.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 workqueue_init_early();
> [...]
>=20
> So either we find a way to reorder this, or we make sure
> poking_init()
> does not require the workqueue.
>=20
> Thanks,
>=20
> Mathieu
>=20

Nice suggestion! That seems the culprit..

From the full dmesg of the failure I've seen there's also a problem
with disabling the delayed work synchronously, since mmdrop cannot
sleep if we are not in PREEMPT_RT.

I'm trying to come with some satisfactory solution for both, ideally:
1. the delayed work is not needed in early boot, we may have a better
place where to start it
2. we can cancel the work asynchronously on mmdrop and abort it if the
pcpu_cid is null, but it seems racy, perhaps there's a better place for
that too

Thanks,
Gabriele


