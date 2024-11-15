Return-Path: <linux-kernel+bounces-411315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DABF9CF614
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0E21F21D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7021F1D5CF1;
	Fri, 15 Nov 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjV/O4UL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D7C1D79B6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702346; cv=none; b=JETQV0mln0Ng+9YjCNkVmDvLOVtcrQYgBmwwvXrjO8oJwNfzG0R1qFVn17oG5ukej/CT1qYOyuWHg9TW1ZnqUZ3Q54D0S6vafUBq6C2fm8vV5JkeTmQxipi2rxI81XDGPM1RhmPLmlH6bcSYav6Tq8J9hiyTLzqxOPLITntyDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702346; c=relaxed/simple;
	bh=vzB88Ab0K9g7gx/HZQf5Qt3upMzQRUJK5J17p+p5qss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIe+QWdZQERcAgwcJzMs2QYpr8BztLCPdBoeO/6oCfGuT6bDZ6ulfDVqGx67cDd4xLjRM1wB5cXndoXhulp0kSwkqBhI+D7ipjzwLtc6Jhl2yOVKAgGwa5OBAB5o8f9QQiezu45y51NWBc3i/QW5tNDhSsK1FqsKN2MLG8TVQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjV/O4UL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731702344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNLrlgsuyCSQO136ZlOgDlHV4KMR1L8gzLEmcIW3BjM=;
	b=UjV/O4ULn/idPIrUfunUQExglOjVT2mvMVdD/UGCx9wJ1KeBZHOkLNczn26EwMhfao+RGQ
	19KDRL5f2GBny0vlNiVWXW/RSBxQ4L7W1grxAhCscZpO+EjbZwV/3ydY4y3zu1nLGSC7+9
	Se0BoRfJeDns0Q6ky7Ky4c94PPOGync=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-neDtoD72P-WmHpGWsDI80Q-1; Fri, 15 Nov 2024 15:25:42 -0500
X-MC-Unique: neDtoD72P-WmHpGWsDI80Q-1
X-Mimecast-MFC-AGG-ID: neDtoD72P-WmHpGWsDI80Q
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-288de8b3be2so25000fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731702342; x=1732307142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNLrlgsuyCSQO136ZlOgDlHV4KMR1L8gzLEmcIW3BjM=;
        b=RiBuMTQKDc7MBDSkJz0S1NAMXfJjFxdKR0y44ZCsD8CALfzG66NmYIFv5Cc0cZ8coN
         cbq+2Ag9IBoR1HkFlRgWnQarz0oQF65iMQXEFMdkk/YOj2KwA+HDtCYT59o2HCicV3Xf
         aEIuto6KER/FzkWVMlxLZ0sWlatTbSd0R//6TEAQvAYdQHI3vPH49akex95pWmlHIIF8
         KAEFEh9gAT94BOzKEBQCDo2slRTvbWyhLEMOqiTlW2HxKoNMdCbHRs+qWDRnBLJ8ujXZ
         4YhkuKlzeCcOUEH7TiY+m8aH+Hzc2nXdYPSktxcjYS6SBa0ziFr78n56VEmbh2/R3mgf
         cahA==
X-Forwarded-Encrypted: i=1; AJvYcCVsb0VCzoYRAhVrq8iVY6PwJsFw5N4hq5it0E3bnrn7M4FbHckuBuCDi6PBshGCEjjhXUQJgv41veodDIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw226x8Sk/1zZ7rsdJJcMOxRUlERkVdHT0Zmu6WpTYLJ0ceAUdS
	A9kBKVNTj9ZVSZo7GobOjJiwVIbOyy2bqEGz0YQt2VFc5LEbSia9JKTJ03dnmFJTws7T+GQfX9g
	uWUPJv8l3ggmEEjRbuirCZ4aTblEOU0PWe/fDT1OBaHI2rc5VsEyHXlud9cpI3ahRUicYoRCtdN
	jtnbxVaHzloJJ45pzoSSazxszfv+HfqXLbXk2j
X-Received: by 2002:a05:6871:e085:b0:295:91a0:af1 with SMTP id 586e51a60fabf-2962de09fa0mr4330108fac.19.1731702342161;
        Fri, 15 Nov 2024 12:25:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHprnkP4mcnKY9AIEZogy1RG7ERmEnfoV7JX0QKAbhQCgxNP7EEumthj14YA/khDgoSXi5sWHjd6wPh6Z6kCCs=
X-Received: by 2002:a05:6871:e085:b0:295:91a0:af1 with SMTP id
 586e51a60fabf-2962de09fa0mr4330087fac.19.1731702341911; Fri, 15 Nov 2024
 12:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108054831.2094883-3-costa.shul@redhat.com> <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
In-Reply-To: <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Fri, 15 Nov 2024 22:25:05 +0200
Message-ID: <CADDUTFwYKjbPnzdzQA0ZjW4w3pHBsoZBQ6Ua5QbFp=X2-GfGtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>, Waiman Long <longman@redhat.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Michal.

Isolation of CPUs from blk_mq_hw_ctx during boot is already handled on
call hierarchy:
...
        nvme_probe()
                nvme_alloc_admin_tag_set()
                        blk_mq_alloc_queue()
                                blk_mq_init_allocated_queue()
                                        blk_mq_map_swqueue()

blk_mq_map_swqueue() performs:
for_each_cpu(cpu, hctx->cpumask) {
        if (cpu_is_isolated(cpu))
                cpumask_clear_cpu(cpu, hctx->cpumask);
}

static inline bool cpu_is_isolated(int cpu)
{
        return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
                !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
               cpuset_cpu_is_isolated(cpu);
}

cpu_is_isolated() is introduced by  3232e7aad11e5.

Thanks,
Costa


On Fri, 15 Nov 2024 at 17:45, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> On Fri, Nov 08, 2024 at 07:48:30AM GMT, Costa Shulyupin <costa.shul@redha=
t.com> wrote:
> > Cgroups allow configuring isolated_cpus at runtime.
> > However, blk-mq may still use managed interrupts on the
> > newly isolated CPUs.
> >
> > Rebuild hctx->cpumask considering isolated CPUs to avoid
> > managed interrupts on those CPUs and reclaim non-isolated ones.
> >
> > The patch is based on
> > isolation: Exclude dynamically isolated CPUs from housekeeping masks:
> > https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com=
/
>
> Even based on that this seems incomplete to me the CPUs that are part of
> isolcpus mask on boot time won't be excluded from this?
> IOW, isolating CPUs from blk_mq_hw_ctx would only be possible via cpuset
> but not "statically" throught the cmdline option, or would it?
>
> Thanks,
> Michal
>
> (-Cc: lizefan.x@bytedance.com)


