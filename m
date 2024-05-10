Return-Path: <linux-kernel+bounces-175419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E57B8C1F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5AE6B21BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCA615FCE9;
	Fri, 10 May 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F44vmO4r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AEB15FA9E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327856; cv=none; b=B+bnl6XAQ0jdFvPBv0YQDl0F0ogwpcS1FDJLgptuclDqyFfksyaFIzruxd3V5vYTqbFCYzdF0Rn4Nbsr8pR+jI8fZiIuOQfy0/oJr9Bk7+0kM5JDG6ULmoQYrD873Kjapio+Boj09IFgMDsnGyWTtuXNLv1BQ76jUt66AEksBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327856; c=relaxed/simple;
	bh=0ZBc+Q6dI2nvBKuIrhZxI1E2dONPs+Fjuws1+0I2wc0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=TY17k+y2uzhvKT859ZkuY8B8puISei439XIfZQ2anwLsYOvp4/Pzs7t9Q6efwRvZWmMQGsiKNZMnmwO+V9SccDQUZAlzgiM6jtto+pyRcplh/Mn95+CUEP7on4xO7EhG2flJIc8cnpKY04mQIlIi/0hRh4/gUZuXCZRRTvqQvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F44vmO4r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715327854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZBc+Q6dI2nvBKuIrhZxI1E2dONPs+Fjuws1+0I2wc0=;
	b=F44vmO4r8Ea8+BsmPdSshXtOQ+g2Q7juJIxV73APMcX5sBqgemVhomNwMrrcz+w4TRBlpw
	UurrBZ3TQljrlOnO1+dfxtDMp6tZ7/CUyAfW2FmOYO/Ui6juGkLLQZpQY04dh2d1WgQFeG
	CB0ELswSv8Q3gR07ezN7NFVDqs/QVi0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-_VIFnsB-PaqnQWIh6XDzdA-1; Fri,
 10 May 2024 03:57:27 -0400
X-MC-Unique: _VIFnsB-PaqnQWIh6XDzdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73F983C0C892;
	Fri, 10 May 2024 07:57:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A1BA11847D6;
	Fri, 10 May 2024 07:57:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zj22cFnMynv_EF8x@gpd>
References: <Zj22cFnMynv_EF8x@gpd> <Zj0ErxVBE3DYT2Ea@gpd> <20231221132400.1601991-1-dhowells@redhat.com> <20231221132400.1601991-41-dhowells@redhat.com> <1567252.1715290417@warthog.procyon.org.uk>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1578870.1715327842.1@warthog.procyon.org.uk>
Date: Fri, 10 May 2024 08:57:22 +0100
Message-ID: <1578871.1715327842@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Andrea Righi <andrea.righi@canonical.com> wrote:

> The only reproducer that I have at the moment is the autopkgtest command
> mentioned in the bug, that is a bit convoluted, I'll try to see if I can
> better isolate the problem and find a simpler reproducer, but I'll also
> be travelling next week to a Canonical event.

Note that the netfslib has some tracepoints that might help debug it.

David


