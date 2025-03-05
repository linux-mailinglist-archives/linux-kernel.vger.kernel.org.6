Return-Path: <linux-kernel+bounces-545916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F45A4F38F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485501888809
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79FA144D21;
	Wed,  5 Mar 2025 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IUfeufbC"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29E1411DE;
	Wed,  5 Mar 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137899; cv=none; b=X+pvb04pGQMe9zF6X2brp90Hvm9xGG0okL2FcUOxJvWWn9gE9K2t6p5vYf4UsRv9ppx0Ed/jHcTmcubVit1hIvb4WpF5OiT4mCU3FhAL1tL3YoITAKvN2xWGTWTmSp63huQjx91P4/NF1jz1k7QpPiFtSjk8SYGzg9Tjb5Bw79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137899; c=relaxed/simple;
	bh=3Ph3oqRgO+q2RGVMQyfyxHJM7Y30LoLLhU8T3WLPmZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JtBumgxraM+P8WNmrHQoNKMgE47aF/1GpxlEjKgFVgcR9JRpn7YHot1TOqPrR16bdH9n5+KIgW/hv9KxwAGRvRiWmCs2mXDcKt9e9F0sXLzlMWBrFaHVubO1glOiqjI6pAOWPi0STdj24QMwoDejQREDa1sjaTjQQ+u+fjhsqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IUfeufbC; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6MUV6
	8mNmpYgUP6QfuCmMxdeFLghS+WsQcZYfEe/f0A=; b=IUfeufbCBk8UrgwiS676y
	qVYbeXj2O7OqHRGXV7C/MMRuAKd6llGloQw7hQhf0ajuISGjiCOmoBqYufpnyHcS
	vYsfhQq33usAzwHflnG+deNS6+50l1FfIOys1wdqra01Jquu59XieGuO2L92cjfx
	mqlPglMMusv0FGxFtwgnSU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXz3bcp8dnCh_CFw--.52995S2;
	Wed, 05 Mar 2025 09:24:46 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: gregkh@linuxfoundation.org
Cc: limiao870622@163.com,
	limiao@kylinos.cn,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: Re: [PATCH] usb: quirks: Add DELAY_INIT and NO_LPM for Prolific PL2303 Serial Port
Date: Wed,  5 Mar 2025 09:24:44 +0800
Message-Id: <20250305012444.19742-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025030339-morbidly-relax-80c0@gregkh>
References: <2025030339-morbidly-relax-80c0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAXz3bcp8dnCh_CFw--.52995S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr17KF1rCr1DCFWrWFWUtwb_yoW8uFWrpa
	y5XFZagFsrGr1xK34jy3Z7ZFyrCws5CayrKrZxt34j9wn8XrZ3Kr1xGF45GFW7Zr1UGw10
	vw48KF98Ja4kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUJCztUUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/1tbiYBYHzWfHo0+iygAAsY

>On Mon, Mar 03, 2025 at 03:00:47PM +0800, Miao Li wrote:
>> From: Miao Li <limiao@kylinos.cn>
>> 
>> When used on Huawei hisi platforms, Prolific PL2303 Serial Port which
>> the VID:PID is in 067b:2731 might fail to enumerate at boot time and
>> doesn't work well with LPM enabled, combination quirks:
>> USB_QUIRK_DELAY_INIT + USB_QUIRK_NO_LPM
>> fixed the problems.
>> 
>> Signed-off-by: Miao Li <limiao@kylinos.cn>
>> ---
>>  drivers/usb/core/quirks.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
>> index dfcfc142bd5e..8aca5518e003 100644
>> --- a/drivers/usb/core/quirks.c
>> +++ b/drivers/usb/core/quirks.c
>> @@ -341,6 +341,10 @@ static const struct usb_device_id usb_quirk_list[] = {
>>  	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
>>  	  USB_QUIRK_STRING_FETCH_255 },
>>  
>> +	/* Prolific PL2303 Serial Port */
>> +	{ USB_DEVICE(0x067b, 0x2731), .driver_info = USB_QUIRK_DELAY_INIT |
>> +	  USB_QUIRK_NO_LPM },
>
>But this is not the device id for a pl2303 device (or at least one that
>Linux supports), so how was this tested?
>
>And why would this device suddenly stop working?  This chipset has been
>working with Linux for decades now, what is new about this device that
>requires this change?

Hi greg k-h,
we received this patch from Huawei hisi, but without device info,
I use deepseek to search device info for 067b:2731,  
but got the incorrect answer,I'm sorry for making this mistake,
then I visit Prolific official website for device 067b:2731,
https://www.prolific.com.tw/US/ShowProduct.aspx?p_id=326&pcid=153,
067b:2731 is a USB 3.0 Single-LUN Mass Storage Card Reader.
Hisi tested the related device on kirin990/9a0/9000c/9006c platforms
with reboot/suspend/hibernation circles more than two thousand times,
they found the device might fail to enumerate or experiences intermittent disconnections on reboot test,
and this patch has been practically applied to the mentioned platforms to resolve the problems.
I've modified the device description information in patch V2.

Best Regards,
Miao Li


