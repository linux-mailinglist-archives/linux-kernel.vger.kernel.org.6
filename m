Return-Path: <linux-kernel+bounces-333972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82E97D0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530461F22E04
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D6376E9;
	Fri, 20 Sep 2024 05:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TDdjeood"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C402746B;
	Fri, 20 Sep 2024 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726809181; cv=none; b=kEdnVJZ8RTZ+fHsHP3oEL6edWVT8OSp+ogbK2UdA+oR5jWsvfdsc7TZNt45YzGoGH4k8+ZP03bwlJ++4Za3dnqABPxrD47yYQtbNAxC3VhoQPnlUEzl+P7Snts55rM8jvK/vK0D+yhZYcwp9edc5loTK/ZMOH8XYq4fSvXmtKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726809181; c=relaxed/simple;
	bh=piMSoVhy/D9gqh9FrPUHfiLZ9DC1lL5bBLpyTws+rS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSBLHVzMkU5Q530frdmNppm8Y8iwFgucDMBwbwVavnT0mMj6z2aHQjmRf7ycKmsyZkgFoyHcHnH8FFUuHnKqv2dAvDGOz7zMweyDlGruHgL/DhY6moeBwF+m7UxXY8xql3XXO7xlDYptoiOkLKkmQPByMTfQBZztUvsYjmCFeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TDdjeood; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726809165;
	bh=iIpeX/YTfhSlEkkeuECb8mo5DaPBrbYDbRDN4IXS7fo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TDdjeoodJmrkIzwWB2mdFdtDixosckyJJ2/ntEKeFmi7c13VhXRwzYzQ4lmpiIwao
	 D65bb5cPCDpPWE1Ms0h5JD686a6iaV7gsyVpD+YfMJJLx4sKP8U5OOBZUFqrk0CvyL
	 BmPApI02cdaBqXKf/+iEba9RM4bGRvfd1MdnicxE=
X-QQ-mid: bizesmtpsz6t1726809128tdg8zyx
X-QQ-Originating-IP: 4qK6gaLJ7eqPa1/2ba1T5tsfcJmFoZtyCcdNx9BH5JI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Sep 2024 13:12:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10282610817389181719
From: WangYuli <wangyuli@uniontech.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org,
	raoxu@uniontech.com,
	wangyuli@uniontech.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com
Subject: [PATCH] xhci: debugfs: Add virt endpoint state to xhci debugfs
Date: Fri, 20 Sep 2024 13:11:59 +0800
Message-ID: <63B520E210CBE3F6+20240920051159.1363806-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

The ring data structure of each xHCI endpoint might stop sending
data due to the virt endpoint state.

Show the virt endpoint state within the endpoint context via debugfs
to facilitate debugging.

Co-developed-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/usb/host/xhci-debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index f8ba15e7c225..35247cd50c74 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -291,12 +291,13 @@ static int xhci_endpoint_context_show(struct seq_file *s, void *unused)
 	for (ep_index = 0; ep_index < 31; ep_index++) {
 		ep_ctx = xhci_get_ep_ctx(xhci, dev->out_ctx, ep_index);
 		dma = dev->out_ctx->dma + (ep_index + 1) * CTX_SIZE(xhci->hcc_params);
-		seq_printf(s, "%pad: %s\n", &dma,
+		seq_printf(s, "%pad: %s, virt_state:%#x\n", &dma,
 			   xhci_decode_ep_context(str,
 						  le32_to_cpu(ep_ctx->ep_info),
 						  le32_to_cpu(ep_ctx->ep_info2),
 						  le64_to_cpu(ep_ctx->deq),
-						  le32_to_cpu(ep_ctx->tx_info)));
+						  le32_to_cpu(ep_ctx->tx_info)),
+						  dev->eps[ep_index].ep_state);
 	}
 
 	return 0;
-- 
2.45.2


