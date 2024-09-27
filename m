Return-Path: <linux-kernel+bounces-342002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B6298896F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F9FB22545
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D3166F23;
	Fri, 27 Sep 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb7x4jv2"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3363218B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456496; cv=none; b=rZbq1ddchD57jAa8LpBf39so6JYVWqhS4Bhi8dKKj7Qqx+vglRqc9u1XX0yrHUig2oBHco5WuRdmmnHR63NPczHy/R4qtyea9TkVoDv51/2Bje30gYLM3rPemlF/8cZUJrKN6+j/IrJBmSa7/mCJ+8S0qp/E16ScVGA1uLBGsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456496; c=relaxed/simple;
	bh=WLPW3vYOhVb8JN5ILaO/6AVIelRqy+oC6hnkCvD81tU=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References; b=hTBocIj+zixOq/tbgue9S84fBPMdU2rrdunBj+xFqQsqRnq2kweg/9uo4V3xnQHGydyXmMX4fPuZ7+JoP/tii5u3Po8Eav6RO+G1TBekVb++Zr+avJGXvV+6VYGjD8peTrcuNRx7j9Rag0l8/bxyuuAlD+yz+RYk0edzv0/wurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb7x4jv2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7198de684a7so1727110b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727456493; x=1728061293; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0e/LXRDatzR1ko5dqutMPc7tTkgrpupuki1OBNWU17U=;
        b=Hb7x4jv2LG0ZmjyizljSVGdDG8PN0CFgTEl5ffsg2l5I/Mcy1x6mazmrOmfvAJOiyf
         1SpmIfgJELCKZCSq1Ue0PX57kL1DSxadQkCxpGaw0qhqkfnyMogeWIaK4xnd6qkvLzKw
         CREk82aVD1kczJnrWBd4r0DywGXTjCfHZLhgOZ+9sUskDW7/wMdcwznI1ypP27Vg7yvm
         hLG/Ig+xdVR5Kd9d6Le7YGkqhHOXhkjN8Km8G+jMSsRJSAuvOsklSi+oLQsgH7jLMWgD
         d82FQwBkTA5Xd8TqsXvXo/QF93rIpRBT6dLEW7x/ji588aIaZ/BsB9vQR5yg3wgPHCaA
         /XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727456493; x=1728061293;
        h=references:message-id:date:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0e/LXRDatzR1ko5dqutMPc7tTkgrpupuki1OBNWU17U=;
        b=THkuhWpupi0pT60YJkEimX+uHY2rFHyI/639/FjEKACIB2CvOdBwyIBukkJ4hzCdVa
         wZFZXXYl+/kt7sXB2ZC3bLKb/HB7+fJu/rnt5T/NhWaCBkf8e/5jwvTEiIXhf1KFcKGJ
         XLVZTGAVBnZYcBH7ar+pJpfnqMSQW35SFEegplTntquJc4XD8MlRKe0pyDIN2BHc5sX8
         ptbsASChMWVZ+5XcbuPJcA12sUASoz6cWGJPoAJdJAxK3UiAIp8JgA5TUIMHqxRZGfUR
         AAu1lQx+PoYbk++N3KJezrYg/aRidhHLyvC5pupb+WMPy64BGlqFbAgP+z/5V3U18QyD
         HTVA==
X-Forwarded-Encrypted: i=1; AJvYcCVZwK0dk81qSW/t+pFXUsbR+/D9wKk5JZSVy+IjnVAdKSQMw1qDVQKKoeDEu3Gj+tjL2S9fxuLcCyhAgKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxIktmn86PPwUJt/QAolpYKi4bfOEAExevURt6jDNBvFSg110
	btz1WzpTJ25jDgOpQxIsbejOCgQP7WNy6NorQLJe+kYLKK0FAgCKF21y2w==
X-Google-Smtp-Source: AGHT+IG8JPYkmIGygGx7DzIdtslWIAQ+eYr4XQKWx2dNuwfUnD/ENoX2brDodsF7v6n1OqO5YT016A==
X-Received: by 2002:a05:6a00:2d11:b0:717:839c:6822 with SMTP id d2e1a72fcca58-71b2604d3dfmr6004694b3a.17.1727456493238;
        Fri, 27 Sep 2024 10:01:33 -0700 (PDT)
Received: from dw-tp ([171.76.86.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652bb5esm1878603b3a.175.2024.09.27.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 10:01:32 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Costa Shulyupin <costa.shul@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/xive: Use cpumask_intersects()
In-Reply-To: <20240926092623.399577-2-costa.shul@redhat.com>
Date: Fri, 27 Sep 2024 22:14:54 +0530
Message-ID: <87ed55avw9.fsf@gmail.com>
References: <20240926092623.399577-2-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Costa Shulyupin <costa.shul@redhat.com> writes:

> Replace `cpumask_any_and(a, b) >= nr_cpu_ids`
> with the more readable `!cpumask_intersects(a, b)`.
>
> Comparison between cpumask_any_and() and cpumask_intersects()
>
> The cpumask_any_and() function expands using FIND_FIRST_BIT(),
> resulting in a loop that iterates through each bit of the bitmask:
>
> for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {
> 	val = (FETCH);
> 	if (val) {
> 		sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(val)), sz);
> 		break;
> 	}
> }
>
> The cpumask_intersects() function expands using __bitmap_intersects(),
> resulting in that the first loop iterates through each long word of the bitmask,
> and the second through each bit within a long word:
>
> unsigned int k, lim = bits/BITS_PER_LONG;
> for (k = 0; k < lim; ++k)
> 	if (bitmap1[k] & bitmap2[k])
> 		return true;
>
> if (bits % BITS_PER_LONG)
> 	if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
> 		return true;
>
> Conclusion: cpumask_intersects() is at least as efficient as cpumask_any_and(),
> if not more so, as it typically performs fewer loops and comparisons.
>

I agree with the analysis in above. cpumask_any_and() has to get the
first set bit from the two cpumask for which it also does some
additional calculations like __ffs().

whereas cpumask_intersects() has to only check if any of the bits is set
hence does fewer operations.


Looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.harjani@gmail.com>


> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
> ---
>
> v2: add comparison between cpumask_any_and() and cpumask_intersects()
>
> ---
>  arch/powerpc/sysdev/xive/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index fa01818c1972c..a6c388bdf5d08 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -726,7 +726,7 @@ static int xive_irq_set_affinity(struct irq_data *d,
>  	pr_debug("%s: irq %d/0x%x\n", __func__, d->irq, hw_irq);
>  
>  	/* Is this valid ? */
> -	if (cpumask_any_and(cpumask, cpu_online_mask) >= nr_cpu_ids)
> +	if (!cpumask_intersects(cpumask, cpu_online_mask))
>  		return -EINVAL;
>  
>  	/*
> -- 
> 2.45.0

