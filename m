Return-Path: <linux-kernel+bounces-190145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88698CFA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28301C20D75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8713225D9;
	Mon, 27 May 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbreIYAS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A0D266
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795218; cv=none; b=dF6IWudQEAwRrymGFoj0MeryCj7mTmheVnqncr93pScELVCr55CYa5XxMWWgpCsOpR6b8g7KlTP3z5VqNCsjZl774rniEawWA5Iv3UXaQURMDUYjUA/P9SL7diQnRLXssDr+pHPG5OL/kWj9ZOkYdW4Y3eLJMN38ZhJ9KBqIiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795218; c=relaxed/simple;
	bh=uYRLEMYbUp3EeSjC/NuDVxpwnZ8p8U46ukUXSSR7wdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmCjz6udjVWDVq2g5R4+DDXmu6IJX9c9INxw4KztP46j5kdGKWhxM3SodtInk+R37vp/zv9j+vop5Zu7F4envTJY558HmI6/KpXVqAwouOpih1piW/U67/OKKLP+CreS7jYNgb0k5Hzrgx21vk+yAoxPWs0hLI9SfN28fBNfdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbreIYAS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716795215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Stx8nsYupK1retZeodvUwtce4GNZK7VWKmIXj47JHKk=;
	b=LbreIYASz73UysOjLmYfjRbL7dESH0wqHNp8CzbqPMCmtmEBNQV51BjnQLekxhME6RUy1f
	YpHmEJPAyiVsqBfujcQuGDt0tmB88nQmX/bpWb4ZGouNuWAYHMM3CKeiCAtd2jUTGL+ImA
	KpL324VPzIrJrt6rX6CmM5fGrzkiaOQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-cve-knA7NVCfKv-kcRNGsQ-1; Mon, 27 May 2024 03:33:32 -0400
X-MC-Unique: cve-knA7NVCfKv-kcRNGsQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-794b4b5b8a7so99800585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795212; x=1717400012;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Stx8nsYupK1retZeodvUwtce4GNZK7VWKmIXj47JHKk=;
        b=qSr5TT8tb4bIQE3op4jtSZ6f+T7CbD+TZUnkX1+e6qQ7YSZKduwJPYQCUOqctkKgmE
         CIXhPtDC3iqfYPBDuEhf5fFQAq/siFz+ewb1el0r4UOh84uQdki9OPAFRu1Epou3S7YA
         TQEAa+6sZJKCA/br6wNsZM8qBblom8ICKJR14DqSggB1190XOs8qEbb+1RJgTILUSbHF
         q138Njcsx1SPnQEcBGV2Kp7ew775J0B+uzBzae6+wzOFuXj5SZXxFv2NhGREW5PzdmpG
         x6V4tFZdFVILJ5ZldeCHzcuJzQvqXN/uG25jfV+hNxqj5d5K1UYH7uLBbh8D4OGnoWG8
         LJdw==
X-Gm-Message-State: AOJu0Ywr7EP3Vvd9QslXYXNxkkwmwIu0PPMqVEP4SA8OD9z356rlzP1s
	1LYaJeAb2NJO7g3ogxHI19htAhiV0/dP/XoU/M8wTUPyxdJNi9NTappKgxfxUKA1NNXr3YRCgeX
	++CGpT0w9Rsun6NTvXAnHGh/lNPmU8kbTMhKvoFLeGiXuth3kFfAZBGvKtYa2lg==
X-Received: by 2002:a05:620a:91b:b0:792:ba9e:d730 with SMTP id af79cd13be357-794aaf8bf51mr826792085a.0.1716795212117;
        Mon, 27 May 2024 00:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE/3pPs3Vm1d+crgAAu/1hHrCejTqkMeasyZPJuKiKRdtxp691PtFwHU7g1rdZmvXB/dz6Sw==
X-Received: by 2002:a05:620a:91b:b0:792:ba9e:d730 with SMTP id af79cd13be357-794aaf8bf51mr826790785a.0.1716795211679;
        Mon, 27 May 2024 00:33:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd085ddsm277854785a.76.2024.05.27.00.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 00:33:31 -0700 (PDT)
Message-ID: <2c8c4ddd-3b5e-49cb-9391-c249c27fdd2d@redhat.com>
Date: Mon, 27 May 2024 09:33:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: /proc/pid/smaps_rollup: avoid skipping vma after
 getting mmap_lock again
To: Yuanyuan Zhong <yzhong@purestorage.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Mohamed Khalfella <mkhalfella@purestorage.com>
References: <20240523183531.2535436-1-yzhong@purestorage.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20240523183531.2535436-1-yzhong@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.05.24 um 20:35 schrieb Yuanyuan Zhong:
> After switching smaps_rollup to use VMA iterator, searching for next
> entry is part of the condition expression of the do-while loop. So the
> current VMA needs to be addressed before the continue statement.
> 
> Fixes: c4c84f06285e ("fs/proc/task_mmu: stop using linked list and highest_vm_end")
> Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   fs/proc/task_mmu.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e5a5f015ff03..f8d35f993fe5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -970,12 +970,17 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>   				break;
>   
>   			/* Case 1 and 2 above */
> -			if (vma->vm_start >= last_vma_end)
> +			if (vma->vm_start >= last_vma_end) {
> +				smap_gather_stats(vma, &mss, 0);
> +				last_vma_end = vma->vm_end;
>   				continue;
> +			}
>   
>   			/* Case 4 above */
> -			if (vma->vm_end > last_vma_end)
> +			if (vma->vm_end > last_vma_end) {
>   				smap_gather_stats(vma, &mss, last_vma_end);
> +				last_vma_end = vma->vm_end;
> +			}
>   		}
>   	} for_each_vma(vmi, vma);
>   

Looks correct to me. I guess getting a reproducer is rather tricky.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


