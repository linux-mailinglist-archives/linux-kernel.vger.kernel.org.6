Return-Path: <linux-kernel+bounces-288864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E66953FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875C31C22531
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3E34AEE5;
	Fri, 16 Aug 2024 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F0muKMew"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4840855
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775918; cv=none; b=o1t4uh81ye3h7HAt28JoU0j51fhol+nrWr2jTwbGD3M43zmfXTq55QMKlBye7Reb4Aq6kXte36J8GDNCOqwHGwyhouqcC1w7VBOZFiWmepJqwNuYNcudlIQXLBwVTxuyM4kaz6XXTy8QxiTYfMhXsCxO9xaIRv2ui2cNS40UXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775918; c=relaxed/simple;
	bh=P78B+OYBGqEJQl4cyhbCurfcxBY2SL9cXnCHcM08L+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrZsSua1Ic/qFGuxG4lXGQP3kQYYLm5pw6G+r2XL00dz6SjvwGRAhS61MIAS0fzFIA6Eoc/SUrx+MhdauLwXi2rjc0U1PwqPpuEcD96IslwfzJThtN/JqHtEH6H1Vg+L+XN1uJpHgdLhw+oiKA6v5y1exOFSD2wJbYbD1bENc4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F0muKMew; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7c3d9a5e050so1121503a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723775916; x=1724380716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nkeK/grZEPp6IQRQFIGhpI12QpEXAYnL1RbISrkxAw=;
        b=F0muKMewCaZuG5ph1Fd/qL1l/XHlK+85N87DtikUnke8GtDTGp9Kn/bon1qTgOfwwu
         Phly24lfk3fgDsYg9VLwVgL0cS6YJJE1+5mbM9UbdRAnu0agNQ/MXWnHSajli+flCIAx
         yfQNC99GWxWqqD6i9SdHHEzEgC//xuyKIxyEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723775916; x=1724380716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nkeK/grZEPp6IQRQFIGhpI12QpEXAYnL1RbISrkxAw=;
        b=YNb7ZAxDheQC+Y++XdTFHcVi5y6mkJe1wm4V/ypRl1O6Vx469uKi+qZh47d1WOWjqL
         ZZKxh1lyx20wLr9OhuvXi1mZlJhpqt8qT/KgMx2/KPQ7Y4i51C9Zb80Mpe34f1AaZ7ua
         Lzsh0rJHFYg7q52FDK4PHcBAVur63YeG9XCnftdzXnBbQ+vPUOs9DlzkQSEXA6Obxlcd
         AkGtPBmlg4EtiWcREp8fbPMrJU/jdT9+T1SP0uZO5aE27hruFjkV31rpKVRbhmWMA5e8
         cjH5I11BSEr8BTJGkGMjZcjpzi+mSxTH2lDZYk7nC8h25yYk7HvtIo6oU9tfDyJKcb/4
         8Zog==
X-Forwarded-Encrypted: i=1; AJvYcCXMfck68j3JXBMyqfTkAL3/pK+TzIw+y+E88qz8QbG/PhhJmCKPcwrnsPJHoELyzzRTl0DZud6IohrpWdZ1MFSalCJJqTbjKtABv3+K
X-Gm-Message-State: AOJu0Ywa22K/KO7eyAplzB0mJt42PcPiye6j20DiNNTkrgIHvLSMjQyV
	49/yBKusoZk+B0U2V3pO4Yz99V2dURsGFfCF2y/gZ00kDGx4sB7kgNcX2ZMa5g==
X-Google-Smtp-Source: AGHT+IGegcpN6PTlCQdus+u+voVSTHi7JDqFrQQctnE1TWePFTgJ0CP8SHDsrEvJSNpF3jUTY4JSCA==
X-Received: by 2002:a05:6a20:d493:b0:1c4:81ab:1f5e with SMTP id adf61e73a8af0-1c90503036amr2025225637.38.1723775915977;
        Thu, 15 Aug 2024 19:38:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fe02:865:f677:1481])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fb465sm16522355ad.51.2024.08.15.19.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 19:38:35 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:38:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matthew Brost <matthew.brost@intel.com>, Tejun Heo <tj@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <20240816023831.GD12106@google.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
 <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>

Hi Matthew,

On (24/08/15 16:24), Matthew Brost wrote:
[..]
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 8ccbf510880b..5e818eae092d 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -534,7 +534,7 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
>   * @fmt: printf format for the name of the workqueue
>   * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful)
>   * @lockdep_map: user-defined lockdep_map
> - * @args: args for @fmt
> + * @...: args for @fmt
>   *
>   * Same as alloc_ordered_workqueue but with the a user-define lockdep_map.
>   * Useful for workqueues created with the same purpose and to avoid leaking a
> @@ -543,20 +543,9 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
>   * RETURNS:
>   * Pointer to the allocated workqueue on success, %NULL on failure.
>   */
> -__printf(1, 4) static inline struct workqueue_struct *
> -alloc_ordered_workqueue_lockdep_map(const char *fmt, unsigned int flags,
> -                                   struct lockdep_map *lockdep_map, ...)
> -{
> -       struct workqueue_struct *wq;
> -       va_list args;
> -
> -       va_start(args, lockdep_map);
> -       wq = alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | flags,
> -                                        1, lockdep_map, args);
> -       va_end(args);
> +#define alloc_ordered_workqueue_lockdep_map(fmt, flags, lockdep_map, args...)  \
> +       alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, lockdep_map, ##args)
> 
> -       return wq;
> -}
>  #endif

Oh, I haven't checked the workqueue header.  Yes, you are right.
A macro should work.


Tejun, how do you plan to handle this?  Would it be possible to
drop current series from your tree so that Matthew can send an
updated version (with all the fixes squashed)?

