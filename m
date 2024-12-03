Return-Path: <linux-kernel+bounces-429994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D37599E2A73
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1E1161F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752F1FAC5B;
	Tue,  3 Dec 2024 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZiRWCs2Z"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F41F8901;
	Tue,  3 Dec 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249418; cv=none; b=K5cpfTgtWeFGSvhzjfDXHEniuzmytwaLbTimSnc32PpSwalyzTJSpn/pfjqvGvEh+AAMOEshF106Zn8ogmu4/cp69QRroyNaY36k606lShse1Ub0eySm6FoRHGnIVaLoecx3Z4V5GZ47YJRlbxc+qkZrP052WyE7xReF/DEJhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249418; c=relaxed/simple;
	bh=ZTHwsjfKnVcom6cihpuRRRLaOW6K79Z5eWKeH1qZHXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBJZIGVH45sAcGbFdrAS7tr7Gxyg5bMzX4DjC/LRTKwfT5joG6sDQMNFnoSTetnzP8nSgbTMfToWociF2RuVEjDx9feVtaLnzwKq4x//eYfefAJ3FIDdw/jDz1hcEi9kzaBMz2C/ZtGzdRpZLqUPuFeBNnrSJdCja9Pc/zpySTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZiRWCs2Z; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3Bd87x023380;
	Tue, 3 Dec 2024 18:40:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	a2HFVmT0ifFjwnHk05ULxBqujThdhTxnxipVuThE684=; b=ZiRWCs2ZytZEyeKv
	Bvw656ItVt66sZoQUxrvhwU+vNfUe2mA+uHmKYepotJV0iGmyaunR3bScEkMv4PD
	483J4WUeCyhNXGp8fu5spX+AXLOpVhXbmfOEOBUr2fxpjBmDNA7teUQV7A8hOJd1
	wJ4tdvd66W2b/uK6BGyvoUxVc+c5J3rxGIccYvKEo5fgY5GcPG3HHaheKMhvTsfs
	ggUXPH5XpB3IUm4RzlW4ThBFzxtULQkh/S9cTmPZjrJxKjMzaqenfSuxqnxdjexA
	srPkTt1LHexZ093a6QYwM6NAJODrLjVznKOQHz0Ax2d5UvltZQcYawBg77t9WaEV
	tCzWDQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437tfge484-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 18:40:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 598D24004B;
	Tue,  3 Dec 2024 18:39:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EFF6623781A;
	Tue,  3 Dec 2024 18:39:11 +0100 (CET)
Received: from localhost (10.48.86.128) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 3 Dec
 2024 18:39:11 +0100
From: Etienne Carriere <etienne.carriere@foss.st.com>
To: <linux-kernel@vger.kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        Etienne
 Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v2 2/2] firmware: arm_scmi: round rate bisecting in discrete rates
Date: Tue, 3 Dec 2024 18:39:08 +0100
Message-ID: <20241203173908.3148794-3-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Implement clock round_rate operation for SCMI clocks that describe a
discrete rates list. Bisect into the supported rates when using SCMI
message CLOCK_DESCRIBE_RATES to optimize SCMI communication transfers.
Parse the rate list array when the target rate fit in the bounds
of the command response for simplicity.

If so some reason the sequence fails or if the SCMI driver has no
round_rate SCMI clock handler, then fallback to the legacy strategy that
returned the target rate value.

Operation handle scmi_clk_determine_rate() is change to get the effective
supported rounded rate when there is no clock re-parenting operation
supported. Otherwise, preserve the implementation that assumed any
clock rate could be obtained.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
Changes since patch series v1:
- New patch introduced in this v2 series.

---
 drivers/clk/clk-scmi.c            | 17 +++++-
 drivers/firmware/arm_scmi/clock.c | 93 +++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h     |  3 +
 3 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 09ccd6cea7f2..7bbb2ee55f4f 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -61,13 +61,20 @@ static long scmi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
 	/*
-	 * We can't figure out what rate it will be, so just return the
+	 * In case we can't figure out what rate it will be when the clock
+	 * describes a list of discrete rates, then just return the
 	 * rate back to the caller. scmi_clk_recalc_rate() will be called
 	 * after the rate is set and we'll know what rate the clock is
 	 * running at then.
 	 */
-	if (clk->info->rate_discrete)
+	if (clk->info->rate_discrete) {
+		ftmp = rate;
+		if (scmi_proto_clk_ops->round_rate &&
+		    !scmi_proto_clk_ops->round_rate(clk->ph, clk->id, &ftmp))
+			return ftmp;
+
 		return rate;
+	}
 
 	fmin = clk->info->range.min_rate;
 	fmax = clk->info->range.max_rate;
@@ -122,9 +129,13 @@ static u8 scmi_clk_get_parent(struct clk_hw *hw)
 static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
 	/*
-	 * Suppose all the requested rates are supported, and let firmware
+	 * If not several parents look into supported rates. Otherwise
+	 * suppose all the requested rates are supported, and let firmware
 	 * to handle the left work.
 	 */
+	if (to_scmi_clk(hw)->info->num_parents < 2)
+		req->rate = scmi_clk_round_rate(hw, req->rate, NULL);
+
 	return 0;
 }
 
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 34fde0b88098..e416476dd336 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -999,6 +999,98 @@ static int scmi_clock_config_oem_get(const struct scmi_protocol_handle *ph,
 				    NULL, oem_val, atomic);
 }
 
+static int scmi_clock_round_rate(const struct scmi_protocol_handle *ph,
+				 u32 clk_id, u64 *rate)
+
+{
+	const struct scmi_msg_resp_clock_describe_rates *resp;
+	size_t index_low, index_high, index_tmp, count, i;
+	struct scmi_msg_clock_describe_rates *msg;
+	u64 rate_low, rate_high, target_rate;
+	struct scmi_xfer *xfer;
+	int ret;
+	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (clk_id >= ci->num_clocks ||
+	    WARN_ONCE(!clk->rate_discrete, "Unexpected linear rates"))
+		return -EINVAL;
+
+	target_rate = *rate;
+	index_low = 0;
+	index_high = clk->list.num_rates - 1;
+	rate_low = clk->list.min_rate;
+	rate_high = clk->list.max_rate;
+
+	if (target_rate <= rate_low) {
+		*rate = rate_low;
+		return 0;
+	}
+	if (target_rate >= rate_high) {
+		*rate = rate_high;
+		return 0;
+	}
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_DESCRIBE_RATES, sizeof(*msg), 0,
+				      &xfer);
+	if (ret)
+		return ret;
+
+	resp = xfer->rx.buf;
+	msg = xfer->tx.buf;
+	msg->id = cpu_to_le32(clk_id);
+
+	while (true) {
+		index_tmp = (index_low + index_high) / 2;
+
+		ph->xops->reset_rx_to_maxsz(ph, xfer);
+		msg->id = cpu_to_le32(clk_id);
+		msg->rate_index = cpu_to_le32(index_tmp);
+
+		ret = ph->xops->do_xfer(ph, xfer);
+		if (!ret && (!RATE_DISCRETE(resp->num_rates_flags) ||
+			     !NUM_RETURNED(resp->num_rates_flags)))
+			ret = -EPROTO;
+		if (ret)
+			break;
+
+		count = NUM_RETURNED(resp->num_rates_flags);
+
+		if (target_rate < RATE_TO_U64(resp->rate[0])) {
+			index_high = index_tmp;
+			rate_high = RATE_TO_U64(resp->rate[0]);
+		} else if (target_rate > RATE_TO_U64(resp->rate[count - 1])) {
+			index_low = index_tmp + count - 1;
+			rate_low = RATE_TO_U64(resp->rate[count - 1]);
+		} else {
+			for (i = 1; i < count; i++)
+				if (target_rate <= RATE_TO_U64(resp->rate[i]))
+					break;
+
+			index_low = index_tmp + i - 1;
+			rate_low = RATE_TO_U64(resp->rate[i - 1]);
+
+			if (i < count) {
+				index_high = index_tmp + i;
+				rate_high = RATE_TO_U64(resp->rate[i]);
+			}
+		}
+
+		if (index_high <= index_low + 1) {
+			if (target_rate - rate_low > rate_high - target_rate)
+				*rate = rate_high;
+			else
+				*rate = rate_low;
+
+			break;
+		}
+	}
+
+	ph->xops->xfer_put(ph, xfer);
+
+	return ret;
+}
+
 static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
 {
 	struct clock_info *ci = ph->get_priv(ph);
@@ -1027,6 +1119,7 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.info_get = scmi_clock_info_get,
 	.rate_get = scmi_clock_rate_get,
 	.rate_set = scmi_clock_rate_set,
+	.round_rate = scmi_clock_round_rate,
 	.enable = scmi_clock_enable,
 	.disable = scmi_clock_disable,
 	.state_get = scmi_clock_state_get,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 240478bb8476..30cf373c3f8b 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -91,6 +91,7 @@ enum scmi_clock_oem_config {
  * @info_get: get the information of the specified clock
  * @rate_get: request the current clock rate of a clock
  * @rate_set: set the clock rate of a clock
+ * @round_rate: tell which is the nearest rate a clock supports (w/o setting it)
  * @enable: enables the specified clock
  * @disable: disables the specified clock
  * @state_get: get the status of the specified clock
@@ -108,6 +109,8 @@ struct scmi_clk_proto_ops {
 			u64 *rate);
 	int (*rate_set)(const struct scmi_protocol_handle *ph, u32 clk_id,
 			u64 rate);
+	int (*round_rate)(const struct scmi_protocol_handle *ph, u32 clk_id,
+			  u64 *rate);
 	int (*enable)(const struct scmi_protocol_handle *ph, u32 clk_id,
 		      bool atomic);
 	int (*disable)(const struct scmi_protocol_handle *ph, u32 clk_id,
-- 
2.25.1


