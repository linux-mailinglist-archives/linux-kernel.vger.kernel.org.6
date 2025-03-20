Return-Path: <linux-kernel+bounces-569943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E560AA6A9E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7641485BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA581EB1AC;
	Thu, 20 Mar 2025 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSklXsnD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403571E8359
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484380; cv=none; b=gxwvGebyn3H5h+kZufhPh6hS0yZZxCxFyMMCd9K8N8AAXSS0nSZFPiEkOEw/gemyTIr8wFpqcv8SeUyF2xYlD1WLGqbwoXQQVvVlaHtPEro8XdkfzTJ6IfnUslTJatO2wZ9WbR7DTh+5NK5WSwLaeqJ1CC4VFHGsMg7liaQLF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484380; c=relaxed/simple;
	bh=TR1eTBA7fRTupQfcNBL8gfm9cGkD0wK7jgIIEFhsD/I=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=D3+Kj5QwEmjJnc43Mb6bTPaW4VrhVV6584vooGUsH87HUHHj9JO6tUTPCwwbRs/VAZzg9Qc0q5d0X9sr897657rC8y1GPquZdP8LO7hHizoJ9U7J2mcacw7MLFThf7HboVYLzai8+3ZC568xRwh/mHv3prHEQfL9OKSPyY/ta1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSklXsnD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742484378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79P3Rj9ZIxn8gB2XJc6nRUWm/vSrFhJbw3HtD7EvGj0=;
	b=YSklXsnDvsjZhAznCMvqvcQEJqLWL6H2EFRxJucAxEOQlt4hxOJ52Zl9YL7riBLKumDVJX
	9rQLHGNqkdRDvLZcPhBJ0QNu+uqHOnr8/3fwfBj0NwqZFJN7P+KX57Ebc8/fCBIy+hWCOg
	sa13cE8XuztHyjVNJP3/Fe8jdsD7UK0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-0M1WztXYMpy43it4VearTw-1; Thu,
 20 Mar 2025 11:26:13 -0400
X-MC-Unique: 0M1WztXYMpy43it4VearTw-1
X-Mimecast-MFC-AGG-ID: 0M1WztXYMpy43it4VearTw_1742484372
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC3121828B26;
	Thu, 20 Mar 2025 15:26:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4B3C19560AF;
	Thu, 20 Mar 2025 15:25:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b31f451e2949e7c07535accda067178238f7e1bb.camel@ibm.com>
References: <b31f451e2949e7c07535accda067178238f7e1bb.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-33-dhowells@redhat.com>
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
Subject: Re: [RFC PATCH 32/35] netfs: Add some more RMW support for ceph
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3173769.1742484356.1@warthog.procyon.org.uk>
Date: Thu, 20 Mar 2025 15:25:56 +0000
Message-ID: <3173770.1742484356@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > +	rreq->buffer.iter	= *iter;
> 
> The struct iov_iter structure is complex enough and we assign it by value to
> rreq->buffer.iter. So, the initial pointer will not receive any changes
> then. Is it desired behavior here?

Yes.  The buffer described by the iterator is going to get partitioned across
a number of subrequests, each of which will get a copy of the iterator
suitably advanced and truncated.  As they may run in parallel, there's no way
for them to share the original iterator.

David


