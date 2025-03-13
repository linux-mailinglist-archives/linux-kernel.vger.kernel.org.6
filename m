Return-Path: <linux-kernel+bounces-558985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2604CA5EDF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CB117B878
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7D261375;
	Thu, 13 Mar 2025 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdstcLdE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB044260A27
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854342; cv=none; b=obTBtgUZr0Ex2uyD16v6AUj0LWAUDlg/upzvxXSMk44yywhGU69gSRRGIvaHyoUgfAedhSxgas3gKvSkaUdIQ7qbSE1b4kLtDtYrxiMR2WVkC62KaILEUsYpzQAMy6pWJtsqpYHRBdj9HN+z3VzSkB7TWmfiLC3Ohh8p0YO3hig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854342; c=relaxed/simple;
	bh=QljnaP8b0o+u3UuwJdMOMNTGRKJYYW3WKMH5vkZKcHc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=naiYRhPfb9hMWB7u8cyzi74igYzJ54ob36AhQakunaUuC0r7PRYk75XlnvxgLS0e3Wu2k2+RZPuL6OuN5qOoGcjwl86xV082kok01z+EuykFQFqKhCbwtTXblJjSJkZ5MdC1HfCdMH33uoDOnGEOhRHawttbZzdpaxOxvYBLdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdstcLdE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741854338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFbXV6wQm1jW/3xJcOUdaz2XhjqGU0ni5DQO1sddI98=;
	b=RdstcLdEvkT2utlkRmVckCHtq8Sf2mYrwpo+6k6g7b4WkBwISXYIJ2P5VApDWMX0Vd5ySQ
	Wt0Z+95drTVlaT7tvqgvncLVqLIXuG8ZTA8szhi6zhAEpxW4fzSeeY4tcifaLOi6+Fve3B
	Uimh8oif+t6BarGfvOBM34eKgla6tGY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-OssFLTJ2N0O8kUzooC6wjQ-1; Thu,
 13 Mar 2025 04:25:34 -0400
X-MC-Unique: OssFLTJ2N0O8kUzooC6wjQ-1
X-Mimecast-MFC-AGG-ID: OssFLTJ2N0O8kUzooC6wjQ_1741854333
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 440F3195605A;
	Thu, 13 Mar 2025 08:25:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9140718001EF;
	Thu, 13 Mar 2025 08:25:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <458de992be8760c387f7a4e55a1e42a021090a02.camel@ibm.com>
References: <458de992be8760c387f7a4e55a1e42a021090a02.camel@ibm.com> <1243044.1741776431@warthog.procyon.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, "slava@dubeyko.com" <slava@dubeyko.com>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    Alex Markuze <amarkuze@redhat.com>, Xiubo Li <xiubli@redhat.com>,
    "brauner@kernel.org" <brauner@kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ceph: Fix incorrect flush end position calculation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1307971.1741854328.1@warthog.procyon.org.uk>
Date: Thu, 13 Mar 2025 08:25:28 +0000
Message-ID: <1307972.1741854328@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> Do we know easy way to reproduce the issue?

I found it by inspection of the code.  Quite possibly the issue will never
arise in actuality because whilst the code only specifies a flush of at least
a few bytes of the tail page, it will be rounded up to the full page/eof.

David


