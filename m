Return-Path: <linux-kernel+bounces-523508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A4A3D7C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B3B17D785
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A611F1516;
	Thu, 20 Feb 2025 11:05:12 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EB41F4735
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049512; cv=none; b=dP4KWDZtAQFMoSk5yQ46Z31ehLYvXdYzzegphL26z9XqfWPVkdyr9xgc6Ec8rXJft2pXVbsGAA8w6KZ/WQsPvCtBJeajqJH2VsI5ga/lsTDVm55z4TjuYk1ztD8ndqST/6BpQybR5NX4CeSClX0zq9GkXogZY59dxTkDCVP2ojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049512; c=relaxed/simple;
	bh=m5UHElaMqS6Tq1Kvk9GCyxZphTm8vcEOFNVJZKYXaZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8d1MAINanjs/lKz9yOlc/2LeSoH50QoWyDlF/XoQakjzf2PqW7NM1e1EhmK4JYiXbOuIP1t8668XBWVo93jTGEv6Aue0T7aMKIjNSuJ4pV8wlKXjfW5O6CvooRAEJ3vidseumXTdaPa04nkj7GR4nUHFKKcPkxNnTqdlOeKlVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30613802a6bso7861541fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740049508; x=1740654308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8uxDiuJb+FtwnSdvnxhyDNV/h2/dsyLMYaCTue1E1s=;
        b=pNBQxvRWKyird3dmGanr/x0Nnxwe+f/01oRldbDBwKXTFtXNGKgrgvr0akkSBaISpG
         iLWYSMFM78gzsPLTh0WS2WeJLwzW1i/faOKN7eI4URcH98XLkLSezJPSPEiqmaMcvZpw
         e8Zf5J45MX0G/xaSYZy8tagTRzEFquauLncGMJ1WkDeQDqVehM5rL2KloTTQA299OE/f
         DXPVB0n6gR86D8E1j0R0fZB32Avfkqd7VEOohy0WowtXlPWp+h6RLUG0zuErTHmZ/yRV
         8HN5HkMN93f8RvE1Y3xIz534QL4P3l25+OZzg+FX/TMrOBUn1wE9YYFqEIyKgdev8tbR
         qtVw==
X-Forwarded-Encrypted: i=1; AJvYcCXjBxhH2ilYz5aPLx4FqXI65YK/FDITJgBL6dHCZNouDlh3O1GO5EWuzTsF0/lM3d7zKlUWmbTezjr1x1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoOw9eMssb/WkIf5fzbn9nnSjC842f6iePaMokrwgFAtC9JSvX
	nFHUvw1DPrNOGK3I1VsFf6N12dUbShFG0+yy3yT/vsnvyGuj6eXI
X-Gm-Gg: ASbGncuYGDGdS67fAKsET0srMg/CZ5D9byYMg1Kx2JpOP1uIe5v/oa6lPJp8t21KB/M
	D2HFdy6lMNwX16qbA9LG+12DtLm9zb52299+N4IHEJJNJI4nVz1OcI/7gdtYtBfF7R1oXGC+ycc
	mw5CldeFWnTXt0K8cXGO1E5/1cDeTVv2Aw+LYI9mgdNneKiIU7DMbveuor/OeA43Xr4wBLHXSk3
	xM6WLMkzPWtfyghpOoEITKBsW8RI5bfElE4hXSNkYbqNb70528sLd7gSaHqCklJP5j3pftxwOOa
	bea6gPCQuG1hGr1McMMmdB/U6jmDFZ7J/5uqD99mbeOmzxC4yMw=
X-Google-Smtp-Source: AGHT+IEDAzNSU4M6N6+sNoHRKE34zjwzmrWG8rZXC43x/q/qFTR8i6SDYVfamfd05Dg4BOm0XvFkhg==
X-Received: by 2002:a05:6512:2342:b0:545:fad:a757 with SMTP id 2adb3069b0e04-5452fe56d47mr6947117e87.29.1740049508045;
        Thu, 20 Feb 2025 03:05:08 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54531afdbdcsm1647220e87.247.2025.02.20.03.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 03:05:07 -0800 (PST)
Message-ID: <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
Date: Thu, 20 Feb 2025 13:05:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
 John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 19/02/2025 16:47, Nilay Shroff wrote:
>
> On 2/18/25 10:45 PM, Keith Busch wrote:
>> On Tue, Feb 18, 2025 at 11:31:58AM -0500, John Meneghini wrote:
>>> On 2/18/25 10:06 AM, Keith Busch wrote:
>>>> On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
>>>>> Keith, Christoph and Sagi,
>>>>>
>>>>> This patch has been fully tested and analyzed by Red Hat's QA group and no
>>>>> unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
>>>>> have been tested. Our QE engineer has asked me to report this upstream.
>>>> What's the harm in leaving the parameter? *I* use it so I can test both
>>>> ways without needing to compile multiple kernels.
>>> LOL.  We've been talking about this since 2017. The goal has always been to remove support for DMMP with NVMe.
>> I understand that disabling nvme native mp it is required for device
>> mapper, and I get you want to prevent the possibility of anyone using
>> dm-mp with nvme, but that isn't the only user that wants to see all
>> namespace paths.
>>   
> Agreed! I do have nvme multi-controller disks and I toggle multipath module parameter to
> test it both ways. One with each individual path to a shared namespace and another with
> a single head node path and then let IO policy determine which path to choose for sending
> IO to disk.
> In fact, we have few nvme blktests which only runs if device is configured with single path
> and so testing it on multi-controller nvme disk would require us to turn off multipath module
> parameter. In that way this parameter is very handy. My typical way of
> toggling this parameter is:
> 1. disable multipath
> # rmmod nvme
> # rmmod nvme_core
> # modprobe nvme_core multipath=0
> # modprobe nvme
>
> Now I could run all nvme blktests which require us disable multipath.
>
> 2. enable multipath:
> # rmmod nvme
> # rmmmod nvme_core
> # modprobe nvme_core multipath=1
> # modprobe nvme
>
> Now if we get away with multipath parameter then it means we have to re-compile kernel
> disabling CONFIG_NVME_MULTIPATH option and that's something we may want to avoid,
> if possible.
>
> Having said that I'm not against this patch however we certainly have users who would
> be using multipath parameter and taking away this parameter may break those user
> application.

Sounds like the user application is already broken. This like any 
modparam is not guaranteed
to stay, and we already have been warning users this is temporary and 
will be removed for years.

>   So I'm wondering why is it not possible for RedHat to let their customer
> know the fact that starting with RHEL-10, we don't support DMMP for NVMe device even
> though the multipath module parameter is present?

I get the testing argument, but I don't think its sufficient to keep 
exposing a user facing
modparam.

This discussion is not specific to RHEL, if there is a real use-case 
that we are interested in supporting,
we can change our minds and keep it (and simply remove the log msg), but 
I haven't heard any real
life use-cases thus far.

