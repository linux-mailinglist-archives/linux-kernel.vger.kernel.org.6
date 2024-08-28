Return-Path: <linux-kernel+bounces-305014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2682D962824
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF331F21563
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D2317BEA2;
	Wed, 28 Aug 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCFZJ/y2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB088175D47
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850131; cv=none; b=N60BkYuNtRSHtTvgXY7dO2Sv44q9aFx/dYoZCvZueL4sZzGtJET3h26mDQYXZZKMhRDwpvf7pmfaf/4uYHXbgW2/JYZzkAjaqSJ4t4aTodcj1OMSs2Rdf4XGQ9Wbyyt1t/gjwkoZhVDLczDQNGU1K7dj5D/HOQli0WVas6RXKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850131; c=relaxed/simple;
	bh=6z9573j1PRy0mQEVayeHkT7XEBmXChvpYifI+rJKeeI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=crdV8ZgodxGBm56P4fs109dPzL7lEKve6BbnNoR09p+Q5UO7UVk3J36zG/nH4OJG5EEBSf9bg1p6NGuXHg2NBgqwKjI1Ry6NO1kWA73vutcRuPLUE94Jipkz0rIJ5TqS67IpSmASSnRIw8KG+E5a90Plt5VxMYP8PBiIQWffdVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCFZJ/y2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724850128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6z9573j1PRy0mQEVayeHkT7XEBmXChvpYifI+rJKeeI=;
	b=VCFZJ/y22JqrUCRrcIg6PDuFxnFFeLdMihqrDk8lYHrCGLr0hMEX0pRDsIJMqFI7e2bLLg
	fk0XycEsEMAEkgfH3Brs6DNfe82nEpmPRPo8Ff+A4p/Zc8i+sHGeePFZUDaOGxFFgi50nC
	9kUYVP4ASKW9TUd1rjb5tyQKvDYnXbs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-dmP1IjVvOrejjqwGLa5RLQ-1; Wed,
 28 Aug 2024 09:02:04 -0400
X-MC-Unique: dmP1IjVvOrejjqwGLa5RLQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96FC41955D47;
	Wed, 28 Aug 2024 13:02:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF17219560A3;
	Wed, 28 Aug 2024 13:01:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com>
References: <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com> <20240826040018.2990763-1-libaokun@huaweicloud.com> <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: dhowells@redhat.com, Markus Elfring <Markus.Elfring@web.de>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>,
    stable@kernel.org, LKML <linux-kernel@vger.kernel.org>,
    Christian Brauner <brauner@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Hou Tao <houtao1@huawei.com>, Jingbo Xu <jefflexu@linux.alibaba.com>,
    Yang Erkun <yangerkun@huawei.com>, Yu Kuai <yukuai3@huawei.com>,
    Zizhi Wo <wozizhi@huawei.com>, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <988771.1724850113.1@warthog.procyon.org.uk>
Date: Wed, 28 Aug 2024 14:01:53 +0100
Message-ID: <988772.1724850113@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Baokun Li <libaokun@huaweicloud.com> wrote:

> Actually, at first I was going to release the reference count of the
> dentry uniformly in cachefiles_look_up_object() and delete all dput()
> in cachefiles_open_file(),

You couldn't do that anyway, since kernel_file_open() steals the caller's ref
if successful.

> but this may conflict when backporting the code to stable. So just keep it
> simple to facilitate backporting to stable.

Prioritise upstream, please.

I think Markus's suggestion of inserting a label and switching to a goto is
better.

Thanks,
David


