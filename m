Return-Path: <linux-kernel+bounces-349323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B29C98F455
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC214B2155F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C11A705A;
	Thu,  3 Oct 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyLqf/yW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DD1A4E9F
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973703; cv=none; b=sDyL/2xVU7yjV5xx+Co/MOeTU06PDwDoJujdE2gsd0CiW3zE4O6OkVJ2vvRb8royJI0wEFad+hU9w9q9ksAsgmnQPz/vLDCchMEuxXiLVWVQCroJ2K8Jl4BL4tuJFQQIojFdj2CGU1V/3hl9zcKYkMCLlPmNSCN9XsF9iZ74+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973703; c=relaxed/simple;
	bh=PPlyf5L8dIc8IqoTuYYer0mJXZjPDPDkLk0E1g+2qmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tX+LQWFc2+Dla5h3BbLmSwLgvoS0WbdMwxCcTLZbY9ml4Ctv270WXsl49JbJmnZ7mHe4otslTRP5yFmnhxxlg/NS8wLkdV3GPUQCKV8NL1Cw5DjXocdsVBwuMgtv4OQX+FkrT+DapqHjNCZKUaDfBEoI4Whgm8CZ4eD/mD8Jq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyLqf/yW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727973699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i4RPhXrw0webQyDTYGk2kJQMxVsljkKK22sGx5B1Nek=;
	b=IyLqf/yWYkPazzvgjMa2orvi6mw1EWCboSW9OPpgAqhgKzstOlcT3okZ5GoV4WyMx2L7OC
	ZnxYJYDigQEc/AaX3v3nW/C1fSpayq9HuokDDLdG2u7wM31+2yNTmQJgWK4Ywt/mruGp8E
	3oRMudX1NCr4qGObsVeAVtfr/z0g1ZY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-1IVJVQkoMm2GzeeqJJlJww-1; Thu, 03 Oct 2024 12:41:38 -0400
X-MC-Unique: 1IVJVQkoMm2GzeeqJJlJww-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e05074e733so946909b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 09:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727973697; x=1728578497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4RPhXrw0webQyDTYGk2kJQMxVsljkKK22sGx5B1Nek=;
        b=B0rKp+34sy36/MRoE7d+VKUOEM8dm6Vtm9AKVoJ7dsKbU6p/1Fk6pojk6R/fGIXcAN
         0Zu3ENyqCR6eUIhBcP0MeOylbd6L79KQTaN2s6UTHExiHs4AK9k1UGIUDhXdE2nmhUZH
         RxS8guIr2WSeamGeRtgn9dwb942Cn0FVPF8L09aNgDO/QtKJf1lLGWtGdG1swPvPMm67
         buTTMaXa+BtP0XEddPjOBt8TztkltDxfeaKbBWc3rwbp/CH34ebf90dTBrlMjOw38B2k
         cmaOg+lDtG2JEPUguuCFa2ZjwVVJNHgIBX1ThwBpyYJQXxrI1O9cPrOy0O1bSFdJyZ8k
         bYfw==
X-Forwarded-Encrypted: i=1; AJvYcCVOOQT3rA08RRfJJVdWP78MkhE/prf3FKvuivXlvXzlZ9j3O29PXV7/gGAL9trPrrwT6AfBDeSrFVvTGNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrbax9olF9zgbE/WhgLPHk6ELvCwp5N9z5rzh0mNA8uXZrJUpv
	d47GVL7Te5wSzq2/K0ZRkuGVMQocXGmEHkJWoAjCIAXwL0fCoppZ5GyPWb63SXyOFCP4WRzAysD
	uZPxRZctETuOR/F46yiJ12x6e8VHwntUAiPs7ym7lCdNMF+YLaYMiuSXPq4mgtQ==
X-Received: by 2002:a05:6358:5248:b0:1b8:211a:e7b3 with SMTP id e5c5f4694b2df-1c0cecddc0cmr387132955d.5.1727973697460;
        Thu, 03 Oct 2024 09:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF06ajgfDGfBlgYiqbs/9DaUSZVIe5gMGYodnUFNrLxqUpmAklXMpk0Fqbrd4FZ5ccOWmqzyA==
X-Received: by 2002:a05:6358:5248:b0:1b8:211a:e7b3 with SMTP id e5c5f4694b2df-1c0cecddc0cmr387131055d.5.1727973697017;
        Thu, 03 Oct 2024 09:41:37 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b39a6f8sm63735385a.41.2024.10.03.09.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:41:36 -0700 (PDT)
Date: Thu, 3 Oct 2024 12:41:34 -0400
From: Peter Xu <peterx@redhat.com>
To: manas18244@iiitd.ac.in
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fixes: null pointer dereference in pfnmap_lockdep_assert
Message-ID: <Zv7JPl_1mxNkvLQy@x1n>
References: <20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in>

On Thu, Oct 03, 2024 at 09:31:06PM +0530, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> syzbot has pointed to a possible null pointer dereference in
> pfnmap_lockdep_assert. vm_file member of vm_area_struct is being
> dereferenced without any checks.
> 
> This fix returns if vm_file member in vm_area_struct is NULL.
> 
> Reported-by: syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
> ---
> This bug[1] triggers a general protection fault in follow_pfnmap_start
> function. An assertion pfnmap_lockdep_assert inside this function
> dereferences vm_file member of vm_area_struct. And panic gets triggered
> when vm_file is NULL.
> 
> This patch returns from the assertion pfnmap_lockdep_assert if vm_file
> is found to be NULL.
> 
> [1] https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
> 
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

Thanks for the patch!

> ---
>  mm/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2366578015ad..b152a95e543f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6346,6 +6346,9 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
>  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
>  {
>  #ifdef CONFIG_LOCKDEP
> +	if (!vma->vm_file)
> +		return;
> +

Hmm I guess I wasn't careful enough here as I was mostly only thinking
about file mappings, but I just notice we have other pfnmaps like the vvar
mappings.. the mapping var can also already be reused later when available.

Logically even if !vm_file we can still check against mmap write lock.  So
would it be better to do this instead:

        struct address_space *mapping = vma->vm_file && vma->vm_file->f_mapping;

        if (mapping)
                lockdep_assert(lockdep_is_held(&mapping->i_mmap_rwsem) ||
                               lockdep_is_held(&vma->vm_mm->mmap_lock));
        else
                lockdep_assert(lockdep_is_held(&vma->vm_mm->mmap_lock));

?

>  	struct address_space *mapping = vma->vm_file->f_mapping;
>  
>  	if (mapping)
> 
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20241003-fix-null-deref-6bfa0337efc3
> 
> Best regards,
> -- 
> Manas <manas18244@iiitd.ac.in>
> 
> 
> 

-- 
Peter Xu


