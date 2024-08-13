Return-Path: <linux-kernel+bounces-284828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD98950599
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C15B25269
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1D6199EAB;
	Tue, 13 Aug 2024 12:51:21 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20441607B9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553481; cv=none; b=YaLZ4paNpcf1BrHn8QbLznPn7ZE/GCWI1nIU3N/b2zTNYLflwTY7KN2AvViekujK2oePofIkeBLAGKDq+rHyptIIFAooAs2nHIOQgfsI3ef6TNq2EIgpT32QlaGjJb5GSCwMxB0D6EucPPz1osly1ivTfRjy9MzzT0DhXC5SdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553481; c=relaxed/simple;
	bh=Zz4ej2l76af9KsTCh8Pq32uexh5VKmSo+nsmBa3DVB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XcPsD8BHfE3fEXecMCGjQYFrWtgbS1gxG1rq7b4F6DrDUmRpJfU9xK0mjGIxwaePt9T34qhBFlD5EjEDxkeA+3mEA+zBLbf96R/sIyxRP9TDpTxnjQzhj5b5ycl6EeZSgn5JXoh8W5Qj0dZSCxVHQIMGXvFiN7TliGh/neU9zp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C56C40005;
	Tue, 13 Aug 2024 12:51:10 +0000 (UTC)
Message-ID: <28cf8a77-e9af-45e4-b178-fd7a478f9b4c@ghiti.fr>
Date: Tue, 13 Aug 2024 14:51:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: riscv syscall performance regression
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, guoren@kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
References: <738d3b74-1e10-4eb5-8c0d-1db33feb740a@intel.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <738d3b74-1e10-4eb5-8c0d-1db33feb740a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Fei,

On 23/02/2024 06:28, Wu, Fei wrote:
> Hi All,
>
> I am doing some performance regression testing on a sophgo machine, the
> unixbench syscall benchmark drops 14% from 6.1 to 6.6. This change
> should be due to commit f0bddf50 riscv: entry: Convert to generic entry.
> I know it's a tradeoff, just checking if it's been discussed already and
> any improvement can be done.
>
> The unixbench benchmark I used is:
> 	$ ./syscall 10 getpid
>
> The dynamic instruction count per syscall is increased from ~200 to
> ~250, this should be the key factor so I switch to test it on system
> QEMU to avoid porting different versions on sophgo, and use plugin
> libinsn.so to count the instructions. There are a few background noises
> during test but the impact should be limited. This is dyninst count per
> syscall I got:
>
> * commit d0db02c6 (right before the change): ~200
> * commit f0bddf50 (the change): ~250
> * commit ffd2cb6b (latest upstream): ~250
>
> Any comment?
>
> Thanks,
> Fei.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


So I finally took some time to look into this. Indeed the conversion to 
the generic entry introduced the overhead you observe.

The numbers I get are similar:

* commit d0db02c6 (right before the change): 185

*  6.11-rc3: 245

I dived a bit deeper and noticed that we could regain ~40 instructions 
by inlining syscall_exit_to_user_mode() and do_trap_ecall_u():

- we used to intercept the syscall trap but now it's dealt with in the 
exception vector, not sure if we can inline do_trap_ecall_u()
- I quickly tried to inline syscall_exit_to_user_mode() but it pulls 
quite a few functions and I failed to do so.

Note that a recent effort already inlined most of the common entry 
functions already 
https://lore.kernel.org/all/20231218074520.1998026-1-svens@linux.ibm.com/

The remaining instructions are caused by:

* the vector extension handling. It won't improve the above numbers 
because the test does not use the vector extension, but we could improve 
__riscv_v_vstate_discard() as mentioned in commit 9657e9b7d253 ("riscv: 
Discard vector state on syscalls")
* the random kernel stack offset

I'll add some performance regressions in my CI in the near future :)

Thanks,

Alex



