Return-Path: <linux-kernel+bounces-170869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BF68BDD1D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC052834D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F7313CAB3;
	Tue,  7 May 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgRYx20c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AED13C9BD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070336; cv=none; b=CtjAkrlNoPmHq0SHvbcOYBDWSDU5la0FBTWluFMtVl8LLHHp9ehIjfpjiymhy2HK+vA4/eX76WNXoz7R30dpYmciIEUQNZ7qKEBnyzZLfeVaa8e4m+ZuuK84RXVJx19g4oU94lLR2eN44NlOj9p0xD2H5wJqJr0t8ZIx9aMgvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070336; c=relaxed/simple;
	bh=Ru/3Cuwl0Ds0fAdi+u7L2g+qfrHVWs2fWeekuJRZ6DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAizAXoHNPdAY9DOSz/1BakMi87D94z97hmTo/HNgTZkfszxe2S21eQQVtZibR8QCz8HKGnLp2L7P5i3sdRFLGtvBVoN+W/H1+GP2srCDD7kkimjTEDYwM1yeRAnH3Q8uNMIlD3YUNXO1qRg6x98bv7eb8tfwlhYAtCLVUJ+UvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgRYx20c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715070333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIV59TTIklTZ8E7Mjg7QWgOJHw97ato/FlS68wODcd0=;
	b=UgRYx20chkX/enaEyqFmAr9yFUywYwoInJHdYMMBGKwK1olev3biKiE0d7MAtNVOIBxHK/
	7D8jFnWG+awZBt3YPN3QjLaBzCX2ahw7JPkF4ETxyUOlUtrcpsozQDlrqZTET+TmzF1UT9
	TgJy0JMp//Rf3mQjM+nDC5iqr5FU3aE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-q7AD0pMqNhSLy5oPvbOwGw-1; Tue, 07 May 2024 04:25:32 -0400
X-MC-Unique: q7AD0pMqNhSLy5oPvbOwGw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a592c35ac06so292604566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715070331; x=1715675131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIV59TTIklTZ8E7Mjg7QWgOJHw97ato/FlS68wODcd0=;
        b=jCY9Xa0czkd0AOdS+1+Venc6TYF0QyXm2J85s4HAsHlqrCcIcCWPeC1qdjtUW3ccWv
         nZDEaJse0dkj9YRzWx43/M3tjxtZLi8IsIJtRxJQ7l2DEUVcR+QhnLbuO80fZuCMR1c+
         qwDX2xSeN4/8LE3K3GlPxmbgpPFMvOkwtem5RDeuDrAusNkxWEOoJ26qXWRykNdzHEqa
         yXcYRNiX8B+/63cUgF6TwjMOlBdnHWZLU/pY3Mh2+T+0Fw73Rz+1XO+K4PDyzZHMKppV
         uYLDwTes39kDPedJrSVEGjhVgWVkmmJi8u/I19mXFAdlj1QPnEwBFYVOpwVMoxAOoeSs
         cf4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV78AvAngLMrkNfFCfkpdBlMlM4Dl5PqqiJ9eMOA0rEh5qmP2ukENn0wFFrnHt+j0AMCms8lSBgFgsGG6InWKJ+ENm3WduTYxB22S50
X-Gm-Message-State: AOJu0YzW+85Sf5Hd8RqaGXGUVEVIbIP6sBlAqcArTEx9b9nE013/mS2P
	jC8JMUA9bG74d64OyCl9W1L4+OY0aPJ+6HIB/HLc6J77fZoobo54J10OL+nKCH0Ch1JwaPvOUxJ
	RHNPp+0Y8ohdTfhU4VUCR8HUYa22UR6Kpeygcj7JfbB9a+DGdRbauXk8NFBkyYQ==
X-Received: by 2002:a17:907:9451:b0:a59:f2d2:49b1 with SMTP id dl17-20020a170907945100b00a59f2d249b1mr513044ejc.9.1715070331099;
        Tue, 07 May 2024 01:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE0YLDxSU/VMUbuSbDaD4PxbC8U7jFZ/xx4z1XkZHULEfaIHq2T/SXOucES9GSEXN/mDLg3A==
X-Received: by 2002:a17:907:9451:b0:a59:f2d2:49b1 with SMTP id dl17-20020a170907945100b00a59f2d249b1mr513024ejc.9.1715070330705;
        Tue, 07 May 2024 01:25:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ao18-20020a170907359200b00a59bda080ffsm3123769ejc.194.2024.05.07.01.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 01:25:30 -0700 (PDT)
Message-ID: <155361c0-5068-44df-9fca-d775fc518b7d@redhat.com>
Date: Tue, 7 May 2024 10:25:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: goodix-berlin - Add sysfs interface for reading
 and writing touch IC registers
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Charles Wang <charles.goodix@gmail.com>, hadess@hadess.net,
 Richard Hughes <hughsient@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
 Mark Brown <broonie@kernel.org>
References: <20240506114752.47204-1-charles.goodix@gmail.com>
 <6362e889-7df2-4c61-8ad5-bfe199e451ec@redhat.com>
 <ZjmOUp725QTHrfcT@google.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZjmOUp725QTHrfcT@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/7/24 4:13 AM, Dmitry Torokhov wrote:
> On Mon, May 06, 2024 at 02:03:13PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 5/6/24 1:47 PM, Charles Wang wrote:
>>> Export a sysfs interface that would allow reading and writing touchscreen
>>> IC registers. With this interface many things can be done in usersapce
>>> such as firmware updates. An example tool that utilizes this interface
>>> for performing firmware updates can be found at [1].
>>
>> I'm not sure if I'm a fan of adding an interface to export raw register
>> access for fwupdate.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/touchscreen/goodix_fwupload.c
>>
>> Contains update support for older goodix touchscreens and it is not
>> that big. I think it might be better to just have an in kernel fwupdate
>> driver for this and have a sysfs file to which to write the new firmware.
>>
>> Adding Richard Hughes, fwupd maintainer to the Cc. Richard, do you have
>> any input on the suggested method for firmware updating ?
>>
>> If raw register access is seen as a good solution, then I think this
>> should use regmap + some generic helpers (to be written) to export
>> regmap r/w access to userspace.
> 
> I think the less code we have in kernel the better,

Ok.

> especially if in
> cases where firmware flashing is not essential for device to work (i.e.
> it the controller has a flash memory).

Right the existing older goodix fw-upload is different because some
controllers are flash-less so they need a fw upload every boot.

> That said IIRC Mark felt very
> strongly about allowing regmap writes from userspace... but maybe he
> softened the stance or we could have this functionality opt-in?

Right when I was talking about generic helpers that was meant for
code re-use purposes. Actually exposing the regmap r/w functionality
to userspace is something which should be decided on a case by case
basis by the driver (IMHO).

Regards,

Hans



> 
>>
>>> [1] https://github.com/goodix/fwupdate_for_berlin_linux
>>
>> Hmm, that tool seems to have some licensing issues there is an Apache License v2.0
>> LICENSE file, but the header of fwupdate.c claims it is confidential ...
>>
>> Regards,
>>
>> Hans
>>
>>
>>> Signed-off-by: Charles Wang <charles.goodix@gmail.com>
>>> ---
>>>  drivers/input/touchscreen/goodix_berlin.h     |  2 +
>>>  .../input/touchscreen/goodix_berlin_core.c    | 52 +++++++++++++++++++
>>>  drivers/input/touchscreen/goodix_berlin_i2c.c |  6 +++
>>>  drivers/input/touchscreen/goodix_berlin_spi.c |  6 +++
>>>  4 files changed, 66 insertions(+)
>>>
>>> diff --git a/drivers/input/touchscreen/goodix_berlin.h b/drivers/input/touchscreen/goodix_berlin.h
>>> index 1fd77eb69..1741f2d15 100644
>>> --- a/drivers/input/touchscreen/goodix_berlin.h
>>> +++ b/drivers/input/touchscreen/goodix_berlin.h
>>> @@ -19,6 +19,8 @@ struct regmap;
>>>  int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
>>>  			struct regmap *regmap);
>>>  
>>> +void goodix_berlin_remove(struct device *dev);
>>> +
>>>  extern const struct dev_pm_ops goodix_berlin_pm_ops;
>>>  
>>>  #endif
>>> diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
>>> index e7b41a926..e02160841 100644
>>> --- a/drivers/input/touchscreen/goodix_berlin_core.c
>>> +++ b/drivers/input/touchscreen/goodix_berlin_core.c
>>> @@ -672,6 +672,44 @@ static void goodix_berlin_power_off_act(void *data)
>>>  	goodix_berlin_power_off(cd);
>>>  }
>>>  
>>> +static ssize_t goodix_berlin_registers_read(struct file *filp, struct kobject *kobj,
>>> +	struct bin_attribute *bin_attr, char *buf, loff_t off, size_t count)
>>> +{
>>> +	struct goodix_berlin_core *cd;
>>> +	struct device *dev;
>>> +	int error;
>>> +
>>> +	dev = kobj_to_dev(kobj);
>>> +	cd = dev_get_drvdata(dev);
>>> +
>>> +	error = regmap_raw_read(cd->regmap, (unsigned int)off,
>>> +				buf, count);
>>> +
>>> +	return error ? error : count;
>>> +}
>>> +
>>> +static ssize_t goodix_berlin_registers_write(struct file *filp, struct kobject *kobj,
>>> +	struct bin_attribute *bin_attr, char *buf, loff_t off, size_t count)
>>> +{
>>> +	struct goodix_berlin_core *cd;
>>> +	struct device *dev;
>>> +	int error;
>>> +
>>> +	dev = kobj_to_dev(kobj);
>>> +	cd = dev_get_drvdata(dev);
>>> +
>>> +	error = regmap_raw_write(cd->regmap, (unsigned int)off,
>>> +				 buf, count);
>>> +
>>> +	return error ? error : count;
>>> +}
>>> +
>>> +static struct bin_attribute goodix_berlin_registers_attr = {
>>> +	.attr = {.name = "registers", .mode = 0600},
>>> +	.read = goodix_berlin_registers_read,
>>> +	.write = goodix_berlin_registers_write,
>>> +};
>>> +
>>>  int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
>>>  			struct regmap *regmap)
>>>  {
>>> @@ -743,6 +781,14 @@ int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
>>>  
>>>  	dev_set_drvdata(dev, cd);
>>>  
>>> +	error = sysfs_create_bin_file(&cd->dev->kobj,
>>> +				      &goodix_berlin_registers_attr);
> 
> If we want to instantiate attributes from the driver please utilize
> dev_groups in respective driver structures to create and remove the
> attributes automatically.
> 
> Thanks.
> 


