Return-Path: <linux-kernel+bounces-294839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC746959341
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946222852C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A824225DA;
	Wed, 21 Aug 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nLxI+kgd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF42E157A61;
	Wed, 21 Aug 2024 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724210097; cv=none; b=nvTEEF/mBwrGKQiPpEZ/bsVZeW8F+UySyR19K4S7MPmj3OWDgxwYQLjK726GSlxWXwOU4QFi2PQtyCvmdCEOBEKY0jm5/fm6Ct8HEHcBMNDs/TXrXgdnfFVjqD5wsiNQB3QEqrR9eQEgNlK93fzs/Csa78ANIUyeXVUPotCARHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724210097; c=relaxed/simple;
	bh=3CUYHsxp+5VFoKv+GFcNuDvb6S7SLjq+KUWIr3/jAyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnTZe9AEEsH0iK3HPPSSYv4ZF67z4AipugMKMZ3vuwuRVbADWZJlAshgubgRauGTUBWKBEf0KHOZim5AJ5F4wr3gIVGr3NVsc+z/C+976+ADZHNmpKlm8qIZtUeH9z7lbIJLRqSXXdVdOYskm3XbAs1QgwNoXg1X/lvA1zHrULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nLxI+kgd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KF3CFa022365;
	Wed, 21 Aug 2024 03:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c7E9L9BtLeSA9YfD5ROOkjwq
	qPBLJOsr8pLqp40PavA=; b=nLxI+kgdWnLhYvBkKo7nz5o4AQ1CFCTXNyzjOUm4
	B+sgHw5yMLkcs3PoEfU9TI3PuSoSBvNrltgN45ZLeWvGDmYXmllxFR7/nl4RUsnk
	6sInZr1V7PjYfw/rZ1i69hKe1CQKfuG0NfzxtXDq0DiLfapnf6B7WkV/vMOQsSqm
	WcJESGQhoGnzFb2MhrUxOJqiM3kZplVh7ZdSTSduDbHlmSY90R0nMkDNag+yWy1U
	63p82Qso6AO09DxU0PN6Su6vJ4pcXIi68LI363XO3cpZiGrRgkCM7XxhwA5s3VFn
	oI8R/+CdThYDKmyAIj5BzPKUFhI5WnGRlGnJK55576lwyA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pdmasxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 03:14:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47L3ETPs021053
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 03:14:30 GMT
Received: from taozha2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 20 Aug 2024 20:14:26 -0700
From: Tao Zhang <quic_taozha@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan
	<leo.yan@linux.dev>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Tao Zhang <quic_taozha@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3 2/3] coresight: Add support for trace filtering by source
Date: Wed, 21 Aug 2024 11:13:47 +0800
Message-ID: <20240821031348.6837-3-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240821031348.6837-1-quic_taozha@quicinc.com>
References: <20240821031348.6837-1-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fFmrhCcvGFHYsGrf_XjD40ytOAACqaAS
X-Proofpoint-ORIG-GUID: fFmrhCcvGFHYsGrf_XjD40ytOAACqaAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_03,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210022

Some replicators have hard coded filtering of "trace" data, based on the
source device. This is different from the trace filtering based on
TraceID, available in the standard programmable replicators. e.g.,
Qualcomm replicators have filtering based on custom trace protocol
format and is not programmable.

The source device could be connected to the replicator via intermediate
components (e.g., a funnel). Thus we need platform information from
the firmware tables to decide the source device corresponding to a
given output port from the replicator. Given this affects "trace
path building" and traversing the path back from the sink to source,
add the concept of "filtering by source" to the generic coresight
connection.

The specified source will be marked like below in the Devicetree.
test-replicator {
    ... ... ... ...
    out-ports {
        ... ... ... ...
        port@0 {
            reg = <0>;
            xxx: endpoint {
                remote-endpoint = <&xxx>;
                filter_src = <&xxx>; <-- To specify the source to
            };                           be filtered out here.
        };

        port@1 {
            reg = <1>;
            yyy: endpoint {
                remote-endpoint = <&yyy>;
                filter_src = <&yyy>; <-- To specify the source to
            };                           be filtered out here.
        };
    };
};

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 136 +++++++++++++++---
 .../hwtracing/coresight/coresight-platform.c  |  18 +++
 include/linux/coresight.h                     |   5 +
 3 files changed, 136 insertions(+), 23 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 9fc6f6b863e0..d09266a4dd1c 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -75,22 +75,57 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
 }
 EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
 
+static struct coresight_device *coresight_get_source(struct list_head *path)
+{
+	struct coresight_device *csdev;
+
+	if (!path)
+		return NULL;
+
+	csdev = list_first_entry(path, struct coresight_node, link)->csdev;
+	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
+		return NULL;
+
+	return csdev;
+}
+
+/**
+ * coresight_block_source - checks whether the connection matches the source
+ * of path if connection is binded to specific source.
+ * @src:	The source device of the trace path
+ * @conn:	The connection of one outport
+ *
+ * Return false if the connection doesn't have a source binded or source of the
+ * path matches the source binds to connection.
+ */
+static bool coresight_block_source(struct coresight_device *src,
+				    struct coresight_connection *conn)
+{
+	if (conn->filter_src_fwnode && (conn->filter_src_dev != src))
+		return true;
+	else
+		return false;
+}
+
 static struct coresight_connection *
-coresight_find_out_connection(struct coresight_device *src_dev,
-			      struct coresight_device *dest_dev)
+coresight_find_out_connection(struct coresight_device *csdev,
+			      struct coresight_device *out_dev,
+			      struct coresight_device *trace_src)
 {
 	int i;
 	struct coresight_connection *conn;
 
-	for (i = 0; i < src_dev->pdata->nr_outconns; i++) {
-		conn = src_dev->pdata->out_conns[i];
-		if (conn->dest_dev == dest_dev)
+	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
+		conn = csdev->pdata->out_conns[i];
+		if (coresight_block_source(trace_src, conn))
+			continue;
+		if (conn->dest_dev == out_dev)
 			return conn;
 	}
 
-	dev_err(&src_dev->dev,
-		"couldn't find output connection, src_dev: %s, dest_dev: %s\n",
-		dev_name(&src_dev->dev), dev_name(&dest_dev->dev));
+	dev_err(&csdev->dev,
+		"couldn't find output connection, csdev: %s, out_dev: %s\n",
+		dev_name(&csdev->dev), dev_name(&out_dev->dev));
 
 	return ERR_PTR(-ENODEV);
 }
@@ -251,7 +286,8 @@ static void coresight_disable_sink(struct coresight_device *csdev)
 
 static int coresight_enable_link(struct coresight_device *csdev,
 				 struct coresight_device *parent,
-				 struct coresight_device *child)
+				 struct coresight_device *child,
+				 struct coresight_device *source)
 {
 	int link_subtype;
 	struct coresight_connection *inconn, *outconn;
@@ -259,8 +295,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	if (!parent || !child)
 		return -EINVAL;
 
-	inconn = coresight_find_out_connection(parent, csdev);
-	outconn = coresight_find_out_connection(csdev, child);
+	inconn = coresight_find_out_connection(parent, csdev, source);
+	outconn = coresight_find_out_connection(csdev, child, source);
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && IS_ERR(inconn))
@@ -273,15 +309,16 @@ static int coresight_enable_link(struct coresight_device *csdev,
 
 static void coresight_disable_link(struct coresight_device *csdev,
 				   struct coresight_device *parent,
-				   struct coresight_device *child)
+				   struct coresight_device *child,
+				   struct coresight_device *source)
 {
 	struct coresight_connection *inconn, *outconn;
 
 	if (!parent || !child)
 		return;
 
-	inconn = coresight_find_out_connection(parent, csdev);
-	outconn = coresight_find_out_connection(csdev, child);
+	inconn = coresight_find_out_connection(parent, csdev, source);
+	outconn = coresight_find_out_connection(csdev, child, source);
 
 	link_ops(csdev)->disable(csdev, inconn, outconn);
 }
@@ -337,7 +374,8 @@ EXPORT_SYMBOL_GPL(coresight_disable_source);
  * disabled.
  */
 static void coresight_disable_path_from(struct list_head *path,
-					struct coresight_node *nd)
+					struct coresight_node *nd,
+					struct coresight_device *source)
 {
 	u32 type;
 	struct coresight_device *csdev, *parent, *child;
@@ -375,7 +413,7 @@ static void coresight_disable_path_from(struct list_head *path,
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			coresight_disable_link(csdev, parent, child);
+			coresight_disable_link(csdev, parent, child, source);
 			break;
 		default:
 			break;
@@ -388,7 +426,10 @@ static void coresight_disable_path_from(struct list_head *path,
 
 void coresight_disable_path(struct list_head *path)
 {
-	coresight_disable_path_from(path, NULL);
+	struct coresight_device *source;
+
+	source = coresight_get_source(path);
+	coresight_disable_path_from(path, NULL, source);
 }
 EXPORT_SYMBOL_GPL(coresight_disable_path);
 
@@ -418,7 +459,9 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode,
 	u32 type;
 	struct coresight_node *nd;
 	struct coresight_device *csdev, *parent, *child;
+	struct coresight_device *source;
 
+	source = coresight_get_source(path);
 	list_for_each_entry_reverse(nd, path, link) {
 		csdev = nd->csdev;
 		type = csdev->type;
@@ -456,7 +499,7 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode,
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			ret = coresight_enable_link(csdev, parent, child);
+			ret = coresight_enable_link(csdev, parent, child, source);
 			if (ret)
 				goto err;
 			break;
@@ -468,7 +511,7 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode,
 out:
 	return ret;
 err:
-	coresight_disable_path_from(path, nd);
+	coresight_disable_path_from(path, nd, source);
 	goto out;
 }
 
@@ -619,6 +662,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
  * @csdev:	The device to start from.
  * @sink:	The final sink we want in this path.
  * @path:	The list to add devices to.
+ * @source:	The trace source device of the path.
  *
  * The tree of Coresight device is traversed until @sink is found.
  * From there the sink is added to the list along with all the devices that led
@@ -627,7 +671,8 @@ static void coresight_drop_device(struct coresight_device *csdev)
  */
 static int _coresight_build_path(struct coresight_device *csdev,
 				 struct coresight_device *sink,
-				 struct list_head *path)
+				 struct list_head *path,
+				 struct coresight_device *source)
 {
 	int i, ret;
 	bool found = false;
@@ -639,7 +684,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
 
 	if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
 	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
-		if (_coresight_build_path(sink, sink, path) == 0) {
+		if (_coresight_build_path(sink, sink, path, source) == 0) {
 			found = true;
 			goto out;
 		}
@@ -650,8 +695,13 @@ static int _coresight_build_path(struct coresight_device *csdev,
 		struct coresight_device *child_dev;
 
 		child_dev = csdev->pdata->out_conns[i]->dest_dev;
+
+		if (csdev->pdata->out_conns[i]->filter_src_dev
+		    && (csdev->pdata->out_conns[i]->filter_src_dev != source))
+			continue;
+
 		if (child_dev &&
-		    _coresight_build_path(child_dev, sink, path) == 0) {
+		    _coresight_build_path(child_dev, sink, path, source) == 0) {
 			found = true;
 			break;
 		}
@@ -696,7 +746,7 @@ struct list_head *coresight_build_path(struct coresight_device *source,
 
 	INIT_LIST_HEAD(path);
 
-	rc = _coresight_build_path(source, sink, path);
+	rc = _coresight_build_path(source, sink, path, source);
 	if (rc) {
 		kfree(path);
 		return ERR_PTR(rc);
@@ -924,6 +974,16 @@ static int coresight_orphan_match(struct device *dev, void *data)
 	for (i = 0; i < src_csdev->pdata->nr_outconns; i++) {
 		conn = src_csdev->pdata->out_conns[i];
 
+		/* Fix filter source device before skip the port */
+		if ((conn->filter_src_fwnode) && dst_csdev
+			&& (conn->filter_src_fwnode == dst_csdev->dev.fwnode)) {
+			if (dst_csdev->type == CORESIGHT_DEV_TYPE_SOURCE)
+				conn->filter_src_dev = dst_csdev;
+			else
+				dev_warn(&conn->filter_src_dev->dev,
+				  "Filter source is not a source device\n");
+		}
+
 		/* Skip the port if it's already connected. */
 		if (conn->dest_dev)
 			continue;
@@ -953,6 +1013,14 @@ static int coresight_orphan_match(struct device *dev, void *data)
 			ret = coresight_add_in_conn(conn);
 			if (ret)
 				return ret;
+
+			/*
+			 * Make sure the device still orphan if there is a
+			 * filter source firmware node but the filter source
+			 * device is null.
+			 */
+			if (conn->filter_src_fwnode && !conn->filter_src_dev)
+				still_orphan = true;
 		} else {
 			/* This component still has an orphan */
 			still_orphan = true;
@@ -974,18 +1042,40 @@ static int coresight_fixup_orphan_conns(struct coresight_device *csdev)
 			 csdev, coresight_orphan_match);
 }
 
+static int coresight_clear_filter_source(struct device *dev, void *data)
+{
+	int i;
+	struct coresight_device *source = data;
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
+		if (csdev->pdata->out_conns[i]->filter_src_dev == source)
+			csdev->pdata->out_conns[i]->filter_src_dev = NULL;
+	}
+	return 0;
+}
+
 /* coresight_remove_conns - Remove other device's references to this device */
 static void coresight_remove_conns(struct coresight_device *csdev)
 {
 	int i, j;
 	struct coresight_connection *conn;
 
+	if (csdev->type == CORESIGHT_DEV_TYPE_SOURCE)
+		bus_for_each_dev(&coresight_bustype, NULL, csdev,
+				 coresight_clear_filter_source);
+
 	/*
 	 * Remove the input connection references from the destination device
 	 * for each output connection.
 	 */
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		conn = csdev->pdata->out_conns[i];
+		if (conn->filter_src_fwnode) {
+			conn->filter_src_dev = NULL;
+			fwnode_handle_put(conn->filter_src_fwnode);
+		}
+
 		if (!conn->dest_dev)
 			continue;
 
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 64e171eaad82..6ef4b26f04bb 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -243,6 +243,24 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		conn.dest_fwnode = fwnode_handle_get(rdev_fwnode);
 		conn.dest_port = rendpoint.port;
 
+		/*
+		 * Get the firmware node of the filter source through the
+		 * reference. This could be used to filter the source in
+		 * building path.
+		 */
+		conn.filter_src_fwnode =
+			fwnode_find_reference(&ep->fwnode, "filter-src", 0);
+		if (IS_ERR(conn.filter_src_fwnode))
+			conn.filter_src_fwnode = NULL;
+		else {
+			conn.filter_src_dev =
+			 coresight_find_csdev_by_fwnode(conn.filter_src_fwnode);
+			if (conn.filter_src_dev && (conn.filter_src_dev->type
+			    != CORESIGHT_DEV_TYPE_SOURCE))
+				dev_warn(&conn.filter_src_dev->dev,
+				  "Filter source is not a source device\n");
+		}
+
 		new_conn = coresight_add_out_conn(dev, pdata, &conn);
 		if (IS_ERR_VALUE(new_conn)) {
 			fwnode_handle_put(conn.dest_fwnode);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index f09ace92176e..91a689b4514b 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -172,6 +172,9 @@ struct coresight_desc {
  * @dest_dev:	a @coresight_device representation of the component
 		connected to @src_port. NULL until the device is created
  * @link: Representation of the connection as a sysfs link.
+ * @filter_src_fwnode: filter source component's fwnode handle.
+ * @filter_src_dev: a @coresight_device representation of the component that
+		needs to be filtered.
  *
  * The full connection structure looks like this, where in_conns store
  * references to same connection as the source device's out_conns.
@@ -200,6 +203,8 @@ struct coresight_connection {
 	struct coresight_device *dest_dev;
 	struct coresight_sysfs_link *link;
 	struct coresight_device *src_dev;
+	struct fwnode_handle *filter_src_fwnode;
+	struct coresight_device *filter_src_dev;
 	atomic_t src_refcnt;
 	atomic_t dest_refcnt;
 };
-- 
2.17.1


