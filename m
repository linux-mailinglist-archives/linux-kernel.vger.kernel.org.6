Return-Path: <linux-kernel+bounces-358871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B099984F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB5D2836D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8931C32E5;
	Thu, 10 Oct 2024 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLn0SmSw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5691C244C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559634; cv=none; b=pUcd0OmhPJdRWXJnoXxgnlryHrJQJvcl91112lspsp7xVM+WpaI/j8fBvZaNoPJ0RZGtXOQg5rgdmf+HkYGafwuOqKo7Boe9GY2tE0KgceOOp53LERyyHH183Uq51bWOqd7g36ZGxuCOhvDLNpHA+x/5XSdZb/2QXj97wemvvRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559634; c=relaxed/simple;
	bh=Eq/0sQ9QSl7+JfnyZYKaS6BiFxibDB0xi/+v/5+P29c=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=liyO2xZD3H990aOOumyHCPPbWnV8sZFDWFRzD3uH5X6z9/5VG9HSTKpvd+uWR5Df1gVu49h8iw40EbR7ipDW+pTvm9VNOPrsezm7fI3wwZf8ZgDRVZ9pcuJfBo/8pDVBfyBit+FUrUNDoe2S7vwDUmXR76rkkb9oKGwQp4h2Jls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLn0SmSw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq/0sQ9QSl7+JfnyZYKaS6BiFxibDB0xi/+v/5+P29c=;
	b=LLn0SmSwucYqhr6manKf31H/b18+wgfyxWwiEWKI855BSvh0cRjUeim1QLURDHncY863/e
	49MJOlwTuELkP5mLJJFwTHW9BbIdl/mFnwU+yqVZMMJYfUT8Y7CLRM+EVN41KXvZ6xAcrv
	S2oVNg+blA0EzrGIsfRCjZ71Cd4trrg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206--6Q7z21RMtWhXfgKRbCahQ-1; Thu,
 10 Oct 2024 07:27:05 -0400
X-MC-Unique: -6Q7z21RMtWhXfgKRbCahQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1527E19560BF;
	Thu, 10 Oct 2024 11:27:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D27D19560AA;
	Thu, 10 Oct 2024 11:26:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-4-wozizhi@huawei.com>
References: <20240821024301.1058918-4-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 3/8] cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <304003.1728559613.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Oct 2024 12:26:54 +0100
Message-ID: <304004.1728559614@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Zizhi Wo <wozizhi@huawei.com> wrote:

> In the erofs on-demand loading scenario, read and write operations are
> usually delivered through "off" and "len" contained in read req in user
> mode. Naturally, pwrite is used to specify a specific offset to complete
> write operations.
> =

> However, if the write(not pwrite) syscall is called multiple times in th=
e
> read-ahead scenario, we need to manually update ki_pos after each write
> operation to update file->f_pos.
> =

> This step is currently missing from the cachefiles_ondemand_fd_write_ite=
r
> function, added to address this issue.
> =

> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up=
 cookie")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Acked-by: David Howells <dhowells@redhat.com>


