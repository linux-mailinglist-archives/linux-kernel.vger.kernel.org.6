Return-Path: <linux-kernel+bounces-353500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB69F992EA2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB53B1C22F01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEB21D433B;
	Mon,  7 Oct 2024 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KNzQ4tcX"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E71D1748
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310593; cv=none; b=Ij5MdK/AB4akARRDsl/0gvH/4HYUypLlxIJJ096+QZTw60Z3GLeVsAbnodQBcE8ETpllFD+YVQWbZYtH4mcIn8m32Aac3NfNU6E3ri4SMjRwcu/vbi7Xc6PIugY8I5IeIlt5jKgQ09NwKtHC1+AdWxcjGjj9Au61TwFa8ZTj4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310593; c=relaxed/simple;
	bh=WHTwqV6tDRa6dj7SWK8VezUucQdP1t0l/GdZU3cB/1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pYo40U7S+NPSGQBniv2gVVygGHP4OyVynBjnBF2EcgsOvrnnRdefea0hn0R4TJQ76OWIvVHVCMvt5uew5F4alXwESAzVNMwyyNBl+m0Wwh5eToZDk9dNbc6+Lr8vJibQiMCd0TJyN9MqbXsIFpnbCaVW2xNSGgkFo7PUh0c7elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KNzQ4tcX; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fac63abf63so42526001fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728310589; x=1728915389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cxVbsU1/6PlRbliGY4tsEIOFuRRavVmNqKCjLC4eEs0=;
        b=KNzQ4tcXFZmaZpxfiPsDWrxsSTalmt68/KbvoabZjVw5DAiguniN2RutUecv+POEtq
         n2Nmn81Juiiw8WTl9b4B6OHO7pi5XWZR3Y+wLS1EXeB3H7/vCwKliMAmtsfBQ11zQGLi
         2/mIHKsXAT76IaOORhzDdnPlH44gHRSaaSUb0sCklCH2EssPmMSJPbXqhdsMaHGNjTaf
         rX7Uy1bV474mQxk/KZtJa5XUf87ajaQol3KP+8F0jOqyAHcQynRcUsT/POZ0ArZ3/61B
         m3ELmVVs4VeKDe4TQgfcG1zm5eD+SXTOPR3bpFN5S6RpUW6MtpudotWbhnATC1H39M9A
         g1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310589; x=1728915389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxVbsU1/6PlRbliGY4tsEIOFuRRavVmNqKCjLC4eEs0=;
        b=mRFS9454IZwURG8yrTyTBUyYOnza6U63Ffns4S4j/z9/KR1UGSEsKRhDPp8N9ywkvP
         rDcQshTSF5/nj3m6Vj9v/IUWcmboWOjD4DiRfombq/k5hNLq7iS4TJ4aMZHjM6usN6sQ
         aEVGMsgk6tJ94+HlkaIIfY3UTesC7VqgXh1zahGxQU81I7nPbAngIfhqL6kdxnlAF4+I
         Tk6dVEoqQCg6ccvbIqXk8ynG1TjIVMTdzjR005PBRrXzdHc16ySyh6Ap4cuw5PuCEZVS
         hfs74fdJmXrV3KB6zXG2YFcWE4kfoSI6SS0YM9cAym/omZYgcj4/8YgdoRd/OmhTWp17
         pXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUYXB+ePSMPsv26KsnJN+5KlN9a/pNzJvb8kiH99Ch2/68GTokoEZ4K5bzmIN65R4o3kkjeGUEBp9MNng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYJ2j9Uz+7u/Im1Z4tyrqjtTAm/oD3x4SK+JJJq2yNGoGgAyeT
	99bQyUiGGr3jHkidgbSYqu5VK85Ht1RT7weEAkMuQEPYmNLIqynZ9iK/+oyYwrU=
X-Google-Smtp-Source: AGHT+IEPRUuIot87bqEBFnZBoR54B02LoDCRIyfJ2/1E0D11LEH0v3cn2FItdSgJHKxr3q6YTB5cGA==
X-Received: by 2002:a2e:a99d:0:b0:2f7:58bc:f497 with SMTP id 38308e7fff4ca-2faf3d7380bmr55287811fa.28.1728310588723;
        Mon, 07 Oct 2024 07:16:28 -0700 (PDT)
Received: from ?IPV6:2001:a61:1370:2201:dbf:8c7d:e87d:3baf? ([2001:a61:1370:2201:dbf:8c7d:e87d:3baf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb357sm3204024a12.69.2024.10.07.07.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:16:28 -0700 (PDT)
Message-ID: <b60f922a-5c10-4983-9404-ad18bdd86c67@suse.com>
Date: Mon, 7 Oct 2024 16:16:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_register_dev (2)
To: syzbot <syzbot+a194ded97ce38690073f@syzkaller.appspotmail.com>,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6703c076.050a0220.49194.0505.GAE@google.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <6703c076.050a0220.49194.0505.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07.10.24 13:05, syzbot wrote:

> INFO: task kworker/1:0:25 blocked for more than 144 seconds.
>        Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:0     state:D stack:20416 pid:25    tgid:25    ppid:2      flags:0x00004000
> Workqueue: pm pm_runtime_work
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:5315 [inline]
>   __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
>   __schedule_loop kernel/sched/core.c:6752 [inline]
>   schedule+0x14b/0x320 kernel/sched/core.c:6767
>   usb_poison_urb+0x1bc/0x2e0 drivers/usb/core/urb.c:763

This points to a bug in the HCD.
usb_poison_urb() is guaranteed to make progress.

>   poison_urbs drivers/usb/class/cdc-wdm.c:342 [inline]
>   wdm_suspend+0x174/0x380 drivers/usb/class/cdc-wdm.c:1271
>   usb_suspend_interface drivers/usb/core/driver.c:1328 [inline]
>   usb_suspend_both+0x2a5/0x1140 drivers/usb/core/driver.c:1433
>   usb_runtime_suspend+0x59/0x100 drivers/usb/core/driver.c:1968

What HC is used for these tests?

	Regards
		Oliver


