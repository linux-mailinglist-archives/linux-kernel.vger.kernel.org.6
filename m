Return-Path: <linux-kernel+bounces-201216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71568FBB0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC1528904D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D6A14A0AE;
	Tue,  4 Jun 2024 17:57:56 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9CE7E2;
	Tue,  4 Jun 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523876; cv=none; b=Hkv5GatH1iKnEluQcpr8+TI/KfrsnMt60LHFXSDNBG0EdeRM8B72xxKpK17S0ukrnpXcUbpR4V/qTvoMPdSBabRG0PRh4EmUmBzBxdZ2PAqiYIvQALeMXrpUq5jwovHWm4r0dSbDMNn4Crgt/2cB+4Qb8KOaN272qffdNEXH8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523876; c=relaxed/simple;
	bh=VfjsCNv3tPCRb/eFant6jx5dnFmC+uhdZpNm4L/xvcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NAguUevDqTuFklVVSXY42jg5iI0FSFga74rlTvK8onrws1VN0wmOybMfRBvQC/wcUgS8SyuHgKuXygTFCFs+rVWeOT6MOZsV9kog9j75Gc8Hx4GI1EoekVV12GJafQVovN6KsLNcb1nb3W4MTvg7QctkFKG34dMpwzviT1sFA6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 4 Jun
 2024 20:57:50 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 4 Jun 2024
 20:57:49 +0300
Message-ID: <51adbe66-1ba1-428c-a6ea-9341f9adfa04@fintech.ru>
Date: Tue, 4 Jun 2024 10:57:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: atm: cxacru: fix endpoint checking in cxacru_bind()
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>,
	<syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com>
References: <20240528183807.3832-1-n.zhandarovich@fintech.ru>
 <2024060415-cloud-calcium-ca2f@gregkh>
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <2024060415-cloud-calcium-ca2f@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)



On 6/4/24 06:35, Greg Kroah-Hartman wrote:
> On Tue, May 28, 2024 at 11:38:07AM -0700, Nikita Zhandarovich wrote:
>> Syzbot is still reporting quite an old issue [1] that occurs due to
>> incomplete checking of present usb endpoints. As such, wrong
>> endpoints types may be used at urb sumbitting stage which in turn
>> triggers a warning in usb_submit_urb().
>>
>> Fix the issue by verifying that required endpoint types are present
>> for both in and out endpoints, taking into account cmd endpoint type.
>>
>> Unfortunately, this patch has not been tested on real hardware.
>>
>> [1] Syzbot report:
>> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
>> WARNING: CPU: 0 PID: 8667 at drivers/usb/core/urb.c:502 usb_submit_urb+0xed2/0x18a0 drivers/usb/core/urb.c:502
>> Modules linked in:
>> CPU: 0 PID: 8667 Comm: kworker/0:4 Not tainted 5.14.0-rc4-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Workqueue: usb_hub_wq hub_event
>> RIP: 0010:usb_submit_urb+0xed2/0x18a0 drivers/usb/core/urb.c:502
>> ...
>> Call Trace:
>>  cxacru_cm+0x3c0/0x8e0 drivers/usb/atm/cxacru.c:649
>>  cxacru_card_status+0x22/0xd0 drivers/usb/atm/cxacru.c:760
>>  cxacru_bind+0x7ac/0x11a0 drivers/usb/atm/cxacru.c:1209
>>  usbatm_usb_probe+0x321/0x1ae0 drivers/usb/atm/usbatm.c:1055
>>  cxacru_usb_probe+0xdf/0x1e0 drivers/usb/atm/cxacru.c:1363
>>  usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
>>  call_driver_probe drivers/base/dd.c:517 [inline]
>>  really_probe+0x23c/0xcd0 drivers/base/dd.c:595
>>  __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
>>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
>>  __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
>>  bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
>>  __device_attach+0x228/0x4a0 drivers/base/dd.c:965
>>  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
>>  device_add+0xc2f/0x2180 drivers/base/core.c:3354
>>  usb_set_configuration+0x113a/0x1910 drivers/usb/core/message.c:2170
>>  usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
>>  usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
>>
>> Reported-and-tested-by: syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com
>> Fixes: 902ffc3c707c ("USB: cxacru: Use a bulk/int URB to access the command endpoint")
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>> ---
>> P.S. While the driver is orphaned, it might still make sense to
>> suppress the syzbot report, seeing how ancient it is.
>> P.P.S. checkpatch complains about outdated format of debug printing
>> but I decided to keep it in tune with the rest of the driver. 
>>
>>  drivers/usb/atm/cxacru.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
>> index 4ce7cba2b48a..8a8e94a601c6 100644
>> --- a/drivers/usb/atm/cxacru.c
>> +++ b/drivers/usb/atm/cxacru.c
>> @@ -1131,7 +1131,8 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
>>  	struct cxacru_data *instance;
>>  	struct usb_device *usb_dev = interface_to_usbdev(intf);
>>  	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
>> -	int ret;
>> +	struct usb_endpoint_descriptor *in, *out;
>> +	int ret = -1;
> 
> Why initialize this and then write over it?
> 
> Also, -1 is not a valid return value, so even if this was needed, it's
> not correct :(
> 
> 

I agree, that was a mistake on my part. An artifact from WIP-version of
the patch. I should have removed that initialization. Thank you for
bringing that up.

>>  
>>  	/* instance init */
>>  	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
>> @@ -1177,6 +1178,19 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
>>  		goto fail;
>>  	}
>>  
>> +	if (usb_endpoint_xfer_int(&cmd_ep->desc))
>> +		ret = usb_find_common_endpoints(intf->cur_altsetting,
>> +						NULL, NULL, &in, &out);
>> +	else
>> +		ret = usb_find_common_endpoints(intf->cur_altsetting,
>> +						&in, &out, NULL, NULL);
>> +
>> +	if (ret) {
>> +		usb_dbg(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");
> 
> Shouldn't this be an error instead?

I was torn between following the code style established in cxacru_bind()
(and some other functions) where in case of an error usb_dbg() is used
AND doing exactly what you suggested. I agree that using usb_err()
probably makes more sense here.
> 
> thanks,
> 
> greg k-h

I'll send revised patch soon.

Regards,
Nikita

