Return-Path: <linux-kernel+bounces-325664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF30975CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B336B1F23C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CC815098F;
	Wed, 11 Sep 2024 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al02ng36"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25B273FC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092409; cv=none; b=WtGlKcnIWZ8t1Wxu8sdjuygw2JWesKQDGeMcSgaiEvh4amQloVbigeUgqYdg5y8jFakZSuKXZ2+biFrC0z6m/Hi3sv0rJM2sxo+JkrbxMlfTECh0VB4UB8hQu8+OlwoSA1qHYr90Tj0YLsHliUvCFQpbvOc1JcVR7ZmGYNya8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092409; c=relaxed/simple;
	bh=taHVSlys6RyCmQtNIBQ4InHQJ3j6lpc3059nErFV8AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1DyKoleprr8Dsh9Lu3E39Cm1XWqgs4EkbxaQiWoS8/J0PQOTgj+UYErQW6cQdeJYeS7vsVb7SO1nDGxUM/Xjf4lxmilNYFFgJ22Mm1yE+lncoZB/Fu3AWEhzCzJMB0ntvHiXDDYD/OrdTQtfcsupusb3lj4Kep068kERzHUCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al02ng36; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e039f22274so140917b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726092406; x=1726697206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JD0soAaY6dT9lbfuB4e2jVnHF/ZTPreVXVtfXCiRdhc=;
        b=al02ng366wOI++rGjoXvt7TJFFxGo8GzbllHEeBl9CfIbcZMZ7nZG7Z8uLWv2lsIiS
         Y/dCc1YnWMLslt2lcjmpX9oIeNzqvwM9opCw0/MityuPbj4O+Z7xYwgcriAMi7vF0vrR
         lMfaesuSvw1NI4gLUyjKDZOtrIXcvmgmb/qwpPYiwL5V3oJHSiYy29abFX23apHbGgdO
         pSrqST8AYMu7dlz/U3xwno6nxrKEznC/D6IFBnHSoo+T0/naRt3k6YgCgqvEl2x9Lakd
         W93nizoTJHsMVly/Mokpu0tYphUjPin45Kp476E79b2IvzKgIjCeNOekCr1vze3DCY6K
         R5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726092406; x=1726697206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JD0soAaY6dT9lbfuB4e2jVnHF/ZTPreVXVtfXCiRdhc=;
        b=EoGqHAxv/AeiRmPFhLh2MwHkXwD1LJpAJ/0+cFjCmGpXRCkNxC3AL9zdgehRjxTEej
         iJ90KgXQ+3hVZWtbC4lclYjD7o8EpOKaioFc4JDVVx1jStxAprpkZP1bElGb3/3H5wf7
         2nwDqasvE8Jhs9VN242lSv+3bwlN/ga5tTWo8NyNLDY80S+wpN6tBbx+Fi/bBrmlTZkS
         9vgHUE5MlhDHu1B6IGcTWe5o9Lf2GefJuelJoIHJuBto1yYlobBXuS1RLHf9TWpg7KuD
         zjXW5W6IH4Y2PSxaSY4VgkzMcQfdeSftSe7o5ypOUiKHJHiyIXbdas2WmzdNcaj83Qgj
         i9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWOQUREDAyGJcZDSmug+81zvP08TH+UciaWE97ehcKXM7rdb4mCJcNFojiPo8RS1J/s5m/BbezRHkr21nU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1jM3+HKRL+i4ViCcs6a8kIGXewIZf+Spu7axtPF1rokTUw+AJ
	SxKs7fZ5p9pmxn/plEGL0ccbEwhPF9SyBbbVn8zdODQ9m1BxWnxo
X-Google-Smtp-Source: AGHT+IE2WLLYWJNS/ulH2mqh88sxEWyHkmHX1esueqCMNAj7zhZ8eziMOPeeQ8l41s4TY0z5x9rQlA==
X-Received: by 2002:a05:6808:2f0f:b0:3e0:483a:380f with SMTP id 5614622812f47-3e0719edd67mr660126b6e.0.1726092406154;
        Wed, 11 Sep 2024 15:06:46 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e039c12360sm2133809b6e.53.2024.09.11.15.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 15:06:45 -0700 (PDT)
Message-ID: <a232a0aa-0bff-43ed-8eae-37c75dbc2304@gmail.com>
Date: Wed, 11 Sep 2024 17:06:42 -0500
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
 <448875be-59e1-48a5-8a3c-cc45fff196ca@gmail.com>
 <c1f065ec-c544-4191-85b5-e1bb01808183@siemens.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <c1f065ec-c544-4191-85b5-e1bb01808183@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/11/2024 12:51 AM, Jan Kiszka wrote:
> On 11.09.24 02:14, stuart hayes wrote:
>>
>>
>> On 9/8/2024 8:36 AM, Jan Kiszka wrote:
>>> On 22.08.24 22:28, Stuart Hayes wrote:
>>>> Add code to allow asynchronous shutdown of devices, ensuring that each
>>>> device is shut down before its parents & suppliers.
>>>>
>>>> Only devices with drivers that have async_shutdown_enable enabled
>>>> will be
>>>> shut down asynchronously.
>>>>
>>>> This can dramatically reduce system shutdown/reboot time on systems that
>>>> have multiple devices that take many seconds to shut down (like certain
>>>> NVMe drives). On one system tested, the shutdown time went from 11
>>>> minutes
>>>> without this patch to 55 seconds with the patch.
>>>>
>>>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>>>> Signed-off-by: David Jeffery <djeffery@redhat.com>
>>>> ---
>>>>    drivers/base/base.h           |  4 +++
>>>>    drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
>>>>    include/linux/device/driver.h |  2 ++
>>>>    3 files changed, 59 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>>>> index 0b53593372d7..aa5a2bd3f2b8 100644
>>>> --- a/drivers/base/base.h
>>>> +++ b/drivers/base/base.h
>>>> @@ -10,6 +10,7 @@
>>>>     * shared outside of the drivers/base/ directory.
>>>>     *
>>>>     */
>>>> +#include <linux/async.h>
>>>>    #include <linux/notifier.h>
>>>>      /**
>>>> @@ -97,6 +98,8 @@ struct driver_private {
>>>>     *    the device; typically because it depends on another driver
>>>> getting
>>>>     *    probed first.
>>>>     * @async_driver - pointer to device driver awaiting probe via
>>>> async_probe
>>>> + * @shutdown_after - used during device shutdown to ensure correct
>>>> shutdown
>>>> + *    ordering.
>>>>     * @device - pointer back to the struct device that this structure is
>>>>     * associated with.
>>>>     * @dead - This device is currently either in the process of or has
>>>> been
>>>> @@ -114,6 +117,7 @@ struct device_private {
>>>>        struct list_head deferred_probe;
>>>>        const struct device_driver *async_driver;
>>>>        char *deferred_probe_reason;
>>>> +    async_cookie_t shutdown_after;
>>>>        struct device *device;
>>>>        u8 dead:1;
>>>>    };
>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>> index 7e50daa65ca0..dd3652ea56fe 100644
>>>> --- a/drivers/base/core.c
>>>> +++ b/drivers/base/core.c
>>>> @@ -9,6 +9,7 @@
>>>>     */
>>>>      #include <linux/acpi.h>
>>>> +#include <linux/async.h>
>>>>    #include <linux/cpufreq.h>
>>>>    #include <linux/device.h>
>>>>    #include <linux/err.h>
>>>> @@ -3531,6 +3532,7 @@ static int device_private_init(struct device *dev)
>>>>        klist_init(&dev->p->klist_children, klist_children_get,
>>>>               klist_children_put);
>>>>        INIT_LIST_HEAD(&dev->p->deferred_probe);
>>>> +    dev->p->shutdown_after = 0;
>>>>        return 0;
>>>>    }
>>>>    @@ -4781,6 +4783,8 @@ int device_change_owner(struct device *dev,
>>>> kuid_t kuid, kgid_t kgid)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(device_change_owner);
>>>>    +static ASYNC_DOMAIN(sd_domain);
>>>> +
>>>>    static void shutdown_one_device(struct device *dev)
>>>>    {
>>>>        /* hold lock to avoid race with probe/release */
>>>> @@ -4816,12 +4820,34 @@ static void shutdown_one_device(struct device
>>>> *dev)
>>>>            put_device(dev->parent);
>>>>    }
>>>>    +/**
>>>> + * shutdown_one_device_async
>>>> + * @data: the pointer to the struct device to be shutdown
>>>> + * @cookie: not used
>>>> + *
>>>> + * Shuts down one device, after waiting for shutdown_after to complete.
>>>> + * shutdown_after should be set to the cookie of the last child or
>>>> consumer
>>>> + * of this device to be shutdown (if any), or to the cookie of the
>>>> previous
>>>> + * device to be shut down for devices that don't enable asynchronous
>>>> shutdown.
>>>> + */
>>>> +static void shutdown_one_device_async(void *data, async_cookie_t
>>>> cookie)
>>>> +{
>>>> +    struct device *dev = data;
>>>> +
>>>> +    async_synchronize_cookie_domain(dev->p->shutdown_after + 1,
>>>> &sd_domain);
>>>> +
>>>> +    shutdown_one_device(dev);
>>>> +}
>>>> +
>>>>    /**
>>>>     * device_shutdown - call ->shutdown() on each device to shutdown.
>>>>     */
>>>>    void device_shutdown(void)
>>>>    {
>>>>        struct device *dev, *parent;
>>>> +    async_cookie_t cookie = 0;
>>>> +    struct device_link *link;
>>>> +    int idx;
>>>>          wait_for_device_probe();
>>>>        device_block_probing();
>>>> @@ -4852,11 +4878,37 @@ void device_shutdown(void)
>>>>            list_del_init(&dev->kobj.entry);
>>>>            spin_unlock(&devices_kset->list_lock);
>>>>    -        shutdown_one_device(dev);
>>>> +
>>>> +        /*
>>>> +         * Set cookie for devices that will be shut down synchronously
>>>> +         */
>>>> +        if (!dev->driver || !dev->driver->async_shutdown_enable)
>>>> +            dev->p->shutdown_after = cookie;
>>>> +
>>>> +        get_device(dev);
>>>> +        get_device(parent);
>>>> +
>>>> +        cookie = async_schedule_domain(shutdown_one_device_async,
>>>> +                           dev, &sd_domain);
>>>> +        /*
>>>> +         * Ensure parent & suppliers wait for this device to shut down
>>>> +         */
>>>> +        if (parent) {
>>>> +            parent->p->shutdown_after = cookie;
>>>> +            put_device(parent);
>>>> +        }
>>>> +
>>>> +        idx = device_links_read_lock();
>>>> +        list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>>>> +                device_links_read_lock_held())
>>>> +            link->supplier->p->shutdown_after = cookie;
>>>
>>> This will not fly if a supplier registered after its consumer. As we are
>>> walking the list backward, the supplier will now wait for something that
>>> is coming later during shutdown if the affected devices are still doing
>>> this synchronously (as almost all at this stage). This creates a
>>> circular dependency.
>>>
>>> Seems to explain the reboot hang that I'm seeing on an embedded target
>>> with a mailbox dev waiting for a remoteproc dev while the mailbox being
>>> after the remoteproc in the list (thus first on shutting down).
>>>
>>> This resolves the issue for me so far, but I don't think we are done yet:
>>>
>>> list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>>>          device_links_read_lock_held()) {
>>>      if (link->supplier->driver &&
>>>          link->supplier->driver->async_shutdown_enable)
>>>          link->supplier->p->shutdown_after = cookie;
>>> }
>>>
>>> I wonder if overwriting the supplier's shutdown_after unconditionally is
>>> a good idea. A supplier may have multiple consumers - will we overwrite
>>> in the right order then? And why do we now need this ordering when we
>>> were so far shutting down suppliers while consumers were still up?
>>>
>>
>> The devices_kset list should already be in the right order for shutting
>> stuff down--i.e., parents and suppliers should be shutdown later as the
>> device_shutdown loop goes through the devices.
>>
>> With async shutdown this loop still goes the devices_kset list in the same
>> order it did before the patch, so my expectation was that any
>> parents/suppliers
>> would come later in the loop than any children/siblings, and it would
>> update
>> shutdown_after as it went to ensure that each device ended up with the
>> cookie
>> of the last child/consumer that it needed to wait for.
>>
>> However, I missed that the devices_kset list isn't always reordered when a
>> devlink is added and a consumer isn't dependent on the supplier (see
>> device_is_dependent()).  I have a patch would address that, and add a
>> sanity
>> check in case any devices get in the list in the wrong order somehow:
>>
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index b69b82da8837..52d64b419c01 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4832,6 +4832,13 @@ static void shutdown_one_device_async(void *data,
>> async_cookie_t cookie)
>>   {
>>       struct device *dev = data;
>>   
>> +    /*
>> +     * Sanity check to prevent shutdown hang in case a parent or supplier
>> +     * is in devices_kset list in the wrong order
>> +     */
>> +    if (dev->p->shutdown_after > cookie)
>> +        dev->p->shutdown_after = cookie - 1;
>> +
>>       async_synchronize_cookie_domain(dev->p->shutdown_after + 1,
>> &sd_domain);
>>   
>>       shutdown_one_device(dev);
>> @@ -4898,8 +4905,11 @@ void device_shutdown(void)
>>   
>>           idx = device_links_read_lock();
>>           list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>> -                device_links_read_lock_held())
>> +                device_links_read_lock_held()) {
>> +            if (device_link_flag_is_sync_state_only(link->flags))
>> +                continue;
>>               link->supplier->p->shutdown_after = cookie;
>> +        }
>>           device_links_read_unlock(idx);
>>           put_device(dev);
>>   
>>
>> I'll submit this shortly if nobody responds with any issues with this.
>>
>> Thank you!
>>
> 
> This sounds widely reasonable to me, and a quick check confirmed that it
> apparently resolves the issue I was seeing.
> 
> I'm still wondering, though, if overwriting the parent's shutdown_after
> and only checking later on in shutdown_one_device_async is sufficient or
> if it wouldn't be safer to have a check when we write. The fact that
> there could be multiple children for a parent is worrying me.
> 
> Jan
> 

Having multiple children isn't a problem.  All of the children will be in
the shutdown loop before the parent, and as each of them is seen, the
parent's shutdown_after will be updated with the cookie of the latest
child to be shut down.  When the parent then does a synchronize_cookie to
wait for that last child, it won't continue until the earlier children have
also shutdown, because synchronize_cookie doesn't just wait for that one
cookie--it waits until the specified cookie is the lowest cookie in
progress, which means all the earlier children are also done shutting down.

>>
>>> Same overwrite question applies to setting shutdown_after in parents.
>>> Don't we rather need a list for shutdown_after, at least once everything
>>> is async?
>>>
>>> This needs to be thought through once more, I guess.
>>>
>>> Jan
>>>
>>>> +        device_links_read_unlock(idx);
>>>> +        put_device(dev);
>>>>              spin_lock(&devices_kset->list_lock);
>>>>        }
>>>>        spin_unlock(&devices_kset->list_lock);
>>>> +    async_synchronize_full_domain(&sd_domain);
>>>>    }
>>>>      /*
>>>> diff --git a/include/linux/device/driver.h
>>>> b/include/linux/device/driver.h
>>>> index 1fc8b68786de..2b6127faaa25 100644
>>>> --- a/include/linux/device/driver.h
>>>> +++ b/include/linux/device/driver.h
>>>> @@ -56,6 +56,7 @@ enum probe_type {
>>>>     * @mod_name:    Used for built-in modules.
>>>>     * @suppress_bind_attrs: Disables bind/unbind via sysfs.
>>>>     * @probe_type:    Type of the probe (synchronous or asynchronous)
>>>> to use.
>>>> + * @async_shutdown_enable: Enables devices to be shutdown
>>>> asynchronously.
>>>>     * @of_match_table: The open firmware table.
>>>>     * @acpi_match_table: The ACPI match table.
>>>>     * @probe:    Called to query the existence of a specific device,
>>>> @@ -102,6 +103,7 @@ struct device_driver {
>>>>          bool suppress_bind_attrs;    /* disables bind/unbind via
>>>> sysfs */
>>>>        enum probe_type probe_type;
>>>> +    bool async_shutdown_enable;
>>>>          const struct of_device_id    *of_match_table;
>>>>        const struct acpi_device_id    *acpi_match_table;
>>>
> 

