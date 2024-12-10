Return-Path: <linux-kernel+bounces-439743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A27D9EB36B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E618821A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC341AA1D0;
	Tue, 10 Dec 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CzFfuBZN"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA71B0F12
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841263; cv=none; b=pwdNRl3P39MG8F+RnBcdmArIAAALfLk4CQpr/4oADLHBL+EEHom5wsA2awQp2IWwf7pLQAbi80NPk3uaqVawrba7De444p5LccwVzWrqeg844ajMqR91r4uBLRFKRa2sJNbdNITZZIpMrHAUVometRteSb/hDbp+bN+AKHzaRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841263; c=relaxed/simple;
	bh=wL/C8ixmOeDW1M47Em1V+s7X4Nn+lXQj60lRvkyXGHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ViXFTldm6BiwdoBFq5DaxzJifGy/7v9FFglbIyh0jUmDD2DZ7gHN6tn/6q4sBo/klU5aLWlWOwN/NUkY8I8FUxGd7OhpTXSP6gosyWzBhko8ptsBdPTszcxIBsGQIDfDLCedkzIFD3rUtZGYTDQCXo+jORPYLxJgfxZsqXxdWF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CzFfuBZN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3863494591bso1609045f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733841259; x=1734446059; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLWNAFt04XZFMzgoo3Wx69kCUbMq2HcsHfVzuaxPD5U=;
        b=CzFfuBZN75Kmrj/rhKaCXOsZbYGcSZvvLmP781Sxqgy7uXUnkcYO7PGPgGiXFe3n3o
         FcGB41KqgzJGROpACmbTh6Hrai9c+z0uD8Dz7rElddZdcXX3YHe+NEXMvT6fq87+K0ud
         rYQJA2hob79UhoYAbb4ebtvXCum+YLcg+Eajl4ELUKmc2w0mpJdYKQT9f613gzBSdudP
         Np8J57EzdaTaI+ZBwFPCz62WCgH0W5ujU7LGAvXVuR3DyFFytMry7uT+UadpHW0dWIDF
         wSYdddpZo8aoLiV+hh4C3Nl4R3VlgT1LkYnc29NTwymTC0SQ6RE1jL/YuMAm+XZwR4IV
         v+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841259; x=1734446059;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLWNAFt04XZFMzgoo3Wx69kCUbMq2HcsHfVzuaxPD5U=;
        b=I621xuWIqYb6B6ju9zXuCU2vQ2gbeaxNueS7qkyYvBYCfSwgOEZMuBGTZZTeExKQ6y
         dIWLLHso4T2M5kvUBM/G8JjMHpd2v/exnCybIkDcdx9hsP+3l/PE6qTnzJ3l8PfH6hUf
         6lYnnAkphI6/RaNPET73sdTx9IdboT1DL79z4E9QfTs/21ZDyNFPW8okRMWwiy+nV4xH
         SutLqWMqWXkhjTHinDiCP5wHThRi9tM/x5UWNbkSPlR4pT25A1SliLp9E0ljN17+Qh9X
         t38BkInejxxP8tlu26fs1oMRmretVQ04CFtg6PXfET4J+I1p1vMft82YX2hdQtJJhzpn
         pxag==
X-Forwarded-Encrypted: i=1; AJvYcCXqAubo/GS0iap0pA99ou6WHS1LPv9r7+8E0geJnpuOTAyvJi/KktMvfU50CkoL+xB66B/qXX/t3P2RiOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8dDBLS9IxceJP+Q280iBkNdrRNzV3NNKqyorrXpMymbmQ0Rrf
	QwQOCHgtcFccWrcKa/2avInOHFelFZlYjhn1o0rspfSv8IOj/svig0mQGgwEwAY=
X-Gm-Gg: ASbGncuZMdgi+b0NwXCy2L4IChkjH91NxxCkVve5+59lgdBvGDVPzvrYOXrN2zm6Zf8
	6qykFQis1za1RENNEa+xHIKcB0ACbLHeLs+VIoR95iIYA8Gy2gji6rw6qepvD9v9bMmMkKPThc1
	wAON8daCncKPBza7ByFVS4uiXtI08WMMO3LayTUl24S4Sdwq0vjQKQM0s5UlpbbfJX4bJjhQwj0
	NuV5urJAsQzrLrRKiLfanfspM/Tm3ji1LIwW/W36KTcnrWanMiV4Q==
X-Google-Smtp-Source: AGHT+IE5Z4NPwjLfUmC7wukJpwINHppjLl7ehi1JIZ2MTEDsQKsxXtiivlh1JGXCVK4hlptPFx2sRw==
X-Received: by 2002:a05:6000:1568:b0:385:dffb:4d70 with SMTP id ffacd0b85a97d-386453fbf0dmr2943951f8f.54.1733841259194;
        Tue, 10 Dec 2024 06:34:19 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:f337:e8ca:8b65:dbc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38636e05568sm9978095f8f.39.2024.12.10.06.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:34:18 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Ertman <david.m.ertman@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  "Rafael J. Wysocki" <rafael@kernel.org>,  Stephen
 Boyd <sboyd@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: auxiliary bus: add device creation helper
In-Reply-To: <2024121048-latticed-etching-8961@gregkh> (Greg Kroah-Hartman's
	message of "Tue, 10 Dec 2024 15:05:36 +0100")
References: <20241210-aux-device-create-helper-v1-1-5887f4d89308@baylibre.com>
	<2024121048-latticed-etching-8961@gregkh>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 10 Dec 2024 15:34:17 +0100
Message-ID: <1jseqvwqs6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 10 Dec 2024 at 15:05, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Dec 10, 2024 at 02:43:12PM +0100, Jerome Brunet wrote:
>> Add an function helper to create a device on the auxiliary bus.
>> This should avoid having the same code repeated in the different drivers
>> registering auxiliary devices.
>> 
>> Suggested-by: Stephen Boyd <sboyd@kernel.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>> The suggestion for this change was initially discussed here: [1]
>> 
>> I was not sure if the managed variant should return the auxiliary device or
>> just the error. This initial version returns the auxiliary device, allowing
>> it to be further (ab)used. Please let me know if you prefer to just return
>> the error code instead.
>> 
>> Also the non managed variant of the helper is not exported but it could
>> easily be, if necessary.
>> 
>> [1]: https://lore.kernel.org/linux-clk/df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org
>> ---
>>  drivers/base/auxiliary.c      | 89 +++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/auxiliary_bus.h |  4 ++
>>  2 files changed, 93 insertions(+)
>
> We can't add new functions like this without a real user of it.  Please
> submit that at the same time.

Sure. There is some prep work ongoing in the user. It will get used once
that's done. I'll resubmit once this is ready, assuming the rest is fine.

>
> And are you ok with sharing the id range with multiple aux bus
> implementations?
>

In the initial discussion, a global id was thought to sufficient [2]
It also helps to make things simpler on the user side, which is good I think.

Do you think we've overlooked something ?

[2]: https://lore.kernel.org/linux-clk/c9556de589e289cb1d278d41014791a6.sboyd@kernel.org

>
>> 
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index afa4df4c5a3f371b91d8dd8c4325495d32ad1291..60ca3f0da329fb7f8e69ecdf703b505e7cf5085c 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -385,6 +385,95 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv)
>>  }
>>  EXPORT_SYMBOL_GPL(auxiliary_driver_unregister);
>>  
>> +static DEFINE_IDA(auxiliary_device_ida);
>> +
>> +static void auxiliary_device_release(struct device *dev)
>> +{
>> +	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
>> +
>> +	ida_free(&auxiliary_device_ida, auxdev->id);
>> +	kfree(auxdev);
>> +}
>> +
>> +static struct auxiliary_device *auxiliary_device_create(struct device *dev,
>> +							const char *name,
>> +							void *platform_data)
>> +{
>> +	struct auxiliary_device *auxdev;
>> +	int ret;
>> +
>> +	auxdev = kzalloc(sizeof(*auxdev), GFP_KERNEL);
>> +	if (!auxdev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = ida_alloc(&auxiliary_device_ida, GFP_KERNEL);
>> +	if (ret < 0)
>> +		goto auxdev_free;
>> +
>> +	auxdev->id = ret;
>> +	auxdev->name = name;
>> +	auxdev->dev.parent = dev;
>> +	auxdev->dev.platform_data = platform_data;
>> +	auxdev->dev.release = auxiliary_device_release;
>> +	device_set_of_node_from_dev(&auxdev->dev, dev);
>> +
>> +	ret = auxiliary_device_init(auxdev);
>> +	if (ret)
>> +		goto ida_free;
>> +
>> +	ret = __auxiliary_device_add(auxdev, dev->driver->name);
>> +	if (ret) {
>> +		auxiliary_device_uninit(auxdev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return auxdev;
>> +
>> +ida_free:
>> +	ida_free(&auxiliary_device_ida, auxdev->id);
>> +auxdev_free:
>> +	kfree(auxdev);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +static void auxiliary_device_destroy(void *_auxdev)
>> +{
>> +	struct auxiliary_device *auxdev = _auxdev;
>> +
>> +	auxiliary_device_delete(auxdev);
>> +	auxiliary_device_uninit(auxdev);
>> +}
>> +
>> +/**
>> + * devm_auxiliary_device_create - create a device on the auxiliary bus
>> + * @dev: parent device
>> + * @name: auxiliary bus driver name
>> + * @platform_data: auxiliary bus device platform data
>> + *
>> + * Device managed helper to create an auxiliary bus device.
>> + * The parent device KBUILD_MODNAME is automatically inserted before the
>
> KBUILD_MODNAME doesn't make sense here, as that's the aux bus file.

I'll change to "parent device driver name" 

>
> thanks,
>
> greg k-h

-- 
Jerome

