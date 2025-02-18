Return-Path: <linux-kernel+bounces-520232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2A7A3A74E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F5916E996
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611751E833E;
	Tue, 18 Feb 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4ScCo7R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1421B9C7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906588; cv=none; b=IhGgD5huXrWfVt6vVtG3I2m4r73/o0BRQ6ULJd503jlWiOVsGoCIgLuoIvgqdWrySHhA8hNjHXgmtBfrgcDy7xoJWplTahlvIZs+/ETP+VfbkG9qqWgynrTouvymbLw9t1PwaJUiQbUoBA7La2rPirT22nx7NMUvNKCHwCcmcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906588; c=relaxed/simple;
	bh=LdM6YWJorqkUh0RrJpizFWheSHgWKS3j4SIexQeKkT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaAlDPNZ43pnJlIPo0zGvQyMj7MrDcLYowc9JTqnrtH8524PkoDLeO0pU3d/cKOSVWxew/6teFdVxIpZKYXfM39boEJfAjSuoiosGuZSC1QBSGz35QIPfkZRtG7EBLuMzHBqzomiyMRn6F0J/yBiATcg18dMXdcFH6XZbNZB66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4ScCo7R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739906586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPX5X0FLbu8i/pSR/GZDg1fvDLeMt1ooWaCQcD/mFIo=;
	b=Y4ScCo7Rb2anjMhr6iYH1v95RB6IwCRNDRoENQCaxQrvQ9eNp/JElNgE/w/nJQ+pLS8LrR
	u0smUKW0Zc9DfGXoHM7wXelIuTFzo22R9C7QeHj8XcDosF/8syCAdWBdqWbJpb9ABb5fu5
	E0YutK+c/2KkAKEUCH1W0WFCKFiX+Js=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-2VyI0uHRP2Cv18UI9ndGCw-1; Tue,
 18 Feb 2025 14:23:01 -0500
X-MC-Unique: 2VyI0uHRP2Cv18UI9ndGCw-1
X-Mimecast-MFC-AGG-ID: 2VyI0uHRP2Cv18UI9ndGCw_1739906580
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 585651800984;
	Tue, 18 Feb 2025 19:23:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A010D1956094;
	Tue, 18 Feb 2025 19:22:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/5] rxrpc: rxperf: Fix missing decoding of terminal magic cookie
Date: Tue, 18 Feb 2025 19:22:44 +0000
Message-ID: <20250218192250.296870-2-dhowells@redhat.com>
In-Reply-To: <20250218192250.296870-1-dhowells@redhat.com>
References: <20250218192250.296870-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The rxperf RPCs seem to have a magic cookie at the end of the request that
was failing to be taken account of by the unmarshalling of the request.
Fix the rxperf code to expect this.

Fixes: 75bfdbf2fca3 ("rxrpc: Implement an in-kernel rxperf server for testing purposes")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/rxperf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 7ef93407be83..e848a4777b8c 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -478,6 +478,18 @@ static int rxperf_deliver_request(struct rxperf_call *call)
 		call->unmarshal++;
 		fallthrough;
 	case 2:
+		ret = rxperf_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		/* Deal with the terminal magic cookie. */
+		call->iov_len = 4;
+		call->kvec[0].iov_len	= call->iov_len;
+		call->kvec[0].iov_base	= call->tmp;
+		iov_iter_kvec(&call->iter, READ, call->kvec, 1, call->iov_len);
+		call->unmarshal++;
+		fallthrough;
+	case 3:
 		ret = rxperf_extract_data(call, false);
 		if (ret < 0)
 			return ret;


