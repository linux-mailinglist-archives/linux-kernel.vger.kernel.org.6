Return-Path: <linux-kernel+bounces-330341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ACA979CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68111C221E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC72C13D619;
	Mon, 16 Sep 2024 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IN2RQ1bg"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF2F1339B1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475735; cv=none; b=TdLHj6ktrHm8mELhH8Nmf1x/mqwvA4i1KDbkd1RRxMXtAIzh0R3cL0oaE3oRHSp7WQ0b2nsq4l3q/pZi5XtZyAzJ6nvPXAmmshzp8yg8vfZhUG7BxLzpML+XxOZNtfiJdayd0apNpPmPPyO0N0MT5mLrAi5ACbpNKxR9vEMiAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475735; c=relaxed/simple;
	bh=/nwtXF3hLOPB73p62TxSPjaiOvKukeEL3qu6NUtL18Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g20NioM48OrC9Fuv2X82wsVCVjnVQu5/k+wFHEidQ1bMKk+GTQGNR/W7UtW6+/u1YLl7VpYue7dkpinv/ccPhr73C+eXC08MztAQrNJSqjk42hBi7gika/RohAE3QddSJOv74fQC38gL0hrj2xi2m/tbTWQvGPEq/x96nCs4VII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IN2RQ1bg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so2781788f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726475731; x=1727080531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMINKOsmPsHhcKu4v5845p8XqAyVAJIHsx+sTkvYhMI=;
        b=IN2RQ1bgl7MI1CKO66qzoZqA2I5+aRnwy3hoUkCEtnGuvQHZFz4RbEQeSi+T96hFzB
         PdODomd2LYO2R0Flu2vw8rFSBXUENlxgDH7iHIPXfGw7sptKgNyfAOdqOBRWh2x1hiy/
         A6uC5CTRDjjWTo4vn9bZlHekSlMrJ0vjiktYiDFqa4gEmgIkKcr0C637hhBG6Lt9cHtv
         aViplzFsUC6WvPShMNhPcdY7bR/ADhaGdDzJccjhhXbWIaw8uLmFQdzncPiCsBzsLUa5
         LektQuGGAWkR1C+2r9uUjhJWhW+Ifd8iQFiO+i7K7UlScL0XC8ApPLoV8OjKXAW6hPtp
         VvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726475731; x=1727080531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMINKOsmPsHhcKu4v5845p8XqAyVAJIHsx+sTkvYhMI=;
        b=ZMVdELPpmBiSQpF2goNEBEJKNXWw1tT0cWFPy54G9dWYZiFdJQoB8vyVVdAQ/xdKxp
         hMbZUBmOeHPzGHdhjBx5/9wuVS6hgPHrH2I5laWmwhujt6tdTsiTcuXRD9Zsn5HOFTLo
         egwL2iGw60fFZt7Kj7Wy5OMJWgGxjllP0QPhIZFi34wuYyoX1Zb5A0RvbvDn3XHQUr44
         hXqJwx+LUQJEfOZuw6qq/PGdEZeXu164NC8izM/mzRPraok3t+ga+1z8ppldV+a1FSer
         6mO5gTOvz6rK8SVePV/nG99PMVRz8etfnIt+jiy142hwAKOvI9yoJ/FX2JHX1nIa3E9m
         HrMw==
X-Forwarded-Encrypted: i=1; AJvYcCXTGHu5Ypl0TnwM1qHJYICxKXFZrDRn/HULJ2/eYhFEX+JChhzaOFaRdfpptaBSOGtK+BHnrVS9+BIai7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxv6oRhUezAZzuGlzonnnKAC6Od1kqZdrPShJEQgeVj+o9nJ1+
	jJxZX0q75NCMAnYGQ4xcEhlcN/A+Q4+nP6w/pw1qiNrrV1YYD8War6gi11RW0mo=
X-Google-Smtp-Source: AGHT+IE69UyTFKQQkGocKkUovyUk2AzY8YU3o8sLgoMLS2EWGr6fEKXQOQLsjaX1L9CBGh3Eg3PRCA==
X-Received: by 2002:a05:6000:120d:b0:374:cafe:c55f with SMTP id ffacd0b85a97d-378d61e269bmr7882762f8f.20.1726475730509;
        Mon, 16 Sep 2024 01:35:30 -0700 (PDT)
Received: from ?IPV6:2001:a61:13e7:b801:321e:ca35:2127:23e6? ([2001:a61:13e7:b801:321e:ca35:2127:23e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78052efsm6555075f8f.97.2024.09.16.01.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 01:35:30 -0700 (PDT)
Message-ID: <15bc0f3a-5433-43e0-b0b0-8b9c26dec165@suse.com>
Date: Mon, 16 Sep 2024 10:35:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
To: Greg KH <gregkh@linuxfoundation.org>, Jeongjun Park <aha310510@gmail.com>
Cc: colin.i.king@gmail.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240916040629.28750-1-aha310510@gmail.com>
 <2024091648-excusable-unfilled-83de@gregkh>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2024091648-excusable-unfilled-83de@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16.09.24 06:15, Greg KH wrote:
> On Mon, Sep 16, 2024 at 01:06:29PM +0900, Jeongjun Park wrote:
>> Currently, iowarrior_read() does not provide any protection for the
>> iowarrior structure, so the iowarrior structure is vulnerable to data-race.
>>
>> Therefore, I think it is appropriate to protect the structure using
>> mutex_lock in iowarrior_read().
>>
>> Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>> ---
>>   drivers/usb/misc/iowarrior.c | 42 +++++++++++++++++++++++++++---------
>>   1 file changed, 32 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
>> index 6d28467ce352..7f3d37b395c3 100644
>> --- a/drivers/usb/misc/iowarrior.c
>> +++ b/drivers/usb/misc/iowarrior.c
>> @@ -277,28 +277,41 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
>>   	struct iowarrior *dev;
>>   	int read_idx;
>>   	int offset;
>> +	int retval = 0;
>>   
>>   	dev = file->private_data;
>>   
>> +	if (!dev) {
> 
> How can this happen?  How was this tested?

It cannot happen.

[..]
>> +	mutex_lock(&dev->mutex);
> 
> Please use the guard() form here, it makes the change much simpler and
> easier to review and maintain.

That would break the O_NONBLOCK case.

Looking at the code it indeed looks like iowarrior_read() can race
with itself. Strictly speaking it always could happen if a task used
fork() after open(). The driver tries to restrict its usage to one
thread, but I doubt that the logic is functional.

It seems to me the correct fix is something like this:

 From 1627bc3a8e9aae60bdfc85430db2a44283e71a68 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Thu, 12 Sep 2024 12:47:33 +0200
Subject: [PATCH] iowarrior: fix read racing against itself case

In a multithreaded application iowarrior_read() can race against itself.
It needs to take the mutex.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
  drivers/usb/misc/iowarrior.c | 33 ++++++++++++++++++++++++++-------
  1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..3b49d6c7b569 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -277,6 +277,8 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
  	struct iowarrior *dev;
  	int read_idx;
  	int offset;
+	int result;
+	bool nonblock = file->f_flags & O_NONBLOCK;
  
  	dev = file->private_data;
  
@@ -292,14 +294,25 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
  	    && (count != (dev->report_size + 1)))
  		return -EINVAL;
  
+	if (nonblock) {
+		result = mutex_trylock(&dev->mutex);
+		if (!result)
+			return -EAGAIN;
+		result = 0;
+	} else {
+		result = mutex_lock_interruptible(&dev->mutex);
+		if (result < 0)
+			return -EINTR;
+	}
  	/* repeat until no buffer overrun in callback handler occur */
  	do {
  		atomic_set(&dev->overflow_flag, 0);
  		if ((read_idx = read_index(dev)) == -1) {
  			/* queue empty */
-			if (file->f_flags & O_NONBLOCK)
-				return -EAGAIN;
-			else {
+			if (nonblock) {
+				result = -EAGAIN;
+				goto out;
+			} else {
  				//next line will return when there is either new data, or the device is unplugged
  				int r = wait_event_interruptible(dev->read_wait,
  								 (!dev->present
@@ -309,14 +322,17 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
  								  -1));
  				if (r) {
  					//we were interrupted by a signal
-					return -ERESTART;
+					result = -ERESTART;
+					goto out;
  				}
  				if (!dev->present) {
  					//The device was unplugged
-					return -ENODEV;
+					result = -ENODEV;
+					goto out;
  				}
  				if (read_idx == -1) {
  					// Can this happen ???
+					mutex_unlock(&dev->mutex);
  					return 0;
  				}
  			}
@@ -324,13 +340,16 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
  
  		offset = read_idx * (dev->report_size + 1);
  		if (copy_to_user(buffer, dev->read_queue + offset, count)) {
-			return -EFAULT;
+			result = -EFAULT;
+			goto out;
  		}
  	} while (atomic_read(&dev->overflow_flag));
  
  	read_idx = ++read_idx == MAX_INTERRUPT_BUFFER ? 0 : read_idx;
  	atomic_set(&dev->read_idx, read_idx);
-	return count;
+out:
+	mutex_unlock(&dev->mutex);
+	return result < 0 ? result : count;
  }
  
  /*
-- 
2.45.2



