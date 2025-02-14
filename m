Return-Path: <linux-kernel+bounces-515500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4A1A365A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016A53A613A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE41269804;
	Fri, 14 Feb 2025 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bsu41QDY"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932C2686B3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557248; cv=none; b=ddZ9SibAd31D8Ns7lDEHPilxLpuxTvXYmowepAlv/oVJxSvHAopHPJfS0u2zW83xu3NOAQHNyolV3gFkKjfjZeEIGaKZD0AcXoUh+kHh8RkCflGS4ic5QRsEIU+TcDV9ru9p4VN+HotFwxNA8ULECKQps9KE7od9XwPAyCf28oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557248; c=relaxed/simple;
	bh=hGm6bdP44W45VjFKx4g3WtxK7XzlXxi7Onetxlpq+ME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHfikz4QpUDOfVTT7cZ2pm0RJPqxeBQPukUaee7ROa7YlyafeNw2cTj7ETd5DCXnrqLL0enVd1vuwIpGXFF59GC3Fdz+t5GsrwzFTDHhA8rvbHkNUKUin2T39j0ITL5onhc3ZtGvtjYbEGbObXFFbvQbwQadfLifEYa4RvswXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bsu41QDY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f32c1c787so214336f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739557243; x=1740162043; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LiwQPv6ok4yIcjSGgvmUI+UqSRNOd6zqIh/ZijyeTno=;
        b=bsu41QDYFLNrNhi9hk8XS9pEFPPqCvqc0/JZ2EGSvXH51g6hslzu7hXAQwfDePAZj0
         F9gKY75BYPZIN2YYH14G+pIFae+MG+sYhs3nVYmjaw41LkVLHigAmJ57DjEG0aE0LrvN
         nMMOXTwcKBBNUx6ZjCUTWJyMW/ruEFPHqoEw1suNxeQ2+2wpPTHMAx96bRV2reyZ2lJi
         caTrTacYrbNc2Wfn5wn1xdcWmvFAPIkdx7wdRQ9qpAT0VQXFMHaVbKbYx1RvOFCNBc2d
         CcHsUFIXLIu9IFud85FIuUxfewBYWKfQJj56Gn8rKQbheYUVe00eGU3ax4ANfU84Cxzd
         qAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739557243; x=1740162043;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiwQPv6ok4yIcjSGgvmUI+UqSRNOd6zqIh/ZijyeTno=;
        b=ZA6dIyoe+Cav8jqifzm3GyOKELm8KmOi5Z/e80e+BV6nwSL35C3EqYjNati/+t5Seo
         ObyfUBB+swzLUGjvVAW1jbZF0JxbMfoO4hlnnICZHtz2rPfn5Zi8/nSLJWXQDvkn381A
         ckY38GEW878K1dsQB2NplKK4cHxbFmsNBhlTdBPcN8TuEy7KVVpJgw8JmPUw5zA0FStU
         G4cmsgd6Fn17LCX6hsXTSHKVT0deeLzUgp8gGSrcPXljG9jzFGPJTrhJW2odwfD8g3T3
         ErUdNgsi/gy/RHdLxBkbEaJ0qW7ZSLmSfij9IG1zG+A1Mo8rcg2hgMc8GrWgvtpd1vaH
         7n/w==
X-Forwarded-Encrypted: i=1; AJvYcCU8IeLjAmbl6eW/aaglE+Iql/q+zbKpyf/RyNPcUZytQRhBopUECVjqOalJNHsP2eC1uN7AkwxVNMczMk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/r8wtymF8nppmI/QxLT4KSG5SK4LtNdMbetIiTwh5Vg2VCapV
	oHcRHyyxj91OTY2f9l3ZjwjRYL1w91WtLi0kiV/WQi50FY3XUh7Prb9K7B4f5QY=
X-Gm-Gg: ASbGncsjlakntPl6HeoDpOQnKDLZ61tjjq+j+rjeiSJNBURTlPdWK+giwebjqksKUtk
	6QklipL91bWX259sE8xMvMZuzJ93VFEnmx9NKBO9GuNyhjo6cwyF/vONx7pM9Cqez9pr8PZaoIG
	nM0+USFh6JPTyvPp8+6NsYnQEnzeF0pXyT9+GG77ZY0RYbZkykZ3pRd+uAsOJa3JORWOntVTCM8
	uoWbtuBOc6xf5Ow9HOWj4/9Zeti3Yn2lvzVH5BBepe2J+LA+0QdyFKomTuB6qb6O+QygDIKbLLL
	Mn/6ngd18TMClQ==
X-Google-Smtp-Source: AGHT+IHsTHTiL3wJj3nrHf3yF9cKckC3Rmpa9H0r1If+8TaecjIo4Dqny2vOXtw6IlfG2e9gn40oVw==
X-Received: by 2002:a05:6000:1542:b0:38d:d4b5:84d5 with SMTP id ffacd0b85a97d-38f33f14a9dmr31093f8f.8.1739557243484;
        Fri, 14 Feb 2025 10:20:43 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:7018:8c7:bdd4:3436])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43961884e88sm49912865e9.26.2025.02.14.10.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 10:20:42 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Dave Ertman
 <david.m.ertman@intel.com>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  "Stephen Boyd" <sboyd@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  Danilo Krummrich <dakr@kernel.org>,  Conor Dooley
 <conor.dooley@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Philipp Zabel <p.zabel@pengutronix.de>,
  Douglas Anderson <dianders@chromium.org>,  Andrzej Hajda
 <andrzej.hajda@intel.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  "Robert Foss" <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
  "Jernej Skrabec" <jernej.skrabec@gmail.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,  Hans de Goede
 <hdegoede@redhat.com>,  Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
  Bryan O'Donoghue <bryan.odonoghue@linaro.org>,  Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>,  Gregory CLEMENT
 <gregory.clement@bootlin.com>,  =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
  Michael Turquette <mturquette@baylibre.com>,  "Abel Vesa"
 <abelvesa@kernel.org>,  Peng Fan <peng.fan@nxp.com>,  Shawn Guo
 <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  "Pengutronix Kernel Team" <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
  <linux-kernel@vger.kernel.org>,  <linux-riscv@lists.infradead.org>,
  <dri-devel@lists.freedesktop.org>,
  <platform-driver-x86@vger.kernel.org>,  <linux-mips@vger.kernel.org>,
  <linux-clk@vger.kernel.org>,  <imx@lists.linux.dev>,
  <linux-arm-kernel@lists.infradead.org>,
  <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH v3 6/7] clk: clk-imx8mp-audiomix: use the auxiliary
 device creation helper
In-Reply-To: <67af6c284c349_1614f3294dd@iweiny-mobl.notmuch> (Ira Weiny's
	message of "Fri, 14 Feb 2025 10:15:36 -0600")
References: <20250211-aux-device-create-helper-v3-0-7edb50524909@baylibre.com>
	<20250211-aux-device-create-helper-v3-6-7edb50524909@baylibre.com>
	<67af6c284c349_1614f3294dd@iweiny-mobl.notmuch>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 14 Feb 2025 19:20:40 +0100
Message-ID: <1jr040xu9z.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 14 Feb 2025 at 10:15, Ira Weiny <ira.weiny@intel.com> wrote:

> Jerome Brunet wrote:
>> The auxiliary device creation of this driver is simple enough to
>> use the available auxiliary device creation helper.
>> 
>> Use it and remove some boilerplate code.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/clk/imx/clk-imx8mp-audiomix.c | 56 ++++-------------------------------
>>  1 file changed, 6 insertions(+), 50 deletions(-)
>> 
>> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
>> index c409fc7e061869988f83c7df3ef7860500426323..988a5fffeb4e0e481ec57038d9d1f1b43432fc98 100644
>> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
>> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
>> @@ -228,64 +228,20 @@ struct clk_imx8mp_audiomix_priv {
>>  	struct clk_hw_onecell_data clk_data;
>>  };
>>  
>> -#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
>
> I see the Kconfig ...
>
>         select AUXILIARY_BUS if RESET_CONTROLLER
>
> But I don't see how this code is omitted without AUXILIARY_BUS.  Is this
> kconfig check safe to remove?

Ahhh that's what this directive was for.

I thought it was really odd to have an #if on RESET while auxialiary
device was supposed to properly decouple the clock and reset part.

To keep things as they were I'll add an #if on CONFIG_AUXILIARY_BUS I
wonder if this driver should select CONFIG_AUXILIARY_BUS instead ?

>
> Ira
>
>> -
>> -static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
>> -{
>> -	struct auxiliary_device *adev = _adev;
>> -
>> -	auxiliary_device_delete(adev);
>> -	auxiliary_device_uninit(adev);
>> -}
>> -
>> -static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
>> +static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev)
>>  {
>> -	struct auxiliary_device *adev = to_auxiliary_dev(dev);
>> -
>> -	kfree(adev);
>> -}
>> -
>> -static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
>> -							 struct clk_imx8mp_audiomix_priv *priv)
>> -{
>> -	struct auxiliary_device *adev __free(kfree) = NULL;
>> -	int ret;
>> +	struct auxiliary_device *adev;
>>  
>>  	if (!of_property_present(dev->of_node, "#reset-cells"))
>>  		return 0;
>>  
>> -	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
>> -	if (!adev)
>> -		return -ENOMEM;
>> -
>> -	adev->name = "reset";
>> -	adev->dev.parent = dev;
>> -	adev->dev.release = clk_imx8mp_audiomix_reset_adev_release;
>> -
>> -	ret = auxiliary_device_init(adev);
>> -	if (ret)
>> -		return ret;
>> -
>> -	ret = auxiliary_device_add(adev);
>> -	if (ret) {
>> -		auxiliary_device_uninit(adev);
>> -		return ret;
>> -	}
>> -
>> -	return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_unregister_adev,
>> -					no_free_ptr(adev));
>> -}
>> -
>> -#else /* !CONFIG_RESET_CONTROLLER */
>> +	adev = devm_auxiliary_device_create(dev, "reset", NULL, 0);
>> +	if (IS_ERR_OR_NULL(adev))
>> +		return PTR_ERR(adev);
>>  
>> -static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
>> -							 struct clk_imx8mp_audiomix_priv *priv)
>> -{
>>  	return 0;
>>  }
>>  
>> -#endif /* !CONFIG_RESET_CONTROLLER */
>> -
>>  static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
>>  {
>>  	struct clk_imx8mp_audiomix_priv *priv = dev_get_drvdata(dev);
>> @@ -408,7 +364,7 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto err_clk_register;
>>  
>> -	ret = clk_imx8mp_audiomix_reset_controller_register(dev, priv);
>> +	ret = clk_imx8mp_audiomix_reset_controller_register(dev);
>>  	if (ret)
>>  		goto err_clk_register;
>>  
>> 
>> -- 
>> 2.45.2
>> 

-- 
Jerome

