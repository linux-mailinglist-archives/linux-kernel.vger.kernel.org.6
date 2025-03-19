Return-Path: <linux-kernel+bounces-567387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC0A6855B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0F23BEBFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86724F5A0;
	Wed, 19 Mar 2025 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="iKb5qD+q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxRzi32D"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F1424EF77;
	Wed, 19 Mar 2025 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367527; cv=none; b=gPOaCidwbKbztfasfMhXmmrYYCuBzQRAf7JdWMTTkn6GykqRLEAC6ukABOfmnK2kK7nIeQOP//0O8F1I05iS7FpSd2S7ISuiWLnZiaITf+ntyZ8jXQTdTKVe+mhZVNdSiwjpAH5G5k6/63a6QkJaB3TY51aYn+Y/MdkCjzbx/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367527; c=relaxed/simple;
	bh=t3hdt5uXEx9dxL3lKnsKjczVJtdf7kTGQr3g0tIWQOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngXE+i/j/atJKzWmZS+iNLysH7rToLdSZJyz5iK8K8Ysouf7D2hejT/Z0fi7+UYMFlchByaCKEXL0Y9ZKp08WMyoBy4zmJ2335TasjjcxBWQABAfG0LHYL953JmzWIja8wwXLspHhcfd/QH1YyCPN99XaVXI6LoziKAst33KPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=iKb5qD+q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxRzi32D; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B4FAB11400BF;
	Wed, 19 Mar 2025 02:58:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 19 Mar 2025 02:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742367523; x=
	1742453923; bh=Rtjh6ZRlRVNYPddesNT8V4uwDysytInj1MX69Xl/58A=; b=i
	Kb5qD+qIlbnDhCwO6zQJoYk8hLoUQ1qp2UFmjawWujtQIoV+jnX6eARwghmkG7r/
	W4TZKSH8csTQEsmRh6SUaGgX3iLcf2bkdgDsUvRSkk/sfuuExe/qQj1+YVtG3Wn0
	lhC02ZMlUxjgIj5ClbC9PRXYNSMWx81zTGRnIC6VTm1sGuSTpo5/FBzqKDlWmlwB
	0sEQqLtSGe4s0UgvhPUc0R0R+1nQ0uIZXccVjTvvHE1B1fEkyggaUREVwiXU1hgC
	dqFdUKaiZ3qRmneqeox5juYUb0mGCYgPuSGAE0Ihl4MUgP+LquL4/REoiADj3wes
	62sv9lcbccbfuwBXvuq7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742367523; x=1742453923; bh=R
	tjh6ZRlRVNYPddesNT8V4uwDysytInj1MX69Xl/58A=; b=WxRzi32DkDJPX4trp
	mU8FQwy/ziPZN+9f5xJXzQCwgimq1ARGvnJ2PoORp9ne9PQZgJII7j9Oxj51XCE7
	rm9z2wnVQzY1/1xOah4Js8r06MbABRX4MSGAUER5sfN+A07cZpVsULV+7KvSu3/U
	zg1zRYRsafFt1W44Z7MQFPqjnZroGP0zw/wb8WzXao9dFqJ0hiYfOLqMhkQVWklg
	ps1h+7ptWUHN4bx1yaowABKzRfz4wPNuEg44ycIANCsIAhamWOpyFjkP+nlh6/C+
	GD45q3XnAdC2hbzheWlNd9YFLMeXjMApecFsjFlmmm//c4NMGSBuR9b9aE7mSAVn
	VUdbw==
X-ME-Sender: <xms:ImvaZ2ol4VQ1BceljSmvUGAlOUo9dmnaB3Q8j1EOui1dwmcyM-9TxQ>
    <xme:ImvaZ0pGKB0aQ10dxQ-MnyyqWxtYEMiXCwE77CqbdBfmZI3v9WlMgWIwLiHylT5E1
    ZxR0XK5Iv5qtgxnz88>
X-ME-Received: <xmr:ImvaZ7PB5Ijsn-zUdK0zMwpfdf3BCtCt__PUiQdWE9oTbfTqN4Gs0zQHO17WcdJ3K6bM5vz83Ylo-XCkzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvh
    eqnecuggftrfgrthhtvghrnhepueeuleeffeeihfelhffhheelfeffgeetuefhheevkeet
    uedugfetfeetlefhieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinh
    htvghlrdgtohhmpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekiees
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntg
    hivghllhhosegrmhgurdgtohhmpdhrtghpthhtoheplhhukhgvsehljhhonhgvshdruggv
    vh
X-ME-Proxy: <xmx:ImvaZ163VN-9Cqi-JP3BXdmMrz20fRVBd9oXuZdoROPX2dRcFAodNw>
    <xmx:ImvaZ15LvP7XxLMPqiKhdTZjuzb7ITmeboR5G0F11ztuTFdXTxgp2Q>
    <xmx:ImvaZ1gncSGCM97zxPlBSU8b32WYMM34fJi0FIsxOGPfK3TDaV1lBg>
    <xmx:ImvaZ_5hRO5p4YqT-nxpZg8GgZdZq_oAHWRxmZ6i5ZOujVNxC3aiQA>
    <xmx:I2vaZzTqWjo7RBO8cLzcONIvwixAc6UD1qwR-5myGd34hRefceK-tooW>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 02:58:39 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v8 1/8] platform/x86: asus-wmi: export symbols used for read/write WMI
Date: Wed, 19 Mar 2025 19:58:20 +1300
Message-ID: <20250319065827.53478-2-luke@ljones.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319065827.53478-1-luke@ljones.dev>
References: <20250319065827.53478-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

Export symbols for read/write WMI symbols using a namespace.
Existing functions:
- asus_wmi_evaluate_method
- asus_wmi_set_devstate
New function:
- asus_wmi_get_devstate_dsts

The new function is inteded for use with DSTS WMI method only and
avoids requiring the asus_wmi driver data to select the WMI method.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/asus-wmi.c            | 45 ++++++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  9 +++++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cbc64d3a22ad..2784b8e6514e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -389,7 +389,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
 {
 	return asus_wmi_evaluate_method3(method_id, arg0, arg1, 0, retval);
 }
-EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
+EXPORT_SYMBOL_NS_GPL(asus_wmi_evaluate_method, "ASUS_WMI");
 
 static int asus_wmi_evaluate_method5(u32 method_id,
 		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
@@ -553,12 +553,51 @@ static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
 	return 0;
 }
 
-int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
-				 u32 *retval)
+
+/**
+ * asus_wmi_get_devstate_dsts() - Get the WMI function state.
+ * @dev_id: The WMI method ID to call.
+ * @retval: A pointer to where to store the value returned from WMI.
+ *
+ * On success the return value is 0, and the retval is a valid value returned
+ * by the successful WMI function call otherwise an error is returned if the
+ * call failed, or if the WMI method ID is unsupported.
+ */
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	int err;
+
+	err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, retval);
+	if (err)
+		return err;
+
+	if (*retval == ASUS_WMI_UNSUPPORTED_METHOD)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(asus_wmi_get_devstate_dsts, "ASUS_WMI");
+
+/**
+ * asus_wmi_set_devstate() - Set the WMI function state.
+ * @dev_id: The WMI function to call.
+ * @ctrl_param: The argument to be used for this WMI function.
+ * @retval: A pointer to where to store the value returned from WMI.
+ *
+ * The returned WMI function state if not checked here for error as
+ * asus_wmi_set_devstate() is not called unless first paired with a call to
+ * asus_wmi_get_devstate_dsts() to check that the WMI function is supported.
+ *
+ * On success the return value is 0, and the retval is a valid value returned
+ * by the successful WMI function call. An error value is returned only if the
+ * WMI function failed.
+ */
+int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
 {
 	return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
 					ctrl_param, retval);
 }
+EXPORT_SYMBOL_NS_GPL(asus_wmi_set_devstate, "ASUS_WMI");
 
 /* Helper for special devices with magic return codes */
 static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a32cb8865b2f..96ff25b2b51b 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -160,6 +160,7 @@
 #if IS_REACHABLE(CONFIG_ASUS_WMI)
 void set_ally_mcu_hack(bool enabled);
 void set_ally_mcu_powersave(bool enabled);
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
 int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
 int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
 #else
@@ -175,6 +176,14 @@ static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
 {
 	return -ENODEV;
 }
+static inline int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	return -ENODEV;
+}
+static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
+{
+	return -ENODEV;
+}
 static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
 					   u32 *retval)
 {
-- 
2.49.0


