Return-Path: <linux-kernel+bounces-510324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D0DA31B27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9E57A34A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374A86F305;
	Wed, 12 Feb 2025 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="M/bEGU3g"
Received: from resqmta-a2p-658785.sys.comcast.net (resqmta-a2p-658785.sys.comcast.net [96.103.146.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125884502F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.103.146.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739323659; cv=none; b=EQml4BRESBqMyvsyJNcjWJNAEcvgnLjrwO3+ewdImzM+53Gg3EaJQVe1CecdEB+zlnV+v/zKlwfscMEoX430rgKLmswEhKciamMBElX4z7dkBMegN3mTnoL29XwaQTDxFvspumCQX3qeUJGabiFIiPfMrQstSdr9vjPQe3G7Vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739323659; c=relaxed/simple;
	bh=huMXU5PkK5OaSxJhp+YkycjSdx7SpClR99y4NMzsgPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FaSe6tJ6ONtc77MpbxyRUArTATwRr/tW4OYeOPVqtHdsW8hpCv/unJmRY1MsfHK1a4Zs85LUOY8iG26Ry6nNIbg2+KhCl6wJmgd4itd3jEqbEzErZVJQNETgnuxFXeVKby2cLJSPlc9KxDXOsowBGsSunomLtxfIUQIYgUV9odo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=comcast.net; spf=pass smtp.mailfrom=comcast.net; dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b=M/bEGU3g; arc=none smtp.client-ip=96.103.146.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=comcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comcast.net
Received: from resomta-a2p-647975.sys.comcast.net ([96.103.145.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resqmta-a2p-658785.sys.comcast.net with ESMTPS
	id i0pFt4uRjjNM1i1UqtxDhO; Wed, 12 Feb 2025 01:25:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=20190202a; t=1739323500;
	bh=sqsQOneILkPAi5s6Ecy2iy5+xQ+mWTe+ZD3pipY5ZnU=;
	h=Received:Received:From:To:Subject:Date:Message-ID:MIME-Version:
	 Xfinity-Spam-Result;
	b=M/bEGU3gsdbzzBWZcoFOVI0BSALeeFj3Dsqi4qbSH1TcoZzU2fW9JW3qzJ9VS/LRT
	 IQTfWlcc50cj6DBEOhuL4wfkp82BpePA7fXPEO4G5OEsU800SAM0IOwvM141WMp8ks
	 Nljs8Wl8IyTCM7iebDbdEAK8HEG3Ssako5G+pXQWh3uJ+m/CegRBGyJQJU/CkMOQ+g
	 u5QPg7L4MQYLWO4koRt+KcA9wErTC1D7cI2ng42DvbW8NsC38X9D8Pu83Q4itzWCkF
	 ufW7AV/4eVpXIgd7oQkaKgSU1GT4kK5erOZiu8kpWGpP2wO230wvMLuUWfI9x0vr08
	 O1BcUCFe0xLkg==
Received: from jack-livingood.hsd1.ca.comcast.net
 ([IPv6:2601:647:4d81:b870::c894])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-a2p-647975.sys.comcast.net with ESMTPSA
	id i1UftMnGEnjISi1Uktf2bR; Wed, 12 Feb 2025 01:24:57 +0000
From: jack Livingood <jacklivingood@comcast.net>
To: sfr@canb.auug.org.au
Cc: tiwai@suse.de,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Jack Livingood <jacklivingood@comcast.net>
Subject: [PATCH 1/4] sounds: firewire: isight: changed strcpy to strscpy
Date: Tue, 11 Feb 2025 17:23:46 -0800
Message-ID: <20250212012346.83516-1-jacklivingood@comcast.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHAiJ30Wmtx29GpTwxjkHtaV2oqyinE5N36XH0KTPLa0/Vl93uTAar6MbtN8PmQ+0Ju2JbZd/uGT951ivvrvEg2y+Eo0bkZoSDFNlZ0k7wHcVy/vX7qR
 22ilMV4o4Md4T6iHXlC7v4UgCGLX+c1SpZe10h+QVmEofQ+9eUL3IoqziY+xlhInIV0rdJgy3zhIYJQbrGuLZDLOXY0iqO7CbuSKtfD61pwKCfFsGVEEH+hn
 yiha/LRQ7ZhxRAsti0NzRljNwL8KHVGszK8ORpa+s6MYIEWIk5sPvBvarGBwvoq3GvFttBc5lDpq2HF9sV7OtvuFcVu+U+chVpDCUpOZ9UBPkClPtXrsr6RX
 XgHuCXyRF8spZ4dkKC2nVRN+VBoF5FfpAxwiF66YBAAa//XrGnE=

From: Jack Livingood <jacklivingood@comcast.net>

fixed a spelling issue in the commit made previous

Signed-off-by: Jack Livingood <jacklivingood@comcast.net>
---
 sound/firewire/isight.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 806f82c9ceee..e9617fc0a532 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -637,13 +637,13 @@ static int isight_probe(struct fw_unit *unit,
 
 	card->private_free = isight_card_free;
 
-	strcpy(card->driver, "iSight");
-	strcpy(card->shortname, "Apple iSight");
+	strscpy(card->driver, "iSight");
+	strscpy(card->shortname, "Apple iSight");
 	snprintf(card->longname, sizeof(card->longname),
 		 "Apple iSight (GUID %08x%08x) at %s, S%d",
 		 fw_dev->config_rom[3], fw_dev->config_rom[4],
 		 dev_name(&unit->device), 100 << fw_dev->max_speed);
-	strcpy(card->mixername, "iSight");
+	strscpy(card->mixername, "iSight");
 
 	err = isight_create_pcm(isight);
 	if (err < 0)
-- 
2.48.1


