Return-Path: <linux-kernel+bounces-327518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A759F977712
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6AA1F2190D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9FB1B12D4;
	Fri, 13 Sep 2024 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="oXem1gET"
Received: from out187-4.us.a.mail.aliyun.com (out187-4.us.a.mail.aliyun.com [47.90.187.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9952C95
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726195878; cv=none; b=T3I5xvt3QgLnvEM1Nu7jwlP1MMfqFJPQOHyCBNLvHotB8y9K7qCdl/nnKIAn0X8dYz2X6dFPK8J1pe8XDuJ3hXyZ4q1DZ0LWZQ5kvVjV+aiQ0BymloXfyHU6QmofaTPfK9GXlDnOErU9SLf6mYcReF8JbybdanhV5Al2LsP4zBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726195878; c=relaxed/simple;
	bh=G4EmlOr+LS1+Lsc/7Al2WGatEGkS1P2AgGF7aJzx0Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuMgJ2YtaDZPYX89nyQpOibX+oGhwNk1Ymv/A/WCwJ5xQ1vitOGc9PNDrFDpQs8ZAv8tOe2gYWBQLzc7kY/VfQA9KfxGEXgN62T7Z14NguwmaXsop+cH/IPS/vUofdcPdiFFgZ9sS6m3cHxnLjthsrZgxfpI07tqull2H6h4VGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=oXem1gET; arc=none smtp.client-ip=47.90.187.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726195861; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HWH9M4UJqrJf3rT0idbSbbMprE/6p0CH3pO9dW+PNd8=;
	b=oXem1gETbaglX3JRUgxAvWXtDWY/TzmEw/R7MPVyD+O6/oTL4lTdRYXh17WEyicR90pY/WZQ7q2hPqAQliTibpUm9zAuWRrBNHjvGxnfdVR3NhF+eisme3yXJE7DVT0/zjTStKY/JsyYPFC4L/259S6w1Yl8aaabg5eJJJxDKdU=
Received: from 30.230.92.212(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZHr0TbG_1726194006)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 10:20:13 +0800
Message-ID: <e259385a-ddc5-4c93-9251-395cd1c44429@antgroup.com>
Date: Fri, 13 Sep 2024 10:20:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Fix the return value of elf_core_copy_task_fpregs
To: Richard Weinberger <richard@nod.at>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20240828135140.1015940-1-tiwei.btw@antgroup.com>
 <78364371.37121.1726167098936.JavaMail.zimbra@nod.at>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <78364371.37121.1726167098936.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/9/13 02:51, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Tiwei Bie" <tiwei.btw@antgroup.com>
>> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
>> <johannes@sipsolutions.net>
>> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Tiwei Bie"
>> <tiwei.btw@antgroup.com>
>> Gesendet: Mittwoch, 28. August 2024 15:51:40
>> Betreff: [PATCH] um: Fix the return value of elf_core_copy_task_fpregs
> 
>> This function is expected to return a boolean value, which should be
>> true on success and false on failure.
>>
>> Fixes: d1254b12c93e ("uml: fix x86_64 core dump crash")
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>> ---
>> arch/um/kernel/process.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
>> index be2856af6d4c..3cc2b663aa78 100644
>> --- a/arch/um/kernel/process.c
>> +++ b/arch/um/kernel/process.c
>> @@ -291,7 +291,8 @@ unsigned long __get_wchan(struct task_struct *p)
>> int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
>> {
>> 	int cpu = current_thread_info()->cpu;
>> +	int pid = userspace_pid[cpu];
>>
>> -	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu);
>> +	return save_i387_registers(pid, (unsigned long *) fpu) == 0;
> 
> Why a new local variable?

Thanks for the review! The new variable isn't necessary for the fix.
Will drop it to make the fix more straightforward.

Regards,
Tiwei

