Return-Path: <linux-kernel+bounces-561548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A016A61358
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7A918926E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037381FF1D6;
	Fri, 14 Mar 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9GgvfVm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86F1BC3C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961298; cv=none; b=Q9TCbUrC2O6MhG22TgAr5UrTGR+ykHJfHMyB7o+Gk0KXTTg2LuV3pW8KYe72OgcMKfTHKHyePPy4XMcQaXYwbsEY7Pkp+AgPuh1jJs9B/STgHMB+EeswQBuc172seXV0xX27JldtypMChazaIon69+XJHp/uExz2np+JsiDt1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961298; c=relaxed/simple;
	bh=GD4+r4m1jeRyhJA4gN/oXy3ae1vzR4/5HnDITG/UePk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QA/uPzaB3XT+ZLKnjWjJsj+HGH1yHBSvYjgSHSIGWOxRSj5jQPFZ9a5N/iUtjGbwtkK7GySZA73vYtigfuifwokV80mwHO6j/2w3MbrizRfvdP35TYCFRdkG1x5EbuRNRyzbkFAylfrFbxqh4/4E/MVQXkw2ZdlU21K6FXyYr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9GgvfVm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741961295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XiWxQU6JodHLwCI5x/exGKqysWue0It77G2BPht28Bo=;
	b=K9GgvfVm3jNHCcWlU6DPkEK3s4i4cqntfyoGuUYnh/Cra03Iqh07YtSPXf+7SrLtr7X6QT
	dhiqRT5GdtkIqtlqKjXQwY6KU6+4nkqWljC2MZEUam/fvr59Wma+FePWkYMJWpBMw2Rpk1
	1xxRAsgkyvD6Rsxxwo1uahOKbsFgZc0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-ZPypSD9KMoK75GAJ1JgzgQ-1; Fri, 14 Mar 2025 10:08:09 -0400
X-MC-Unique: ZPypSD9KMoK75GAJ1JgzgQ-1
X-Mimecast-MFC-AGG-ID: ZPypSD9KMoK75GAJ1JgzgQ_1741961289
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-47686947566so40032751cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961289; x=1742566089;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiWxQU6JodHLwCI5x/exGKqysWue0It77G2BPht28Bo=;
        b=BV1bAhxdTzrerZuEu8FDYDPCaziBEc/6AA2vR25kqZAuTuKY6gMNySNouHudCxHwb4
         xjUIOw8ElMIXxnb0Pa4VbFQ0pS7oE8H/oVgNPpFS4N4Zpxgub29sRvsnDXi3JZUpQ3fv
         H2FGSEzGmX+RTySOTK6SgndFJHiQUNfBuvk2Ul/fSf9Mbh61oVN32G5zg7UElxis2yrB
         q0QvoluRACo3WrnLdkBzajeIPOnDr7yZCnm3cS5MIFUdQ+1LovhXciYiN6KK5ppRNzZF
         M4QJjgnwypy/0zUgHoKCcf5oupPTV9ccoEltjSc268F0FcTpVFsbh0qXePs+3JjwV/Q3
         vDkA==
X-Forwarded-Encrypted: i=1; AJvYcCWNwuIV1rS7nZ5+nGddXZcO+JK4yszG73514gqDPf6bTlsFEO0wfxX+qOnLRfKU1my/nTJ5Sob36NIOluw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxupOqjrDBtMs3dw191fB5gR/ocKic+gjf6/rd5q6lOJci3kB65
	R+T1XljuBHdYv36LnWVqVtITVnUk/5GEAnxB8AMlChuUGuHpMLz4tkU7pOedlcNQT1qXZ952Jc2
	F3k3jtC/SXDTyRVrAbiNTlKX7wdLOtkTmeXtXVgBZMmyOv27HScZk0/LNHJDD7A==
X-Gm-Gg: ASbGncu7jdmrLExHJmdsuz7WYnjdOxWzknAPB02XQyncinI0/Cic4/BEo4aFNWFgTDd
	kKPB4TKAfWODaTRhqS3iyPdRJZWEqgdaSAFNTY4tPhh2NmWwYjv/fyzMZq1EfF0N+XevKpSG7ut
	2cDtbPQwfJ5CPu8grTpeO1ydyXxNJ1jweOezmvMVU5ia9UYn1V9PrRvyE7XuQ+aeXVgqPiBCeB8
	M1u9T5Gxsxl34baLdQgK94RJL3SZjVUQX79pq0JgskwipOPeiDTBiHrQ/U11iTDo4plH98REEFF
	U6wfMa3QCE3Cv6AsgipN8UAMT2HyUBIDpRwjnI50O3c7yKYkM66FPabqM5j4nQ==
X-Received: by 2002:a05:622a:347:b0:474:e255:db2c with SMTP id d75a77b69052e-476c8147d0bmr32951981cf.26.1741961288768;
        Fri, 14 Mar 2025 07:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmB3QdNHS7JX9Vf1/vdSRiWQM5fcJ+rOfX/ySnMtNR+xVnff9VvfSihy+iOnvkNDEE4fa8AA==
X-Received: by 2002:a05:622a:347:b0:474:e255:db2c with SMTP id d75a77b69052e-476c8147d0bmr32951461cf.26.1741961288384;
        Fri, 14 Mar 2025 07:08:08 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb66f9ccsm23614561cf.47.2025.03.14.07.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:08:07 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6ebfdd9a-0919-4c65-a6ab-48ac6c81cd0d@redhat.com>
Date: Fri, 14 Mar 2025 10:08:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Fix upper limit for LOCKDEP_BITS configs
To: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>,
 Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, "J. R. Okajima" <hooanon05g@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>
References: <20250314064729.163602-1-zhangxiaomeng13@huawei.com>
Content-Language: en-US
In-Reply-To: <20250314064729.163602-1-zhangxiaomeng13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/25 2:47 AM, Xiaomeng Zhang wrote:
> The upper limit that was initially setup for LOCKDEP_BITS configs
> is too high (24 bit shift), which causes the kernel image size to exceed
> KERNEL_IMAGE_SIZE (1024MB) limit. When LOCKDEP_BITS is set to 24,
> the kernel image size grows to 1562.19MB.
>
> Adjust LOCKDEP_BITS to 22, which results in a kernel image size of
> 888.19MB, keeping it under the KERNEL_IMAGE_SIZE limit while still
> maintaining adequate debug information capacity.
>
> This change prevents the linker error:
>    ld: kernel image bigger than KERNEL_IMAGE_SIZE
>
> Fixes: e638072e6172 ("lockdep: Fix upper limit for LOCKDEP_*_BITS configs")
> Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
> ---
>   lib/Kconfig.debug | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 35796c290ca3..6faba965a349 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1504,7 +1504,7 @@ config LOCKDEP_SMALL
>   config LOCKDEP_BITS
>   	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
> -	range 10 24
> +	range 10 22
>   	default 15
>   	help
>   	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.

The current size of lock_list structure is 56 bytes. If we have 2^24 of 
them, they will occupy 896 Mbytes. That leaves about 100 Mbytes for the 
rest. Yes, we should reduce it further.

Acked-by: Waiman Long <longman@redhat.com>


