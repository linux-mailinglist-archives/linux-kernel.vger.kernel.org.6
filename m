Return-Path: <linux-kernel+bounces-194283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15D8D3975
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925DC1C22E87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D56159912;
	Wed, 29 May 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjzd6D8J"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59AE159209
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993387; cv=none; b=EZ+Jvn9aP8vIFmQntdr07FGOYLOB6k0iHXaoTFHr2e8N5jolCkhiqxlFYcmOHlYk4/na2BQGWv1g5/gFMHGMr6BDhXKhOfmr/zVzUhSeqdRSBwxCX0cBZHtvyD9qOWhU/5zBBzIlgruFMJxuAkyqSpPH7ODDYNvSeqzNhqFOrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993387; c=relaxed/simple;
	bh=OGbtwjULhl3w+vcGIL81b+obaLwHCiTbz2FtbPMorDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J6bLE4o6B/TIhKK0+uDPE/4+rPH8n7Cl44mRlkdbSj6j4IWBL698/kUG4hvUD/hosxGss6lpNz6DyoXd8htwo1h3yw6zu1LpaD8jz8jS47K2js6WckM0rc4WrnIbIcOXXuOciJjNEU1J3bGzvh0BCsZIJ+E/VRnW/EBflaoHg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjzd6D8J; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5295bcb9bc1so2294331e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716993384; x=1717598184; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=onLXeJRqtHiywJfTtQupZmxSe9czseg1ydGlgZn2T04=;
        b=cjzd6D8JtWGDjAN+E7b91l2sY8dlCZ6TWvu1q9RAHv8qwfoECiXO9Mjv7jrmwLkm7I
         5q+2uZVeOTXJkazqnptyqCtO9phu32XlKDO9WZ4hV8LlvtJ7Elo1pZfQpij1542axtul
         cOMPqHkQaBjUt3+uoC6q5Cm/2O9B9Ya5Mc9RMIfiWPqBCCT9SlM2t0664jgI2YUONQDu
         88gtShsvH2K0gdDyG19fyp38m6jLBktP7aZI+JwfRExEgFobSJWf8vpmpuSm9OzjBxe7
         08qLqVHugypeqJvLxLZfaGBTAiBPsoph3sulkfVOpJQ4Z8KUx9DvdfiQ/uRgIr6bsfuK
         e20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993384; x=1717598184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onLXeJRqtHiywJfTtQupZmxSe9czseg1ydGlgZn2T04=;
        b=Snl4zM/UBlm6jnZpaAvbXm4/PYraazoqiMiM9xPhDF3RzVm/+mh2Epclsanf88l1Mp
         /Cu8Rm0zuSJCe3t9vV3ujZ/8SHuLsUfI3C6LjhouWchruq7whufp4NiNY6XlftW/aT77
         3MkejnKvqHOsWHcVBNItJkj9drYnQyL7kXj9Ir7p3GB7HjzuZcpiREfePW0s7EeWjgEb
         zobHW0eFYqNCdWw/1sLSybipicQFpyHWWF6trHY9lCZH7DZIFXwVW9VOnyXr1tD+GbZK
         NkT9bFVbV8Yf7oXUetjRZn5denWcTISGDebdg+If02gLFh5+vpQ8z1xpxJ/YCmJkXixO
         eivA==
X-Forwarded-Encrypted: i=1; AJvYcCXGvac+xB/vJfKbH10syqTKHJam8/MgHVJeTL31ImCDHBA31K0b/SefomAziuQAehQplT5GVpZqx0Na/vAgq7XLeB87qFLN89I3EmbF
X-Gm-Message-State: AOJu0YziTmNKtRXWuk6SMcEzODaGM/7HHMjBXOuqFjDUk5Qr03uaH1y5
	zg6X7nbh/7lmrAtP8Zl5PrFaN7O7wltQpneF6exSr85r4AK220SJf/Q9DzAXW9k=
X-Google-Smtp-Source: AGHT+IGc7EKt54sm1khoej2woFrmOQu3LLvXiuSZdD1P1QxwpCeqzx3WQs7Wuujc3vbdzMFGi4KfwA==
X-Received: by 2002:a05:6512:3a93:b0:529:b3c9:7261 with SMTP id 2adb3069b0e04-529b3c97397mr6223224e87.5.1716993383771;
        Wed, 29 May 2024 07:36:23 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc51489sm721025766b.128.2024.05.29.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:36:23 -0700 (PDT)
Date: Wed, 29 May 2024 17:36:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Francesco Dolcini <francesco@dolcini.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: ti-ads1119: Add driver
Message-ID: <a3521734-487b-4c17-b910-2b169b26bc64@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527154050.24975-3-francesco@dolcini.it>

Hi Francesco,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Dolcini/dt-bindings-iio-adc-add-ti-ads1119/20240527-234431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240527154050.24975-3-francesco%40dolcini.it
patch subject: [PATCH v1 2/2] iio: adc: ti-ads1119: Add driver
config: openrisc-randconfig-r071-20240529 (https://download.01.org/0day-ci/archive/20240529/202405291150.r5z8TZYu-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405291150.r5z8TZYu-lkp@intel.com/

New smatch warnings:
drivers/iio/adc/ti-ads1119.c:653 ads1119_get_configs() warn: passing zero to 'PTR_ERR'

vim +629 drivers/iio/adc/ti-ads1119.c

14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  642  static int ads1119_get_configs(struct ads1119_state *st)
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  643  {
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  644  	struct device *dev = &st->client->dev;
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  645  
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  646  	st->vref = devm_regulator_get_optional(dev, "vref");
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  647  	if (IS_ERR(st->vref))
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  648  		return dev_err_probe(dev, PTR_ERR(st->vref),
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  649  				     "Failed to get vref\n");
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  650  
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  651  	st->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  652  	if (IS_ERR(st->reset_gpio))
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27 @653  		return dev_err_probe(dev, PTR_ERR(st->vref),
                                                                                                  ^^^^^^^^
st->reset_gpio was intended.

14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  654  				     "Failed to get reset gpio\n");
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  655  
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  656  	return ads1119_alloc_and_config_channels(st);
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  657  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


