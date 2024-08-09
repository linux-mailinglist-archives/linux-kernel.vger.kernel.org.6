Return-Path: <linux-kernel+bounces-280642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A1294CD38
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7507EB2138C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFD019149A;
	Fri,  9 Aug 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PY9zvAjb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5EBBA41
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195161; cv=none; b=iSYfobzKiHLYk2rHjOlyisn3rdaSR+dVO74dAt+zObuj/tCZzXlby6X77bZys5/1o6ncuzVduhnZqfonQ1CLRcuxG2vKj6slSOZtt/JVNm1S/qzgGE2OesHS2iBXQCt2D2dW33jh/QgxXtFJYtcxknO8kTdiwZVljNAXLjQEe78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195161; c=relaxed/simple;
	bh=OQ0rUY9k5366jlj4+dUr0oPb1JZFBuOj6IVbjHA5Pe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPd7wRa5b3LMJJ8Iw4PpabSLvwtCWltsdYZq7LsT775RPlD5oq6/7grx/byFVj/jXTZIrju8JxHqR4GIU2KWB5mkOPiUpThpxqo5prj24nIPUqQYF7EQdcSo0mjEUD011E8nCPFwqgP27zZwr/KiYbSuRIlzLzK67B46DenVBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PY9zvAjb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723195159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pZWUGLODRsv8EeGlSVOUvCLclv5jllzVt1XoedXh4CA=;
	b=PY9zvAjbMIFeto7xFd1yuaCYupjI3RDOmHWQMVVK35mcGUbmIHEEgoySsz1+lrZfPPPdFQ
	jq3cSXPiTgOaYyUL+nAXg+SxwCdB/oHWaAFat807LKxHLd1G9xqKkaOHmjZ4ruYfo+6bl4
	VxKcJmfr7TkfkWyGwzqwdK/pp7od854=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-xKaf1nYgNK-DLbiFv78n4Q-1; Fri, 09 Aug 2024 05:19:17 -0400
X-MC-Unique: xKaf1nYgNK-DLbiFv78n4Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef244cdd30so17901751fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195156; x=1723799956;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pZWUGLODRsv8EeGlSVOUvCLclv5jllzVt1XoedXh4CA=;
        b=C7+urYkFhe8di0gC9HyziQx4dkyevQfHSoPo9yiOeBTdZagA7OuT3dxJ+Td/NASANF
         5U2XgUxb0fDyIKL54xzLSSXXd1yK6cdyTW00mLa8EPah7HtYZ2ufbuMOtW3MMV5bW+aM
         TPuk0hvvP/HjY6G8r0BEMYEb2MSk89Y0Bqv1wUf70+cyc4rJWDdig/YeRY3s+3Qagw4j
         9+GgskfCFEGdTLqe+hpgQYHiGOz9VUiHLTgPWbkQ/6NDSGTgfulkIcyfIh/qfq7stUDj
         0SJ6AFxbQSISxtltL6WPeSPdsX99wZqn7rJ7wHjWQg0P4vnCMMeJBq5ylsYOjywYTwQt
         ct7A==
X-Gm-Message-State: AOJu0YzKZBgWNMBmJso8Rj/Yuv6cEsFeJAVtJvmV2ta8D3DmGMzQnKM/
	Ah0EWthHFJPlM5M67NuSHMePm8kMdJbQ8s03PHayP1XXcNXLt0xMJ8yR/YMSdXeCTrGx2CXITJC
	bI6yn+Q2b6oauW89LILyIZwS6gljLj9Jb8EZeMZPa1DEVzCQSnQM8hsXkEhnZBg==
X-Received: by 2002:a2e:a7ca:0:b0:2f1:a7f8:810f with SMTP id 38308e7fff4ca-2f1a7f8823fmr6448541fa.36.1723195155756;
        Fri, 09 Aug 2024 02:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERFqdldjC5PnskzxrtRFwNOGuYPceqmKH7g+/yiqBvbrTGXJS29rX4SHxyUZiKMEecTdYb1Q==
X-Received: by 2002:a2e:a7ca:0:b0:2f1:a7f8:810f with SMTP id 38308e7fff4ca-2f1a7f8823fmr6448291fa.36.1723195155202;
        Fri, 09 Aug 2024 02:19:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:4e00:b097:7075:f6ba:300a? (p200300cbc71c4e00b0977075f6ba300a.dip0.t-ipconnect.de. [2003:cb:c71c:4e00:b097:7075:f6ba:300a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059a8912sm120876935e9.38.2024.08.09.02.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 02:19:14 -0700 (PDT)
Message-ID: <99b78488-c524-4269-b1fb-a13eaa4f274c@redhat.com>
Date: Fri, 9 Aug 2024 11:19:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Barry Song <baohua@kernel.org>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240808101700.571701-1-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240808101700.571701-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.24 12:16, Ryan Roberts wrote:
> Add thp_anon= cmdline parameter to allow specifying the default
> enablement of each supported anon THP size. The parameter accepts the
> following format and can be provided multiple times to configure each
> size:
> 
> thp_anon=<size>[KMG]:<value>
> 
> See Documentation/admin-guide/mm/transhuge.rst for more details.
> 
> Configuring the defaults at boot time is useful to allow early user
> space to take advantage of mTHP before its been configured through
> sysfs.

I suspect a khugeapged enhancement and/or kernel-config-dependant 
defaults and/or early system settings will also be able to mitigate that 
without getting kernel cmdlines involved in the future.

> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> Hi All,
> 
> I've split this off from my RFC at [1] because Barry highlighted that he would
> benefit from it immediately [2]. There are no changes vs the version in that
> series.
> 
> It applies against today's mm-unstable (275d686abcb59). (although I had to fix a
> minor build bug in stackdepot.c due to MIN() not being defined in this tree).
> 
> Thanks,
> Ryan
> 
> 
>   .../admin-guide/kernel-parameters.txt         |  8 +++
>   Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
>   mm/huge_memory.c                              | 55 ++++++++++++++++++-
>   3 files changed, 82 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bcdee8984e1f0..5c79b58c108ec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6631,6 +6631,14 @@
>   			<deci-seconds>: poll all this frequency
>   			0: no polling (default)
> 
> +	thp_anon=	[KNL]
> +			Format: <size>[KMG]:always|madvise|never|inherit
> +			Can be used to control the default behavior of the
> +			system with respect to anonymous transparent hugepages.
> +			Can be used multiple times for multiple anon THP sizes.
> +			See Documentation/admin-guide/mm/transhuge.rst for more
> +			details.
> +
>   	threadirqs	[KNL,EARLY]
>   			Force threading of all interrupt handlers except those
>   			marked explicitly IRQF_NO_THREAD.
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 24eec1c03ad88..f63b0717366c6 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would block the collapse::
> 
>   A higher value may increase memory footprint for some workloads.
> 
> -Boot parameter
> -==============
> +Boot parameters
> +===============
> 
> -You can change the sysfs boot time defaults of Transparent Hugepage
> -Support by passing the parameter ``transparent_hugepage=always`` or
> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
> -to the kernel command line.
> +You can change the sysfs boot time default for the top-level "enabled"
> +control by passing the parameter ``transparent_hugepage=always`` or
> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
> +kernel command line.
> +
> +Alternatively, each supported anonymous THP size can be controlled by
> +passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
> +``inherit``.
> +
> +For example, the following will set 64K THP to ``always``::
> +
> +	thp_anon=64K:always
> +
> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
> +not explicitly configured on the command line are implicitly set to
> +``never``.

I suggest documenting that "thp_anon=" will not effect the value of 
"transparent_hugepage=", or any configured default.

Wondering if a syntax like

thp_anon=16K,32K,64K:always;1048K,2048K:madvise

(one could also support ranges, like "16K-64K")

Would be even better. Then, maybe only allow a single instance.

Maybe consider it if it's not too crazy to parse ;)

-- 
Cheers,

David / dhildenb


