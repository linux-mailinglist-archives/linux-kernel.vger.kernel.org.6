Return-Path: <linux-kernel+bounces-231947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 793E191A0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B6FB21B15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF286CDC0;
	Thu, 27 Jun 2024 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BB0bpfRP"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D055896
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474296; cv=none; b=DFBek1tJlwZi14Bwjye3SgtaBBzwCYMY4a/7YZnQtVjlXsD/iwfSoZeHidv/GXS0PJWj86Fx9Z0SC4H5b9DUHi1ldolnyUnpzG9ggBCk5NDYIQuXkVwjQn0UmeXIMPqkt9U5DqwkQK58ArDRVL1H/JItS6Abty5lCSbG9FVzleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474296; c=relaxed/simple;
	bh=8qOWdDXB9HSQPbqMtdP0Y+Izjr8HhvZjxiOuhXLbJiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5vY4kFhlvBJFcHeOPKInPzDLX8kmv6cIxyGbsJcRH/8sbg33FjoXEpH3Z/9HSQykxwQIk+SSGh717sj+ltvAnF4OGU2dc4rAcLSVUOb47/qq9V8OV6OOVySTNUAl4ETmdfZ0CGD9IbYRUvQLp4BvXuN5f6Hitl1lSyUTJLE/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BB0bpfRP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec5779b423so55066201fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719474292; x=1720079092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3I2peLbwqTMNwRMsXiUshwxensjYJkxOB4bxai6nNc=;
        b=BB0bpfRPeTtj0/Qn1gAMUArlOJdoTBhWMG69CE/sI6uIIRZ37QPOoyBta+QOwll1sc
         aA/eDVKmEjNpdwoo3pYYjjCcBDr6xTTVuBAEpbDRUU3WAkdKc3m2tB9HDoUwlV9Mf4fn
         3LBsGuXz5dtEn/Y/gEMx6wQh/JUK3o87bDePsnUb0riliJt6wp1dMi2MUOas1AdKlfb/
         VUmzkUthUOKbXAMLGUX1fB77OeEo8MyZObNB2GAB/4bs+rOKzL0xc4WEpehofjNSdOjd
         Gl1Br4zhHWXKofpIB6q51XrlkQGqyCoxiEDpfmzOMNDd+CKqJ8pL7WNUUNpT2xwjZt9e
         Rjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719474292; x=1720079092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3I2peLbwqTMNwRMsXiUshwxensjYJkxOB4bxai6nNc=;
        b=BSoqapYb3gmu1+/fG+o6b7w62NEftfki7i8OvAeNFJpK7rVDw6sa/T6/64x7puwim0
         HttDMsPN4SCguXv4q0r8OykZmDcxydlU8EIzSR4d2otvDshTdng8sz7ee2PP+qJY5iga
         9ObdfQFP11qK1wHqp1K1qyuBozylLhYOyHECBv1aHfKp76y3P03VVfXUj/qmhwl0fy7Q
         uDjuiyosK0Yi6P8pjlY9vHdvSdl9gvufXb9yQoP+7pBW9KscfVXQYNeAhhhRJlB3NQXp
         11fakTGSSAO/SZVtpiLsviqfoqMh3K/3SJMeC+OetWijUMKCKndOHpUwHkACPJ2NAGEj
         1kdA==
X-Forwarded-Encrypted: i=1; AJvYcCWFNH4wYHYZvmycyu/t/iO1hAm7pIP84lNVx0Dwe6QNinOlOSwEQyknsNPtS3S+mTMRi+S7jyuJkKBtGHTVNpGLV6h6ZbTNhpsfeptk
X-Gm-Message-State: AOJu0Yz0jLuSRQLVTT4yAIlWv0MDjzqTRTS1x57J5hutsm+5Ry3B4IT5
	Wx19i6kEmzw2nNumZau3F95MM3G2OVep6dVxsP2Q4DCS3cQIt2x6kNdYUIn7RdxDS8z4ke74Xok
	b
X-Google-Smtp-Source: AGHT+IHN6b8remGnruz33Lh9lJ+g+CR4br0qQiPLB5CmxCILz/0fH0ZmVP9+qqLqluSITysBIrrOlQ==
X-Received: by 2002:a2e:bc04:0:b0:2ec:5964:9c0d with SMTP id 38308e7fff4ca-2ec5964a0f6mr132227091fa.0.1719474291847;
        Thu, 27 Jun 2024 00:44:51 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d12824d7sm521542a12.30.2024.06.27.00.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:44:51 -0700 (PDT)
Date: Thu, 27 Jun 2024 09:44:51 +0200
From: Michal Hocko <mhocko@suse.com>
To: alexjlzheng@gmail.com
Cc: akpm@linux-foundation.org, brauner@kernel.org, axboe@kernel.dk,
	oleg@redhat.com, tandersen@netflix.com, willy@infradead.org,
	mjguzik@gmail.com, alexjlzheng@tencent.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: optimize the redundant loop of
 mm_update_next_owner()
Message-ID: <Zn0Yc8Zd3gQDnDll@tiehlicka>
References: <20240620152744.4038983-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620152744.4038983-1-alexjlzheng@tencent.com>

On Thu 20-06-24 23:27:45, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> When mm_update_next_owner() is racing with swapoff (try_to_unuse()) or /proc or
> ptrace or page migration (get_task_mm()), it is impossible to find an
> appropriate task_struct in the loop whose mm_struct is the same as the target
> mm_struct.
> 
> If the above race condition is combined with the stress-ng-zombie and
> stress-ng-dup tests, such a long loop can easily cause a Hard Lockup in
> write_lock_irq() for tasklist_lock.
> 
> Recognize this situation in advance and exit early.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>

Even if this is not really a full fix it is a useful stop gap to catch
at least some cases.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> Changelog:
> 
> V2: Fix mm_update_owner_next() to mm_update_next_owner() in comment
> ---
>  kernel/exit.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f95a2c1338a8..81fcee45d630 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -484,6 +484,8 @@ void mm_update_next_owner(struct mm_struct *mm)
>  	 * Search through everything else, we should not get here often.
>  	 */
>  	for_each_process(g) {
> +		if (atomic_read(&mm->mm_users) <= 1)
> +			break;
>  		if (g->flags & PF_KTHREAD)
>  			continue;
>  		for_each_thread(g, c) {
> -- 
> 2.39.3
> 

-- 
Michal Hocko
SUSE Labs

