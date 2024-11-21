Return-Path: <linux-kernel+bounces-416721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537909D4933
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142C4282DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56D1CACF2;
	Thu, 21 Nov 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4yNPK2i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003182890
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179175; cv=none; b=bgic8tezwVY3xGJ8Jl4NKG4ulF3l3BmamZGVq0ILwF77x7HoYoDBHog8E2S9EO3p+kWPwiVIsvtlufgaDSrSk2/vYLp+qEZ54k8b+wc55zamTOdaFzDUcVnN3EhmaC57lWTv72TeUi/fQCbPe5wRzV+YyrGtEJdDiXPmC0YuJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179175; c=relaxed/simple;
	bh=NRGX8nLWYrM3ltoP7C44QRwGHamZ4XdhvJzKB2gqzBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X5U2IvotEQqShFGb/rNRIgzjYD/Rlgz20JUDVxUHM6C9UFmSYEAHaHJZ+jxgBEkBraIAuPez/xDlildk1UWi3dA4Ymk7/9nc1J2dypQ6rE3emKLC7UD76uqkU5tWOzecMA+07nNVeQ2x+/mtGYwLuXaXSiDA3uI5VUkHM91SyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4yNPK2i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ysxQtuuPsMDFWjUHBsJ/HbQemfY0qYeO4cd2SaJSr6o=;
	b=E4yNPK2i8ExFDQ2978ovewWxe+aXxTtAcQ/7Z3cnqobwvnDbQfK2FnosNYfIs2/KxKANkL
	Z23yZTweu2/sPPY/R9E9owJNL/msj11I64cCK5c9KTnG125aweWr71igSxCLniixoS83US
	PaP9k1/spT5L3J/OASXN6nAW8+CdRoA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-EGZ37IwVPKqrNV_3F-KoFg-1; Thu, 21 Nov 2024 03:52:50 -0500
X-MC-Unique: EGZ37IwVPKqrNV_3F-KoFg-1
X-Mimecast-MFC-AGG-ID: EGZ37IwVPKqrNV_3F-KoFg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3822f550027so335376f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179169; x=1732783969;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysxQtuuPsMDFWjUHBsJ/HbQemfY0qYeO4cd2SaJSr6o=;
        b=NbY3cg9MWvqiVf/48dCdiBbG7agZJ8nV+7/+TlXGgtijeZbwsoTVhKhf8mCMKpi6bS
         X4MzXsbIIA8Ke1FcbLlG4fpEPBgYQUsolerhqXfYwLEz8mOgTTu6/48e5+UW6BRniHB9
         YJjR689JzQMuKD4yAojizGpaz0arNcU+QMxlzK5+7/ttNTapWzx2MSv7H4R2XnWuAqyf
         f97uozcYtj2AZigIT52TBqEFK/AXwBCZ9nYktka4PsWj1lUOZ+h7+lR5ESqUfK2eKbHw
         b5k+y3qddrfRneDgZ+2I2mviZQ+VmnwJIGrCeNQixyEtYt18dQZ46KMIcgKgVOkOcuIg
         /k/w==
X-Gm-Message-State: AOJu0Ywc2tp1C1pzWodVM8mSPYtc8+msl2r+yKUUvrJBkMtx10rG47rd
	3baQy0iYwdIa5B+M0uk9Fv16+YMFwWPB+WBXznN57VrQjQZikuQnUjHID+2LG/TgFEfZBB+Ms8y
	ZctoRmD/18pRDE/gRUb9hw3FQYn5UKNDZVfwbeu4G7NE9M32XsolHFoXT4LMaOw==
X-Gm-Gg: ASbGnctx1p6oKZjRLLAZqKMSrKUwbZv7+XoVSzDFySh0+RtOejdRoQBdusle+El3aen
	EtRFpM0991qatKSckcLw2BwIFmNYXuYIYrr4J1Zh5BgSrH6Uo+0sk5i+/cqd83Yy80+UN9BNuFf
	MUnQs5yobM87UiOUcRGJOCiigM22KW0OOX8waZ1j8MhBWSu/Eh0+xHvbNtrNCr0JdS+5x4oo6iE
	QKjHBGaWmxdLfM95aep3Sr+0xxy1bMQcg0XDwO5KxfORBvbva7PLDnM82kpTlyhSIWvA2Lqr8gZ
	T3cbabWX0DFD274Smdg8yYTeHDxwbAdQ
X-Received: by 2002:a5d:59a3:0:b0:382:41ad:d8d1 with SMTP id ffacd0b85a97d-38254b29189mr4342721f8f.53.1732179168734;
        Thu, 21 Nov 2024 00:52:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmHkyTJQsvPBIeNQ4O0n/PRklEe3/aJpR0EagZekMNQVtDIV70aAaQfYCxqvTRmmw76q/KRg==
X-Received: by 2002:a5d:59a3:0:b0:382:41ad:d8d1 with SMTP id ffacd0b85a97d-38254b29189mr4342706f8f.53.1732179168335;
        Thu, 21 Nov 2024 00:52:48 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490cdf7sm4282202f8f.42.2024.11.21.00.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:52:47 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, robh@kernel.org, arnd@linaro.org
Cc: linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>, Zhipeng
 Wang <zhipeng.wang_1@nxp.com>, Maxime Ripard <mripard@kernel.org>,
 javier@dowhile0.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
In-Reply-To: <20241121071127.y66uoamjmroukjck@vireshk-i7>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
Date: Thu, 21 Nov 2024 09:52:46 +0100
Message-ID: <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Viresh Kumar <viresh.kumar@linaro.org> writes:

Hello Viresh,

> +Rob/Arnd,
>
> On 19-11-24, 12:18, Javier Martinez Canillas wrote:
>> This driver can be built as a module since commit 3b062a086984 ("cpufreq:
>> dt-platdev: Support building as module"), but unfortunately this caused
>> a regression because the cputfreq-dt-platdev.ko module does not autoload.
>> 
>> Usually, this is solved by just using the MODULE_DEVICE_TABLE() macro to
>> export all the device IDs as module aliases. But this driver is special
>> due how matches with devices and decides what platform supports.
>> 
>> There are two of_device_id lists, an allow list that are for CPU devices
>> that always match and a deny list that's for devices that must not match.
>> 
>> The driver registers a cpufreq-dt platform device for all the CPU device
>> nodes that either are in the allow list or contain an operating-points-v2
>> property and are not in the deny list.
>> 
>> For the former just add a MODULE_DEVICE_TABLE(), and for the latter add a
>> module alias. That way the driver would always be autoloaded when needed.
>> 
>> Reported-by: Radu Rendec <rrendec@redhat.com>
>> Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as module")
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> Posting as an RFC because I don't have a platform that uses this driver
>> but I'll let Radu test since he reported by issue.
>> 
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index 2a3e8bd317c9..7ae7c897c249 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -97,6 +97,7 @@ static const struct of_device_id allowlist[] __initconst = {
>>  
>>  	{ }
>>  };
>> +MODULE_DEVICE_TABLE(of, allowlist);
>
> This is fine obviously.
>

Yeah, this part is trivial.

>>  /*
>>   * Machines for which the cpufreq device is *not* created, mostly used for
>> @@ -236,4 +237,16 @@ static int __init cpufreq_dt_platdev_init(void)
>>  }
>>  core_initcall(cpufreq_dt_platdev_init);
>>  MODULE_DESCRIPTION("Generic DT based cpufreq platdev driver");
>> +/*
>> + * The module alias is needed because the driver automatically registers a
>> + * platform device for any CPU device node that has an operating-points-v2
>> + * property and is not in the block list.
>> + *
>> + * For this reason the MODULE_DEVICE_TABLE() macro can only export aliases
>> + * of the devices in the allow list, which means that the driver will not
>> + * autoload for devices whose cpufreq-dt will be registered automatically.
>> + *
>> + * Adding an "of:N*T*Coperating-points-v2" alias is a workaround for this.
>> + */
>> +MODULE_ALIAS("of:N*T*Coperating-points-v2");
>
> How does this work? This will autoload the module for any platform with
> "operating-points-v2" property in the DT ? The driver though works only if the
> property is in the CPU node, while now we will try to load this driver even if a
> non-CPU node has the property now.
>

Will autload the driver for any platform that has a Device Tree node with a
compatible = "operating-points-v2" (assuming that this node will be a phandle
for the "operating-points-v2" property.

For example, in the case of the following DT snippet:

cpus {
        cpu@0 {
                operating-points-v2     = <&cpu0_opp_table>;
        };
};

cpu0_opp_table: opp_table {
        compatible = "operating-points-v2";
...
};

It will autoload if OF finds the opp_table node, but it register the cpufreq-dt
device only if there's a cpu@0 with a "operating-points-v2" property.

Yes, there may be false positives because the autload semantics don't exactly
match the criteria for the driver to "match" but I believe is better to load it
and not use for those cases, than needing the driver and not autoloading it.

> I am not sure what's the best way forward to fix this.
>

I couldn't find another way to solve it, if you have a better idea please let
me know. But IMO we should either workaround like this or revert the commit 
that changed the driver's Kconfig symbol to be tristate.

> Arnd, Rob, any inputs ?
>
>>  MODULE_LICENSE("GPL");
>
> -- 
> viresh
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


