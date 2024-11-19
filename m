Return-Path: <linux-kernel+bounces-414826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891E29D2DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1B02840AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D981D1F7B;
	Tue, 19 Nov 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HudPGdt7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5C27473
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040904; cv=none; b=KS521qRSJs7VCPDOJ3LYOW6B6zOcag9gm07ROo7Iwt2hLJ3a/kvqgdBvo+n0iVyG3jd0AQAntmpxi698OHj3xuuXtK7AudbX9zpkeUkrvWGIn25znIFkkO+RdZOCx7raN/zqjuTt+68MS0lgdNRJ8AalczbqHY0L6l/iApf3DLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040904; c=relaxed/simple;
	bh=aOfzgNGS2bXfXTBHiXoHw71WtKV+hVha2BZUF9W18Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7Z61W+TaYM0bCVDr3SJpVrhj4RA6tTY5ER4cLRFdyaeuP3MvxzljpzO0/ENPJJJ0O0dqm45UElbh4lSAS6mgtYT7phMkKOX1MRxlEBZyQnKLRl9Mx5LXxJ6WwXeZXccGT0VXWQrOiuatctwEtRe2v/1OSfTNgV9GrPY14ebMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HudPGdt7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732040901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlrGX4tDOrgFzhWMsaRhM72OmNEQYx5+fxuWv+zUqNg=;
	b=HudPGdt7SG2GVIgjLvGL1nyDFvn9Tx7Bwl0kfmPnessS/hR3Mh/Jk5yk81OMKjYjMQ67ia
	jki5QFOLT2/6R5hwfOw7B82ri/f9OZr02V8DFubWQaGtziXxDB215vrYlZjub8TU7j5Ru4
	VMVKpMxydmnEecQbvKIjqbOXJH6/zow=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-gbuMewXgNWqWkRgLDuiV0A-1; Tue, 19 Nov 2024 13:28:19 -0500
X-MC-Unique: gbuMewXgNWqWkRgLDuiV0A-1
X-Mimecast-MFC-AGG-ID: gbuMewXgNWqWkRgLDuiV0A
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a004bfc1cso65646066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732040898; x=1732645698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlrGX4tDOrgFzhWMsaRhM72OmNEQYx5+fxuWv+zUqNg=;
        b=ovs130AzNjx+YmT+lLUoZ0E8gMDGbH5vfV9dP1yIsU02ZlBDIT2SnqXbo43bZIVmdx
         ZLg0+YAC8GYgmtGNqSFuxgTkdxJGXtP1OxqQKl9rtg2wi3MIbpnD8d99fXqmKr9VGjZx
         ipj0nF4C+pS1ApwzSqKEy5t2uJiXcZBLIVvPRQ4GhAeljAeak762KtwBsfIJom+3P7ib
         XQg4Q34b3WEZ1bNkdLtZSV7Tpk0/WKmy8y5EkrVjXsloqbUxUqbAs7IeoxSDFbpwSM4L
         VUQyt8HmLCWWClsbBeSW5ZCfKjC9MmqziAtoMURti6XBi3z5XCPj7ra/qzDphcxlrzsz
         5E5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcEIign7iJvMOo09Cp3YRuG/kvaXzmejH45KqWirD6zyQBLBMWB1yirY0MLpeU7KpDrQbqQiYIHnqVoaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2zUsd3nMPiSwh8Rpc7FcjA9JpvBwXZPAuqA4TWZ8fKeX2XXB
	XZDDIUE++s8n57OI9zyJmC5dGrYA+FE2w76FRnaFsRwxYtwJNiuJjpY2EfgMB5xRcXpihDk6/MD
	H/e6DfjgbQVfHGglx24QbGLckFakyCP7W64XHQ3PMzAQjpkfJ7UU99GBQlXJAEw==
X-Received: by 2002:a17:906:c143:b0:a99:fa4e:ba97 with SMTP id a640c23a62f3a-aa483525c07mr1568611166b.39.1732040898527;
        Tue, 19 Nov 2024 10:28:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2Z6Wo03xzy7sNQoLmldUCU8doepcqjME8LBeDFcMEwSIqHDCcze0CMkR4SS35dlZsfhlkzw==
X-Received: by 2002:a17:906:c143:b0:a99:fa4e:ba97 with SMTP id a640c23a62f3a-aa483525c07mr1568608866b.39.1732040898116;
        Tue, 19 Nov 2024 10:28:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:2a07:3a01:e7a9:b143:57e6:261b? (2001-1c00-2a07-3a01-e7a9-b143-57e6-261b.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:e7a9:b143:57e6:261b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm676725866b.42.2024.11.19.10.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 10:28:17 -0800 (PST)
Message-ID: <fbe53f25-2cce-4c1d-bace-e7976c4ba20c@redhat.com>
Date: Tue, 19 Nov 2024 19:28:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?B?SWxwbyBK77+9cnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Klara Modin <klarasmodin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danil Rybakov <danilrybakov249@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
References: <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath> <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath> <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com> <Zzt2JNchK9A0pSlZ@goliath>
 <p3lt3psoxenwlvxu6yjpjk4yskrplagj54vk4vxkg6biudghus@go6hpoakvfwh>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <p3lt3psoxenwlvxu6yjpjk4yskrplagj54vk4vxkg6biudghus@go6hpoakvfwh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 19-Nov-24 3:20 AM, Shinichiro Kawasaki wrote:
> On Nov 18, 2024 / 17:15, Daniel Walker (danielwa) wrote:
>> On Mon, Nov 18, 2024 at 05:00:52PM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 18-Nov-24 4:55 PM, Andy Shevchenko wrote:
> [...]
>>>> Hans, there will be no need to fix anything if they implement correct access
>>>> to the GPIO, i.e. via driver and board code with GPIO lookup tables.
>>>
>>> Agreed, still I'm not sure how I feel about us hiding the previously unhidden P2SB.
>>>
>>> OTOH I guess it may have only been unhidden in the BIOS to make the hack they
>>> are using possible in the first place.
>>
>> From a flexibility POV I would suggest if you can not hide it if it's not already
>> hidden by the BIOS that would be better since some company may have a good
>> reason to make a custom driver or to export the pci device to userspace thru
>> UIO. The current situation is you can't make a custom driver if p2sb is enable
>> with this additional patch even if you unhide the device inside the BIOS.
>>
>> In our case it seems like we could use the already existing solution with
>> pinctrl, but others may not be able to do that or may not want to for different
>> reasons.
> 
> I don't have strong opinion about the choice, but I wonder how the p2sb code
> will be if we keep the unhidden P2SB. I created a trial patch below. If the
> device is not hidden, it does not call pci_scan_single_device() and
> pci_stop_and_remove_bus_device(). Instead, it calls pci_get_slot() and
> pci_dev_put(). I don't have the environment which unhides P2SB. Daniel, if you
> have time to afford, please try it out.

Thank you for looking into this.

Daniel can you give this a try? It should fix the regression you are seeing
without needing to rework your code (reworking your code to be cleaner
might still be a good idea though).

Shinichiro, can you turn this into a proper patch without all the debug
prints and maybe follow Andy's suggestion to just make this a separate
function.

Regards,

Hans




> 
> diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
> index 31f38309b389..dec3d43ce929 100644
> --- a/drivers/platform/x86/p2sb.c
> +++ b/drivers/platform/x86/p2sb.c
> @@ -79,29 +79,49 @@ static void p2sb_read_bar0(struct pci_dev *pdev, struct resource *mem)
>  	mem->desc = bar0->desc;
>  }
>  
> -static void p2sb_scan_and_cache_devfn(struct pci_bus *bus, unsigned int devfn)
> +static void p2sb_scan_and_cache_devfn(struct pci_bus *bus, unsigned int devfn,
> +				      bool hidden)
>  {
>  	struct p2sb_res_cache *cache = &p2sb_resources[PCI_FUNC(devfn)];
> -	struct pci_dev *pdev;
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!hidden)
> +		pdev = pci_get_slot(bus, devfn);
> +
> +	pr_info("%s: hidden=%d pci_get_slot=%px\n", __func__, hidden, pdev);
> +
> +	if (!pdev) {
> +		hidden = true;
> +		pdev = pci_scan_single_device(bus, devfn);
> +	}
>  
> -	pdev = pci_scan_single_device(bus, devfn);
>  	if (!pdev)
>  		return;
>  
>  	p2sb_read_bar0(pdev, &cache->res);
> +
> +	pr_info("%s: devfn=%x.%x\n", __func__,
> +		PCI_SLOT(devfn), PCI_FUNC(devfn));
> +	pr_info("%s: %llx-%llx: %lx\n", __func__,
> +		cache->res.start, cache->res.end, cache->res.flags);
> +
>  	cache->bus_dev_id = bus->dev.id;
>  
> -	pci_stop_and_remove_bus_device(pdev);
> +	if (hidden)
> +		pci_stop_and_remove_bus_device(pdev);
> +	else
> +		pci_dev_put(pdev);
>  }
>  
> -static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn)
> +static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn,
> +			       bool hidden)
>  {
>  	/* Scan the P2SB device and cache its BAR0 */
> -	p2sb_scan_and_cache_devfn(bus, devfn);
> +	p2sb_scan_and_cache_devfn(bus, devfn, hidden);
>  
>  	/* On Goldmont p2sb_bar() also gets called for the SPI controller */
>  	if (devfn == P2SB_DEVFN_GOLDMONT)
> -		p2sb_scan_and_cache_devfn(bus, SPI_DEVFN_GOLDMONT);
> +		p2sb_scan_and_cache_devfn(bus, SPI_DEVFN_GOLDMONT, hidden);
>  
>  	if (!p2sb_valid_resource(&p2sb_resources[PCI_FUNC(devfn)].res))
>  		return -ENOENT;
> @@ -127,9 +147,12 @@ static int p2sb_cache_resources(void)
>  	unsigned int devfn_p2sb;
>  	u32 value = P2SBC_HIDE;
>  	struct pci_bus *bus;
> +	bool hidden;
>  	u16 class;
>  	int ret;
>  
> +	pr_info("%s\n", __func__);
> +
>  	/* Get devfn for P2SB device itself */
>  	p2sb_get_devfn(&devfn_p2sb);
>  
> @@ -157,13 +180,15 @@ static int p2sb_cache_resources(void)
>  	 * Unhide the P2SB device here, if needed.
>  	 */
>  	pci_bus_read_config_dword(bus, devfn_p2sb, P2SBC, &value);
> -	if (value & P2SBC_HIDE)
> +	hidden = value & P2SBC_HIDE;
> +	pr_info("%s: P2SBC_HIDE=%u\n", __func__, value & hidden);
> +	if (hidden)
>  		pci_bus_write_config_dword(bus, devfn_p2sb, P2SBC, 0);
>  
> -	ret = p2sb_scan_and_cache(bus, devfn_p2sb);
> +	ret = p2sb_scan_and_cache(bus, devfn_p2sb, hidden);
>  
>  	/* Hide the P2SB device, if it was hidden */
> -	if (value & P2SBC_HIDE)
> +	if (hidden)
>  		pci_bus_write_config_dword(bus, devfn_p2sb, P2SBC, P2SBC_HIDE);
>  
>  	pci_unlock_rescan_remove();
> @@ -189,6 +214,8 @@ int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
>  {
>  	struct p2sb_res_cache *cache;
>  
> +	pr_info("%s\n", __func__);
> +
>  	bus = p2sb_get_bus(bus);
>  	if (!bus)
>  		return -ENODEV;
> @@ -204,6 +231,12 @@ int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
>  		return -ENOENT;
>  
>  	memcpy(mem, &cache->res, sizeof(*mem));
> +
> +	pr_info("%s: devfn=%x.%x\n", __func__,
> +		PCI_SLOT(devfn), PCI_FUNC(devfn));
> +	pr_info("%s: %llx-%llx: %lx\n", __func__,
> +		cache->res.start, cache->res.end, cache->res.flags);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(p2sb_bar);


