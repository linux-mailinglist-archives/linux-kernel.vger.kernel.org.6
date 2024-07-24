Return-Path: <linux-kernel+bounces-261281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA11193B527
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7880AB22677
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AE915EFCC;
	Wed, 24 Jul 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpsYg/TA"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504E15ECCE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838861; cv=none; b=Mb9Mos7d59mxTeiVDJcQ8H2XPN71pAR5I4/LOm9RhRJlqSIKRIAl7GxsS+7nhE/j2ifA3sGZzrRQydTC7TdHJ/pPYvOm95BuGIsjnXV5lLgGKNH3GGMSxSaFtNwsefOK3yzv7vYKoLqnHsFNtNLmHPZUr1i/3nbVZ297TqDwNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838861; c=relaxed/simple;
	bh=ET0PZ9UhyP8VpoKQZiTmsTCLD32ZZjBnKfIjAlicbhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A07NpQTTw4jt0w6VX4wvC/KBluLwwz+5nmMUuIq0TJcAD7xsrCNiI7Qc2YMyPE1wAVPjz/haC1EG3YaMp1KsWu04mnrgJkgCeBdPBKXYm20/AuUU3lESugw5rgamg5JSXBMwayXi++hUig7PV7PDCq36flYuTuhr8J89JCwuEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpsYg/TA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc56fd4de1so388695ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721838860; x=1722443660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vIG3zJH4fEMkjChV9chAxPASQRZkCLprPRL6srDZt5g=;
        b=DpsYg/TAi8yl0KMiMavGXkWtUxFidXgCb8bvOKtse6CUxmV4xw73E9AbxPOF5mkiKw
         uOK4LuQfY0y2ZuFfO6ZPXQ1kRUqR3PSIb4K39kJKbnezty+wIjTExhuwsHjg7vVGW3M6
         ZwGQxazSg2NnZqCiy7Hx0g747CXkJ01gCUwGeCCSNTxDWUVYpeCk5wBCwqAztaa68H/I
         i6P3Mgpak3UnVGKVbVFzMCpDRN0NBIjSuJ4W8cN1u3c0YRuCCRmJGpTBIx2rwk6NbrIz
         c3VPfqj+i1yCB3JM78JDWNB2ZhvqngClIrKP/5ygRC0yu5UYCYCZlNGUIWhbx/yYbfjC
         Q9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838860; x=1722443660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIG3zJH4fEMkjChV9chAxPASQRZkCLprPRL6srDZt5g=;
        b=HPhnI1tIY/MKKJgqXKUZ0v5hB1kFXgcq064FPyt3yZqZGt9RFmeyJeaoDYYtMoO77P
         pmEEZKSJRxjc5fkQMwZ933k1r2ZCDcisGOr+ccC8sidtwJrM6069lgZvIirRWLB43FuG
         SAwCnXw2megF2mo6b5JtSqNLgl5eIZsja4yhlVa8YVpFPnFG6/Sk2fIE3qRzSZbUGrLY
         KIVBBaT84TTOIpEdqOUkstvs4vScrCZTP1XdLjUYKvhCqC40dtyiUIcTmSUoK6lFXwxh
         LZxi6Rq5jpFCH/qmov1WnbfAEsroKJ8k0qEMrPL4fVHioI8McDsE9lz/dsUMwr3g0+kS
         3pFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUv25iTWHHKn2Zwc3DoBLc5yjc+GdL0K1+kjIQG1pZylB1OVIywKUFy7sXojB7PzrRJAVm3W4CLhHLWcP4x8jeq9iuyqJ9AEYI1pJt
X-Gm-Message-State: AOJu0Yz24U/a4bP4rYzrqXHtsdESuR6hxEA6nEFEDqcwbq+ihsqq24GM
	M14psRKCV9vCLx2E9PeSpBWQUzcvkWuJ6hHjuq6ncQD/aQ+sHvvG92NMlL+E6w==
X-Google-Smtp-Source: AGHT+IGFyB4+UfMood6Wf+690kpMPPELeX+J/GX7Wh+sbtakeR/erJKd/lv3sge+W7GObXBYSY4D6Q==
X-Received: by 2002:a17:902:fa4f:b0:1fd:9648:2d66 with SMTP id d9443c01a7336-1fed2786619mr2664095ad.17.1721838859281;
        Wed, 24 Jul 2024 09:34:19 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31d2b0sm96775625ad.162.2024.07.24.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:34:18 -0700 (PDT)
Date: Wed, 24 Jul 2024 16:34:15 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, linux-kernel@vger.kernel.org,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: Re: [PATCH] binder_alloc: Fix sleeping function called from invalid
 context
Message-ID: <ZqEtB3FdE8PjtPIM@google.com>
References: <20240724155555.2405467-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724155555.2405467-1-quic_mojha@quicinc.com>

On Wed, Jul 24, 2024 at 09:25:55PM +0530, Mukesh Ojha wrote:
> 36c55ce8703c ("binder_alloc: Replace kcalloc with kvcalloc to
nit: I believe checkpatch expects the format "Commit 36c55..."

> mitigate OOM issues") introduce schedule while atomic issue.
nit: past tense "introduced"

> 
> [ 2689.152635][ T4275] BUG: sleeping function called from invalid context at mm/vmalloc.c:2847
> [ 2689.161291][ T4275] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4275, name: kworker/1:140
> [ 2689.170708][ T4275] preempt_count: 1, expected: 0
> [ 2689.175572][ T4275] RCU nest depth: 0, expected: 0
> [ 2689.180521][ T4275] INFO: lockdep is turned off.
> [ 2689.180523][ T4275] Preemption disabled at:
> [ 2689.180525][ T4275] [<ffffffe031f2a2dc>] binder_alloc_deferred_release+0x2c/0x388
> ..
> ..
> [ 2689.213419][ T4275]  __might_resched+0x174/0x178
> [ 2689.213423][ T4275]  __might_sleep+0x48/0x7c
> [ 2689.213426][ T4275]  vfree+0x4c/0x15c
> [ 2689.213430][ T4275]  kvfree+0x24/0x44
> [ 2689.213433][ T4275]  binder_alloc_deferred_release+0x2c0/0x388
> [ 2689.213436][ T4275]  binder_proc_dec_tmpref+0x15c/0x2a8
> [ 2689.213440][ T4275]  binder_deferred_func+0xa8/0x8ec
> [ 2689.213442][ T4275]  process_one_work+0x254/0x59c
> [ 2689.213447][ T4275]  worker_thread+0x274/0x3ec
> [ 2689.213450][ T4275]  kthread+0x110/0x134
> [ 2689.213453][ T4275]  ret_from_fork+0x10/0x20
> 
> Fix it by moving the place of kvfree outside of spinlock context.
> 
> Fixes: 36c55ce8703c ("binder_alloc: Replace kcalloc with kvcalloc to mitigate OOM issues")
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/android/binder_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index b00961944ab1..b3acbc4174fb 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -939,9 +939,9 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  			__free_page(alloc->pages[i].page_ptr);
>  			page_count++;
>  		}
> -		kvfree(alloc->pages);
>  	}
>  	spin_unlock(&alloc->lock);
> +	kvfree(alloc->pages);
>  	if (alloc->mm)
>  		mmdrop(alloc->mm);
>  
> -- 
> 2.34.1
> 

Note scripts/get_maintainer.pl asks to Cc the blamed fixes:
  Lei Liu <liulei.rjpt@vivo.com> (blamed_fixes:1/1=100%)

If you care to fix the nits feel free to add for v2:
Acked-by: Carlos Llamas <cmllamas@google.com>

Thanks
--
Carlos Llamas

