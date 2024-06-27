Return-Path: <linux-kernel+bounces-231953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D691A0C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843FA1C21293
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D06BFB5;
	Thu, 27 Jun 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L0MhL9l6"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38936134
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474550; cv=none; b=Xq5Hqo53ni5YzkLR5p3wZCtaxf9P+T/RanHnGidMNRDcxYkk3TkoorAU1j5lZEKVgj2N8h7NaWL1zAIrzhBVUv1OC0YjEHiGJ0mbPi2iX94Q7WHUe3NCsPXtjrNKBiBhDSAZrK5AvH91Nsn3hlU5oxYJwgnQgtz5/UkJ7k9aJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474550; c=relaxed/simple;
	bh=zrC4+12RUb0agQa6jKlw3FI0NsxKRHWfNJL8To7AV1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR5r1BQL+lzS+/z7zeMvd/2d5iKusgFEvNKm35NKcFchceKrpBFomRLmcm1ZmAYX22p3CGezFT9iiPevrnMNHpsbPD/Rca/SoNLWvSFx3ETOxQrQRlPQlV7Egd3rtljhQnpObpO/Q4cKlmDnGTLJyqC3NueVMf+NU86wZu++4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L0MhL9l6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d07673185so1379767a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719474546; x=1720079346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0qr1g3J2CoiFAeYg4LCEdk8NhgStrl4piJOqO3A1/Y=;
        b=L0MhL9l6w1exO5hKrl8bed/0JvZ7Eci9/QcrGh2TQVW7IrHOcIG/foQ7ISnG5yoaxl
         R+gAylStHN60OT2z9n43ya4NpCSQCmKru+oOyvY+MdXu0eJLW1PbFcjVBeC7aw8NCgcQ
         zsazIwr3uW8jcsIxKyXACa3e9mU86i3FabxPKZg3q3wuwL0eqmpppOSVbgurH+fnjj8g
         sl/+hJdsgGzi9hmyU32qncUdBUQmw4GdaWQ2i6jc3hHkkfFdDwR4sFypLlc1rtFSGjpV
         MSlXDhwZtPhjJpv9vp77eYlENWVuDxTmowlSA8QjJBaXhG3UHm69vqyAlaTbhpoQxMj9
         PbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719474546; x=1720079346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0qr1g3J2CoiFAeYg4LCEdk8NhgStrl4piJOqO3A1/Y=;
        b=fsGPPtjBU2F35x9Ex4oExyrLq0bzmcg69LEtWyEzSJl4HIwyt0E0oNwtkbyTyZwXJ7
         iB9t+a0DOJJmbvScs/LssD4SH3R1Wn/uDnl5yPk6SXMEPHWSB6cCF9l2xbYvRK0eXP6/
         tEzycpT91gkehQgGsVPGGo9ydYcMS0Bn8va2Mkgq+9avC8KCrtRJDMx2zJaA+vc+gAmy
         kPAYqUIVwDxJAqPkv07LSkQFCoLQV4ljHuKL6xmZLwuZRCR5JBuGukrRk+XqvE3qqFEM
         Z3T939HuZaFjlH/NtXHa1+FhfltomUNn14jvybw3urSxEKKh16cs6bmBqmAFF7QjAkB4
         1CBA==
X-Forwarded-Encrypted: i=1; AJvYcCVqNk9/zKqY0PqorfJW6zXK+3t+jA2hye5dD2rnpxvo6QmVWnALV9FBqmdgUNIwV8On9DrMlfjanhZEJiBR8eaULcgWunsL7F30SuNP
X-Gm-Message-State: AOJu0YwrjZrAWBb0HKo/hJVcZNk6SsC8uq78gcyROT/xyk6tnxWpUHV9
	zyA1Z5j/k6XS8TVS9xOrBn6ibJ8yinVOUr0sn70JpkhIHF2PUpHPDIm4E1rGsH2O6FYFBj3mKcb
	x
X-Google-Smtp-Source: AGHT+IEVVfYndGynimeWdaFvn9OJeXU2JhXBIcI34eGLJMdck+CXu/uVwQBuXXs4Rt9mcsHqdg5iFg==
X-Received: by 2002:a05:6402:1d52:b0:57d:5e33:371a with SMTP id 4fb4d7f45d1cf-57d5e3337cfmr11499744a12.39.1719474546316;
        Thu, 27 Jun 2024 00:49:06 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d0c9df6fsm527707a12.6.2024.06.27.00.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:49:06 -0700 (PDT)
Date: Thu, 27 Jun 2024 09:49:05 +0200
From: Michal Hocko <mhocko@suse.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_task_mm: check PF_KTHREAD lockless
Message-ID: <Zn0ZcZRqejmSRqsZ@tiehlicka>
References: <20240626191017.GA20031@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626191017.GA20031@redhat.com>

On Wed 26-06-24 21:10:17, Oleg Nesterov wrote:
> Nowadays PF_KTHREAD is sticky and it was never protected by ->alloc_lock.
> Move the PF_KTHREAD check outside of task_lock() section to make this code
> more understandable.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  kernel/fork.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4c361d2bdc12..d3dc623a1247 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1536,14 +1536,13 @@ struct mm_struct *get_task_mm(struct task_struct *task)
>  {
>  	struct mm_struct *mm;
>  
> +	if (task->flags & PF_KTHREAD)
> +		return NULL;
> +
>  	task_lock(task);
>  	mm = task->mm;
> -	if (mm) {
> -		if (task->flags & PF_KTHREAD)
> -			mm = NULL;
> -		else
> -			mmget(mm);
> -	}
> +	if (mm)
> +		mmget(mm);
>  	task_unlock(task);
>  	return mm;
>  }
> -- 
> 2.25.1.362.g51ebf55
> 

-- 
Michal Hocko
SUSE Labs

