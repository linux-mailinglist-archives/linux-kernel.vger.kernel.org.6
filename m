Return-Path: <linux-kernel+bounces-430006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838EF9E2ACA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D5C285586
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC11FCF41;
	Tue,  3 Dec 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHnLK8hx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768361F4733
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250457; cv=none; b=ZWolqGNE56QjHNPBwNHIBpCLEjvbMxDd5134s3elvUuBgyMdY2KjA7bHASesL0mnAQcBPt2L5n84hvbUNP8ufzE8VLZSpoKeOvNzejnmoHXpYqpykB1QmEykEMoxL2AtZZY0FJpqGBKMkIhsQ2z1+WnCdlE65xYkg3WbyTtXsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250457; c=relaxed/simple;
	bh=5HGdaZ9Ra1+ZAPqqe+CxmybP2bWJqT5uZHVEzA2wfJc=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=KiVbJUyubQWQBy1ehsaJHyZXgF+I31AJZAOjrgW8j0cAL6+vuSZns59BLb9nfFzza11hPzq6yTpz6eVb4EotpR+wyKzowtrMa3TU+zhhI1PI0083Ur4bUENSyKc5WJ5yUJal0cgYhUkeJ7yQuIZArIjs3POHk6VOY12pSk4rrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHnLK8hx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733250454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=EmiuDFB8f/vAqkLlrCN9e4fPptaLGdfl54A6B37sFKM=;
	b=UHnLK8hxfs04psOx3HKc5aoO509eyl41CuXxkx6UIU6VrG5UjQQZM49Ky/JYdaOsM56aSo
	KqmlN6MBannbT2jWKIgQ6arRi3MutvWvqVcF9chhA4NgJGPzkMQNXm8PvpDsw3tZqLkQ9g
	OiJpHs3A6ISMlDo14OcCQBj+pZz5WDQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-mzsYFnhBNECzURDzQL9YUw-1; Tue,
 03 Dec 2024 13:27:31 -0500
X-MC-Unique: mzsYFnhBNECzURDzQL9YUw-1
X-Mimecast-MFC-AGG-ID: mzsYFnhBNECzURDzQL9YUw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3777B195FD1A;
	Tue,  3 Dec 2024 18:27:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC7D01956052;
	Tue,  3 Dec 2024 18:27:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Checkpatch miscomplaint about macro parentheses enclosure in traces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <676595.1733250446.1@warthog.procyon.org.uk>
Date: Tue, 03 Dec 2024 18:27:26 +0000
Message-ID: <676596.1733250446@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi,

I'm seeing:

	ERROR: Macros with complex values should be enclosed in parentheses
	#61: FILE: include/trace/events/rxrpc.h:484:
	+#define rxrpc_tq_traces \
	+       EM(rxrpc_tq_alloc,                      "ALLOC") \
	+       EM(rxrpc_tq_cleaned,                    "CLEAN") \
	+       EM(rxrpc_tq_decant,                     "DCNT ") \
	+       EM(rxrpc_tq_decant_advance,             "DCNT>") \
	+       EM(rxrpc_tq_queue,                      "QUEUE") \
	+       EM(rxrpc_tq_queue_dup,                  "QUE!!") \
	+       EM(rxrpc_tq_rotate,                     "ROT  ") \
	+       EM(rxrpc_tq_rotate_and_free,            "ROT-F") \
	+       EM(rxrpc_tq_rotate_and_keep,            "ROT-K") \
	+       EM(rxrpc_tq_transmit,                   "XMIT ") \
	+       E_(rxrpc_tq_transmit_advance,           "XMIT>")

in the trace headers.  However, this cannot be parenthesised as one of the
things it is being used for is to generate an enum, thereby reducing the
number of times the list of symbols is given.

Can this be at least downgraded to a warning, if not waived altogether, if the
file is in the include/trace/events/ directory?  Possibly the "EM"/"E_"/"EMe"
prefix could be checked for.

David


