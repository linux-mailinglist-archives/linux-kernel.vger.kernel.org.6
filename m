Return-Path: <linux-kernel+bounces-561560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011F9A61379
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428B91761AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D65420011A;
	Fri, 14 Mar 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="dvYvFpA8"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AD1FF7D7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961842; cv=none; b=YVsbjboq7zbMgtCW+RurHF28R6CbgmkO6uXu/j/j3vgnUQ9beCGifthHfUyBQtD/aTTgORcANJqgJfisx2aG/lGbVIER7ZJMhAt+PDORl72MSHQqtap4DXh8erXE9UCgeLxxCqaSBoVwyQdCdZjYwc+xw29f1WOn2ASgLJsX5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961842; c=relaxed/simple;
	bh=ct4TTvaRx+bolwbvqBUFkdTE2mM6ZyMZv2IBxFNKGSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHKebZL4SuavYQAyRYWjT8hy28Lrd7SskBJ0TrDC8BWH9oGMuAbZc1A1e3nH0+MD3odRCv6npWs26jxJpr+JKLKKgQZVMVP7eaXaNiKuysTDG1dKXjQu7ktzOQOe8dlhuyPYsJFf0UwcBzUDK3bjg4gEXl93togohzOjx9YMQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=dvYvFpA8; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1zBOojnIvZ6+0aG++WWMyXS/rfcD8EpeSnNyagPabZA=; b=dvYvFpA8UnpGdxdYqfIk3Hn2bq
	kRfEwDRz/JVd5J/I5aE1/4/1mDwoXNE1uilin4Ik4A3Nlhpr92dl0AZQiixjRwC3qhHOUrsKeJn/3
	id9gl1xSGrtWPPb35b1sblc3+39OU4liSavBrca919M/5YhkZEo6hDAJStd+EPgKkEdJqzCKJAfoJ
	+nBNeY6Cid7WbG0M/hq92LeKtqBnaqq+PHNKICKm58sBpcuQpDA8mP6Ceukm6AE8AtQx0iMtMEGn3
	cUqgYAEyy3GAhh/uMmWDvgrv55CVPJ9xsBmI/jpr2uyWriZGymPIbrlSQTY+yHcda3pRBSmSDtcw5
	da55XW1g==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tt5Pe-00FJws-Mx; Fri, 14 Mar 2025 13:49:22 +0000
Message-ID: <5a81a72d-550d-42b4-8549-176f2b27ffc9@codethink.co.uk>
Date: Fri, 14 Mar 2025 13:49:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] riscv: uaccess: optimizations
To: Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
 charlie@rivosinc.com, jrtc27@jrtc27.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jszhang@kernel.org
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
 <4f6c83c0-39f6-467d-83c6-13d37440fb20@ghiti.fr>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <4f6c83c0-39f6-467d-83c6-13d37440fb20@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 14/03/2025 13:28, Alexandre Ghiti wrote:
> Hi Cyril,
> 
> On 21/02/2025 01:09, Cyril Bur wrote:
>> This series tries to optimize riscv uaccess by allowing the use of
>> user_access_begin() and user_access_end() which permits grouping user 
>> accesses
>> and avoiding the CSR write penalty for each access.
>>
>> The error path can also be optimised using asm goto which patches 3 and 4
>> achieve. This will speed up jumping to labels by avoiding the need of an
>> intermediary error type variable within the uaccess macros
>>
>> I did read the discussion this series generated. It isn't clear to me
>> which direction to take the patches, if any.
>>
>> V2:
>> I've taken on this series as there isn't any response from Jisheng. No
>> significant changes other than build fixes.
>> - Fixes build breakage in patch 3 to do with not having used 'goto' 
>> keyword.
>> - Fixes build breakage in patch 4 on 32bit not having delcared __ptr 
>> in the
>>    macro.
>>
>> V3:
>> Significant commit message rewrites.
>>   - Corrected the justification for patch 2
>>   - Better explained/justified patches 3 and 4
>> Minor code changes for legibility and more comments.
>>
>> Jisheng Zhang (4):
>>    riscv: implement user_access_begin() and families
>>    riscv: uaccess: use input constraints for ptr of __put_user()
>>    riscv: uaccess: use 'asm goto' for put_user()
>>    riscv: uaccess: use 'asm_goto_output' for get_user()
>>
>>   arch/riscv/include/asm/uaccess.h | 205 +++++++++++++++++++++++--------
>>   1 file changed, 152 insertions(+), 53 deletions(-)
>>
> Following up on Ben's comment here https://lore.kernel.org/linux-riscv/ 
> b45aab1e-6d37-4027-9a15-4fa917d806b9@codethink.co.uk/
> 
> The problem that Ben mentions is caused by the use of *macros* which 
> used to make the evaluation of the parameter inside the user-accessible 
> section, and since this parameter could be a sleeping function, we could 
> schedule another process with the SUM bit set, which could be cleared by 
> this process, which would make the first process fault when trying to 
> access user memory. I did not find any macro using unsafe_XXX() 
> functions which could cause a problem right now, but I may have missed 
> one and new could come up later, so we have multiple solutions here:
> 
> - suppose that a macro using unsafe_get/put_user() and passing a 
> sleeping function as argument won't happen and then do nothing
> - or save/restore CSR sstatus when switching processes
> - or simply check that SUM is not set when switching processes
> 
> Let me know what you think.

I'm on the save the flag side, for these reasons:

#1 sleeping functions can happen more often when various checks
    get enabled in the kernel (this was why the original fault
    was found).  Adding larger sections is just going to make
    the fault pop up again at some point in the future.

#2 the save/restore is a small addition to the swap registers

#3 saving SUM over a regs swap is always going to make sure we
    never see this gremlin turn up again

FYI, I think I may have posted our original test thread at some
point, but I could do so again.

> 
> Thanks,
> 
> Alex
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

