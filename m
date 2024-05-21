Return-Path: <linux-kernel+bounces-185138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 882858CB10C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2686BB23532
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDFA143C61;
	Tue, 21 May 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RzUe5abH"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00D143890;
	Tue, 21 May 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304337; cv=none; b=GVkDLy+CfG2e7gGvuyfYI4O+3TrjrXmWQaOr/99qXD4PH++Y50cRhBkk8O24ZxRoJ/kOO0BGlj/PhZXAt7Sp03WDyUD26SDtfjhuy0hfgRIgFwzzlFG/NJARC83mh+Aj89ITseCzjdnBf0o2yQijbp89ehB9F9G/68YVHfc7kPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304337; c=relaxed/simple;
	bh=k9id5A6AEoMcg1f8l0mCaVw+EfoZR8CooAB/aKAYWFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rYcoqhd2k4AsCKNHaf67JHab/fOqYL1rZlS7iYUnS6qQcSRnxUyF9zNmCEtplXmzBEim6dziqYB8eLwQLz9JmMi/8qjU3hAC3eUa1U2WaU87SsnXFF+leLLQaUC1qq7nG4B0gdtazsxu3TOgv8L5/3hr4Jel0RAFluVyePaPmCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RzUe5abH; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LDpiHh028512;
	Tue, 21 May 2024 17:11:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=/FEvlAQ
	usilGdNjTRD3PN3O7G4HvNhMpAzyobKWFMJ8=; b=RzUe5abH98tY6GRCtWl7ubG
	AVSey2r/LDF6N+YK3U9A6eXRwP250dihFM5bZPJyA8GFYLqmHfJw9PIKPzA+c6XO
	hsxsg7pZX2MobxHpYMLu0JJfYmk2A0Zfcwed1cu5CHvTXAf4mJFjTX7O7k2R86GH
	L2xVp1KMZFbDLfjGYJvc0PfKTEYBA5Co7pBRHfH5bvYvO5abtZikcO89T9h7nkHl
	Ud0Tcb3BiR6DT5kAQ2Fa+BflikB3eN9VwGpl7QVi8NjQrKT0FI9s9Y3rfR+WYKtd
	CHCaX4Ai6XP9sS9EbvoekG1iuGsLPegHdsJ7hLjtGyUE9jkm4LHzU32ByQJARdQ=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y8vqh8cag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 17:11:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1BCFF4002D;
	Tue, 21 May 2024 17:11:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 220332194C7;
	Tue, 21 May 2024 17:11:17 +0200 (CEST)
Received: from localhost (10.252.1.80) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 17:11:16 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH] usb: ucsi: stm32: fix command completion handling
Date: Tue, 21 May 2024 17:11:09 +0200
Message-ID: <20240521151109.3078775-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_09,2024-05-21_01,2024-05-17_01

Sometimes errors are seen, when doing DR swap, like:
[   24.672481] ucsi-stm32g0-i2c 0-0035: UCSI_GET_PDOS failed (-5)
[   24.720188] ucsi-stm32g0-i2c 0-0035: ucsi_handle_connector_change:
 GET_CONNECTOR_STATUS failed (-5)

There may be some race, which lead to read CCI, before the command complete
flag is set, hence returning -EIO. Similar fix has been done also in
ucsi_acpi [1].

In case of a spurious or otherwise delayed notification it is
possible that CCI still reports the previous completion. The
UCSI spec is aware of this and provides two completion bits in
CCI, one for normal commands and one for acks. As acks and commands
alternate the notification handler can determine if the completion
bit is from the current command.

To fix this add the ACK_PENDING bit for ucsi_stm32g0 and only complete
commands if the completion bit matches.

[1] https://lore.kernel.org/lkml/20240121204123.275441-3-lk@c--e.de/

Fixes: 72849d4fcee7 ("usb: typec: ucsi: stm32g0: add support for stm32g0 controller")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/typec/ucsi/ucsi_stm32g0.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 93d7806681cf..7d6576778dad 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -395,9 +395,13 @@ static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const
 				   size_t len)
 {
 	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
 	int ret;
 
-	set_bit(COMMAND_PENDING, &g0->flags);
+	if (ack)
+		set_bit(ACK_PENDING, &g0->flags);
+	else
+		set_bit(COMMAND_PENDING, &g0->flags);
 
 	ret = ucsi_stm32g0_async_write(ucsi, offset, val, len);
 	if (ret)
@@ -405,9 +409,14 @@ static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const
 
 	if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
 		ret = -ETIMEDOUT;
+	else
+		return 0;
 
 out_clear_bit:
-	clear_bit(COMMAND_PENDING, &g0->flags);
+	if (ack)
+		clear_bit(ACK_PENDING, &g0->flags);
+	else
+		clear_bit(COMMAND_PENDING, &g0->flags);
 
 	return ret;
 }
@@ -428,8 +437,9 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (test_bit(COMMAND_PENDING, &g0->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
+	if (cci & UCSI_CCI_ACK_COMPLETE && test_and_clear_bit(ACK_PENDING, &g0->flags))
+		complete(&g0->complete);
+	if (cci & UCSI_CCI_COMMAND_COMPLETE && test_and_clear_bit(COMMAND_PENDING, &g0->flags))
 		complete(&g0->complete);
 
 	return IRQ_HANDLED;
-- 
2.25.1


