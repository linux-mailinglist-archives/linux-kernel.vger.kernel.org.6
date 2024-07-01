Return-Path: <linux-kernel+bounces-236783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAA791E703
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC697B210EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45D616E88C;
	Mon,  1 Jul 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiB/hVX4"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3E16D4F0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856666; cv=none; b=kaLQB6sV78qch8XgZjt6RMSuCoTbmm625j36FJMOcA7fKSbZwmfLOKH8j3QRCruQaFJPvPjl0kRrRbCFyNpBYG6Dh5MLvVxeTTM8ZUmy3iUlk7jNCn+eGc4B2/k1G2+MquLucWF4wX69L+g+by3VBqXUPwEfX+oLdwZYTR9X2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856666; c=relaxed/simple;
	bh=SSh9HCaWvyEmhyXPHgrKUYkleMVbvV4Dm8MXK2e8yZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQrExFCLuO58x0//84rPC5LVR35tTnutIngmY5wKhlJu2gmztIK6UnyAKhmq3pyKfZIkpO05sbbozU3VJ0Am5oVwQ3k8/nu/MEKFZ7SVUy1Z/7xyKKf6A/SjfyPI8ubeny+iMJhYKqhIKAcGhuKmuvXV/MLHXlLeSe4UZTV6lYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiB/hVX4; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-250c0555a63so1638069fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719856664; x=1720461464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iq7LaOoJ929Ne7IIqCNeS+dBDfJFsJTnNAQTkDtHOm0=;
        b=iiB/hVX49V0hpgMsAkOWXCJ2pCJYiPurj6+y6s4qk2LjE3lKL36Ps+C/G66noak/s5
         0bthG2UI9q76ItDVrnLZY0qA1T0lruu1oGVbF0g3CdiLvo+yz8iP8owKZw3aoJ0WxNL3
         uUbYoC1VIXQrHhrj90yNnZZdLl9Ikidq82+lN4hO3fO2v0N/PLfDQAl8AJNe0i6EV8RG
         Jzub6GxEvXX10Y7D9wTbY+n/b/o8jRs5UC9+wY+6vgFsDBgMwXZgNA/LP8SeHWfR8Sx1
         eMdVaj5zP9PY1d+HrxeFIEJl/Bqe1jQ+laqqqd/XDE5vv26ZC6hpDp5iKhYcuUsAC+Uw
         xB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719856664; x=1720461464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq7LaOoJ929Ne7IIqCNeS+dBDfJFsJTnNAQTkDtHOm0=;
        b=Lxf2s0lEshKh168pY+AtQ8G0O0eZaGMclptLWFEdp9Euo4iQ03pSBDc2xhrV8Jz1by
         MLhfmUFdfVQaaEWxx0gioOXYliPnrAPMNROY2DJftfuIBs8YiYHXz7CnswN1ynx7o7PN
         cPK3l3zaaLAWKcug4W7YfG3QlGIjnFwrl47hFt+npO5pBgWb5/1CsCGQrkmP/76mVwZp
         UvUFXbcCpJkv5btGOtkl5RFMbWvsnt1icq3+6rsIyJvIpSSOWCf1dgAl3wDmoadPjmyg
         Hwq91VvMHonDCScWpB/0o5TnEeTqa99pf9zwEWTLMNHGqiPuFUuufs7uKCd4e3wgRbrI
         1tXQ==
X-Gm-Message-State: AOJu0YxlX95v6YZcHLw1EwHzJImfGe286IAPkZilwchfdEhD69AzJ3VR
	NR5a8wkvCrpBoc5HAkbjS17LzVCJPRW7CcPpEVUdMqipmo81t/3s
X-Google-Smtp-Source: AGHT+IHcImss3ZKjRkkmMrd9b9X4rGySjxBpsw1cPL0M4Fg4bC3ZEpvE4Id7GDKSHjFtpuRmhhUy+g==
X-Received: by 2002:a05:6870:9626:b0:258:42c8:7f69 with SMTP id 586e51a60fabf-25db33f81f1mr5718323fac.23.1719856663587;
        Mon, 01 Jul 2024 10:57:43 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e1f278fsm1829479fac.24.2024.07.01.10.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 10:57:43 -0700 (PDT)
Message-ID: <8a7ae125-883c-4c45-8b89-791066fb5866@gmail.com>
Date: Mon, 1 Jul 2024 12:57:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] driver core: shut down devices asynchronously
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
 <20240626194650.3837-4-stuart.w.hayes@gmail.com>
 <20240627055515.GC15415@lst.de>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240627055515.GC15415@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/27/2024 12:55 AM, Christoph Hellwig wrote:
> On Wed, Jun 26, 2024 at 02:46:49PM -0500, Stuart Hayes wrote:
>> Add code to allow asynchronous shutdown of devices, ensuring that each
>> device is shut down before its parents & suppliers.
>>
>> Add async_shutdown_enable to struct device_driver, and expose it via sysfs.
>> This can be used to view or change driver opt-in to asynchronous shutdown.
>> Only devices with drivers that have async_shutdown_enable enabled will be
>> shut down asynchronously.
>>
>> This can dramatically reduce system shutdown/reboot time on systems that
>> have multiple devices that take many seconds to shut down (like certain
>> NVMe drives). On one system tested, the shutdown time went from 11 minutes
>> without this patch to 55 seconds with the patch.
> 
> We discussed this before, but there is no summary of it and I of course
> forgot the conclusion:
> 
>   - why don't we do this by default?

It is done by default in this version, for devices whose drivers opt-in.

In the previous discussion, you mentioned that you thought "safe" was the
only sensible option (where "safe" was driver opt-in to async shutdown)...
that is the default (and only) option with this version.  Greg K-H also
requested opt-in as well, and suggested that "on" (driver opt-out) could
be removed.

>   - why is it safe to user enable it?

I guess it isn't necessarily safe, if there are any drivers that can't
handle their devices shutting down asynchronously. I thought it would be
nice to be able to enable driver opt-in from user space for testing, before
changing the default setting for the driver.

> 
>> + * @shutdown_after - used during device shutdown to ensure correct shutdown ordering.
> 
> Overly long line.
> 
>> +static ssize_t async_shutdown_enable_store(struct device_driver *drv, const char *buf,
> 
> .. and here.
> 
I can correct these lines. I thought that an 80 character line length limit
was no longer required, and saw another line a few lines above these that was
even longer... and the checkpatch script didn't flag it either.

