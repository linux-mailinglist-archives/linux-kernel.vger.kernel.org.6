Return-Path: <linux-kernel+bounces-352775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B919923FF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CF41C221AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656B5137C2A;
	Mon,  7 Oct 2024 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2OJ1DkX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A43A8F0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 05:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280319; cv=none; b=jY3TKX4AsY9h7bxe8LADPaOS318lEPDc4YBW1NlPzKdv/gveuM2zhiabk29E38+JmaCARJBdEUiqC2BGgHhKWdchLi3qhUG2U2r179mwvisF+UwPO1f9JGvYJgqKzgP+qU0WV2r/O89k4uSOIVNxwuAhDiuuQpVlbIhCUhA82IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280319; c=relaxed/simple;
	bh=KnK1uYeoVhEFgeupnHXOaf+ewp2gQYADBOPrGi9YkkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyUZ9dJY9cPiHgkkdlsIp5Dbnjzr9o6Xk5XFle7+4wEJNyrjERFfPp5r6J8QuUZFezY6aFbzj+/OuHn9zSgPulF1vVQdIOKy9aG52eTY92j0kvxRpCWQa8E+UEpvYjLqe1ghp1dn+A8YFQTywA+1CqafSS46JaaxflkVI+F3dg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2OJ1DkX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728280316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dvm3GNeRuIppyqIEdTTo+CSZWlYOZQhpICoceJ5OpV0=;
	b=C2OJ1DkX3u9TL3Hp2TOTWtaS/LnXSYYVN5xbZwVd8XVLvmXzg19mzLTWjAkbwvAzCd6OuT
	tM11ruZ4LPpDC/pRXqOH/+w5QLXyOwvzxPedk3ONSoB4fQksa5+csle5zZ7KJeD9eg1wW5
	R6dEuQIBL2H//ROsmFZ48O2T3SI4nzE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-uwXf7DpTOAuNFv7x6_aqpQ-1; Mon,
 07 Oct 2024 01:51:52 -0400
X-MC-Unique: uwXf7DpTOAuNFv7x6_aqpQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B055193316A;
	Mon,  7 Oct 2024 05:51:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.80])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5D8C21956089;
	Mon,  7 Oct 2024 05:51:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  7 Oct 2024 07:51:37 +0200 (CEST)
Date: Mon, 7 Oct 2024 07:51:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: luca.boccassi@gmail.com
Cc: linux-kernel@vger.kernel.org, christian@brauner.io
Subject: Re: [PATCH v6] pidfd: add ioctl to retrieve pid info
Message-ID: <20241007055133.GA1333@redhat.com>
References: <20241006213530.335087-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006213530.335087-1-luca.boccassi@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 10/06, luca.boccassi@gmail.com wrote:
>
> +#ifdef CONFIG_CGROUPS
> +	if (request_mask & PIDFD_INFO_CGROUPID) {
> +		rcu_read_lock();
> +		struct cgroup *cgrp = task_cgroup(task, pids_cgrp_id);
> +		if (!cgrp)
> +			return -ENODEV;

return without rcu_read_unlock().

And iirc this is against the coding style, "struct cgroup *cgrp" should
be declared at the start of block.

Oleg.


