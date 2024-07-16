Return-Path: <linux-kernel+bounces-253223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C409931E51
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3927E28316C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B908EA943;
	Tue, 16 Jul 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Y1rO5zwf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezyZEdo4"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23088567F;
	Tue, 16 Jul 2024 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092307; cv=none; b=sYd51624tG3HvxMadntUA7G8CSdsr0rPUwdNRoY2+hRFGAz2C7cNNFeuntA0GKNQZAI3VJwW7nTRdutob0bOIS9N9qdoHLSSqKxHRxM4KI/M6kVN+4MofhO+qkZgylrhrkMc7dfe9kmYHfxBq3TsiVtFftRrjKXD3Fn5nWWH+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092307; c=relaxed/simple;
	bh=DhUVijoft+zc2MQRWKMmLENLhF3q7rH5J4bSqaVPZ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKXpx6P43tPWXK4WBR8IieZJAFRf8IK5HgpjrgbywPN0KDz8R5kBrzYNrM4GQA0nl3WtfRSu2Grha0CfxbiT1fFUMvdacI/U86Qy/unIfjywTpk/AiS1HeGshGzUI6sLfq3iTllq4ogPz2SbfESOu6eOnDWSw5Xow/ooDZ0NckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Y1rO5zwf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezyZEdo4; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1BA331380E54;
	Mon, 15 Jul 2024 21:11:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Jul 2024 21:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1721092305; x=
	1721178705; bh=qbyksZ7iEx44k4y6E5Q3QAM0NCeuNyBb9S85yzok2gA=; b=Y
	1rO5zwfd8BwSpIcogoAAETgFeQgg2V3ilzBLAVxkEBBWspO8sDLcvADKm7fYc84R
	j7gsseHF1BrwatW8CwGoe+9b4gi64iJV34aWHtQVwkdiL8pukSpt2mvOTTmtPMZJ
	Keiroks3GnyTz1RpbwLEcSwpPqsB4MLMBYthblfVa0VHsqcREHcrgj+uUK9FsE67
	cyQ9n12il+UU2V8telwIoiEhYC8+bzj7wZZt8KiaQf+C1KsL5hh8b5LMdETRyAjp
	Yt7fEquej3VsGJ/YLTlOxgOUoXm7Qifn3mlZ22GspOkUs+NVGR6KGVwjAkwsT8eP
	5WLYQDQmbUQssGqcBtYaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721092305; x=
	1721178705; bh=qbyksZ7iEx44k4y6E5Q3QAM0NCeuNyBb9S85yzok2gA=; b=e
	zyZEdo47QX9tymoEyNvJLzfjfslLjQupYpHwXj2dgCRTOzDnT1w00UqgiCbC+ykU
	8pHJf2bqP05ii6ZDvyQhQQq0rmdcPlE6p9iy6rXYuNVyOBMw0ip+cwtm8PbWL2qd
	/4/kIMvJfaDBqAGqUKC7g2yrjUBtPjPSuUDVerNSmRnibfIB298jYIM58MyoZ/wi
	CTSHIfxJN6GWul64UvwILRxyZLMvksVVmT5sueTCN/wka8Sn5hea8EfY/aVFdNY7
	FuDM6YUuXq2tTHygIMYSnqgt9J9tGAQQ9cIehwYpz3rHf2XEtZF48xaXERzmxOJf
	qyLBwkLuOL7gzuTv3dW2A==
X-ME-Sender: <xms:z8iVZo1ivAAAKXeI0wHwEGo5n9igyUhw7Oo-gc4vd4LyedNI3zX-Aw>
    <xme:z8iVZjHAsviUBmYlmJF1l9x6MjjTZgpcRDy_w9QDKpWiLh6tlHPkLCTQr27Nu4zua
    av2u5cd7YSS8-QWNNg>
X-ME-Received: <xmr:z8iVZg4zVB9DQDvO9_7s-Jzvn2d9pPeOnGToUox6hu9gTEPjuji_4g7bnOtT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeefgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgv
    ucffrdculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepgfetfedugfetudeuheetjefhuefggfelleetvdevtefhueeujeefvdegleev
    hefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:0MiVZh29g3a2a47laGYzb72pQkHdLY5N4v4WlAdu_43mmM0G0vKGEQ>
    <xmx:0MiVZrFX_4rTZ_mfRJg_sIlUnIpYVa0SstwRS1_-1aOMYS4DkVn1lg>
    <xmx:0MiVZq_4k20oGuV00MSRWgg-M1YXpsUZCnUTJ7z-lbDKI_QAnMe0hA>
    <xmx:0MiVZgmuXw_TQXe3ajMXroMksemFXfRoAE2gt6XjWsZSCvnKZwIRgg>
    <xmx:0ciVZg6F69vxPgTkXGCxAONwIDB_XQVupIagJarJIzkwhxM8LoiYLIlS>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jul 2024 21:11:40 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v1 1/1] platform/x86: asus-wmi: fix TUF laptop RGB variant
Date: Tue, 16 Jul 2024 13:11:30 +1200
Message-ID: <20240716011130.17464-2-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716011130.17464-1-luke@ljones.dev>
References: <20240716011130.17464-1-luke@ljones.dev>
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

Fixes: ae834a549ec1 ("platform/x86: asus-wmi: add support variant of TUF RGB")
Tested-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 7d87ff68f418..2b968003cb9b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -906,10 +906,14 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
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


