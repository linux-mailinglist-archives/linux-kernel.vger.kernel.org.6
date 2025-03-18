Return-Path: <linux-kernel+bounces-567009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AEDA67FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AD7423DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955C42063E3;
	Tue, 18 Mar 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGjqPlGf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C66155753
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336836; cv=none; b=qY2lJcDHbbU1bunasWunpQH0pjADPIQFubQZv6PyYzpZP2JOWKCP2Gy/4LUH8cleAyMqoUcOE8sIuqgsvRHSlIYcsn8xxeoI0e/jQAQpJeXiBch3G8YeW3N8veUbeyLOpdkjrg+DlDiVGRI183TkkD2VcoRmZ72G8qjC419sXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336836; c=relaxed/simple;
	bh=mn8ciSZM7TzSdMWoRAmxUj268/ACb2sMPk8DNE7dNaQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kQA8/ihnhgeuziwvbdfZfZ0r7ebTltUoLX00iX79SS33RkKygnbSyyveb18uOQPYF+1U7WLJyLREpLMiDTgC6OqC1jfx2JWld18JQ/p4MlkIp9yvQfaB6J6S5XDB8pGVeOEeJhf9kU8CnwQGAm6iEHuXeQybUvPc+HNX6d0hauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGjqPlGf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742336833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6vJdlI3UJeMtCRnyHVRGZoKUZQprA89U08X2gYyoWMo=;
	b=aGjqPlGfNbqh1ZtHtAyRU1hTzaehmydGNDTGe7u4kGG1KKKeOgxF7bbxsWei7tOGpi90mr
	H4hUswjTME38545qJ6+Izpuuz7lrrFnqQpmX8IV1sJvuwGIajI+aAWBTAN6KLv6XWv3bH4
	TmE7BgDoD9LGZlkblAs2sGsJAXMdYGM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-vM1uv3UQMFeoyx3DM-zW5A-1; Tue,
 18 Mar 2025 18:27:10 -0400
X-MC-Unique: vM1uv3UQMFeoyx3DM-zW5A-1
X-Mimecast-MFC-AGG-ID: vM1uv3UQMFeoyx3DM-zW5A_1742336829
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA3A919560B0;
	Tue, 18 Mar 2025 22:27:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC3CE3001D0E;
	Tue, 18 Mar 2025 22:27:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <a8a3948417c0d1882f80c9f3870eeda23cb9ffd8.camel@ibm.com>
References: <a8a3948417c0d1882f80c9f3870eeda23cb9ffd8.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-20-dhowells@redhat.com>
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
Subject: Re: [RFC PATCH 19/35] libceph, ceph: Convert users of ceph_pagelist to ceph_databuf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2680946.1742336824.1@warthog.procyon.org.uk>
Date: Tue, 18 Mar 2025 22:27:04 +0000
Message-ID: <2680947.1742336824@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> >  		/*
> > -		 * number of encoded locks is stable, so copy to pagelist
> > +		 * number of encoded locks is stable, so copy to databuf
> >  		 */
> >  		struct_len = 2 * sizeof(u32) +
> >  			    (num_fcntl_locks + num_flock_locks) *
> 
> I think we have too many mysterious equations in CephFS code. :)

That's not particularly a function of these patches.

> > -		err = ceph_pagelist_reserve(pagelist,
> > -					    sizeof(u64) + sizeof(u32) +
> > -					    pathlen + sizeof(rec.v1));
> > +		err = ceph_databuf_reserve(dbuf,
> > +					   sizeof(u64) + sizeof(u32) +
> > +					   pathlen + sizeof(rec.v1),
> > +					   GFP_NOFS);
> 
> Yeah, another mysterious calculation. Why do we add sizeof(u64) and
> sizeof(u32) here?

Protocol element space.

David


