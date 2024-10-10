Return-Path: <linux-kernel+bounces-360151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED3C99952C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BFF286DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FBA1E7C02;
	Thu, 10 Oct 2024 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="oK9dhEkg"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EA1E4928;
	Thu, 10 Oct 2024 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599084; cv=none; b=SaApH7YnmBw9fZM5sworY/vzBuXTigzq0CsQERlQ66xDVPnI2qQJ+MTmAh7Cb+ndUVqbQdMh3JcQKBrSw0ioRvXz1uT2OIPJ7eNi2Fnj7/hTlwumN5RiQeZSOpMgTfC8z7/gT/n1DJ86eb8PQWtoEe6tzRa02IPqz0jiFSVPE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599084; c=relaxed/simple;
	bh=nnppAyg0uu9DQyucYYwiM38Kjn9/msZ/fi8oUktdXJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FViIb1gsImIdwCxj8HngEeW7Znumf+VeK7CERB8jnASa1j59y/RcZJJ68TNsy4cSm1YfpUvZqu0H3iwcKO8tn8JBHLweAfVbTQ+NET5JzvnNwbFQxntWVXH0vqb6ARK+sqBiUWuG//eiltdu3w2Ie782PqthRAMNopJkPblX60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=oK9dhEkg; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id A57491E000E;
	Fri, 11 Oct 2024 01:18:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru A57491E000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1728598683; bh=oTVEzPYQGmSNBS05cQ2KHdUTxfJGHwOb/ByzaCoMz4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=oK9dhEkg9c5s6EedS0v9cJGieopFVFcwlN3VrsLsKVv5jzrpbKtKDB9GhB2C3yqbI
	 2w+we9qyW29gHehD7ZRnXsYNgxFdVfwuKqHYxpIjNnQTW5mjvP3N/xtlMaJH/JBxER
	 peCCIwl2G96GlJDgHc07wZxVyvs4dsjVAHxwcP7WPO5oACuEwFhYxhlfaVukw2lupY
	 PjBt5o1gWVwdmZy3TekerGK2xGjR+TVOSx1fo0zQvFSRDbOPZhFiUjrx/qOEnSyyJp
	 WhABS1oA1yXHSktgsyQqvQL4/HQH8mqSctXcoX8IL/sogkDb4lE0jL9CArQ8gmMTgv
	 up0j66hoaaXPA==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Fri, 11 Oct 2024 01:18:03 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.244) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Fri, 11 Oct
 2024 01:18:01 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Jaroslav Kysela <perex@perex.cz>
CC: Murad Masimov <m.masimov@maxima.ru>, Takashi Iwai <tiwai@suse.com>, Vitaly
 Rodionov <vitalyr@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] ALSA: hda/cs8409: Fix possible NULL dereference
Date: Fri, 11 Oct 2024 01:16:45 +0300
Message-ID: <20241010221649.1305-1-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188364 [Oct 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;81.200.124.62:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;maxima.ru:7.1.1;ksmg02.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/10 20:32:00 #26733528
X-KSMG-AntiVirus-Status: Clean, skipped

If snd_hda_gen_add_kctl fails to allocate memory and returns NULL, then
NULL pointer dereference will occur in the next line.

Since dolphin_fixups function is a hda_fixup function which is not supposed
to return any errors, add simple check before dereference, ignore the fail.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 20e507724113 ("ALSA: hda/cs8409: Add support for dolphin")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 sound/pci/hda/patch_cs8409.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 26f3c31600d7..614327218634 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -1403,8 +1403,9 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		kctrl = snd_hda_gen_add_kctl(&spec->gen, "Line Out Playback Volume",
 					     &cs42l42_dac_volume_mixer);
 		/* Update Line Out kcontrol template */
-		kctrl->private_value = HDA_COMPOSE_AMP_VAL_OFS(DOLPHIN_HP_PIN_NID, 3, CS8409_CODEC1,
-				       HDA_OUTPUT, CS42L42_VOL_DAC) | HDA_AMP_VAL_MIN_MUTE;
+		if (kctrl)
+			kctrl->private_value = HDA_COMPOSE_AMP_VAL_OFS(DOLPHIN_HP_PIN_NID, 3, CS8409_CODEC1,
+					       HDA_OUTPUT, CS42L42_VOL_DAC) | HDA_AMP_VAL_MIN_MUTE;
 		cs8409_enable_ur(codec, 0);
 		snd_hda_codec_set_name(codec, "CS8409/CS42L42");
 		break;
--
2.39.2


