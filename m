Return-Path: <linux-kernel+bounces-282004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF6694DE2D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 20:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B8D28290A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5012EBD7;
	Sat, 10 Aug 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pQfwmFCD"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2097.outbound.protection.outlook.com [40.92.49.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DD18AF9;
	Sat, 10 Aug 2024 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723316020; cv=fail; b=cs27eWfjDZPzSBv9k4V14g2HItv1vzAMYOGtn8a/1dpxepqj6DG2mqIXKZY3kYc57LbotBS4n1yA48d/5lMhV9Bda7EG3nG/s3dpdh2yATwXr4VDSnfpZ47PZHgZlvZxCk1YiLtp+IjEZQ1MXQ3byI3QFP+l++ij0J7paP5oUyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723316020; c=relaxed/simple;
	bh=gB7DToxzVFrnXMShBTtJFy8+ZRu3tn+DXYQOPiTNWLY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e599F3mjS4d9IL7TknAI0Nqzz4nPfSe7RF4Lco/+o8WWpqaVTXeuZKo6iyfnWhkkqbENzCm5oMutWhkxcAqFL/dZFHIwQaJQBfp59qZjgx1OJ/tfEmmIQ5eEoDq0I8xznRBB/9acI+zgAzqRT/8AokSWJt6YSRa2Qy8Gg9B9QmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pQfwmFCD; arc=fail smtp.client-ip=40.92.49.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJQ50od8htQah1qEGwcO3K2SKvLSM41AObiJOgjPl4WnBWGtwopBPBTZHuVtGOarJ9yarDTdPWL+oLqd054DHlgdLwRy53rtAGWuFnaLuSKkU+n4kx/DdVR7tL4ibWVQG8DqrJCE8NS1tWEL88Zm+1X6yYhMe10k+yNPUz2VFYFe4prm3weH1Riay19VyfmMx/AsxxhoIwcqUBlpFzFWgp95dCnT1eAeQljcYxR8oX/O4H3vAy+SgSbpPyQl4BpqTXr3k44+qJS1xaimoQQWoazsf2YJXfxr5mjlvihFMyW1WrGxSUMuRTUf301Ir6iItwJOTUWGgPh+bBAfeRJH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRyWA5OpsH0Le8aaQZn9YpwDjc3HqjQdQokklETDbw0=;
 b=hX9V1Y0YFkcOIKKAqyk2Pzf86InPV3tXIumBcPVe65qTrLoPG8aRunX1ctWQodCxkSTCujmnaAcKCsx1n7eLkKrrU2rh4GCfqwtw3N4BDEe9D49MMHqVbTxHCDJwAoxZTEwze9ju+o74JdcBrVpbG51tvqzsxticlEAg5ur2FU9CL5h6qG4+iS2LMOJnwx+60kFGYvpdtG2PZgSdXFz6DKw5eRijJXa269fvKYRc0sWvNKP02iz0HVf4lKhGm7zzEs6e5gqJwV9NC8ngppIekcHAGsK3Qu15KNxMpbredg3E3bTyCEF+g8ZBUw2msDSggi5NOvLBgpF4ewmmlzTnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRyWA5OpsH0Le8aaQZn9YpwDjc3HqjQdQokklETDbw0=;
 b=pQfwmFCD8W1cmP+NVpADQSXnal/1YvkTnWSJ967Q08LdaCX4i3raGpmBUbgoBOkHf5aJjeE3/UsOwlzPYKutdKhl0N0AuDa3JO8QUJLWJZ+yvuGEtycb/zDfrlvcOMZuB6Tf74Ro6M+bjrXdKpx5Y1NNRyLB+rFsHO4jWEWe3+zbix3E3LB5GDvt6UoYrd4Kdsj9gr5J9iEejjuEkbcRnXjzaFeuQzVtd5itw108bRdEL3hLw4Agsy8OEMZvtOP/0eTZg+nvT8/m2+3WuXNnz5V/rFlT47jPxTt9REv7NVfM2EjvP7N0uKuJmvtPMIoiJVeXD0AFmo4xAohXWL9hTQ==
Received: from AS8P190MB1285.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e0::21)
 by GV1P190MB2111.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:1a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Sat, 10 Aug
 2024 18:53:32 +0000
Received: from AS8P190MB1285.EURP190.PROD.OUTLOOK.COM
 ([fe80::5307:a61:337b:f3fb]) by AS8P190MB1285.EURP190.PROD.OUTLOOK.COM
 ([fe80::5307:a61:337b:f3fb%5]) with mapi id 15.20.7849.018; Sat, 10 Aug 2024
 18:53:32 +0000
From: Karol Kosik <k.kosik@outlook.com>
To:
Cc: Karol Kosik <k.kosik@outlook.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Steven 'Steve' Kendall" <skend@chromium.org>,
	Alexander Tsoy <alexander@tsoy.me>,
	Kenny Levinsen <kl@kl.wtf>,
	Christos Skevis <xristos.thes@gmail.com>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Stefan Stistrup <sstistrup@gmail.com>,
	Sarah Grant <s@srd.tw>,
	Johan Carlsson <johan.carlsson@teenage.engineering>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Support multiple control interfaces
Date: Sat, 10 Aug 2024 11:49:55 -0700
Message-ID:
 <AS8P190MB1285B5259BF21D0616C25E3AECBB2@AS8P190MB1285.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [pAn3fPZsM82LabEZfWlnAj/jDWhIaB2F]
X-ClientProxiedBy: MW4PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:303:87::26) To AS8P190MB1285.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e0::21)
X-Microsoft-Original-Message-ID: <20240810185007.121601-1-k.kosik@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P190MB1285:EE_|GV1P190MB2111:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b44c62-94c7-4456-5c5e-08dcb96dbb31
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|15080799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	WFVUSQcMhjch+qCc4/YuYucVN8ZnHit0GtG7BKYdF0qabTp5uVi/W5/folYEbu4LVHxM88ln2YwBUaHlG4WWAiNawsuciMIxciNlasNn2ms2NfKsjr+u/5eyoDbAi3UPl3SPY+mwWxwVWwSSyNGaQT2OLR49xgb9YxoBgDgF/LdWqi6e7vLos5T3d2/JB0tVggxMNmN7LkiDWUlZIWui2gp4Qgh7i43EFgPWvoWua9Q8P4uwlOQWUfgvhYRFeqA4NietXvnevMMFmFXkjWr4PcPZH+yTHJGsRF5hzGd1cFPf03Y65MUz/XQcH9JxQ3mCXZd0V+6XB3IgIf1T0cyk32omlG+62uRxVl1oIfSrt1gK9uHxdQwzsEiA6vJRAq9cpm0par8Vg3fzRzpsxh35vk1WqpeA22s/jnxP0oBRUDPeIJLjOjxOslv1smEDZfbyM/z+2sUBIqoCVlQ6AJ9vdwAVGR/SECCPdQ7Nwrv2agROXMQ538t3f8AKNYG6llAbLqfraRQj2RMJwZelXbyH05eW+3BBM2ckiQhShkhgV97WtCKpkrv7i2Tc6IZ2NUhvVB9ozU3IKW4F9h0X2TOizmBqkL56X9CUOFr9naI+6oMSLpDf0unFTBM5dsGgKqjqTuIjL8/Y9Zh9lCuon3BmE9H/cWP3iO/5zxQHs0J14kGWVcd8g4SNi84K8h0s4nJoByq5Y8U5c3pOD/P+4MP/QeJnNZfnUbDMxyWUIeLXkcQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gg2yxX1YEDVRwWkkKpItJpbMHqLZ0GpvegoSz7WkE9pUEYowSVgiTqlzsn5P?=
 =?us-ascii?Q?W9BEQUx4TRN7RXW/AzNCDONdsJx2+WRy6t+KFhbcMO6q19W8QoNVVp7dMGTE?=
 =?us-ascii?Q?Pjgsa9Sm6Ib5Y4uaj/HkoA6xHapYG1jUlSEEByYAwEsOycHK7LWAa4YZmYH8?=
 =?us-ascii?Q?kC6bEmI0qrN3b3GFKwUA9kx/UoAzrH89+JjoSgwEahqDDoUvgkqTaueqBx4T?=
 =?us-ascii?Q?FE/pNbjYog/AUdFAXyAHKlkxZAoz80QIsWdSNARupCMMhKlFTYKVqON+xxR+?=
 =?us-ascii?Q?9EiRYjpMYsa+oO9dgqhWCfVjvHv92jbM4ktY9nVfobqDtVo7VL4CkBxHQRub?=
 =?us-ascii?Q?3s710XZdOGQTAtCcFgJtb0+UYBkuYa8/iN3NjieVqZig/4WqN47FHvhUWl8x?=
 =?us-ascii?Q?gZ8+PtEqcWMqdn/nu5YMCyi5wpZu5IqQl32CYI5vnpN5LPeruZUNEwvM6YNs?=
 =?us-ascii?Q?8YyEN1r0uTfXpgM0o2UX06xP6HiqxOHDakoJLtPMyOwBE5KItDLnsxtmQaHM?=
 =?us-ascii?Q?3Hx9Tn6WaVVzEBb2hhcRe3ccOX62kj85ykyJa7IRq2ztInzg7PRQBU2L+kd5?=
 =?us-ascii?Q?5U2K4B77oEg8GNI9nhC+YGH+4pnADFvux8G3uPMOm0fq+TxfelzIi5psMyaJ?=
 =?us-ascii?Q?yXvOJAS8lxxhzXXSrtEQr4u/9A6GZT17OMTlHQG4kl7ixxMorwXTqrny0zaG?=
 =?us-ascii?Q?pqFT82GSS4eTM3cIBFvhetgZ2sS3xRoP+v+5lZpMfwQ0vt5q1WsgqRPNseue?=
 =?us-ascii?Q?Y7uSuvC6wH+rSl32WhMpW4aQRabaXCibtXKdMQDd02waiZf2WrkcbYdKoAqF?=
 =?us-ascii?Q?zxlZIqADDY76K1OixA/KKmMj4zPB37fB+o/7iD0CyH1/bdPXGd0FlOm35rcb?=
 =?us-ascii?Q?dCANy5aKhjmG21Tl9TaxJNCAy3kFGzdzN+QSm5iiVSog8GSEIAWBISYuTjFR?=
 =?us-ascii?Q?mqZ9s534GIevzxcxiPcGkq4XKE/1XXW+tOQ2s4EoeUjEUneOiuMw/R8NWnjO?=
 =?us-ascii?Q?owzp360+hfsBLt3yO984aCLbPs+xij1fukzrgfH0GkbCGzCKlc5W6Idto1LH?=
 =?us-ascii?Q?CNmya3/7fdg74iCGRL3+6JIjdKTD4EbJG5GQAzoyQEgcJARw27DRrVEUjwOt?=
 =?us-ascii?Q?AqcVuAoRxAbjuN+NFyjdi+M6yxLJA7fh5U8A9qypitPlWRK+WM4amwFbGRwv?=
 =?us-ascii?Q?r/Lj91H6vJj33Z6vq2gHvdf1Vl2gqptINphbeVoEvB54XcrCxvYtzoTZ/Y8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b44c62-94c7-4456-5c5e-08dcb96dbb31
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1285.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 18:53:32.6437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB2111

USB standard allows for a device to have many audio functions, each
represented by Audio Interface Collection. Every audio function is
considered closed box and will contain unique AudioControl interface and
zero or more AudioStreaming and MIDIStreaming interfaces.

Add structure holding association between each interface and its
AudioControl Interface counterpart, instead of relying on AudioControl
Interface define for the entire device.

Signed-off-by: Karol Kosik <k.kosik@outlook.com>
---
 sound/usb/card.c           |  2 ++
 sound/usb/clock.c          | 62 ++++++++++++++++++++++++--------------
 sound/usb/format.c         |  6 ++--
 sound/usb/helper.c         | 34 +++++++++++++++++++++
 sound/usb/helper.h         | 10 ++++--
 sound/usb/mixer.c          |  2 +-
 sound/usb/mixer_quirks.c   | 17 ++++++-----
 sound/usb/mixer_scarlett.c |  4 +--
 sound/usb/power.c          |  3 +-
 sound/usb/power.h          |  1 +
 sound/usb/stream.c         | 21 ++++++++-----
 sound/usb/usbaudio.h       | 12 ++++++++
 12 files changed, 127 insertions(+), 47 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index bdb04fa37a71..778de9244f1e 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -206,6 +206,8 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 		return -EINVAL;
 	}
 
+	snd_usb_add_ctrl_interface_link(chip, interface, ctrlif);
+
 	if (! snd_usb_parse_audio_interface(chip, interface)) {
 		usb_set_interface(dev, interface, 0); /* reset the current interface */
 		return usb_driver_claim_interface(&usb_audio_driver, iface,
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 60fcb872a80b..8f85200292f3 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -76,11 +76,14 @@ static bool validate_clock_multiplier(void *p, int id, int proto)
 }
 
 #define DEFINE_FIND_HELPER(name, obj, validator, type2, type3)		\
-static obj *name(struct snd_usb_audio *chip, int id, int proto)	\
+static obj *name(struct snd_usb_audio *chip, int id,	\
+				const struct audioformat *fmt)	\
 {									\
-	return find_uac_clock_desc(chip->ctrl_intf, id, validator,	\
-				   proto == UAC_VERSION_3 ? (type3) : (type2), \
-				   proto);				\
+	struct usb_host_interface *ctrl_intf =	\
+		snd_usb_find_ctrl_interface(chip, fmt->iface); \
+	return find_uac_clock_desc(ctrl_intf, id, validator,	\
+				   fmt->protocol == UAC_VERSION_3 ? (type3) : (type2), \
+				   fmt->protocol);				\
 }
 
 DEFINE_FIND_HELPER(snd_usb_find_clock_source,
@@ -93,16 +96,19 @@ DEFINE_FIND_HELPER(snd_usb_find_clock_multiplier,
 		   union uac23_clock_multiplier_desc, validate_clock_multiplier,
 		   UAC2_CLOCK_MULTIPLIER, UAC3_CLOCK_MULTIPLIER);
 
-static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int selector_id)
+static int uac_clock_selector_get_val(struct snd_usb_audio *chip,
+				int selector_id, int iface_no)
 {
+	struct usb_host_interface *ctrl_intf;
 	unsigned char buf;
 	int ret;
 
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, iface_no);
 	ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
 			      UAC2_CS_CUR,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			      UAC2_CX_CLOCK_SELECTOR << 8,
-			      snd_usb_ctrl_intf(chip) | (selector_id << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (selector_id << 8),
 			      &buf, sizeof(buf));
 
 	if (ret < 0)
@@ -111,16 +117,18 @@ static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int selector_i
 	return buf;
 }
 
-static int uac_clock_selector_set_val(struct snd_usb_audio *chip, int selector_id,
-					unsigned char pin)
+static int uac_clock_selector_set_val(struct snd_usb_audio *chip,
+					int selector_id, unsigned char pin, int iface_no)
 {
+	struct usb_host_interface *ctrl_intf;
 	int ret;
 
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, iface_no);
 	ret = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
 			      UAC2_CS_CUR,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 			      UAC2_CX_CLOCK_SELECTOR << 8,
-			      snd_usb_ctrl_intf(chip) | (selector_id << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (selector_id << 8),
 			      &pin, sizeof(pin));
 	if (ret < 0)
 		return ret;
@@ -132,7 +140,7 @@ static int uac_clock_selector_set_val(struct snd_usb_audio *chip, int selector_i
 		return -EINVAL;
 	}
 
-	ret = uac_clock_selector_get_val(chip, selector_id);
+	ret = uac_clock_selector_get_val(chip, selector_id, iface_no);
 	if (ret < 0)
 		return ret;
 
@@ -155,8 +163,10 @@ static bool uac_clock_source_is_valid_quirk(struct snd_usb_audio *chip,
 	unsigned char data;
 	struct usb_device *dev = chip->dev;
 	union uac23_clock_source_desc *cs_desc;
+	struct usb_host_interface *ctrl_intf;
 
-	cs_desc = snd_usb_find_clock_source(chip, source_id, fmt->protocol);
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, fmt->iface);
+	cs_desc = snd_usb_find_clock_source(chip, source_id, fmt);
 	if (!cs_desc)
 		return false;
 
@@ -191,7 +201,7 @@ static bool uac_clock_source_is_valid_quirk(struct snd_usb_audio *chip,
 			err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 					      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 					      UAC2_CS_CONTROL_CLOCK_VALID << 8,
-					      snd_usb_ctrl_intf(chip) | (source_id << 8),
+					      snd_usb_ctrl_intf(ctrl_intf) | (source_id << 8),
 					      &data, sizeof(data));
 			if (err < 0) {
 				dev_warn(&dev->dev,
@@ -217,8 +227,10 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
 	struct usb_device *dev = chip->dev;
 	u32 bmControls;
 	union uac23_clock_source_desc *cs_desc;
+	struct usb_host_interface *ctrl_intf;
 
-	cs_desc = snd_usb_find_clock_source(chip, source_id, fmt->protocol);
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, fmt->iface);
+	cs_desc = snd_usb_find_clock_source(chip, source_id, fmt);
 	if (!cs_desc)
 		return false;
 
@@ -235,7 +247,7 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_CS_CONTROL_CLOCK_VALID << 8,
-			      snd_usb_ctrl_intf(chip) | (source_id << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (source_id << 8),
 			      &data, sizeof(data));
 
 	if (err < 0) {
@@ -274,7 +286,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 	}
 
 	/* first, see if the ID we're looking at is a clock source already */
-	source = snd_usb_find_clock_source(chip, entity_id, proto);
+	source = snd_usb_find_clock_source(chip, entity_id, fmt);
 	if (source) {
 		entity_id = GET_VAL(source, proto, bClockID);
 		if (validate && !uac_clock_source_is_valid(chip, fmt,
@@ -287,7 +299,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 		return entity_id;
 	}
 
-	selector = snd_usb_find_clock_selector(chip, entity_id, proto);
+	selector = snd_usb_find_clock_selector(chip, entity_id, fmt);
 	if (selector) {
 		pins = GET_VAL(selector, proto, bNrInPins);
 		clock_id = GET_VAL(selector, proto, bClockID);
@@ -317,7 +329,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 
 		/* the entity ID we are looking at is a selector.
 		 * find out what it currently selects */
-		ret = uac_clock_selector_get_val(chip, clock_id);
+		ret = uac_clock_selector_get_val(chip, clock_id, fmt->iface);
 		if (ret < 0) {
 			if (!chip->autoclock)
 				return ret;
@@ -346,7 +358,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 			if (chip->quirk_flags & QUIRK_FLAG_SKIP_CLOCK_SELECTOR ||
 			    !writeable)
 				return ret;
-			err = uac_clock_selector_set_val(chip, entity_id, cur);
+			err = uac_clock_selector_set_val(chip, entity_id, cur, fmt->iface);
 			if (err < 0) {
 				if (pins == 1) {
 					usb_audio_dbg(chip,
@@ -377,7 +389,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 			if (ret < 0)
 				continue;
 
-			err = uac_clock_selector_set_val(chip, entity_id, i);
+			err = uac_clock_selector_set_val(chip, entity_id, i, fmt->iface);
 			if (err < 0)
 				continue;
 
@@ -391,7 +403,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 	}
 
 	/* FIXME: multipliers only act as pass-thru element for now */
-	multiplier = snd_usb_find_clock_multiplier(chip, entity_id, proto);
+	multiplier = snd_usb_find_clock_multiplier(chip, entity_id, fmt);
 	if (multiplier)
 		return __uac_clock_find_source(chip, fmt,
 					       GET_VAL(multiplier, proto, bCSourceID),
@@ -491,11 +503,13 @@ static int get_sample_rate_v2v3(struct snd_usb_audio *chip, int iface,
 	struct usb_device *dev = chip->dev;
 	__le32 data;
 	int err;
+	struct usb_host_interface *ctrl_intf;
 
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, iface);
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_CS_CONTROL_SAM_FREQ << 8,
-			      snd_usb_ctrl_intf(chip) | (clock << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (clock << 8),
 			      &data, sizeof(data));
 	if (err < 0) {
 		dev_warn(&dev->dev, "%d:%d: cannot get freq (v2/v3): err %d\n",
@@ -524,8 +538,10 @@ int snd_usb_set_sample_rate_v2v3(struct snd_usb_audio *chip,
 	__le32 data;
 	int err;
 	union uac23_clock_source_desc *cs_desc;
+	struct usb_host_interface *ctrl_intf;
 
-	cs_desc = snd_usb_find_clock_source(chip, clock, fmt->protocol);
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, fmt->iface);
+	cs_desc = snd_usb_find_clock_source(chip, clock, fmt);
 
 	if (!cs_desc)
 		return 0;
@@ -544,7 +560,7 @@ int snd_usb_set_sample_rate_v2v3(struct snd_usb_audio *chip,
 	err = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
 			      UAC2_CS_CONTROL_SAM_FREQ << 8,
-			      snd_usb_ctrl_intf(chip) | (clock << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (clock << 8),
 			      &data, sizeof(data));
 	if (err < 0)
 		return err;
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 1bb6a455a1b4..0cbf1d4fbe6e 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -545,7 +545,9 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 	unsigned char tmp[2], *data;
 	int nr_triplets, data_size, ret = 0, ret_l6;
 	int clock = snd_usb_clock_find_source(chip, fp, false);
+	struct usb_host_interface *ctrl_intf;
 
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, fp->iface);
 	if (clock < 0) {
 		dev_err(&dev->dev,
 			"%s(): unable to find clock source (clock %d)\n",
@@ -557,7 +559,7 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_CS_CONTROL_SAM_FREQ << 8,
-			      snd_usb_ctrl_intf(chip) | (clock << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (clock << 8),
 			      tmp, sizeof(tmp));
 
 	if (ret < 0) {
@@ -592,7 +594,7 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_CS_CONTROL_SAM_FREQ << 8,
-			      snd_usb_ctrl_intf(chip) | (clock << 8),
+			      snd_usb_ctrl_intf(ctrl_intf) | (clock << 8),
 			      data, data_size);
 
 	if (ret < 0) {
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index bf80e55d013a..72b671fb2c84 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -130,3 +130,37 @@ snd_usb_get_host_interface(struct snd_usb_audio *chip, int ifnum, int altsetting
 		return NULL;
 	return usb_altnum_to_altsetting(iface, altsetting);
 }
+
+int snd_usb_add_ctrl_interface_link(struct snd_usb_audio *chip, int ifnum,
+		int ctrlif)
+{
+	struct usb_device *dev = chip->dev;
+	struct usb_host_interface *host_iface;
+
+	if (chip->num_intf_to_ctrl >= MAX_CARD_INTERFACES) {
+		dev_info(&dev->dev, "Too many interfaces assigned to the single USB-audio card\n");
+		return -EINVAL;
+	}
+
+	/* find audiocontrol interface */
+	host_iface = &usb_ifnum_to_if(dev, ctrlif)->altsetting[0];
+
+	chip->intf_to_ctrl[chip->num_intf_to_ctrl].interface = ifnum;
+	chip->intf_to_ctrl[chip->num_intf_to_ctrl].ctrl_intf = host_iface;
+	chip->num_intf_to_ctrl++;
+
+	return 0;
+}
+
+struct usb_host_interface *snd_usb_find_ctrl_interface(struct snd_usb_audio *chip,
+							int ifnum)
+{
+	int i;
+
+	for (i = 0; i < chip->num_intf_to_ctrl; ++i)
+		if (chip->intf_to_ctrl[i].interface == ifnum)
+			return chip->intf_to_ctrl[i].ctrl_intf;
+
+	/* Fallback to first audiocontrol interface */
+	return chip->ctrl_intf;
+}
diff --git a/sound/usb/helper.h b/sound/usb/helper.h
index e2b51ec96ec6..0372e050b3dc 100644
--- a/sound/usb/helper.h
+++ b/sound/usb/helper.h
@@ -17,6 +17,12 @@ unsigned char snd_usb_parse_datainterval(struct snd_usb_audio *chip,
 struct usb_host_interface *
 snd_usb_get_host_interface(struct snd_usb_audio *chip, int ifnum, int altsetting);
 
+int snd_usb_add_ctrl_interface_link(struct snd_usb_audio *chip, int ifnum,
+		int ctrlif);
+
+struct usb_host_interface *snd_usb_find_ctrl_interface(struct snd_usb_audio *chip,
+								int ifnum);
+
 /*
  * retrieve usb_interface descriptor from the host interface
  * (conditional for compatibility with the older API)
@@ -28,9 +34,9 @@ snd_usb_get_host_interface(struct snd_usb_audio *chip, int ifnum, int altsetting
 
 #define snd_usb_get_speed(dev) ((dev)->speed)
 
-static inline int snd_usb_ctrl_intf(struct snd_usb_audio *chip)
+static inline int snd_usb_ctrl_intf(struct usb_host_interface *ctrl_intf)
 {
-	return get_iface_desc(chip->ctrl_intf)->bInterfaceNumber;
+	return get_iface_desc(ctrl_intf)->bInterfaceNumber;
 }
 
 /* in validate.c */
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 2d27d729c3be..9945ae55b0d0 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -728,7 +728,7 @@ static int get_cluster_channels_v3(struct mixer_build *state, unsigned int clust
 			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
 			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			cluster_id,
-			snd_usb_ctrl_intf(state->chip),
+			snd_usb_ctrl_intf(state->mixer->hostif),
 			&c_header, sizeof(c_header));
 	if (err < 0)
 		goto error;
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index d56e76fd5cbe..5d6792f51f4c 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1043,7 +1043,7 @@ static int snd_ftu_eff_switch_init(struct usb_mixer_interface *mixer,
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			      pval & 0xff00,
-			      snd_usb_ctrl_intf(mixer->chip) | ((pval & 0xff) << 8),
+			      snd_usb_ctrl_intf(mixer->hostif) | ((pval & 0xff) << 8),
 			      value, 2);
 	if (err < 0)
 		return err;
@@ -1077,7 +1077,7 @@ static int snd_ftu_eff_switch_update(struct usb_mixer_elem_list *list)
 			      UAC_SET_CUR,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 			      pval & 0xff00,
-			      snd_usb_ctrl_intf(chip) | ((pval & 0xff) << 8),
+			      snd_usb_ctrl_intf(list->mixer->hostif) | ((pval & 0xff) << 8),
 			      value, 2);
 	snd_usb_unlock_shutdown(chip);
 	return err;
@@ -2115,24 +2115,25 @@ static int dell_dock_mixer_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
-static void dell_dock_init_vol(struct snd_usb_audio *chip, int ch, int id)
+static void dell_dock_init_vol(struct usb_mixer_interface *mixer, int ch, int id)
 {
+	struct snd_usb_audio *chip = mixer->chip;
 	u16 buf = 0;
 
 	snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
 			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 			(UAC_FU_VOLUME << 8) | ch,
-			snd_usb_ctrl_intf(chip) | (id << 8),
+			snd_usb_ctrl_intf(mixer->hostif) | (id << 8),
 			&buf, 2);
 }
 
 static int dell_dock_mixer_init(struct usb_mixer_interface *mixer)
 {
 	/* fix to 0dB playback volumes */
-	dell_dock_init_vol(mixer->chip, 1, 16);
-	dell_dock_init_vol(mixer->chip, 2, 16);
-	dell_dock_init_vol(mixer->chip, 1, 19);
-	dell_dock_init_vol(mixer->chip, 2, 19);
+	dell_dock_init_vol(mixer, 1, 16);
+	dell_dock_init_vol(mixer, 2, 16);
+	dell_dock_init_vol(mixer, 1, 19);
+	dell_dock_init_vol(mixer, 2, 19);
 	return 0;
 }
 
diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 0d6e4f15bf77..ff548041679b 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -460,7 +460,7 @@ static int scarlett_ctl_meter_get(struct snd_kcontrol *kctl,
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	unsigned char buf[2 * MAX_CHANNELS] = {0, };
 	int wValue = (elem->control << 8) | elem->idx_off;
-	int idx = snd_usb_ctrl_intf(chip) | (elem->head.id << 8);
+	int idx = snd_usb_ctrl_intf(elem->head.mixer->hostif) | (elem->head.id << 8);
 	int err;
 
 	err = snd_usb_ctl_msg(chip->dev,
@@ -1002,7 +1002,7 @@ int snd_scarlett_controls_create(struct usb_mixer_interface *mixer)
 	err = snd_usb_ctl_msg(mixer->chip->dev,
 		usb_sndctrlpipe(mixer->chip->dev, 0), UAC2_CS_CUR,
 		USB_RECIP_INTERFACE | USB_TYPE_CLASS |
-		USB_DIR_OUT, 0x0100, snd_usb_ctrl_intf(mixer->chip) |
+		USB_DIR_OUT, 0x0100, snd_usb_ctrl_intf(mixer->hostif) |
 		(0x29 << 8), sample_rate_buffer, 4);
 	if (err < 0)
 		return err;
diff --git a/sound/usb/power.c b/sound/usb/power.c
index 606a2cb23eab..66bd4daa68fd 100644
--- a/sound/usb/power.c
+++ b/sound/usb/power.c
@@ -40,6 +40,7 @@ snd_usb_find_power_domain(struct usb_host_interface *ctrl_iface,
 					le16_to_cpu(pd_desc->waRecoveryTime1);
 				pd->pd_d2d0_rec =
 					le16_to_cpu(pd_desc->waRecoveryTime2);
+				pd->ctrl_iface = ctrl_iface;
 				return pd;
 			}
 		}
@@ -57,7 +58,7 @@ int snd_usb_power_domain_set(struct snd_usb_audio *chip,
 	unsigned char current_state;
 	int err, idx;
 
-	idx = snd_usb_ctrl_intf(chip) | (pd->pd_id << 8);
+	idx = snd_usb_ctrl_intf(pd->ctrl_iface) | (pd->pd_id << 8);
 
 	err = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
 			      UAC2_CS_CUR,
diff --git a/sound/usb/power.h b/sound/usb/power.h
index 396e3e51440a..1fa92ad0ca92 100644
--- a/sound/usb/power.h
+++ b/sound/usb/power.h
@@ -6,6 +6,7 @@ struct snd_usb_power_domain {
 	int pd_id;              /* UAC3 Power Domain ID */
 	int pd_d1d0_rec;        /* D1 to D0 recovery time */
 	int pd_d2d0_rec;        /* D2 to D0 recovery time */
+	struct usb_host_interface *ctrl_iface; /* Control interface */
 };
 
 enum {
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index e14c725acebf..d70c140813d6 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -713,10 +713,13 @@ snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
 	struct usb_device *dev = chip->dev;
 	struct uac_format_type_i_continuous_descriptor *fmt;
 	unsigned int num_channels = 0, chconfig = 0;
+	struct usb_host_interface *ctrl_intf;
 	struct audioformat *fp;
 	int clock = 0;
 	u64 format;
 
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, iface_no);
+
 	/* get audio formats */
 	if (protocol == UAC_VERSION_1) {
 		struct uac1_as_header_descriptor *as =
@@ -740,7 +743,7 @@ snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
 
 		format = le16_to_cpu(as->wFormatTag); /* remember the format value */
 
-		iterm = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+		iterm = snd_usb_find_input_terminal_descriptor(ctrl_intf,
 							       as->bTerminalLink,
 							       protocol);
 		if (iterm) {
@@ -776,7 +779,7 @@ snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
 		 * lookup the terminal associated to this interface
 		 * to extract the clock
 		 */
-		input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+		input_term = snd_usb_find_input_terminal_descriptor(ctrl_intf,
 								    as->bTerminalLink,
 								    protocol);
 		if (input_term) {
@@ -786,7 +789,7 @@ snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
 			goto found_clock;
 		}
 
-		output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
+		output_term = snd_usb_find_output_terminal_descriptor(ctrl_intf,
 								      as->bTerminalLink,
 								      protocol);
 		if (output_term) {
@@ -870,6 +873,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	struct uac3_cluster_header_descriptor *cluster;
 	struct uac3_as_header_descriptor *as = NULL;
 	struct uac3_hc_descriptor_header hc_header;
+	struct usb_host_interface *ctrl_intf;
 	struct snd_pcm_chmap_elem *chmap;
 	struct snd_usb_power_domain *pd;
 	unsigned char badd_profile;
@@ -881,6 +885,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	int err;
 
 	badd_profile = chip->badd_profile;
+	ctrl_intf = snd_usb_find_ctrl_interface(chip, iface_no);
 
 	if (badd_profile >= UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
 		unsigned int maxpacksize =
@@ -966,7 +971,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
 			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			cluster_id,
-			snd_usb_ctrl_intf(chip),
+			snd_usb_ctrl_intf(ctrl_intf),
 			&hc_header, sizeof(hc_header));
 	if (err < 0)
 		return ERR_PTR(err);
@@ -990,7 +995,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
 			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			cluster_id,
-			snd_usb_ctrl_intf(chip),
+			snd_usb_ctrl_intf(ctrl_intf),
 			cluster, wLength);
 	if (err < 0) {
 		kfree(cluster);
@@ -1011,7 +1016,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	 * lookup the terminal associated to this interface
 	 * to extract the clock
 	 */
-	input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+	input_term = snd_usb_find_input_terminal_descriptor(ctrl_intf,
 							    as->bTerminalLink,
 							    UAC_VERSION_3);
 	if (input_term) {
@@ -1019,7 +1024,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 		goto found_clock;
 	}
 
-	output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
+	output_term = snd_usb_find_output_terminal_descriptor(ctrl_intf,
 							      as->bTerminalLink,
 							      UAC_VERSION_3);
 	if (output_term) {
@@ -1068,7 +1073,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 							       UAC_VERSION_3,
 							       iface_no);
 
-		pd = snd_usb_find_power_domain(chip->ctrl_intf,
+		pd = snd_usb_find_power_domain(ctrl_intf,
 					       as->bTerminalLink);
 
 		/* ok, let's parse further... */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 43d4029edab4..b0f042c99608 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -21,6 +21,15 @@ struct media_intf_devnode;
 
 #define MAX_CARD_INTERFACES	16
 
+/*
+ * Structure holding assosiation between Audio Control Interface
+ * and given Streaming or Midi Interface.
+ */
+struct snd_intf_to_ctrl {
+	u8 interface;
+	struct usb_host_interface *ctrl_intf;
+};
+
 struct snd_usb_audio {
 	int index;
 	struct usb_device *dev;
@@ -63,6 +72,9 @@ struct snd_usb_audio {
 	struct usb_host_interface *ctrl_intf;	/* the audio control interface */
 	struct media_device *media_dev;
 	struct media_intf_devnode *ctl_intf_media_devnode;
+
+	unsigned int num_intf_to_ctrl;
+	struct snd_intf_to_ctrl intf_to_ctrl[MAX_CARD_INTERFACES];
 };
 
 #define USB_AUDIO_IFACE_UNUSED	((void *)-1L)
-- 
2.34.1


