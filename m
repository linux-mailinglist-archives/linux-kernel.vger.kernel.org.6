Return-Path: <linux-kernel+bounces-530756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A1BA437E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E433B10BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A5E260A59;
	Tue, 25 Feb 2025 08:43:55 +0000 (UTC)
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3A25A326;
	Tue, 25 Feb 2025 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473034; cv=none; b=Es23f16/ZZkszP0qqpteGjsiiIqFZSRfnIkM5zGrlRSfdXnT8gTd8qYhKhlDtYII0FhLhbXpN8ND+0sEytr0IdMJVRHjbC4nrQcLGcA7BHKtQK8szIK+TWr5pLbygVkTjIHzYMqJgZwMxVIhF7BdxjmwKJJIwKvRJFbSQVskeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473034; c=relaxed/simple;
	bh=8yUlIoEzbCjT7IopLPQVynw1cUw5sKDknmbbjhGd4PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klTqIm+xJNFzAI0Ty2fhNpVU/3hG0wwMPUzktmmhKiBStTz9/8Nve/ewBkfLw7DYCjQD/h3i1xbQGuFxWNOrw5HxTR1DfSN+CO6xDUuPC92HeV68d4iPYdHRTQEU8apvqhWeg5etKvHpi+PrVavi4LVLWD6J2c9T6bGy4a/X53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.bcH-6Kr_1740469334 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 15:42:20 +0800
From: wangweidong.a@awinic.com
To: krzk@kernel.org
Cc: broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ivprusov@salutedevices.com,
	jack.yu@realtek.com,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	nuno.sa@analog.com,
	paulha@opensource.cirrus.com,
	perex@perex.cz,
	quic_pkumpatl@quicinc.com,
	rf@opensource.cirrus.com,
	robh@kernel.org,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	yijiangtao@awinic.com,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH V1 2/2] ASoC: codecs: Add aw88166 amplifier driver
Date: Tue, 25 Feb 2025 15:42:14 +0800
Message-ID: <20250225074214.29902-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250223-vigilant-cooperative-snake-2d810b@krzk-bin>
References: <20250223-vigilant-cooperative-snake-2d810b@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you very much for your review

On Fri, Feb 23, 2025 at 12:46:14 +0100, krzk@kernel.org wrote:
> On Fri, Feb 21, 2025 at 06:26:23PM +0800, wangweidong.a@awinic.com wrote:
>> +
>> +static void aw88166_hw_reset(struct aw88166 *aw88166)
>> +{
>> +	if (aw88166->reset_gpio) {
>> +		gpiod_set_value_cansleep(aw88166->reset_gpio, 1);
>> +		usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
>> +		gpiod_set_value_cansleep(aw88166->reset_gpio, 0);
>> +		usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
>> +		gpiod_set_value_cansleep(aw88166->reset_gpio, 1);

> Why do you keep reset as active after reset? How is it suppose to work?

The gpio port of the AW88166 is reset when it is low.
So it's working now, I will modify it as follows:
if (aw88166->reset_gpio) {
	gpiod_set_value_cansleep(aw88166->reset_gpio, 0);
	usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
	gpiod_set_value_cansleep(aw88166->reset_gpio, 1);
	usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
}

>> +static int aw88166_i2c_probe(struct i2c_client *i2c)
>> +{
>> +	struct aw88166 *aw88166;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
>> +		return dev_err_probe(&i2c->dev, -ENXIO, "check_functionality failed\n");
>> +
>> +	aw88166 = devm_kzalloc(&i2c->dev, sizeof(*aw88166), GFP_KERNEL);
>> +	if (!aw88166)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&aw88166->lock);
>> +
>> +	i2c_set_clientdata(i2c, aw88166);
>> +
>> +	aw88166->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);


> So here reset is low...


>> +	if (IS_ERR(aw88166->reset_gpio))
>> +		return dev_err_probe(&i2c->dev, PTR_ERR(aw88166->reset_gpio),
>> +							"reset gpio not defined\n");
>> +	aw88166_hw_reset(aw88166);

> and here is high afterwards?

Yes, low indicates reset state, high indicates working state

Best regards,
Weidong Wang

