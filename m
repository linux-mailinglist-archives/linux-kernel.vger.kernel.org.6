Return-Path: <linux-kernel+bounces-221745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BABB90F7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CDC1F2257F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7D15B553;
	Wed, 19 Jun 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0lfIalt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB715B140
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830852; cv=none; b=O92Ge/OJKMLosUr3H7EuPxW2HryWkODsHi/3CoYfWsCpVSOib9Wi11xVGZ9aJHxE8CegnqfyEcfPP0k33y5WmzXWl+Ws237bQ+fh/u7aJSZ4xfccLy5TL2Hpy/FF95ZFedQ0GgM+TdSsiw8S3ICLKEhR425PS9Zv+/4mqI1L5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830852; c=relaxed/simple;
	bh=5pAd5l8SzMmlQSEbbBoeGexj0e42jZKo6+z9g7T1oew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTnKXs67f2SX8VQp42V83ctmqmau4dFlF1I0BIMp2RZiGcC9nH6aQnsnDGPRgkpuQ4Yr18JqMC22Ch8LJO6thXcUr1o/ih2d6f4K6reIUwzpt7hQLKH8yi7QJn5VxFVLIcr/72K03ygz12zGnKIwz0n9kDBwLmfQQpxuuwKQEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0lfIalt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718830850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maZ9TMPYGbzb/EBP71+0JWLbUHEakzvhjd9HxWMo8cg=;
	b=I0lfIaltKY643uh0qKr6yNXC9Sai8vfaXLaBRN/6reJbn1VaFWO32Aa2UKmmeFOSekrslZ
	yssyOUDhfSshby0v5Y+fieivO1jugQ9L9Lz7oF9VjCXkeVwf6W10wjzlC6KwOKtoG4C5IB
	+pKJnlbnaaKFK0sJYOhIWeOAX2mURds=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-2XxbiWXBP0mG2Y7-X9m8mw-1; Wed,
 19 Jun 2024 17:00:47 -0400
X-MC-Unique: 2XxbiWXBP0mG2Y7-X9m8mw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01FCE195608B;
	Wed, 19 Jun 2024 21:00:44 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.189])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB50519560AE;
	Wed, 19 Jun 2024 21:00:39 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 03/10] net: psample: skip packet copy if no listeners
Date: Wed, 19 Jun 2024 23:00:04 +0200
Message-ID: <20240619210023.982698-4-amorenoz@redhat.com>
In-Reply-To: <20240619210023.982698-1-amorenoz@redhat.com>
References: <20240619210023.982698-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If nobody is listening on the multicast group, generating the sample,
which involves copying packet data, seems completely unnecessary.

Return fast in this case.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/psample/psample.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/psample/psample.c b/net/psample/psample.c
index b37488f426bc..1c76f3e48dcd 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -376,6 +376,10 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 	void *data;
 	int ret;
 
+	if (!genl_has_listeners(&psample_nl_family, group->net,
+				PSAMPLE_NL_MCGRP_SAMPLE))
+		return;
+
 	meta_len = (in_ifindex ? nla_total_size(sizeof(u16)) : 0) +
 		   (out_ifindex ? nla_total_size(sizeof(u16)) : 0) +
 		   (md->out_tc_valid ? nla_total_size(sizeof(u16)) : 0) +
-- 
2.45.1


