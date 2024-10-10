Return-Path: <linux-kernel+bounces-358908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D755F99852E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3761F2267F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FB01C689F;
	Thu, 10 Oct 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsPy4U/3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A941C4604
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560229; cv=none; b=ALxafdmLXhRnGsL/uj+Hdl42poqq3AgtwkE1jpbGQ3l67k+yVneMPYlbc3rVHL0vbeNRmv60W3mARln92pEu/HV1dkzYMag7NvifruBx5m6tbi8znUYzTDe8UGlHHVuFGE9jfZr5quEcVShwql5zn2eDHVygw9U/lt6tFGtKvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560229; c=relaxed/simple;
	bh=7muf9vDPJHKAd2mvKg8YJK84HnrdBqeO6Zqe4jEU3is=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=D74+M0im0WrTKwSW3dSv/SVg3jJt1JLTqGxxgIuNDFoTz04niIRBx1o+I/yLtZ3PwVgMpyfVjVrKfCvXaX5/HWUO1EjHIp02Ik7etqkpeoHL5TSE1L+NikpzyjRID2hE3DcikIJVv6XhjXHD7GLs5Lx/xopBeOkDDg8DVQENrV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsPy4U/3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728560226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7muf9vDPJHKAd2mvKg8YJK84HnrdBqeO6Zqe4jEU3is=;
	b=EsPy4U/38qh099cB5UPE/iYAEgVY3K84KQm6BKiTiJfs1dHr8o/y/2l8jVY3SjVzF85ipk
	rlYhbza3P3jKwE79f0No2P71yq4FZXjC4j1t3xULb+TUY5XdvQMNPHF0auhndvFcHVk6X5
	cqk/KDs0HCFBIhb+icqmEkNwOzHpKFs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-zaMNslEuNF-beVOermW28w-1; Thu,
 10 Oct 2024 07:37:04 -0400
X-MC-Unique: zaMNslEuNF-beVOermW28w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 243EC1955EA5;
	Thu, 10 Oct 2024 11:37:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 34F1019560A3;
	Thu, 10 Oct 2024 11:36:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <e94a52d9-ded4-4a22-90d5-18cb7665607b@huawei.com>
References: <e94a52d9-ded4-4a22-90d5-18cb7665607b@huawei.com> <20240821024301.1058918-2-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com> <302546.1728556499@warthog.procyon.org.uk>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 1/8] cachefiles: Fix incorrect block calculations in __cachefiles_prepare_write()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <304310.1728560215.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:36:55 +0100
Message-ID: <304311.1728560215@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Zizhi Wo <wozizhi@huawei.com> wrote:

> For scenarios such as nfs/cifs, the corresponding bsize is PAGE_SIZE aligned

cache->bsize is a property of the cache device, not the network filesystems
that might be making use of it (and it might be shared between multiple
volumes from multiple network filesystems, all of which could, in theory, have
different 'block sizes', inasmuch as network filesystems have block sizes).

David


