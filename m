Return-Path: <linux-kernel+bounces-220980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62D590EA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FB1F230B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CB713DDBC;
	Wed, 19 Jun 2024 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aoLPbKyH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="avIcTGke"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5A824BB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798036; cv=none; b=HAH0NNP2Ob9MFjm6Q7UNfHEa37/313Mp8L5IBB5kSSLuKTlV2KlhTTkhEeD3f5ZAYNyB4dK4BVX7vj2VTYBruiOeXCxClCU67ePvZ07YaJfqsYZfT0wVA8IXFQT0Tqxr29fuOhRSUMaUN/OSc/UErpDi5UAsktZXrGrlzaZKaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798036; c=relaxed/simple;
	bh=YQrA+Ofvibruv+RsEPT/k3pCMNmlIvJ6DgMoqoSFrCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lA2hP5KaQHFG6+yz6O+Wo1Tjjy2bb4NrrodLlZpk3AW80xgAVvYBFVRSyty+4s1LMApzOlm53D9YUxyg4oVntbwtO/Y/npaC4noIcsDfkVhtLi5uOQQ03Z67KiYmcYhAUZGZ4zALKQTCcEiNidxRKcwa08Or7yMRhWKpl6r0g3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=aoLPbKyH; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=avIcTGke reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718798032; x=1750334032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6/L5C5Os3SSiFRpcPCNc5RhU6USXqMj9n8kh1VrLr0c=;
  b=aoLPbKyHOIyiNYgG77RAmNkUv8ITWNYl/medXAiBWlQvI9CPTuGfZD7Z
   7q8t2iRKbe1ECGQbA9pC/7urAqh6ZaebANNBQbFylXpBZzIr9B1nN6ylM
   6OfDc93NRyo+B+OvfNLkkC5uR4MoxYKrlSeZNMhpkFrHsTcTxU+b0/sXt
   UexwBNzhriUXTfdOQU1CzHPFhFXRxdW3jGqyWNdvXKPvjcB99uGX+Ybr3
   Qt4FLsr1HVUo8pOuVQS7NJCbZn5N5F2KIm/fSgolDVBuKrFKX1nk5tqj0
   E0IKzzbqfc1tjzLHoGHifBYYiJuqiKGWxPaJ5oCK/B3c7BbfrAO5Rk2nc
   g==;
X-CSE-ConnectionGUID: oPfshukWQT+q8qz9jArq/w==
X-CSE-MsgGUID: RzchgCHlQy6l4zaLJEXYoA==
X-IronPort-AV: E=Sophos;i="6.08,250,1712613600"; 
   d="scan'208";a="37475493"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Jun 2024 13:53:49 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B94A161187;
	Wed, 19 Jun 2024 13:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718798025;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=6/L5C5Os3SSiFRpcPCNc5RhU6USXqMj9n8kh1VrLr0c=;
	b=avIcTGkeuaV51Y45OWg7+8HYVrxR67zKW/3jvQ8LbgXy2ivZd3Smj+GJC5K/uhQqxgFT+6
	BMDHpJ+9XV6Bn3D37donlTkxS4OqH+W8Odprlrw4jOer/Uud0GrgQaDNSUUhHQcsEOciOk
	NTb7NfJlrL+NUISlnDTvzCGAJuD3UuBQIuf4COqDGwplgXu/mrzxgW+AqyUqmkgh+JQowf
	7kF1CFghKEyPVYnYAq4O9RSkf2RAxC9/OsA3bqpgmIk8vzxvuQ9Q/oXERT6Kge+LksazuW
	K5v3W0wtvBQuZ7rBiQ8t6PZq20yUX9hIYv/jiZoI+TYNSFLJX6gjw5cq09x46A==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Andrew Davis <afd@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] mailbox: omap: request shared interrupt to fix initialization
Date: Wed, 19 Jun 2024 13:52:58 +0200
Message-ID: <20240619115258.108557-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The TI AM64x and similar SoC families have mailboxes with two channels
each which share the same IRQ. The IRQ must thus be requested with
IRQF_SHARED, or initializing the second channel will fail.

Fixes: 3f58c1f4206f ("mailbox: omap: Remove kernel FIFO message queuing")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mailbox/omap-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 46747559b438f..03187c65f98bf 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -230,7 +230,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	int ret = 0;
 
 	ret = request_threaded_irq(mbox->irq, NULL, mbox_interrupt,
-				   IRQF_ONESHOT, mbox->name, mbox);
+				   IRQF_ONESHOT | IRQF_SHARED, mbox->name, mbox);
 	if (unlikely(ret)) {
 		pr_err("failed to register mailbox interrupt:%d\n", ret);
 		return ret;
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


