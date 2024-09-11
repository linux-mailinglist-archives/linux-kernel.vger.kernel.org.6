Return-Path: <linux-kernel+bounces-324043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE7B97472D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F402E1F26E47
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3310F2;
	Wed, 11 Sep 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFbzi2+w"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05981161
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726013693; cv=none; b=nrQx3OiQLTISs2KHhMO1Wg4R2RilXIibd0mvIu23AobmJy6HKFZZwDCTlF5sYGv/s7g3mvC73oZTY4MaxOxeenRzas5XxQbXjozMA1/vOmzMfbSKDCRf1Ju4SGhqBwJLMnllDEFKOHTF5Z8kXlLX/q2Iq0sbfE146s4UdEQhcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726013693; c=relaxed/simple;
	bh=k2W3pbCFkRPtbmMvvfiwbMjjv8QC6SpajFpKUkF/EcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTUoV4WPjCa2WlhZ+NXoPg+rsMuvSx0cz6NUHsXdqu8NH035f/eYVbVu2AGvU+TZoUrCsxWmD4XpODqAKaDh9uj73Xy7Sb0ZHhbCpqrh9HtzUqoeeVwJXXl68g9pSPzyBD81gG4E70GBs9/FJNguy2weGHWDA5EWqvvJK4zP1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFbzi2+w; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e1ba05bf73so2093248eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726013691; x=1726618491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7hVWeUvUoQr1iC6yAkTUjAfhiUW0kH/T+xrk2Ax6NQ=;
        b=cFbzi2+wRNHHfK8RpqAzMbg+RksjVWadjLF8VP1EOrby1IhDYYg24ewQJeU/bKyG5S
         42FdZEmHhnZbAAfwTDLI3j/Id+xCtvR3ZLg8wOOBzZcfWY5onLyUzRQB0tF+r+qpGihN
         fUGHDaZHHORQXDkWAy7NB/a9jTdPNpgj7ZoM4s8be9hszpIIHrYMWncm+Zx5RVyvNhih
         nMc5xYdnXv1eQd2gayKro0gQKffMduBujvrjPnYlR7jyZmXYtwPVnnNX1pHuh8tr7+B0
         7SXn8Hob5WBobAFLqKgh/H+CPW9DKCOQDYTwzBdu0ceDkJyFbBWcyyRsvM9EapTGZata
         LoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726013691; x=1726618491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7hVWeUvUoQr1iC6yAkTUjAfhiUW0kH/T+xrk2Ax6NQ=;
        b=g+m5Wk3LVTNC1tV6n4UmqBGT289kYfCo4KcpHZe9zD/+uSpXpTzrdwqtaD+3SukPic
         JzNyGIh4+VrScRvxe9jwyH7dMZlpLc3jPo+KfcOQDDrN6m7/LXcQL4pUVhbfBasYdlIa
         sx7qIssKvtgQjz9tvmPxyW7+BKSecGf8otebPmODDxOsHndxlkhSMBjh35V9F3/X3SzP
         NKBQ3rYUV9aCfe9+lVOovPsJXfYE2X1OwgECLUxT0vzmRFG6VC0T2qFWiLv0Wndl+D2F
         aSaM8E4WQEdN8IeRsx5xgFnDQBW0FFAzxB2gZDWhQU5fm/s4leVha8Xm856CZ8WMDhRB
         kRGg==
X-Forwarded-Encrypted: i=1; AJvYcCWPj2IhhNA3+3nGAS47IYgze/4yGM3J+ngLXbEA629zeqSiKrCaBpx7cji5psC3JzM5z0mqIJoXqX1GHjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPelYQrZEr1XE6yYldvr5VEXjiTHgKz3omsKx7liXiv8O9ByoJ
	Cv9Otk/2QQtb1YsyOw26MQqRoxycD275UBLu9UYRdhyctGMLgOl/
X-Google-Smtp-Source: AGHT+IHu/0D49+q66yw8qi6Pm7tYwbhCpFnWHyT7Wd5PtioB86fwZUNf6pgpry+otwJmQxjV4F0vww==
X-Received: by 2002:a05:6820:1e01:b0:5e1:ebf1:816d with SMTP id 006d021491bc7-5e1ebf1859amr1828283eaf.4.1726013690858;
        Tue, 10 Sep 2024 17:14:50 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e1c4e3968dsm1723644eaf.25.2024.09.10.17.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 17:14:50 -0700 (PDT)
Message-ID: <448875be-59e1-48a5-8a3c-cc45fff196ca@gmail.com>
Date: Tue, 10 Sep 2024 19:14:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Nathan Chancellor <nathan@kernel.org>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <83f39f2d-7237-4880-83e3-1c3afc62087d@siemens.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <83f39f2d-7237-4880-83e3-1c3afc62087d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/2024 8:36 AM, Jan Kiszka wrote:
> On 22.08.24 22:28, Stuart Hayes wrote:
>> Add code to allow asynchronous shutdown of devices, ensuring that each
>> device is shut down before its parents & suppliers.
>>
>> Only devices with drivers that have async_shutdown_enable enabled will be
>> shut down asynchronously.
>>
>> This can dramatically reduce system shutdown/reboot time on systems that
>> have multiple devices that take many seconds to shut down (like certain
>> NVMe drives). On one system tested, the shutdown time went from 11 minutes
>> without this patch to 55 seconds with the patch.
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> Signed-off-by: David Jeffery <djeffery@redhat.com>
>> ---
>>   drivers/base/base.h           |  4 +++
>>   drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
>>   include/linux/device/driver.h |  2 ++
>>   3 files changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>> index 0b53593372d7..aa5a2bd3f2b8 100644
>> --- a/drivers/base/base.h
>> +++ b/drivers/base/base.h
>> @@ -10,6 +10,7 @@
>>    * shared outside of the drivers/base/ directory.
>>    *
>>    */
>> +#include <linux/async.h>
>>   #include <linux/notifier.h>
>>   
>>   /**
>> @@ -97,6 +98,8 @@ struct driver_private {
>>    *	the device; typically because it depends on another driver getting
>>    *	probed first.
>>    * @async_driver - pointer to device driver awaiting probe via async_probe
>> + * @shutdown_after - used during device shutdown to ensure correct shutdown
>> + *	ordering.
>>    * @device - pointer back to the struct device that this structure is
>>    * associated with.
>>    * @dead - This device is currently either in the process of or has been
>> @@ -114,6 +117,7 @@ struct device_private {
>>   	struct list_head deferred_probe;
>>   	const struct device_driver *async_driver;
>>   	char *deferred_probe_reason;
>> +	async_cookie_t shutdown_after;
>>   	struct device *device;
>>   	u8 dead:1;
>>   };
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 7e50daa65ca0..dd3652ea56fe 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -9,6 +9,7 @@
>>    */
>>   
>>   #include <linux/acpi.h>
>> +#include <linux/async.h>
>>   #include <linux/cpufreq.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>> @@ -3531,6 +3532,7 @@ static int device_private_init(struct device *dev)
>>   	klist_init(&dev->p->klist_children, klist_children_get,
>>   		   klist_children_put);
>>   	INIT_LIST_HEAD(&dev->p->deferred_probe);
>> +	dev->p->shutdown_after = 0;
>>   	return 0;
>>   }
>>   
>> @@ -4781,6 +4783,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>>   }
>>   EXPORT_SYMBOL_GPL(device_change_owner);
>>   
>> +static ASYNC_DOMAIN(sd_domain);
>> +
>>   static void shutdown_one_device(struct device *dev)
>>   {
>>   	/* hold lock to avoid race with probe/release */
>> @@ -4816,12 +4820,34 @@ static void shutdown_one_device(struct device *dev)
>>   		put_device(dev->parent);
>>   }
>>   
>> +/**
>> + * shutdown_one_device_async
>> + * @data: the pointer to the struct device to be shutdown
>> + * @cookie: not used
>> + *
>> + * Shuts down one device, after waiting for shutdown_after to complete.
>> + * shutdown_after should be set to the cookie of the last child or consumer
>> + * of this device to be shutdown (if any), or to the cookie of the previous
>> + * device to be shut down for devices that don't enable asynchronous shutdown.
>> + */
>> +static void shutdown_one_device_async(void *data, async_cookie_t cookie)
>> +{
>> +	struct device *dev = data;
>> +
>> +	async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
>> +
>> +	shutdown_one_device(dev);
>> +}
>> +
>>   /**
>>    * device_shutdown - call ->shutdown() on each device to shutdown.
>>    */
>>   void device_shutdown(void)
>>   {
>>   	struct device *dev, *parent;
>> +	async_cookie_t cookie = 0;
>> +	struct device_link *link;
>> +	int idx;
>>   
>>   	wait_for_device_probe();
>>   	device_block_probing();
>> @@ -4852,11 +4878,37 @@ void device_shutdown(void)
>>   		list_del_init(&dev->kobj.entry);
>>   		spin_unlock(&devices_kset->list_lock);
>>   
>> -		shutdown_one_device(dev);
>> +
>> +		/*
>> +		 * Set cookie for devices that will be shut down synchronously
>> +		 */
>> +		if (!dev->driver || !dev->driver->async_shutdown_enable)
>> +			dev->p->shutdown_after = cookie;
>> +
>> +		get_device(dev);
>> +		get_device(parent);
>> +
>> +		cookie = async_schedule_domain(shutdown_one_device_async,
>> +					       dev, &sd_domain);
>> +		/*
>> +		 * Ensure parent & suppliers wait for this device to shut down
>> +		 */
>> +		if (parent) {
>> +			parent->p->shutdown_after = cookie;
>> +			put_device(parent);
>> +		}
>> +
>> +		idx = device_links_read_lock();
>> +		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>> +				device_links_read_lock_held())
>> +			link->supplier->p->shutdown_after = cookie;
> 
> This will not fly if a supplier registered after its consumer. As we are
> walking the list backward, the supplier will now wait for something that
> is coming later during shutdown if the affected devices are still doing
> this synchronously (as almost all at this stage). This creates a
> circular dependency.
> 
> Seems to explain the reboot hang that I'm seeing on an embedded target
> with a mailbox dev waiting for a remoteproc dev while the mailbox being
> after the remoteproc in the list (thus first on shutting down).
> 
> This resolves the issue for me so far, but I don't think we are done yet:
> 
> list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> 		device_links_read_lock_held()) {
> 	if (link->supplier->driver &&
> 	    link->supplier->driver->async_shutdown_enable)
> 		link->supplier->p->shutdown_after = cookie;
> }
> 
> I wonder if overwriting the supplier's shutdown_after unconditionally is
> a good idea. A supplier may have multiple consumers - will we overwrite
> in the right order then? And why do we now need this ordering when we
> were so far shutting down suppliers while consumers were still up?
> 

The devices_kset list should already be in the right order for shutting
stuff down--i.e., parents and suppliers should be shutdown later as the
device_shutdown loop goes through the devices.

With async shutdown this loop still goes the devices_kset list in the same
order it did before the patch, so my expectation was that any parents/suppliers
would come later in the loop than any children/siblings, and it would update
shutdown_after as it went to ensure that each device ended up with the cookie
of the last child/consumer that it needed to wait for.

However, I missed that the devices_kset list isn't always reordered when a
devlink is added and a consumer isn't dependent on the supplier (see
device_is_dependent()).  I have a patch would address that, and add a sanity
check in case any devices get in the list in the wrong order somehow:


diff --git a/drivers/base/core.c b/drivers/base/core.c
index b69b82da8837..52d64b419c01 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4832,6 +4832,13 @@ static void shutdown_one_device_async(void *data, async_cookie_t cookie)
  {
  	struct device *dev = data;
  
+	/*
+	 * Sanity check to prevent shutdown hang in case a parent or supplier
+	 * is in devices_kset list in the wrong order
+	 */
+	if (dev->p->shutdown_after > cookie)
+		dev->p->shutdown_after = cookie - 1;
+
  	async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
  
  	shutdown_one_device(dev);
@@ -4898,8 +4905,11 @@ void device_shutdown(void)
  
  		idx = device_links_read_lock();
  		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
-				device_links_read_lock_held())
+				device_links_read_lock_held()) {
+			if (device_link_flag_is_sync_state_only(link->flags))
+				continue;
  			link->supplier->p->shutdown_after = cookie;
+		}
  		device_links_read_unlock(idx);
  		put_device(dev);
  

I'll submit this shortly if nobody responds with any issues with this.

Thank you!


> Same overwrite question applies to setting shutdown_after in parents.
> Don't we rather need a list for shutdown_after, at least once everything
> is async?
> 
> This needs to be thought through once more, I guess.
> 
> Jan
> 
>> +		device_links_read_unlock(idx);
>> +		put_device(dev);
>>   
>>   		spin_lock(&devices_kset->list_lock);
>>   	}
>>   	spin_unlock(&devices_kset->list_lock);
>> +	async_synchronize_full_domain(&sd_domain);
>>   }
>>   
>>   /*
>> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
>> index 1fc8b68786de..2b6127faaa25 100644
>> --- a/include/linux/device/driver.h
>> +++ b/include/linux/device/driver.h
>> @@ -56,6 +56,7 @@ enum probe_type {
>>    * @mod_name:	Used for built-in modules.
>>    * @suppress_bind_attrs: Disables bind/unbind via sysfs.
>>    * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
>> + * @async_shutdown_enable: Enables devices to be shutdown asynchronously.
>>    * @of_match_table: The open firmware table.
>>    * @acpi_match_table: The ACPI match table.
>>    * @probe:	Called to query the existence of a specific device,
>> @@ -102,6 +103,7 @@ struct device_driver {
>>   
>>   	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
>>   	enum probe_type probe_type;
>> +	bool async_shutdown_enable;
>>   
>>   	const struct of_device_id	*of_match_table;
>>   	const struct acpi_device_id	*acpi_match_table;
> 

