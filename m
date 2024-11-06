Return-Path: <linux-kernel+bounces-398620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D029BF3B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225F01C21814
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6F205E18;
	Wed,  6 Nov 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXD+aOUX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F14201115
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912061; cv=none; b=NoWj17k8a0Vh+vruRPX2igLPZVx5e9zhSPWyf0QfJeOZLOxh2nvaL/ALtcG7PwxeLS5JI1yfHcOWDCCwHwcFhC6KQoq20tEnPe+Pt1cyvp/OqkrMS0CVYbNVVaplMOngDvBlCFDBVJPW7WFE4ldujTt8zvpaiSMkCzs6NezVums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912061; c=relaxed/simple;
	bh=dG6WRTCDdWZxN1ZPonGPv86dVFZaMXolba9LDuLkSyo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ZbcCYUe7fDKCApgRw09KvBsxlfEs2hj2X/gKZyH0epUEIq5ZstW+k2RM/LRoskwHNAuCZoliJBkhyngCTnxpP9zAbQX9ddWKVry+o3c0laQhdEBAmNtRWN0fh68FrWm5JfWIamhQhpqPFBib/seesaF3lfi+l/0W0oIkdZbY2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXD+aOUX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730912057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dG6WRTCDdWZxN1ZPonGPv86dVFZaMXolba9LDuLkSyo=;
	b=ZXD+aOUXhZV5RA+s13hpV221qTh6IZVlo6OB9SuVaDcWiVe+fF1lU5uGbb1EaeF5UCLKGO
	nChIEzyB2JjPQ3S7bIWKM9Prg55CoI4XtDnqwhS3C3fm21/j1Kd+xYO/0m2flsCQxM7nlO
	VNEzwued/9K0xpABSxXwL9vdSMZv4TA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-AiRqPIzVNaeSqZD40U8RZw-1; Wed,
 06 Nov 2024 11:54:14 -0500
X-MC-Unique: AiRqPIzVNaeSqZD40U8RZw-1
X-Mimecast-MFC-AGG-ID: AiRqPIzVNaeSqZD40U8RZw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43AF01955F4A;
	Wed,  6 Nov 2024 16:54:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 581983000198;
	Wed,  6 Nov 2024 16:54:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <726660.1730898202@warthog.procyon.org.uk>
References: <726660.1730898202@warthog.procyon.org.uk>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix missing locking causing hanging calls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <761175.1730912047.1@warthog.procyon.org.uk>
Date: Wed, 06 Nov 2024 16:54:07 +0000
Message-ID: <761176.1730912047@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fixes: 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O thread")
Reported-by: Marc Dionne <marc.dionne@auristor.com>


