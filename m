Return-Path: <linux-kernel+bounces-448646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD81C9F4361
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E788188F524
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82B159565;
	Tue, 17 Dec 2024 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDVnwQGU"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6D136347
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734416089; cv=none; b=DaLpJIjNLOZuyoYuKHU1nm/4QqLkxOtRTXZbYtEVfUGk6yvD9fZGM3RH2Fc91pZwCBP9xUwJgbZqGt8xvn9BiUBnGPpbxMsgfYglmjmYVh4zXv0M0Nk4bWDfHXd7mMTZwFKGylle2iQ0yoUoVj46m7KnMS5ctcUUSwcAjeYn2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734416089; c=relaxed/simple;
	bh=oVV3P+WoUDphqtnnTAtC9FINcJEsDhDSdaDK1TVTBwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QKLYZVBLyg7tgAjxqpKL+qY2M6NEzn/7r7Wx9AlWWHA0tNV/dxofuOJYgZoGBhiWMWzd6lJKjsHBbsb5jOq+HjKtIloY4oW5m9G7tW1Ffy5HEBNe38ZgufZtpyvEDdieocgyb95iReNU1roAWimUPuwSNXkbAcEnLAcPm6locLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDVnwQGU; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-725ed193c9eso4105166b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734416087; x=1735020887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFPNgsHYpGnEBJL+FeR9lTLPypSyQFpvnedfuwkNqWs=;
        b=EDVnwQGUuU33hY4o2vxsAHzVSLlq4mignkBrTm0N8FQaEVuk8jHuXD0Ggvc7Ydg6yX
         U/vgxb/9aYhxCDxxwrQn4AQ2WjjbhE1QoNV5Glk1UFFeX3eWIRbObDUlvEn3db0UniFV
         pCzklil9YmrgrRyeEEj5IF3qio2jCUL+14ZDKepuKQ/kdbEh0NlXaam9ayk1I3+NCqW4
         9iTEZHC16xbWmZAZ6BSpAQZPR/Bcixj4DJ+QKbdnHvCtJywp9fcMeI/Yx0rWtoqPf8cW
         q5yqJVrAYc0Q82wJAp5tQV1qrVikOQM77/n5aQQipPu0Q/MsR4Eq/tJJ95tRblC9yg9p
         ivlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734416087; x=1735020887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFPNgsHYpGnEBJL+FeR9lTLPypSyQFpvnedfuwkNqWs=;
        b=sIrOb8qUeAsOPz3ramRteDAhYTpnejzbrDUMrrfrGh7J7GqeiqiM7+61ljSTZb4Pa1
         Zmo5o6hze3YKclLP5Vb5c+BFTLEM68GzMqGVtNYrNer6+I5um286CSoWxY5cKXmpwjvw
         CJX7rP+v38xGGFoXSdnF50OwevFEQ6Q51P8N5zFP6uVfGxQLErsc7wnG42MHyGWXa0Ay
         CbOXSAaFDmAhekjVRDDSOAMTK1k729tTGj42No3Mxi9CeimGrDwWHME1Zb44CkyDdWDF
         IQ0oaw7TTWMoTZiVKgvYmg5hpSghlUnmw3UB+sWwEx0+x2igKdqMBhm/3AaRMY3yYWdv
         gD2g==
X-Forwarded-Encrypted: i=1; AJvYcCVopv+niOklOkB9EanfzzI83HqPd52o7eW/8n+4le0u75AwLT7bXfOp4sn4JeTVGIR2wH1ZgHC0nUV4mEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKiVHGla84+Ska+S4JH8xHWK3WStlZ4ZNROKEsQb4sC9j8Pbc
	kOFgCSnDqn7V2aL+igpcgVObnz+SfF0a90sMWeIgy5vI6lH3kkO9
X-Gm-Gg: ASbGnctai6C/g98ep5AT9eW3bgP9nasfRSsGczhNFlezagxykpqzX9crCk65bG0retH
	XNz4eVRA7p/IKkxV26X00xjPJk09xQO8v+nTPoTbjurjXijbc1RFRwRJJG9/qKReVMwph22ninq
	mZfhz9e5M5Ub5e+tZIsjMF0Yy0gD17GMlbX6gB1P4z6vlXNtoZGWfKExE6L2I2mXNhGNgqKwaxv
	NC6NSx3WJFY8sfwpWZM+hk6DcCopRpdjmBhJ6YX4VxDIanwgV9Yzi68aRRhQSns2tRcbtaj7nlm
	3xxqluk=
X-Google-Smtp-Source: AGHT+IHF3WzKCWl9uwrQmwkUElteyQAN9SyB6FO0L05zx7tIAz1IyBzEL3iRMUu7KimCNXEU3NY+TQ==
X-Received: by 2002:a05:6a20:918d:b0:1e1:af74:a235 with SMTP id adf61e73a8af0-1e1dfd70c58mr24708117637.24.1734416087374;
        Mon, 16 Dec 2024 22:14:47 -0800 (PST)
Received: from localhost.localdomain ([2408:80e0:41fc:0:fe2d:0:1:6253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c3a513sm5112625a12.72.2024.12.16.22.14.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Dec 2024 22:14:46 -0800 (PST)
From: zhouzihan30 <15645113830zzh@gmail.com>
X-Google-Original-From: zhouzihan30 <zhouzihan30@jd.com>
To: vincent.guittot@linaro.org
Cc: 15645113830zzh@gmail.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vschneid@redhat.com,
	yaozhenguo@jd.com,
	zhouzihan30@jd.com
Subject: Re: [PATCH] sched: Forward deadline for early tick
Date: Tue, 17 Dec 2024 14:13:19 +0800
Message-Id: <20241217061317.92811-1-zhouzihan30@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAKfTPtDcQH==23tWEXNz=dFujBvBC88NESp4KcwEPf83_s6PjA@mail.gmail.com>
References: <CAKfTPtDcQH==23tWEXNz=dFujBvBC88NESp4KcwEPf83_s6PjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Thank you Vincent Guittot for solving my confusion about tick error: why 
is it always less than 1ms on some machines.

It is normal for tick not to be equal to 1ms due to software or hardware,
but on some machines, tick is always less than 1ms, which is a bit strange.
I have not provided a good explanation for it, but now I know the reason.
The root cause is CONFIG_IRQ_TIME_ACCOUNTING.

I used bpftrace to monitor changes in the rq clock (task) in the system:

kprobe:update_rq_clock_task /pid == 6388/
{
    @rq = (struct rq *)arg0;
    $delta = (int64)arg1;
    @clock_pre = @rq->clock_task;
    printf("rq clock delta is %llu\n", $delta);
}

kretprobe:update_rq_clock_task /pid == 6388/
{
    $clock_post = @rq->clock_task;
    printf("rq clock task delta: %llu\n", $clock_post - @clock_pre);
}


result:
rq clock delta is 999994                                                          
rq clock task delta: 996616                    
rq clock delta is 1000026
rq clock task delta: 996550
rq clock delta is 1000047
rq clock task delta: 996716
rq clock delta is 999995 
rq clock task delta: 996454
rq clock delta is 1000058
rq clock task delta: 996621
rq clock delta is 999987 
rq clock task delta: 996457
rq clock delta is 1000047 
rq clock task delta: 996621
rq clock delta is 999966 
rq clock task delta: 996594
rq clock delta is 1000071
rq clock task delta: 996470
rq clock delta is 1000073
rq clock task delta: 996586
rq clock delta is 999958                       
rq clock task delta: 996446                    
rq clock delta is 1000018
rq clock task delta: 996574
rq clock delta is 999993 
rq clock task delta: 996908
rq clock delta is 1000037
rq clock task delta: 996547


As Vincent Guittot said:

< the delta of rq_clock_task is always
< less than 1ms on my system but the delta of rq_clock is sometimes
< above and sometime below 1ms

According to the kernel function: update_rq_clock_task, Both
 CONFIG_IRQ_TIME_ACCOUNTING and CONFIG_PARAVIRT_TIME_ACCOUNTING often
 result in the delta of rq_clock_task being lower than 1ms. I counted
 13016 delta cases, and in the end, 47% of the delta of rq_clock was
 less than 1ms, but all of the delta of rq_clock_task is always less
 than 1ms

In order to conduct a comparative experiment, I turned off those CONFIG
 and re checked the changes in clock, It is found that the values of
 rq clock and rq clock task become completely consistent, However, 
according to the information from perf, there are still errors in tick
 (slice=3ms) :

      time    cpu  task name     wait time  sch delay   run time
                   [tid/pid]        (msec)     (msec)     (msec)
---------- ------  ------------  ---------  ---------  ---------
110.436513 [0001]  perf[1414]        0.000      0.000      0.000 
110.440490 [0001]  bash[1341]        0.000      0.000      3.977 
110.441490 [0001]  bash[1344]        0.000      0.000      0.999 
110.441548 [0001]  perf[1414]        4.976      0.000      0.058 
110.445491 [0001]  bash[1344]        0.058      0.000      3.942 
110.449490 [0001]  bash[1341]        5.000      0.000      3.999 
110.452490 [0001]  bash[1344]        3.999      0.000      2.999 
110.456491 [0001]  bash[1341]        2.999      0.000      4.000 
110.460489 [0001]  bash[1344]        4.000      0.000      3.998 
110.463490 [0001]  bash[1341]        3.998      0.000      3.001 
110.467493 [0001]  bash[1344]        3.001      0.000      4.002 
110.471490 [0001]  bash[1341]        4.002      0.000      3.996 
110.474489 [0001]  bash[1344]        3.996      0.000      2.999 
110.477490 [0001]  bash[1341]        2.999      0.000      3.000 


It seems that regardless of whether or not there is
 CONFIG_IRQ_TIME_ACCOUNTING, tick errors can cause random variations in
 runtime between 3 and 4ms.



< This means that the task didn't effectively get its slice because of
< time spent in IRQ context. Would it be better to set a default slice
< slightly lower than an integer number of tick

We once considered subtracting a little from a slice when setting it,
for example, if someone sets 3ms, we can subtract 0.1ms from it and
 make it 2.9ms. But this is not a good solution. If someone sets it to
 3.1ms, should we use 2.9ms or 3ms? There doesn't seem to be a
 particularly good option, and it may lead to even greater system errors.

Changing the default value is a simple solution, in fact, we did it on 
the old kernel we used (we just set it 2.9ms. On our old kernel 6.6,
 tick error caused processes with the same weight have different run time,
the new kernel did not have this problem, but we still submitted this
 patch because we thought unexpected behavior might occur in other
 scenarios). However, apart from the kernel's default value, 
different OS seemes to have different behaviors, and the default value is
 often an integer number of tick... so we still hope to solve this
 problem in kernel.








