Return-Path: <linux-kernel+bounces-556370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16780A5C4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC017A47F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B0425EF81;
	Tue, 11 Mar 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYxmACJ4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881131C3BEB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705630; cv=none; b=HTtBMG5xC/9S3bkolahgiJrYGVRUXC1A7gPNat/KLTe2+eLnir9CCM9hDx7iw2OvClRAYQsfRkl+qHZIslfYHQlBegON7EzUsWbtKLu6/J9BTy3w5O196/KqxG9JoBplxrY+M+Jm8gewO+gosfTZ1wiS9zdMCl6guM8gb1nrBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705630; c=relaxed/simple;
	bh=Dawmuk4eFgkgU5MwhrBGTiEGZORF2E7FMEQk1S+++ok=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iTLx4h2SdgC6gVfES5JBdXF9JDEmLIlcSrisj3aWTNgxx42W7soE8dPpa19NeEHEVinJASjdaawlMjBlbHIkmkpToHHbQ3ruJ2BeJqqBfaUocX9eqBSz42aeLRLZFPyPIjdztzxdvRThXWmem6N5+m0U5iH8B1hn+qjMj/2tgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYxmACJ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFd1ExBPEt0Dfyww2+rzGd1ksO5mjGdVVVOBajHIlYI=;
	b=WYxmACJ41X5Bqc1zO8Rw+7gF2Zz3pwrtMYaO2ZLV1BTq/XI3KMlAh9zDs8f061hIEixNec
	LMIELm5WUQ+v/orksBBUvZaQQe2GmKcfwaud04NtkOvrkn39qDQF2sBV3jghO+/MZIyqfI
	r8SEFkTuEXJ4A18jI5vZciCMOMq603g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Twk8D3paNoCUxRNKs63myQ-1; Tue, 11 Mar 2025 11:07:06 -0400
X-MC-Unique: Twk8D3paNoCUxRNKs63myQ-1
X-Mimecast-MFC-AGG-ID: Twk8D3paNoCUxRNKs63myQ_1741705625
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4766e03b92bso60695331cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705625; x=1742310425;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFd1ExBPEt0Dfyww2+rzGd1ksO5mjGdVVVOBajHIlYI=;
        b=RQQi2tzb4UXplvvzcqSmkPUWt6TmCGV78AGcKJB2Mlnt81ikRQMCzmkfwlk7OkytE6
         BdX+K2ijHK67+Kki+5VvcF9XT+WS5EEQPkP7aL6CLuIqRw5J2fz0oOo/BrhotDxGZ7hd
         mnFyCZ4p355IVws2V7qqnereaqnSIcd9deIMdODk4SfzFKW5hkGxqLFi3QRWDxHmwdIz
         b6/p55Mevoj6WInIugN8ZMQWoKAefwNxDd1lZnGe0T/4FXfBW7I/vJjA/opPTTY0YKde
         ju/0NV0IgYnZnE/isBWxtZ/W3l6q9iF0StaAVI9mU6Lz0x3OnqU5oKvxlWhSQCBQzQ6i
         I4kw==
X-Forwarded-Encrypted: i=1; AJvYcCWLa1wmgZMmNoYYT/6eKAAY3kEZbEkuVvZO/i9kQmRrQr3xTkIbT9SKx7nZsWO/iaYkCy/2qVSxt35GeWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQme0UV1pUNAbEhGLN5FyAWL4ReYDVGnFuHJYMk9D4eQvkH8Fn
	uZIclmW6p+MZlQ44H/CGAb4MjToFK1k1ndu+hePfeP8Y3yx/Pp7fz86yAgZxXWCIkmhtrJabEMC
	1i8YxFBn7gZXDpkJ2wr4ZfEW/SIMXQb9211LaUTZ83tm/Dkn624y1EPGw0lEIOQ==
X-Gm-Gg: ASbGncv81m8DP5I+1eQY17HqlXcd52n6slsZDuotxBpaD+7P1/TboJQg3qwPcKet6u5
	okfBCAB1pNQaZkWLCNSO86beAzkf6dGhY3Tu4rokqw0S2uf3xdgkJBgm+GDrocVphUC7im/mcSr
	2YC5BXL/W12C25ACIOv3ekQdaqvbaeKcw77AHboIEpDK8mlYlL8D24GE7fPvy7JPIUCC43nlPGx
	3sFG6q8Aql5xE5iQ/ep8aBoLUHTgF4e4mGPG1czVpQI8ucvg4wZeUli1KZ9c6fGAvgKWmOToQnb
	xYBdS5B3imOo28/V9GhPIpXTbi/kXfyHJa4LVD1WlkEeYmP98BX5SIlBeUCo0Q==
X-Received: by 2002:ac8:5956:0:b0:476:5fd5:4de7 with SMTP id d75a77b69052e-4769960eaf4mr63992361cf.41.1741705625650;
        Tue, 11 Mar 2025 08:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcTKH15BMvz0iV4fiI1KTJpmb6vk5YFJA1fTIm45MoXYHgz9eGSlC/+8KqB1nS3XsadACJ8g==
X-Received: by 2002:ac8:5956:0:b0:476:5fd5:4de7 with SMTP id d75a77b69052e-4769960eaf4mr63991921cf.41.1741705625335;
        Tue, 11 Mar 2025 08:07:05 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4765f877398sm50151521cf.4.2025.03.11.08.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:07:04 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d2a3328e-c8b1-4697-9a97-c198fe672f40@redhat.com>
Date: Tue, 11 Mar 2025 11:07:03 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] cgroup/cpuset-v1: Add deprecation messages to
 memory_spread_page and memory_spread_slab
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-3-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-3-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/11/25 8:36 AM, Michal Koutný wrote:
> There is MPOL_INTERLEAVE for user explicit allocations.
> Deprecate spreading of allocations that users carry out unwittingly.
> Use straight warning level for slab spreading since such a knob is
> unnecessarily intertwined with slab allocator.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 9d47b20c03c4b..fea8a0cb7ae1d 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -441,9 +441,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		cpuset_memory_pressure_enabled = !!val;
>   		break;
>   	case FILE_SPREAD_PAGE:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
>   		break;
>   	case FILE_SPREAD_SLAB:
> +		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = cpuset_update_flag(CS_SPREAD_SLAB, cs, val);
>   		break;
>   	default:
Acked-by: Waiman Long <longman@redhat.com>


