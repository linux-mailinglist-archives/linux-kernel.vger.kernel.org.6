Return-Path: <linux-kernel+bounces-392225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E739B913A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6588E1C215F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC019E982;
	Fri,  1 Nov 2024 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxPiJU5d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE119E7F7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730464905; cv=none; b=MS0gw5JvfVSTNQp9N51V+5nivqQ83AjYUjhVtkiXItHArg6jufrqyIrznLOsi35fhG4A+XoRkhw5phQVRHDWhzULJYvyZPEl4EjKMwltvZWjtRgJSWPNMJcBRZeiZTBgzf2N2AR+PsrUfjg25FsWCcSXR2SdDs9HomulmAi6xNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730464905; c=relaxed/simple;
	bh=cUk/xskTKjjrCsTBnZaPMW40XSVSKDz2IZgnZtLZzk4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YasdJvImS4AscEZlDWCVCCGQjAZaHf64vimK6ib1AADiDyPWqhhWZvXe1HN36CJvzVr3reDsDh1BoIiWubrTjvwk2joCnocWGTK2cBiQ9VGw7NvFr2nEZGfeuivApkN6hbclx3Lz84a0wmM9YuspVqcWkHrn2GmsCC530s2scHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxPiJU5d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730464901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daCi0NDDhzj7qIkfaAgOyXECPMHal4Ju0DlZnZ8lsZU=;
	b=MxPiJU5dke9ObnSkNAemjMdaqbxjZ5s9qLlI86m+2pPyYDVQW25/VgezV5lb+Ss00uLugv
	k1UPjZmT9apkzAm3wHBfK58okhOhzCEwa83n3KW8BYXgXUmvV4FkqwOp4So4HDr++zeJr2
	w0ax+/1Lo2lNsUAkVMD+zS8uIkLES3E=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-78Us7ikaMoC8Ws47TUKAsQ-1; Fri, 01 Nov 2024 08:41:40 -0400
X-MC-Unique: 78Us7ikaMoC8Ws47TUKAsQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e30cf48435fso3700519276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 05:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730464899; x=1731069699;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daCi0NDDhzj7qIkfaAgOyXECPMHal4Ju0DlZnZ8lsZU=;
        b=CS6B5XScDtWL9jjHVQ2/IUblWuz7mydDkE3GfEqyWzOjVEBY4xvkV5qx0YSJu5yzIw
         1VwJBsiSijSV4pjCRNpvht6JQtn0PLv6c9BFjwqXftpEg09YroQVavmaSJ7Z+sjmnYcH
         ep85AzrTpCLrcfcNutbt8a5hj1r9dB+yIp+aFjq1zUh1/uaKMjnKROtoDiZDGGCiB/hM
         gzy/7Rw9Rtz/toNo+l2LqLVp2wCay5y2pRh6uKM7Uvk3ChUqc8ABs4dbuPxbqjvTIbWk
         yI1Tk65ax/yS/uXcw4QTREB/xtKwcifgmbl0ZNVjftKaWt0yzCFeZ8ibb3dV0CoJ9Qgn
         MwFw==
X-Forwarded-Encrypted: i=1; AJvYcCW0+fhRYz57JofPKf6Rl0yidc2/75kTch7gXNg3kOdN/w9DA8gRR5CZKL01tRwoIfdqpkEvV3NY6LEkMmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzloPtVdpcU798D4UUsZOC0WWiyBh++I6au6dos4vMxITrkg+Yf
	S1XMrT9SZ5+Iy/sawn1eeqFh5GZUxSwMuhaKSgG+zyPZmYyIDWtDY2goBU0YDxs+qFqgqJSFGRn
	4SBghdw5V1t0OEqyzhf128NFYK8Rmxq1QCVOn/Au1phMP+ajIZm0VlYtSvfZdIDvrXQnD9A==
X-Received: by 2002:a05:6902:124b:b0:e2b:d131:f293 with SMTP id 3f1490d57ef6-e30cf4eca13mr11168982276.51.1730464899639;
        Fri, 01 Nov 2024 05:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDPtyPPrkq7Jk1C7LfKXl054BEA2PIAAJUUrPjUHIXRdxQdc1sCRTl2Ysmi678HByvzevNcA==
X-Received: by 2002:a05:6902:124b:b0:e2b:d131:f293 with SMTP id 3f1490d57ef6-e30cf4eca13mr11168958276.51.1730464899337;
        Fri, 01 Nov 2024 05:41:39 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad161f33sm18073491cf.78.2024.11.01.05.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 05:41:38 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bcad4168-52a0-44cc-b0f0-9346f30d8d80@redhat.com>
Date: Thu, 31 Oct 2024 16:18:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH 0/4] futex: Add support task local hash maps.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
 <20241031155640.Fhtm3uFD@linutronix.de>
Content-Language: en-US
In-Reply-To: <20241031155640.Fhtm3uFD@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/24 11:56 AM, Sebastian Andrzej Siewior wrote:
> On 2024-10-28 13:13:54 [+0100], To linux-kernel@vger.kernel.org wrote:
>>                                                             Need to do
>> more testing.
> So there is "perf bench futex hash". On a 256 CPU NUMA box:
> 	perf bench futex hash -t 240 -m -s -b $hb
> and hb 2 … 131072 (moved the allocation to kvmalloc) I get the following
> (averaged over 3 three runs)
>
> buckets op/sec
>        2     9158.33
>        4    21665.66	+ ~136%
>        8    44686.66	+ ~106
>       16    84144.33	+ ~ 88
>       32   139998.33	+ ~ 66
>       64   279957.0	+ ~ 99
>      128   509533.0	+ ~100
>      256  1019846.0	+ ~100
>      512  1634940.0	+ ~ 60
>     1024  1834859.33	+ ~ 12
>           1868129.33 (global hash, 65536 hash)
>     2048  1912071.33	+ ~  4
>     4096  1918686.66	+ ~  0
>     8192  1922285.66	+ ~  0
>    16384  1923017.0	+ ~  0
>    32768  1923319.0	+ ~  0
>    65536  1932906.0	+ ~  0
>   131072  2042571.33	+ ~  5
>
> By doubling the hash size the ops/sec almost double until 256 slots.
> After 2048 slots the increase is almost noise (except for the last
> entry).
>
> Pinning the bench to individual CPUs belonging to a NUMA node and
> running the same test with 110 threads only (avg over 5 runs):
>            ops/sec global	ops/sec local
> node 0		2278572.2	2534827.4
> node 1		2229838.6	2437498.8
> node 0+1	2542602.4	2535749.8

Looking at the performance data, we should probably use the global hash 
table to maximize throughput if latency isn't important.

AFAICT, the reason why patch 4 allocates a local hash whenever the first 
thread is created to avoid a race between the same futex hashed on both 
the local and global hash tables. Correct me if my understanding is 
incorrect. That will enforce all multithreaded processes to use local 
hash tables for private futexes even if they don't care about latency.

Maybe we should limit the auto local hash table allocation only to RT 
processes. To avoid the race, we could add a flag to indicate if  a 
private futex has ever been hashed in the kernel and avoid local hash 
creation in this case and probably also when the prctl() is being called 
to create local hash table.

My 2 cents.

Cheers,


