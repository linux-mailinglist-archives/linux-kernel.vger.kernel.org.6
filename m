Return-Path: <linux-kernel+bounces-350159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22399009B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D56E1F2356B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDCC14B092;
	Fri,  4 Oct 2024 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="YKfBlsd5"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496214AD24
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036805; cv=none; b=aaHtSRrftKi8bnm5lhPjXcUpVBlCbsXwAROTzWqpdxSTqrn/Lz4Qv/oc1cidWKQwo2wtjlFdsBXklg8xo0UcRdNgRMnTyd1h65U5cVuYWEirD6FZT9WZWFAUbfBdeo+qdjw0e5WX/hZ/j9CTcmFlyIitH3lsKibloLcETNGzXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036805; c=relaxed/simple;
	bh=wfKAsviBlVVb6S8QdL7Jq2f0uaNrbOZUXmDfvV4I/Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQQpYJ1/bIN6Pev3Oqwxe0OuYGeAwwD4hvzkBQJcWYeGn7T5Pn8mr3AvJd/vj0g2uv1utnWoFhx3pTVjUjx8FKglU4885J5fkAhsKpGOPCnRyk0tsoWBkuCkeaNZ6lVtAb6wHhqK5DoKCXqQcaX00P1OspufZAfEUKxGQFpLWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=YKfBlsd5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71dee13061dso84464b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1728036800; x=1728641600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPGRnLkJcNuyTgTIqxv1cy1FTj/54JB3cbTz2KFQ0BE=;
        b=YKfBlsd5eFfVcHpHT3iuCZh1+IF3coV8HwbACWhs327Zd4my7NXx01C6+NAEqLpavV
         NjWDzNuMWgcRe/JYcjvBMfLBJAjQrUn4D5CwdrPOq7zRtKPTYxVwJgdwObjZhOPckNNn
         2rxWBtRNYjNEMY5SLTELW9JQyeCRISejpys1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728036800; x=1728641600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPGRnLkJcNuyTgTIqxv1cy1FTj/54JB3cbTz2KFQ0BE=;
        b=Ik2v/Xx0eqV9RYcuPSIRiDKFCSMEwaFqW6CjwjGMSi8Fs+sQ1sn/VBz7rcnGbkrIpo
         nMVNmLGJ4t7FzLnMEuk6esLTJ9+kMftwhgigHCIDBLvNiXb2NCcHGcz7kY6aB0ZaYCw3
         Ofh74ZAQ1vXwVmBvkAPGzjnXTzx0ftbKoXg6ScgxSW3vTVHvM1o+E6QDJqk4NmkyX7ft
         +YGTW15EptfxBBdsWy9RBqG12B905xYvAsOz1pLRiAZF7Nr5DjTBH5/OnBcKkSa8nEST
         0Fx1A+Cy36vpOK0ysvV/2aR/blZz2CYbKswhpWX21nJUbMeut67eT7GcmOXBXf5uS3YO
         xaeA==
X-Forwarded-Encrypted: i=1; AJvYcCVkiAC2biBhDAV24kJw23L4kkDiXf0R2x4PyDJb/uT92gdULs43LcsQBCuSKJ2lRP2X62RWq4FpJ6N7GcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3zuxTPq342AvDzBhaorxLNgc7hopfsFbbBq2BRMsDE2rRyws
	VT7sMXvxvpqjdUdvRba7dgBH8iRCCM2xplwN1NKVJOiM0+6C4KlZxV/twT5Km4t2LwfL3Fjp8VS
	akA9NTw==
X-Google-Smtp-Source: AGHT+IFpDRip7ZoLiaDkcYkyz5tKjOu56kdo3ARfMFyFPFHyuu3hykcKSxokPboYpQhFfAFyTwCeFg==
X-Received: by 2002:a05:6a21:a4c1:b0:1d3:294e:65fb with SMTP id adf61e73a8af0-1d6dfa422b1mr3291408637.25.1728036799581;
        Fri, 04 Oct 2024 03:13:19 -0700 (PDT)
Received: from fedora ([103.3.204.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9defc6fsm2848697b3a.158.2024.10.04.03.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:13:18 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:43:12 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fixes: null pointer dereference in pfnmap_lockdep_assert
Message-ID: <x4zctv3fdymenonaao2vwsy6ldab6d6pfappdzepfcax6ycc4n@nx46w3lncvqr>
References: <20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in>
 <Zv7JPl_1mxNkvLQy@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <Zv7JPl_1mxNkvLQy@x1n>

Hi Peter, thanks for reviewing.

On 03.10.2024 12:41, Peter Xu wrote:
>On Thu, Oct 03, 2024 at 09:31:06PM +0530, Manas via B4 Relay wrote:
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
>Thanks for the patch!
>
>> ---
>>  mm/memory.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 2366578015ad..b152a95e543f 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -6346,6 +6346,9 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
>>  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
>>  {
>>  #ifdef CONFIG_LOCKDEP
>> +	if (!vma->vm_file)
>> +		return;
>> +
>
>Hmm I guess I wasn't careful enough here as I was mostly only thinking
>about file mappings, but I just notice we have other pfnmaps like the vvar
>mappings.. the mapping var can also already be reused later when available.
>
>Logically even if !vm_file we can still check against mmap write lock.  So
>would it be better to do this instead:
>
>        struct address_space *mapping = vma->vm_file && vma->vm_file->f_mapping;
>
This will lead to `-Wint-conversion` error in the assignment. We can either do a
cast like the following:

         struct address_space *mapping = (struct address_space *)(vma->vm_file && vma->vm_file->f_mapping);

But I am not sure if it is the canonical way of doing it. It will also lead to
warning about pointer from integer casting.

Or will a conditional like this work here?

         struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
       
>        if (mapping)
>                lockdep_assert(lockdep_is_held(&mapping->i_mmap_rwsem) ||
>                               lockdep_is_held(&vma->vm_mm->mmap_lock));
>        else
>                lockdep_assert(lockdep_is_held(&vma->vm_mm->mmap_lock));
>
>?
>

>>  	struct address_space *mapping = vma->vm_file->f_mapping;
>>
>>  	if (mapping)
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
>>
>
>-- 
>Peter Xu
>

-- 
Manas

