Return-Path: <linux-kernel+bounces-567611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB3A68854
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D02883B96
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794A6253B7B;
	Wed, 19 Mar 2025 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr3WF+EG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C34255222;
	Wed, 19 Mar 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376759; cv=none; b=oux8cJd9Zh7WHgR7ojoP1dm0rpUc0ElbMGb6XAoZSrb5Ozwn/kfeO/da57xOBpkhY/G7IXo9ceSAPU+PWsm78qGA9h4ynrZWjDIDH2bO/G145X2YlamI9fMNTLr2oYPKeDNgl2cPlX0xQ3o/3xRyTASkFd6ZOQi4OUV7XDbCcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376759; c=relaxed/simple;
	bh=Vs/QmQTNg51FiGX+xS8ZOopYDNsegQ+nGM9Zf3T39vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLJJzl1ODeHkZAzQq06pg+VoiQpOR1CCSRkQk9n5Esj+ppExmEBFhqZG91D0nHkisbH4TJPQNZrjiQAZmx7KSHOxhNizVbIT6WJBAp5FXF7SpeJ9aEFqXrhmy0kXx6UimSdYYkqXXWDmJFVm+m+jEx99rBPKZCjSMKbXlY+7O+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr3WF+EG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEECC4CEE9;
	Wed, 19 Mar 2025 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376759;
	bh=Vs/QmQTNg51FiGX+xS8ZOopYDNsegQ+nGM9Zf3T39vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lr3WF+EG+jZmyODez+3Ag0Zf8+xFWxE0+o+jdNbXUypqJTMUzHcRQrpazBfjnhntl
	 EJmkO5HWO+igXD99Xwj3IQdDko93kAReOPmUscoC2Kk68Jxp7ZFBYrvbGxf/MEtPjb
	 s995jscfk+aqK3OwEOalHyI3P78jNSchfpEvUrI1Mn1Rq3MENrYBF/8O+0pRn8dVAO
	 pA81d8pX8EuXSoyJd+ZknO4wlVT7xwc7yBlvUds+l1OWEiuFrWvg0oZSOiKTqWV9/4
	 Iet13GuIJHjsaqyqAOtlNFh6AKsKAatBE2hyYh1T85qZ0dwZigHF1kqt3ztaarKKLB
	 T59w5kyQ5c1fw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH v2 35/57] irqdomain: sound: Switch to irq_domain_create_linear()
Date: Wed, 19 Mar 2025 10:29:28 +0100
Message-ID: <20250319092951.37667-36-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: linux-sound@vger.kernel.org
---
 sound/soc/codecs/wcd937x.c | 2 +-
 sound/soc/codecs/wcd938x.c | 2 +-
 sound/soc/codecs/wcd939x.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index ff8bb01edf42..dd2045a5d26d 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2480,7 +2480,7 @@ static const struct irq_domain_ops wcd_domain_ops = {
 
 static int wcd937x_irq_init(struct wcd937x_priv *wcd, struct device *dev)
 {
-	wcd->virq = irq_domain_add_linear(NULL, 1, &wcd_domain_ops, NULL);
+	wcd->virq = irq_domain_create_linear(NULL, 1, &wcd_domain_ops, NULL);
 	if (!(wcd->virq)) {
 		dev_err(dev, "%s: Failed to add IRQ domain\n", __func__);
 		return -EINVAL;
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index b536e8bdc5a7..1ae498c32391 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3025,7 +3025,7 @@ static const struct irq_domain_ops wcd_domain_ops = {
 static int wcd938x_irq_init(struct wcd938x_priv *wcd, struct device *dev)
 {
 
-	wcd->virq = irq_domain_add_linear(NULL, 1, &wcd_domain_ops, NULL);
+	wcd->virq = irq_domain_create_linear(NULL, 1, &wcd_domain_ops, NULL);
 	if (!(wcd->virq)) {
 		dev_err(dev, "%s: Failed to add IRQ domain\n", __func__);
 		return -EINVAL;
diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 4a417a92514d..0a87a79772da 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -2975,7 +2975,7 @@ static const struct irq_domain_ops wcd_domain_ops = {
 
 static int wcd939x_irq_init(struct wcd939x_priv *wcd, struct device *dev)
 {
-	wcd->virq = irq_domain_add_linear(NULL, 1, &wcd_domain_ops, NULL);
+	wcd->virq = irq_domain_create_linear(NULL, 1, &wcd_domain_ops, NULL);
 	if (!(wcd->virq)) {
 		dev_err(dev, "%s: Failed to add IRQ domain\n", __func__);
 		return -EINVAL;
-- 
2.49.0


