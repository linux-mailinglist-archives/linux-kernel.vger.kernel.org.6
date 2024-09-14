Return-Path: <linux-kernel+bounces-329239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2A978F08
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C778528504B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C84013C3C2;
	Sat, 14 Sep 2024 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WpKsOKGY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Lyrk9A+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WpKsOKGY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Lyrk9A+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA103EA64;
	Sat, 14 Sep 2024 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301719; cv=none; b=GRtKLF0MqJsecy5Y5spsuKyjndGjtLTMRx7Qpy5nM+A5jjQWIO0KDf/5F+CViUpIL6qQ3fxNlGYTSjswgPM/X7yye8bUOF4wbbsClZA3tAy1fjG7wkrk9UFr/P7l4KbfMS4vjj4lv7GSHFO3CdsAppDUw1M88Tb3SXNP/erTsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301719; c=relaxed/simple;
	bh=8KTUqAOiRbluEQFpVGirnz1V/hE3SHkgoeYcKXQjXhw=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=ESyH43mxkCxJqkApPm8E29zAVFukdJxw4OKm8G8JQrFW6gOijX3tSs3eHV4Ejuk5BNHCHSBoZ4rfXyc+w+CfwIF5LBJ24kgfQLTmmiDbHSS1wGybOwdd3IUV1VidLESrpaugsmENyDJY54o1faHkntohzQXRs0rtya+R7uqbcTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WpKsOKGY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/Lyrk9A+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WpKsOKGY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/Lyrk9A+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B8BC1F791;
	Sat, 14 Sep 2024 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726301715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=i/MtqaGwn1sEmMhgjwuXgS65qL9DVebamuXnFXhyqJA=;
	b=WpKsOKGYgoNHrSfBAagWLWJ4TMorPMdIEsva141ZMSVrs/wOD+DyltkMRExeahmqNbZlhL
	jqrEiBWYC1o+oc6gTAql2DMcGMo9q5DhCYoJnewDZ6TtTDCqqvPzzHp9vE4HfoAFlPUdIK
	GESEUeaj5wsIm8/l2zysKAZU/dZU3kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726301715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=i/MtqaGwn1sEmMhgjwuXgS65qL9DVebamuXnFXhyqJA=;
	b=/Lyrk9A+9FXDd+OPsvUNKklk7nt26WEA1bk1URjK1ILk1TJL70p36TYNYsqg/96SNG0mWD
	hlEMwkwBT5I65tDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WpKsOKGY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/Lyrk9A+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726301715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=i/MtqaGwn1sEmMhgjwuXgS65qL9DVebamuXnFXhyqJA=;
	b=WpKsOKGYgoNHrSfBAagWLWJ4TMorPMdIEsva141ZMSVrs/wOD+DyltkMRExeahmqNbZlhL
	jqrEiBWYC1o+oc6gTAql2DMcGMo9q5DhCYoJnewDZ6TtTDCqqvPzzHp9vE4HfoAFlPUdIK
	GESEUeaj5wsIm8/l2zysKAZU/dZU3kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726301715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=i/MtqaGwn1sEmMhgjwuXgS65qL9DVebamuXnFXhyqJA=;
	b=/Lyrk9A+9FXDd+OPsvUNKklk7nt26WEA1bk1URjK1ILk1TJL70p36TYNYsqg/96SNG0mWD
	hlEMwkwBT5I65tDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C1371386E;
	Sat, 14 Sep 2024 08:15:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 76eqCBNG5WZBYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 14 Sep 2024 08:15:15 +0000
Date: Sat, 14 Sep 2024 10:16:04 +0200
Message-ID: <87ldzubqgr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.11-rc7
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 5B8BC1F791
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nxp.com:email,amd.com:email,codeaurora.org:email,quicinc.com:email,ltu.se:email,alsa-project.org:email,linux.dev:email];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

please pull sound fixes for v6.11 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11

The topmost commit is 134536c21275bb3410cd1f10c5e369d30702741d

----------------------------------------------------------------

sound fixes for 6.11

A few last-minute ASoC fixes and MAINTAINERS update.
All look small, obvious and nice-to-have fixes for 6.11-final.

----------------------------------------------------------------

Arseniy Krasnov (1):
      ASoC: meson: axg-card: fix 'use-after-free'

Bard Liao (2):
      ASoC: Intel: soc-acpi-intel-lnl-match: add missing empty item
      ASoC: Intel: soc-acpi-intel-mtl-match: add missing empty item

Pierre-Louis Bossart (1):
      MAINTAINERS: update Pierre Bossart's email and role

Shenghao Ding (1):
      ASoC: tas2781: fix to save the dsp bin file name into the correct array in case name_prefix is not NULL

Su Hui (1):
      ASoC: codecs: avoid possible garbage value in peb2466_reg_read()

---
 .mailmap                                          | 1 +
 MAINTAINERS                                       | 6 +++---
 sound/soc/codecs/peb2466.c                        | 3 ++-
 sound/soc/codecs/tas2781-i2c.c                    | 2 +-
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c | 1 +
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c | 1 +
 sound/soc/meson/axg-card.c                        | 3 ++-
 7 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index f01d7bfca2a0..7c7f171d0e55 100644
--- a/.mailmap
+++ b/.mailmap
@@ -529,6 +529,7 @@ Pavankumar Kondeti <quic_pkondeti@quicinc.com> <pkondeti@codeaurora.org>
 Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter.oruba@amd.com>
 Peter Oruba <peter@oruba.de>
+Pierre-Louis Bossart <pierre-louis.bossart@linux.dev> <pierre-louis.bossart@linux.intel.com>
 Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
 Praveen BP <praveenbp@ti.com>
 Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> <pradeepc@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index f70987f7e462..cc40a9d9b8cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11156,12 +11156,12 @@ F:	drivers/gpio/gpio-i8255.h
 
 INTEL ASoC DRIVERS
 M:	Cezary Rojewski <cezary.rojewski@intel.com>
-M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
 M:	Liam Girdwood <liam.r.girdwood@linux.intel.com>
 M:	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
 M:	Bard Liao <yung-chuan.liao@linux.intel.com>
 M:	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
 M:	Kai Vehmanen <kai.vehmanen@linux.intel.com>
+R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/intel/
@@ -21391,13 +21391,13 @@ S:	Maintained
 F:	tools/sound/dapm-graph
 
 SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS
-M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
 M:	Liam Girdwood <lgirdwood@gmail.com>
 M:	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
 M:	Bard Liao <yung-chuan.liao@linux.intel.com>
 M:	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
 M:	Daniel Baluta <daniel.baluta@nxp.com>
 R:	Kai Vehmanen <kai.vehmanen@linux.intel.com>
+R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
 L:	sound-open-firmware@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 W:	https://github.com/thesofproject/linux/
@@ -21406,7 +21406,7 @@ F:	sound/soc/sof/
 SOUNDWIRE SUBSYSTEM
 M:	Vinod Koul <vkoul@kernel.org>
 M:	Bard Liao <yung-chuan.liao@linux.intel.com>
-R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
 R:	Sanyog Kale <sanyog.r.kale@intel.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
diff --git a/sound/soc/codecs/peb2466.c b/sound/soc/codecs/peb2466.c
index 76ee7e3f4d9b..67ea70cef0c7 100644
--- a/sound/soc/codecs/peb2466.c
+++ b/sound/soc/codecs/peb2466.c
@@ -229,7 +229,8 @@ static int peb2466_reg_read(void *context, unsigned int reg, unsigned int *val)
 	case PEB2466_CMD_XOP:
 	case PEB2466_CMD_SOP:
 		ret = peb2466_read_byte(peb2466, reg, &tmp);
-		*val = tmp;
+		if (!ret)
+			*val = tmp;
 		break;
 	default:
 		dev_err(&peb2466->spi->dev, "Not a XOP or SOP command\n");
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index e79d613745b4..cf8bc7ede6c7 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -502,7 +502,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	 */
 	tas_priv->fw_state = TASDEVICE_RCA_FW_OK;
 	if (tas_priv->name_prefix)
-		scnprintf(tas_priv->rca_binaryname, 64, "%s-%s_coef.bin",
+		scnprintf(tas_priv->coef_binaryname, 64, "%s-%s_coef.bin",
 			tas_priv->name_prefix, tas_priv->dev_name);
 	else
 		scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
diff --git a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
index e6ffcd5be6c5..edfb668d0580 100644
--- a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
@@ -208,6 +208,7 @@ static const struct snd_soc_acpi_link_adr lnl_cs42l43_l0[] = {
 		.num_adr = ARRAY_SIZE(cs42l43_0_adr),
 		.adr_d = cs42l43_0_adr,
 	},
+	{}
 };
 
 static const struct snd_soc_acpi_link_adr lnl_rvp[] = {
diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index 8e0ae3635a35..d4435a34a3a3 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -674,6 +674,7 @@ static const struct snd_soc_acpi_link_adr mtl_cs42l43_l0[] = {
 		.num_adr = ARRAY_SIZE(cs42l43_0_adr),
 		.adr_d = cs42l43_0_adr,
 	},
+	{}
 };
 
 static const struct snd_soc_acpi_link_adr mtl_cs42l43_cs35l56[] = {
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 8c5605c1e34e..eb0302f20740 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -104,7 +104,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 				     int *index)
 {
 	struct meson_card *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_dai_link *pad = &card->dai_link[*index];
+	struct snd_soc_dai_link *pad;
 	struct snd_soc_dai_link *lb;
 	struct snd_soc_dai_link_component *dlc;
 	int ret;
@@ -114,6 +114,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 	if (ret)
 		return ret;
 
+	pad = &card->dai_link[*index];
 	lb = &card->dai_link[*index + 1];
 
 	lb->name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-lb", pad->name);

