Return-Path: <linux-kernel+bounces-515021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EBAA35ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB31E16E13F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC827264A6F;
	Fri, 14 Feb 2025 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YesuA9zq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A201F2641C6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539016; cv=none; b=l0oVa+9B7KUQ4T1xyds2pOl4Wn/VxO83ML4Yk72XbULu2256l7VohSgL3/g6KLqZQlkqPdyIV1UYq/tuDVT1IePDCtEJwI3F0EOjuhQG2L+t0EVKb05rUDAaMf4jDC8CHXpG6LNUdfmNjaYrumW7dRNF+JYZJ16Rg4MNTpufhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539016; c=relaxed/simple;
	bh=4z1f4w3fc/rS+rR37tw4jvKtssLmhg7xJF+noxM8VNw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=OwXrVc6UX+J0uxeYeTlfZJgTpySEKPjwfbVaT5+DEXRKNungfKBHVJnbffqoaGZExlh85wDyPmwrPO6aWCqBpZOGSmEcnmtenKZ81F3gSImQbjvdAVsKWroTVKm0jU1HQt2mhFTAJok/47WRw3Cy7ldKvKgsntbxaPFfiAzjkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YesuA9zq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739539013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M24UA7C5snSotQt93BcJrFNpx6zFhQ3V7OApt+YZfGE=;
	b=YesuA9zqWIOrUpnT+fnvSIXfsKmyTdq2bg1YnncB5eo/CqMU95TPrKrCJOTlgNUbJ/c89S
	PRn+vmhJ5ntozIV00yhaMIxE3qvmGgz4nBdgzLVP/yHsF3WjJDzZFHcU81V8vutEOV3aqR
	Yt391rcYE64LGfNlmBLpnsSTZRLv7fc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685--G0UtyqJM92QBVRVbsr8hA-1; Fri,
 14 Feb 2025 08:16:51 -0500
X-MC-Unique: -G0UtyqJM92QBVRVbsr8hA-1
X-Mimecast-MFC-AGG-ID: -G0UtyqJM92QBVRVbsr8hA_1739539011
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6BE71800875;
	Fri, 14 Feb 2025 13:16:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95DCF1941298;
	Fri, 14 Feb 2025 13:16:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250214131225.492756-1-max.kellermann@ionos.com>
References: <20250214131225.492756-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6.13 v2] fs/netfs/read_collect: fix crash due to uninitialized `prev` variable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3979098.1739539008.1@warthog.procyon.org.uk>
Date: Fri, 14 Feb 2025 13:16:48 +0000
Message-ID: <3979099.1739539008@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Max Kellermann <max.kellermann@ionos.com> wrote:

> When checking whether the edges of adjacent subrequests touch, the
> `prev` variable is deferenced, but it might not have been initialized.
> This causes crashes like this one:
> 
>  BUG: unable to handle page fault for address: 0000000181343843
> ...
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Signed-off-by: David Howells <dhowells@redhat.com>


