Return-Path: <linux-kernel+bounces-358874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567D9984FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB02E283C57
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442CA183CD9;
	Thu, 10 Oct 2024 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KActgayI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB21C244B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559916; cv=none; b=mcBJ++g434ypZU0d0zvXQzRABnDEecvTqSnPxJinj/nZbUIT7uq3CyJHoEYWMoHa80yIGNWbhxR8GX1OTMLELoKjmvpWgOPYGzby1O17F7E+ecrtfii+2/5RHmcTLxH/HYCa+5u7eO39Ux4wq6jaXky+km5c18HTfpbKbhPUBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559916; c=relaxed/simple;
	bh=pfGEpMF39VFoy+My07KmkNgcSpKJiJuaOIL+fXlG1Cs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=CZJTC+Y85u1RP2sP2Xp5YzeAt72hWiVWz07cR8wNNj3/F12oPwubQ7lWIS6BQJvU3hfWrIKtyTvS62dQN8DmsGI9Q/q0mlAumV/v45IeXzIe6nqk7fUkz5zQ0udeWXq4uaFoEDHUK1Smf7Fd2td0IEluiJLplh2ogKCnHeg6Hz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KActgayI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0mSN84ctC9kB+Ps3c0dqY7xkZFlxz3esb1cmK+QLag=;
	b=KActgayIC8MBkPCj80i5Tw2d+r+V3h6NKXkGReAcLrxJDnyIXb5j5kGb4F/jp+fAQ8PnFL
	hUsvqnEFnSOy8deQMSsPRTCTozjoRNcdEH+W3jHOYmFMQSeHunPlOKaoZjPexkdoNJUNeK
	qULVx0tKmeB2mS16QLLMjgQPXiBxWfg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-harA49VCM6mKEob86Vqu_Q-1; Thu,
 10 Oct 2024 07:31:48 -0400
X-MC-Unique: harA49VCM6mKEob86Vqu_Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C96A1955F44;
	Thu, 10 Oct 2024 11:31:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E65E819560AA;
	Thu, 10 Oct 2024 11:31:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-7-wozizhi@huawei.com>
References: <20240821024301.1058918-7-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 6/8] cachefiles: Modify inappropriate error return value in cachefiles_daemon_secctx()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <304107.1728559896.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:31:36 +0100
Message-ID: <304108.1728559896@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Zizhi Wo <wozizhi@huawei.com> wrote:

> In cachefiles_daemon_secctx(), if it is detected that secctx has been
> written to the cache, the error code returned is -EINVAL, which is
> inappropriate and does not distinguish the situation well.

I disagree: it is an invalid parameter, not an already extant file, and a
message is logged for clarification.  I'd prefer to avoid filesystem errors as
we are also doing filesystem operations.

David


