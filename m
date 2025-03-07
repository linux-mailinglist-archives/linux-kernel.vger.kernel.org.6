Return-Path: <linux-kernel+bounces-550701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503BBA5631A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1047AA19F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B21E1DF0;
	Fri,  7 Mar 2025 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0r/LtFp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E1199E94
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337967; cv=none; b=HeuSY5QxUAwrlQ/P06IcNB+qnOPL1SOI964CuMqIDuKB4uiSZkAOLOYsOkiuO+TxfvhD74arexMNNr+iIGZIS9cEjnYkZRSPrqPBSh+N/RYFOUDUp4S10qKlrxK0TFYl0dJotbwYq8UfzRXqlSkj2sJBMhwDrW5R2Xq43YogPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337967; c=relaxed/simple;
	bh=DnLQl3Ksq7Z2cxllWUtimVgS0kCffSWmdptylR8Su4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgJ6NSDxCa9P8/5SwQg63N0EEKd6cvITc/OacGJb/b0h7tZthxQjEL7G15XDu9Klo8jzuiuJvIx0dUtmoU//URol9y2ViA5yHNznpOQItzvtgHJIerbCig7wJVpYenvsnwIGAAaN+5RLISZoUOQimumZWk4bFOH6tP/MEy+6K00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0r/LtFp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741337964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fNzbo/dN/JoeBXTVjx7dS75+0FihoJ2m5H1svayNa/U=;
	b=H0r/LtFp7lYsOgf7+jbdhD3Hbkaxux8K7oFiG1B68T2x3pVB0Rpoh/0kjUp4H+vUuRwi/T
	SKXFtDNNXKQ4yuKQvnNKwy0O06YjPfJYMZ9f6JIyGqL9ADvHSPzkPUAgS4grvnQXdSmpqD
	LePOLALn7f32eBWXDBSOEPjqI1UQJnc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-z2zDNYcKM4eFkh4Uim-Iig-1; Fri, 07 Mar 2025 03:59:23 -0500
X-MC-Unique: z2zDNYcKM4eFkh4Uim-Iig-1
X-Mimecast-MFC-AGG-ID: z2zDNYcKM4eFkh4Uim-Iig_1741337963
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4751af95442so32989891cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741337963; x=1741942763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNzbo/dN/JoeBXTVjx7dS75+0FihoJ2m5H1svayNa/U=;
        b=TtKgCLEVAaD6cueNFIzaLeJ8F8KAq9bw3ZEVdOtGE0yzE4DhtacnfF5iLcMGC02Ucl
         KFos81fZXY/2AY6b55v1PZEJDfiY1E71RLKhDzs0u6wAEz71wO4mm3PKipIk5mHUa32X
         FpZj0l9ozL1ZF7f/tW4h2qUlbBREg/Yz2bf3o+pvLQYQ6P8c+BlmqsyGZ2DU+7FUEOJE
         M5fpHbHtOsjUh526E+x88lFpRmyX/HAI2pofiT0ErpyS3M8AUx9Lm85DrbmuCOxyu7lX
         u3bmol0pN4JFy6uddr575QPacJrKGqWcrBzi6KW2KQn0i9SszHeCKJbUKixRrT5Dp2Uj
         ajBw==
X-Gm-Message-State: AOJu0YzDr2IPhFwqGS6oiEiutURsqlPWbe41hPDeicAgWCsugTamxAiK
	s84OmXvvkBir9lH4+veu5t3t3ZzSAfF8oU4ALSfNOl1YZWtO73uAHvd44g2b5fxFMQwLRNcJzqU
	zVwdtHn3oXt5SpSPebdVk1JVdWnRBgQ94eXBSzZXcY3T+vxvNjldwyFPc8gp+Pg==
X-Gm-Gg: ASbGnct5YejrzGmkBwjo+R46rKFMKfqHwOSawVOy26185bf89GS8dJvE1wy1G+SwBWC
	5szssWmjln61Y6x0AhdmkonNJLpWQ4zGwAtBWjJgvpBHl2ylm6nFVYCZ9fcwlAt+oa7sIhtg5UF
	uPC6M3koK0nVOr6OECa34n2kXPv2nSaAtqpfeOGtDCuOrfJAa0TQXnku7EMCeFvAfUpyj/IUEZ/
	4fb436PhagX7cIGQvMUNxoHxxP/YMtyDenUGag/JNppczZm2N43OmCZYUpFwXJBWKRsNqIxFZyh
	rz4QJ6MBBeMRqJo1EFi833e7KYhwYQENTMlUWMotiIKujQLTa+wuNsGF5cj2FOkXDlOBokZfmMY
	GLeS+
X-Received: by 2002:ac8:7f42:0:b0:471:fde4:f0ae with SMTP id d75a77b69052e-476189e8118mr29380241cf.36.1741337963210;
        Fri, 07 Mar 2025 00:59:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq0N4B7njPtAmPXmTzn2vvYLdOcpPjQWYIsJ8Snozrqg1T6MF5pIGRzPtQzrAvPBv5qyU+Fg==
X-Received: by 2002:ac8:7f42:0:b0:471:fde4:f0ae with SMTP id d75a77b69052e-476189e8118mr29380101cf.36.1741337962968;
        Fri, 07 Mar 2025 00:59:22 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d96f378sm18205061cf.30.2025.03.07.00.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:59:22 -0800 (PST)
Date: Fri, 7 Mar 2025 08:59:17 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 4/8] sched/deadline: Rebuild root domain accounting
 after every update
Message-ID: <Z8q1ZdJEjOEkhEt2@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-5-juri.lelli@redhat.com>
 <295680e1-ba91-4019-9b7f-e8efd75d7f13@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295680e1-ba91-4019-9b7f-e8efd75d7f13@linux.ibm.com>

On 07/03/25 13:02, Shrikanth Hegde wrote:
> 
> 
> On 3/6/25 19:40, Juri Lelli wrote:
> > Rebuilding of root domains accounting information (total_bw) is
> > currently broken on some cases, e.g. suspend/resume on aarch64. Problem
> > is that the way we keep track of domain changes and try to add bandwidth
> > back is convoluted and fragile.
> > 
> > Fix it by simplify things by making sure bandwidth accounting is cleared
> > and completely restored after root domains changes (after root domains
> > are again stable).
> > 
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

...

> > @@ -965,11 +967,12 @@ static void dl_rebuild_rd_accounting(void)
> >   	rcu_read_lock();
> > -	/*
> > -	 * Clear default root domain DL accounting, it will be computed again
> > -	 * if a task belongs to it.
> > -	 */
> > -	dl_clear_root_domain(&def_root_domain);
> > +	for_each_possible_cpu(cpu) {
> > +		if (dl_bw_visited(cpu, cookie))
> > +			continue;
> > +
> > +		dl_clear_root_domain_cpu(cpu);
> > +	}
> 
> This will clear all possible root domains bandwidth and rebuild it.
> 
> For an online CPUs, the fair server bandwidth is added i think in
> rq_attach_root. But for an offline CPUs the sched domains wont be rebuilt.
> It may not be an issue. but the def_root_domain's bw may be different
> afterwords. no?

dl_clear_root_domain() actually adds DL servers contribution back on
their domains (dynamic and def) and we want to keep offline CPUs DL
server contribution not accounted for until they come back online and
the domains are rebuilt.

Thanks,
Juri


