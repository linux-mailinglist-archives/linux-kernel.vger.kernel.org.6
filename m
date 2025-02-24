Return-Path: <linux-kernel+bounces-529330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E86A4233E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D60E16BAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658E13F43A;
	Mon, 24 Feb 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="JT3Wxp9X"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A7192D9D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407315; cv=none; b=pTkqejpUWgqImx4pC+rSDDDs5exSskeldNhcSQHF6IOSMKIFVUjEjl3OY41cXgiuTNvx5dl2H8GRYBJPSInwI1idb3Ohfp3cNFgQ9VXu587kiAed9HuCIGCKe368SAmZP6XM2K7pJOj45WAOoKkcIgxhJh6L2EME1uxAxxsMLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407315; c=relaxed/simple;
	bh=nCn/e9wT+E25eSZ1ei2joTWI7pSGhHrSkauu3idzI9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qo2/BJBFkomAQjBcw6P8gr9NOGqH4cyJD/dOaz754jYhJSRlfp2QzoHow5g7o7uwNY8TKrsVBFazTT8nwovVu4ANKwp8SGNDlWRWr1YU2NzaAczk7t46uDh+ABNx/eLnOg5G4dRJjjbr0paXF4dIMb1QKHfSf/zN3DH9y1IYxxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=JT3Wxp9X; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=+3tpAC2W8iJabEmawl81OO0+wWVWghHmKVFpf6gpmrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=JT3Wxp9XbBDYTDSbQb4SajFV97/NnVmYUzz0B1FmRMoEsFO0JrF9Psw8l4TXeTfW6
	 bjIRSMkCVheSYm0ivZhenC0khZk1olap6O0qxCFucjmfzb5V5toy+tXoIBcI6NUdWT
	 x8zsrlxdDcDfaVGdkddG4mUSLFBlBHJ2O6rGDU45qgCc6UPdfS3Q3iLakjlPLUmxzS
	 G4zd+7zR/DoOmdnAhW/cL4eOnLFd4gTcTWl1tb6Nua+TzICfAKubLXlTXPyq2ykk8d
	 x0ZHcYM8eGWoG2k9hb6y4ek/GGN4mwa1ypYlKwqapyazS0rMLmAPyJBY5P+iVZ02ys
	 qn8rIZ/UWNSgQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 05D384A0458;
	Mon, 24 Feb 2025 14:28:29 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 24 Feb 2025 22:27:58 +0800
Subject: [PATCH 2/5] of: Introduce and apply private is_pseudo_property()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-of_bugfix-v1-2-03640ae8c3a6@quicinc.com>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
In-Reply-To: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: OwNEz86RX_9nBuMgxsGzfZWC9eSPvAX1
X-Proofpoint-ORIG-GUID: OwNEz86RX_9nBuMgxsGzfZWC9eSPvAX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=959
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502240104
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

There are several places which check if a property name is one of
'name'|'phandle'|'linux,phandle'.

Introduce and apply private is_pseudo_property() for the check.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/base.c       | 4 +---
 drivers/of/of_private.h | 7 +++++++
 drivers/of/overlay.c    | 4 +---
 drivers/of/resolver.c   | 4 +---
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d2d41601136bc8ee2b97e31b83af1b361ba03261..001ff6ce4abf85c07f13649d5a9f691f549a8ccc 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1855,9 +1855,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 		int id, len;
 
 		/* Skip those we do not want to proceed */
-		if (!of_prop_cmp(pp->name, "name") ||
-		    !of_prop_cmp(pp->name, "phandle") ||
-		    !of_prop_cmp(pp->name, "linux,phandle"))
+		if (is_pseudo_property(pp->name))
 			continue;
 
 		np = of_find_node_by_path(pp->value);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f3e1193c8ded4899f39677a76da073e2266a1b9a..b0c077867bf4abc045ca332ebacb988cdead90fc 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -208,4 +208,11 @@ static void __maybe_unused of_dump_addr(const char *s, const __be32 *addr, int n
 static void __maybe_unused of_dump_addr(const char *s, const __be32 *addr, int na) { }
 #endif
 
+static inline bool is_pseudo_property(const char *prop_name)
+{
+	return !of_prop_cmp(prop_name, "name") ||
+		!of_prop_cmp(prop_name, "phandle") ||
+		!of_prop_cmp(prop_name, "linux,phandle");
+}
+
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 434f6dd6a86c1ffad2b0d490b2b612a5147994c5..5a51c52b9729af2ab77b5a9365cb72d30740f3b0 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -304,9 +304,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	int ret = 0;
 
 	if (target->in_livetree)
-		if (!of_prop_cmp(overlay_prop->name, "name") ||
-		    !of_prop_cmp(overlay_prop->name, "phandle") ||
-		    !of_prop_cmp(overlay_prop->name, "linux,phandle"))
+		if (is_pseudo_property(overlay_prop->name))
 			return 0;
 
 	if (target->in_livetree)
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 779db058c42f5b8198ee3417dfaab80c81b43e4c..31eb80d894ec569e5b7538cbc07895803ca7d402 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -161,9 +161,7 @@ static int adjust_local_phandle_references(const struct device_node *local_fixup
 	for_each_property_of_node(local_fixups, prop_fix) {
 
 		/* skip properties added automatically */
-		if (!of_prop_cmp(prop_fix->name, "name") ||
-		    !of_prop_cmp(prop_fix->name, "phandle") ||
-		    !of_prop_cmp(prop_fix->name, "linux,phandle"))
+		if (is_pseudo_property(prop_fix->name))
 			continue;
 
 		if ((prop_fix->length % 4) != 0 || prop_fix->length == 0)

-- 
2.34.1


