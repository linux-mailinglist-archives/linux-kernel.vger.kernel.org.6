Return-Path: <linux-kernel+bounces-187667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A92B8CD62C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C9D28394F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67325847B;
	Thu, 23 May 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtMiUXOn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556204690
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475943; cv=none; b=jzYPBTK/Cze5MhuUjc1SJbmF4W7ajKW+xiwbRZ+ZYHHj41vRWoLlQwn03cn2HhmKJ3Z0pN+nHdn7Babqtb5AR+x34PYw2owqI7JM99wp/gygjfEi9xgVW7oYWYecxNT0hptzR026NwGP7/tAcYBCk8pRCu6gf6ruJuxgO4vAG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475943; c=relaxed/simple;
	bh=LpXSjgBMEkRv8opmgT2NRH5VOajy5q7jfqB+yTTvnkk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=USV+/hAMJY7/BOoTX7xXNFZ0zC2HrGip7eOyZQxqjXnP8bYyuNVu/RB2lq4R/fThqaLbDO1YdT00/ZT533pd+NYLr8UtQk8uNm2VftLMUQ94HG0NuNQipvxs5hXsGSaj6CdGB8c8YUC8e/qQBsQsPgo9aMTuQmz6puUodE/KTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VtMiUXOn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716475941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vjc2IcLX5yvNsYGF0QGbdU4NIiYVHBYS+4rvVrUYiTM=;
	b=VtMiUXOngHXsyoCHB8foSSXGInlM8+vSqqq7uh+ySzU3qEg9wtBpjP+ED4T5pFIZRA1Q8I
	EDTZ9m35WCpYAWtHocnHaFfVPBwT3e1whvtI4n/SDp9lJ+Id+rp1ltfX2NiFuk4vT9FMcw
	7OQavPamcu5yHkPVjgVp3ku/Clbg5Z0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-FkCOD_CFOpWL3hQxuAfccQ-1; Thu,
 23 May 2024 10:52:17 -0400
X-MC-Unique: FkCOD_CFOpWL3hQxuAfccQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CB8D29AA2C1;
	Thu, 23 May 2024 14:52:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DC4211C0654B;
	Thu, 23 May 2024 14:52:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <536b0f03-db96-49a3-93de-d9ea835e8785@talpey.com>
References: <536b0f03-db96-49a3-93de-d9ea835e8785@talpey.com> <469451.1716418742@warthog.procyon.org.uk>
To: Tom Talpey <tom@talpey.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cifs: Fix credit handling in cifs_io_subrequest cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <581216.1716475935.1@warthog.procyon.org.uk>
Date: Thu, 23 May 2024 15:52:15 +0100
Message-ID: <581217.1716475935@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Tom Talpey <tom@talpey.com> wrote:

> From a protocol standpoint it's correct to reserve the credits while the
> operation is in flight. But from a code standpoint it seems risky to
> stop accounting for them. What if the operation is canceled, or times
> out?

No idea, TBH - SMB credits wrangling isn't my area of expertise.  Note the
patch is superfluous as smb2_readv/writev_callback() clear the credits at the
end; worse, it's actually wrong as we're not allowed to touch [rw]data after
calling ->async_readv()/->async_writev().

> I'd quibble with the assertion that the server will "give us new credits
> in the response". The number of granted credits is always the server's
> decision, not guaranteed by the protocol (except for certain edge
> conditions).

It does give us new credits in the response, doesn't it?  In
hdr.CreditRequest - though I suppose this could be zero.

> I guess I'd suggest a deeper review by someone familiar with the
> mechanics of fs/smb/client credit accounting. It might be ok!

I've given Steve a patch to try and find where the double add occurs.

David


