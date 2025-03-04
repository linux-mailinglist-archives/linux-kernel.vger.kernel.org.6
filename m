Return-Path: <linux-kernel+bounces-543322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B01EA4D443
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AF83A3FAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8B1F5849;
	Tue,  4 Mar 2025 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IHZe2jYJ"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0315A6F073;
	Tue,  4 Mar 2025 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071926; cv=none; b=aML90tRvajCoGUT7TgqhAhKBi7eY+kCljIUGt8NzwVFkJesZn+YSziz0drg43YTrHvc0GiV+sertjeyYmKj8hxmg7SrmaxXVzU9sxG0yLPXaX7pFpJxK9K/OqvV850tceYIgJw/0/gqOdKKgfgfv+CtahcurEoopW9jnS5NtOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071926; c=relaxed/simple;
	bh=m76L6ain9nyK3UEQIpUZw3E7mpLgKtpWpHeRlrXMdpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aX5OUImJAzazOHFJgonjcKnLCfITFB2V006dnWN3qtKaW/dxOfOboqJAtxE/jA3TW85uWCi95012G3wQOYK/z+jIbB+Fj7ck8LRvWFArevC2JjVNVqYTt6lyImXCtbmW6WIfP9gn47Cbh0qB8shN1V2nbKA/ItTpHysLllxOTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IHZe2jYJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=ZUPoFFc6tRgg1Pz7Fi5lQT3Ot0GwMUEq8HX8iEM94ME=;
	b=IHZe2jYJBqUWRINNjtlpUqrtsjjgu7JWoAgiBDzEi113VMBB/mG93GIXtdX4Jw
	scqyWvSK/Gzx1C+Ci3I+WXrqmzyYiwo160rDqM3bVnUAFAoiW8ZtUUpVu2KeFMQT
	CGHoVmqLpTpRiLaL4S2VbFTkjmWWR1uKHb3LbC9BHIA/o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3zyQhpsZnvVEtQQ--.20385S2;
	Tue, 04 Mar 2025 15:05:06 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com
Subject: Re: [PATCH] usb: quirks: Add DELAY_INIT and NO_LPM for Prolific PL2303 Serial Port
Date: Tue,  4 Mar 2025 15:05:04 +0800
Message-Id: <20250304070504.138244-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303070047.153591-1-limiao870622@163.com>
References: <20250303070047.153591-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3zyQhpsZnvVEtQQ--.20385S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUrwZ7UUUUU
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/1tbiEQ0GzWfGYoco9QABsP

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
but got the incorrect answer，I'm sorry for making this mistake，
then I visit Prolific official website for device 067b:2731,
https://www.prolific.com.tw/US/ShowProduct.aspx?p_id=326&pcid=153，
067b:2731 is a  USB 3.0 Single-LUN Mass Storage Card Reader.
Hisi tested the related device on kirin990/9a0/9000c/9006c platforms
with reboot/suspend/hibernation circles more than two thousand times，
they found the device might fail to enumerate or experiences intermittent disconnections on reboot test，
and this patch has been practically applied to the mentioned platforms to resolve the problems.
I've modified the device description information in patch V2.

Best Regards,
Miao Li


