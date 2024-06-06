Return-Path: <linux-kernel+bounces-204088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E8D8FE40A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC03B24E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D7F19069A;
	Thu,  6 Jun 2024 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwJZ635G"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DD19068F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668774; cv=none; b=pjRZ2WwBrRpJOtVbx2BEPONZKhhYCaWctYizsQM3KyEaTWgi0563t6ks44olI1e7Q8VXtem8jjQ+iWaKGO0R4wlkxBmdO6CJD7SsbVPuhLGswKy2PWrrNIJewleeRXtrHHrCgg55/BuYzsFhZCBJjtyxtEqvLpOdiD6MGjgaRBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668774; c=relaxed/simple;
	bh=FpruvuPD/Bh18bogFae9RpIep/NtvqwBxSmz4eQZHgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZjRrTowM6hyG144vsSLNJ55vAbAoZzMdqj28WNPLlhVUkYEdtH+5H5AN5atWgPpK4J7zF46mPVQNf8HwCzLMHItw4zUtpMKk4WkwS1lcDjiNBdukM+LkL7kwL6pKPG3EnIQ0Y/OJZlLPPkqG1WeitOId/ZB5kq34o3ufVG8XDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QwJZ635G; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a692130eb19so75625366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717668771; x=1718273571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYT9tVkTJ0UAXf8TGzWVnjnavb5dtCMnGfW04T5qoh8=;
        b=QwJZ635GQ9/JZnsucRnpXGmSllsRSat1CcuUKNpzGbWEpAmS++/+Ubf5dzu+Scrlry
         cWw4QtPU5BEyMSWokwbk3R7srtoBk78YlCTtLKxS69g7Ou4r4sj4Sxf+NVu741I88OVw
         CRtCl041XMZk4UzozeSgUyIbrf4ADb/gB45Aqe5GMwVS0QZRa3ixu3SpHwP+L99FGdGu
         o9ZUuU6t1nz+60ihdQBej7j+UvSykK2ZdnOTNRFYZR0a2FwckmXjoCYBrO7J2o1LKFxK
         43JKAB2Nji/OV5nM68oJkASDZEwQ8bzdTO0K/W3Fa8Gk1RJ84oC+OEgl/3b9Bk3hwYzu
         gURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668771; x=1718273571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYT9tVkTJ0UAXf8TGzWVnjnavb5dtCMnGfW04T5qoh8=;
        b=lzs16KwIdgQ8+bVK6n1+yJ7e8LG5RPnBrkOpjyCXnW7YWF8yu1RbHiHcphVwzvk/22
         n6RrTBcrzGaFhkemjzCFH96a2J9QBcFmEWNNaF8mcj0zPCT+MQSOx/MAVJoo5m7VjS+q
         l4czt+Vw/rfmBx0OmZaYF+ynNn4UdDPznd33KOAS99XSyCFJyXhgEopn9kJyOmO3OuZV
         gUYCt7bmC2EJ8WJIS/juqUKDK3GHfeT1kfUQ6pGK///zFysYyAdghSTIoGqaMZjKJeLB
         aooUf9EgWfH8hosa2bEqdI4OolJ2E5bIPvoCmJKYKAdRny/YgP3Y2FR2QoFt3WY46iwE
         8r0w==
X-Forwarded-Encrypted: i=1; AJvYcCUbgZ44YjgNyqLpkecPo48ZbFpb5ArOxxLBXKXfqoKqEoXZjVMIyKD9rkI9u2tgHxhwIsg2sRE7ER7bkC31Kp76L60s1m405CIJ+TCT
X-Gm-Message-State: AOJu0YzwHxqJVqdFO/MboDHtYUSlh6EXJgNnDFmOGmMtRRaIlKTSYkRR
	J7qCXTOT9a3KCm7AjzXfBvCwQ4Cw1bYvXXOc9+kt7RFXlMTdVZ3NEHTi++Sz3/s=
X-Google-Smtp-Source: AGHT+IGXEvwhigvaa2F7LH3u2SEZD2GotxH0tm3Qb9rzSgbG/zs824MHzxfnZBM0j8XV9T2jW92teA==
X-Received: by 2002:a17:906:38d1:b0:a5a:1562:518c with SMTP id a640c23a62f3a-a69a02363f3mr311414866b.48.1717668770651;
        Thu, 06 Jun 2024 03:12:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e82esm74598366b.161.2024.06.06.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:12:50 -0700 (PDT)
Date: Thu, 6 Jun 2024 13:12:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	manugautam@google.com
Subject: Re: [PATCH v1 06/17] misc: eeprom: at24: Change nvmem reg_read/write
 return type
Message-ID: <e5f3e798-0fb9-4dca-9449-cc1ab0677700@moroto.mountain>
References: <20240605175953.2613260-1-joychakr@google.com>
 <20240605175953.2613260-7-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605175953.2613260-7-joychakr@google.com>

On Wed, Jun 05, 2024 at 05:59:50PM +0000, Joy Chakraborty wrote:
> Change nvmem read/write function definition return type to ssize_t.
> 
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>  drivers/misc/eeprom/at24.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 4bd4f32bcdab..0e8d92d6ab1e 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -424,8 +424,9 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
>  	return -ETIMEDOUT;
>  }
>  
> -static int at24_read(void *priv, unsigned int off, void *val, size_t count)
> +static ssize_t at24_read(void *priv, unsigned int off, void *val, size_t count)
>  {
> +	size_t bytes_read = count;
>  	struct at24_data *at24;
>  	struct device *dev;
>  	char *buf = val;
> @@ -465,11 +466,12 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>  	if (unlikely(at24->read_post))
>  		at24->read_post(off, buf, i);
>  
> -	return 0;
> +	return bytes_read;
>  }

This is called like:

   574          ret = at24_read(at24, 2, &val, 1);
   575          if (ret || val != 11)
   576                  return;

So this breaks the driver.

regards,
dan carpenter


