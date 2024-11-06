Return-Path: <linux-kernel+bounces-398977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6A9BF8CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4CA3B22802
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4A81DA2FD;
	Wed,  6 Nov 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhmO4vDR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275261CF2A5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930472; cv=none; b=FvVlPn1aJfF7OVKTnoAcBjlfmt604rvkOzimcScpJs5BpoQjx12wa0RWHMedxCZI/tLiaHdEBIOO4teIYZIYzyRRX9XldMp+QnWgv3Gt4pTLx99boFaMyJRD/Me/Hc2HG8sqlITrwnV8wZWMxZnkotlQEHV0HxpwiHgIsqi2+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930472; c=relaxed/simple;
	bh=Ouf4XzzU9BDiFBs8f/7h+WkG2cfCo4XqkFKzWinQv54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XN944eEckvIQKBJiS8NmaISZkuISldC+6/HDkm9WDaLR6K7eqLxhEqG2EqymmHvfzAqlE4Z3aFumFBSSXTfBza0Qm5pq0W4hWHIBDm/6vrVw7j7oIUEKpwJ7aoDFfMCyBZnnrfEonWF8gc0pUqADXrH1C6+HIvaw/QExyIUyuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhmO4vDR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730930470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CQkjpCq+FR4wEb3gcJTTVlpVQssWedAQsO1i+66yjS0=;
	b=fhmO4vDRHExFJhemWJ2rAeKwcOrFrp5Ac2vhjWq4p9G4zQIEK7PQnqL0qkxbosRX/chue+
	Koit2d2ohWJ6Gct0VtMimm9KDMMcS53q4NQdHZ4Hj2Jgg6kmppeQ3HsD8YKBSn/XFLL7Ue
	3L8xVXdCo8tV5rSyTawm+37PIZcxfHQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-g35XZgqGMTmn5CkoR9Ysow-1; Wed,
 06 Nov 2024 17:01:06 -0500
X-MC-Unique: g35XZgqGMTmn5CkoR9Ysow-1
X-Mimecast-MFC-AGG-ID: g35XZgqGMTmn5CkoR9Ysow
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76EFA1955F07;
	Wed,  6 Nov 2024 22:01:05 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.71])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A39591956088;
	Wed,  6 Nov 2024 22:01:03 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mei: vsc: Do not re-enable interrupt from vsc_tp_reset()
Date: Wed,  6 Nov 2024 23:01:02 +0100
Message-ID: <20241106220102.40549-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The only 2 callers of vsc_tp_reset() are:

1. mei_vsc_hw_reset(), which immediataly calls vsc_tp_intr_disable()
   afterwards.

2. vsc_tp_shutdown() which immediately calls free_irq() afterwards.

So neither actually wants the interrupt to be enabled after resetting
the chip and having the interrupt enabled for a short time afer
the reset is undesirable.

Drop the enable_irq() call from vsc_tp_reset(), so that the interrupt
is left disabled after vsc_tp_reset().

Link: https://github.com/intel/ivsc-driver/issues/51
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/mei/platform-vsc.c | 2 --
 drivers/misc/mei/vsc-tp.c       | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
index 20a11b299bcd..71f9994da2cc 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -256,8 +256,6 @@ static int mei_vsc_hw_reset(struct mei_device *mei_dev, bool intr_enable)
 
 	vsc_tp_reset(hw->tp);
 
-	vsc_tp_intr_disable(hw->tp);
-
 	return vsc_tp_init(hw->tp, mei_dev->dev);
 }
 
diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 1618cca9a731..107177b05dcd 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -364,8 +364,6 @@ void vsc_tp_reset(struct vsc_tp *tp)
 	gpiod_set_value_cansleep(tp->wakeupfw, 1);
 
 	atomic_set(&tp->assert_cnt, 0);
-
-	enable_irq(tp->spi->irq);
 }
 EXPORT_SYMBOL_NS_GPL(vsc_tp_reset, VSC_TP);
 
-- 
2.47.0


