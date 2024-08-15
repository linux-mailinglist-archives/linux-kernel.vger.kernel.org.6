Return-Path: <linux-kernel+bounces-288239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D8D9537C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C11F21ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C861B143B;
	Thu, 15 Aug 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SkI11rOA"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B921B3F0B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737581; cv=none; b=t7fsu8JwWcAjYxL2/CJK6ya00aOvBu/ByPG5oLEzbEFI4qCEfQAMICOkUOeMRFnAtfGZBpOvn396brXGpw7s3aY+dEkPVtmvvhtGOol0BETUpdnT7wnJySTt535zsCaYFgMJ8KKy35yCQ9mxOeTvCnaNSwepRTleWi+NFPd9a/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737581; c=relaxed/simple;
	bh=MNgHIH+lkUsEt2L6I+eFso69L5v3uwKBRJthgipnp8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9z2wwAVanaZwMIQMN6KF+fXi4SFMRavLrLVdsCXe/Wo19nOGwi2ROOCyUIbwCtOvdhzUsJSuCEAxoYL8lQ2hHYkLCa1lvMOmzh0j6EkGi/uVi8+p1eVIU2glI795cqawbCX3CHYN/GLFnQULrpwYg8fUyP7pyqMiLpxCxhlpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SkI11rOA; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-81f86fd93acso39307039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723737579; x=1724342379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g4+z91zLwzol+brq2IIPZq1Ohh/pu+6NsMuoxH1a358=;
        b=SkI11rOA6ZMBXozIGSKIw4X5RO4bwoAA7e3w1/SlV0Zv8MmMLhNXU5SjjiNMb9vz/S
         89Mow9KyEAsPIrsNnOjzHRYgP9IfQAxHXqopDqxWP+BliVV194tWJdsbGda0OBxbx41b
         ERGQVMaqHBuu1mWDZjB7ElmG90SGJeLfiUGMc6ZvFkJorky3A8pwCPr0ze//6nhP42xs
         CSk0D1XtIuqUDdhaP9178HfRrYQgyKejjVHdfqqsX0RuG4XfqP/EHUQJ3AvHalx3hUNt
         A+nt4mHANS5VMdM/oc5THcOnhttaXKZnQZUYpopqVYsVMWQ8FI4+KjEPy4d/2p6AM0WX
         Jlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737579; x=1724342379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4+z91zLwzol+brq2IIPZq1Ohh/pu+6NsMuoxH1a358=;
        b=GLg1wKXo5daC3rM9WIJuX8QiTn6p5/jW3wAekzPyvvCUEBVPref60GjqrtJXw2/dJ3
         ipSK/2Dy7bdsHGjhte4P74jdAcxNTjqDpqXHq4vFBkk1p2zIUTYHcLIn22853frS9TRZ
         1lnsm936zbMrYhhZ4Jt6EZE6OUW4mIQknxtZ7y/1pp8Zw3dQ4jOmyZF3m5BNTmhjZbmY
         pNy9vwagsNUNJmcRIxxD91+gPemGBTc0FsU7nfbRccxrwzO9m4mINmDQpIh1o47uhEbL
         rscRwbX6vVvaWI90H1egme1bUMxyZGBNnavdMWY+vyLsEXr0gX/ia1YWcaMtrjaL/Qp0
         jOqQ==
X-Gm-Message-State: AOJu0YwGUOerT2hi4g/+9K8EimQnxEayxbSrMaxWZcnEDeqNlMd8hOxX
	CnajxJc7ouYgdj0HAysO3nV/PD4ZJZeb6SHgCrX5zIPnY4HZ4TK9Bl5x7ljPT5M=
X-Google-Smtp-Source: AGHT+IFNOb+TtVyiLhjQXNipwoGI8CZl3XTIEhqlZdMaV4HQw3tSJmyEeEAIBgFrQISH3pvXP4F29g==
X-Received: by 2002:a5e:df02:0:b0:81f:8825:af8f with SMTP id ca18e2360f4ac-824e76b222cmr271498539f.2.1723737579038;
        Thu, 15 Aug 2024 08:59:39 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-824e990d5b4sm57205339f.14.2024.08.15.08.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 08:59:38 -0700 (PDT)
Message-ID: <085c8332-d7f1-41df-8854-bee06291ba83@sifive.com>
Date: Thu, 15 Aug 2024 10:59:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx>
 <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx>
 <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
 <87plqalyd4.ffs@tglx> <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
 <87h6blnaf1.ffs@tglx>
 <CAK9=C2V7oL023=u6nodJs76k_0yHZ8PTJs=n1QFqDWCcCnG9kw@mail.gmail.com>
 <be1db8f5-af55-48a4-be7a-5e8a1a5e25c4@sifive.com>
 <CAJM55Z9kKqs-kMubsGsRkS6E2Y4ur1MmwD+1XFvGP=UVNrJvRg@mail.gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAJM55Z9kKqs-kMubsGsRkS6E2Y4ur1MmwD+1XFvGP=UVNrJvRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Emil,

On 2024-08-15 10:07 AM, Emil Renner Berthing wrote:
> Samuel Holland wrote:
>> On 2024-08-15 9:16 AM, Anup Patel wrote:
>>> On Thu, Aug 15, 2024 at 7:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>>
>>>> On Thu, Aug 15 2024 at 08:32, Samuel Holland wrote:
>>>>> On 2024-08-15 8:16 AM, Thomas Gleixner wrote:
>>>>>> Yes. So the riscv timer is not working on this thing or it stops
>>>>>> somehow.
>>>>>
>>>>> That's correct. With the (firmware) devicetree that Emil is using, the OpenSBI
>>>>> firmware does not have a timer device, so it does not expose the (optional[1])
>>>>> SBI time extension, and sbi_set_timer() does nothing.
>>>>
>>>> Sigh. Does RISCV really have to repeat all mistakes which have been made
>>>> by x86, ARM and others before? It's known for decades that the kernel
>>>> relies on a working timer...
>>>
>>> My apologies for the delay in finding a fix for this issue.
>>>
>>> Almost all RISC-V platforms (except this one) have SBI Timer always
>>> available and Linux uses a better timer or Sstc extension whenever
>>> it is available.
>>
>> So this is the immediate solution: add the CLINT to the firmware devicetree so
>> that the SBI time extension works, and Linux will boot without any code changes,
>> albeit with a higher-overhead clockevent device.
> 
> But this will mean that you can't update your kernel to v6.9 or newer without
> reflashing OpenSBI and u-boot. That's still a regression right?

I suppose that depends on if you think the SBI time extension is (or should have
been) mandatory for platforms without Sstc. If the SBI time extension is
mandatory, then this is a firmware bug, and not really Linux's responsibility to
work around.

If the SBI time extension is not mandatory, then Linux needs to be able to
handle platforms where the S-mode visible timer is attached to an external
interrupt controller (PLIC or APLIC), so the irqchip driver needs to be loaded
before time_init() (timer_probe()). So in that case, the bug is a Linux
regression, and we would need to revert the platform driver conversion.

Regards,
Samuel


