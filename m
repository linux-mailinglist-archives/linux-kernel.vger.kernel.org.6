Return-Path: <linux-kernel+bounces-430004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4129E2ABA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FED1661AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AE01FCF41;
	Tue,  3 Dec 2024 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrL+wHJg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1841E868
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250209; cv=none; b=m/5CnFNcUbH9BnGbaOKIlR+TfOVUhtFeyIdfMxFWfu8BBYjiSoGCrEH3URvsdI7E/6+Qq58b/kvxxRG9ZexLPDp9y3EuqrwcImpmCxWNyV6fKUe4eDqcKQlGVnTp1zv5TyAmKm6tQiBKvi6sszW7la0PNFivaqi1vFtLFDuEC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250209; c=relaxed/simple;
	bh=Gm8BYBFq5ESfeQP5FccasbAPqKY343MLNjZu1L6h8t4=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=nOkpagvofXaqFcxd9oX3g6Mo2LcQ/duBCEgB/oDg+H0uHAF9mfPkd4HJoNlBn6q2K3lEoEADVTyFfC3ASWhyQAPPPYBAiLnzSMwXP5LtkrGQNoRVAXOuYBHNejvUm8cOMzvYcbHuX0n26ZugD+9+0MQlIr1/28OZ4chuSlyxNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrL+wHJg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733250205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=stlRERQ+3aWmc4HxV0lKBLNeU9BMq7VK1iLto4fzPzA=;
	b=MrL+wHJgMueGITB0HuwKc9No+E2QZGKFlL/6s/gFzupsRixKmZ8hKBcgdqgbCS2Gija/+R
	OQNgr66DxqDm03uUXP/ZFlbuWpW+eO6Ku1stwZ4NCdJIuz4VhV6i9XE2saCkCikwioOblJ
	z1tDqIgbRMaMX8wjRuw6AkORjbcyZSw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-TCiAeOjKMF-xqJ9UAVhNYQ-1; Tue,
 03 Dec 2024 13:23:24 -0500
X-MC-Unique: TCiAeOjKMF-xqJ9UAVhNYQ-1
X-Mimecast-MFC-AGG-ID: TCiAeOjKMF-xqJ9UAVhNYQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 533C119560BC;
	Tue,  3 Dec 2024 18:23:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D0CC30000DF;
	Tue,  3 Dec 2024 18:23:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Checkpatch miscomplaint about multi-arm if-statement
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <676504.1733250201.1@warthog.procyon.org.uk>
Date: Tue, 03 Dec 2024 18:23:21 +0000
Message-ID: <676505.1733250201@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi,

I'm seeing this:

	WARNING: else is not generally useful after a break or return
	#1220: FILE: net/rxrpc/sendmsg.c:301:
	+               return -ENOMEM;
	+       } else {

on:

	if (call->send_queue) {
		tq->qbase = call->send_top + 1;
		call->send_queue->next = tq;
		call->send_queue = tq;
	} else if (WARN_ON(call->tx_queue)) {
		kfree(tq);
		return -ENOMEM;
	} else {
		tq->qbase = 0;
		call->tx_qbase = 0;
		call->send_queue = tq;
		call->tx_qtail = tq;
		call->tx_queue = tq;
	}

but you cannot eliminate the last 'else' statement there.

David


