Return-Path: <linux-kernel+bounces-517966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A0A38821
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5461888EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1D2253F2;
	Mon, 17 Feb 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RcsCqdHR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B2224B0D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807300; cv=none; b=VxLqbyDWMTa2wg9/5bsZJiGcoLHigUO0WO/XHuWaPFU8/svSpoH3OlP2u8FZewTkeMIpizVzPh+FnBf9ubS+5hGsk4aFozzQUSTOrtDjlfCwXasEPYS8tLhn9kt3khTYy5tzbg73Tl16h4hX/uYA2TQt97tCRm0QHvpLiG/ZyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807300; c=relaxed/simple;
	bh=xPQST4IbdwkBuWEQlgziyUdfc17TPPIa/rFcr4bkzng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNADdFA2S+NJy6QE1mVBuIPfjPJ3mIz8027IEzphN1pHrjGR5h8uhy49UHcsfjVNZx8xuPY5XwwA6a3E7AB+6kmq9Ass+FMjYLWKkvNvKiUN5KU0SyEG6HCBYK3aMTNgJOd7Vhp6ItxaXyXi6l6sBiJYk1ov3hYAC75OkxYVEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=RcsCqdHR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43967004304so21239845e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739807297; x=1740412097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFPS7jWerxORL3qYOvf7GvgH3VVFrmdTXhBMeC3dyLU=;
        b=RcsCqdHRFl0A+OoSkMSgQ9DNLbd//+A0yHeZGp68uPI3+nUz6Scp7Fi3xA4apemIWX
         03Cr5f1HjwnkYuooF6wbmJN44CCEt3oAZtNlrspjzt1sD4z+YOEGT+qfY5YjX2s0SdNK
         sGlboYbzDHDFPhGIc8VjnywbpUF02mk1uNMPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739807297; x=1740412097;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFPS7jWerxORL3qYOvf7GvgH3VVFrmdTXhBMeC3dyLU=;
        b=sjBEkH9+ETR78NeQ+1NqwybzaqrnKBTGWtkGCA/cF1TOF1Kb4yHo/HSxk+jFJtiV4e
         ZBo3fHKVCjZHkD3MKaPlD0HiZiqGEvRjKMWIoTw2Zn5dhtf9z561bt9z+qgiPnJQRxrY
         LnjoWWlAkfMX3/AhJMu+lhwJr8a43zpaVkPhVWdi1Fr9xEO4kX0Y0M8QxYtudEAmf1sW
         xleuHqTZd2xIHPnSS1pGRi04CMLHgKVjNbYXYBty3mGW4ZGgWAUy6+zevnIRwFPfCqyx
         KLR48Uq7F54bl04YLOtzq0N/7LG7kYMDuf5vm0Qnxj1r19EN8GxgqqgMzMWjVjMHMVA/
         6qZA==
X-Forwarded-Encrypted: i=1; AJvYcCVRvSCrruA7NIyfkA15r2M9iR1A0r2FjXrewf4YqjMmCccpflqBRTxKftFup/aJfuZ0xB3Zyj4FZQ/LD7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoab37xqQq3XYibefWTo9qyoeCkVG9CmktgaoISDpC9dXf4wmO
	N1ZncqAluGJqOz/U0hFVn32tC8mtjpV2XB9oHBdM/rL7fy6+3J34eQmmDMNK5LY=
X-Gm-Gg: ASbGncuAVVfbt676skomUCJWaD4+4mPznFemi3GPUr8okr7cdbIuqAmt9xA2/UK+2xu
	cOxm3cP2NncAAcOBBS16It6dDAxSx+ei+pwAlC2zeRxJIQ/vCrQR1NujQEG4ZALmSIYjcQRwwWI
	SPCQ7bCRKVyDRw3ibG3zwJlqbcyTJc+W3nDtT7c/grdOJ2koEs+A1GLJROKSMNRdBJL1t3WN5bD
	2glsiTEikV0Ecf79JzcSiFcsrNvoGMT8LueYH2LWhXQ7n9FylqMb+gD5MZpyzh79YZqTBwSftkd
	Hq781tb27byAZetzKvbIDtmq1gg=
X-Google-Smtp-Source: AGHT+IGSPCdUDCd1o/i4T/qnIV8TpHBkXWunEDUWfKiArJRtbwbNRix+QBABPgefm77mFrNCuPLfcg==
X-Received: by 2002:a05:600c:4688:b0:439:89e9:4eff with SMTP id 5b1f17b1804b1-43989e951bbmr23616275e9.10.1739807296485;
        Mon, 17 Feb 2025 07:48:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961645422sm75891405e9.2.2025.02.17.07.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:48:15 -0800 (PST)
Date: Mon, 17 Feb 2025 16:48:13 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z7NaPYvuRF11uxnM@phenom.ffwll.local>
Mail-Followup-To: Alexandre Courbot <acourbot@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Mon, Feb 17, 2025 at 11:04:45PM +0900, Alexandre Courbot wrote:
> Hi everyone,
> 
> This short RFC is based on top of Danilo's initial driver stub series
> [1] and has for goal to initiate discussions and hopefully some design
> decisions using the simplest subdevice of the GPU (the timer) as an
> example, before implementing more devices allowing the GPU
> initialization sequence to progress (Falcon being the logical next step
> so we can get the GSP rolling).
> 
> It is kept simple and short for that purpose, and to avoid bumping into
> a wall with much more device code because my assumptions were incorrect.
> 
> This is my first time trying to write Rust kernel code, and some of my
> questions below are probably due to me not understanding yet how to use
> the core kernel interfaces. So before going further I thought it would
> make sense to raise the most obvious questions that came to my mind
> while writing this draft:
> 
> - Where and how to store subdevices. The timer device is currently a
>   direct member of the GPU structure. It might work for GSP devices
>   which are IIUC supposed to have at least a few fixed devices required
>   to bring the GSP up ; but as a general rule this probably won't scale
>   as not all subdevices are present on all GPU variants, or in the same
>   numbers. So we will probably need to find an equivalent to the
>   `subdev` linked list in Nouveau.
> 
> - BAR sharing between subdevices. Right now each subdevice gets access
>   to the full BAR range. I am wondering whether we could not split it
>   into the relevant slices for each-subdevice, and transfer ownership of
>   each slice to the device that is supposed to use it. That way each
>   register would have a single owner, which is arguably safer - but
>   maybe not as flexible as we will need down the road?
> 
> - On a related note, since the BAR is behind a Devres its availability
>   must first be secured before any hardware access using try_access().
>   Doing this on a per-register or per-operation basis looks overkill, so
>   all methods that access the BAR take a reference to it, allowing to
>   call try_access() from the highest-level caller and thus reducing the
>   number of times this needs to be performed. Doing so comes at the cost
>   of an extra argument to most subdevice methods ; but also with the
>   benefit that we don't need to put the BAR behind another Arc and share
>   it across all subdevices. I don't know which design is better here,
>   and input would be very welcome.
> 
> - We will probably need sometime like a `Subdevice` trait or something
>   down the road, but I'll wait until we have more than one subdevice to
>   think about it.

It might make sense to go with a full-blown aux bus. Gives you a lot of
structures and answers to these questions, but also might be way too much.

So just throwing this a consideration in here.
-Sima

> 
> The first 2 patches are small additions to the core Rust modules, that
> the following patches make use of and which might be useful for other
> drivers as well. The last patch is the naive implementation of the timer
> device. I don't expect it to stay this way at all, so please point out
> all the deficiencies in this very early code! :)
> 
> [1] https://lore.kernel.org/nouveau/20250209173048.17398-1-dakr@kernel.org/
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Alexandre Courbot (3):
>       rust: add useful ops for u64
>       rust: make ETIMEDOUT error available
>       gpu: nova-core: add basic timer device
> 
>  drivers/gpu/nova-core/driver.rs    |  4 +-
>  drivers/gpu/nova-core/gpu.rs       | 35 ++++++++++++++-
>  drivers/gpu/nova-core/nova_core.rs |  1 +
>  drivers/gpu/nova-core/regs.rs      | 43 ++++++++++++++++++
>  drivers/gpu/nova-core/timer.rs     | 91 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/error.rs               |  1 +
>  rust/kernel/lib.rs                 |  1 +
>  rust/kernel/num.rs                 | 32 ++++++++++++++
>  8 files changed, 206 insertions(+), 2 deletions(-)
> ---
> base-commit: 6484e46f33eac8dd42aa36fa56b51d8daa5ae1c1
> change-id: 20250216-nova_timer-c69430184f54
> 
> Best regards,
> -- 
> Alexandre Courbot <acourbot@nvidia.com>
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

