Return-Path: <linux-kernel+bounces-548932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE8AA54B01
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D3C3AEC5E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB86520C488;
	Thu,  6 Mar 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7b6r05G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2D20C463
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264929; cv=none; b=h2qCBtcg5Z+hj6dByz/fBfLBCLyWJ6z7pWOn2TTVGw4dZRgm5PfM67dxnsvp7lSdL8MTqkmroE29+mpvrDm9gGzh+FIyEERUTeuW6yJizq0agyz1caubX7qpu709LWXW1Dn1WIGDf1LCIkZClYTTzkg7yw8OEwUUQCdeIhgBmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264929; c=relaxed/simple;
	bh=eP1g9nlyYI9CoKkIY1xPDI2Sac0aG/68toWY/f4XmOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX00Sg7QKJ2hSsdyX9CWhT5dtlvqwGn5LK35++013DbuivAGcNjqzJVecQ+4KwVG/RNUerLxZHuT2DyyowexhOPaCODG8K+r3AAxmsisyEKmQCF6c7ex8JlX1WscbKnve0Zu8iROx67Kdlwe/pG0mxTIFOy3qHZMijH+9ES0iCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7b6r05G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741264926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OPM/bCOOX2GDDU6yA/rUlU5U2LhtBTM4alZ9ThMJ7Vs=;
	b=F7b6r05Gcj9li2s2vZbGILYbcKXmMSCXK6BJeAhwLk302NLOY3BADoc8iWDNgBU45qh6zV
	alAVtYBFVgNcFqjE6gcgY63X8Q5dYFhoTXKb/asS223edBEzAxVLJ5UOL3ICktpR0XuxNA
	s77RQgX1hEYVt3TmeR9r4Fc3dN2myT4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-oZUYr1CKPBuiVKGau2zVhQ-1; Thu,
 06 Mar 2025 07:42:03 -0500
X-MC-Unique: oZUYr1CKPBuiVKGau2zVhQ-1
X-Mimecast-MFC-AGG-ID: oZUYr1CKPBuiVKGau2zVhQ_1741264921
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53C0C19560B0;
	Thu,  6 Mar 2025 12:42:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.240])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E5570300019E;
	Thu,  6 Mar 2025 12:41:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Mar 2025 13:41:29 +0100 (CET)
Date: Thu, 6 Mar 2025 13:41:21 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Neeraj.Upadhyay@amd.com,
	Ananth.narayan@amd.com, Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 3/3] treewide: pipe: Convert all references to
 pipe->{head,tail,max_usage,ring_size} to unsigned short
Message-ID: <20250306124120.GF19868@redhat.com>
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
 <20250306113924.20004-1-kprateek.nayak@amd.com>
 <20250306113924.20004-4-kprateek.nayak@amd.com>
 <20250306123245.GE19868@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306123245.GE19868@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/06, Oleg Nesterov wrote:
>
> On 03/06, K Prateek Nayak wrote:
> >
> > @@ -272,9 +272,9 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >  	 */
> >  	for (;;) {
> >  		/* Read ->head with a barrier vs post_one_notification() */
> > -		unsigned int head = smp_load_acquire(&pipe->head);
> > -		unsigned int tail = pipe->tail;
> > -		unsigned int mask = pipe->ring_size - 1;
> > +		unsigned short head = smp_load_acquire(&pipe->head);
> > +		unsigned short tail = pipe->tail;
> > +		unsigned short mask = pipe->ring_size - 1;
>
> I dunno... but if we do this, perhaps we should
> s/unsigned int/pipe_index_t instead?
>
> At least this would be more grep friendly.

in any case, I think another cleanup before this change makes sense...
pipe->ring_size is overused. pipe_read(), pipe_write() and much more
users do not need "unsigned int mask", they can use pipe_buf(buf, slot)
instead.

Oleg.


