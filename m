Return-Path: <linux-kernel+bounces-247305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB09592CDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0808D1C22BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923021891BE;
	Wed, 10 Jul 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLtpTjlK"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445311891B3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602120; cv=none; b=BrIELR5z+kyIfc6aRAxNhO/d4G/tWXATCMHxEyyevfNCPWceSgXUM57M/YmzwP4LdCb0eUtt7ETc5vO/97oSQa6K1h3Xj4O8fH4jEehHP2qrkAh4neetGdXDV7YeikCSHuR+ywZy+foda1EN0aoamn86B4349OnFX/WZxpJgKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602120; c=relaxed/simple;
	bh=eGuIvECbSXn6359y/dCjg0H/80Fuz5QDMmImUI44+Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7RtVpwapU+IyV2wHfl9WU2E2gpfoYffL2qrVQRkL1JCaliaBPOFAv2sGsKmTP+hpHScSnu5NOoXbxg7qO9IyAzHYgM7vir3XAa9VLHuT4eMifhB8S19zp0UbnulSMIvduDuZFBtzmEMUwT/Z0Aj5HwtNUn9kvl8jMSmMkLzXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLtpTjlK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111b0so4182492a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720602117; x=1721206917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s7FmM2wXolbOPiJO9z3OXAJMWaN/JKVl+AasVIF0mwE=;
        b=bLtpTjlKFBFCO9FDczH7XD2enERWAHSMSyRkKsLhtVVaXr3t+XHFG8dwYBamMUuMu5
         syZ44JOryYg0tYIuXCYj34MdYWGjsKkBdHO14BSAg2MCdcpe6K+qo1AEMctVeO9PlDQo
         cFBcUH9K7jxWKiI6SiBV6jd/2yoCxgvd/TLUq2jX0LzAA4pKjLODYNjpx6dGrvH3GLqA
         QQx6oys2pbMbTz0bOki1NRzoj+Vk7GNzLJ6T9DSQjIRfnUhsF7HuntxdR+lAd7Dr57+p
         UJsgy++VbipCqXrLnt32GikbwL/REVKKd9/V81gtrYVPA+bnreKL9FKOHNdJvr1jPdrm
         WBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720602117; x=1721206917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7FmM2wXolbOPiJO9z3OXAJMWaN/JKVl+AasVIF0mwE=;
        b=pEKxiUFNO6HCk9TCz2hiFYMCsGNfN152je65CuW8RSMak0fb2YtG7Ccj0i1f7WTict
         Ib9+pQ4HNpCRBcAyOYhiTfBMihsBGEmXDUEShIEMccMFjSVHFdmVHR85+Xru2a4qvXG7
         tnUJgi6C71GpcLAHKl8mcCZiDlHVUBS8LhTG3RwxN0j3BicgODBxnppZrwMzf0PaFWF8
         XONtb/mYnhqqeOciTBAfmG/GY6qCfm3ExVl4wAPpUp8T2FfQPtGyz7cpa3TYwj4Prcmh
         mqiNNM9zEQpPveXsKHqrzs64yqTeHcoxLio+0r6dz9v7etKERgsbdgQawIuOXFLcgj28
         ZyGg==
X-Forwarded-Encrypted: i=1; AJvYcCXLpy/CSG5NtP5vT0ZF7ea7q0+QNW/EP8gOmtq6p/k9yBaxo+b9aPPCJjoGUM6v3rOHxHvT3TPJIYDRh5o2zWggezksm3G15zglxEBa
X-Gm-Message-State: AOJu0YzZlMHpMqsk8Md0cuVdWyIt1aGQiNGMRM6ghVoZY3LgG7jThWji
	6npJ9XXiZmkVuaRNn58jcJ564fUjw7U1uFeIfgon9xT78EG+bPw=
X-Google-Smtp-Source: AGHT+IHyl1og7q+6Pg7/7cFbcSFX2PZGINov4dlX9TkLDPo06gjLN2ZRHIFLUAHTkN3JGsHK4SIELg==
X-Received: by 2002:a05:6402:348c:b0:58f:2087:7983 with SMTP id 4fb4d7f45d1cf-594bcba842bmr4455758a12.40.1720602117351;
        Wed, 10 Jul 2024 02:01:57 -0700 (PDT)
Received: from localhost ([151.47.106.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bba548d2sm1989506a12.7.2024.07.10.02.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 02:01:57 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:01:53 +0200
From: Andrea Righi <righi.andrea@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com
Subject: Re: [PATCHSET sched_ext/for-6.11] sched_ext: Allow SCX_DSQ_LOCAL_ON
 for direct dispatches
Message-ID: <Zo5OATwDf5uGjO2w@gpd>
References: <20240709212137.1199269-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709212137.1199269-1-tj@kernel.org>

On Tue, Jul 09, 2024 at 11:21:06AM -1000, Tejun Heo wrote:
> Hello,
> 
> In ops.dispatch(), SCX_DSQ_LOCAL_ON can be used to dispatch the task to the
> local DSQ of any CPU. However, during direct dispatch from ops.select_cpu()
> and ops.enqueue(), this isn't allowed. This is because dispatching to the
> local DSQ of a remote CPU requires locking both the task's current and new
> rq's and such double locking can't be done directly from ops.enqueue(). This
> gap in API forces schedulers into work-arounds which are not straightforward
> or optimal such as skipping direct dispatches in such cases.
> 
> This patchset implements SCX_DSQ_LOCAL_ON support for direct dispatches.
> 
> This patchset contains the following patches:
> 
>  0001-sched-Move-struct-balance_callback-definition-upward.patch
>  0002-sched_ext-Open-code-task_linked_on_dsq.patch
>  0003-sched_ext-Make-rf-optional-for-dispatch_to_local_dsq.patch
>  0004-sched_ext-s-SCX_RQ_BALANCING-SCX_RQ_IN_BALANCE-and-a.patch
>  0005-sched_ext-Allow-SCX_DSQ_LOCAL_ON-for-direct-dispatch.patch
>  0006-sched_ext-scx_qmap-Pick-idle-CPU-for-direct-dispatch.patch
> 
> While 0001 is a scheduler core change, all it does is moving the definition
> of struct balance_callback so that it's visible for struct scx_rq
> definition. If there are no objections, it'd make sense to route it through
> the sched_ext tree with the rest of the changes.

Apart for the minor nits, everything looks good to me. I did a quick
test inside virtme-ng and I haven't found any regression. I'll do more
tests with the new way of using SCX_DSQ_LOCAL_ON, but so far so good.
FWIW:

Tested-by: Andrea Righi <righi.andrea@gmail.com>

Thanks,
-Andrea

> 
> and is also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-ddsp-local-on
> 
>  kernel/sched/ext.c             |  207 +++++++++++++++++++++++++++++++++++++++++++++++++++------------
>  kernel/sched/sched.h           |   19 +++--
>  tools/sched_ext/scx_qmap.bpf.c |   39 +++++++++--
>  tools/sched_ext/scx_qmap.c     |    5 -
>  4 files changed, 215 insertions(+), 55 deletions(-)
> 
> --
> tejun

