Return-Path: <linux-kernel+bounces-352539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC5C99207E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8029E1C20C17
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED218A6B8;
	Sun,  6 Oct 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8pCXCLc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3941320B
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728240963; cv=none; b=TEXHanBUGI/ME6A9k9hbs/ZiKqVIaOJSm5P3MMMgDmixvnBYne317m6l0kALOHAj+nSwwsCk3BCqp0g4IjXk5e96kfdmNsoalVVosnD7VpeBZ+dxfOksQOjvw24UHZCjJDGTk2oSE/qm78Y+3q8sc86DdYEXGG2gQcy9Yf7A84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728240963; c=relaxed/simple;
	bh=8GYshRdGxggO/jffQP59mrphoxqHR5TBXZyAXmxKLWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVVBAt4zICBXXZCaO5KqG11vDaunLiBHF2aFPCcqX5bVs9EujV8OaXEOBlMRgTNUkvSFxNZ3cE+VF/duvdWVSTQp8Y9U/a0anyod0iT+CrFjgEryzyZINgSYmYWhqzbSId6WRRHvxwpSyQnGfGcWrZdMsV4oKlVw4i+S4iXbulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8pCXCLc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728240960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GYshRdGxggO/jffQP59mrphoxqHR5TBXZyAXmxKLWc=;
	b=c8pCXCLcIRjDMM0/lt2G92p9az1cCH+KGU+mMiPzZ98tgED8UJ6MhCXJIFnHOAz4t8qTZu
	n/tRabusJUz5CtZPTYuBbuk61w3cl+oBvIWN5vDsJyebTbJs19MCPFve6N2+ahTy+pJMDg
	uFPie0iu8aoMfKjl+tzvU8Qgbje8v4o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-8A1ChGNLPLuzf7NpDvs0_w-1; Sun,
 06 Oct 2024 14:55:56 -0400
X-MC-Unique: 8A1ChGNLPLuzf7NpDvs0_w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F538195FE1A;
	Sun,  6 Oct 2024 18:55:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.57])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8EDB41956088;
	Sun,  6 Oct 2024 18:55:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  6 Oct 2024 20:55:41 +0200 (CEST)
Date: Sun, 6 Oct 2024 20:55:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: linux-kernel@vger.kernel.org, christian@brauner.io
Subject: Re: [PATCH v5] pidfd: add ioctl to retrieve pid info
Message-ID: <20241006185537.GC10213@redhat.com>
References: <20241006145727.291401-1-luca.boccassi@gmail.com>
 <20241006172158.GA10213@redhat.com>
 <CAMw=ZnS1GTC9RGQCeTqB8g2b78mFXi4zLfg6bumrp+zmgx0VXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnS1GTC9RGQCeTqB8g2b78mFXi4zLfg6bumrp+zmgx0VXg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 10/06, Luca Boccassi wrote:
>
> I see, so what should I do here then? Check both? Or none?

I don't know, because I don't know how are you going to use this API.

> The caller
> needs to verify that the data is still valid at the point they use it
> anyway,

So "none" should work fine? Just it should be documented that, say,
kinfo.pid can be 0 if we race with the exiting task.

Just in case, you can also use lock_task_sighand() || return -ESRCH,
this way kinfo.*pid can't be zero. But I don't think this will buy too
much, the task can exit right after pidfd_info() returns.

Oleg.


