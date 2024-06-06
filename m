Return-Path: <linux-kernel+bounces-204567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FA08FF099
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2B32828EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23C196C98;
	Thu,  6 Jun 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXSF9Rrq"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4838DE4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687404; cv=none; b=Dfa3T0IrnucPzSvWbwMdmbmIB9vALYkYKOvZvxiZY0aLKaU8USvBkXjbRhSfq9p6cieVTeWKe2J18+8balbDoObjGK9iDXjWX0C1gbiWnmFiADZSk3AwH/JCgBHMpFHx0IQafVBuDCyP7wcIpQ12SJ+m8ygfx1KEiJcP+WTf/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687404; c=relaxed/simple;
	bh=qgaleIyiC/Dlz9oTPpTjcdutMwgXXaSkbU8q9PlWvaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjEY7doOLLqxARZXoOCoz73v/XBPKxpWXad7UThcRlZFfWSBpiYau4XklGLAajodfPRNymmEwoH5ccO384kh6o5yBO5UtbMi+57VxPsDWJUv9Xht1iTxHP6FWOSf95Iu9p58K6sr0d9ulztBJCgN1/Xqg04qscx7A3Qo4rAi998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aXSF9Rrq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42163fa630aso2535685e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717687401; x=1718292201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCY6s9fW0gWKQLqN3TTMf8BsXd+eZx1afj6UUUmr+8c=;
        b=aXSF9Rrqvh7zXDM1knGaz9AECcYEbmmLUb2WFKToGn9yWLRp92Jla6dDaH577XCqcA
         d08h9ySI9oBBS82f7pE+uQcezQDew33wXXn2qAYph/0Wi9Irtu1Im5RXWBLyMBbzkM8a
         qMyRv41UCnGHqvXzHqwiLsRyLgaQKkRfimH9z/xb1KnCnJzdx7sSqX2CKAyvTXp/E4Mb
         pbQGgQTU1whuvv5IGjHCk2rFZsSuWydiSyVHZmcr9CkFE71YsgD0Yuzd/ue+3Qy3h08u
         0weSX7NghzHIBlm2MleQwvMiDAgoCS4YcaNFpQ8LyIkGfT+8GRDSM/CjjjpqVo9OoFLC
         6dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717687401; x=1718292201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCY6s9fW0gWKQLqN3TTMf8BsXd+eZx1afj6UUUmr+8c=;
        b=ntRveuFRgNh9io1sLULCiwwEc/gAzx+aqm3BDSSGK0sGD+QXmaGGVZaJdG9gs2rO3Q
         a6qKzPKZt3pODXdWw+HYSN6zITuT3WtEkrr7qTLXWUa8g8dnnYi8HOWEFXnYfB0w6N52
         rRxXeBBCY9PZn3auJ1dhuyiJo9CUheDIXRespxdL5Ci9Q6ylCxpCyxTUsf68+C6e/V/Y
         5FR0fTIAvhQttjwKNwidfAmEu/BDT0nW2ENmGIiCIqTOfLhZIhyCk7C68vagnb4jRb6S
         YVo9/lsZqc3vdSUeI7QVxWdbHHbjKzMZy0cXR74uC3syCnTGEsPoCOg51tsiWAGyemW3
         U8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCQ1gnMvTfCGZn5G/YioTq3DnOSZkthHuwwQmFpSxjayooWq5jLZ20+4Y989Gzb2okCS+8htfAUP2PWVOjQZdbNveh6z+GAIuVgupd
X-Gm-Message-State: AOJu0YxBvHJ1nM4KGeAKDAAFkl+uBio58qiv6CBR36Vn6CLGhb0zgyJv
	0t0OYaH5TBSuRziWAvnGNIRpjDjXtTm1pKxmBK3oDMopgumlx6fEG+/1KcaD/SA=
X-Google-Smtp-Source: AGHT+IF7OJ/jSCXoSU5VCyNfFS0KK2fi2pmZMBth4IB/zOOHZphRC7deMHklLE+sq7AJJGkFQWjcFA==
X-Received: by 2002:adf:e781:0:b0:357:4c8f:ef8 with SMTP id ffacd0b85a97d-35e8ef946eemr4333511f8f.70.1717687400520;
        Thu, 06 Jun 2024 08:23:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f9a9:3740:b905:9995? ([2a05:6e02:1041:c10:f9a9:3740:b905:9995])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35ef5fc169fsm1809458f8f.94.2024.06.06.08.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 08:23:20 -0700 (PDT)
Message-ID: <97c8ab14-f56f-4a25-b036-51679251adf3@linaro.org>
Date: Thu, 6 Jun 2024 17:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] driver core: Add timeout for device shutdown
To: Soumya Khasnis <soumya.khasnis@sony.com>, gregkh@linuxfoundation.org,
 rafael@kernel.org, linux-kernel@vger.kernel.org, festevam@denx.de,
 lee@kernel.org, benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
 ldmldm05@gmail.com, srinavasa.nagaraju@sony.com
Cc: Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
 keita.aihara@sony.com, masaya.takahashi@sony.com
References: <20240606085003.GA118950@sony.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240606085003.GA118950@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2024 10:50, Soumya Khasnis wrote:
> The device shutdown callbacks invoked during shutdown/reboot
> are prone to errors depending on the device state or mishandling
> by one or more driver. In order to prevent a device hang in such
> scenarios, we bail out after a timeout while dumping a meaningful
> call trace of the shutdown callback to kernel logs, which blocks
> the shutdown or reboot process.

Is that not somehow already achieved by the watchdog mechanism ?

> Signed-off-by: Soumya Khasnis <soumya.khasnis@sony.com>
> Signed-off-by: Srinavasa Nagaraju <Srinavasa.Nagaraju@sony.com>
> ---
> Changes in v3:
>    -fix review comments
>    -updated commit message
> 
>   drivers/base/Kconfig | 18 ++++++++++++++++++
>   drivers/base/base.h  |  8 ++++++++
>   drivers/base/core.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 66 insertions(+)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..342d3f87a404 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -243,3 +243,21 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
>   	  work on.
>   
>   endmenu
> +
> +config DEVICE_SHUTDOWN_TIMEOUT
> +	bool "device shutdown timeout"
> +	default y
> +	help
> +	   Enable timeout for device shutdown. In case of device shutdown is
> +	   broken or device is not responding, system shutdown or restart may hang.
> +	   This timeout handles such situation and triggers emergency_restart or
> +	   machine_power_off. Also dumps call trace of shutdown process.
> +
> +
> +config DEVICE_SHUTDOWN_TIMEOUT_SEC
> +	int "device shutdown timeout in seconds"
> +	range 10 60
> +	default 10

How do you know the shutdown time is between this range?

What about large systems ?

> +	depends on DEVICE_SHUTDOWN_TIMEOUT
> +	help
> +	  sets time for device shutdown timeout in seconds
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 0738ccad08b2..97eea57a8868 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -243,3 +243,11 @@ static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
>   
>   void software_node_notify(struct device *dev);
>   void software_node_notify_remove(struct device *dev);
> +
> +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> +struct device_shutdown_timeout {
> +	struct timer_list timer;
> +	struct task_struct *task;
> +};
> +#define SHUTDOWN_TIMEOUT CONFIG_DEVICE_SHUTDOWN_TIMEOUT_SEC
> +#endif
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b93f3c5716ae..dab455054a80 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -35,6 +35,12 @@
>   #include "base.h"
>   #include "physical_location.h"
>   #include "power/power.h"
> +#include <linux/sched/debug.h>
> +#include <linux/reboot.h>
> +
> +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> +struct device_shutdown_timeout devs_shutdown;
> +#endif
>   
>   /* Device links support. */
>   static LIST_HEAD(deferred_sync);
> @@ -4799,6 +4805,38 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>   }
>   EXPORT_SYMBOL_GPL(device_change_owner);
>   
> +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> +static void device_shutdown_timeout_handler(struct timer_list *t)
> +{
> +	pr_emerg("**** device shutdown timeout ****\n");
> +	show_stack(devs_shutdown.task, NULL, KERN_EMERG);
> +	if (system_state == SYSTEM_RESTART)
> +		emergency_restart();
> +	else
> +		machine_power_off();
> +}

So if one device is misbehaving, all the others shutdown callbacks are 
skipped with emergency halt/reboot ? That is prone to break the system, no?

> +static void device_shutdown_timer_set(void)
> +{
> +	devs_shutdown.task = current;
> +	timer_setup(&devs_shutdown.timer, device_shutdown_timeout_handler, 0);
> +	devs_shutdown.timer.expires = jiffies + SHUTDOWN_TIMEOUT * HZ;
> +	add_timer(&devs_shutdown.timer);
> +}
> +
> +static void device_shutdown_timer_clr(void)
> +{
> +	del_timer(&devs_shutdown.timer);
> +}
> +#else
> +static inline void device_shutdown_timer_set(void)
> +{
> +}
> +static inline void device_shutdown_timer_clr(void)
> +{
> +}
> +#endif
> +
>   /**
>    * device_shutdown - call ->shutdown() on each device to shutdown.
>    */
> @@ -4810,6 +4848,7 @@ void device_shutdown(void)
>   	device_block_probing();
>   
>   	cpufreq_suspend();
> +	device_shutdown_timer_set();
>   
>   	spin_lock(&devices_kset->list_lock);
>   	/*
> @@ -4869,6 +4908,7 @@ void device_shutdown(void)
>   		spin_lock(&devices_kset->list_lock);
>   	}
>   	spin_unlock(&devices_kset->list_lock);
> +	device_shutdown_timer_clr();
>   }
>   
>   /*

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


