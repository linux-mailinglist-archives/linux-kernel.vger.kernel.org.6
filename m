Return-Path: <linux-kernel+bounces-401240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F39C178E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBF6B218B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22AC1D2B05;
	Fri,  8 Nov 2024 08:12:08 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868B7DA95
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053528; cv=none; b=FahiFrzbbLG9Dbhnm9OlC7O60gYIWuYFodrUkl7OTK1R90z+S7+o6Sn6E/ZQj+0TAgdi/JjIilBRU5qpQL/pw2tfokvfKxSqRZo0faC+YiChq3F2ZCLFV6DAX81+2H6Fao3OphhXodO4ebQSsAmkCrpHiAdgXat8h57u0Coistc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053528; c=relaxed/simple;
	bh=lexQ0z5VgNggYkHp6VFeGJ7u/ajNPKEtH9zbswAwx0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCVF0Hl64jTYYR7TLRV+/gnHMSoS0YVU0OtTgImYqP5b+oIcEXQKx8OPpAC6f0An2zZQ5OV+sy5g/sJ9yagAiNDLExrsKpBt/oPdv7nXgyGgoU5qexHSj7CFFH7rAMpwl0kTdDzrv/easT8u0lLp9wOWuCEGXBVKjEF8Mwd81EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XlBVr5PvJz9sSL;
	Fri,  8 Nov 2024 09:12:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7eDBIlK95skM; Fri,  8 Nov 2024 09:12:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XlBVr4bf2z9sSK;
	Fri,  8 Nov 2024 09:12:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BDE28B77B;
	Fri,  8 Nov 2024 09:12:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 72UkeJnZvjjl; Fri,  8 Nov 2024 09:12:04 +0100 (CET)
Received: from [192.168.232.200] (PO21514.IDSI0.si.c-s.fr [192.168.232.200])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 279148B77A;
	Fri,  8 Nov 2024 09:12:04 +0100 (CET)
Message-ID: <8bd5e396-7583-435e-bafc-7d092a31f4ff@csgroup.eu>
Date: Fri, 8 Nov 2024 09:12:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
To: Mike Rapoport <rppt@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jinjie Ruan
 <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Liu Shixin <liushixin2@huawei.com>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com> <877cbr7qed.ffs@tglx>
 <50551f21-6e90-3556-7a3d-8b81a042f99c@huawei.com> <87a5gm5tb3.ffs@tglx>
 <ZtuPSIFsV8C3UZW8@bombadil.infradead.org>
 <Zuv0nmFblHUwuT8v@bombadil.infradead.org> <ZvJomuNWjtHYDcsW@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZvJomuNWjtHYDcsW@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luis,

Le 24/09/2024 à 09:22, Mike Rapoport a écrit :
> On Thu, Sep 19, 2024 at 02:53:34AM -0700, Luis Chamberlain wrote:
>> On Fri, Sep 06, 2024 at 04:24:56PM -0700, Luis Chamberlain wrote:
>>> On Thu, Sep 05, 2024 at 11:44:00AM +0200, Thomas Gleixner wrote:
>>>> Now you at least provided the information that the missing cleanup in
>>>> the init() function is not the problem. So the obvious place to look is
>>>> in the module core code whether there is a failure path _after_
>>>> module->init() returned success.
>>>>
>>>> do_init_module()
>>>>          ret = do_one_initcall(mod->init);
>>>>          ...
>>>> 	ret = module_enable_rodata_ro(mod, true);
>>>> 	if (ret)
>>>> 		goto fail_mutex_unlock;
>>>>
>>>> and that error path does _not_ invoke module->exit(), which is obviously
>>>> not correct. Luis?
>>>
>>> You're spot on this needs fixing.
>>
>> Christophe, this is a regression caused by the second hunk of your commit
>> d1909c0221739 ("module: Don't ignore errors from set_memory_XX()") on v6.9.
>> Sadly there are a few issues with trying to get to call mod->exit():
>>
>> - We should try try_stop_module()  and that can fail
>> - source_list may not be empty and that would block removal
>> - mod->exit may not exist
>>
>> I'm wondering if instead we should try to do the module_enable_rodata_ro()
>> before the init, but that requires a bit more careful evaluation...
> 
> There is ro_after_init section, we can't really make it RO before ->init()
>   

Surprisingly I never received Luis's email allthough I got this answer 
from Mike that I overlooked.

So coming back here from 
https://lore.kernel.org/all/ZyQhbHxDTRXTJgIx@bombadil.infradead.org/

As far as I understand, indeed once init is called it is too late to 
fail, right ? Especially when the module has no exit() path or when 
CONFIG_MODULE_UNLOAD is not built in.

So the only thing we can do then is a big fat warning telling 
set_memory_ro() on ro_after_init memory has failed ?

Maybe we should try and change it to RO then back to RW before calling 
init, to be on a safer side hopping that if change to RO works once it 
will work twice ?

Christophe

