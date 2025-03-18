Return-Path: <linux-kernel+bounces-565759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D68A66EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F023B62C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B822040AD;
	Tue, 18 Mar 2025 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="pq5bzkLi"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D61993B2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287412; cv=none; b=XF9BCbMJBwlfkqxn3Ml58KkgHmOU0e/EsMjKwxUHWbwCFONqBdwl4OfPWW+BXpWvn5OLR4rDaGLEkRtZ6xPKj3PwuFtzUHCoNSRzPCeAvioDpKk8WI/Ry6ReUI0u1SiT0ydr8/FjS80d7StfB9Ld3bOB2X4puRnLlDR8AZZdLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287412; c=relaxed/simple;
	bh=3kae9PDchkzx2XRsRhSJiA5Y2AzPkdgojbRNeLN+k9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGwKkt9mkflHfvS97GhO86A9eYMZGF8B/NegWPOEWke8ytAbGxFThDsrnApS6r6zIVoGBMrJhZuGHqHjm2zCB/blzEsC86v0j8c5FbGBXUvo/tzgZm1pKWL/obUWKGKBOY38vCqBgjZI7wD/KNPLNlFR4N12CcF9JTCJw408v88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=pq5bzkLi; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bVnYcV85zatttdVWEcG8loEvcr+gkH1XrFyQXfytOEI=; b=pq5bzkLi3D0CWPwuv9eCvPRhx1
	tCNPOD1necWsIdsHZ7mNeoTxY6vDKFAeCp8u+y3myCBHn53mQPwWgLffQQYp5dV+9N8fCsTGZk2+t
	aeQZsX7+tco6n03o/0wp6Q+HY9kSfhHQzHyR9srPuF8D4N0tELFdjBVDCPuLzJ3lmtUOXUx9cO1EH
	ef4QGphUwCc0fmsuGHyiehhTT+lDNAX5eH9IilBLbtjipWGd+mQ3/Cwgw0cdy9jdVWUW3VKO2ulSL
	XSr2G7USZnrEna9f8N7i9qurQ1r5SxGLYoHdG1pDGa6HJ+hRc4rgiukMauv9K+X5A9fWt0bghuKO3
	c7w6BZ7w==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tuRuL-00HYKY-Gg; Tue, 18 Mar 2025 08:02:41 +0000
Message-ID: <8ee4944a-01d3-49e7-8934-e4a866ccc628@codethink.co.uk>
Date: Tue, 18 Mar 2025 08:02:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v3 0/4] riscv: uaccess: optimizations
To: Cyril Bur <cyrilbur@tenstorrent.com>, Alexandre Ghiti <alex@ghiti.fr>,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
 charlie@rivosinc.com, jrtc27@jrtc27.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jszhang@kernel.org
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
 <4f6c83c0-39f6-467d-83c6-13d37440fb20@ghiti.fr>
 <5a81a72d-550d-42b4-8549-176f2b27ffc9@codethink.co.uk>
 <ac5b93be-5b9c-4d39-bce6-a78032e43fbf@tenstorrent.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <ac5b93be-5b9c-4d39-bce6-a78032e43fbf@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 17/03/2025 23:52, Cyril Bur wrote:
> 
> 
> On 15/3/2025 12:49 am, Ben Dooks wrote:
>> On 14/03/2025 13:28, Alexandre Ghiti wrote:
>>> Hi Cyril,
>>>
>>> On 21/02/2025 01:09, Cyril Bur wrote:
>>>> This series tries to optimize riscv uaccess by allowing the use of
>>>> user_access_begin() and user_access_end() which permits grouping 
>>>> user accesses
>>>> and avoiding the CSR write penalty for each access.
>>>>
>>>> The error path can also be optimised using asm goto which patches 3 
>>>> and 4
>>>> achieve. This will speed up jumping to labels by avoiding the need 
>>>> of an
>>>> intermediary error type variable within the uaccess macros
>>>>
>>>> I did read the discussion this series generated. It isn't clear to me
>>>> which direction to take the patches, if any.
>>>>
>>>> V2:
>>>> I've taken on this series as there isn't any response from Jisheng. No
>>>> significant changes other than build fixes.
>>>> - Fixes build breakage in patch 3 to do with not having used 'goto' 
>>>> keyword.
>>>> - Fixes build breakage in patch 4 on 32bit not having delcared __ptr 
>>>> in the
>>>>    macro.
>>>>
>>>> V3:
>>>> Significant commit message rewrites.
>>>>   - Corrected the justification for patch 2
>>>>   - Better explained/justified patches 3 and 4
>>>> Minor code changes for legibility and more comments.
>>>>
>>>> Jisheng Zhang (4):
>>>>    riscv: implement user_access_begin() and families
>>>>    riscv: uaccess: use input constraints for ptr of __put_user()
>>>>    riscv: uaccess: use 'asm goto' for put_user()
>>>>    riscv: uaccess: use 'asm_goto_output' for get_user()
>>>>
>>>>   arch/riscv/include/asm/uaccess.h | 205 ++++++++++++++++++++++ 
>>>> +--------
>>>>   1 file changed, 152 insertions(+), 53 deletions(-)
>>>>
>>> Following up on Ben's comment here https://lore.kernel.org/linux- 
>>> riscv/ b45aab1e-6d37-4027-9a15-4fa917d806b9@codethink.co.uk/
>>>
>>> The problem that Ben mentions is caused by the use of *macros* which 
>>> used to make the evaluation of the parameter inside the user- 
>>> accessible section, and since this parameter could be a sleeping 
>>> function, we could schedule another process with the SUM bit set, 
>>> which could be cleared by this process, which would make the first 
>>> process fault when trying to access user memory. I did not find any 
>>> macro using unsafe_XXX() functions which could cause a problem right 
>>> now, but I may have missed one and new could come up later, so we 
>>> have multiple solutions here:
>>>
>>> - suppose that a macro using unsafe_get/put_user() and passing a 
>>> sleeping function as argument won't happen and then do nothing
>>> - or save/restore CSR sstatus when switching processes
>>> - or simply check that SUM is not set when switching processes
>>>
>>> Let me know what you think.
>>
>> I'm on the save the flag side, for these reasons:
>>
>> #1 sleeping functions can happen more often when various checks
>>     get enabled in the kernel (this was why the original fault
>>     was found).  Adding larger sections is just going to make
>>     the fault pop up again at some point in the future.
>>
>> #2 the save/restore is a small addition to the swap registers
>>
>> #3 saving SUM over a regs swap is always going to make sure we
>>     never see this gremlin turn up again
>>
>> FYI, I think I may have posted our original test thread at some
>> point, but I could do so again.
> 
> Yes, after Ben pointed out the issue I came to the conclusion we 
> probably want Bens patch which saves the bit. Apologies if I didn't 
> express this thought in email.
> 
> I'm happy to take the patch and put it on the front of this series, 
> although perhaps it makes more sense you to revive the patch since 
> you're still around Ben?

Yes, I'm currently very busy so happy for someone else to get this
merged and tested.

We could do with some better testing on whether we leak flags on
task switches (possibly), but that's a side quest and not for now.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

