Return-Path: <linux-kernel+bounces-251386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8195193044C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23BBCB21C19
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 07:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5378E3D3AC;
	Sat, 13 Jul 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="UjpwvcZa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CpPj1n47"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E23A8F0;
	Sat, 13 Jul 2024 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720856420; cv=none; b=TUnohBW8DD1dqZ8dQrtEK96B5AWgcZl1vmsNrB34G+GjEJhGCbFEMrSnCkrMGNYo0aiAEkz3uBVo0sov9YNDKJpgZSjF5pz8FYN5C2eOaUiCBP/28NGcYs6N8ZhXETU5GKtk5eSUcq9rlS847pSnWTP6i7kLb5dKEyjCL/W6Shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720856420; c=relaxed/simple;
	bh=4hZsywXDA7FoIK301osJ8bMzWKvxqyuwo+s05wF/t8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ck21JPZHdhMJwYcw1RC3hH65s/hWcDE6PLIVOCh6X3TvyA8LPUP5dRqwCfanXBelhQBVqgaLtRDVxULMXCI6NGOTdOADQaZE0rgfQvl4DStg5ymdDitwaZo1M4AwsxCk44cMILtFN+Dhfvlx3ldT5ZwoccDC+PPNyxcbY/8dB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=UjpwvcZa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CpPj1n47; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 930BE1388831;
	Sat, 13 Jul 2024 03:40:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 13 Jul 2024 03:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1720856416; x=1720942816; bh=jMyuBQRKOqnVq6xVHyydK
	/usqhMkFp9sGyVsbSi1+HE=; b=UjpwvcZaeua9TpTu+R3WhvmPnllsI+3xZwj3b
	HMCbu2lsRxnCdX6YMCoiwypzKR0Fe2rbMgA7cb61ZpoUEXHQsCXUfWNEjlEjbOGn
	RrpFfrC6CGbL/XX4rwPcKwdl0HCSmyK5cmxXXx6fk86o17t/Bv2gFcP46LlDIL3r
	Aci3FyDAxRny6/TcSXnHQcfZV3N1lxtJsoWvz0zcwW99oTN4kGOQcaMPpBquHo8A
	qq1yWDVUrwmpRwMjhmjjfy+W/kO3A1jH9XH8bLzSlja4H4jDEuFWbpBIRxiUNQDd
	7u+xtr9zT1gdwchNmigkYaugDqBfhIBSRaVQiGegH616v0AlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720856416; x=1720942816; bh=jMyuBQRKOqnVq6xVHyydK/usqhMk
	Fp9sGyVsbSi1+HE=; b=CpPj1n477vtZEZBFBoWaVRQSP4HaQowpYk/3WoMHHhIq
	kUAvD2eJ0PfOE98tKBIa8toz/z+SCZrqq4/yTZcVLL+UxDBd5WdWYgACk970eStI
	3n6jprXjkPJVPpcn+e/cF1QJXS19uUK1yqge5ZVzh2GFi2pmrDXQBMcd7Cy/FfRu
	5Gen0pkFABviyFTmk7UFfO8K+8Xpf9fhMw3R9C0y9KGsxolIWoADXWG5/xIOlPOK
	EjRVGMl34sVC+hg7cFJ9x6zoC+Dg4tAsuAXX673DNuh3u2MRFXt8STHSvbrm3oCs
	xX60in5slyZD4a3cynQoiWzcad63JZzEsLf/vv6Pwg==
X-ME-Sender: <xms:Xi-SZs77XKOj8HUlbWchaJod7zwGTYkNIMvuCAAHkBkuIJJ6ciQS9Q>
    <xme:Xi-SZt5msCbR72iSHZvfAmQT-DGj9S67UDf_vEWRaD3VKzma5U2tqkCOadX8y51K3
    QNyHE0Hyfgwpw-MYuE>
X-ME-Received: <xmr:Xi-SZreYj0UCxbEZUx84TXtMXDWkdoS2nMVChwp_QxyPdntGkO56oHBf-orU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeejgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepfdfnuhhkvgcu
    ffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpefgudejtdfhuddukefffeekiefftddtvdfhgeduudeuffeuhfefgfegfeetvedv
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Xi-SZhLc72D-L64XkuIufgcPIBicTJNIi4r9t_baz3GXEsn3Cr0dgg>
    <xmx:Xi-SZgKktH5McAk8uLzORuMRmKM9n7uihPziWf0b4Y2y1PVa8AWGTA>
    <xmx:Xi-SZiw9Aq34amaG5eka5ywc85G7ukbUQWpWprs3qHfYe1v-okvvsQ>
    <xmx:Xi-SZkIlF6x2Kfiy5lVABkFI0xMqv7rQrKvp980QhHT6lcsYW-r7SA>
    <xmx:YC-SZo_wWDnpWwUxEYFBsnoeo326nXLGLF4HoQBHzrlNValCGsu8FnH8>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jul 2024 03:40:11 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH] Fixes: ae834a549ec1 ("platform/x86: asus-wmi: add support variant of TUF RGB")
Date: Sat, 13 Jul 2024 19:40:05 +1200
Message-ID: <20240713074005.66254-1-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In kbd_rgb_mode_store the dev_get_drvdata() call was assuming the device
data was asus_wmi when it was actually led_classdev.

This patch corrects this by making the correct chain of calls to get the
asus_wmi driver data.

Tested-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 799d928c7d3d..2935af013535 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -879,10 +879,14 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
-	struct asus_wmi *asus = dev_get_drvdata(dev);
 	u32 cmd, mode, r, g, b, speed;
+	struct led_classdev *led;
+	struct asus_wmi *asus;
 	int err;
 
+	led = dev_get_drvdata(dev);
+	asus = container_of(led, struct asus_wmi, kbd_led);
+
 	if (sscanf(buf, "%d %d %d %d %d %d", &cmd, &mode, &r, &g, &b, &speed) != 6)
 		return -EINVAL;
 
-- 
2.45.2


