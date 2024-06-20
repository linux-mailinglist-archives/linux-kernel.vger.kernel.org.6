Return-Path: <linux-kernel+bounces-222640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B4910526
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E540F1F2170C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250551B5812;
	Thu, 20 Jun 2024 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/oa2mCI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B431AD9EE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888197; cv=none; b=L/2IOcDWxHwKYdbtL8VLumLFKQNwhtvLRwjK9CrqEW6qiSXG9bjX9rKS2YCYGvI2yG333IlLQdSspELq98WeUJJETcUpoXsnU+ciKSEB3rYd3++Fna/yEJ9COTvN6RbYqPrpYod+X2inv6MdvJkdIk/mCN7L6Zn8IUYMwa5S7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888197; c=relaxed/simple;
	bh=RZ14lsCYb4YxKJjabopa0avjAflKI1wcPKwGhod+Gzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwQ5+LPxmmrzKZ63LRdbCv7PUCdwUt1Mo3IrFzyi4NcJtZ//lHB4OrVcwU9DWd6k3rfe/zXL7o8/oe+I+kd0HEFGvHSh50bns62y6pSfgoiJhD5j3S0xGYRL9gnG5nbHmi7IrWOKSze0ccTr0/NM8OSfhQ+kgFNjdmu1Dnc0bW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/oa2mCI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718888195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MT58cRhLJAAVBSqhZOpx+MX2NQrfS9vYxE2s7Gss0cM=;
	b=U/oa2mCIf21uiDjUPfsO1vjfBQdDsE1aDfBziQBiKrZY32u1Ctn+zs4tuQ1rZU+WcsAjAf
	pZRSPfUepk+D0rH58w5XuxrA0hyaFcLJ3GgCCjCRa2ql1zd4B+yASz5bUFCdzzJFV/xDoL
	jCwpLJWalRwhMiuuhpa6ilMhpaSB5KA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-7wKk4AGJNyqBx2PAe4xtCg-1; Thu,
 20 Jun 2024 08:56:31 -0400
X-MC-Unique: 7wKk4AGJNyqBx2PAe4xtCg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 635421956062;
	Thu, 20 Jun 2024 12:56:29 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.9.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 531141955E83;
	Thu, 20 Jun 2024 12:56:26 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 7/7] selftests: net: add config for openvswitch
Date: Thu, 20 Jun 2024 08:56:01 -0400
Message-ID: <20240620125601.15755-8-aconole@redhat.com>
In-Reply-To: <20240620125601.15755-1-aconole@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The pmtu testing will require that the OVS module is installed,
so do that.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 04de7a6ba6f3..d85fb2d1f132 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -101,3 +101,8 @@ CONFIG_NETFILTER_XT_MATCH_POLICY=m
 CONFIG_CRYPTO_ARIA=y
 CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
+CONFIG_OPENVSWITCH=m
+CONFIG_OPENVSWITCH_GRE=m
+CONFIG_OPENVSWITCH_VXLAN=m
+CONFIG_OPENVSWITCH_GENEVE=m
+CONFIG_NF_CONNTRACK_OVS=y
-- 
2.45.1


