Return-Path: <linux-kernel+bounces-321789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B996C971F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D661F234CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B40166F07;
	Mon,  9 Sep 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4GHBLUG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922B1487E2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900198; cv=none; b=HoehxRQfTNlp1mYGFfMkCgALBvDQc/WRUMH7bEQkDHuaghIYAwM2wgbMDpNDLM3prW7Tq9EimKHodidSvrtXEx4mCo0+yWT/oz3c/lHu6XmxTj4dsRCrErbJ7hybO6ggsKR8poL+LOkhIvscfps6tkozdqN2wPULBwXfBU1tQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900198; c=relaxed/simple;
	bh=S1kbf0phCb48MWSXgkXfEpcXC/gNa49fODrt+nrAW0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXhHvAgRtImJ1gIOVRaYrR8pGBnz3mdv/BZrSZD6+njjYPk9QPaZMes6R/2c03zfxaxub9xn5ipa8Lam274sX4PCKgjE1tBOXl3/m2RwhvJ2Jn+cCS8Y3JTtU5MS0J5PfdqiGrVqokPUkiMoor/fBVqamsGQoOkYFw+/Z6p/Rsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4GHBLUG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725900196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbH/T4X4Z14PtQAR2gn/t9qdJNLYFFSA99p6UVt3HUg=;
	b=J4GHBLUGRs1sKIHFpuQTdJ+TIHW0AiXnH50vRC+KjJgy0BNSmlrCHdJJqQSSrthtv8QhuU
	RCgmM8AuvuZsCTbqKFh2I+lS+28nX03huLZSQIv4EgfdxdlBZ3+aFyzlio7BwwvZT59UH6
	yuaEsKS/1PzzjrqveZI9uuMcxr2X5To=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-wC5ljZ1JN2mAG-1VWczGWw-1; Mon,
 09 Sep 2024 12:43:10 -0400
X-MC-Unique: wC5ljZ1JN2mAG-1VWczGWw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3C3A19560BF;
	Mon,  9 Sep 2024 16:43:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 98AA71956048;
	Mon,  9 Sep 2024 16:43:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  9 Sep 2024 18:42:57 +0200 (CEST)
Date: Mon, 9 Sep 2024 18:42:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: akpm@linux-foundation.org, apais@microsoft.com, benhill@microsoft.com,
	ebiederm@xmission.com, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com, sunilmut@microsoft.com,
	torvalds@linux-foundation.org, vdso@hexbites.dev
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
Message-ID: <20240909164251.GA14058@redhat.com>
References: <20240908140838.GB21236@redhat.com>
 <20240909151946.1108962-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909151946.1108962-1-romank@linux.microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/09, Roman Kisel wrote:
>
> On 9/8/2024, Oleg Nesterov wrote:
>
> > But you can safely ignore me, I do not pretend I understand the userspace's
> > needs.
> >
> > And I guess people will use it anyway, so I won't argue with, say, a trivial
> > patch which just adds
> >
> > case PR_GET_PTRACED:
> >     error = !!current->ptrace;
> >     break;
> >
> > into sys_prctl(), even if I agree that this probably just makes bad behavior
> > easier.
>
> Very kind of you trying to build a longer table rather than a taller fence,
> I appreciate that very much! Your aproach looks very neat indeed,

Well, you didn't answer my question in
https://lore.kernel.org/all/20240906114819.GA20831@redhat.com/
so I decided that a simpler change which returns !!current->ptrace instead
of the tracer's pid might work as well.

Sorry for annoying you.

Oleg.


