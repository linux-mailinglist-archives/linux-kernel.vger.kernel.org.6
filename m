Return-Path: <linux-kernel+bounces-548439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFFCA544DF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058AE188D3A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C7206F1D;
	Thu,  6 Mar 2025 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3AtKyBi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF5204C34
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249787; cv=none; b=cJWWtMFrKCwChKVY5Rj64+OwPcc1mRvp13OZgBHpTzIlkzLHlCV4m9DIFoItIL+LYAMahBub9GftSdhnq++BC/WAsj+s9WbGj+GG24ZCbWymopwmlhSmi5NeZ6ghmm7kILQII+WGdW+V/YG2v4XIu7l0vYSl/K+2s4y+4K68W1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249787; c=relaxed/simple;
	bh=BsvmU4RmQ+cLf9JaDEOmF7+c5xSuPJSASA1oMwfoOYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPL5h8jF9WfLPw5WDLPEGMJUsXcjk8An0ovusOfqkmN/nqwA1LHNmfirIjvnUC5hDwGy0mbdittp3CEeU/wWfC2Y2VCwRU6Nt3ZxHmBEvoRNZqjiZ395RIAa5Lyxoj9igGeC6BqLYOLhhMZx+d5qmtWReO2y5fyKvgY5I4lcPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3AtKyBi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741249784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPkJedQJXqUyMXlHMnWho+d+TcigluJIP07QDR+Qmow=;
	b=L3AtKyBiAghxGMwcxxf1Y03uf+EX8BEU9/kwt6OJ4OxH7JqWcNhma8p7+IWthMWP7Wx1/V
	ipB0dEpzb93qwS0JoLWoRdfMAK4dJAUOeUmXIsZMa+FLEy9eVCeBIPC0hxz5xKcVAqzvN6
	i1iHzxIsfTqLmyn9LWaLLaxGIGE+SV0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-7ArMLGwmOt-csJxXX5RrYw-1; Thu, 06 Mar 2025 03:29:42 -0500
X-MC-Unique: 7ArMLGwmOt-csJxXX5RrYw-1
X-Mimecast-MFC-AGG-ID: 7ArMLGwmOt-csJxXX5RrYw_1741249782
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3b53373faso74614885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249782; x=1741854582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPkJedQJXqUyMXlHMnWho+d+TcigluJIP07QDR+Qmow=;
        b=NifvucMjwbxSruG8ynDeDDiO4HM0Z55Aw/uERbv4XMdmGgV7OFixVx7fDFLQ+uSXX2
         PwJSVJuwVbhR4cqcr1yXnACOGehcG8KBg++fkxhdGLLW8fOEWWj7zwcW+3yTlNtlM1hl
         YGQMhp3zea+JTLwBF3023mIsXfSf4ARUwOPtrsS+nk5vCzgR9jVAVGN4vFMU+LcNgbK1
         Ja0hA8093Ljo0pcV+7/YezCu4Kbk0HuQ/CXzFEyV1vZQuycWyTjrS3xVTazO3tqqf0It
         sk4X/qgpH0898Anexkat4t1St4kXjr2TC9JnEdkI2Z2uNcEcN/u3/LHi+8jRlmwT6BHv
         +joA==
X-Gm-Message-State: AOJu0YyqBk2LkftTSsmI3l/g8dRp+ozY2z4dNHohRYioXIuyqu6EdOVR
	2hfCaTRqZqw/C2J2AV15BakhzDQyXin8FF6O7YdGNXR3qAuOLDRgFBmYfZbhGcQhejbysoW9PIK
	0xQtJJlXNALn+fPL71cKo2SnXA/4zcinXAGUEhSx5HGBI7J928Jr3VLBI/aI8AA==
X-Gm-Gg: ASbGnctuBIGO4v2ugszk9Oaz9xBcf5c0xf25uQpy6ThtJbPhElTt8cazRgV954QMEZ0
	5F3SZ3kXW5z25U1HsKT4ydSFuI03G+O/CO49ZaYHgg3/I14q75MsnUQ2KozyUQQL55KfuPl8wXA
	dranUNtBWi4srlBkCInhod8preO/esLCfU43GO+QXb9ubpRCKSJty4Z/xQrksxDxVUZWxGhGvhr
	TntiyqBLi0X9tUq1XP3IaIyJjP0b1CsQiu/R7MOi6UBfiiOln7uULjO9iaLn2F5D0YAU+x//eVF
	b4xYpqPkdlN88/HUf1TgKtCsjdnZi3rRUYtz99YvafvzJN/pSdhVI5ear3kI5s33A5eaTuoQMIE
	fhFws
X-Received: by 2002:a05:620a:84c4:b0:7c3:c574:98aa with SMTP id af79cd13be357-7c3d8e55849mr1050274385a.44.1741249781928;
        Thu, 06 Mar 2025 00:29:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECmTama7e10TlePjfSqmNPlnnzlKIEiVmzULtU4K+rjgo8DAVDPqZtpfrOj8g3m1YKqzEzUw==
X-Received: by 2002:a05:620a:84c4:b0:7c3:c574:98aa with SMTP id af79cd13be357-7c3d8e55849mr1050272685a.44.1741249781659;
        Thu, 06 Mar 2025 00:29:41 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5381d0asm62854085a.54.2025.03.06.00.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:29:40 -0800 (PST)
Date: Thu, 6 Mar 2025 08:29:35 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, hbathini@linux.ibm.com, joelagnelf@nvidia.com
Subject: Re: [PATCH 1/2] sched/deadline: use online cpus for validating
 runtime
Message-ID: <Z8lc79prs3OdUXtB@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306052954.452005-1-sshegde@linux.ibm.com>
 <20250306052954.452005-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306052954.452005-2-sshegde@linux.ibm.com>

Hi!

On 06/03/25 10:59, Shrikanth Hegde wrote:
> ftrace selftest reported failure since writing -1 to sched_rt_runtime_us
> return -EBUSY. This happens when the possible CPUs is different than
> the active CPUS.
> 
> Active CPUs are part of one root domain, while remaining CPUs are part
> of def_root_domain. Since active cpumask is being used, this results in
> cpus=0 when a non active CPUs is used in the loop.
> 
> Fix it by looping over the online CPUs instead for validation the
> bandwidth calculations.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/deadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 2d0f571f95e9..7ea9c040c72f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3187,7 +3187,7 @@ int sched_dl_global_validate(void)
>  	 * value smaller than the currently allocated bandwidth in
>  	 * any of the root_domains.
>  	 */
> -	for_each_possible_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		rcu_read_lock_sched();
>  
>  		if (dl_bw_visited(cpu, gen))
> -- 

Makes sense to me.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


