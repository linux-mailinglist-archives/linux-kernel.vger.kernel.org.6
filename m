Return-Path: <linux-kernel+bounces-182674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F28C8E52
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8911F22B90
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FD91419B5;
	Fri, 17 May 2024 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="uofYj0pO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PVvv3a/g"
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10917140375;
	Fri, 17 May 2024 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715985870; cv=none; b=EE822v+oyGK0myPjppDCcwteAqusXKulS7nEehQ8Jy1hgDSFW/oCjjWLqOvh633mE+4POXT0LkOhAis656grqsFhx4M+DTSpSCNdiAa6ADCTEDGPbmSShtxRGl0AZRvGn1ML8cBn1SWK7othnB3cJOsptHlud38lrg4qKiG122g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715985870; c=relaxed/simple;
	bh=HWrrVsIWO8Y/vDkkDrw8BNTFmPPWbA2OH5R7wP7hxmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESmZD4Su6HSWpsXJQMRTuQ26vF1lwWMPkOG72ZmLhJTGclI3qlvFhRyo6xkgTgsAw5Hc3DL7Kk/IFJ54XzwjdX8M/qzbaGqQbJmNY1rUWVtMbv6PbgUhiQZHAKeXF2sWquf9yjQX6/k0METwvw9EheeGjW7P8IJeDbectx5OCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=uofYj0pO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PVvv3a/g; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 26BDF18000BC;
	Fri, 17 May 2024 18:44:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 17 May 2024 18:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1715985866; x=
	1716072266; bh=ophfuI0pldy6rb1ZeywejXaBasnIE+4VwXup8tD4W3A=; b=u
	ofYj0pOfyxS9Qhb2xjNo68yW7ShUe5HZHL1rfpcGRWiuxYu8cWgECmDSOcgb+DaA
	q2AZPxdej8jVougetKpaXUnqrMudM4VlQPhPV3V96zBPBLvnhp2XpQ2Qjh6NL1mX
	fr4bKIHrX77XsGU8YO+ZZ/wz//9lxgzaBZdpRsEaLTiZ3Kxec1VZTIo7T/ZiQQUu
	g/O3KEwiuoAtb3piYbLETlKv5konHomkshf15i1rmjXbvupGmoVy3ZHqJugU9Wsd
	vbrfVzennTFsjbfSZrLl2M8plSEmXh7dj17aJC/VqAWJM/S/e3vci16Il64jeDhg
	34HrugzYOPKzyf/lqoYHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715985866; x=
	1716072266; bh=ophfuI0pldy6rb1ZeywejXaBasnIE+4VwXup8tD4W3A=; b=P
	Vvv3a/gCvQAs4OzG2vRlb7V4swceXLWg8RhrAQ9jo+8osq54rQ3zBsXpQyXjt6q4
	3p7ham450d+krzfipF3q0aydprZYA+8NDLlFbtiO8dgdjEQ5Bz9lTMUHxx1RmOBu
	oUceGnaCuOqQAsTrVlIV9G+N7x5HMKpqAYWla1a6B7U9qheMVnT5hVv2YhNecVLt
	2e/3HgfkzD2Iv9TnIUO3LbIaLuIBdbV1XlsMHMjW/BhHABZSku7ffuiTSmLSfVa6
	aFUN01DFXNepp/WNx4UF4d5mr23gPWwWTszkGQx0thu1qTYk9tdfeW8k2+cwBx6Y
	p63Yj5dG1KF6feanbzTvw==
X-ME-Sender: <xms:yt1HZunOF-Q9VoBD2OaZFAcwg-lEj_CgnKod855WvRJsx3DfsiNoUQ>
    <xme:yt1HZl2LypbSD1zUCOTeQP7vlz4GyA48mnJk3H9-N_GHLcQNGZZ_m91e4MAkV2mc-
    4DIKiG2KS9A8aNUvSU>
X-ME-Received: <xmr:yt1HZso8j0RKQRW5zFsDNqmEjDXkPi4rhUlpSxewwmb6CUo4TqTD_M8GLd31ZDjycUXSeC8flT04naqrPDhy7ZB93qslTQ8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepnfihnhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhi
    hnuggvnhhordgtrgeqnecuggftrfgrthhtvghrnheplefhieffkedtledugfetgfegfeeh
    hfethffhffeuvefhtdekvdeikeehleejieetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:yt1HZinKtVxPjyi8I9r8CLqMsSEACIv2uwMTOBEZI1VFO3dDWd3lyw>
    <xmx:yt1HZs2tF_WNNIPZq7TOYFu7neqI_WiXGfd2oX2q8bjQ58u6iibXwQ>
    <xmx:yt1HZpvKHSHJDwQzZeH0ev01s7nHT5kkmN7ga3ctOOav0_gRGOzXMw>
    <xmx:yt1HZoUXOIHd5oErJwAjZqGBkL5xg6guHPqLAtNybWGAu6NrW0JHng>
    <xmx:yt1HZlE-ZHUprlh1GEy92wV52DLZ1ZybEY54nk2mxrxyqHPckfwGKDd6>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 18:44:26 -0400 (EDT)
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: lsanche@lyndeno.ca
Cc: mario.limonciello@amd.com,
	pali@kernel.org,
	W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	lkp@intel.com,
	hdegoede@redhat.com,
	Yijun.Shen@dell.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v7 2/3] platform/x86: dell-smbios: Move request functions for reuse
Date: Fri, 17 May 2024 16:42:35 -0600
Message-ID: <20240517224323.10045-3-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240517224323.10045-1-lsanche@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240517224323.10045-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the dell_send_request and dell_fill_request symbols into smbios-base
so that they can be used in multiple modules.

Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
---
 drivers/platform/x86/dell/dell-laptop.c      | 23 ------------------
 drivers/platform/x86/dell/dell-smbios-base.c | 25 ++++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios.h      |  5 ++++
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 42f7de2b4522..6552dfe491c6 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -353,29 +353,6 @@ static const struct dmi_system_id dell_quirks[] __initconst = {
 	{ }
 };
 
-static void dell_fill_request(struct calling_interface_buffer *buffer,
-			       u32 arg0, u32 arg1, u32 arg2, u32 arg3)
-{
-	memset(buffer, 0, sizeof(struct calling_interface_buffer));
-	buffer->input[0] = arg0;
-	buffer->input[1] = arg1;
-	buffer->input[2] = arg2;
-	buffer->input[3] = arg3;
-}
-
-static int dell_send_request(struct calling_interface_buffer *buffer,
-			     u16 class, u16 select)
-{
-	int ret;
-
-	buffer->cmd_class = class;
-	buffer->cmd_select = select;
-	ret = dell_smbios_call(buffer);
-	if (ret != 0)
-		return ret;
-	return dell_smbios_error(buffer->output[0]);
-}
-
 /*
  * Derived from information in smbios-wireless-ctl:
  *
diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index fbdd12a7cb8d..515c454acfe6 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -314,6 +314,31 @@ int dell_smbios_call(struct calling_interface_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(dell_smbios_call);
 
+void dell_fill_request(struct calling_interface_buffer *buffer,
+			       u32 arg0, u32 arg1, u32 arg2, u32 arg3)
+{
+	memset(buffer, 0, sizeof(struct calling_interface_buffer));
+	buffer->input[0] = arg0;
+	buffer->input[1] = arg1;
+	buffer->input[2] = arg2;
+	buffer->input[3] = arg3;
+}
+EXPORT_SYMBOL_GPL(dell_fill_request);
+
+int dell_send_request(struct calling_interface_buffer *buffer,
+			     u16 class, u16 select)
+{
+	int ret;
+
+	buffer->cmd_class = class;
+	buffer->cmd_select = select;
+	ret = dell_smbios_call(buffer);
+	if (ret != 0)
+		return ret;
+	return dell_smbios_error(buffer->output[0]);
+}
+EXPORT_SYMBOL_GPL(dell_send_request);
+
 struct calling_interface_token *dell_smbios_find_token(int tokenid)
 {
 	int i;
diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
index 756c354b1eef..1d6463cca12a 100644
--- a/drivers/platform/x86/dell/dell-smbios.h
+++ b/drivers/platform/x86/dell/dell-smbios.h
@@ -64,6 +64,11 @@ int dell_smbios_call_filter(struct device *d,
 	struct calling_interface_buffer *buffer);
 int dell_smbios_call(struct calling_interface_buffer *buffer);
 
+void dell_fill_request(struct calling_interface_buffer *buffer,
+			       u32 arg0, u32 arg1, u32 arg2, u32 arg3);
+int dell_send_request(struct calling_interface_buffer *buffer,
+			     u16 class, u16 select);
+
 struct calling_interface_token *dell_smbios_find_token(int tokenid);
 
 enum dell_laptop_notifier_actions {
-- 
2.42.0


