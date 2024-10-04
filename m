Return-Path: <linux-kernel+bounces-350837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A8990A53
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE25A280DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DB71D9A78;
	Fri,  4 Oct 2024 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="ajOj/gIb"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAA1D9A6D
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063650; cv=none; b=rvQGlRAkNiD06TCdxMkwTo0KGXrNyBZMRRdh8Wyyid5teUC/57TJ4a9wyozbGOTLENjyAQZwN1LMfjtZhXVco2NL8bxhAhRyFhlQFb8B18O2hFWcv9xLphmuZ18ugwiRXdfHK/WGbUKfuxMkFdPSJXd3SiebKiH5SaYXNjzUv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063650; c=relaxed/simple;
	bh=ihsMZg9Wwb5wnkNU0osqiAc+lJizu5sHA5+TYwsmFqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo2zBoub0WCpA1W8Xs19rml4knFa4pcrsefLsH5/EY2KhQNKsnmiWIfmu9vte4M8rZLwFfJ+Oj1fwwufzc9FOq5JBnMh44gXW6SUKP/pZMSTWPrsd8Ws9Z1jH8++HmNfZvUZXNO3mniqzrHZGb9DgXYyqKf32Lv4kK/Mid5xPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=ajOj/gIb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db299608e7so1549309a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1728063646; x=1728668446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gipk7tZ2gHWfXWt09uDNRITU//gp2sMa6qCxHdj3Mzc=;
        b=ajOj/gIbkUOHGWxvx3jYk0vGH9Ys7WZcHIQ9XzA3oNqQw0Hh6TIq1FiB5+/yd/sLLs
         8orW0Uys9ClOHUSXawZG+5rehtNtbiHVvZGrG/kXDigWWmbWNzvVy9EeZFfn0+RC08PX
         R/OsTer3CkVvT5xeE+ZfKSfhQRkrbmogHlxhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728063646; x=1728668446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gipk7tZ2gHWfXWt09uDNRITU//gp2sMa6qCxHdj3Mzc=;
        b=H01eYCjhJOpSSUF1cDXk5Ofx0LijiViSfutLcvTOMXEobc9+/Bt67aphfPiAKKNQWr
         NkMn3EgX5vQjPLQutdXB7GffanssS6eNoKOBRz0lMkV6ez7nvYOWLxTkBMA6B68Lsxvy
         wh2PRdqWiDDJXda/cGMldGNe3Ir07OE+BNp7RtG+FPUKKGYm4nJIt8dCxzEEPuPsKQTl
         0AkqfdP0k49Fwl9C9YEOafvTdW+bnQeMkGfp+Kk9zyD9feyptTCtiNlBBRu+hPG/s+HM
         yrPtmNk2zrkc5keEQ7Wm0ksM1sozFuFvJRT7eT1pyb0b0JtRzZaJdhctyhCUSJxblMxD
         L7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVAjlFhGRRQTZrK9r5hbPYz3xkymIiiIuZHsKO1CxUBAaxUFIy+/iiio/D8onYGgyF9UdZviDJy2mguXtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8efLyulVCWR6ovgqiSqUfbqrjWj5Yw1x6O0zYhottjHZD5eHX
	UEkXAKgHQ/aVz12ZVT2a6T2ENpg+yGfUhvdD/8/mnhczpbDioOGinMpwdvZhgvo=
X-Google-Smtp-Source: AGHT+IGgamVQRcGOh/R/rIbHRa9Yfyqlrpw7tGzWKPgyIC71DXw8qw9b3gT+FD5JEJTsgWDm/bo/HQ==
X-Received: by 2002:a05:6a20:d492:b0:1d2:f124:a1cb with SMTP id adf61e73a8af0-1d6dfa27999mr5401546637.9.1728063646247;
        Fri, 04 Oct 2024 10:40:46 -0700 (PDT)
Received: from fedora ([103.3.204.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd5006sm123518b3a.77.2024.10.04.10.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 10:40:45 -0700 (PDT)
Date: Fri, 4 Oct 2024 23:10:37 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Message-ID: <mvf3iorotqyioegxrre67a745ewk2dhqiuttn2vfwemv5kyjh4@m2x22dnxesjr>
References: <20241004-fix-null-deref-v3-1-f9459b1cc95f@iiitd.ac.in>
 <ZwAHFtAmMq9BNuGv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <ZwAHFtAmMq9BNuGv@casper.infradead.org>

Hi Matthew,

On 04.10.2024 16:17, Matthew Wilcox wrote:
>On Fri, Oct 04, 2024 at 07:15:48PM +0530, Manas via B4 Relay wrote:
>> +++ b/mm/memory.c
>> @@ -6346,10 +6346,10 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
>>  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
>>  {
>>  #ifdef CONFIG_LOCKDEP
>> -	struct address_space *mapping = vma->vm_file->f_mapping;
>> +	struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
>
>Overly long and complex line.  Much simpler to write:
>
>	struct address_space *mapping = NULL;
>
>	if (vma->vm_file)
>		mapping = vma->vm_file->f_mapping;
>
Thank you for reviewing! I am sending v4.

>>  	if (mapping)
>> -		lockdep_assert(lockdep_is_held(&vma->vm_file->f_mapping->i_mmap_rwsem) ||
>> +		lockdep_assert(lockdep_is_held(&mapping->i_mmap_rwsem) ||
>>  			       lockdep_is_held(&vma->vm_mm->mmap_lock));
>>  	else
>>  		lockdep_assert(lockdep_is_held(&vma->vm_mm->mmap_lock));
>
>This one should have been lockdep_assert_held(&vma->vm_mm->mmap_lock).
>
>I'm not sure that the previous one is correct.  The
>lockdep_assert_held() macro is pretty careful about checking
>LOCK_STATE_NOT_HELD to avoid the LOCK_STATE_UNKNOWN possibility.
>But I'll leave that for Peter to fix.

-- 
Manas

