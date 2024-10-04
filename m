Return-Path: <linux-kernel+bounces-350366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DE6990407
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F71280CBB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E6F21D2CF;
	Fri,  4 Oct 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtuBCmo8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129C21B423
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048090; cv=none; b=EZSDQYr+7uHC8ASd59/ijLBXa/SyfItDDyAQjBdGsG4LT83MbS9GlrJ1s4/F/5DHBvUQkm+r3wVE60s8u1Dn5uaygR+toTLRzFfGsuWeTdENLG2obKX3na+MVVkN9TG8qQk2ryEObf0N6vcyQ5aiScyn/ElPyRt51OtTSsB5hcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048090; c=relaxed/simple;
	bh=uQdJ38ZRdKS5mzfNVJWQatbpXvSCCqNWPwudC+FcQ3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2aiCcEyNlO/For5E5VID379d9jw8tD7XaV0Mwsfbo/2sNtycIVDRpUjAqE6G5muZWYMo0XwOFVCu2nMojsi2PlvxHNFKCmOiq/Sz0tW9cOKNo+ZvJPBmLds29BWP9WZDcXYEbzgKyqhYAq6jang4TxL6g1zeu4EviM40yaWmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtuBCmo8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728048086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2UIepWR+azDXM2XI21WjHLnX4WwxE2FD8gQl9unO1KA=;
	b=LtuBCmo8qqg/0rw6bbg06OON9nTaFBqRLc15Sd3E+3k1UISQRVZ8tnQS/RiH0bwtukccfn
	A+53MExSHE89GT0kQSL6wk8caDhKswGeiRTt3eP5a3wExlGrL4IqH0eeP4k2uchQEu4X1P
	y+4xnkXT2kAXKZ4s27TbyL/o4FeUh30=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-9Rf8_g9oOeayH9B84DUiMg-1; Fri, 04 Oct 2024 09:21:25 -0400
X-MC-Unique: 9Rf8_g9oOeayH9B84DUiMg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20b4d8b489aso19641415ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728048083; x=1728652883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UIepWR+azDXM2XI21WjHLnX4WwxE2FD8gQl9unO1KA=;
        b=v4FRKdZMVCMPbWawi0wfMdyhl07hkv3HzQG8uazmhiGGC+zPu735SGadPrRfEI//ld
         oG5V1RwACbgqTwKOSk1XV4JJ57SOXUyyeRnv8RB2lVvYdwQVQeQiA72xOOXY6/lWi1wS
         sIzNXxf70ap9WWCf8xOkJ+ABNVx6DYEst/V6e2a7eys9Hirm10Rabsd9JX/KpXwZDVIv
         KCt/Yxp8dzubPksXRrfD8rSRTFkrIPMBhHNn1ZR9uB0sRB/Yj5tvn+gqHetndzPHAItp
         g8fquKeiPtAF9Uxy7xkHhLKSN6XPPwsHnhIoLSwndmZlnuJ0dFVa2UUPEBY4oHbSAvNr
         cRog==
X-Forwarded-Encrypted: i=1; AJvYcCUW7nLwZQsohSpOUTGUwxTV3nGFkI91CdU07fOz67Bk8slnn61OLkEwNprjuF5uAy95aMxfLgTgjpw37Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+1o5NlcH7AtTeMUz3dy6SpLeLc/Ldpps0ev/7gQKTax2D1UjO
	9cj9nu9mVTCdiuDs+Hip+L4AfIY9o9YJIuI0rv1Osr4R0zHNbclwOmu3W0OAOtkDXNXf8Pt+I17
	nmDlXdAp7xPTkCnpApgHetWb/h0MJgzLR9s3jOJNHCIUhft8Ja4bFybdAs9qVjw==
X-Received: by 2002:a17:902:dac5:b0:20b:b132:4dec with SMTP id d9443c01a7336-20bfde57e80mr47654745ad.11.1728048083540;
        Fri, 04 Oct 2024 06:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6yX1SDrKOeIEH4urURKmqoAQn45vWsdXdcXjDTbJ96B/vFkxqFrL/fI+/e8RvQY6Mi6I27Q==
X-Received: by 2002:a17:902:dac5:b0:20b:b132:4dec with SMTP id d9443c01a7336-20bfde57e80mr47654425ad.11.1728048083179;
        Fri, 04 Oct 2024 06:21:23 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef70695bsm23648605ad.273.2024.10.04.06.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:21:22 -0700 (PDT)
Date: Fri, 4 Oct 2024 09:21:19 -0400
From: Peter Xu <peterx@redhat.com>
To: manas18244@iiitd.ac.in
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Message-ID: <Zv_rz2DRYENY0K5d@x1n>
References: <20241004-fix-null-deref-v2-1-23ad90999cd1@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004-fix-null-deref-v2-1-23ad90999cd1@iiitd.ac.in>

On Fri, Oct 04, 2024 at 06:35:53PM +0530, Manas via B4 Relay wrote:
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

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick:

> ---
> Changes in v2:
> - v2: use ternary operator according to feedback
> - Link to v1: https://lore.kernel.org/r/20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2366578015ad..5ed109a8f02e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6346,7 +6346,7 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
>  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
>  {
>  #ifdef CONFIG_LOCKDEP
> -	struct address_space *mapping = vma->vm_file->f_mapping;
> +	struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
>  
>  	if (mapping)
>  		lockdep_assert(lockdep_is_held(&vma->vm_file->f_mapping->i_mmap_rwsem) ||

This can use "mapping" directly, as I mentioned in previous email (but
probably got overlooked..).

Thanks!

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

-- 
Peter Xu


