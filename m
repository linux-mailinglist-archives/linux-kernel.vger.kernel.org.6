Return-Path: <linux-kernel+bounces-372575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6354A9A4A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 02:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD62228343F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895FF16C850;
	Sat, 19 Oct 2024 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG5DhDY1"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE44160884
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729297626; cv=none; b=ENAgTcdsQ/3jf2UW6n/05h+l2tzaSlZOtHchE2E6g8WXstUDu02Y/rcVgBoUfKnNX4pP34UNQbRIeegKzN6cIneU4QAMri36F7a7kCPSy4ybd/wudMC7TR//7mZhaStkFJcM7HyuHs/45lOML4tN3T18uoDP3HlqK6/ryoguVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729297626; c=relaxed/simple;
	bh=mC8LyQ7/Ic1MxJvGuzEDAsCOFfYxeIZNcLFx4btzmXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPV9b7JR0J0LNtkcfSLzHuW121ocqtjqej3mdi9spRiTt3CZ9uQBDii4ZbQMXf4f+tQkEsXprpTqhvnzLSQedfBeu7ZR4F4guije1E7RyxpqUnl6I1o7YOWBDbViq4iwJB1jlRhG/rzIsAYSrsNWOeGla7ahuXxd9ktk/8eHnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG5DhDY1; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5eb8dd1385aso663315eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729297624; x=1729902424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWuWGHAAelbSJMtiFqn1+UQTsoAFrJ5pUxKEak7CgJU=;
        b=IG5DhDY1r/Yfd3JCDLVyoO6PiOjHhLupw8jmk72FvkoUFXZ0cm9DZKGZmEuRGycxWZ
         X2Kk9rjxISlM82I6It7LoZISzR1kHuxAIKEYGNRPm4vpStxq1/EFbZa833hvOGROnYei
         d4XGckjMQTZNeUADOQbK+sCBHzN17128TFlEGn+4cskrPaGazNpMtN23CQmTNbkP8aIi
         N8F9jaMg8CTNTPtHPCM5tgbPoZsmVexPxECYhV0vZMZ2qhs+7lK76bsPnlFHHElrHy/z
         7lMvARsxEQmpVedFA3fTmpff7po4gwT9z6UyvsHDF3RYNZ8Pa4cY7CxuBjmfHlJ14zDd
         OWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729297624; x=1729902424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWuWGHAAelbSJMtiFqn1+UQTsoAFrJ5pUxKEak7CgJU=;
        b=Y2hyEDmzWDakZj57YF6lua/3xDZnoex0gz1F2yQqcqXArsVHxsj7MMgahBMjqC3AIy
         CGUTkatXzD5OaAygIvdZvJf6kcsmAA0yLY+o3qFGXX5ZpGVZPohijFVuLL+gHR76vkMU
         KOpvnXzPwiAmSYM37ha5/cBZVsOkVOt9AaJcrsMnYdjO+/0Z9L0PFGxryxp/eTZegmgg
         hq9VQmfYS5onOq+206i/UyulAp/Z32ieX0loDiAMn4oD2Pu2KGmw/yDu1zt+lraEAn+C
         Ow5I5JqFUxDd06Gxtr0O5pBFhRBlzsgWGezAUp5sX9Ds8i/oOuS6BQYHX8OH2WgSh4Wq
         hPHA==
X-Forwarded-Encrypted: i=1; AJvYcCUYXIzi++B9Vo9aD+uKj5V3c9kat5+EAx8nF/csb6gRV7Q9QIfdbl2L9lg53Me1IE3i9XDB1Km5nvgkuyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIN04f4LWda3H6BtjF/VCiDxwdmXsHw3XyOVJr1XNdTOe933qZ
	nOqXcVzNyT3PjEV7YzU0zoMQ1ByE1RgKoJsSfanuzU1JFiAEzSWy
X-Google-Smtp-Source: AGHT+IESX5Hsh4rByt9TT7qRj6nBeyiiqVeM++X9wRFAXHn7aXUasUZUsEjtFPx2JIwhR54muwYLPA==
X-Received: by 2002:a05:6808:bd5:b0:3e6:264:2988 with SMTP id 5614622812f47-3e602d8c1d2mr4171867b6e.35.1729297624025;
        Fri, 18 Oct 2024 17:27:04 -0700 (PDT)
Received: from [192.168.1.22] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e602a47df4sm621930b6e.40.2024.10.18.17.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 17:27:03 -0700 (PDT)
Message-ID: <7ec51cc8-b64f-4956-b4e6-4b67f1a8fa76@gmail.com>
Date: Fri, 18 Oct 2024 19:27:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] shut down devices asynchronously
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lukas Wunner <lukas@wunner.de>
Cc: Michael Kelley <mhklinux@outlook.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, David Jeffery <djeffery@redhat.com>,
 Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nathan Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>,
 Bert Karwatzki <spasswolf@web.de>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
 <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>
 <2024101809-granola-coat-9a1d@gregkh> <ZxInC1U7WiB7FNkJ@wunner.de>
 <2024101808-subscribe-unwrapped-ee3d@gregkh>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <2024101808-subscribe-unwrapped-ee3d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/2024 4:37 AM, Greg Kroah-Hartman wrote:
> On Fri, Oct 18, 2024 at 11:14:51AM +0200, Lukas Wunner wrote:
>> On Fri, Oct 18, 2024 at 07:49:51AM +0200, Greg Kroah-Hartman wrote:
>>> On Fri, Oct 18, 2024 at 03:26:05AM +0000, Michael Kelley wrote:
>>>> In the process, the workqueue code spins up additional worker threads
>>>> to handle the load.  On the Hyper-V VM, 210 to 230 new kernel
>>>> threads are created during device_shutdown(), depending on the
>>>> timing. On the Pi 5, 253 are created. The max for this workqueue is
>>>> WQ_DFL_ACTIVE (256).
>> [...]
>>> I don't think we can put this type of load on all systems just to handle
>>> one specific type of "bad" hardware that takes long periods of time to
>>> shutdown, sorry.
>>
>> Parallelizing shutdown means shorter reboot times, less downtime,
>> less cost for CSPs.
> 
> For some systems, yes, but as have been seen here, it comes at the
> offset of a huge CPU load at shutdown, with sometimes longer reboot
> times.
> 
>> Modern servers (e.g. Sierra Forest with 288 cores) should handle
>> this load easily and may see significant benefits from parallelization.
> 
> "may see", can you test this?
> 
>> Perhaps a solution is to cap async shutdown based on the number of cores,
>> but always use async for certain device classes (e.g. nvme_subsys_class)?
> 
> Maybe, but as-is, we can't take the changes this way, sorry.  That is a
> regression from the situation of working hardware that many people have.
> 
> thanks,
> 
> greg k-h

Thank you both for your time and effort considering this.  It didn't 
occur to me that an extra few 10s of milliseconds (or maxing out the 
async workqueue) would be an issue.

To answer your earlier question (Michael), there shouldn't be a 
possibility of deadlock regardless of the number of devices. While the 
device shutdowns are scheduled on a workqueue rather than run in a loop, 
they are still scheduled in the same order as they are without this 
patch, any any device that is scheduled for shutdown should never have 
to wait for device that hasn't yet been scheduled. So even if only one 
device shutdown could be scheduled at a time, it should still work 
without deadlocking--it just wouldn't be able to do shutdowns in parallel.

And I believe there is still a benefit to having async shutdown enabled 
even with one core. The NVMe shutdowns that take a while involve waiting 
for drives to finish commands, so they are mostly just sleeping. 
Workqueues will schedule another worker if one worker sleeps, so even a 
single core system should be able to get a number of NVMe drives started 
on their shutdowns in parallel.

I'll see what I can to do limit the amount of stuff that gets put on the
workqueue, though.  I can likely limit it to just the asynchronous 
device shutdowns (NVMe shutdowns), plus any devices that have to wait 
for them (i.e., any devices of which they are dependents or consumers).





