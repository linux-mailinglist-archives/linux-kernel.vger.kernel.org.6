Return-Path: <linux-kernel+bounces-280667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FB94CD7D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6D41F221F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DECB1922C9;
	Fri,  9 Aug 2024 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoyGEjGi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F1BA41
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196619; cv=none; b=uSKVyWqcdX+FkSy9bYEWqiCw/iyD2zx19OUi0UrJXxiJwFHYH1piRBuX6VdsyZ06zHMtlmfr7Y5CpDpHKlnAXxbOMUBOLj1J4CbHcaOBeQdQ6hHQc/Q9hbEK8kfLWryBTC0UEkgT85stNll3HIb602py5nXMEHm7mjTFjKJTPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196619; c=relaxed/simple;
	bh=c+rmZIzInoBT2KFCTHVlr3jD8s3CtnlHvec/G7ZojvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iUApQXeliu2gvivLx0I3dr6Re+Zipv7uNWQ3IehnVeOXnaR9b+aAaR2p5aQnx+J4VO8S+oEcRz1+i36svd1e4jfIsNFoG29z7uHcIFpkDTlZWbbor9dBt0dooV2Sqwlf3iSaukdTVk9ULjhRntAeYrifXzOJOFuZOrxh0QGEflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CoyGEjGi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723196614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FLR5xQw9vyqJru3cGFEnuo/Pv6LW2/XUDyfd3LTMiu0=;
	b=CoyGEjGiRSbQQGz54IOvfbAbPJAjL6oqIMOrP40N3wK1zA9WaFLJYETthuiLy9nTCXCaVo
	Jn0Yq+g+WqdKXWtBxmTS6TuncbIzYkYxFGPWUSgNGChXTDkUA1sJCtR5WMyLywkqtbZGte
	bo6ThVkawKM8uBVnl7Tbvqf9ON9Lh9M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-QwfZbvEoOcaLMwdsPOBXKw-1; Fri,
 09 Aug 2024 05:43:31 -0400
X-MC-Unique: QwfZbvEoOcaLMwdsPOBXKw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 896681955F3B;
	Fri,  9 Aug 2024 09:43:29 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99F51300019B;
	Fri,  9 Aug 2024 09:43:25 +0000 (UTC)
Date: Fri, 9 Aug 2024 11:43:21 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved size
Message-ID: <20240809094321.GA8122@asgard.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

ssn_offset field is u32 and is placed into the netlink response with
nla_put_u32(), but only 2 bytes are reserved for the attribute payload
in subflow_get_info_size() (even though it makes no difference in the end,
as it is aligned up to 4 bytes).  Supply the correct argument to the relevant
nla_total_size() call to make it less confusing.

Fixes: 5147dfb5083204d6 ("mptcp: allow dumping subflow context to userspace")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 net/mptcp/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 3ae46b545d2c..2d3efb405437 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -94,7 +94,7 @@ static size_t subflow_get_info_size(const struct sock *sk)
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
 		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
-		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
 		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_FLAGS */
 		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_REM */
-- 
2.28.0


