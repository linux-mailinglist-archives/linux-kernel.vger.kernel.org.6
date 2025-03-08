Return-Path: <linux-kernel+bounces-552255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4CDA5779F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0DA175B43
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 02:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C21465AE;
	Sat,  8 Mar 2025 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WyslvGXS"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88845BE3
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741400560; cv=none; b=lY7fxWsy7k7BObxxv4OlK3L4MLT2ODevUuZWd3STaxJjnWCHmzfRvrUQQJlbi+IcERD855ufg8ldlk6kPzxxVNft7EkIAOCCYwJ5oRUP0W2+OU+Sbm4LL94fKF9x7/+txRoWd7NN7ZhWMOq73DNwMM2zzwir9x6VT6ex/Cg4tJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741400560; c=relaxed/simple;
	bh=L/7jaKoLREh8m9RJKqR0YdJUC506zG80lLbEZM3Eaw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHy6+fvUXDzY7uUrfe91Gs9k3XIWvTyop08hMosuHeHk6e3KyuVuk1+8CHAhlN4wlNlwQ1aJweQZUbGbrCE0vNXUGOrmSgrixy42uS8xQJtLTKMJjo/M4tcjeN8adzU+mCArlnF+1iiFjfB8Uaj1Xy0+Pa2aKDi92MhTf55A1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WyslvGXS; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fe4802f2-f81b-6e33-6ee1-af2f3771f8fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741400555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjhDoAzUW/5FGOnDp5v3OzlWQhpu3YvcufnBv3JkkCM=;
	b=WyslvGXSkVSfE45H250Oc8xhGdfep6CJ03v8xSTm1NlBuuoYFOJekXiQapFNHzVBr0sFgf
	aPVdC/D1z9yTXMwG76VmJNwp7EOEunCUVEeachPWaLqL6QiP4oU1vXiRusZzj9OS5F2cdi
	rBVZHezXAvweCUq6RmimulD3iMtv+Gw=
Date: Sat, 8 Mar 2025 10:21:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fs: binfmt_elf_efpic: fix variable set but not used
 warning
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
 kernel test robot <lkp@intel.com>
References: <20250307061128.2999222-1-sunliming@linux.dev>
 <a555rynwidxdyj7s3oswpmcnkqu57jv3wsk5qwfg5zz6m55na3@n53ssiekfch4>
 <202503071227.578545FF9@keescook>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sunliming <sunliming@linux.dev>
In-Reply-To: <202503071227.578545FF9@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2025/3/8 04:30, Kees Cook wrote:
> On Fri, Mar 07, 2025 at 03:47:28PM +0100, Jan Kara wrote:
>> On Fri 07-03-25 14:11:28, sunliming@linux.dev wrote:
>>> From: sunliming <sunliming@kylinos.cn>
>>>
>>> Fix below kernel warning:
>>> fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but not
>>> used [-Wunused-but-set-variable]
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: sunliming <sunliming@kylinos.cn>
>> The extra ifdef is not pretty but I guess it's better. Feel free to add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> Since we allow loop-scope variable definitions now, perhaps this is a
> case for defining the variable later within the #ifdef, like this?
>
>
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index e3cf2801cd64..b0ef71238328 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -1024,7 +1024,7 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>   	/* deal with each load segment separately */
>   	phdr = params->phdrs;
>   	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
> -		unsigned long maddr, disp, excess, excess1;
> +		unsigned long maddr, disp, excess;
>   		int prot = 0, flags;
>   
>   		if (phdr->p_type != PT_LOAD)
> @@ -1120,9 +1120,10 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>   		 *   extant in the file
>   		 */
>   		excess = phdr->p_memsz - phdr->p_filesz;
> -		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
>   
>   #ifdef CONFIG_MMU
> +		const unsigned long excess1 =
> +			PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
>   		if (excess > excess1) {
>   			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
>   			unsigned long xmaddr;
I think this is a good idea. I will resend this patch in this way，thanks.
>> 								Honza
>>
>>> ---
>>>   fs/binfmt_elf_fdpic.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
>>> index e3cf2801cd64..bed13ee8bfec 100644
>>> --- a/fs/binfmt_elf_fdpic.c
>>> +++ b/fs/binfmt_elf_fdpic.c
>>> @@ -1024,8 +1024,11 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>>>   	/* deal with each load segment separately */
>>>   	phdr = params->phdrs;
>>>   	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
>>> -		unsigned long maddr, disp, excess, excess1;
>>> +		unsigned long maddr, disp, excess;
>>>   		int prot = 0, flags;
>>> +#ifdef CONFIG_MMU
>>> +		unsigned long excess1;
>>> +#endif
>>>   
>>>   		if (phdr->p_type != PT_LOAD)
>>>   			continue;
>>> @@ -1120,9 +1123,9 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>>>   		 *   extant in the file
>>>   		 */
>>>   		excess = phdr->p_memsz - phdr->p_filesz;
>>> -		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
>>>   
>>>   #ifdef CONFIG_MMU
>>> +		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
>>>   		if (excess > excess1) {
>>>   			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
>>>   			unsigned long xmaddr;
>>> -- 
>>> 2.25.1
>>>
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR

