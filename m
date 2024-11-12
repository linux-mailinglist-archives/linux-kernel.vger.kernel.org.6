Return-Path: <linux-kernel+bounces-406139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48919C5B67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990D62831F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF720010B;
	Tue, 12 Nov 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVCLhh0j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B51FF044
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423856; cv=none; b=K7kD2cEkrjbUgB4VbXSSjnbTSkhgPekUW7CCHtfzBylGdlc69m1Hat/FgcswRN23JtYXXladUefRSZFFF4zWHLDn/hB9NwzkmO8lWpJ8jwrUT1XUnWbYCDzDV5SIJQwULlq7ykDoe+EM37kYQ36INo5blvkuXv6k021SuiqZ/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423856; c=relaxed/simple;
	bh=6h5pADxNne9d8m//9uJHWM1499lvxVfSbKp4qax5VKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=naDh26N+TzDVl6GS1+EicU946ctMgAKrrfrBB87Sj0S7htaFm13LHUmNQ48P7onUQX95dGteE06vxS9VVP9FZLJI2jam8EDO6o1TUWy3wHdxsg9NuZQe8cKMzXqc7bXuDY3qcRS78dO50SYmmvv57o6u764n+FnYdrmBbf8ctqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVCLhh0j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731423852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j0W+PnPsRwyZd3T+tjupo+6i4tCF4pLBt+SKLFRqZtg=;
	b=KVCLhh0jgVxH3H/iQZZfNYnZnyzinGunqqr0ZDlqox2hKrKkKLKa7f/6SmH/gcBXfvVR59
	LLLnmFSOPABK7G3853y4fJo+WVdjj7O3HmPEumHbC91Mv62gso1JLtVXD0qW8/sfOST1gX
	pY0DhHKJNaxryv/bL3BGSdcbEEHbjoY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-2Qg6Dtf2NSSXIBkdg5BxEQ-1; Tue,
 12 Nov 2024 10:04:06 -0500
X-MC-Unique: 2Qg6Dtf2NSSXIBkdg5BxEQ-1
X-Mimecast-MFC-AGG-ID: 2Qg6Dtf2NSSXIBkdg5BxEQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A8EE1955F09;
	Tue, 12 Nov 2024 15:04:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.225])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BCDF1955F40;
	Tue, 12 Nov 2024 15:04:02 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-hyperv@vger.kernel.org
Cc: mhklinux@outlook.com,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hv/hv_kvp_daemon: Pass NIC name to hv_get_dns_info as well
Date: Tue, 12 Nov 2024 16:04:01 +0100
Message-ID: <20241112150401.217094-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The reference implementation of hv_get_dns_info which is in the tree uses
/etc/resolv.conf to get DNS servers and this does not require to know which
NIC is queried. Distro specific implementations, however, may want to
provide per-NIC, fine grained information. E.g. NetworkManager keeps track
of DNS servers per connection.

Similar to hv_get_dhcp_info, pass NIC name as a parameter to
hv_get_dns_info script.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/hv/hv_kvp_daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index ae57bf69ad4a..296a7a62c54d 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -725,7 +725,7 @@ static void kvp_get_ipconfig_info(char *if_name,
 	 * .
 	 */
 
-	sprintf(cmd, KVP_SCRIPTS_PATH "%s",  "hv_get_dns_info");
+	sprintf(cmd, KVP_SCRIPTS_PATH "%s %s", "hv_get_dns_info", if_name);
 
 	/*
 	 * Execute the command to gather DNS info.
-- 
2.47.0


