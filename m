Return-Path: <linux-kernel+bounces-358864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10AF9984DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7804283B99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CE81C2DD5;
	Thu, 10 Oct 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3Tu0g8v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40311C2DA1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559399; cv=none; b=ZRF6sdmzA5TRZDcUJrHQdRVuyC0p2zZAeloNL5fcjJjLSKsRKCGb/+hQ4iyB6vwrfDVVxvuWtCQ6CyNJqOHy0eLJf5YDSss5PQ1DEcf4zUHXUsqU992DnAsb71juOvXQvKLKo8nvpdMgXElp5G6GFTUI3fgMkBUJjL7HqusX3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559399; c=relaxed/simple;
	bh=x9iaGYlku1I61w3bKz/b2Pv+BfrZU92jU/nEmEgj4Fo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=YMLAt2Lgcbl+BcgpP0G3ESucLubVqWLH2c9kFixHDVfhwVLXFn3yroJhPPZN9reHNd+Pe6m2oLY4z7hdoHUTApZzsnwpnVCAg8kzxLBzagY8eHP1fwK1kzmBGk+TUXxicyRcKWWDTc9J9IEGE5kdTfRrFe1uM8PImPefH602PWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3Tu0g8v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NXJ/YlAi2284RdYmfvHVqovUyQSlsXPT+gI0a/FAik=;
	b=Q3Tu0g8vXbH0OCqlEKxVPnn795jBfs3ro7Diw8PCl5kkwSeYBwz/JLF9wUmMhVUv8pJcP4
	1dS7DkJotENflUaOuJsr06HxnEX2uUMcxCQRMZmWzzY70QJdWTrcNCiOchmrJgJaNPZXYD
	fxETlzjebCxn6DVhNPzpkHTxdCRU/KE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-i8qS1cvJP6ysisq-7AS9jg-1; Thu,
 10 Oct 2024 07:23:10 -0400
X-MC-Unique: i8qS1cvJP6ysisq-7AS9jg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9F8C1956096;
	Thu, 10 Oct 2024 11:23:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 984581956086;
	Thu, 10 Oct 2024 11:23:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-6-wozizhi@huawei.com>
References: <20240821024301.1058918-6-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 5/8] cachefiles: Clean up in cachefiles_commit_tmpfile()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303857.1728559382.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:23:02 +0100
Message-ID: <303858.1728559382@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Zizhi Wo <wozizhi@huawei.com> wrote:

> Currently, cachefiles_commit_tmpfile() will only be called if object->flags
> is set to CACHEFILES_OBJECT_USING_TMPFILE. Only cachefiles_create_file()
> and cachefiles_invalidate_cookie() set this flag. Both of these functions
> replace object->file with the new tmpfile, and both are called by
> fscache_cookie_state_machine(), so there are no concurrency issues.
> 
> So the equation "d_backing_inode(dentry) == file_inode(object->file)" in
> cachefiles_commit_tmpfile() will never hold true according to the above
> conditions. This patch removes this part of the redundant code and does not
> involve any other logical changes.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Yeah, that's reasonable - and if it did hold true, all we do is unlink and
relink it.

Acked-by: David Howells <dhowells@redhat.com>


