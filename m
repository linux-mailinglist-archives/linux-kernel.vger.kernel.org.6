Return-Path: <linux-kernel+bounces-300427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF7C95E38C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B85281710
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AD31547DA;
	Sun, 25 Aug 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h00MT5Oz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FB1E520
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724591584; cv=none; b=bFbw78WTTJU6/fB4tAWgiMg52i47wzVffS6rDRkWJd8n+iiSziCXeGFvdeWsanbAWFkGnZY2cZSP4B3HmN0pXmrLJ2X6EDsLMwMKY3BBcAv1zHoRmsZV3zsFUPDUbIqbcZk31ECpqgccvRTxHQgWMLHFo1jAa5E7nMnDb0A65Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724591584; c=relaxed/simple;
	bh=TgKYnPZPyDTOZ3L65cfrHkuK/skuYvE26k2QLr8XRJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTihIZofVxWB12aqDSw+mgZebg3dNewKIst3ktaSR6KRahVWnPhFyZ+hsEEmPYpJ+DuLMIatl+Ojf9ysQ59ucbfldgeIC04oolJ0Als98VCsEpQ4qu6K9/HQtEhzgJbAJOiFtqgSiJsd7yfIDUqE78+I+LpZyyr0Q2KoGzfSvok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h00MT5Oz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724591582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjT76MGllL0Qcry+tUV4L4dLGaCMJhJzvO4cnqx+Y6g=;
	b=h00MT5OzNb4u65ogvNRayx2QATnT6PEUgQpQCbTM6r8iBhjwqnGuPSwcQ4RdcbVtkm56Ut
	AfnrHCHUVjM3pAMptOqkMEaPK6F6H9ng1TawJMszmsEOswFoIzeVoJeZXDbI3avfwEMPnU
	cwRuoYhutfvzcC8WmRm3xx+MqBD6jbA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-gZg8FLg7PwOOEBuKCyitDg-1; Sun, 25 Aug 2024 09:13:00 -0400
X-MC-Unique: gZg8FLg7PwOOEBuKCyitDg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3fc9d8c00so36215381fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 06:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724591579; x=1725196379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjT76MGllL0Qcry+tUV4L4dLGaCMJhJzvO4cnqx+Y6g=;
        b=PIGFoD9YTIpXukjmjrEfLMFyhebs9i7S3/5XeO8kFRHgKnCMR1wlz98W0KvvnHTp86
         MWO+aeZSw00ygwsA5CEZWhWCUP95Cn3ccT0YxNYTWb4RZhuLFr7rr0rqbKwWj4YKYx86
         QloLiutYuAEfRRYnGC3t7wt+2g9F5xVvrPkw39HMrPagPB/2oTwmrlouK0S9B6KL24lf
         eog3iDOWhQdyNC0KfCWPInhzduma7Hk1OuIpC00pUW8DKub1xDPArmdVmuQ3ygsnp/zX
         Vq97DOlkSseyH4HX+DrvzuVeLPwSK1DYI/2vRsJR/BTNm5FfVGu6mjtwyXLLMqekKvb5
         Ywlg==
X-Forwarded-Encrypted: i=1; AJvYcCUbrXYjQZqD0DpTa7SURE+ZgscWvxAXvRrHN+ma+C6ukaHSy3bfjfYB0/jvJuRWK1cgrcqCSZzdaKuSYTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGr7kaEJS9JB4Uce752Xjmzk+s+m20pKDl2kAMC6w3g4e9MCs
	ojaOxsnRg0xi41TdPabWcvHhoS/iHyunvxqpl41cLTJ7F56AOWilmEHSxAfSu+zkM8ZahJYKSa5
	Q1VCig5nOXEd8FLjuq30w/9Jqp6nGL9i+pRxe8xTBFI71daMl4LFSEScF7e2npQ==
X-Received: by 2002:a2e:5119:0:b0:2f1:922f:874a with SMTP id 38308e7fff4ca-2f4f48eeda8mr42665831fa.14.1724591579160;
        Sun, 25 Aug 2024 06:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGedG8Qc1ocP0F7rBDO7Du9zOdeBSFMEWGKGSF2JNS3V7HesaJGbrGKKVPU6aQQc17mUbUsw==
X-Received: by 2002:a2e:5119:0:b0:2f1:922f:874a with SMTP id 38308e7fff4ca-2f4f48eeda8mr42665631fa.14.1724591578503;
        Sun, 25 Aug 2024 06:12:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3cc25bsm4404438a12.38.2024.08.25.06.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 06:12:58 -0700 (PDT)
Message-ID: <c32467c6-fe3d-4ac9-85cb-15f37d4728a2@redhat.com>
Date: Sun, 25 Aug 2024 15:12:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] Input: atkbd - use guard notation when acquiring
 mutex
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Jeff LaBundy <jeff@labundy.com>, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org
References: <20240825051627.2848495-1-dmitry.torokhov@gmail.com>
 <20240825051627.2848495-4-dmitry.torokhov@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240825051627.2848495-4-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/25/24 7:16 AM, Dmitry Torokhov wrote:
> This makes the code more compact and error handling more robust
> by ensuring that mutexes are released in all code paths when control
> leaves critical section.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/input/keyboard/atkbd.c | 37 ++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index f4f2078cf501..5855d4fc6e6a 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -639,7 +639,7 @@ static void atkbd_event_work(struct work_struct *work)
>  {
>  	struct atkbd *atkbd = container_of(work, struct atkbd, event_work.work);
>  
> -	mutex_lock(&atkbd->mutex);
> +	guard(mutex)(&atkbd->mutex);
>  
>  	if (!atkbd->enabled) {
>  		/*
> @@ -657,8 +657,6 @@ static void atkbd_event_work(struct work_struct *work)
>  		if (test_and_clear_bit(ATKBD_REP_EVENT_BIT, &atkbd->event_mask))
>  			atkbd_set_repeat_rate(atkbd);
>  	}
> -
> -	mutex_unlock(&atkbd->mutex);
>  }
>  
>  /*
> @@ -1361,7 +1359,7 @@ static int atkbd_reconnect(struct serio *serio)
>  {
>  	struct atkbd *atkbd = atkbd_from_serio(serio);
>  	struct serio_driver *drv = serio->drv;
> -	int retval = -1;
> +	int error;
>  
>  	if (!atkbd || !drv) {
>  		dev_dbg(&serio->dev,
> @@ -1369,16 +1367,17 @@ static int atkbd_reconnect(struct serio *serio)
>  		return -1;
>  	}
>  
> -	mutex_lock(&atkbd->mutex);
> +	guard(mutex)(&atkbd->mutex);
>  
>  	atkbd_disable(atkbd);
>  
>  	if (atkbd->write) {
> -		if (atkbd_probe(atkbd))
> -			goto out;
> +		error = atkbd_probe(atkbd);
> +		if (error)
> +			return error;
>  
>  		if (atkbd->set != atkbd_select_set(atkbd, atkbd->set, atkbd->extra))
> -			goto out;
> +			return -EIO;
>  
>  		/*
>  		 * Restore LED state and repeat rate. While input core
> @@ -1404,11 +1403,7 @@ static int atkbd_reconnect(struct serio *serio)
>  	if (atkbd->write)
>  		atkbd_activate(atkbd);
>  
> -	retval = 0;
> -
> - out:
> -	mutex_unlock(&atkbd->mutex);
> -	return retval;
> +	return 0;
>  }
>  
>  static const struct serio_device_id atkbd_serio_ids[] = {
> @@ -1465,17 +1460,15 @@ static ssize_t atkbd_attr_set_helper(struct device *dev, const char *buf, size_t
>  	struct atkbd *atkbd = atkbd_from_serio(serio);
>  	int retval;
>  
> -	retval = mutex_lock_interruptible(&atkbd->mutex);
> -	if (retval)
> -		return retval;
> +	scoped_guard(mutex_intr, &atkbd->mutex) {
> +		atkbd_disable(atkbd);
> +		retval = handler(atkbd, buf, count);
> +		atkbd_enable(atkbd);
>  
> -	atkbd_disable(atkbd);
> -	retval = handler(atkbd, buf, count);
> -	atkbd_enable(atkbd);
> -
> -	mutex_unlock(&atkbd->mutex);
> +		return retval;
> +	}
>  
> -	return retval;
> +	return -EINTR;
>  }
>  
>  static ssize_t atkbd_show_extra(struct atkbd *atkbd, char *buf)


