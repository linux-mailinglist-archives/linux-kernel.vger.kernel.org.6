Return-Path: <linux-kernel+bounces-358868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135319984EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FBD1C24142
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1349C1C2DA1;
	Thu, 10 Oct 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hclnYxbE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC71C32FE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559470; cv=none; b=sMm/HFc1Y0rZaMpV7QR24vGJbw3L4DydoUiTpbNcvUl8PJDPO1wYAKgZsYqQTnL4oRNEp9Ij+Hq/1JAiIBxD6bf2ELLoe40O1oohfBdbtaapr7PepLOe8SErFeB9xv5oSOcnpasN1iNZgNFu5+nNTE5FyLE3sJmfS2E41Alqv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559470; c=relaxed/simple;
	bh=91MakKXXdZ/X8v1/goDuWFlMTUMGbgqBgnskPiSeMP0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=TLlQNyDpOSHYjM1D5gx6WJ4aPfQA9kmnKqGe6o2gd2WO4pXNcqzCCRBVNRosPAQlYy6ZYD8NKTxlMi27Qon4kwif8cciuIBhTm/wcWBT55YgjhFnVrPsdQDVReJ2BXqzTgqgY4zeFwfhaYAoyJcDDaJDKz5CXk5HnTgLqynTz6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hclnYxbE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91MakKXXdZ/X8v1/goDuWFlMTUMGbgqBgnskPiSeMP0=;
	b=hclnYxbEJvPa6OUVyH7DdyXycxlmc1CFJt6EnRkLka0vVjdJw9AQbWapKcsvJz7zNp6sAB
	npU/4ZK/2zlQu8+hXbQDG0E9uHEX0/i7pBskLQ7r2geNc1UOqZPgsgTvtEz1SXr3/22Qmj
	75r066wbhe3OS4C5Rw4fPWcvEvOZaZQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-ppm18wj7PQSs_wzc0tN0EA-1; Thu,
 10 Oct 2024 07:24:24 -0400
X-MC-Unique: ppm18wj7PQSs_wzc0tN0EA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B128B195608C;
	Thu, 10 Oct 2024 11:24:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A21B819560AE;
	Thu, 10 Oct 2024 11:24:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-9-wozizhi@huawei.com>
References: <20240821024301.1058918-9-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 8/8] netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303925.1728559457.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Oct 2024 12:24:17 +0100
Message-ID: <303926.1728559457@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Zizhi Wo <wozizhi@huawei.com> wrote:

> In fscache_create_volume(), there is a missing memory barrier between th=
e
> bit-clearing operation and the wake-up operation. This may cause a
> situation where, after a wake-up, the bit-clearing operation hasn't been
> detected yet, leading to an indefinite wait. The triggering process is a=
s
> follows:
> ...
> By combining the clear and wake operations into clear_and_wake_up_bit() =
to
> fix this issue.
> =

> Fixes: bfa22da3ed65 ("fscache: Provide and use cache methods to lookup/c=
reate/free a volume")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Acked-by: David Howells <dhowells@redhat.com>


