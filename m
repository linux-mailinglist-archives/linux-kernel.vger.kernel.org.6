Return-Path: <linux-kernel+bounces-432536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9712C9E4CA0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C862828F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B755D18FC79;
	Thu,  5 Dec 2024 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecisg8ge"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A631865E3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369092; cv=none; b=CcVq3xC0ZmWRnvHgp88lkg3gFfWgeEtTh+DcK2hVQj37bT9vJw3jX95xwz2Vvo09k7acsYXV21lW3TEpVaqazRdMOS2I5+5If1jtibSWYZhUJeNI2CY4x9otaQ2oYFW6yivIR95o2W3LmggGDfpD4JnnDQ0W5LPTRl0er8j10iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369092; c=relaxed/simple;
	bh=RwkxEFFv8q3ISwP2l+RC1VYFZ/XHGfddE826DaC9HK0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=T80BsrvKhny128S5wybcSgy0csh7qpIuKghnYShr1YR0+8/JNIc39VvSO3LXz5ZckJXSg7cGwOAPA727V3NBpOx61BmOkEmMQOfmg4hN4iJXWlITX2WgNmhBFc5owJc2O2GZ2426pEEQ0c1G/t22yKzTqESu0fxZA+yp2IFsntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecisg8ge; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733369089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiW4fVWTfbek1lugR+wCShZlU6+zULbZMymUmbRO2/g=;
	b=ecisg8gev0a6+JFz3zQy12n7EaNcZwbKSyIJHkcjhpOniswgwhHHPgToIh1ORx1tEoxt/d
	g/1maOWMAYmPkFhKLy1KntJZyU6MC/1ixcADF83U+egdSq5FWJGlkkaRtSYVF3n3rXpnEi
	+duiN7SjPxfYVHSE76j2Im8GuYKS1kI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-TMbLvK0UNw25f6Xcs1fbXA-1; Wed, 04 Dec 2024 22:24:47 -0500
X-MC-Unique: TMbLvK0UNw25f6Xcs1fbXA-1
X-Mimecast-MFC-AGG-ID: TMbLvK0UNw25f6Xcs1fbXA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4668e97e00eso9041421cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 19:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733369087; x=1733973887;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiW4fVWTfbek1lugR+wCShZlU6+zULbZMymUmbRO2/g=;
        b=oBJS7kS7zem1/hNH3iPsOwqm7/OGMb2hil6bKy8lRzsnQUYoantnTEjErRCpXeSvyk
         fvkgDGzMKsXl5onpDVEZCPmTNyper2hgaB01ixHS0mxkvt2Z4Yvi9def5EnkAYrUGEh6
         6IQAyrSvEn0A21VfyX9tqtXDEtet/VhJmvosZdwJLX+RcUqGNnRijzeUTkq6apoFjIeH
         ugIu6CMdQBtMYahNQf410EUW3tHhlNufU7qJtVKKP2e2/idTJYKCB7rj/v3bDVGi1j9y
         At80WK6b+abxNV3CDptloEeFiamecU2KRRCBJOwyiWloH+W3NM72GNmkiM5jufEPTCi+
         nJWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdN0fKVC+utTcSm3G4cY8kFUjjFaijksuWU12J40zeQQeTFdinVRC90w727IpSh1fYwoNfbTuCp2rR/Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YypH7pCEfnyRCMNeFQ8DVJLZexedtWWUQi/i/ADuS9hDNEBNQxw
	ECqOogtik/ObbqYxH5Qxk7XVJo3p7pnrxl7EMP93HmSD/qJgDfIpyPJApAPwWYxC/flL2VRpL46
	rZfX4NWnHwC66e/Qiy4otkXy2VPoBp92ATsccfrdyhkcOMksQwp7UQG1Ni18rDg==
X-Gm-Gg: ASbGncvC2I/wuELQQODPA1wZGImNFGR+Qpl0Hr1ZDouxYjAi2er3FKE7s3jjpWa6Twh
	LNdo22Lv/Ftxv5CW7wJp8IhgN698yYeEqPuBV0gOA9Ao2e5tKO+gTmmfWVPadc0aqZhgQR4gu8y
	08SlcrJiwvXdBbc4EqjH19zBl6R3cbHMu6WEb91SrfZ9pP9Q9eSebViRJAka5F8MzQz9dAG8fBK
	P5zPz466rITtUj5UXo4RTWIan/Fpf3GFcHSnDiCiYI3EuLc3erby//qd8kZKFvQWbLvH4mmvbGm
	ftTOewCWFdLaQSmh6g==
X-Received: by 2002:ac8:57ce:0:b0:466:886f:3774 with SMTP id d75a77b69052e-4670c06e83dmr154847751cf.8.1733369087330;
        Wed, 04 Dec 2024 19:24:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWtUXxytWVON4jfgw8C4Dr74OEBtaexKT/xIm04jm+Elc+DONnLu38y3+rhOG+Ezdamtl+8w==
X-Received: by 2002:ac8:57ce:0:b0:466:886f:3774 with SMTP id d75a77b69052e-4670c06e83dmr154847591cf.8.1733369086990;
        Wed, 04 Dec 2024 19:24:46 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296a4930sm3288371cf.18.2024.12.04.19.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 19:24:46 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <92427cf8-782c-4681-b0e5-a7ebee79dd63@redhat.com>
Date: Wed, 4 Dec 2024 22:24:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: Remove stale text
To: Costa Shulyupin <costa.shul@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241204110442.348402-1-costa.shul@redhat.com>
Content-Language: en-US
In-Reply-To: <20241204110442.348402-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/4/24 6:04 AM, Costa Shulyupin wrote:
> Task's cpuset pointer was removed by
> commit 8793d854edbc ("Task Control Groups: make cpusets a client of cgroups")
>
> Paragraph "The task_lock() exception ...." was removed by
> commit 2df167a300d7 ("cgroups: update comments in cpuset.c")
>
> Remove stale text:
>
>   We also require taking task_lock() when dereferencing a
>   task's cpuset pointer. See "The task_lock() exception", at the end of this
>   comment.
>
>   Accessing a task's cpuset should be done in accordance with the
>   guidelines for accessing subsystem state in kernel/cgroup.c
>
> and reformat.
>
> Co-developed-by: Michal Koutný <mkoutny@suse.com>
> Co-developed-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>
> ---
> v2: Address comments
>
> ---
>   kernel/cgroup/cpuset.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d5d2b4036314..ee62207fee9f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -207,10 +207,8 @@ static struct cpuset top_cpuset = {
>   
>   /*
>    * There are two global locks guarding cpuset structures - cpuset_mutex and
> - * callback_lock. We also require taking task_lock() when dereferencing a
> - * task's cpuset pointer. See "The task_lock() exception", at the end of this
> - * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
> - * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
> + * callback_lock. The cpuset code uses only cpuset_mutex. Other kernel
> + * subsystems can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
>    * structures. Note that cpuset_mutex needs to be a mutex as it is used in
>    * paths that rely on priority inheritance (e.g. scheduler - on RT) for
>    * correctness.
> @@ -239,9 +237,6 @@ static struct cpuset top_cpuset = {
>    * The cpuset_common_seq_show() handlers only hold callback_lock across
>    * small pieces of code, such as when reading out possibly multi-word
>    * cpumasks and nodemasks.
> - *
> - * Accessing a task's cpuset should be done in accordance with the
> - * guidelines for accessing subsystem state in kernel/cgroup.c
>    */
>   
>   static DEFINE_MUTEX(cpuset_mutex);

LGTM

Acked-by: Waiman Long <longman@redhat.com>


