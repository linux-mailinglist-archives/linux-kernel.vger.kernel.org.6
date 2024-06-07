Return-Path: <linux-kernel+bounces-205453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3868FFC39
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7737A287C22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36311150985;
	Fri,  7 Jun 2024 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSJxb+Xw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088E14F118
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741644; cv=none; b=nEV4FevTUnJKXVkLbxNbXPvWqqFLUcn6VR4od/6fZ+lBoyXAPUjNmaqIhEA8rMyhqnx8XhpCNWRa6d56s6PLuNPUY/UObaCKqe/+1sCMGjlPvPe1qZVb/wdqp+P+NxEPNvKkVE7j03Z/3Af0kFaatIdWsxyx9G80gJdnNtTQ4HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741644; c=relaxed/simple;
	bh=7l34DuoF32Wc8jfFzmRvwBR/sGpFa36t+jZFou8s5R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZp0Q/hbnwoYO9joViFMlBEXum1qt5nRFNyX2cnoZmm2Tzv7dkxTI3jNpjQPwGhqqKKmPwYXFn0wKtzK6bh3+Uwa6rdtgoLvVmsHHoNzZG4Zaa1coMZ53y0MgQR6KKy2Z2kmu+UHc/wR1lQhsTKdHU9IWgaZb1qfBhAP8R6465g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSJxb+Xw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717741642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7l34DuoF32Wc8jfFzmRvwBR/sGpFa36t+jZFou8s5R8=;
	b=MSJxb+Xw6JY/7eaMlgB27fmVutflhMwm2W8xdzgoi/yIUDZRj4pXwYQat31xcSjVue7W9l
	cV3RRVhMb1r0hFW1STnYs3//W9TaJKk5UVq3HMNdJwKqAipby6lKCZPa1WfiowxOfa9Tij
	0lWb8FE+6ACSAdLzjNrEy2vR7a5YUhA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-toa5buPyNVOv6pbV-lg_ng-1; Fri,
 07 Jun 2024 02:27:15 -0400
X-MC-Unique: toa5buPyNVOv6pbV-lg_ng-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E06D193586D;
	Fri,  7 Jun 2024 06:27:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2AC4D1955F14;
	Fri,  7 Jun 2024 06:27:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  7 Jun 2024 08:25:41 +0200 (CEST)
Date: Fri, 7 Jun 2024 08:25:31 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Wei Fu <fuweid89@gmail.com>
Cc: Sudhanva.Huruli@microsoft.com, akpm@linux-foundation.org,
	apais@linux.microsoft.com, axboe@kernel.dk, boqun.feng@gmail.com,
	brauner@kernel.org, ebiederm@xmission.com, frederic@kernel.org,
	j.granados@samsung.com, jiangshanlai@gmail.com,
	joel@joelfernandes.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	michael.christie@oracle.com, mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org, paulmck@kernel.org,
	qiang.zhang1211@gmail.com, rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org, rostedt@goodmis.org, weifu@microsoft.com
Subject: Re: [RCU] zombie task hung in synchronize_rcu_expedited
Message-ID: <20240607062531.GA30954@redhat.com>
References: <20240606172848.GC22450@redhat.com>
 <20240607030219.2990306-1-fuweid89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607030219.2990306-1-fuweid89@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Thanks for this info,

On 06/07, Wei Fu wrote:
>
> All the kernels disable CONFIG_PREEMPT and PREEMPT_RCU.

Ah, this can explain both soft-lockup and synchronize_rcu() hang. If my theory
is correct.

Can you try the patch I sent?

Oleg.


