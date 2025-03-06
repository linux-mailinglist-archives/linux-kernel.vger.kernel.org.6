Return-Path: <linux-kernel+bounces-548447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC52A544F9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76CB7A2A06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E0D20767F;
	Thu,  6 Mar 2025 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhSKew1w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502D1FC113
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250053; cv=none; b=JymW9gNidEX6iYV51Osl9HkBpM/FPHHVyvQHHRoTbPjD7V6nsUFqPUcPv5f7O7diA98tq/439MayfGaVbY7nwyolQoPlacMNBl2jwJCEYBHiqEt0cONNLV+FvRmgcNZFNAxpUpgN1ujgQ3I6fjxDF6yQnbIWR8YUqX2RNX87YLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250053; c=relaxed/simple;
	bh=OUp0E+qsiDEUSCpddjnFVpM0lNWkMIkK+SwJDDKMgp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqb35+Xaymt6PFjI9S73+2I8pmBw8pawJbWCgEz6iy8a8tGXOzMnYZz49LnetGaphuKIglYhrdu7XHZCZCF4Fk6t7RnF5BknRcm+VWa7/iJOhKmgRksF4bgKJ9vsb7nR3ZpQ7ObthvTFPBuJRWAlxM70lRKPergIWj6KpjR0Zo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhSKew1w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741250050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVFBDJpq+OLAVUkkYuhqX9NrEU4yq2FBIEz0GFuT+xc=;
	b=LhSKew1wNkzmpuJETl6G12bkVd+TCk6s20WEkGy1gnLj3LqTtSUO5T7+ZYyCBeCCrHJXg9
	D1RpEFE2VqjH45cWg13aGmYj5+rrpCkSJTmUn+YrnoJp6Iha0Z/snsTriZXTOvFYLpixZB
	Ws5MZZdZSnsiornU4VfaEjZ2W+UGrFg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-pyuynPR_NyaEyU7wjoOvMQ-1; Thu, 06 Mar 2025 03:34:08 -0500
X-MC-Unique: pyuynPR_NyaEyU7wjoOvMQ-1
X-Mimecast-MFC-AGG-ID: pyuynPR_NyaEyU7wjoOvMQ_1741250048
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0b7ee195bso91809885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741250048; x=1741854848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVFBDJpq+OLAVUkkYuhqX9NrEU4yq2FBIEz0GFuT+xc=;
        b=SSw7IyCiKGQ46hGb4M/aeuHmNQcvRZJouuOytfQlcNmetZ2iT0GwGSiMJLZb0Zcef/
         8lkED9HqkOySVL6FG27VH1xIDd7V3wp+p4Tlb+LFyYwp3PuZYesuuTX0DK6KsKxrFz/C
         zmZG0KqAcLm9ESFEIvHt18RLcKMCEfSRcxMge7P4UEu36Dooju3inC1Ic4nH5kSDdzcv
         6RkAdlk+eu+KIKvBcpmkvLUCUgCUjxsVo4fS0UePFgXXfzBnfZZ7Xi9GDtcXodhdu/FJ
         UJ7VgMLY3eC6WUOjmfmVqtEFz5NuGOcemlj01rwis7Zn5e4NbNAi8muGdkX2U1R3bKlv
         fFLQ==
X-Gm-Message-State: AOJu0YyvHY94SicGRjC7VOlCB2LcamTXHczvxqbRnD7QRmuQViTVYEH8
	GZbp+I+hRX+C/o3dMIYd6vX2rnmadk8FCZljuJyyEng4bls/xye70CgfcPeivy1+gStMCc0cZVE
	IH5IhCV5Gv/Hd8EAjzcFaN3Zs1zXuIgKAAym7JzfGiD1UGuAigQidWbe6WQvfVg==
X-Gm-Gg: ASbGncsc8YBFZuClxJjsyxQxjZp43EYyRpnAYtpz3nllHzaRSu6nmnl9FM+D0Z4ZiKW
	R8D0iO/J38yOrCfS7OFp0kUcsHAzvqySWymcjTU9f2pqdNfckYBDO1EkA7bic1lw14jX+s2+xr5
	Ygx5l0+3jQrpCZzAhIN2Me7tIYGMZlS/IvqEFL/DiLK8FxJypKrvyzJkxARhcjjOhQryDGqiSKv
	xngGhNUZZSbM0G3i2sSNkJ2P/lg/GIh55rmRnKB5Dv7lcNLAGdRu608Vksmr96kFnD81fK++kZ7
	sBrawbWWjeGm3q79mRLYTyzgXuJw3qTBE1r3JIlW+ufKV/nT7n42dmgtq+OaKl3S0wvzO3ZVCqo
	kY5u3
X-Received: by 2002:a05:620a:43a7:b0:7c3:d717:c0a4 with SMTP id af79cd13be357-7c3d8ea1affmr917471485a.33.1741250048288;
        Thu, 06 Mar 2025 00:34:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZRnjkumUJ/eM6/ka96Ogpv4ZIhNgKdZ2rJrJTuRVTpRw8PW21uUe5vsN/2ChkYxUDB6nUbA==
X-Received: by 2002:a05:620a:43a7:b0:7c3:d717:c0a4 with SMTP id af79cd13be357-7c3d8ea1affmr917468485a.33.1741250047994;
        Thu, 06 Mar 2025 00:34:07 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5389d57sm63078285a.64.2025.03.06.00.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:34:06 -0800 (PST)
Date: Thu, 6 Mar 2025 08:34:02 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, hbathini@linux.ibm.com, joelagnelf@nvidia.com
Subject: Re: [PATCH 2/2] sched/rt: update limit of sched_rt sysctl in
 documentation
Message-ID: <Z8ld-hutVNH3_aXF@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306052954.452005-1-sshegde@linux.ibm.com>
 <20250306052954.452005-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306052954.452005-3-sshegde@linux.ibm.com>

Hi,

On 06/03/25 10:59, Shrikanth Hegde wrote:
> By default fair_server dl_server allocates 5% of the bandwidth to the root
> domain. Due to this writing any value less than 5% fails due to -EBUSY.
> 
> cat /proc/sys/kernel/sched_rt_period_us
> 1000000
> $ echo 49999 > /proc/sys/kernel/sched_rt_runtime_us
> -bash: echo: write error: Device or resource busy
> $ echo 50000 > /proc/sys/kernel/sched_rt_runtime_us
> $
> 
> Since the sched_rt_runtime_us allows -1 as the minimum, put this
> restriction in the documentation.
> 
> One should check average of runtime/period in 
> /sys/kernel/debug/sched/fair_server/cpuX/* for exact value.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  Documentation/scheduler/sched-rt-group.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
> index 80b05a3009ea..ab464335d320 100644
> --- a/Documentation/scheduler/sched-rt-group.rst
> +++ b/Documentation/scheduler/sched-rt-group.rst
> @@ -102,6 +102,9 @@ The system wide settings are configured under the /proc virtual file system:
>    * sched_rt_period_us takes values from 1 to INT_MAX.
>    * sched_rt_runtime_us takes values from -1 to sched_rt_period_us.
>    * A run time of -1 specifies runtime == period, ie. no limit.
> +  * sched_rt_runtime_us/sched_rt_period_us > 0.05 inorder to preserve
> +    bandwidth for fair dl_server. For accurate value check average of
> +    runtime/period in /sys/kernel/debug/sched/fair_server/cpuX/

Looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri


