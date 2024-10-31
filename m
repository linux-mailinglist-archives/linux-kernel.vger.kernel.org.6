Return-Path: <linux-kernel+bounces-390926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BABD9B801C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B45E2854A4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD401BD51B;
	Thu, 31 Oct 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q5M/Oj9i"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C61BD4E4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392072; cv=none; b=cP9ElKdtaGsVq1YKCUDdURotjQPAPo07adVzlpWYAC6SGDPSlVGMmbbuYPJgoiNVKMr7YD/SWXltjuVGYGwDbv5XMR56/J8I8rQQCGTR1rAqd0JDUR20Sk7pTgdJAVeOfQ+0X0BepTQI9C87nd4JhEdiYfgqNVsEwGtqlnUmnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392072; c=relaxed/simple;
	bh=NXkq/qyOqhp8iiSocyYd5F4iMl9dEpzBnig3MAjD1ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTb4TbSaDZXmB9zPUKtdRe70vkp4IvTKjmaLizeoAWYthwYBUGnNEJdwrYvkZbZzxHtEVaEZiZsEtIQUHO1A41NGwWGaJFKgqjfuIWxLLR05QRS7yZ0kJCUXa8rqYkx/E7QUU5jw558D/Isp9uzxAiT8ECVWLPnis7Z3fHnWGUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q5M/Oj9i; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7180f2f5fb0so571932a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730392068; x=1730996868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8zkuoswXbu0x76VZ9dkSgVo5XUz825DeoWuELNa3+zU=;
        b=q5M/Oj9i+XqVZc0GrEkuCxFJfj8OZBgHXw0lBI/odPbQvz4o76tGKXZ4a98Oj95Teg
         NE7qbtFqX/M5poFVVX00GCuUc69wAYNMwdGETpLXaJ1QXGVqDpxJLHoFY3H5wMYng6ol
         Ufd8lUxtTEhXq/QniyAhaBB7CfeIhcohnWOSmqB1Rnqxf2BBMgv+p/6lw6+CEb4aWP2O
         4OswJ5tyDTDxjLZk6/L7gHOL1Hkuem9de0eMx9Kjk/R/qjazmik86pMeMmUuheJ5SLKI
         oa6QbxVUhTFyBAe1GhljdsPsUpnAmh42AUOaTHrmc/kzdcFG8/lA1rHO1VImy0O2btvW
         2fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392068; x=1730996868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zkuoswXbu0x76VZ9dkSgVo5XUz825DeoWuELNa3+zU=;
        b=bY0DrTGI1xG0xBAW/HXwhrghilNPIHQJOMAWcp9H8lt7lSUOOFbQURhFFZ7au5hGBc
         Elvw6SmdWEniDG9QJqtZOtm6D2DuI2lFEFLn/QDUz3S3MIv2qXVHTL42eX7pj/mWKGeJ
         Hk1dA8AKZ/WJcZDQnxTuhCDhiiguNqwCTWVxLFOnfH7jOH7c2ZlaZCgHDD1csuFj9heX
         VBeOPHNJQkKRK7yfh+NgHgOClOUENcOzYxJH3gUTS81K0IPzgLD+gsJQiOCRVnpOxHeh
         /MzkDikZFBLT3PAjcusJXFmGAx0KZnEj9RgI8kPsOxrg2Qtfrmp/J45aakr4d69uNXi8
         Ls9w==
X-Forwarded-Encrypted: i=1; AJvYcCVKcaEuJRjpidMUqFbxQ8r0PE2r/hVUrCVD/035cYVGeo7OXFWOsDEYvuv9B5HtSog0SHfc7HkJUSxmb8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR172F8PQvdSPAK043MT3j2K5FZuXs5taBKHG7ybBtliGvBDe/
	ZGRiciQVOX3E88CiQPbl21CMYGmN3WKLRj3GBrpwq0qIJHm9xs/QpdtNV5jkIpY=
X-Google-Smtp-Source: AGHT+IGn3VcXN2vRbd8Rr0640Qt+w79Jerb9SkZNzmKhPFUbewiTnVqw/wQKsRc9oFeGGtT+FubdUQ==
X-Received: by 2002:a05:6830:4123:b0:718:43b6:b0a0 with SMTP id 46e09a7af769-7189b4b76edmr3540707a34.4.1730392067759;
        Thu, 31 Oct 2024 09:27:47 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc69b1dsm402044a34.18.2024.10.31.09.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 09:27:47 -0700 (PDT)
Message-ID: <ef4fe230-b7fb-4f7e-9173-ae85d305e9ae@baylibre.com>
Date: Thu, 31 Oct 2024 11:27:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] iio: light: adux1020: write_event_config: use
 local variable for interrupt value
To: Julien Stephan <jstephan@baylibre.com>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Dan Robertson <dan@dlrobertson.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Michal Simek <michal.simek@amd.com>, Mariel Tinaco
 <Mariel.Tinaco@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij
 <linus.walleij@linaro.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
 <20241031-iio-fix-write-event-config-signature-v2-6-2bcacbb517a2@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-6-2bcacbb517a2@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 10:27 AM, Julien Stephan wrote:
> state parameter is currently an int, but it is actually a boolean.
> iio_ev_state_store is actually using kstrtobool to check user input,
> then gives the converted boolean value to write_event_config.  The code
> in adux1020_write_event_config re-uses state parameter to store an
> integer value. To prepare for updating the write_event_config signature
> to use a boolean for state, introduce a new local int variable.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/light/adux1020.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> index 2e0170be077aef9aa194fab51afbb33aec02e513..db57d84da616b91add8c5d1aba08a73ce18c367e 100644
> --- a/drivers/iio/light/adux1020.c
> +++ b/drivers/iio/light/adux1020.c
> @@ -505,7 +505,7 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
>  				       enum iio_event_direction dir, int state)
>  {
>  	struct adux1020_data *data = iio_priv(indio_dev);
> -	int ret, mask;
> +	int ret, mask, val;
>  
>  	mutex_lock(&data->lock);
>  
> @@ -526,12 +526,12 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
>  			mask = ADUX1020_PROX_OFF1_INT;
>  
>  		if (state)
> -			state = 0;
> +			val = 0;
>  		else
> -			state = mask;
> +			val = mask;
>  
>  		ret = regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
> -					 mask, state);
> +					 mask, val);
>  		if (ret < 0)
>  			goto fail;
>  
> 

Instead of introducing `val`, I would rewrite this as:

	if (state)
		ret = regmap_clear_bits(...);
	else
		ret = regmap_set_bits(...);




