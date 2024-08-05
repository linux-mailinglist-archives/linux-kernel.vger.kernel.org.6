Return-Path: <linux-kernel+bounces-274385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 935F5947798
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCCA1C21403
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD2614F9EB;
	Mon,  5 Aug 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Xw7nI+os";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RvmDsTtE"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A11474D7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848055; cv=none; b=FQMq2h3usrg1bItY9Y6sLeUC7iNPF4f0qQUIo4ovezQoEJwX4kZOGzaYLj0U+T8hRDz2CDTGRiTMQ8QR0zJjGPrxd7ler3Q7SvQKbSSHMDfEuegiAywH7kiObeIBlX0pBxJCOMaH66hT4MLCDVtUSD9A9qyak68/hfRMeP+yXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848055; c=relaxed/simple;
	bh=LTZgk4Q7yEHgsYa/3BCj3o9FpVWAGqL0/melW16hM1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj51mPrw4N8ODmjYwWsRd7gXA9gD0BLP+DcB2MEVeRu85QdlQzcGQamzcROZEa2n/ssrN7jCdKe9tSZO63UB6UizBFtr+2wIq+k038hfOCZ1UpZXPabjlovLSM1ciwbNwK5LBVxpJ08Q9gFHhpv+L8y8XhjZ0sVMpZ7AnH8LqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Xw7nI+os; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RvmDsTtE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 502F31151C9B;
	Mon,  5 Aug 2024 04:54:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 05 Aug 2024 04:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848053; x=
	1722934453; bh=96B7qG2RXUCqvEU76ArBM5B2OlW27Ke00tHiDtOnSak=; b=X
	w7nI+oseErLaEdC9C5UVw1plc2OMYvt8gD2mtUUdGw3z/zw6jbYYcGa8Hw2EFipd
	fh/eYqbEdZ9NJWZql5GZQ10mroMgNquxChFOGrJfEW8BC5Ejm5+eYzj3ajcajxj0
	33uhXTgEP8ETqFrYDD8qtIz1R21J4eFPe9WyzYlaNPWlHt8lNE7FyURKliGChIeE
	SYc2QLx5JEvgPoetdHi4rqsVxETUHXdMUMKbz8vREedaj9FSXc/f4zT/hnRAIhU4
	MXAKOMV/K21fcUYzOFO/rT/qx00hAyDshfbMbXTKLzt8KQ0rRHsMb8+8pZTkHqIy
	Hq/nxEmpqXznXprR5jAKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848053; x=
	1722934453; bh=96B7qG2RXUCqvEU76ArBM5B2OlW27Ke00tHiDtOnSak=; b=R
	vmDsTtEp62s22RsWxZ5jSNfUEf/uutbAtTgXeOG1g3ypoXUFW4OBZo3hZ/yDEHh/
	5HzjcTfdr++j87U3Aw7fDm2DJ9l3MDoiOcvrA9O6KC3kMZSbqGiWTiC3Fvrv3FcA
	A7L10NzQUrVBLujWzki+SSQ3OrcErMxwgXvUvArevRPCD8Kh2JvlXyeBZfcohq9E
	2XZH8C28XbuBZfmtpSsGyZ5gyzHrkmN5TMQNw7Pdm4UUGERcFMB0i++DbZHQgvK0
	mz49FREaOh/xJOPDa8mvvA2pvuxSKJa4F5bSeKVJgDiYFl7VS+y9bc8eeOurzJKY
	Z9tqhwdAsJ2SumziwObAw==
X-ME-Sender: <xms:NZOwZrsEgQCUW_JhRyKb46YQ2PisGMtudj8SiME-58TyrV1Wi_PZdA>
    <xme:NZOwZschie_x7bp0DLZOrmr0tG6dAzu-pE8E4gFoPElxXa3P2-C2OJQLgbKjL3QUS
    6sZsxJ0wOUm-UednqA>
X-ME-Received: <xmr:NZOwZuyDkN7iZJY4UpS7QfkqndxXdO9-ibVQuXeOfsRRsZyq0ursh4K2JloeN9rzSpN3k48gl-h5QgOOC0clGzW6QPOIwtsTlJHHP3XeRDU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:NZOwZqOfgSRopmfTlYJzjpy6zMpuHSOnjw7CaL5cccukYZBung2Qag>
    <xmx:NZOwZr8uJcFiPM-lJMgdeO8zFtcd3HJg1KozFxyRoQcm8LGikv9NOQ>
    <xmx:NZOwZqUdz99pXNLsWv5WxiW8p0XBUDh6P0VwmAQWVq9Y4PgI65uCnA>
    <xmx:NZOwZsduizwb3N8AlF6N6qdecVAX2bswqI4wGFMTA1OB_Nzeh43ZWg>
    <xmx:NZOwZtK0OR0aq3IG3I-wF5cdf1Bwn9YahBorIAFoHspQTzRmd6Ghh3zU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:12 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/17] firewire: core: use guard macro to maintain static packet data for phy configuration
Date: Mon,  5 Aug 2024 17:53:52 +0900
Message-ID: <20240805085408.251763-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
References: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core function provide a kernel API to send phy configuration packet.
Current implementation of the feature uses packet object allocated
statically. The concurrent access to the object is protected by static
mutex.

This commit uses guard macro to maintain the mutex.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a89c841a7dbe..2a2cbd6e2f9b 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -494,7 +494,7 @@ void fw_send_phy_config(struct fw_card *card,
 	phy_packet_phy_config_set_gap_count(&data, gap_count);
 	phy_packet_phy_config_set_gap_count_optimization(&data, true);
 
-	mutex_lock(&phy_config_mutex);
+	guard(mutex)(&phy_config_mutex);
 
 	async_header_set_tcode(phy_config_packet.header, TCODE_LINK_INTERNAL);
 	phy_config_packet.header[1] = data;
@@ -508,8 +508,6 @@ void fw_send_phy_config(struct fw_card *card,
 
 	card->driver->send_request(card, &phy_config_packet);
 	wait_for_completion_timeout(&phy_config_done, timeout);
-
-	mutex_unlock(&phy_config_mutex);
 }
 
 static struct fw_address_handler *lookup_overlapping_address_handler(
-- 
2.43.0


