Return-Path: <linux-kernel+bounces-363032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4DF99BD23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8544281640
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 00:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D13FF1;
	Mon, 14 Oct 2024 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMRRg7jW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F14C7C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728866868; cv=none; b=eYG0ehTRV5DhZ8240nUsTvd121z/gcWgl2gQ9z5TelZc6Y1Swi5ursfgU7LxhE9T8ItH+0MTwiEhD8R+xhBEqWxYIzbT7m+E00WqWunys6ZkXserZb1Ya/YIqJ4t5mNqD7tvPI8fEBN8ZGTUAjlSRDvCBsM5FPaJViue/Uw+AYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728866868; c=relaxed/simple;
	bh=3KGQob7k6Ew8a0A8C5bPWpWol4v3kwZJKffbU9ctFuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 MIME-Version; b=kEyT8LMzyAm7R2Tkg/zcaO4XV+5vkrXJmvnKkkMGvwOYrpdhcQ2cVmqvH5dpAI0kFaqgLaV+mfG5pNn5cA2ajQUUBAtTA1NZ7S2/RJ2zbP9KFVUuVkzO6HZJBiC9aXmX8+vxmPgXBKq7RakfkMzz2lk0udu1COKBAjtALdbADXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMRRg7jW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728866865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:mime-version:  content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X05hnwmFfahTamUd2ZyCmOrUz5+WC9QCz0YioOU37gU=;
	b=NMRRg7jWvywpd0R9GstwQ7/duc+43vYKpnj7BgrFwvks7TiMEvpXBj4Fza/So9N8irwT/y
	YLQuoUfKdqg428EiVB6sSEQ2Vk/SYYcPH6NkntBNLXHFZ9WiOLgzNP0a0ODRX8FAuwVcH3
	QmEBY72wq//0g78AYZlsm+HjRGjoEd8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-_PDTQTuXM4ixcBjULnFfOg-1; Sun,
 13 Oct 2024 20:47:41 -0400
X-MC-Unique: _PDTQTuXM4ixcBjULnFfOg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DE7A19560AA;
	Mon, 14 Oct 2024 00:47:40 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F45B19560AA;
	Mon, 14 Oct 2024 00:47:36 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	shan.gavin@gmail.com
Subject: [PATCH] firmware: arm_ffa: Fix warning caused by export_uuid()
Date: Mon, 14 Oct 2024 10:47:24 +1000
Message-ID: <20241014004724.991353-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Run into build warning caused by export_uuid() where the UUID's
length exceeds that of ffa_value_t::a2, as the following warning
messages indicate.

In function ‘fortify_memcpy_chk’,
inlined from ‘export_uuid’ at ./include/linux/uuid.h:88:2,
inlined from ‘ffa_msg_send_direct_req2’ at drivers/firmware/arm_ffa/driver.c:488:2:
./include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ \
declared with attribute warning: detected write beyond size of field (1st parameter); \
maybe use struct_group()? [-Werror=attribute-warning]
571 |                         __write_overflow_field(p_size_field, size);
    |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix it by not passing a plain buffer to memcpy() to avoid the overflow
and underflow warning, similar to what have been done to copy over the
struct ffa_send_direct_data2.

Fixes: aaef3bc98129 ("firmware: arm_ffa: Add support for FFA_MSG_SEND_DIRECT_{REQ,RESP}2")
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/firmware/arm_ffa/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 4d231bc375e0..154777e89f04 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -485,7 +485,7 @@ static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
 		.a0 = FFA_MSG_SEND_DIRECT_REQ2, .a1 = src_dst_ids,
 	};
 
-	export_uuid((u8 *)&args.a2, uuid);
+	memcpy((void *)&args + offsetof(ffa_value_t, a2), uuid, sizeof(*uuid));
 	memcpy((void *)&args + offsetof(ffa_value_t, a4), data, sizeof(*data));
 
 	invoke_ffa_fn(args, &ret);
@@ -496,7 +496,7 @@ static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
 		return ffa_to_linux_errno((int)ret.a2);
 
 	if (ret.a0 == FFA_MSG_SEND_DIRECT_RESP2) {
-		memcpy(data, &ret.a4, sizeof(*data));
+		memcpy(data, (void *)&ret + offsetof(ffa_value_t, a4), sizeof(*data));
 		return 0;
 	}
 
-- 
2.45.2


