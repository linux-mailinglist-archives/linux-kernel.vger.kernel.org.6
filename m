Return-Path: <linux-kernel+bounces-436870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728899E8BDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717B8163E12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67FA21481B;
	Mon,  9 Dec 2024 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEsLB5kI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207714AD0E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728278; cv=none; b=MXDampyHYpmfMrM+ZO1iEhYLrmnZZjdALEFEJOUL1aK8VcZx0WmcU6qZWwnP3S0rqgIjWWGLJYoNtmaRTyu6QLuoy4iwrvXkcSF5aw9ibyYGfHGoPr35q125Z4ImaGMqRpezOqaOOd1enUpDl/w87K6udM/sDmLmMzOUxWHNp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728278; c=relaxed/simple;
	bh=Yj2Iv6g6YqBMgSTnkq+eiZiQZkssOFdl4liiPa9R7bc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GytPZwMsqRHf6QyBRUPUP+VKXlS55ry0R3GydSoNA/Q8ObFDNAIgduAJlnPEB56npuhVwNmjy4jBhH33Fs5HapseHrZEYfoy6bXUKDLCCZrW+s9oGsyYKEaE6MbNsAka1dgBjOVehIbA2Blwt9jZAOkGAG/WECKNGBe7e2Sc9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEsLB5kI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733728274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Mi9Qz7TtkdLgolRsAJJGRcl9QUP3iOzC3Uynd9UXnnY=;
	b=VEsLB5kI5fXKfWA7W3SF6YAwWJu8YB2CrjXXWZG5MT3X1Er5qYnl5x1KlluKdAFGD3dPgq
	5HpqlF7YUPma/7SgVLT8KAfxpAGUzkYoK/zcFBSMw9O6OLorECgHz9h+Wm9jT7WkHp8P3E
	9MXdr23P8qSmcc1KP/rY/aQsN+ahGTU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-gwzRWFd4MmCN8ElRX6QHAw-1; Mon, 09 Dec 2024 02:11:12 -0500
X-MC-Unique: gwzRWFd4MmCN8ElRX6QHAw-1
X-Mimecast-MFC-AGG-ID: gwzRWFd4MmCN8ElRX6QHAw
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d3d9d6293fso1181986a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 23:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728271; x=1734333071;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mi9Qz7TtkdLgolRsAJJGRcl9QUP3iOzC3Uynd9UXnnY=;
        b=xTTujEcKiEfWp1tvkeH0bS2c/f685vlNh4WfgDnAQ424kE/mTYNS3zeZTCPVTshhzn
         wnnVlGthcH4ZCcSa1ZY69GRbObVzAi90z7isMlua9Lfq+dBYAVDsgs6eVhP2jkiUrXhU
         hEyt+j0pIkCf/1cmHqsAFMNDeCCuB2+AtuMAEoFH0Vayi9b/HlFDvW0gowacrNjIXsIi
         FZetTCcOi2CtiYaX6u/nft2wA8BFLhZs2n5ab+7zBBQjpV5Ld6Yy2mMbDs25ImQrCPz7
         9ck9X7WBv0xVFzDvYhjvAqschJ3iiKdnrr9FpChJS/pN+I4sZK4XJ+xCxzphazURsa3k
         Wu/w==
X-Gm-Message-State: AOJu0Yyse+AeM+soEjEru0QlwAGPC4F7kNI+bwg6/3wF80/+QVYgnc6V
	s//JajB8HasDmvfJ/qmkyeUY48enQEm8AWUbdqduAt4IRKfY6TDFAhUATJRozoz7X4K3eE879xX
	tfa6XKJWADbPMUeX0CoMGdP09JHm9jN9FmV2o576bu+uSOqR9KmQuZIHz+8YDVnUF6dWyMaBHSV
	tFdatrYiuwA9nIhBGEXvm3Rl2OUDT2Kjns/mXg
X-Gm-Gg: ASbGncvm89XNdind5pOkNV8En5eSGKXnR1KbE4fmyZYTInwFSaC/9KKfmBdtDKA6EWT
	rjYBYwu+VZCSLdz5f+gcWvOhz3krcSRuL6TPBuEvLPMviD+AuOYy2n2qdnoUKLcJLDw==
X-Received: by 2002:a05:6402:5207:b0:5d0:ceec:deec with SMTP id 4fb4d7f45d1cf-5d3be6d7b30mr9651722a12.13.1733728271520;
        Sun, 08 Dec 2024 23:11:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6VriEYcq7g26XtrrvpIi8XUmysOVepZOkqjfpouObyKc+t4PFFOMjZlioRby6jxtoJoabUEfaTIc6Tnxt8Lg=
X-Received: by 2002:a05:6402:5207:b0:5d0:ceec:deec with SMTP id
 4fb4d7f45d1cf-5d3be6d7b30mr9651714a12.13.1733728271231; Sun, 08 Dec 2024
 23:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Mon, 9 Dec 2024 09:10:35 +0200
Message-ID: <CADDUTFzK0FNS_mJ=S2_FH2vS2c5a+gW_qsjf3Hb9k=zzjB4JmA@mail.gmail.com>
Subject: Interference of CPU hotplug on CPU isolation and Real-Time tasks
To: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello

Simplified test:
rtla timerlat hist -c 1 -a 500 &
echo 0 >  /sys/devices/system/cpu/cpu11/online

RTLA reveals blocking thread stack trace:
...
               -> multi_cpu_stop
               -> cpu_stopper_thread
               -> smpboot_thread_fn
...

I've found that multi_cpu_stop() disables interrupts for EACH online
CPU because takedown_cpu() indirectly invokes take_cpu_down() through
stop_machine_cpuslocked(). I'm omitting the detailed description of
the call chain.

Potentially using stop_one_cpu() instead of stop_machine_cpuslocked()
could solve the problem:

@@ -1335,7 +1339,7 @@ static int takedown_cpu(unsigned int cpu)
       /*
        * So now all preempt/rcu users must observe !cpu_active().
        */
-       err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
+       err = stop_one_cpu(cpu, take_cpu_down, NULL);

Original stop_machine code was introduced 20 years ago:
Author: rusty <rusty>
Date:   Fri Mar 19 16:02:28 2004 +0000

   [PATCH] Hotplug CPUs: cpu_down()

   Implement cpu_down(): uses stop_machine to freeze the machine, then
   uses (arch-specific) __cpu_disable() and migrate_all_tasks().

   Whole thing under CONFIG_HOTPLUG_CPU, so doesn't break archs which
   don't define that.

https://github.com/jeffmahoney/linux-pre-git/commit/864a81b15223552102124656a012ac6de6947499#diff-52e4b09f63a029f319f95a60ddc0a09c31de0e172f8a2802ce39294569e60587R122

Additionally, take_cpu_down() relies on local_irq_save() and
hard_irq_disable(). However, I am omitting this patch to concentrate
solely on stop_one_cpu().

Questions:
1. Why stop_machine() is used during the CPU hotplug?
2. Is it worth testing using stop_one_cpu(), or would that be the
wrong approach?
3. Do you have any additional recommendations?

Thanks
Costa


