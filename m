Return-Path: <linux-kernel+bounces-333731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C797CD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2990A1F2439A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2156B1A2547;
	Thu, 19 Sep 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzPJQ3dC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766A1EB56
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766904; cv=none; b=HlVRIDzAPstPrEXCNXdBP0R4Drkh/RCEJrkGQNBP+M3jyKZVzgZJaSAllzUX8IsqKf4kukHUVqdBQFWt/ifiTLerzoIFNafHXHs1/PP54I/kTxBwvkQahIwn/bIQ8/VwGhVfgv8aaEH6g4vRU66eBmZ7MxOUB8lxQUD0y70bpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766904; c=relaxed/simple;
	bh=q/8GZpdOgpQYLd5/b98y+bVNGR7nE/3+3PLEFu3cics=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RhDTZmHQZF7LEyguUxaV2oaFjKa0P6EN58TPP0zcKKTybBe7pWtsCOGcunwjNTp/w4iP8q+FlijUpRmIrvfPnWT6DOmovVW3hz/myppBPJvqLk2MA4RmFn4IDUWSToOzfs9pBv7nLBNVH31Q76SQY+EW0Ks5lxYXUet1mO78dig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzPJQ3dC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726766901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jtAIQYly13WhE3zNfo9XsIwX5Uobm9lPqxpjxAY62es=;
	b=AzPJQ3dCfcXsvJQ2QG1gK1SGnEBNcqQmYuY42cG/kXyV3qiaNpey0PCDjy0Oz+mhs0U/8e
	QiQ+nLY9Z8j7aE4Iyfmh7uRo4V37Z7hZqbmuSHwRuVFdX9hwPlD45xaytwf82GVJgOZ4i4
	3eN2tk/NUKuqpdZje2+0vt8KKoMcMfM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-xqh_ZZwVMGqy18vORT_p-w-1; Thu,
 19 Sep 2024 13:28:19 -0400
X-MC-Unique: xqh_ZZwVMGqy18vORT_p-w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F4B01944D3F;
	Thu, 19 Sep 2024 17:28:18 +0000 (UTC)
Received: from desnesn-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4684A19560AA;
	Thu, 19 Sep 2024 17:28:16 +0000 (UTC)
From: Desnes Nunes <desnesn@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl
Subject: [PATCH] media: dvb-usb-v2: af9035: fix ISO C90 compilation error on af9035_i2c_master_xfer
Date: Thu, 19 Sep 2024 14:27:55 -0300
Message-ID: <20240919172755.196907-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This fixes a 'ISO C90 forbids mixed declarations and code' compilation
error on af9035_i2c_master_xfer, which is caused by the sanity check added
on user controlled msg[i], before declaring the demodulator register.

Fixes: 7bf744f2de0a ("media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer")
Signed-off-by: Desnes Nunes <desnesn@redhat.com>
---
 drivers/media/usb/dvb-usb-v2/af9035.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index e63298e30a31..ee5dccc0b509 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -321,13 +321,16 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			/* demod access via firmware interface */
+			u32 reg;
+
 			if (msg[0].len < 3 || msg[1].len < 1) {
 				ret = -EOPNOTSUPP;
 				goto unlock;
 			}
-			/* demod access via firmware interface */
-			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
-					msg[0].buf[2];
+
+			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
+				msg[0].buf[2];
 
 			if (msg[0].addr == state->af9033_i2c_addr[1])
 				reg |= 0x100000;
@@ -384,13 +387,16 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			/* demod access via firmware interface */
+			u32 reg;
+
 			if (msg[0].len < 3) {
 				ret = -EOPNOTSUPP;
 				goto unlock;
 			}
-			/* demod access via firmware interface */
-			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
-					msg[0].buf[2];
+
+			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
+				msg[0].buf[2];
 
 			if (msg[0].addr == state->af9033_i2c_addr[1])
 				reg |= 0x100000;
-- 
2.46.0


