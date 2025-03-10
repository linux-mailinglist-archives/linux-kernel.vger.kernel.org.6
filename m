Return-Path: <linux-kernel+bounces-553512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC71A58AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 04:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F283AC720
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6989C1ADFFE;
	Mon, 10 Mar 2025 03:04:52 +0000 (UTC)
Received: from mail78-60.sinamail.sina.com.cn (mail78-60.sinamail.sina.com.cn [219.142.78.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002A136349
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741575892; cv=none; b=j0OJekns/cS+kQJz1g55Z8rJEEraLzaIcVwYBDYswp3A50Slw392ykTWWOD7G4pgauokHPu+ejprWIanf1yDQS7rJgaW8xCIJeHU0TBeLTEP/PdIAekDar62M28BgIHSx5h/T5oVbnRYzMNwNabfmgtMw90jAs2L63VUhDDjQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741575892; c=relaxed/simple;
	bh=26cx/vvyLmyfjqV5b45btoxXJllLg5LCM9Zt3cXbU8Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=G286qHkDN3xbyOhXej68qoVa4pj4q0cROB2mBxjLetsMoBaZzjW4G3U2C0nVim96IJXyTX14Z0qBD2gpDlKm+aCgG/4Hi2t1BhYxUvlAeWKuRWFg9EIqfDTrPgxD4qDFBgOtMlE61yHPjKA2LqxP8kzMfwdAGvlUJnpWOIZe9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com; spf=pass smtp.mailfrom=everest-semi.com; arc=none smtp.client-ip=219.142.78.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everest-semi.com
Received: from unknown (HELO zy-virtual-machine.localdomain)([180.159.108.137])
	by sina.net (10.185.250.30) with ESMTP
	id 67CE569D000009D8; Mon, 10 Mar 2025 11:03:58 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: B3C55CFE67994179ABD0A7C2F67E6B58
X-SMAIL-UIID: B3C55CFE67994179ABD0A7C2F67E6B58-20250310-110358
From: Zhang Yi <zhangyi@everest-semi.com>
To: krzk@kernel.org
Cc: tiwai@suse.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz
Subject: RE: [PATCH v4 1/2] ASoC: codecs: add support for ES8389
Date: Mon, 10 Mar 2025 11:03:57 +0800
Message-Id: <20250310030357.120390-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I apologize for not responding to this review comment.
But I did view these review comments and fixed the error.
In the meantime I will modify my cc list, do I need to resend a new version
of the patch to correct my error in my cc list?

> > +static int es8389_probe(struct snd_soc_component *codec)
> > +{
> > +	int ret = 0;
> > +	struct es8389_private *es8389 = snd_soc_component_get_drvdata(codec);
> > +
> > +	ret = device_property_read_u8(codec->dev, "everest,mclk-src", &es8389->mclk_src);
> > +	if (ret != 0) {
> > +		dev_dbg(codec->dev, "mclk-src return %d", ret);
> > +		es8389->mclk_src = ES8389_MCLK_SOURCE;
> > +	}
> > +
> > +	ret = device_property_read_u8(codec->dev, "everest,adc-slot", &es8389->adc_slot);
> > +	if (ret != 0) {
> > +		dev_dbg(codec->dev, "adc-slot return %d", ret);
> > +		es8389->adc_slot = 0x00;
> > +	}
> > +
> > +	ret = device_property_read_u8(codec->dev, "everest,dac-slot", &es8389->dac_slot);
> > +	if (ret != 0) {
> > +		dev_dbg(codec->dev, "dac-slot return %d", ret);
> > +		es8389->dac_slot = 0x00;
> > +	}
> > +
> > +	es8389->dmic = device_property_read_bool(codec->dev,
> > +			"everest,dmic-enabled");
> > +	dev_dbg(codec->dev, "dmic-enabled %x", es8389->dmic);
> > +
> > +	if (!es8389->adc_slot) {
> > +		es8389->mclk = devm_clk_get(codec->dev, "mclk");
> > +		if (IS_ERR(es8389->mclk)) {
> > +			dev_err(codec->dev, "%s,unable to get mclk\n", __func__);
> 
> Syntax is return dev_err_probe. Also, drop __func__.

Ok,I'll fix it

> > +static struct snd_soc_component_driver soc_codec_dev_es8389 = {
> > +	.probe = es8389_probe,
> > +	.remove = es8389_remove,
> > +	.suspend = es8389_suspend,
> > +	.resume = es8389_resume,
> > +	.set_bias_level = es8389_set_bias_level,
> > +
> > +	.controls = es8389_snd_controls,
> > +	.num_controls = ARRAY_SIZE(es8389_snd_controls),
> > +	.dapm_widgets = es8389_dapm_widgets,
> > +	.num_dapm_widgets = ARRAY_SIZE(es8389_dapm_widgets),
> > +	.dapm_routes = es8389_dapm_routes,
> > +	.num_dapm_routes = ARRAY_SIZE(es8389_dapm_routes),
> > +	.idle_bias_on = 1,
> > +	.use_pmdown_time = 1,
> > +};
> > +
> > +static struct regmap_config es8389_regmap = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +
> > +	.max_register = ES8389_MAX_REGISTER,
> > +
> > +	.volatile_reg = es8389_volatile_register,
> > +	.cache_type = REGCACHE_MAPLE,
> > +};
> > +
> > +#ifdef CONFIG_OF
> > +static struct of_device_id es8389_if_dt_ids[] = {
> > +	{ .compatible = "everest,es8389", },
> 
> Bindings are before the user (see DT submitting patches).

Ok,I'll fix it

> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, es8389_if_dt_ids);
> > +#endif
> > +
> > +static void es8389_i2c_shutdown(struct i2c_client *i2c)
> > +{
> > +	struct snd_soc_component *component;
> > +	struct es8389_private *es8389;
> > +
> > +	es8389 = i2c_get_clientdata(i2c);
> > +	component = es8389->component;
> > +	dev_dbg(component->dev, "Enter into %s\n", __func__);
> 
> Please drop simple probe enter/exit debugs. Tracing is for that in
> general.

I'll drop these.

> > +
> > +	regmap_write(es8389->regmap, ES8389_MASTER_MODE, 0x28);
> > +	regmap_write(es8389->regmap, ES8389_HPSW, 0x00);
> > +	regmap_write(es8389->regmap, ES8389_VMID, 0x00);
> > +	regmap_write(es8389->regmap, ES8389_RESET, 0x00);
> > +	regmap_write(es8389->regmap, ES8389_CSM_JUMP, 0xCC);
> > +	usleep_range(500000, 550000);//500MS
> > +	regmap_write(es8389->regmap, ES8389_CSM_JUMP, 0x00);
> > +	regmap_write(es8389->regmap, ES8389_ANA_CTL1, 0x08);
> > +	regmap_write(es8389->regmap, ES8389_ISO_CTL, 0xC1);
> > +	regmap_write(es8389->regmap, ES8389_PULL_DOWN, 0x00);
> > +}
> > +
> > +static int es8389_i2c_probe(struct i2c_client *i2c_client)
> > +{
> > +	struct es8389_private *es8389;
> > +	int ret = -1;
> > +
> > +	es8389 = devm_kzalloc(&i2c_client->dev,
> > +			sizeof(*es8389), GFP_KERNEL);
> 
> You wrapping is odd: unnecessary and not matching coding style.

Ok,I'll fix it

>> +	if (es8389 == NULL)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(i2c_client, es8389);
>> +	es8389->regmap = devm_regmap_init_i2c(i2c_client, &es8389_regmap);
>> +	if (IS_ERR(es8389->regmap))
>> +		return dev_err_probe(&i2c_client->dev, PTR_ERR(es8389->regmap),
>> +			"regmap_init() failed\n");
>> +
>> +	ret =  devm_snd_soc_register_component(&i2c_client->dev,
>> +			&soc_codec_dev_es8389,
>> +			&es8389_dai,
>> +			1);
>> +	if (ret < 0) {
>> +		kfree(es8389);
>
>You have a bug here - double free. You can easily trigger this and see
>the result with KASAN.

Ok,I'll fix it

> > +		return ret;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct i2c_device_id es8389_i2c_id[] = {
> > +	{"es8389"},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, es8389_i2c_id);
> > +
> > +static struct i2c_driver es8389_i2c_driver = {
> > +	.driver = {
> > +		.name	= "es8389",
> > +		.owner	= THIS_MODULE,
> 
> So you sent us an old code, probably based on downstream, duplicating
> issues we already fixed in upstream.
> 
> That's really suboptimal choice.
> 
> First, you have the issues here which we already fixed. Second, you ask
> us to review and find the same problems we already pointed out and
> fixed.
> 
> Instead, please take the newest reviewed driver and use it as base.

Ok,I'll fix it

> > +		.of_match_table = of_match_ptr(es8389_if_dt_ids),
> > +	},
> > +	.shutdown = es8389_i2c_shutdown,
> > +	.probe = es8389_i2c_probe,
> > +	.id_table = es8389_i2c_id,
> > +};
> > +module_i2c_driver(es8389_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("ASoC es8389 driver");
> > +MODULE_AUTHOR("Michael Zhang <zhangyi@everest-semi.com>");
> > +MODULE_LICENSE("GPL");
> > +
> > +
> 
> No need for blank lines at the end.

Ok,I'll fix it

