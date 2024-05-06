Return-Path: <linux-kernel+bounces-170493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F68BD808
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C10F283BA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAC81E492;
	Mon,  6 May 2024 23:06:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891B14037D
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715036813; cv=none; b=OUBNwZbR+5dPRNRS1kJuYqt5M9YURloxL4XU89tc3OS8kDI1qDP6lo8kJZBipxYhWUpAhD3weLBXkWyfITLmKyNg7rhP5p7kLV1wHEIJWhx8OU2yXeEYJCnRd7GBHM9HrTXdOlF/OyTzJBeD/AO1p0KanhpnnLpRJ+E8UdGjMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715036813; c=relaxed/simple;
	bh=9HN86MYQ33YdNbS0Pmv0lByag7ERw0yRrumYfb+xENQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e3kp2kC8MV43CpLk5hJnSJQrYbec6rTukIwU4iSlkssWLcLGcGdOiOZbSMEc7N3bsR83/0ujQKDNejEtwcFOoZNFGGQsAusHXhsezIQ5p0UPB0u65g9zSU0s08D0YeXlqITwzTq7SPp0XLtLHBKqSbbMIvjkfJNXAG1sTgmOZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1s47Pw-0004CD-FD; Tue, 07 May 2024 01:06:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1s47Pu-00GMw9-Mp; Tue, 07 May 2024 01:06:42 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1s47Pu-00FAuL-0Z;
	Tue, 07 May 2024 01:06:42 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 07 May 2024 01:06:41 +0200
Subject: [PATCH] usb: dwc3: gadget: create per ep interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAIBiOWYC/x2N2wrCMBAFf6Xss4Gk3sBfEQm5HM1CiXGjtlD67
 y4+zsAwK3UIo9NlWEnw5c7PquB2A6US6gOGszKNdjzYoz2bPKe9bxCP5lle7yII2WTr4ELMCad
 E2sbQYaKEmorW9TNNKpvgzst/dr1t2w+jR8iNfAAAAA==
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: michael.riesch@wolfvision.net, kernel@pengutronix.de, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10879;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=9HN86MYQ33YdNbS0Pmv0lByag7ERw0yRrumYfb+xENQ=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmOWKC1GjeiNy2Qy5NxhR++0X3N3yWLNeUPlNF0
 hxcgCLV0xqJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZjliggAKCRC/aVhE+XH0
 q36ED/oCXb1ah+WzibYE5zj1bJV7PpYrWjOsmSsyZDsbNG/jQswx1jY49hCIoa3km/qsreKsPzl
 ZkkwGsm9UtZ0AtQwlM99LR34YZK476ONQpvI0olbSMrLFtEhDuqRMDkRR3Ydj9AL25IXrDWpxnW
 ljsOpVjl5kLVP2y9mdIDxJeipL5Vv449RlCzSc05VdGRYbV1xMEpMiSY74fFExh6G65nq4zE9xI
 tzY2qNq+evkuQkY1D84RspP9GrgnDwE7RbLa0Gh3Qcu41ovG+WtnSDk6hGPDqnlqvfLIqhJWrDH
 r7Hz4ENkR4beKjC16onbLB5JzMD8Iv2zlvbUFAurlYKaQuKnxx2h4Q7Ec72kNIrcwKXy9jlSCoA
 ZYnOLODjB+sNViu0h7XbZVHeg87CoKQTRsnwEr1Q80fYC/sYCg+7+k1GBFjcMB7UqmpZDWeGYqr
 k4P+WS/zXf6Y4Djbg/6gbq7BoUmYpCGWcWYcGAp/zBzIfNOgHpfMoysrKr6Bop2VE/6tJQ6C3GD
 Cs0EFGB7anC+1kmJkM396TazGhdEWq6aGFBHyEuufkY2JmzDR3sA4MWX/2gP3DS+dZcu8RTN421
 oznNw78p0gzj824LdXr7moh1KCqFCuXznm831YHagsDSIV1aSfkhPnkPR9r2+KZrsgIvKdQTN+q
 D9r9dnWYjbKXplQ==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This patch is splitting up the interrupt event handling from one
interrupt thread to separate per endpoint interrupt threads.

To achieve this we create a new dwc3 interrupt domain in which
we map all claimed interrupts to individual interrupt threads.

Although the gadget layer is preparing the claimed parameter
of each usb_ep which could be checked if the endpoint is
to used or not, the claimed value was 0 for each ep in gadget_start.
This was tested when describing some composite gadget using configfs.

As a workaround we check the ep->address value instead for now.

The ep0 is handling in and out events both in one common thread.

There is still some work left to improve.

1) The big dwc->lock can block other endpoint threads. To solve this,
   the endpoint need their own locks. While the ep0 device events
   have still to be handled priviliged.

2) The smp_affinity is currently not possible to change which will make
   the per ep threads run on the same cpu as the current irq. To gain
   benefit from running the ep threads on different cores, the big
   dwc->lock is needs to be solved first anyways.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/dwc3/core.h   |  14 ++++
 drivers/usb/dwc3/gadget.c | 202 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 215 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 180dd8d29287c..53cc34ce71682 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -733,6 +733,18 @@ struct dwc3_ep {
 	struct list_head	pending_list;
 	struct list_head	started_list;
 
+	unsigned int irq_endpoint;
+
+	spinlock_t event_lock;
+	u32 ep_event_buffer[256];
+	int ep_event_w_index;
+	int ep_event_r_index;
+
+	int givebacks_current_turn;
+
+#define DWC3_EP_EVENT_OVERFLOW		BIT(0)
+	unsigned int ep_event_flags;
+
 	void __iomem		*regs;
 
 	struct dwc3_trb		*trb_pool;
@@ -1173,6 +1185,8 @@ struct dwc3 {
 	struct usb_gadget	*gadget;
 	struct usb_gadget_driver *gadget_driver;
 
+	struct irq_domain	*ep_irq_domain;
+
 	struct clk		*bus_clk;
 	struct clk		*ref_clk;
 	struct clk		*susp_clk;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f94f68f1e7d2b..3b49d80fc8dfa 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -16,6 +16,9 @@
 #include <linux/pm_runtime.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
 #include <linux/list.h>
 #include <linux/dma-mapping.h>
 
@@ -1049,6 +1052,106 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 /* -------------------------------------------------------------------------- */
 
+static irqreturn_t dwc3_endpoint_irq(int irq, void *_dep)
+{
+	return IRQ_WAKE_THREAD;
+}
+
+static void dwc3_process_event_entry(struct dwc3 *dwc,
+				     const union dwc3_event *event);
+
+static irqreturn_t dwc3_endpoint_thread_irq(int irq, void *_dep)
+{
+	struct dwc3_ep *dep = _dep;
+	struct dwc3 *dwc = dep->dwc;
+	const union dwc3_event *event;
+	int count_processed = 0;
+	u32 event_raw;
+	unsigned long flags;
+
+	dep->givebacks_current_turn = 0;
+
+	spin_lock_irqsave(&dep->event_lock, flags);
+
+	if (dep->ep_event_flags & DWC3_EP_EVENT_OVERFLOW) {
+		dev_err(dwc->dev, "ep%d: event buffer overflow\n", dep->number);
+		dep->ep_event_flags &= ~DWC3_EP_EVENT_OVERFLOW;
+	}
+
+	while (dep->ep_event_r_index != dep->ep_event_w_index) {
+
+		event_raw = dep->ep_event_buffer[dep->ep_event_r_index];
+
+		/*
+		 * we have a copy of the event, so we can release the lock
+		 */
+		spin_unlock_irqrestore(&dep->event_lock, flags);
+
+		event = (const union dwc3_event *) &event_raw;
+
+		spin_lock(&dwc->lock);
+		dwc3_process_event_entry(dwc, event);
+		spin_unlock(&dwc->lock);
+
+		/*
+		 * we need to re-acquire the lock to update the read index
+		 */
+		spin_lock_irqsave(&dep->event_lock, flags);
+
+		dep->ep_event_r_index = (dep->ep_event_r_index + 1) %
+					 ARRAY_SIZE(dep->ep_event_buffer);
+
+		count_processed += 1;
+	}
+
+	spin_unlock_irqrestore(&dep->event_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static int dwc3_gadget_init_endpoint_irq(struct dwc3 *dwc, struct dwc3_ep *dep)
+{
+	char *irq_name;
+	int ret = 0;
+
+	/* FIXME: endpoint.claimed would be better here, but somehow
+	 * the composite gadget layer is leaving the claimed value to 0
+	 * after calling usb_ep_autoconfig_reset after the final bind
+	 */
+	/* ep0in and ep0out share the same interrupt thread */
+	if (!dep->endpoint.address && dep->number)
+		return 0;
+
+	dep->irq_endpoint = irq_create_mapping(dwc->ep_irq_domain, dep->number);
+	if (dep->irq_endpoint < 0) {
+		ret = dep->irq_endpoint;
+
+		dev_err(dwc->dev, "failed to map irq for ep%d --> %d\n",
+				dep->number, ret);
+		return ret;
+	}
+
+	irq_name = kzalloc(16, GFP_KERNEL);
+	if (!dep->number)
+		snprintf(irq_name, 16, "ep0");
+	else
+		snprintf(irq_name, 16, "ep%d%s", dep->number >> 1, dep->direction ?
+			"in" : "out");
+
+	ret = request_threaded_irq(dep->irq_endpoint, dwc3_endpoint_irq,
+				   dwc3_endpoint_thread_irq, IRQF_SHARED,
+				   irq_name, dep);
+	if (ret) {
+		irq_dispose_mapping(irq_find_mapping(dwc->ep_irq_domain, dep->number));
+		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
+				dep->irq_endpoint, ret);
+	}
+
+	return ret;
+}
+
+/* -------------------------------------------------------------------------- */
+
 static int dwc3_gadget_ep0_enable(struct usb_ep *ep,
 		const struct usb_endpoint_descriptor *desc)
 {
@@ -2939,6 +3042,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
+	u8			epnum;
 	unsigned long		flags;
 	int			ret;
 	int			irq;
@@ -2952,6 +3056,17 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 		return ret;
 	}
 
+	for (epnum = 0; epnum < dwc->num_eps; epnum++) {
+		int			ret;
+		/* ep0in and ep0out share the same interrupt thread */
+		if (epnum == 1)
+			continue;
+
+		ret = dwc3_gadget_init_endpoint_irq(dwc, dwc->eps[epnum]);
+		if (ret)
+			return ret;
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= driver;
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -2972,6 +3087,7 @@ static void __dwc3_gadget_stop(struct dwc3 *dwc)
 static int dwc3_gadget_stop(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
+	u8			epnum;
 	unsigned long		flags;
 
 	if (dwc->sys_wakeup)
@@ -2982,6 +3098,18 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	dwc->max_cfg_eps = 0;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	for (epnum = 0; epnum < dwc->num_eps; epnum++) {
+		struct dwc3_ep		*dep;
+
+		if (epnum == 1)
+			continue;
+
+		dep = dwc->eps[epnum];
+
+		free_irq(dep->irq_endpoint, dwc->eps[epnum]);
+		irq_dispose_mapping(dep->irq_endpoint);
+	}
+
 	free_irq(dwc->irq_gadget, dwc->ev_buf);
 
 	return 0;
@@ -3298,6 +3426,8 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	INIT_LIST_HEAD(&dep->started_list);
 	INIT_LIST_HEAD(&dep->cancelled_list);
 
+	spin_lock_init(&dep->event_lock);
+
 	dwc3_debugfs_create_endpoint_dir(dep);
 
 	return 0;
@@ -4403,7 +4533,9 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 {
 	struct dwc3 *dwc = evt->dwc;
 	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
 	int left;
+	int i;
 
 	left = evt->count;
 
@@ -4412,10 +4544,36 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 
 	while (left > 0) {
 		union dwc3_event event;
+		struct dwc3_ep *dep;
+		int epnum = 0;
 
 		event.raw = *(u32 *) (evt->cache + evt->lpos);
 
-		dwc3_process_event_entry(dwc, &event);
+		if (!event.type.is_devspec) {
+			struct dwc3_event_depevt *depevt = &event.depevt;
+
+			epnum = depevt->endpoint_number;
+			/* ep0in and ep0out share the same interrupt thread */
+			if (epnum <= 1)
+				epnum &= ~0x01;
+
+			if (epnum < 0 || epnum >= dwc->num_eps) {
+				dev_err(dwc->dev, "invalid epnum %d\n", epnum);
+				continue;
+			}
+		}
+
+		dep = dwc->eps[epnum];
+
+		spin_lock(&dep->event_lock);
+		dep->ep_event_buffer[dep->ep_event_w_index] = event.raw;
+		dep->ep_event_w_index = (dep->ep_event_w_index + 1) %
+					 ARRAY_SIZE(dep->ep_event_buffer);
+
+		if (dep->ep_event_w_index == dep->ep_event_r_index)
+			dep->ep_event_flags |= DWC3_EP_EVENT_OVERFLOW;
+
+		spin_unlock(&dep->event_lock);
 
 		/*
 		 * FIXME we wrap around correctly to the next entry as
@@ -4430,6 +4588,22 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 		left -= 4;
 	}
 
+	for (i = 0; i < dwc->num_eps; i++) {
+		struct dwc3_ep *dep = dwc->eps[i];
+
+		/* ep0in and ep0out share the same interrupt thread */
+		if (i == 1)
+			continue;
+
+		spin_lock_irqsave(&dep->event_lock, flags);
+
+		// TODO: improve
+		if (dep->ep_event_r_index != dep->ep_event_w_index)
+			generic_handle_domain_irq_safe(dwc->ep_irq_domain, i);
+
+		spin_unlock_irqrestore(&dep->event_lock, flags);
+	}
+
 	evt->count = 0;
 	ret = IRQ_HANDLED;
 
@@ -4553,6 +4727,22 @@ static void dwc_gadget_release(struct device *dev)
 	kfree(gadget);
 }
 
+static const struct irq_chip ep_irq_chip = {
+	.name = "dwc3-ep",
+};
+
+static int ep_irq_domain_map(struct irq_domain *d, unsigned int virq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(virq, &ep_irq_chip, handle_simple_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ep_irq_dom_ops = {
+	.map = ep_irq_domain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
 /**
  * dwc3_gadget_init - initializes gadget related registers
  * @dwc: pointer to our controller context structure
@@ -4573,6 +4763,13 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	dwc->irq_gadget = irq;
 
+	dwc->ep_irq_domain = irq_domain_add_simple(NULL, dwc->num_eps, 0, &ep_irq_dom_ops, dwc);
+	if (!dwc->ep_irq_domain) {
+		dev_err(dwc->dev, "failed to create ep irq domain\n");
+		ret = -ENOMEM;
+		goto err0;
+	}
+
 	dwc->ep0_trb = dma_alloc_coherent(dwc->sysdev,
 					  sizeof(*dwc->ep0_trb) * 2,
 					  &dwc->ep0_trb_addr, GFP_KERNEL);
@@ -4691,7 +4888,10 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
+	irq_domain_remove(dwc->ep_irq_domain);
+
 	dwc3_enable_susphy(dwc, false);
+
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);

---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240507-dwc3_per_ep_irqthread-d01e1abdce6c

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


