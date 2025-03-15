Return-Path: <linux-kernel+bounces-562720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00301A631C4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 19:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0747A704B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C12F205ADC;
	Sat, 15 Mar 2025 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="b/voBN2I"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEA205514
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064046; cv=none; b=HE5fhXs8tDIkCMHCDels6IDicEDoXvHrAzgczUGf36MKrfP7Kq2LPOH4VYk0Pue4+3GPYyVAC8JQz8yJdQ1VLD5IEJGGuy1TFJIRRjCFdhqs4LXIvsqRWYoVvxUjKKFvTFt3TJzLuoNeZ+kUoV24KL66tiJp2jdFC+1EukhYe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064046; c=relaxed/simple;
	bh=kXYUqQ1WyW2zQjx2kvrrYGLuZIQyX6L7PQ/n5lHB7fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnaJBl4/V/gXrTx7HJ7xtZxJNEu7/JM9V49k21fIExBmjp1wsnWp6BgpBgMS8z7OVPNk0vyxF7Y2sOzcj54FCJ/e1KcGF3IMARxpvrC5cjm/Qi7mdZIsY1uq81rjwGXxIbn0Mr86QLxneWvDKNijFOvahXZGUYo7L5XRwC9VnhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=b/voBN2I; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c56a3def84so314435285a.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1742064043; x=1742668843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s87parI80M4+i1I+85i5e9n1/c46r0tZ/M47p6g2MOY=;
        b=b/voBN2IhiRsfxAc9r6VK9U7BA7Jflby0MRIdyE+REdhkMoVsrv9NFKhMf+wOypXIt
         pNktBqmDicAU79BhAKxY6BeOUxX4JgO1+dASdwLimmmbeNuU99q31Moh4SZf5aRcDqb2
         G6I/PUYoa1J0XIsqQTsVZjPvuXdWsFH6hkvSMNaVcl/W3EoSJvtixgtU0co8AZAPpH6u
         0u5LXgCtWdYt7PCxBqEe+1j9BxJUEzL1wgF0OtTrYnfheG2zLWSLLsbJI5njz0eHLc4R
         L/pifGIBjmBGpMio/IJR5d948an6vMCzRl6tPYoSSbgLJNKis1gGsHXDj6DibVPXWHfq
         Q4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742064043; x=1742668843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s87parI80M4+i1I+85i5e9n1/c46r0tZ/M47p6g2MOY=;
        b=wyqNu9S4s1oBSmQHUgx8925geABFhXzFSFOMo1IEN0NyE/vJuXx/XOmV7geHZ8w93e
         XCVXS+RER3WS27ygRk9vP/NGgGkDSDXY+dZ+3isya7HIiK8CjxuU021GToOmVmc9/7m0
         9kXxZKHU7yNjmMkY++QdRkmS99zW4HTjq47nJzo7b9MPhXxEDnxlvUA497hlG4E2Y4O7
         FXthMx2nZnkUNqW5swkEBJzjgdi3QohcmX5R4wpSzNYtcx/Z/oAsltZmiRrQI5fyNGcU
         U5icjmPYm0C/8TmbWYKI9ArKHse4zHSKSB+Ugkb52Y8dypqDi+WiIwSIdZVre7MXTLvs
         tGuA==
X-Forwarded-Encrypted: i=1; AJvYcCWszdGFRxeDH1SdVEGDfBkga3hk385QxRAEIb6nXoxhlcy+tIwOi8/3KeibcG4j8VRxxx2vvuayC3Vz9Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRYTwsumxzijAOaVMNT2uvUDCdZCn6/X6T/uCD2ATZIjBjdW2g
	Vn9La98wRFk7L4Ls8fiea4yY1VSxOejZoM3OOkijCZjiqmYso1Fw3l7V7UYapGxYdSlB/K5k4VA
	=
X-Gm-Gg: ASbGncvoURWaxQUwaxHk09no6x8IhEo2dVw/BZ0w3NUo6ZH+akJI0iWWaV1SZu6FS67
	8WAsp/5yyNYorTrqJsUqhOY0T9X+NH7FNxvHDp/Szyaf1E74MjopYcqtteqYGX7pqUzbFODNz2w
	7mq0WQosFuLF5z15m2r/jVWL3bEAKLkmvol/KcoYf8GUIM13UsKrbsPsZ4ejVGz43Bk4h+YDUF6
	name1+4d4X1Fmb4FjDFKiHxftTHY9eEAEXZ4E5uKYZL3sguINNx9ta6Y9WdB42/QosUYexE9i68
	O9lIjfXsho5G5tXz3IFvqX/NowDc7jd0ekr+xj3NrbEEXA==
X-Google-Smtp-Source: AGHT+IE9nyYnvkqK8XAWEi66mN9TwFzGJ4ZRQrIu4DDhkNvkH6fJux44eoq6NYNnTI+td4u4f/WDjA==
X-Received: by 2002:a05:620a:4387:b0:7c0:c469:d651 with SMTP id af79cd13be357-7c57c8f2fafmr968770185a.57.1742064043676;
        Sat, 15 Mar 2025 11:40:43 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::6b3e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c7e26bsm399158685a.41.2025.03.15.11.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 11:40:42 -0700 (PDT)
Date: Sat, 15 Mar 2025 14:40:38 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: daixin_tkzc <daixin_tkzc@163.com>
Cc: Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
	Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [usb-storage] Re:Re:[PATCH] usb: storage: Fix
 `us->iobuf` size for BOT transmission to prevent memory overflow
Message-ID: <6b4fe6ca-e18b-4843-aeaf-224ee01d3067@rowland.harvard.edu>
References: <20250311084111.322351-1-daixin_tkzc@163.com>
 <2b6c4aa7.b165.1958f6b7a3a.Coremail.daixin_tkzc@163.com>
 <814316b6-013b-4735-995d-b6c0c616c71b@rowland.harvard.edu>
 <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com>
 <516c8f89-45f2-4d3f-b1e7-29aecfc8cd3c@rowland.harvard.edu>
 <6e125c5c.2541.195990d2daa.Coremail.daixin_tkzc@163.com>
 <CAA6KcBD=CbW6S8vZ-n2v4BuJfC03vuNPzAG-WD5AN5_mMjgUfw@mail.gmail.com>
 <265533ba.2e97.1959988d8b1.Coremail.daixin_tkzc@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <265533ba.2e97.1959988d8b1.Coremail.daixin_tkzc@163.com>

On Sat, Mar 15, 2025 at 07:20:37PM +0800, daixin_tkzc wrote:
> I'm sorry you may have misunderstood me.
> 
> 
> HCTSIZ register only reflects the transfer size for the Host Channel (between host and device). The dwc_otg manual explains it as follows：
> Non-Scatter/Gather DMA Mode:
> Transfer Size (XferSize)
> For an OUT, this field is the number of data bytes the host sends 
> during the transfer.
> For an IN, this field is the buffer size that the application has 
> Reserved for the transfer. The application is expected to program 
> this field as an integer multiple of the maximum packet size for IN 
> transactions (periodic and non-periodic).

In that case, the dwc_otg driver needs to use a 512-byte bounce buffer.  

The driver must _guarantee_ that no more than 13 bytes will be written 
to the URB's transfer_buffer if the URB's transfer_length is 13.  If the 
hardware cannot provide this guarantee then the driver must work around 
the hardware's deficiencies.  That is how the kernel's USB API is 
designed.

Alan Stern

