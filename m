Return-Path: <linux-kernel+bounces-260020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808A93A196
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436242833F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60415350F;
	Tue, 23 Jul 2024 13:33:07 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDF0208A0;
	Tue, 23 Jul 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741586; cv=none; b=ix3FYQ9Bn1t5G/Iu6dyNozm0JPf/Qn2PrEVp+R5hikaC+ygHyRxUEfeXnHicY91QRvOL6rCKtm1Dir0lNqmRIrA+G8/clfn6kSpR/22gDorl6/LVYjsV7uwHvg3GPvJ4OLes/yqeAUsakvTjXLB1iTRCbGvFNr4o51ZxsvCqYzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741586; c=relaxed/simple;
	bh=vmhHHcC3WZiFq+EgmtM70e1+5EcqoRGLgNcKEJZqJxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=btEwLjz5UljAFv+t2jf7YHZlDjUA0626EwcIERiqL0M7RiOpWcHEbhdIRYz8jJssLOETTrP4rcEvG8Kurbu5zkswIjD4LI1CZolOppMIYo7YY0Jef/arkDpDtd+jwKBkSOKj+jEyAE6gszCrzABOHR5JGrHXVMnHEMzHhQjRbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowABXhUHxsJ9mkCCQAA--.4469S2;
	Tue, 23 Jul 2024 21:32:44 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	make24@iscas.ac.cn,
	dmitry.baryshkov@linaro.org,
	bleung@chromium.org,
	utkarsh.h.patel@intel.com,
	abhishekpandit@chromium.org,
	kyletso@google.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference in ucsi_displayport_vdm()
Date: Tue, 23 Jul 2024 21:32:30 +0800
Message-Id: <20240723133230.1325392-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXhUHxsJ9mkCCQAA--.4469S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1rXry7Gr45tF4DKryDZFb_yoWDJrg_A3
	Wv9wnrWF1jkFyq9r15ta4a9rWFkay0v3WIqFn3t3s5CF129F1xXrWUXrs3XFyfuF45uF9x
	Cr1jkryxuw4DGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

When dp->con->partner is an error, a NULL pointer dereference may occur.
Add a check for dp->con->partner to avoid dereferencing a NULL pointer.

Fixes: 372adf075a43 ("usb: typec: ucsi: Determine common SVDM Version")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/usb/typec/ucsi/displayport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 420af5139c70..eb7d3f97940a 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -222,6 +222,8 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 	switch (cmd_type) {
 	case CMDT_INIT:
 		if (PD_VDO_SVDM_VER(header) < svdm_version) {
+			if (IS_ERR_OR_NULL(dp->con->parter))
+				break;
 			typec_partner_set_svdm_version(dp->con->partner, PD_VDO_SVDM_VER(header));
 			svdm_version = PD_VDO_SVDM_VER(header);
 		}
-- 
2.25.1


