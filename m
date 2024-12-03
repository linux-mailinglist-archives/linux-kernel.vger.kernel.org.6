Return-Path: <linux-kernel+bounces-429948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED149E2C57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7FEB33A03
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499F1FBCAA;
	Tue,  3 Dec 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UV+eJsgh"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8C1F892F;
	Tue,  3 Dec 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247627; cv=none; b=clwKQqPjYqUyMGa07Nl/Z2F+UdQumYdqHSYbet+yY3AFc2HvRRrAWu4UT0BeW06tlXIPuFDIU0i1tuDajIAndHLgDVIykXdTA0rUwRHbJKtKN9lILGJ73xr7jLD+ZVUCDrHno8rRAV/qaEpLrVOGMve1+tzEexzch0WGEmy65yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247627; c=relaxed/simple;
	bh=u56MRaRg7YVdQTfY/eotq17rGkTT8/OoRQSiqJx+cOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5a873noJAnLb5neljrwgGrLQ/q/GSmKWCE4l7lr8vj4c/dsjmbcWtqQSmChs4DHb8eOnfGP0bZIO/SCMTYK8Rzhd6VTybFV/d79NbUUxZR3uFQzS6Iee6w/ay+AozwkuCGZ6YxwFfqTRpuYhFe/vwZ0naQNvONIabIHxM6Kdbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UV+eJsgh; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3C3UdS017760;
	Tue, 3 Dec 2024 18:40:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	CFvrB57kQUB9+YRdta2CSyD4T69d0dVCuOkS2SjanlQ=; b=UV+eJsghDDEF2hwb
	M9GYd8namo9INodFNJ5/AxXsopoiw58qAQ8a8kBrT+b/6x9k4hlTrgnCvjHi5wQQ
	WKpV+t2ABNc1RiohH5V+twdlfqDXFL/DGmf2q+vru1C1vx16JEXnU3OklCr/YeuK
	ShR4r7eCkeuvzoTC7IgF7yLdETstQ0IISqj2zusrb5H4lwIYyrrNgf+9TREaqwhk
	UdkfaGfTy1gjCcg8fALDhxENXiCeFWJL2Rnvy4tdtJo9zXgyIQKbNMM6uOooE7K9
	ixExpQrFHFob21GSJeERL7MnE6kdn3qhP7itR37NQmIWlhFlc8ipkRwYgHChF8Gy
	4oNPSQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437tx26by3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 18:40:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E93B140048;
	Tue,  3 Dec 2024 18:39:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3E1772359CC;
	Tue,  3 Dec 2024 18:39:11 +0100 (CET)
Received: from localhost (10.48.86.128) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 3 Dec
 2024 18:39:10 +0100
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
Subject: [PATCH v2 1/2] firmware: arm_scmi: get only min/max clock rates
Date: Tue, 3 Dec 2024 18:39:07 +0100
Message-ID: <20241203173908.3148794-2-etienne.carriere@foss.st.com>
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

Remove limitation of 16 clock rates max for discrete clock rates
description when the SCMI firmware supports SCMI Clock protocol v2.0
or later.

Driver clk-scmi.c is only interested in the min and max clock rates.
Get these by querying the first and last discrete rates with SCMI
clock protocol message ID CLOCK_DESCRIBE_RATES since the SCMI
specification v2.0 and later states that rates enumerated by this
command are to be enumerated in "numeric ascending order" [1].

Preserve the implementation that queries all discrete rates (16 rates
max) to support SCMI firmware built on SCMI specification v1.0 [2]
where SCMI Clock protocol v1.0 does not explicitly require rates
described with CLOCK_DESCRIBE_RATES to be in ascending order.

Link: https://developer.arm.com/documentation/den0056 [1]
Link: https://developer.arm.com/documentation/den0056/a [2]
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
Changes since patch series v1:
- Preserve the original implementation and keep using it for SCMI
  Clock protocol v1.0.

---
 drivers/clk/clk-scmi.c            |   4 +-
 drivers/firmware/arm_scmi/clock.c | 112 ++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     |   4 +-
 3 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 15510c2ff21c..09ccd6cea7f2 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -244,8 +244,8 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 		if (num_rates <= 0)
 			return -EINVAL;
 
-		min_rate = sclk->info->list.rates[0];
-		max_rate = sclk->info->list.rates[num_rates - 1];
+		min_rate = sclk->info->list.min_rate;
+		max_rate = sclk->info->list.max_rate;
 	} else {
 		min_rate = sclk->info->range.min_rate;
 		max_rate = sclk->info->range.max_rate;
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 2ed2279388f0..34fde0b88098 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -223,10 +223,21 @@ scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+/*
+ * Support SCMI_CLOCK protocol v1.0 as described in SCMI specification v1.0
+ * that do not explicitly require clock rates described with command
+ * CLOCK_DESCRIBE_RATES to be in ascending order. The Linux legacy
+ * implementation for these clock supports a max of 16 rates.
+ * In SCMI specification v2.0 and later, rates must be in ascending order
+ * to we query only to min and max rates values.
+ */
+#define SCMI_MAX_NUM_RATES_V1		16
+
 struct scmi_clk_ipriv {
 	struct device *dev;
 	u32 clk_id;
 	struct scmi_clock_info *clk;
+	u64 rates[SCMI_MAX_NUM_RATES_V1];
 };
 
 static void iter_clk_possible_parents_prepare_message(void *message, unsigned int desc_index,
@@ -493,7 +504,7 @@ iter_clk_describe_process_response(const struct scmi_protocol_handle *ph,
 			break;
 		}
 	} else {
-		u64 *rate = &p->clk->list.rates[st->desc_index + st->loop_idx];
+		u64 *rate = &p->rates[st->desc_index + st->loop_idx];
 
 		*rate = RATE_TO_U64(r->rate[st->loop_idx]);
 		p->clk->list.num_rates++;
@@ -519,7 +530,7 @@ scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
 		.dev = ph->dev,
 	};
 
-	iter = ph->hops->iter_response_init(ph, &ops, SCMI_MAX_NUM_RATES,
+	iter = ph->hops->iter_response_init(ph, &ops, ARRAY_SIZE(cpriv.rates),
 					    CLOCK_DESCRIBE_RATES,
 					    sizeof(struct scmi_msg_clock_describe_rates),
 					    &cpriv);
@@ -535,10 +546,95 @@ scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
 			clk->range.min_rate, clk->range.max_rate,
 			clk->range.step_size);
 	} else if (clk->list.num_rates) {
-		sort(clk->list.rates, clk->list.num_rates,
-		     sizeof(clk->list.rates[0]), rate_cmp_func, NULL);
+		sort(cpriv.rates, clk->list.num_rates,
+		     sizeof(cpriv.rates[0]), rate_cmp_func, NULL);
+		clk->list.min_rate = cpriv.rates[0];
+		clk->list.max_rate = cpriv.rates[clk->list.num_rates - 1];
+	}
+
+	return ret;
+}
+
+static int scmi_clock_get_rates_bound(const struct scmi_protocol_handle *ph,
+				      u32 clk_id, struct scmi_clock_info *clk)
+{
+	struct scmi_msg_clock_describe_rates *msg;
+	const struct scmi_msg_resp_clock_describe_rates *resp;
+	unsigned int num_returned, num_remaining;
+	struct scmi_xfer *t;
+	int ret;
+
+	/* Get either the range triplet or the min rate & rates count */
+	ret = ph->xops->xfer_get_init(ph, CLOCK_DESCRIBE_RATES, sizeof(*msg), 0,
+				      &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->id = cpu_to_le32(clk_id);
+	msg->rate_index = 0;
+
+	resp = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (ret)
+		goto out;
+
+	clk->rate_discrete = RATE_DISCRETE(resp->num_rates_flags);
+	num_returned = NUM_RETURNED(resp->num_rates_flags);
+	num_remaining = NUM_REMAINING(resp->num_rates_flags);
+
+	if (clk->rate_discrete) {
+		clk->list.num_rates = num_returned + num_remaining;
+		clk->list.min_rate = RATE_TO_U64(resp->rate[0]);
+
+		if (num_remaining) {
+			ph->xops->reset_rx_to_maxsz(ph, t);
+			msg->id = cpu_to_le32(clk_id);
+			msg->rate_index = cpu_to_le32(clk->list.num_rates - 1);
+			ret = ph->xops->do_xfer(ph, t);
+			if (!ret)
+				clk->list.max_rate = RATE_TO_U64(resp->rate[0]);
+		} else {
+			u64 max = RATE_TO_U64(resp->rate[num_returned - 1]);
+
+			clk->list.max_rate = max;
+		}
+	} else {
+		/* We expect a triplet, warn about out of spec replies ... */
+		if (num_returned != 3 || num_remaining != 0) {
+			dev_warn(ph->dev,
+				 "Out-of-spec CLOCK_DESCRIBE_RATES reply for %s - returned:%d remaining:%d rx_len:%zd\n",
+				 clk->name, num_returned, num_remaining,
+				 t->rx.len);
+
+			/*
+			 * A known quirk: a triplet is returned but
+			 * num_returned != 3, check for a safe payload
+			 * size to use returned info.
+			 */
+			if (num_remaining != 0 ||
+			    t->rx.len != sizeof(*resp) +
+					 sizeof(__le32) * 2 * 3) {
+				dev_err(ph->dev,
+					"Cannot fix out-of-spec reply !\n");
+				ret = -EPROTO;
+				goto out;
+			}
+		}
+
+		clk->range.min_rate = RATE_TO_U64(resp->rate[0]);
+		clk->range.max_rate = RATE_TO_U64(resp->rate[1]);
+		clk->range.step_size = RATE_TO_U64(resp->rate[2]);
+
+		dev_dbg(ph->dev, "Min %llu Max %llu Step %llu Hz\n",
+			clk->range.min_rate, clk->range.max_rate,
+			clk->range.step_size);
 	}
 
+out:
+	ph->xops->xfer_put(ph, t);
+
 	return ret;
 }
 
@@ -1089,8 +1185,12 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 		struct scmi_clock_info *clk = cinfo->clk + clkid;
 
 		ret = scmi_clock_attributes_get(ph, clkid, cinfo, version);
-		if (!ret)
-			scmi_clock_describe_rates_get(ph, clkid, clk);
+		if (!ret) {
+			if (PROTOCOL_REV_MAJOR(version) >= 0x2)
+				scmi_clock_get_rates_bound(ph, clkid, clk);
+			else
+				scmi_clock_describe_rates_get(ph, clkid, clk);
+		}
 	}
 
 	if (PROTOCOL_REV_MAJOR(version) >= 0x3) {
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 688466a0e816..240478bb8476 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -15,7 +15,6 @@
 
 #define SCMI_MAX_STR_SIZE		64
 #define SCMI_SHORT_NAME_MAX_SIZE	16
-#define SCMI_MAX_NUM_RATES		16
 
 /**
  * struct scmi_revision_info - version information structure
@@ -54,7 +53,8 @@ struct scmi_clock_info {
 	union {
 		struct {
 			int num_rates;
-			u64 rates[SCMI_MAX_NUM_RATES];
+			u64 min_rate;
+			u64 max_rate;
 		} list;
 		struct {
 			u64 min_rate;
-- 
2.25.1


