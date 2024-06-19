Return-Path: <linux-kernel+bounces-221705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C227C90F779
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ADD1F23AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5678477F10;
	Wed, 19 Jun 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KK0RTG31"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46333FC0C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718828430; cv=none; b=IFa+vz//e3gguRjSSLxB+/9W7WLAsMYuTekiw/FjGQOzRvWUNVP45POpJqFeKh+CQ7akFLE8dk1Hj0rrPfR4V2s6uGa7lETc7ou3fTdA6X9iSGjazj2Gj04VlkL6+g/enxPVgIQbFiwQXXEAcG4zeuugqXgrOhoMCWsxd/OMKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718828430; c=relaxed/simple;
	bh=KSnatOZ2XEJu7l7htYBwpHhuBu8rEROA4E7OCUYQtWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0FZh0gh/aky3OIZamnw4c6QgvQ2JIIHa/y5gu++7ydok6avxbgan2NHPaNmdq4NEieRDms6iHvrqzGwBUqVCXj6970LI6G2WklB1cu7dy6+nkg7jYpXm2djTNUZP8nHUjC86R5OQOeJrFlrxpddh30+C0IH1yVQtqWD4zAwN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KK0RTG31; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718828428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSnatOZ2XEJu7l7htYBwpHhuBu8rEROA4E7OCUYQtWI=;
	b=KK0RTG31KtXdAfb3quQW1OpSd9v8sAfYKOcYwYrNhca+oK75V8r9N5bVlGgp5c7MhrBctt
	D5sVp/iTzSfAzWklgdvl6fuIzBp5yLkTXN/8hmrGq/1B375J3HeOa2uDlhWjoj6+HLO9YJ
	dfrI7sFn9Rs6a1FPLpipXJs65DNwX2Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-xLa85BRuOLS4o_ggPO3yeA-1; Wed,
 19 Jun 2024 16:20:23 -0400
X-MC-Unique: xLa85BRuOLS4o_ggPO3yeA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 404E619560AF;
	Wed, 19 Jun 2024 20:20:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.168])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 89CE43000225;
	Wed, 19 Jun 2024 20:20:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Jun 2024 22:18:50 +0200 (CEST)
Date: Wed, 19 Jun 2024 22:18:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] exit: kill signal_struct->quick_threads
Message-ID: <20240619201847.GG24240@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
 <20240613154541.GD18218@redhat.com>
 <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
 <20240617183758.GB10753@redhat.com>
 <87iky5k2yi.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iky5k2yi.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/18, Eric W. Biederman wrote:
>

... snip the parts I don't really understand so far ;) ...

> The patchset should be be good enough to answer what I think needs to
> happen with quick_threads.

OK. as I said I'll _try_ to understand it in a few days.

> I also remember that the cgroup iterators where somewhat hopeless when
> there were zombie thread group leaders.

What do you mean?

Just in case, we have c03cd7738a83b but it seems you mean something else?

Oleg.


