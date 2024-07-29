Return-Path: <linux-kernel+bounces-266210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9D93FC81
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899D0B214F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A2416D4C3;
	Mon, 29 Jul 2024 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jtg+bA2v"
Received: from msa.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC71474CE;
	Mon, 29 Jul 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274585; cv=none; b=P56zqH5DFBirCQ/Va+zes40QoAtNGfdXufXp1fxiIqVg+NSI8GILgcCb9/esoUK1ihbOt73wHBZ/v5c3oqPs9CGS1tEymI3Pa7R4Yw+uz2Y9wB3N9N2Q+c5rMjAt61isckwiuMKD9zNOyi401ZE9OgwRtyzjPBu2J7bhdXKJdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274585; c=relaxed/simple;
	bh=8qXgcTEK1sB9juukqwPldLWJ+ngenIcIAxtBMYrrYQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGGjZ+RjJNFQ+wB38dLo+0fQleoucFhi2Jcdgg4mBgnkpxP0MX7Rz0jIRBbA8xSuJa28VBzsTPIh1lSuPiQC5U94cFllfiVFYlNgzgxZm+Wdn14RzD7GZUm6jEM4ciqyIrW4vVdzy3vZIoT+VWiKNdFhvLlyfkrOVg106WlieEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jtg+bA2v; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id YUI7soyZFhajuYUI8sQhbA; Mon, 29 Jul 2024 19:36:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722274573;
	bh=OMMMxQpsZCVMR8l67H2YGQ2dCZFaG5DSz7db9edlKWs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jtg+bA2vAlqfi+cTiS2Gf1imYLuSNwgshlLsieACR9yNef8s5TO5dFfcpBYV3EWd2
	 eXWKd19sIWEbUTZFk/gueaYcPAV1FnnQ94kEU4RlOuML3YLh+cmQDuhjB9eYgNQkQL
	 S5gKp8Ehpv5ptcdiO849BuW42lximhOiHb5rKYxZaQf9yOZA2fg0yB/2DrZvp2xQWQ
	 11VORJBZMItKMepoAhxvMETKxQIY7esmqgS8CI9QJUDWfoLKUe9JlwE/iHsTcUQMyG
	 LxUAtHDlaxiahSCm8ucJVOIEhEkVUIXe1L32c3ex0eFLirLchPk4qACcsd88/oasFk
	 GyWD2O9b238dA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Jul 2024 19:36:13 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: ckeepax@opensource.cirrus.com,
	javier.carrasco.cruz@gmail.com,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: cs43130: Constify snd_soc_component_driver struct
Date: Mon, 29 Jul 2024 19:36:05 +0200
Message-ID: <1f04bb0366d9640d7ee361dae114ff79e4b381c1.1722274212.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to constify `snd_soc_component_driver` struct, duplicate
`soc_component_dev_cs43130` into a `soc_component_dev_cs43130_digital` and
`soc_component_dev_cs43130_analog`.

These 2 new structures share the same .dapm_widgets and .dapm_routes
arrays but differ for .num_dapm_widgets and .num_dapm_routes.

In the digital case, the last entries are not taken into account.

Doing so has several advantages:
  - `snd_soc_component_driver` can be declared as const to move their
    declarations to read-only sections.
  - code in the probe is simpler. There is no need to concatenate some
    arrays to handle the "analog" case
  - this saves some memory because all_hp_widgets and analog_hp_routes can
    be removed.

Before :
======
   text	   data	    bss	    dec	    hex	filename
  53965	   8265	   4512	  66742	  104b6	sound/soc/codecs/cs43130.o

After :
=====
   text	   data	    bss	    dec	    hex	filename
  54409	   7881	     64	  62354	   f392	sound/soc/codecs/cs43130.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.

See discussion at [1].

[1]: https://lore.kernel.org/all/ZqNawRmAqBRLIoQq@opensource.cirrus.com/
---
 sound/soc/codecs/cs43130.c | 73 +++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index be4037890fdb..cb4ca80f36d2 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1415,7 +1415,7 @@ static const char * const bypass_mux_text[] = {
 static SOC_ENUM_SINGLE_DECL(bypass_enum, SND_SOC_NOPM, 0, bypass_mux_text);
 static const struct snd_kcontrol_new bypass_ctrl = SOC_DAPM_ENUM("Switch", bypass_enum);
 
-static const struct snd_soc_dapm_widget digital_hp_widgets[] = {
+static const struct snd_soc_dapm_widget hp_widgets[] = {
 	SND_SOC_DAPM_MUX("Bypass Switch", SND_SOC_NOPM, 0, 0, &bypass_ctrl),
 	SND_SOC_DAPM_OUTPUT("HPOUTA"),
 	SND_SOC_DAPM_OUTPUT("HPOUTB"),
@@ -1447,19 +1447,16 @@ static const struct snd_soc_dapm_widget digital_hp_widgets[] = {
 			   CS43130_PDN_HP_SHIFT, 1, cs43130_dac_event,
 			   (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD)),
-};
 
-static const struct snd_soc_dapm_widget analog_hp_widgets[] = {
+/* Some devices have some extra analog widgets */
+#define NUM_ANALOG_WIDGETS	1
+
 	SND_SOC_DAPM_DAC_E("Analog Playback", NULL, CS43130_HP_OUT_CTL_1,
 			   CS43130_HP_IN_EN_SHIFT, 0, cs43130_hpin_event,
 			   (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD)),
 };
 
-static struct snd_soc_dapm_widget all_hp_widgets[
-			ARRAY_SIZE(digital_hp_widgets) +
-			ARRAY_SIZE(analog_hp_widgets)];
-
-static const struct snd_soc_dapm_route digital_hp_routes[] = {
+static const struct snd_soc_dapm_route hp_routes[] = {
 	{"ASPIN PCM", NULL, "ASP PCM Playback"},
 	{"ASPIN DoP", NULL, "ASP DoP Playback"},
 	{"XSPIN DoP", NULL, "XSP DoP Playback"},
@@ -1472,15 +1469,12 @@ static const struct snd_soc_dapm_route digital_hp_routes[] = {
 	{"Bypass Switch", "Internal", "HiFi DAC"},
 	{"HPOUTA", NULL, "Bypass Switch"},
 	{"HPOUTB", NULL, "Bypass Switch"},
-};
 
-static const struct snd_soc_dapm_route analog_hp_routes[] = {
+/* Some devices have some extra analog routes */
+#define NUM_ANALOG_ROUTES	1
 	{"Bypass Switch", "Alternative", "Analog Playback"},
 };
 
-static struct snd_soc_dapm_route all_hp_routes[
-			ARRAY_SIZE(digital_hp_routes) +
-			ARRAY_SIZE(analog_hp_routes)];
 
 static const unsigned int cs43130_asp_src_rates[] = {
 	32000, 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000
@@ -2398,7 +2392,23 @@ static int cs43130_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-static struct snd_soc_component_driver soc_component_dev_cs43130 = {
+static const struct snd_soc_component_driver soc_component_dev_cs43130_digital = {
+	.probe			= cs43130_probe,
+	.controls		= cs43130_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs43130_snd_controls),
+	.set_sysclk		= cs43130_component_set_sysclk,
+	.set_pll		= cs43130_set_pll,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	/* Don't take into account the ending analog widgets and routes */
+	.dapm_widgets		= hp_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(hp_widgets) - NUM_ANALOG_WIDGETS,
+	.dapm_routes		= hp_routes,
+	.num_dapm_routes	= ARRAY_SIZE(hp_routes) - NUM_ANALOG_ROUTES,
+};
+
+static const struct snd_soc_component_driver soc_component_dev_cs43130_analog = {
 	.probe			= cs43130_probe,
 	.controls		= cs43130_snd_controls,
 	.num_controls		= ARRAY_SIZE(cs43130_snd_controls),
@@ -2407,6 +2417,10 @@ static struct snd_soc_component_driver soc_component_dev_cs43130 = {
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
+	.dapm_widgets		= hp_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(hp_widgets),
+	.dapm_routes		= hp_routes,
+	.num_dapm_routes	= ARRAY_SIZE(hp_routes),
 };
 
 static const struct regmap_config cs43130_regmap = {
@@ -2479,6 +2493,7 @@ static int cs43130_handle_device_data(struct cs43130_private *cs43130)
 
 static int cs43130_i2c_probe(struct i2c_client *client)
 {
+	const struct snd_soc_component_driver *component_driver;
 	struct cs43130_private *cs43130;
 	int ret;
 	unsigned int reg;
@@ -2596,39 +2611,15 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 	switch (cs43130->dev_id) {
 	case CS43130_CHIP_ID:
 	case CS43131_CHIP_ID:
-		memcpy(all_hp_widgets, digital_hp_widgets,
-		       sizeof(digital_hp_widgets));
-		memcpy(all_hp_widgets + ARRAY_SIZE(digital_hp_widgets),
-		       analog_hp_widgets, sizeof(analog_hp_widgets));
-		memcpy(all_hp_routes, digital_hp_routes,
-		       sizeof(digital_hp_routes));
-		memcpy(all_hp_routes + ARRAY_SIZE(digital_hp_routes),
-		       analog_hp_routes, sizeof(analog_hp_routes));
-
-		soc_component_dev_cs43130.dapm_widgets =
-			all_hp_widgets;
-		soc_component_dev_cs43130.num_dapm_widgets =
-			ARRAY_SIZE(all_hp_widgets);
-		soc_component_dev_cs43130.dapm_routes =
-			all_hp_routes;
-		soc_component_dev_cs43130.num_dapm_routes =
-			ARRAY_SIZE(all_hp_routes);
+		component_driver = &soc_component_dev_cs43130_analog;
 		break;
 	case CS43198_CHIP_ID:
 	case CS4399_CHIP_ID:
-		soc_component_dev_cs43130.dapm_widgets =
-			digital_hp_widgets;
-		soc_component_dev_cs43130.num_dapm_widgets =
-			ARRAY_SIZE(digital_hp_widgets);
-		soc_component_dev_cs43130.dapm_routes =
-			digital_hp_routes;
-		soc_component_dev_cs43130.num_dapm_routes =
-			ARRAY_SIZE(digital_hp_routes);
+		component_driver = &soc_component_dev_cs43130_digital;
 		break;
 	}
 
-	ret = devm_snd_soc_register_component(cs43130->dev,
-				     &soc_component_dev_cs43130,
+	ret = devm_snd_soc_register_component(cs43130->dev, component_driver,
 				     cs43130_dai, ARRAY_SIZE(cs43130_dai));
 	if (ret < 0) {
 		dev_err(cs43130->dev,
-- 
2.45.2


