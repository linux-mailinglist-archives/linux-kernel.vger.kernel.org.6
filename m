Return-Path: <linux-kernel+bounces-568639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B953CA698BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB968A40A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34145211710;
	Wed, 19 Mar 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L38+APyc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2B1CAA81
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411433; cv=none; b=FOFuUvboMLeJ92ueQ4Wq1G9GTRJQOurRH6U6Dwpx6Dm7vp8lKy6xIZOr2cfN6aSUAUXKGNbhoNSwKdbtcpocd38qiJZoYew2widnSpYA2w64aY5bWUhGJEsLoYlqYbsE7rxYhRb1hAoxYuQ22EPgBveA8oMMMrfz9kBFLizB5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411433; c=relaxed/simple;
	bh=0LIFQzQzWNUueswDhxo0s4V+5g06LIM0p6kAe3mcPFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdtMctPEhzaIeZK2KU3EgwL3SwIRwfmm2n9jDCVHNJGtqblknOMV8YJ+FAckYyc966UwHg5z3QlTul5dwvU9vKEy4dqqwYBaJcTdZ6WWwA658qpPVL6Ini0cW027n2ULXSvAn6X9yAeVBGg3VEjIw0/kP28IpDTIGKHklxCltYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L38+APyc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742411430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8Y7Sc62JSldNPcufsG+fYEDr2XeBdcbp9N4UXv3/VY=;
	b=L38+APyci9wk7Dinegfn8f5gwk+4419wjoqOT5AuYQBjC1eREkNLEATWxCY4lb85oeSInl
	HlNJ+6SvvSJQDy9ka0y8Qa2ZhOsulKxnNwrRnVVM82yOTjfGzHCi1hbVmYBD0NHNUiuizw
	CA+3tC8oiDra9M2gzETWaaV2ArnX6/4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-R4CCP6bmNA2INuNS9or1Kg-1; Wed,
 19 Mar 2025 15:10:27 -0400
X-MC-Unique: R4CCP6bmNA2INuNS9or1Kg-1
X-Mimecast-MFC-AGG-ID: R4CCP6bmNA2INuNS9or1Kg_1742411426
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B5C71809CA3;
	Wed, 19 Mar 2025 19:10:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9429918001F6;
	Wed, 19 Mar 2025 19:10:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Mar 2025 20:09:53 +0100 (CET)
Date: Wed, 19 Mar 2025 20:09:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exit: combine work under lock in
 synchronize_group_exit() and coredump_task_exit()
Message-ID: <20250319190950.GF26879@redhat.com>
References: <20250319185433.1859030-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319185433.1859030-1-mjguzik@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/19, Mateusz Guzik wrote:
>
> +	spin_lock_irq(&sighand->siglock);
> +	synchronize_group_exit(tsk, code);
> +	core_state = coredump_task_exit_prep(tsk);
> +	spin_unlock_irq(&sighand->siglock);

Well, but why do we need the new (and trivial) coredump_task_exit_prep?

Can't synchronize_group_exit() be

	static struct core_state *synchronize_group_exit(struct task_struct *tsk, long code)
	{
		struct sighand_struct *sighand = tsk->sighand;
		struct signal_struct *signal = tsk->signal;
		struct core_state *core_state = NULL;

		spin_lock_irq(&sighand->siglock);
		signal->quick_threads--;
		if ((signal->quick_threads == 0) &&
		    !(signal->flags & SIGNAL_GROUP_EXIT)) {
			signal->flags = SIGNAL_GROUP_EXIT;
			signal->group_exit_code = code;
			signal->group_stop_count = 0;
		}
		/*
		 * Serialize with any possible pending coredump.
		 * We must hold siglock around checking core_state
		 * and setting PF_POSTCOREDUMP.  The core-inducing thread
		 * will increment ->nr_threads for each thread in the
		 * group without PF_POSTCOREDUMP set.
		 */
		tsk->flags |= PF_POSTCOREDUMP;
		core_state = tsk->signal->core_state;
		spin_unlock_irq(&sighand->siglock);

		return core_state;
	}

?

No need to shift spin_lock_irq(siglock) from synchronize_group_exit() to do_exit(),
no need to rename coredump_task_exit...

Oleg.


