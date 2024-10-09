Return-Path: <linux-kernel+bounces-357535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A30099724A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA96F1F21E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060371974FA;
	Wed,  9 Oct 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YobH2r8j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D22CA5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492645; cv=none; b=j6bXElR0a/TIfTF8fw4gwrbJPnvkzSpg+Rvag6178+xlHy050Kl/gBZ2niKsDYllxFTuYXbQ8RKhJC7Avu3Gbtf/waz+ye7VCE/dzviTTYsU41knT4uyZWURm+p2fwadiMY/oOH12WahYuX/T9ZLCLINv4tG7Cyb6V5guSUTDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492645; c=relaxed/simple;
	bh=xHSNApdHYoPIkBxuI/ozg/Wj9Z3c0oPkQhORTST36pQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sqo45QXkq+GpQ98YOv+PWpjTouqL1RAkMyBtN6nsSRhrX7SOIjV+NCdegfHl5Na+jTUw5u0JkBLj40mk1hcX2YMSgIzu8F/JbjVFfC9V70mI+8jMS4a5/j/CcmKWO9yKtxqO0mz0DEUeOl3CQXdNB+vA62zke60xCMDzCnZ/k2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YobH2r8j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728492642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6kaDpUk04LV4c/QvJzR1TRAaplvDA6DwwSvWJdKxcw=;
	b=YobH2r8jfvoBp94gIsLI70IahAa4RTuhDvRV35RCh5cfvp8U5fpSjRODzbt8dXuOIBmubh
	vLzluUU6GSh7KvOs9SqIgYsT3rXaPpjVbetpTHM4aphqP5b5O6AGvBGVKIg6KoYkB838rB
	Md3VdNeLHsS5561M/cAuT+ikz3EHImw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-5n2908jRPDK2tPApPtcn5w-1; Wed, 09 Oct 2024 12:50:41 -0400
X-MC-Unique: 5n2908jRPDK2tPApPtcn5w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbe50b415eso825406d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728492641; x=1729097441;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6kaDpUk04LV4c/QvJzR1TRAaplvDA6DwwSvWJdKxcw=;
        b=fcK0fq72W67QR2//jsFXRw/O7f3R4LPoMFp4OEZJy6uqTr/vdHc4pOo/EejLkjayY3
         toQBZoBNmp4htH8yfigaZa0yGcEPHg0dWvmURgKEdGodVMbuu1QFPQi9MHWtUm569zQG
         BLxtkn5Ly0ZINKRzavG6HJXOEgv+AbqdGzO5w8CMdTQAdiVj+G1eV/Q2ymQBiE0j9XJW
         AnpWEMHVMxQgiIykRp4RN4xBOt9ntcluZlTQjy79sOtZXg/sks1yaN1Xvsj2hAA1HXnB
         GKBFmN7cCAjm9veoShphrfYvenpfIyaG1v5CCy6VExVjO24eDODCY9jG7RVtk2PQryuH
         mG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWiWNH3b7qRD8JIwXHZYPcN2YpcwIGtEnY34tVgByESp/ljm/QI/39TEbRB25CkDwgnuHYYOjrB3CIsqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhH7k4epqNW1PXqhBEb9+HVBfto7gGJyd1EmP8HPLfAAWhx64Y
	vhK1qiOH1wotsqHprm49LuyFxjOO6mOyMuc0MyFuC5kAP2vfWbzOBO4V/Ver/dAKnjK/7EiwPWs
	7s26vLBy4NO7sOHu3tmNiIwu4c34kO2pIiBVsbhymsyqh4+0wtE/EcNmg7iUnXQ==
X-Received: by 2002:a05:6214:43c3:b0:6cb:d376:2b27 with SMTP id 6a1803df08f44-6cbd3762c97mr24255606d6.29.1728492640885;
        Wed, 09 Oct 2024 09:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzHekUQqb8tHLxCaVuLNgGDJ6huSuMcfA7ZkWHMf150p5t29VLO9jtA9sdbAuvaMvc6Ct5vw==
X-Received: by 2002:a05:6214:43c3:b0:6cb:d376:2b27 with SMTP id 6a1803df08f44-6cbd3762c97mr24255446d6.29.1728492640576;
        Wed, 09 Oct 2024 09:50:40 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbdd4779c2sm2455926d6.122.2024.10.09.09.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:50:39 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a323429f-66e8-4951-a674-54dc25429a15@redhat.com>
Date: Wed, 9 Oct 2024 12:50:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lockdep: Enable PROVE_RAW_LOCK_NESTING with
 PROVE_LOCKING.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
 <20241009161041.1018375-2-bigeasy@linutronix.de>
Content-Language: en-US
In-Reply-To: <20241009161041.1018375-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/9/24 11:45 AM, Sebastian Andrzej Siewior wrote:
> With the printk issues solved, the last known splat created by
> PROVE_RAW_LOCK_NESTING is gone.
>
> Enable PROVE_RAW_LOCK_NESTING by default as part of PROVE_LOCKING. Keep
> the defines around in case something serious pops up and it needs to be
> disabled.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   lib/Kconfig.debug | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7315f643817ae..5b67816f4a62f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1409,22 +1409,14 @@ config PROVE_LOCKING
>   	 For more details, see Documentation/locking/lockdep-design.rst.
>   
>   config PROVE_RAW_LOCK_NESTING
> -	bool "Enable raw_spinlock - spinlock nesting checks"
> +	bool
>   	depends on PROVE_LOCKING
> -	default n
> +	default y
>   	help
>   	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
>   	 that the lock nesting rules for PREEMPT_RT enabled kernels are
>   	 not violated.
>   
> -	 NOTE: There are known nesting problems. So if you enable this
> -	 option expect lockdep splats until these problems have been fully
> -	 addressed which is work in progress. This config switch allows to
> -	 identify and analyze these problems. It will be removed and the
> -	 check permanently enabled once the main issues have been fixed.
> -
> -	 If unsure, select N.
> -
>   config LOCK_STAT
>   	bool "Lock usage statistics"
>   	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
Acked-by: Waiman Long <longman@redhat.com>


