Return-Path: <linux-kernel+bounces-373864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537839A5DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7752C1C21830
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886AA1E1A3F;
	Mon, 21 Oct 2024 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PTp2c7It"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C21E1A1F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497898; cv=none; b=Bg/qNzciUyB4JxMHo7n9MwjGlu05EsH76SZm0zBDStIfugHocRHpHR2hJQpwYU4NaWlSxOlUqHjs1W/VGXRnvcADICl/xs1nTbC7qdU+9zP4gV0wv9B0bjfiyMk2SFtwysOG5mJx1gOSn67Glc5qnmIIxbbpzIDJJvuRj8+JhQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497898; c=relaxed/simple;
	bh=s5V2nRqdClra2IYN9VkVoloRb2rboxPyLIYaBTGoRyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oKJWE2mWKq28xBBPf+6GLrujVUjYYZkA9eQSAVCaXDVF2hpynfUlPQSY6l0HcEfFkwzC5OlmtwkzkLUjuHecS7ENuj8zS/wuqNZn6NuIcNuLpX9rYz0/bQmrYD5ZvDyU3soBy2wZQJ3iazCM5pSBQfK0vkZtK1cYpGXx5fSeywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PTp2c7It; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb561f273eso39677531fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729497894; x=1730102694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCxbIdeUZnMRvGceySlkhLwCVSlS+VQaiyZ6j0nLBAY=;
        b=PTp2c7ItQqpt4J7mgBJ0Y9Y/gi9izYB2xDzERAFqJXk8SKo59ryvfCOTtmvLip552K
         GMdZe1wdPJ8dDK7i0CIveGGNvyAqBHfmsXKNk+kHBa0/kJsQ2EODd8mTwxSMfmzjPxR4
         QQ+6lN7ui5C1QzdDPfEByYsOtRV2DXNbKBKwYKBM1Idrp2gaEbbZB7V7CQmSW/gMEI5I
         Uo/xTyPy9SB3CIY8Nxc1iFAVrgWYFnMehKmw9FYlE9YI38RI8be8xrvebV/ywVU1kDxa
         Yj2eXz9QlvZVtDMYYqR2ysTI/fxtKhP5bPzrHDePysvX1OFDzy1z80ox7LydOvOw4s+u
         5W4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729497894; x=1730102694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCxbIdeUZnMRvGceySlkhLwCVSlS+VQaiyZ6j0nLBAY=;
        b=XJ5YNuRYtu9VH0h/QkFkY5+l+eB9FwS2nlyIQNAk7E9t1cIKNND+82NsoE2gtOY1dc
         OgezTCum4YGifSDHhhenl8991X1EtcWpdNLu7KF7cWOQArVckJZ/srxtxQ63sO7z9vg2
         pMybsJR6Wxuj+468fnsM3r7nt3I1fvgqw8RvFhTvfUfsdIYyW4MEefIvx6FN813PQAzm
         KWLyI+uw7xDBrJ6/0dQbQOUI0/0RoT7hTO+T1uXrC9PZMER8kZ4iU38rbEjaNjBJLzkJ
         v16tCg9eb9uwSygPRJs5xHli9CA1p52iEZlzbVgbn/y9aTjKYF+yNXEhKKhtYVbIrbMD
         7pvA==
X-Forwarded-Encrypted: i=1; AJvYcCWHxoKwKeu9UJfgWlxJWQO0sU9ef882pm/TtcdfRRX90Zc4qXj++DF6Yf9O+yYhFdePsEYzoXGY6pfSezw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+DP/wAAhU2cGn0wQOx5vz9OMH70tzom76a9yMKDQTpxdOssD1
	EjEqPb00BWDaxtAP4zHac1wERTblQufnwLIC/rZJcuMWcZ+KngOSW29NBZt1tXc=
X-Google-Smtp-Source: AGHT+IHxf07RyEI8Eec6QyY6xEq/FIAh/V44Zfed1CnL3RdUnLnl9WJMhY64JKq5/000/zVBSftcEQ==
X-Received: by 2002:a2e:4a0a:0:b0:2fa:d978:a6a2 with SMTP id 38308e7fff4ca-2fb82fd0093mr39333001fa.27.1729497894081;
        Mon, 21 Oct 2024 01:04:54 -0700 (PDT)
Received: from ?IPV6:2001:a61:13cd:ce01:d26b:21f0:5b2f:6eca? ([2001:a61:13cd:ce01:d26b:21f0:5b2f:6eca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696ba62sm1651567a12.14.2024.10.21.01.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 01:04:53 -0700 (PDT)
Message-ID: <0abd3cbd-0e8a-43b2-8cb0-6556297aa7c9@suse.com>
Date: Mon, 21 Oct 2024 10:04:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, stern@rowland.harvard.edu, sylv@sylv.io,
 syzkaller-bugs@googlegroups.com
References: <67153205.050a0220.1e4b4d.0048.GAE@google.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <67153205.050a0220.1e4b4d.0048.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.24 18:38, syzbot wrote:
  
> INFO: task kworker/0:0:8 blocked for more than 143 seconds.
>        Not tainted 6.12.0-rc3-syzkaller-00051-g07b887f8236e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:0     state:D stack:24544 pid:8     tgid:8     ppid:2      flags:0x00004000
> Workqueue: pm pm_runtime_work
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:5322 [inline]
>   __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
>   __schedule_loop kernel/sched/core.c:6759 [inline]
>   schedule+0xe7/0x350 kernel/sched/core.c:6774

And this sleeps forever. This must not happen.
>   usb_kill_urb.part.0+0x1ca/0x250 drivers/usb/core/urb.c:713
>   usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:702

We are changing our mind, presumably due to a timeout
>   usb_start_wait_urb+0x255/0x4c0 drivers/usb/core/message.c:65

We are sending a control message, presumably to enable
remote wakeup
>   usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
>   usb_control_msg+0x327/0x4b0 drivers/usb/core/message.c:154
>   usb_enable_remote_wakeup drivers/usb/core/hub.c:3365 [inline]
>   usb_port_suspend+0x339/0xf10 drivers/usb/core/hub.c:3472

Suspending ...
>   usb_generic_driver_suspend+0xeb/0x1d0 drivers/usb/core/generic.c:302
>   usb_suspend_device drivers/usb/core/driver.c:1272 [inline]
>   usb_suspend_both+0x66d/0x9c0 drivers/usb/core/driver.c:1443
>   usb_runtime_suspend+0x49/0x180 drivers/usb/core/driver.c:1968

This very much looks like the HC driver used to run these tests
can hand in unlink. If that happens there is nothing usbcore
or a driver can do.
As this is now reproducible I would suggest a bisection. Brute force,
but I see no good alternative.

Syzbot is an important tool and if the HC driver it uses is unreliable,
the whole thing becomes unreliable and that is most undesirable.

	Regards
		Oliver



