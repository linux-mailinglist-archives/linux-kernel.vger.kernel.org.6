Return-Path: <linux-kernel+bounces-569926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 819B5A6A9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1381886484
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAE81E9B06;
	Thu, 20 Mar 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLEQ1kwy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5E1E47A5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484175; cv=none; b=nluqGOfBH9ZgLwjx0+JI2U6fTjv/vDKbMmWfK9nlos6tgvESjnZf0Dot1hJKCewaTFQDrR5C+Fzows6Ek3h+Q1mV+vBZMR2isucGzP/8ybDnL+sCp8PNC6wR2fFR9pp1PFIRo628hhU1W6BX0mO1TAo+OKHQi2QUPq88WQTt1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484175; c=relaxed/simple;
	bh=dN0PedVSuX7QXaHpTR0F3DmJyYmt/gOm5NeJEuK58N0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=nwsmCXgUdaJu0BcPWVGT4ct0uPN1VINcAGvaSjj00OLetEZEJ3xmTnzTAwJSBFgEY2NL8r9uz9Gge+3ZsywenTA3c/S+9BCV9iBLa6Cdyi7Xe5exSFH+R6lwUVkxp6+9UJZvCegyujXf1k4tdbAWFL3QeBmN577PRq//07vxyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLEQ1kwy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742484172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQ12SBS+xaGKl0p+tVquQxEaQenYHJNZyAI7USNHD6U=;
	b=TLEQ1kwyiwg6qkcN97NteosfRuuPFeVJ5UdVn7IgSxAjIyMzBivq9OsTyZA26GYek7d14U
	7ae5Q4zg/7wXtYRKgOBBm9/XuC3dyGTedzCVggxt6knAn878gfAQPCX1/6ZSrympzIsSCS
	VQt6vhPIRK7Nb8uVsF9e7NBNlHmezmc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-BWj7Ce4kPMmRnlhAhS4IhA-1; Thu,
 20 Mar 2025 11:22:47 -0400
X-MC-Unique: BWj7Ce4kPMmRnlhAhS4IhA-1
X-Mimecast-MFC-AGG-ID: BWj7Ce4kPMmRnlhAhS4IhA_1742484165
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 228D9180025C;
	Thu, 20 Mar 2025 15:22:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6EE11828A93;
	Thu, 20 Mar 2025 15:22:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <dd76239caf5ae7ea8f681fd778e6028cb41bbc43.camel@ibm.com>
References: <dd76239caf5ae7ea8f681fd778e6028cb41bbc43.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-29-dhowells@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 28/35] netfs: Adjust group handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3173667.1742484160.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Mar 2025 15:22:40 +0000
Message-ID: <3173668.1742484160@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> >  		if (unlikely(group !=3D netfs_group) &&
> > -		    group !=3D NETFS_FOLIO_COPY_TO_CACHE)
> > +		    group !=3D NETFS_FOLIO_COPY_TO_CACHE &&
> > +		    (group || folio_test_dirty(folio)))
> =

> I am trying to follow to this complex condition. Is it possible case tha=
t
> folio is dirty but we don't flush the content?

It's slightly complicated by fscache.

The way I have made local caching work for things that use netfslib fully =
is
that the writeback code copies the data to the cache.  We achieve this by
marking the pages dirty when we read them from the server.

However, so that we don't *also* write the clean data back to the server, =
the
writeback group[*] field is set to a special value (NETFS_FOLIO_COPY_TO_CA=
CHE)
and we make the assumption that the writeback group is only actually going=
 to
be used by the filesystem if the page is actually modified - in which case=
 the
writeback group field is overwritten.

[*] This is either folio->private or in a netfs_folio struct attached to
folio->private.  Note that folio->private is set to be removed in the futu=
re.

In the event that a page is modified it will be written back to the server=
(s)
and the cache, assuming there is a cache.  Also note the netfs_io_stream
struct.  There are two in the netfs_io_request struct and these are used t=
o
separately manage and divide up the writes to a server and to the cache.  =
I've
also left the possibility open that we can have more than two streams in t=
he
event that we need to write the data to multiple servers.

Further, another reason for making writeback write the data to both the ca=
che
and the server is that if you are using content encryption, the data is
encrypted and then the ciphertext is written to both the server and the ca=
che.

> Is it possible case that folio is dirty but we don't flush the content?

Anyway, to answer the question more specifically, yes.  If the folio is di=
rty
and in the same writeback group (e.g. most recent ceph snap context), then=
 we
can presumably keep modifying it.

And if the folio is marked dirty and is marked NETFS_FOLIO_COPY_TO_CACHE, =
then
we can just overwrite it, replace or clear the NETFS_FOLIO_COPY_TO_CACHE m=
ark
and then it just becomes a regular dirty page.  It will get written to fsc=
ache
either way.

> > +		if ((++flush_counter & 0xf) =3D=3D 0xf)
> > +			msleep(10);
> =

> Do we really need to use sleep? And why is it 10 ms? And even if we woul=
d
> like to use sleep, then it is better to introduce the named constant. An=
d
> what is teh justification for 10 ms?

At the moment, debugging and stopping it from running wild in a tight loop
when a mistake is made.  Remember: at this point, this is a WIP.

But in reality, we might see this if we're indulging in cache ping-pong
between two clients.  I'm not sure how this might be mitigated in the ceph
environment - if that's not already done.

> > -		kdebug("wrong group");
> > +		kdebug("wrong group %px !=3D %px", fgroup, wreq->group);
> =

> I believe to use the %px is not very good practice. Do we really need to=
 show
> the real pointer?

At some point I need to test interference from someone cranking the snaps =
and
I'll probably need this then - though it might be better to make a tracepo=
int
for it.

> > +/*
> > + * Get a ref on a netfs group attached to a dirty page (e.g. a ceph s=
nap).
> > + */
> > +static inline struct netfs_group *netfs_get_group(struct netfs_group =
*netfs_group)
> > +{
> > +	if (netfs_group && netfs_group !=3D NETFS_FOLIO_COPY_TO_CACHE)
> =

> The netfs_group is a pointer. Is it correct comparison of pointer with t=
he
> NETFS_FOLIO_COPY_TO_CACHE constant?

This constant?

#define NETFS_FOLIO_COPY_TO_CACHE ((struct netfs_group *)0x356UL) /* Write=
 to the cache only */

Yes.  See explanation above.

David


