Return-Path: <linux-kernel+bounces-387293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4469B4F19
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EABB283D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0CE1DC184;
	Tue, 29 Oct 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="fn1cobFI"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F721DA305
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218539; cv=none; b=qGEHGj03YEWIsi1o5FGppIlvY4f4OP58KAKQZiMUWFuHmkoOrPwxUwemUTGF2aMTm+LFUup5gTa8VgSAJvHz1ffmMDVwlUSTB+VbH/ZQRzCUCKe8ZOMWxeS0ilVGk4Rz2D7sRxbLnk8s8hUNEQIDM8Y0f5uQkmWGDyXivoDYj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218539; c=relaxed/simple;
	bh=VYpimcHZFMaLzg2VWqD+6ZkRv3WNtiId4G9ZeHhFH0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMBXTnZsJ0v3Sd9/f/oWLwFJhNEHDN+4iUJjsftkp6RUSQDYF+1iSo84hb1TwxarHR4MLxGbbLDdreiyJ/d1rjxDqA3P7381z1zTWt8PVQUOlLqvM0xx1fdM8OKKPBK2aYMSeEVUL+1a4w56RvUWAGs2wDpLZXdz9t8J+W1zELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=fn1cobFI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d462c91a9so4054542f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1730218534; x=1730823334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POjXesPV4dmzq7DJzXweRhoA+WDgQ1brrcjq689pb38=;
        b=fn1cobFIjxUpL800bqdTXceL8DK9D94wGFySuSlXY7kzmCBMlq3hGHCpJXLMTyOr6W
         JfVfrKIRpkkTpoQ6V0BGBtwK/EUuam09pn4sEeEwTi3hsUlNMbGG6YxXbaWfRmnJ27sC
         U1U3nsQP3qjf9slCgf7YjUHkTtgpahePTdv+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218534; x=1730823334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POjXesPV4dmzq7DJzXweRhoA+WDgQ1brrcjq689pb38=;
        b=MN5MmOc0EMo9keGrrQrgEBMznS+noN5lTrtW258wMEP/P/DBTvD8gcl0KTYRHDJuXn
         Pn+5K9h/s9g9A5bm1suA5izsHbXZT9BxDAEX1lAG9PKJ5Deb5eCd0PYEEIyfvKStuZ11
         m+1aNJ5KmZz3+ENi5gE6jYufFk4if+DNp1Xrv5vdAblsO7Dvxo/b/lS/S7nWmr4PSMAf
         tuEpZVT1zQzRY+Qvo/vI4bvLsFplsdET8BP/rDb6x/1LURYN7YZCAt1l0u7Ir7nZ8oe5
         F3HMF4j163Mh5lVC0M2+Icozu1FHPRF1yuWJHxgPP4SkwhbY+NBD7bgTsxs+LyX/cHl4
         Vs+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWH7bE6W4r55t2reqL7m0JXBRRz2vLiOogd4C6ykzQHJvuMBjGOsDDq+G1DwY8RQdVj0BdaYJ6fKXeGEaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytv5n++TE6GbtCQq0fuZv/n2ND0WaBZ5V9CvuNU2/Hgreh97ml
	emdbNRdm00u9kiPKh/KUMDlf7sC/KW/IDUQQhbtSWmne0WulBWVzrgBAO9ALIThh+8tEblaO/dt
	L
X-Google-Smtp-Source: AGHT+IEGOZ9Jprg/DrfCLDUPLS8N3hEzj27LDkjD0swuxX4Kc2moMp4pg03lb/3jVZxuAwGfhfgEfA==
X-Received: by 2002:adf:ec8f:0:b0:374:b35e:ea6c with SMTP id ffacd0b85a97d-381b70ed1c3mr133945f8f.40.1730218533749;
        Tue, 29 Oct 2024 09:15:33 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:949d:5800:e3ef:2d7a:4131:71f? (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr. [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47a41sm12966349f8f.52.2024.10.29.09.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 09:15:33 -0700 (PDT)
Message-ID: <89224e37-f97d-4f50-bc4a-95da28407328@smile.fr>
Date: Tue, 29 Oct 2024 17:15:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpmsg_ns: Work around TI non-standard message
To: Richard Weinberger <richard@sigma-star.at>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 andersson@kernel.org, upstream+rproc@sigma-star.at, ohad@wizery.com,
 s-anna@ti.com, t-kristo@ti.com
References: <20241011123922.23135-1-richard@nod.at>
 <3194112.zE8UqtGg2D@somecomputer> <Zw6suCNC62Cn4fE0@p14s>
 <3518312.cLl3JjQhRp@somecomputer>
Content-Language: fr, en-US
From: Romain Naour <romain.naour@smile.fr>
In-Reply-To: <3518312.cLl3JjQhRp@somecomputer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Richard, All,

Le 15/10/2024 à 20:00, Richard Weinberger a écrit :
> Am Dienstag, 15. Oktober 2024, 19:56:08 CEST schrieb Mathieu Poirier:
>>>> In my opinion the real fix here is to get TI to use the standard message
>>>> announcement structure.  The ->desc field doesn't seem to be that useful since
>>>> it gets discarted.
>>>
>>> This is for the future, the goal of my patch is helping people to
>>> get existing DSP programs work with mainline.
>>> Not everyone can or want to rebuild theirs DSP programs when moving to a mainline
>>> kernel.
>>
>> That's an even better argument to adopt the standard structure as soon as
>> possible.  Modifying the mainline kernel to adapt to vendors' quirks doesn't
>> scale.  
> 
> Well, I can't speak for TI.
> But I have little hope.

I'm also using an AM57xx SoC with DSP firmware and I had the same issue while
updating the kernel from 5.10 to a newer version.

remoteproc rpmsg description field changes [1] is required by the DSP firmware
based on TI-RTOS that is loaded by remoteproc using the new (as of 2013) but
still experimental RPMSG_NS_2_0 [2].

RPMSG_NS_2_0 broke compatibility with existing rpmsg structs [3] (defined in
upstream kernel) for all devices except OMAP5 and newer SoC (Newer 64bits SoC
DRA8 and Jacinto doesn’t need this change thanks to the new IPC-lld implementation).

This rpmsg description field has been added to ipcdev long time ago (14/03/2013)
and requires this kernel vendor change since then (all DSP firmware generated by
AM57xx TI SDK need it).

Note:
RPMSG_NS_2_0 is not the only vendor changes you need to rebase on newer kernels...

DSP firmware generated by TI SDK are using the vendor MessageQ API [4] that
requires AF_RPMSG socket support [5] in the kernel.
This driver was never upstreamed since the IPC 3.x is deprecated nowadays and
replaced by the IPC-lld on newer SoC (IPC-lld uses the upstream generic
rpmg-char driver).

All theses patches were moved out of ti-linux-kernel (6.1 since) to a meta-tisdk
yocto layer that is used only for am57xx vendor kernel. See the latest SDK
release for AM57xx [7].

So, DSP firmwares on AM57xx will requires theses two vendor patches since it's
how the TI IPC stack was designed more than 10 years ago.

It's nice to see newer TI SoC able to use upstream kernel using the standard
structure.

[1]
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-rt-linux-5.10.y&id=7e3ea0d62a4bf0ca04be9bc320d13f564aab0a92
[2]
https://git.ti.com/cgit/ipc/ipcdev/commit/?id=e8a33844cd2faa404e457d13f9d54478ec8129e7
[3]
https://git.ti.com/cgit/ipc/ipcdev/commit/?id=1264ed112ef8c0eed6ff30503b14f81b8ff11dd7
[4]
http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/ipc/latest/docs/doxygen/html/_message_q_8h.html
[5]
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-rt-linux-5.10.y&id=f4b978a978c38149f712ddd137f12ed5fb914161
[6]
https://git.ti.com/cgit/ti-sdk-linux/meta-tisdk/commit/?h=am57x-9.x&id=25e56a0615fb8e973e516b5a225ee81f655f98db
[7] https://www.ti.com/tool/download/PROCESSOR-SDK-LINUX-AM57X/09.02.00.133

Best regards,
Romain


> 
> Thanks,
> //richard
> 


