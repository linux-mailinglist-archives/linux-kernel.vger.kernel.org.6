Return-Path: <linux-kernel+bounces-203805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1C28FE0AB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479AD1C23F14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490CA13BC26;
	Thu,  6 Jun 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WMtzT8xv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZDnFYgU"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30617C68
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661590; cv=none; b=No5nFzyYBHvSVOg8zFboHOhWYlCjydBhVdlEp4E0gPSxz9NKIhfNnjmSx4VAJ5FJS6OWRDTAowt/hVo2qjzfiKJSR2BPq8I6QXNpaJ4OUOtsV2uFox21AYzvabLMW7FYS/5eKF9jnU71Nfw+1iVLzJBQ6yOoakekVlkWCZ24cWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661590; c=relaxed/simple;
	bh=DOwIjxXIFCa/DQrl0N5I/6WB9HOrHgtlzJXowgPVYZM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=NPvwFT/Z64FAQWEiIeTnHRxSR0jDlpNcX1ay3K2qnZGqgb6eHR35Q6lbEmZM3sjqRdm03G288+Vk8ivZgO1KC6fEORZsYvgG84eOzaRyGPpwrU3xXCf5yVlVvg/c4e9xDwpkdJesRcwbRW/hI9KVylgyYzvSO6HaVYZPB/vZJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WMtzT8xv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZDnFYgU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0BEBC13800F1;
	Thu,  6 Jun 2024 04:13:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 04:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717661587; x=1717747987; bh=ApS+F0AL0L
	gfZs4QA3k3GlB2yIxzLtKfENXLTqHjBsI=; b=WMtzT8xvotuax8NYZgTeIvXB2l
	wA/ZYjxqfwZUGStae0l8UN9bKkJOKlfunQ/G+nAMLsUhi8nbJza8wjuchLIkJcnX
	kzVV0WNfqInkOOEhN8R8zAVTLPI598r2XCgpR7hCA1lobGO/fiCyC29/dQPhNHY7
	Mp+a3lUETwQyIoTAZRUA60PsYXaGEn5f0y+IbqQDbWV7VHBTi11fouOHwxe6o29s
	KYWp150w96Wo1IynErqCH69aOC9pkMKcWIIBGZg2RUh78M0ekKehgsYjSNyqP7B6
	SRo5q4nXs6sbK9/8sed06Xb8kbVFGcv+2aDKj49QfEhNSPFKAqmT27oJkwcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717661587; x=1717747987; bh=ApS+F0AL0LgfZs4QA3k3GlB2yIxz
	LtKfENXLTqHjBsI=; b=CZDnFYgUzOTciOkV3ngx30DhwFZginMvNE7OigUC8Wps
	RXhQt0JvHD1+YVa6yvLPqmxHzCOVr9vANKrIUxVdxRdCFpbkW/udshuUUUWdNs6L
	hmlb3jRxMQD+eIy39OHpZ8Ba8nTZkn2G93wj7fLNpU9t31eTOFiJ63g6gnuDH5GB
	O0E4Bqb2xqCvT3TUa5L72B0sR6cjmcoMv9jk8cWeIjQXU6qwfmHkTCFlu/EIM1Hf
	OEJ8Vz9dGrj0XEVjsDHi/jio4r1crYD1L7fnBWm6GQOs5GnDZqXlHzCdVHJiSxUr
	36PruQYrZlQ8BLhLk9mvIDJBlO/CxEfByksj0AYMtA==
X-ME-Sender: <xms:km9hZo3EQZrqrJ8rVEA-9pCpuTpsF74es1E8XlVYhL8pkkiqp3M9tg>
    <xme:km9hZjF6iYQzLv0Z5HHAmYrdUCrpyop-GyCSlGB2W6TsWBgzfoN5JsIajDCatY6Qk
    kdf2r7KRsD-UOvyNqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefgudfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvg
X-ME-Proxy: <xmx:km9hZg5l3QzWC3NqjFpIoxBw2bTrIEVdT27UHUjKWjFNZ3Ods10UkQ>
    <xmx:km9hZh0H2vTONecLgw9u4HkmbcW3hzmiXUL-VqJJKK1b_Z8eBAKEyA>
    <xmx:km9hZrHZOBQH17t8_t3yLsM58BBHATrj1oNuZTmATlC1tekywO2W-Q>
    <xmx:km9hZq9S3F2Q7WmnZCQndWA0T6DfcxjqRhp0pqtpkJmf9BtlXq-ucw>
    <xmx:k29hZjC_tHqDYPJjXL9Szrt12wBSaEie5n_DOjzW-7vYupm1CAOtgeV2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 25F2FB6008D; Thu,  6 Jun 2024 04:13:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <acfe6adb-2070-445c-aecc-ec0972355d8a@app.fastmail.com>
In-Reply-To: <20240606061342.2142527-1-zhe.he@windriver.com>
References: <20240606061342.2142527-1-zhe.he@windriver.com>
Date: Thu, 06 Jun 2024 10:12:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "He Zhe" <zhe.he@windriver.com>, "Clemens Ladisch" <clemens@ladisch.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hpet: Support 32-bit userspace
Content-Type: text/plain

On Thu, Jun 6, 2024, at 08:13, He Zhe wrote:
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index d51fc8321d41..025a5905a370 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -269,7 +269,8 @@ hpet_read(struct file *file, char __user *buf, 
> size_t count, loff_t * ppos)
>  	if (!devp->hd_ireqfreq)
>  		return -EIO;
> 
> -	if (count < sizeof(unsigned long))
> +	if ((sizeof(int) != sizeof(long) && count < sizeof(compat_ulong_t)) ||
> +	    (sizeof(int) == sizeof(long) && count < sizeof(unsigned long)))
>  		return -EINVAL;
> 
>  	add_wait_queue(&devp->hd_waitqueue, &wait);
> @@ -294,9 +295,15 @@ hpet_read(struct file *file, char __user *buf, 
> size_t count, loff_t * ppos)
>  		schedule();
>  	}
> 
> -	retval = put_user(data, (unsigned long __user *)buf);
> -	if (!retval)
> -		retval = sizeof(unsigned long);
> +	if (sizeof(int) != sizeof(long) && count == sizeof(compat_ulong_t)) {
> +		retval = put_user(data, (compat_ulong_t __user *)buf);
> +		if (!retval)
> +			retval = sizeof(compat_ulong_t);
> +	} else {
> +		retval = put_user(data, (unsigned long __user *)buf);
> +		if (!retval)
> +			retval = sizeof(unsigned long);
> +	}

This does not look right: you are changing the behavior for
both 32-bit and 64-bit mode, and now choose the output based
on how many bytes userspace asked for. This has at least two
problems:

- if userspace asks for 5 to 7 bytes on a 64-bit kernel,
  it returns 8 bytes, overflowing the provided buffer.
- when 32-bit userspace asks for 8 or more bytes, it
  gets 8 bytes instead of 4.

Instead, you should check in_compat_syscall() to see
which output matches the running task.

> @@ -651,14 +658,23 @@ struct compat_hpet_info {
>  	unsigned short hi_timer;
>  };
> 
> +#define COMPAT_HPET_INFO       _IOR('h', 0x03, struct compat_hpet_info)
> +#define COMPAT_HPET_IRQFREQ    _IOW('h', 0x6, compat_ulong_t)

Right, it looks this was missing from my original change 54066a57c584
("hpet: kill BKL, add compat_ioctl").

COMPAT_HPET_IRQFREQ should probably have a comment about the
command code being wrong.

>  	mutex_lock(&hpet_mutex);
> -	err = hpet_ioctl_common(file->private_data, cmd, arg, &info);
> +	err = hpet_ioctl_common(file->private_data, cmd, (unsigned 
> long)compat_ptr(arg), &info);
>  	mutex_unlock(&hpet_mutex);

While this works on x86, this is not a correct use of
compat_ptr() on architectures that modify the pointer
in compat_ptr(). Since HPET_INFO is the only one that
passes a pointer and that one is handled separately,
you should just drop the compat_ptr() conversion here.

    Arnd

