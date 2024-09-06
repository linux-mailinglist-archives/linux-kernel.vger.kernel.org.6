Return-Path: <linux-kernel+bounces-318764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC3096F2FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B601C234B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E61CB319;
	Fri,  6 Sep 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3Ty7zU4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA62233B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621882; cv=none; b=rb53fvwhdyVWm85bc27hrrITO9RwzVWATWizcSBYE7E6EGurbwh54eUeL5NO4cantAqslTKImkFCgQ3oJldv0voIbP9jDQcf/T3zC+BgQRNK/Vlw0K1SMBmesDAARfvGUFELhbClMtEA2F1VSIjQZF2dfRLQLty6Uzl9xcQF4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621882; c=relaxed/simple;
	bh=3Ufl/3mWoFm4+5k0to8mapiQOc9KkLb2U6Bz95TlxUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4DedY9jR0U6+46qfWhTluhtz6oQQy7p3dIAUEKWg6iyMrNsCCDXj+dMWr5Nny/pkuHjZY3dcDmoapmxr7n6GRr5DMnYccSHPzR38CiT9iCu/LnOhOTyEzIJ0HdCCiNAXTZvNza9uEtkT7Qmu/kLhoQYMUT4DEds0b+rKYTRF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3Ty7zU4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eysmM2GxvsFnUbEGNgAB4tNvEDMGL4waMBASTYBY7EU=;
	b=h3Ty7zU43QHx6o7iL34igxRb2Idya2H6odV1gHgP67AAmcilKUkgFBbbeojM4RmHHrQRGX
	Feakk/FtKA+m0D2D+xSvzMnoGuRPNeejjgHDPtcipgFdAneFVLLMZP3NQctZrslb4e3gHu
	qYGcGFNgR47/UkJ+kE7cAJbQabci6us=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-TTHnnhLsN3qbI5scpRN9gA-1; Fri,
 06 Sep 2024 07:24:34 -0400
X-MC-Unique: TTHnnhLsN3qbI5scpRN9gA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FA5F19560B4;
	Fri,  6 Sep 2024 11:24:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.74])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9560F3000238;
	Fri,  6 Sep 2024 11:24:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  6 Sep 2024 13:24:21 +0200 (CEST)
Date: Fri, 6 Sep 2024 13:24:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Roman Kisel <romank@linux.microsoft.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
Message-ID: <20240906112345.GA17874@redhat.com>
References: <20240905212741.143626-1-romank@linux.microsoft.com>
 <20240905212741.143626-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905212741.143626-2-romank@linux.microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add cc's. Perhaps someone else can ack/nack the intent...

This (trivial) patch is obviously buggy, but fixable. I won't argue
if it can help userspace.

On 09/05, Roman Kisel wrote:
>
> For debugging, it might be useful to run the debug trap
> instruction to break into the debugger. To detect the debugger
> presence, the kernel provides the `/proc/self/status` pseudo-file
> that needs to be searched for the "TracerPid:" string.
>
> Provide a prctl command that returns the PID of the tracer if any.

prctl?

> That allows for much simpler logic in the user land, and makes it
> possible to detect tracer presence even if PROC_FS is not enabled.

You should probably move the links from 0/1 to the changelog to make
it more convincing.

> +	if (request == PTRACE_TRACER) {
> +		rcu_read_lock();
> +		tracer = ptrace_parent(current);
> +		ret = tracer ? task_pid_nr_ns(tracer,
> +					task_active_pid_ns(current->parent)) : -ESRCH;

The namespace is wrong, we need task_active_pid_ns(current). So this
code should simply do task_tgid_vnr(tracer) like sys_getppid() does.
And to me it would be better to return 0 if !current->ptrace.

> +		rcu_read_unlock();
> +		goto out;

Wrong, this code runs after "child = find_get_task_by_vpid(pid);" above.

And why? perhaps the intent was to check if this child is traced, not
current?

Oleg.


