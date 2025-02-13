Return-Path: <linux-kernel+bounces-512571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D2A33AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96ED3188ECE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97F211299;
	Thu, 13 Feb 2025 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YY/SEY+U"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D320D519;
	Thu, 13 Feb 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438067; cv=none; b=sT2Tx8X/wwrO6ycBMglwg1N5zIen3kKsU+CqMzwmQcZJijvn8nmHIuV/31NZaJT/uy/cR7gRxqgj8cs70U/ayA8z+JyDwLYEHt/lsqCQqzmzuJOYOIcdLrvIXDUHBERrEyHM1ca1ax3xRC+S7OjjilQXS3xc6+RjgquDkFz+WRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438067; c=relaxed/simple;
	bh=VH0gOSLT3KcBrr4tY877xERRX7Mw1PDztgwjnNLzI6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIOg9u5tr/7u2/p4GHBCnKT3aKMvVucabDc15i7i+LszKniA1vBXspS2Ee/bYwdBs0OUj5oOTcdp/O5q4VK3EW9xhDgSg3SZ8Ayde8jj5EiLvfIGFiWVMPZAnfTBfwz1Y4sLkobW9vAUiaBYJqSwY02duYpvOWwBQNC5TTaEDgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YY/SEY+U; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=x23ERDFK1yV7btZzekL4kes0FjMOz/c4VclowWcJil4=;
	b=YY/SEY+UNfFd28ydKiF4UpS+W7XesZfxSOEKVVdF4oN50T1hH7Ybv93DzccrUj
	woN4emiO5FTwUcZKo+Pv2AQjSxcfYPKHHUpztxJs4TOljTIyrnGzbWjwFFcB0pwq
	qHEmPfKuAMxCFSQ0fdkoyeLBpAX0SFMFGGhWkjNfE4RmI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCnDqzAt61nAiVyDw--.49436S2;
	Thu, 13 Feb 2025 17:13:37 +0800 (CST)
From: 412574090@163.com
To: sergei.shtylyov@gmail.com
Cc: 412574090@163.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	weiyufeng@kylinos.cn
Subject: Re: [PATCH] usb: fix error while OF and ACPI all config Y
Date: Thu, 13 Feb 2025 17:13:35 +0800
Message-Id: <20250213091335.197011-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <309b356f-a7b8-4f1f-92b7-ed5b144bd039@gmail.com>
References: <309b356f-a7b8-4f1f-92b7-ed5b144bd039@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCnDqzAt61nAiVyDw--.49436S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw17Zry8XrWxGry5WF4xXrb_yoWfCwb_G3
	Wjk397Gry8G34Fkr15KrWF9r13K3WDWrW8AF1qqr93XFWI93WxXwn0qr9Yva17Ww4DCF1D
	AryFyr9F9F45ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUbD5rUUUUUU==
X-CM-SenderInfo: yursklauqziqqrwthudrp/xtbBXwTyAGetsSF7cQAAs5

>> From: weiyufeng <weiyufeng@kylinos.cn>
>> 
>> When both OF and ACPI are configured as Y simultaneously，this may
>> cause error while install os with usb disk，while reading data from
>> the usb disk, the onboard_ hub driver will reinitialize the
>> hub, causing system installation exceptions.
>> 
>> Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
>> ---
>>  drivers/usb/misc/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
>> index 6497c4e81e95..9ffb51191621 100644
>> --- a/drivers/usb/misc/Kconfig
>> +++ b/drivers/usb/misc/Kconfig
>> @@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
>>  
>>  config USB_ONBOARD_DEV
>>  	tristate "Onboard USB device support"
>> -	depends on OF
>> +	depends on (OF && !ACPI)
>
>   I don't think () are needed here.
    Yes, () will be deleted in next version.
--
Thanks, 

weiyufeng


