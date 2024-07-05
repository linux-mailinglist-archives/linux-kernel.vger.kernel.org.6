Return-Path: <linux-kernel+bounces-241820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE736927FEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8171C220D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D95312E6A;
	Fri,  5 Jul 2024 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aUq/G9EB"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2AEEDD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144498; cv=none; b=nAkGLTcdIllVuyP84yr8UNIVcyL86QXbVK6JXLQPoj7Cgqe6h/KPExOZs537nvhP2YUPYOWSjYx47QaTOyRDSftVsaGqCfSwRV6r9p1KrjyEWaa0pknSg3HSf+C1hG0aK757Vj6FDU4OwCP3TEVZe8Tnp6FuXEnWox2Jnzl38q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144498; c=relaxed/simple;
	bh=puFleb10pgzw0JwK7N3cCc2jyk/wG9aqIS6+Kd6x/q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYEBQdAZdiyfFeuE7MtwqX0/vYyGDmRh2FNiKQJFN/DLISyi8MFDy0Uc6QX+60KRHTHBvYZT0/h33W1JRLaaNItMffs5gYITJOlb77Az2HBedGTfbpRnugStbn8nidwwKOqHGVCsvhGZloC1khAh/0zYckOM+pSUGZTVPAAWcN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aUq/G9EB; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c2284616f7so657106eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720144495; x=1720749295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evps6cM4CdhLYsiZ31MoTnlxQFqNaoqz2LLlLWJA16g=;
        b=aUq/G9EBq0SpDQmhBVBEIjOFdz5IXixuESdBJ6BFakrpoDai82axexVoFZVCYdlHc9
         zX0YZdJ5n7Y3+0UJ9EX7jP7NepHZ+mqnigwe4w2XbtDMREQCCQT++nN/notSZTScw4P+
         Vs2i0yz7BE66fW02o7QN5V1el/Ul98xG/eNeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720144495; x=1720749295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evps6cM4CdhLYsiZ31MoTnlxQFqNaoqz2LLlLWJA16g=;
        b=ATvbftJgbXgosbZ57RTQYKoiI9+HexGC+WLUOzUobw3VQXmr8jZMx8QlbXS8eDQpjQ
         /7LoL7T0EB8M1LstNS1shBntee9ITBfhL+ZEE5fonFMKsidbg1KfnOqP4+2MREEIP39d
         H06w9CWOOSa7EKqOJteo9zijqX1kFmfyNDSmXeXcxNGx2hZhx0mawhcHrvfMbHQlr8hZ
         QY/4JcniqNTK6Rf7jOaAsF70jMInwQ25ZDW1XozYy1XSJdpQOb2WsUQKhWusAc4GDX4p
         FQ3SpTFVgZ6qEQmUY2irQF5FT9XDG2qjRzxZsGfifokt3u4UB8GmKTGNNyJHuurIL07m
         VTVA==
X-Forwarded-Encrypted: i=1; AJvYcCUtsD0NAP3+YiK/6Iwmr/Kwi3uOHd3jD6Ms2He/OmElzQldHdQo4O0UhySdvkJmi979KweGyOLW/c0TfDrJ3oLrkKwMI+CZ/YbCx/Ye
X-Gm-Message-State: AOJu0YwJichbuLKKLfhq71NItHCaQWsZ8yMvomUs+O1T6fryqdmwrQjB
	HyWGwLQQZokfrAGJhmPGGTLbKzpDG0oj5VldA0/vXdXUNkj4Syf72OvY6ze3IA==
X-Google-Smtp-Source: AGHT+IGB5K1TaDIMP5OcTX+7px5H5FK8gl0y0zaorqOhQTli2ft0P1W95wLRmeqHgCMqBoXfhA4u6g==
X-Received: by 2002:a05:6359:4c01:b0:1a6:b08d:7a2c with SMTP id e5c5f4694b2df-1aa98bbd7acmr299648655d.4.1720144494947;
        Thu, 04 Jul 2024 18:54:54 -0700 (PDT)
Received: from ?IPV6:2401:fa00:8f:203:cd34:f8a3:9ee6:ca3? ([2401:fa00:8f:203:cd34:f8a3:9ee6:ca3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d100ea3sm10356761a12.78.2024.07.04.18.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 18:54:54 -0700 (PDT)
Message-ID: <4e01aa78-497e-477e-a5c1-951cfb1df907@chromium.org>
Date: Fri, 5 Jul 2024 10:54:50 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] staging: media: ipu3: Stop streaming in inverse
 order of starting
Content-Language: en-US
To: Bingbu Cao <bingbu.cao@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ricardo Ribalda <ribalda@chromium.org>
References: <20240620145820.3910239-1-mstaudt@chromium.org>
 <20240620145820.3910239-4-mstaudt@chromium.org>
 <e6ff8ad5-933d-fbbb-0c4b-ae19c65e8439@linux.intel.com>
From: Max Staudt <mstaudt@chromium.org>
In-Reply-To: <e6ff8ad5-933d-fbbb-0c4b-ae19c65e8439@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bingbu,

Thanks for your review! Replies inline...


On 7/4/24 4:03 PM, Bingbu Cao wrote:
>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
>> index 3ff390b04e1a..e7aee7e3db5b 100644
>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
>> @@ -535,29 +535,51 @@ static void imgu_vb2_stop_streaming(struct vb2_queue *vq)
>>   		container_of(vq, struct imgu_video_device, vbq);
>>   	int r;
>>   	unsigned int pipe;
>> +	bool stop_streaming = false;
>>   
>> +	/* Verify that the node had been setup with imgu_v4l2_node_setup() */
>>   	WARN_ON(!node->enabled);
>>   
>>   	pipe = node->pipe;
>>   	dev_dbg(dev, "Try to stream off node [%u][%u]", pipe, node->id);
>> -	imgu_pipe = &imgu->imgu_pipe[pipe];
>> -	r = v4l2_subdev_call(&imgu_pipe->imgu_sd.subdev, video, s_stream, 0);
>> -	if (r)
>> -		dev_err(&imgu->pci_dev->dev,
>> -			"failed to stop subdev streaming\n");
> 
> I guess the subdev streams API can help us on this, but current fix
> looks fine for me.

I don't understand what you're referring to, since your comment is in 
relation to a block of existing code that I have merely shuffled around. 
Could you please elaborate?


>>   
>> +	/*
>> +	 * When the first node of a streaming setup is stopped, the entire
>> +	 * pipeline needs to stop before individual nodes are disabled.
>> +	 * Perform the inverse of the initial setup.
>> +	 *
>> +	 * Part 1 - s_stream on the entire pipeline
> 
> stream on or off? it is a little confusing.

I meant that s_stream(off) is called "on the entire pipeline".

Thanks, I'll rephrase this in v2 :)


>> +	 */
>>   	mutex_lock(&imgu->streaming_lock);
>> -	/* Was this the first node with streaming disabled? */
>>   	if (imgu->streaming) {
>>   		/* Yes, really stop streaming now */
>>   		dev_dbg(dev, "IMGU streaming is ready to stop");
>>   		r = imgu_s_stream(imgu, false);
>>   		if (!r)
>>   			imgu->streaming = false;
>> +		stop_streaming = true;
>>   	}
>> -
>>   	mutex_unlock(&imgu->streaming_lock);
>>   
>> +	/* Part 2 - s_stream on subdevs
>> +	 *
>> +	 * If we call s_stream multiple times, Linux v6.7's call_s_stream()
>> +	 * WARNs and aborts. Thus, disable all pipes at once, and only once.
>> +	 */
>> +	if (stop_streaming) {
> 
>> +		for_each_set_bit(pipe, imgu->css.enabled_pipes,
>> +				 IMGU_MAX_PIPE_NUM) {
>> +			imgu_pipe = &imgu->imgu_pipe[pipe];
>> +
>> +			r = v4l2_subdev_call(&imgu_pipe->imgu_sd.subdev,
>> +					     video, s_stream, 0);
>> +			if (r)
>> +				dev_err(&imgu->pci_dev->dev,
>> +					"failed to stop subdev streaming\n");
>> +		}
> 
> Is it possible to move this loop into 'if (imgu->streaming)' above?

The point of separating the loop from 'if (imgu->streaming)', and why 
the stop_streaming variable exists, is to keep the loop out of the 
mutex's hot path. This follows the code in imgu_vb2_start_streaming(), 
as mentioned in the commit message.

Is it safe to do this work with the mutex taken?

Is there any need to do this work with the mutex taken?

Should the streamoff path really be different from the streamon path?

Does this mean that the streamon path should also have this happen with 
the mutex taken?



Thanks,

Max


