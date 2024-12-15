Return-Path: <linux-kernel+bounces-446045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073419F1F16
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 14:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F2418899AE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22F1946B3;
	Sat, 14 Dec 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWYCtP9Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FE192D8C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734183899; cv=none; b=j0Jr3E6wHfjT9uYmf0Xe+Fd7PVNpMLXArBp73XQF08oCW7jET2RNjhoVTgk1swKMazBA4OflpDQFMuniyJ4RkG6ooBZRCs+hngMZoM273akTKL/yAKLJicFy8+LcQ6lsc7unkAObrbcHdiJyoBbkYZOE14JVxtbFRodoA7DPt+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734183899; c=relaxed/simple;
	bh=13rBSAvaRAo4EyKvH1GGFM98sYucjN0FkZJgyl07oPc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=pqRTNACQK2JeJ4hAX4cq6h2NuLHMxxv6zNy5SLARNRpLKys0FdiUmMvaOoBTDQhgSFjyEIMj0QAEGTCC8HKoEO9Kg4wEgN/Cj+OYqQg7u6lzzOdCi1j/70kYx5lEa7Ml9P8O5Y91DUgBMqccr5LUsde/sY3M8pFbphnDw4qFd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWYCtP9Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734183897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=um83NFh7ZIRRd8ai46akYsrKyJ5hcwaKtVTR9gj1RFE=;
	b=aWYCtP9ZZTCXqOIoFozZgTu2Auh5MZLG6YMQqcv0caVWvskw1XwfLQy2f5gaWF37C5Ck2v
	jGP6GnqaIJpGdzhnzXFi9ZJq+kF2QykPsi1tHXnKL8qTKZLdNWVowhIhCVe6hJac/IAOUL
	ka3IFXZGQQ+EXa/gTOKzFTIMXGiIgmk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-ql_YDdrZOJec0ZI5AmZePg-1; Sat,
 14 Dec 2024 08:44:52 -0500
X-MC-Unique: ql_YDdrZOJec0ZI5AmZePg-1
X-Mimecast-MFC-AGG-ID: ql_YDdrZOJec0ZI5AmZePg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2AD4195608C;
	Sat, 14 Dec 2024 13:44:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDE4A195394B;
	Sat, 14 Dec 2024 13:44:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <27fff669-bec4-4255-ba2f-4b154b474d97@gmail.com>
References: <27fff669-bec4-4255-ba2f-4b154b474d97@gmail.com> <20241213135013.2964079-1-dhowells@redhat.com> <20241213135013.2964079-8-dhowells@redhat.com>
To: Akira Yokosawa <akiyks@gmail.com>,
    "Paul E. McKenney" <paulmck@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Max Kellermann <max.kellermann@ionos.com>,
    Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
    Trond Myklebust <trondmy@kernel.org>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
Subject: Re: [PATCH 07/10] netfs: Fix missing barriers by using clear_and_wake_up_bit()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3332015.1734183881.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Dec 2024 13:44:41 +0000
Message-ID: <3332016.1734183881@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

[Adding Paul McKenney as he's the expert.]

Akira Yokosawa <akiyks@gmail.com> wrote:

> David Howells wrote:
> > Use clear_and_wake_up_bit() rather than something like:
> > =

> > 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> > 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
> > =

> > as there needs to be a barrier inserted between which is present in
> > clear_and_wake_up_bit().
> =

> If I am reading the kernel-doc comment of clear_bit_unlock() [1, 2]:
> =

>     This operation is atomic and provides release barrier semantics.
> =

> correctly, there already seems to be a barrier which should be
> good enough.
> =

> [1]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.c=
lear_bit_unlock
> [2]: include/asm-generic/bitops/instrumented-lock.h
> =

> > =

> > Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
> > Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> =

> So I'm not sure this fixes anything.
> =

> What am I missing?

We may need two barriers.  You have three things to synchronise:

 (1) The stuff you did before unlocking.

 (2) The lock bit.

 (3) The task state.

clear_bit_unlock() interposes a release barrier between (1) and (2).

Neither clear_bit_unlock() nor wake_up_bit(), however, necessarily interpo=
se a
barrier between (2) and (3).  I'm not sure it entirely matters, but it see=
ms
that since we have a function that combines the two, we should probably us=
e
it - though, granted, it might not actually be a fix.

David


