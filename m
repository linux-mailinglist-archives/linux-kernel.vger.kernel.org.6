Return-Path: <linux-kernel+bounces-319061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFB796F732
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7795285B79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D81D1741;
	Fri,  6 Sep 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp4uVLKv"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551D1B3757
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633900; cv=none; b=TQt6R5M5RSt4e1xevICZmf6BBeYRMwhKmWoZIcGyGnhpeuJXtzIwvxoYgKbfYdov8WtmzgWALdVF13PfMVHb1jslfBG8XN6nxuWbZlq99CbVQ15qWQ4kZ8l5kZN0Jk3kOz4ugI5/8ZEVe5gXP+dZKeLPcmYFAIApQBobzzbThzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633900; c=relaxed/simple;
	bh=tjAs7g4JFo1JouP8WkaLodacIptG39PhZzgvCwZWTNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKiGqTSsGDekCmsqucn4DGtKj4zw8eiPTtCzRnDpqfEsok5Nf/LHSF46/l/5YnheQojU9kHxJ4LvtzNZOyJML+wrQhwhKZC8EV8mVG+fL6m06Ajh2t2kqGIWQDfx7cz7Ix91zTMpmapPG5BKvlPVItp0Fcq1YU7cQq9c8rVddIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp4uVLKv; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70f670eb827so996578a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633898; x=1726238698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GyxUOYRk77DlFPakFZdQBB8IksHfOA+7wF/s9YT50NI=;
        b=Zp4uVLKv9zTGdx9xTh1I2DbJwsLrMrDnpBhbc9cio1N7prSluzi8NPISgIBGafBkdG
         dCc71Dav/iXP9mWxHDiKDPly7K7QijlMtGtrP9u8ciclcUb4D2G3crQE0jXz/+CNdO75
         6gYRruIs4tIsdLu9L49n7PVM9gTFRziJus4oy3GQ9Frs9JRf3oFeXK/gIFBKG+zDrm68
         Wk4/HW16hRwisGMrFO8ARBpk57l5M64ErbPsyXV5PJatn9WOpLvQFx4UyEkAOdHU+6xu
         EMPRh7MUHlEqdEERhjLQEXdI/Mk3F7wYtO2tYVWa1QQ9PFfINapWY5pMmGF72LvSKlTB
         vUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633898; x=1726238698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyxUOYRk77DlFPakFZdQBB8IksHfOA+7wF/s9YT50NI=;
        b=dQwKdsq81jEZuK51qA9d7hSMgtn9D4I5hx4UNE3xlrnCr4HH8uMMQGsMcku/h5c8V/
         T015sBquhnQJzXxKFJ4AKHfZYoSHmodcjaRoGwwey7jZm0QUkkZKYo/C4Mqz2Kh+9MCG
         ZC5b/7LlTkJUfabjFJceHgGTh1zEcFjvCM7cJUOSRM9/AS7PIlq9Na84qplcX61TndN+
         L//fODsGEBWWj3JEHVn3r7BA7nnQTd4KdylTv9BHFBwH3sfImiMLteiNOGCK6dL1lthp
         jGP+z7WRjr6/yDG/i7GfRzQiJPunCxZpOzh9RnFKk4bqlTxe7XgASqloC8kEbw9t4QTe
         N11g==
X-Gm-Message-State: AOJu0YyiOK4XZDeDpubvPzpGz0Tne6KpCcZJ6uyMUPz+gF4b1c+3kSKz
	j2VYmcppneacZ40thy34qBaV8IrsEbGjyUx7z8KKHx5iza3CY4V6
X-Google-Smtp-Source: AGHT+IHMQDqhtdJGb9vyXpHdHFvZFVG4lkfcKhyySIkCk4aZ5q39igSbjuHhU/CwGK2TOnT9q/pDDw==
X-Received: by 2002:a05:6830:6c87:b0:710:cce7:5bb8 with SMTP id 46e09a7af769-710cce75effmr723161a34.15.1725633897836;
        Fri, 06 Sep 2024 07:44:57 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f7642579fsm2894273a34.66.2024.09.06.07.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:44:57 -0700 (PDT)
Message-ID: <d4d3ef1f-3f34-40c5-88d5-ed1f35123705@gmail.com>
Date: Fri, 6 Sep 2024 09:44:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <20240905221340.GA2732347@thelio-3990X>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240905221340.GA2732347@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/2024 5:13 PM, Nathan Chancellor wrote:
> Hi Stuart,
> 
> On Thu, Aug 22, 2024 at 03:28:04PM -0500, Stuart Hayes wrote:
>> Add code to allow asynchronous shutdown of devices, ensuring that each
>> device is shut down before its parents & suppliers.
>>
>> Only devices with drivers that have async_shutdown_enable enabled will be
>> shut down asynchronously.
>>
>> This can dramatically reduce system shutdown/reboot time on systems that
>> have multiple devices that take many seconds to shut down (like certain
>> NVMe drives). On one system tested, the shutdown time went from 11 minutes
>> without this patch to 55 seconds with the patch.
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> Signed-off-by: David Jeffery <djeffery@redhat.com>
> 
> I am noticing several QEMU machines hang while shutting down after this
> change as commit 8064952c6504 ("driver core: shut down devices
> asynchronously") in -next. An easy test case due to the size of the
> configuration:
> 
>    $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- mrproper virtconfig Image.gz
> 
>    $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/arm64-rootfs.cpio.zst | zstd -d >rootfs.cpio
> 
>    $ timeout --foreground 3m \
>      qemu-system-aarch64 \
>        -display none \
>        -nodefaults \
>        -cpu max,pauth-impdef=true \
>        -machine virt,gic-version=max,virtualization=true \
>        -append 'console=ttyAMA0 earlycon' \
>        -kernel arch/arm64/boot/Image.gz \
>        -initrd rootfs.cpio \
>        -m 512m \
>        -serial mon:stdio
>    [    0.000000] Linux version 6.11.0-rc4-00022-g8064952c6504 (nathan@thelio-3990X) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT Thu Sep  5 15:02:42 MST 2024
>    ...
>    The system is going down NOW!
>    Sent SIGTERM to all processes
>    Sent SIGKILL to all processes
>    Requesting system poweroff
>    qemu-system-aarch64: terminating on signal 15 from pid 2753792 (timeout)
> 
> At the parent commit, there are the following two prints after
> "Requesting system poweroff" then the machine properly shuts down:
> 
>    [    3.411387] kvm: exiting hardware virtualization
>    [    3.411741] reboot: Power down
> 
> If there is any other information I can provide or patches that I can
> test, I am more than happy to do so.
> 
> Cheers,
> Nathan


Thanks, I'll take a look.

