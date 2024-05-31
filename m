Return-Path: <linux-kernel+bounces-196872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C668D62D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2245FB27FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AF3158A18;
	Fri, 31 May 2024 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGhzR6hT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7F7D51E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161607; cv=none; b=qjr//cpC4rJYJuA3ij0jR0aP+ol/RzqFk7PsGoeFbfvFLOddNtyw3Q/1WrxsX95FyvW+W3MxeaTxj55c55Geb6Gdfab3y1gRfL7qN5SbfhRBZHae1hnxl+BFmpOX/Ya6mAT8sxX6ttNwQoUjBw6zNlV320aT4lC6uoFXrXd8GLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161607; c=relaxed/simple;
	bh=VVq8ctt2mTLS4WDTn8eonpp/27+kdpc3GP5Ow4nWyu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jO1aVXAHtA8/1NkKjSR3PJrNBM93FTzsc81ifylz/WffOZblH0/76xFyAU+hRINzGuZo5W0igYB/kcRNEgXVQTVRLE+OaQ4KsI70tM7aimVE4TohPjNZG1Ogv53qdjM/7xPnf974zLSh2e6KohYQ/7iwWXGlmeWE4+JtdVRYxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGhzR6hT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717161605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7RX9XyCRxKIq+uDAOrGUVB9R2UXmSBAHa6vW/8VLOGg=;
	b=RGhzR6hTuTz0AslnpJa+9rDakoNK8KexzR2nJTffcAehxbagqVboAEnID+Bp+s1TczsP05
	E28MLglA2BainoHT3OV1r5fmqLvGzRjOV0T/gf2sqZQFnWW2NQa8oeJN/rf/mvq9ekVKnE
	AEC00yjXK5oskqbeOhebFJa2DOxKiY0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-__lX6inrMQ26Lb-kRwIydA-1; Fri,
 31 May 2024 09:20:02 -0400
X-MC-Unique: __lX6inrMQ26Lb-kRwIydA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABB8D1C0512B;
	Fri, 31 May 2024 13:20:01 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.86])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 539A27412;
	Fri, 31 May 2024 13:20:01 +0000 (UTC)
Date: Fri, 31 May 2024 09:19:59 -0400
From: Phil Auld <pauld@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: sched/urgent] sched/x86: Export 'percpu arch_freq_scale'
Message-ID: <20240531131959.GC54413@lorien.usersys.redhat.com>
References: <20240530181548.2039216-1-pauld@redhat.com>
 <171714958509.10875.11912816904466913393.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171714958509.10875.11912816904466913393.tip-bot2@tip-bot2>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Fri, May 31, 2024 at 09:59:45AM -0000 tip-bot2 for Phil Auld wrote:
> The following commit has been merged into the sched/urgent branch of tip:
> 
> Commit-ID:     d40605a6823577a6c40fad6fb1f10a40ea0389d7
> Gitweb:        https://git.kernel.org/tip/d40605a6823577a6c40fad6fb1f10a40ea0389d7
> Author:        Phil Auld <pauld@redhat.com>
> AuthorDate:    Thu, 30 May 2024 14:15:48 -04:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 31 May 2024 11:48:42 +02:00
> 
> sched/x86: Export 'percpu arch_freq_scale'
>

Thanks Ingo!


> Commit:
> 
>   7bc263840bc3 ("sched/topology: Consolidate and clean up access to a CPU's max compute capacity")
> 
> removed rq->cpu_capacity_orig in favor of using arch_scale_freq_capacity()
> calls. Export the underlying percpu symbol on x86 so that external trace
> point helper modules can be made to work again.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20240530181548.2039216-1-pauld@redhat.com
> ---
>  arch/x86/kernel/cpu/aperfmperf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index f9a8c7b..b3fa61d 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -345,6 +345,7 @@ static DECLARE_WORK(disable_freq_invariance_work,
>  		    disable_freq_invariance_workfn);
>  
>  DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
> +EXPORT_PER_CPU_SYMBOL_GPL(arch_freq_scale);
>  
>  static void scale_freq_tick(u64 acnt, u64 mcnt)
>  {
> 

-- 


