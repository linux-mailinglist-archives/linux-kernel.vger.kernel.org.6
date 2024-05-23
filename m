Return-Path: <linux-kernel+bounces-187859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC908CD9A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D1B1C2112D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98397E79F;
	Thu, 23 May 2024 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdfpYsEl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2EF9F5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487635; cv=none; b=MySpUPn5DvldQXf+73m5ws+fEjwd+57ZF2tdEXVJooi/pvSZCYfk5jwMUQNwyhqiFoFqTu5R14euRTgL/+a0qXr7QJMzJEOL7IFkuahG4P9rHYComXGrXc7pP+1fgVeatVTNyC2YMvjuA2n9EIM10lGrpb+pWSoeciICK60dzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487635; c=relaxed/simple;
	bh=ze+uZvHoEac0gtM0EDXK7xa1oz4j4ce3yLzuoXrr7Xo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=s/mLW5bXQSIlBb11qigvu1F7klsVaT+aAJffl63MN+vSDYAZRLPKL0G5pSpLkTdxoXz/aXgRH2FDTE/tXA4i8wmXw65qzDnRfHR30k2ODijSHMC2ijDGCtDtg6fvTdcxupj4L/KytvONX1dJlbs2i7oQC3kErLzkbnLaWa1r1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdfpYsEl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716487632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRDgVYqMRKVTVVPxWculCYevzyWeiQYRZji0ad67C1A=;
	b=TdfpYsEl5We4NSBzfv/3hfBp6Fhf5BP9gbirHhJMb9zQx8J+D8jZUVI4ahwvdIpWEAx3qm
	a6wC4kMq5xWTd4FdGs0gd8bLsskoO4m8qYPIfsiTQYkxVBO3148rj07FUaIt07UlDKs+5N
	jLYgrMLK/QzoqeUolvqPqzOgtz0Yq1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-fzIgdyQxMWqSuz_WYqEBOQ-1; Thu, 23 May 2024 14:07:08 -0400
X-MC-Unique: fzIgdyQxMWqSuz_WYqEBOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F1CB800169;
	Thu, 23 May 2024 18:07:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1DCD7C15BED;
	Thu, 23 May 2024 18:07:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zk9y21FktxyLGqDJ@codewreck.org>
References: <Zk9y21FktxyLGqDJ@codewreck.org> <00000000000092914806191382ac@google.com> <580959.1716475058@warthog.procyon.org.uk>
To: asmadeus@codewreck.org
Cc: dhowells@redhat.com,
    syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>,
    brauner@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <641238.1716487625.1@warthog.procyon.org.uk>
Date: Thu, 23 May 2024 19:07:05 +0100
Message-ID: <641239.1716487625@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

asmadeus@codewreck.org wrote:

> > There's a problem in 9p's interaction with netfslib whereby a crash occurs
> > because the 9p_fid structs get forcibly destroyed during client teardown
> > (without paying attention to their refcounts) before netfslib has finished
> > with them.  However, it's not a simple case of deferring the clunking that
> > p9_fid_put() does as that requires the client.
> 
> "as that requires the client" doesn't parse

"... as that requires the p9_client record to still be present."?

David


