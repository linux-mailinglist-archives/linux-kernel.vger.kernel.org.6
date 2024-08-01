Return-Path: <linux-kernel+bounces-271390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFA6944D88
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BAA284DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9526A1A3BD4;
	Thu,  1 Aug 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+HWMSz1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264D1A0725
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520752; cv=none; b=X5abCrblkrORw2zzHUrzfRAcek2PzZJdTihqsFr4O9wYNHNstVALKC2KjtvJ6qNkRsuBnRK5KyyCLgg+AGOVaoosE8y2NR4Bmbcr2p8qO66YvjnhTFNyeAKoTQ0qbZEuQZwETtygXdXF9TBuCoEzyHirsiOwLiHvSNI9tIwS6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520752; c=relaxed/simple;
	bh=MpNMcGFJ5X/GwjRYuU61MJgNlI8OH/7MgAUOA9PeOLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezR2uVBJA6Q+ULkzbOZEfgOKSSm39em4+6zVxNaRMFYQyu4zROdXO0TvU5q5mQFDosqa7NjhEsz87SA3W52byNTzGcVfjUu9SCt6NoHxfnahgwt5TPwGrE6yU22X/dYLaeVvtch9sQlURbsLTOCAKG8uowXneMVcLG/5pQQCKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+HWMSz1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722520748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpNMcGFJ5X/GwjRYuU61MJgNlI8OH/7MgAUOA9PeOLc=;
	b=X+HWMSz1FsYj1AL1HHeRDN/r0FSlalYF0rQUG8Sk5T0pm8PWnt1m99iohvRE20nMHJedC6
	nPRwqJW4jdASifjlj0trDc8fHNt8IFRB/y9aQTmtZ9YOPBabW0dHQ+mucutaScWXsQ40r6
	4G+eHMCloOvQlW0UKfHvRRC2bd/asWQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-JMTiKpvCMY2YDExVGLVEwQ-1; Thu,
 01 Aug 2024 09:59:07 -0400
X-MC-Unique: JMTiKpvCMY2YDExVGLVEwQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B20571955D52;
	Thu,  1 Aug 2024 13:59:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7B53B1955D42;
	Thu,  1 Aug 2024 13:59:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:59:05 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:59:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240801135900.GD4038@redhat.com>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240731145132.GC16718@redhat.com>
 <20240801-report-strukturiert-48470c1ac4e8@brauner>
 <20240801080120.GA4038@redhat.com>
 <20240801-clever-mitleid-da9b4142edde@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-clever-mitleid-da9b4142edde@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/01, Christian Brauner wrote:
>
> On Thu, Aug 01, 2024 at 10:01:20AM GMT, Oleg Nesterov wrote:
> > OK, I won't argue, but ....
> >
> > > you may or may not get notified
> > > via poll when a kthread exits.
> >
> > Why? the exiting kthread should not differ in this respect?
>
> Why do you want to allow it?

Again, I didn't try to "nack" your patch. Just tried to understand
your motivation.

And "may not get notified" above doesn't look right to me...

> > /proc/$pid/status has a "Kthread" field...
>
> Going forward, I don't want to force people to parse basic stuff out of
> procfs. Ideally, they'll be able to mostly rely on pidfd operations
> only.

Agreed.

Oleg.


