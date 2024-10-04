Return-Path: <linux-kernel+bounces-350379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CAB990456
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782A81F2145A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6C215F60;
	Fri,  4 Oct 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="PWWdnHmx"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E809215F44
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048489; cv=none; b=Auw8KL6Y/lTsl9dgUlZKXqmG4NIl4i9jCN/FEWY23Y/Ie9fD5dMAAqswfKqaFBPG8vzCS88OrxtCRseZG2Djtt0jJfkE3PTkBNHd8t+7SXaXwhwRzKjmmRT/ouLS8eD/24TEeXuqpdX4/czQ6eEgVnrBa0pUGjIJkTheM82gk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048489; c=relaxed/simple;
	bh=UNkNG8bLih8xS5nokDWWbZMzVi0ftdeLlTnEPsNL5t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiMAeKfJ6p608CByncyXhtynufDKM8yOvW4nifuYvOfc7AnflnkKnRtDDY33+CXOSBzRWzEgPGXAhjygyDye7AuQOWtr66nHqWJGQdnuNjB1fHIZJ6VmS9BnL4/yVrjD24nJHQtRGoGTNp7F3IipCeOX4fW43EvzTvUA/Kt28Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=PWWdnHmx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71dee13061dso228039b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1728048484; x=1728653284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/XyuYW22hcloSOF5PeubqI6B5GS2FJzkX02uzF2Vdc=;
        b=PWWdnHmxufWa3fQHnrnPjKLy0hLtM0dILRMmyKj8G/w3YuxocdeqKGYIlTl2+IICqo
         lfQ/EXkcKVAMTzeGOUcUx1JnwiEjZLZxyLTNwKdndpXhBxUegEnIXODS63TE7b1b3K6U
         TnKFa4wiMAb3H96WdMx7QtDQHGgXLurxWxcS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728048484; x=1728653284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/XyuYW22hcloSOF5PeubqI6B5GS2FJzkX02uzF2Vdc=;
        b=XrGSifJgNE2vTmD77m8m1DtCQEKwoS9lawYi6ntnfP9YbI4Ie/at2Z3Fx04z/nYR9y
         PKx/5wVY4aCiUmVa6b6y+pN+Iw0O3Or/24j+nJSNdJjhMsGuOiSveu+0itUxOUUSiE8b
         QFwkAySuXFWCVLA4HamZpHao0oI4Ww0ouItgUMG1pOB+FZEUDR/sfNw7w7ubkTvu6bJh
         jG5tvYdiN3hvraiZA9B1Ja0Ps4XIfQQVWwfVkKu1zfp2c3tR3RZSy23z5VYATnIBs39H
         40n8vuT37Sgwaw/vtZ6G+peiTNvJn03pjh3feRFifVT/YaffOK+ekUhTAlUfPlQdrQGp
         +nkA==
X-Forwarded-Encrypted: i=1; AJvYcCXBfeTDfuU21YWk7497LetUKSxBYIqoUfkyXh90oyJZh2Uxcb3wphJ/5D1mTm7PKKr/njU+pMW/M4ONpa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZiIa3retdfTPRXqj2z8Qb0X06FuwRbXVkOWEf1bgAw3V915gK
	133zcCxfk7Qxt8stDdWCsNa90dyj7fnWcVRTsF8SK9FnKHoYX8qGECEmafQyqDI=
X-Google-Smtp-Source: AGHT+IFrtukck/tWNOuDiKIC9Vr5Xn1b7TyPdD0qsuLFIVo2+GCHmHMPZiBEtVoIMNTJ6aY7tY0eWw==
X-Received: by 2002:aa7:88c9:0:b0:710:50c8:ddcb with SMTP id d2e1a72fcca58-71de23a57efmr4221458b3a.5.1728048484567;
        Fri, 04 Oct 2024 06:28:04 -0700 (PDT)
Received: from fedora ([103.3.204.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb049a7sm2415269a12.34.2024.10.04.06.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:28:04 -0700 (PDT)
Date: Fri, 4 Oct 2024 18:57:57 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Message-ID: <i5g3nwyjrrmbdgrecedyzhvjwl2p6b7yuniiqpyphndnkszta4@xt2dukgff3f3>
References: <20241004-fix-null-deref-v2-1-23ad90999cd1@iiitd.ac.in>
 <Zv_rz2DRYENY0K5d@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <Zv_rz2DRYENY0K5d@x1n>

On 04.10.2024 09:21, Peter Xu wrote:
>On Fri, Oct 04, 2024 at 06:35:53PM +0530, Manas via B4 Relay wrote:
>> From: Manas <manas18244@iiitd.ac.in>
>>
>> syzbot has pointed to a possible null pointer dereference in
>> pfnmap_lockdep_assert. vm_file member of vm_area_struct is being
>> dereferenced without any checks.
>>
>> This fix returns if vm_file member in vm_area_struct is NULL.
>>
>> Reported-by: syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
>> ---
>> This bug[1] triggers a general protection fault in follow_pfnmap_start
>> function. An assertion pfnmap_lockdep_assert inside this function
>> dereferences vm_file member of vm_area_struct. And panic gets triggered
>> when vm_file is NULL.
>>
>> This patch returns from the assertion pfnmap_lockdep_assert if vm_file
>> is found to be NULL.
>>
>> [1] https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
>>
>> Signed-off-by: Manas <manas18244@iiitd.ac.in>
>
>Reviewed-by: Peter Xu <peterx@redhat.com>
>
>One nitpick:
>
>> ---
>> Changes in v2:
>> - v2: use ternary operator according to feedback
>> - Link to v1: https://lore.kernel.org/r/20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in
>> ---
>>  mm/memory.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 2366578015ad..5ed109a8f02e 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -6346,7 +6346,7 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
>>  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
>>  {
>>  #ifdef CONFIG_LOCKDEP
>> -	struct address_space *mapping = vma->vm_file->f_mapping;
>> +	struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
>>
>>  	if (mapping)
>>  		lockdep_assert(lockdep_is_held(&vma->vm_file->f_mapping->i_mmap_rwsem) ||
>
>This can use "mapping" directly, as I mentioned in previous email (but
>probably got overlooked..).
>
>Thanks!
Oh no! I missed it. Sending v3...

>
>>
>> ---
>> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
>> change-id: 20241003-fix-null-deref-6bfa0337efc3
>>
>> Best regards,
>> --
>> Manas <manas18244@iiitd.ac.in>
>>
>>
>
>-- 
>Peter Xu
>

-- 
Manas

