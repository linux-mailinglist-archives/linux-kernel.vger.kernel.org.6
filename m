Return-Path: <linux-kernel+bounces-326924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39749976E92
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68EEB23999
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC0D1448DC;
	Thu, 12 Sep 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dfi8BGAT"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0C3A1DB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158012; cv=none; b=bjd/R2SY17HDxQF+9Fd2bhvRPb6R/FawSpiHScmCeOdN6LxgoNx6s78fVJiZLoq+agIm8xS09IRSJwamQ8gvYSyh5OK1oA/gesNmrdaa+cG/7jsVvykgB5JAZF05Hb0Bx76Y2irBEu3Bg4tUiBJ/2PGykxwnlXPKvsdfWpm9+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158012; c=relaxed/simple;
	bh=LHDJEmLRoL2bN59BLYZGDznBzTtrOKAaxXkvUvwYTKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZACv9cWYoyJ7Pu2oVGc0qjnFWmbkNLRfAgyCjut24uglOMDW8ANxIQf2VFUysrULo9x0HQgD5ZlGhyhT1BG7Pj9CYt2CXqJsxl3aX32b6cBJIxkvT58uNLuGdhtHx5zWVtwRtwU328bq1NseM3dYFVu9RyH7CNVraHKa6m5wZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dfi8BGAT; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70f645a30dcso615000a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726158008; x=1726762808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3DzjyWHe+KYuHiwnIK8txC0+pHIorBSqWuc7NX4qB8=;
        b=Dfi8BGAT512BekSUHBdw5OtrEl8BdprMzk/VBKsR2oBvwX0/V3QbaDBtUH2wl5ule9
         7xc6zqehlV4e6UZInUhOoxWBGeVh5mZZb00GN9yRf9RI52ooT5AbNODysM8V/3KH+xKv
         E5k1ia9X9OznzlcPtu3SHm6kBY35BVjTNDk4YWquxZ6qSkoG8fzPCnXJyZu3DX3WHGXm
         UdFBi8FvBWUAc8uQF0rAPEtV8uIqU0SVzuYpr8P0GHque0nm+yM2huCLHN+FgYfGqKKc
         QfQ8MjxTyAppBm5eJB7nUB7lgq67aMa1OyC/VEVACwyg0JX26RpU1FlNrlTK2ZeACjsh
         F9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726158008; x=1726762808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3DzjyWHe+KYuHiwnIK8txC0+pHIorBSqWuc7NX4qB8=;
        b=V/JWDzkBuzm8JlD7rhzOmSBEDfcoEMp4e9TAVRZc/pzRgQNyJHCVdENPrMAlcMowy5
         4LbWASqCWwQm5tPZD0N0UHdrT1/21ZjsWGKw4qzQmcJfl+5Ur3pNWSZ5/v5rQOcBmUJr
         H9fypVxrytoqyAvfhU/M5ZZz6sQrQxiTkMGl9VgpwYRgAx9REYSJ+6VGbZu8x9jXrmKP
         m/0goBWY6A3MKoAgdRqRMVsA91gvSZyXVexQDHi8hmAN49DHCrfF2ZqNzD7OJ+scalel
         /vbxGouG0Cn1gSkhK5L+2327jX37TsRdCg3SQg9f4K5yzpoznlZtpuW2h121XZ5Katuf
         EyvA==
X-Forwarded-Encrypted: i=1; AJvYcCXdgSLbyGSAecWBkXIlI4Jh1DJ9ob40yYlLiGwTd3lxws02MawIb5Wd8nJBG6yX6tepAWpGNZJj+mdWWyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLM/RxIAuzStiDTcc4gSuXPUwPcBQBJJOWHr00XCwl+9Plhx4S
	J7q0XMtAvqJjuAaDW+xEA/DbaHMPUL63oMZuafx4fQDE+upWSq2w
X-Google-Smtp-Source: AGHT+IGysuELHgg3OfLGsAwGsKNT+nuiEZGuvh0MVUp5JoZbZ2h+iNnwhYBGFOJN8z2/hdrBjyxDjg==
X-Received: by 2002:a05:6830:6606:b0:710:f797:984b with SMTP id 46e09a7af769-711094c9180mr2533120a34.32.1726158007973;
        Thu, 12 Sep 2024 09:20:07 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9dd6f97sm2742836a34.74.2024.09.12.09.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 09:20:07 -0700 (PDT)
Message-ID: <754401e6-b6a5-4393-ad9b-ffe113e33a72@gmail.com>
Date: Thu, 12 Sep 2024 11:20:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: David Jeffery <djeffery@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <83f39f2d-7237-4880-83e3-1c3afc62087d@siemens.com>
 <448875be-59e1-48a5-8a3c-cc45fff196ca@gmail.com>
 <CA+-xHTEMM09PXgWyKX4h48diUxxGnSSrDowh5Gt=Y+EVhHL-_Q@mail.gmail.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <CA+-xHTEMM09PXgWyKX4h48diUxxGnSSrDowh5Gt=Y+EVhHL-_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/12/2024 9:30 AM, David Jeffery wrote:
> On Tue, Sep 10, 2024 at 8:14 PM stuart hayes <stuart.w.hayes@gmail.com> wrote:
>>
> ...
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index b69b82da8837..52d64b419c01 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4832,6 +4832,13 @@ static void shutdown_one_device_async(void *data, async_cookie_t cookie)
>>    {
>>          struct device *dev = data;
>>
>> +       /*
>> +        * Sanity check to prevent shutdown hang in case a parent or supplier
>> +        * is in devices_kset list in the wrong order
>> +        */
>> +       if (dev->p->shutdown_after > cookie)
>> +               dev->p->shutdown_after = cookie - 1;
>> +
>>          async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
>>
>>          shutdown_one_device(dev);
> 
> While the race window is really small, there is a potential race with
> this fixup. It's possible for the shutdown operation to write a new
> value to shutdown_after in the time between the if check and
> shutdown_after being re-read and used in the
> async_synchronize_cookie_domain call. Such a race would allow a too
> high value to be used.
> 
> Instead, could do something like:
> 
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4833,8 +4833,12 @@ static void shutdown_one_device(struct device *dev)
>   static void shutdown_one_device_async(void *data, async_cookie_t cookie)
>   {
>          struct device *dev = data;
> +       async_cookie_t wait = dev->p->shutdown_after + 1;
> 
> -       async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
> +       if (wait > cookie)
> +               wait = cookie;
> +
> +       async_synchronize_cookie_domain(wait, &sd_domain);
> 
>          shutdown_one_device(dev);
>   }
> 
> This reads the shutdown_after value once and avoids the race window
> where its value being changed on another CPU could still cause a
> potential deadlock.
> 

Good point. Really that sanity check shouldn't be needed at all.  But... maybe it
would be better to just not change the shutdown_after on any device that's
already been scheduled for shutdown... this would work regardless of why the supplier
and consumer devices are in the wrong order on the devices_kset list, and would still
work if supplier/consumer devices don't get reordered for some reason other than
the devlink being sync_state only in the future.  Plus, it's a bit simpler.

How does this look?


diff --git a/drivers/base/base.h b/drivers/base/base.h
index ea18aa70f151..f818a0251bb7 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -105,6 +105,8 @@ struct driver_private {
   * @dead - This device is currently either in the process of or has been
   *	removed from the system. Any asynchronous events scheduled for this
   *	device should exit without taking any action.
+ * @shutdown_scheduled - asynchronous shutdown of the device has already
+ * 	been scheduled
   *
   * Nothing outside of the driver core should ever touch these fields.
   */
@@ -120,6 +122,7 @@ struct device_private {
  	async_cookie_t shutdown_after;
  	struct device *device;
  	u8 dead:1;
+	u8 shutdown_scheduled:1;
  };
  #define to_device_private_parent(obj)	\
  	container_of(obj, struct device_private, knode_parent)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b69b82da8837..bd6bc4a3dc15 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4888,6 +4888,8 @@ void device_shutdown(void)
  
  		cookie = async_schedule_domain(shutdown_one_device_async,
  					       dev, &sd_domain);
+		dev->p->shutdown_scheduled = 1;
+
  		/*
  		 * Ensure parent & suppliers wait for this device to shut down
  		 */
@@ -4898,8 +4900,18 @@ void device_shutdown(void)
  
  		idx = device_links_read_lock();
  		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
-				device_links_read_lock_held())
-			link->supplier->p->shutdown_after = cookie;
+				device_links_read_lock_held()) {
+			/*
+			 * Only update cookie if device shutdown hasn't
+			 * already been scheduled. Some supplier/consumer
+			 * devices (sync_state only) aren't reordered on
+			 * devices_kset list and don't need this, and setting
+			 * this could result in a circular dependency if the
+			 * supplier shutdown has already been scheduled.
+			 */
+			if (!link->supplier->p->shutdown_scheduled)
+				link->supplier->p->shutdown_after = cookie;
+		}
  		device_links_read_unlock(idx);
  		put_device(dev);
  

