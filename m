Return-Path: <linux-kernel+bounces-269006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA5942C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7B0285767
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F11AD3F7;
	Wed, 31 Jul 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5sa+1C4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45391AC43B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422477; cv=none; b=arfRc6p42JT9QvUuwnnuz16WSTZ1oUjkDESAEDiInzcu10hHdmy5NpQmVnz2P1dgnlxI/jG6Ce4l9MwSpTHeXvsDyDNbpTji1fSJW8GswPTgBptQcCRCnvzRR2rfNWNb17PwIOwrW9i/Ok2zpuFk8FkRgd4EsaFMf+OdZSy0EyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422477; c=relaxed/simple;
	bh=DqYZ5STz9vnEwRu/V8Eme26ZMwgmq8Zah47tPzzpGbw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=p8aATbyi946fIZXAki/k1N9zD0WhzhLJi2AhxY97WBFaqCbO56LE2iERBN+i4kN9kUVqmk9iVIIs0yNfXfGROM+TiXDXFP57lbldIUHF2rZgEAN7SIE++bIzuZ3dwEbZEHfFwRxs+Ri1eNa6odQw1eIhcI/w5Zc5RJVtEiAjUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5sa+1C4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722422474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6G1qM9eT2x8ssI1V4rGxcfkfdJn4nj53XrSd0SvXMg=;
	b=b5sa+1C4HVfJne4/9wJZchfbgAOIW6JfkDM2p2wlluYOnY10PCUFGPKcR6MRvLLt0VMYfN
	xAL3EL1EsN9aSwL32tcb74dCQ1+AlllzLnPs7yyCsdCuJ8mm8j/Sjn9il82zMObC9rc2Ke
	f8UiCfyiGr8C8DF0WQ2iFWoC3Gd4FE0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-7LMUdm6QOhGR78baj6--1A-1; Wed,
 31 Jul 2024 06:41:11 -0400
X-MC-Unique: 7LMUdm6QOhGR78baj6--1A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A854E1979065;
	Wed, 31 Jul 2024 10:41:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B17C219560AA;
	Wed, 31 Jul 2024 10:41:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+-4C7qPrOEe=trhmpqoC-UhCLdHGmeyjzaUymg=k93NEA@mail.gmail.com>
References: <CAKPOu+-4C7qPrOEe=trhmpqoC-UhCLdHGmeyjzaUymg=k93NEA@mail.gmail.com> <20240729091532.855688-1-max.kellermann@ionos.com> <3575457.1722355300@warthog.procyon.org.uk> <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
    Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
    willy@infradead.org, ceph-devel@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] netfs, ceph: Revert "netfs: Remove deprecated use of PG_private_2 as a second writeback flag"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3717297.1722422465.1@warthog.procyon.org.uk>
Date: Wed, 31 Jul 2024 11:41:05 +0100
Message-ID: <3717298.1722422465@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Max Kellermann <max.kellermann@ionos.com> wrote:

> It was not caused by my bad patch. Without my patch, but with your
> revert instead I just got a crash (this time, I enabled lots of
> debugging options in the kernel, including KASAN) - it's the same
> crash as in the post I linked in my previous email:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 13 PID: 3621 at fs/ceph/caps.c:3386
> ceph_put_wrbuffer_cap_refs+0x416/0x500

Is that "WARN_ON_ONCE(ci->i_auth_cap);" for you?

David


