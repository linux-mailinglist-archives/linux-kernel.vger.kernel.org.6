Return-Path: <linux-kernel+bounces-536885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6126EA48571
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CC61892424
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAB81BEF90;
	Thu, 27 Feb 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WRqqVmtP"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A261AF0B7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674219; cv=none; b=DhPD9nO7lA9iSC2fIIkUpk/jV4ogRMG6O9RSgr4oJT0nSWv3zv/lNiZ90cUbOB78waT8gZpNNYaFROKFGM0BhZJGg5G5ELm0LNUqDUbU2en+o6TaSqX9T+vyaiotG3KAzqFZje0yBRx0znCWB2svU+B9XYtX3syl03+ME/XxswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674219; c=relaxed/simple;
	bh=/gQrbEYi28B9yzHDRtDvI5K5t1xiTK4XRT9NEguTOIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWHHLaoCB8Cfed189aBzl7syu3r9I+XLMKa5+ftcNTJIuc89Ck9ifzTGVEYGt5jDpEifUqBNsi+F+zIQ6AbRqTMgqNF3FzC2C+sPzEwTOgufuzLZYf/7j9xqef37aDeiWzQgTIlPtOh+xTFttT1P8BcrMyfc1mMOxt3QgmdOI04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WRqqVmtP; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d2f7257181so9088045ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740674216; x=1741279016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InYxoOvYK+MD9saaA0tYT6jBk/j21+61ghGzj15uhx0=;
        b=WRqqVmtP18Bt2wY3f7W0HtTnHsBNweUbnJ3SgFRmtiIgXwrSAdC7LDAClTuXsEPWoQ
         0mZ3/K8/IlPeGYFCGCS0ld2xbByF/9zI3Vwaw2oMXhD8phMve+rVOayQfwe1NWyHPFSt
         mBec7nkXf2UuHPLOGbH2Khp1C2bghSCw+z8KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674216; x=1741279016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InYxoOvYK+MD9saaA0tYT6jBk/j21+61ghGzj15uhx0=;
        b=AMQQWy8yx3ODnhOu+CHm9AEwuxVZuLSL2EcoDdhGbVgBcpR06EPt6YWgvQCk/F/rUQ
         OmOmgE/OPHrIP2XQsS3oxfJsixpiM99N2Wi+I9llyQyxZmStKLrSDTouvtnR7gh+BdSA
         6W6azme43p4UMATmCAf1OHntAgwdPON/qTxz4zEWNc10hgfFBDc0et624w4SOkrjQZK0
         z2hMHkOj6lB3QbBIcEqjZOGRH6KdPauQOBatZpzCEp+2dSzd46EUTc+Ed+e28n2AQtX8
         ZHjTtXsXz3AqPvX73VtX034qq8fiRf+c30zoaKG8if5ybN/iLPH2Jco+zEgl8hhe69WI
         magw==
X-Forwarded-Encrypted: i=1; AJvYcCX+4tls27p77vwdrirS/XqH42nawq4xJXnR6jG9O8ctQpOOjPlW8XVhli3C07DCSLuLVrm8vuregp21voM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3FMFd6s+M0R7W0ENCx9Rras9DzgsNRlUggBvsXxjIEwVM5GNR
	mFu/+EhscKTwT4+bPfHe3PhJY100bYxtVjClAUv5UNR0uVv997rDWI0CNh2z9IE=
X-Gm-Gg: ASbGnctgbmQcrSlmMwXBLrB5r6nqi9jDAvvXJHwX/8duEoTKCmCehqtdcTQQPPTvN9M
	G8lfpvH1hSZWuW69GC2DpFAbQsbL+EQ4ITfXZ65TrdrXMviYqGvKr9NmpquaaEzFw8rk7RtRHQQ
	AMXMw9RVBROZUY3LISoLugqklnjf+qDKPICVbN3SUG/wyD+TJDxI3Q8uIzB2ICxBFQP1E8ejpqO
	ubJVOPtNvHNUzr86V0aVn7INgPsRloOmJEKUQy6o/GsdGUjMNfIYVq8rZjtmiEds5tCW2RnB5fb
	VrSlmtqbuRBQGB/wMXtMvfBqsHttdOIuZxha
X-Google-Smtp-Source: AGHT+IFhaDi0loEVSzsUS9jUGD7nrYZwaXIdsSZjUkhx1kmsnPMxK6UYOZBYI0JOyD/TWTEfpVB3Ww==
X-Received: by 2002:a05:6e02:3092:b0:3d0:21aa:a756 with SMTP id e9e14a558f8ab-3d2cae4c215mr293742505ab.5.1740674216544;
        Thu, 27 Feb 2025 08:36:56 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3deee50afsm3846715ab.71.2025.02.27.08.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:36:56 -0800 (PST)
Message-ID: <cffe9295-7070-4d69-896f-7f0a406861c9@linuxfoundation.org>
Date: Thu, 27 Feb 2025 09:36:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vimc: skip .s_stream() for stopped entities
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250224154928.1220074-1-n.zhandarovich@fintech.ru>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250224154928.1220074-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 08:49, Nikita Zhandarovich wrote:
> Syzbot reported [1] a warning prompted by a check in call_s_stream()
> that checks whether .s_stream() operation is warranted for unstarted
> or stopped subdevs.
> 
> Add a simple fix in vimc_streamer_pipeline_terminate() ensuring that
> entities skip a call to .s_stream() unless they have been previously
> properly started.
> 
> [1] Syzbot report:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5933 at drivers/media/v4l2-core/v4l2-subdev.c:460 call_s_stream+0x2df/0x350 drivers/media/v4l2-core/v4l2-subdev.c:460
> Modules linked in:
> CPU: 0 UID: 0 PID: 5933 Comm: syz-executor330 Not tainted 6.13.0-rc2-syzkaller-00362-g2d8308bf5b67 #0
> ...
> Call Trace:
>   <TASK>
>   vimc_streamer_pipeline_terminate+0x218/0x320 drivers/media/test-drivers/vimc/vimc-streamer.c:62
>   vimc_streamer_pipeline_init drivers/media/test-drivers/vimc/vimc-streamer.c:101 [inline]
>   vimc_streamer_s_stream+0x650/0x9a0 drivers/media/test-drivers/vimc/vimc-streamer.c:203
>   vimc_capture_start_streaming+0xa1/0x130 drivers/media/test-drivers/vimc/vimc-capture.c:256
>   vb2_start_streaming+0x15f/0x5a0 drivers/media/common/videobuf2/videobuf2-core.c:1789
>   vb2_core_streamon+0x2a7/0x450 drivers/media/common/videobuf2/videobuf2-core.c:2348
>   vb2_streamon drivers/media/common/videobuf2/videobuf2-v4l2.c:875 [inline]
>   vb2_ioctl_streamon+0xf4/0x170 drivers/media/common/videobuf2/videobuf2-v4l2.c:1118
>   __video_do_ioctl+0xaf0/0xf00 drivers/media/v4l2-core/v4l2-ioctl.c:3122
>   video_usercopy+0x4d2/0x1620 drivers/media/v4l2-core/v4l2-ioctl.c:3463
>   v4l2_ioctl+0x1ba/0x250 drivers/media/v4l2-core/v4l2-dev.c:366
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:906 [inline]
>   __se_sys_ioctl fs/ioctl.c:892 [inline]
>   __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2b85c01b19
> ...
> 
> Reported-by: syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5bcd7c809d365e14c4df
> Fixes: adc589d2a208 ("media: vimc: Add vimc-streamer for stream control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>   drivers/media/test-drivers/vimc/vimc-streamer.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/media/test-drivers/vimc/vimc-streamer.c b/drivers/media/test-drivers/vimc/vimc-streamer.c
> index 807551a5143b..64dd7e0ea5ad 100644
> --- a/drivers/media/test-drivers/vimc/vimc-streamer.c
> +++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
> @@ -59,6 +59,12 @@ static void vimc_streamer_pipeline_terminate(struct vimc_stream *stream)
>   			continue;
>   
>   		sd = media_entity_to_v4l2_subdev(ved->ent);
> +		/*
> +		 * Do not call .s_stream() to stop an already
> +		 * stopped/unstarted subdev.
> +		 */
> +		if (!sd->s_stream_enabled)

The right interface to call is v4l2_subdev_is_streaming() instead
of checking s_stream_enabled directly.

> +			continue;
>   		v4l2_subdev_call(sd, video, s_stream, 0);
>   	}
>   }

Would it better to change vimc_streamer_pipeline_init() to not
call vimc_streamer_pipeline_terminate() instead here?

ret = v4l2_subdev_call(sd, video, s_stream, 1);
                         if (ret && ret != -ENOIOCTLCMD) {
                                 dev_err(ved->dev, "subdev_call error %s\n",
                                         ved->ent->name);
                                 vimc_streamer_pipeline_terminate(stream);
                                 return ret;
                         }


thanks,
-- Shuah

