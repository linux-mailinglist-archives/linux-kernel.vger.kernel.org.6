Return-Path: <linux-kernel+bounces-335005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E03997DF92
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 02:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5B71C20B3E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC14B28FF;
	Sun, 22 Sep 2024 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcezTFof"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F680B
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726963617; cv=none; b=kCC/B6vLtO8hRKOWhD6o+Qqlmq6hEN8d+4JGOR0h6Iw3VSxDNysAKGVi0vmWcUbNBdKfaXt5vByJ4n7VWyQ0PGBTt7zikTOzIeQp+U/rBW9ZuS3m1O8+kFhpV6Edqem7/AEPxANC2zBgXvb1YJHMkprgxWrOsY4hZPUs5uPENZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726963617; c=relaxed/simple;
	bh=WKyntDpY5RfpkJ3slVwHqlKCBjPxUylJnKPiT5ID+wg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=TNn50UPGr5OOqQ8d91mJ0W+SzyoIhSc8uJ2QIljrIrwp/I2G5QqdhgjtQRByBiCkMB7tLHoU27oyqnXRMskT6zk9JbHB71QvrHDe+fudyLpaO4nz/vdY98W2pNNdFjcTpFgz4oLS2X50K2HAp+gSTd+83IoWzFkQeZE2z1mEdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcezTFof; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726963614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08s6M0VfFhuosAR80HkD/E3XEVyWoGIAF2KhFDbJcRY=;
	b=TcezTFofa8sWV/u3dwgx+vtSi13DAdP/6y0oj2DdzJM4Hk4fNSfy0pA6wi2AvkuiUQToqT
	QCcmlH7TY5lKtwen23FvlnubjHC/8Ycm89mhyAlEngikr8iRhxAvSp5TYqErd5P7ld2Lkk
	tygfP+G8IfNUbiBj2pcgGHtI3m5T7bY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-vSH2yiwgMliaspwAsY6mqQ-1; Sat,
 21 Sep 2024 20:06:52 -0400
X-MC-Unique: vSH2yiwgMliaspwAsY6mqQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FCDE19B9AB4;
	Sun, 22 Sep 2024 00:06:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A3F3195608A;
	Sun, 22 Sep 2024 00:06:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zu4doSKzXfSuVipQ@gmail.com>
References: <Zu4doSKzXfSuVipQ@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <557229.1726963607.1@warthog.procyon.org.uk>
Date: Sun, 22 Sep 2024 01:06:47 +0100
Message-ID: <557230.1726963607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Chang Yu <marcus.yu.56@gmail.com> wrote:

> -		tail = kmalloc(sizeof(*tail), GFP_NOFS);
> +		tail = kzalloc(sizeof(*tail), GFP_NOFS);

I'm deliberately not doing that because of the performance hit.  That's 31
pointers of which, in many cases, we're only going to use the first couple.
There's a bitmask indicating which pointers need putting and a counter that
indicates how many are used.

David


