Return-Path: <linux-kernel+bounces-426987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C969DFAEB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449DB2819A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0301F8F10;
	Mon,  2 Dec 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EkCmAjT7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516D1F8AFE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733122431; cv=none; b=F83gnqDP5ari/5ID9OpDz2qwZrrH/K5bab3oGjft/Rf68wXC7Avh58Bh6LEBm9W2qN0KAQerw6pCcflh4/PSUbgRd0qCuXtlcaK6m+C8ABaooKF7AuP/85VUcgqthR177yTW8tdMM9CfAcM6/w7RpM9BJZOX1q4lkfBldpFw4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733122431; c=relaxed/simple;
	bh=/BNYAN6wpNnHKs/oDKFq3AhVYUv1Zx9wpbmuk/sPDkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgBsO3VXzKK5SJajwL/q4xMAu10d4SmvsmQ6YRlByYuViElYpuSMk/zM+ag8YjhuIthkyWYA9LoCBfTDCGse197nudrmwc8hfMpS3YVsVVC6p67C3RAO2PXQ+0Ff/vkrvjz5FCYzAeV/f2oN7lmaDH74xGM7yGmeadt94EN3Wag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EkCmAjT7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43494a20379so30946445e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 22:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733122427; x=1733727227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBwRkSqaDk16OT0cWKuU5nC1LlQfiaVj6VE7RXOk0Rw=;
        b=EkCmAjT7s5sQsaOx39pbGGi0e24BIxLL6AGK7xdoRzuWpNcgUySKwhqoidoaDwm02V
         ebkrWi798qrnbaZflAyASNo99t8yI2PXTO4G63hGN5j3X/ml1l/x8meTmTF79w/pb/+E
         5bSFUQYf4o6aPtuORbGA6T8HQyeBqZxkVJkCXu+vOMxE8QLdwd3Fq2lDFt+XLN6XjPBk
         kTwhnV7R8R/r1LVwJs9bC75jQo3/SSIz/c5u3zWhAf55spiUnMST1NUAKgtkXpvltSzN
         54qyf3UKsUbfHCsn/6RkSa07Zh2pjmhStGQFWEN1Ve4/qOAymtBTxkECbt2W9aiH6kLw
         WSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733122427; x=1733727227;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBwRkSqaDk16OT0cWKuU5nC1LlQfiaVj6VE7RXOk0Rw=;
        b=S9jS9i012St7alpt/gKkOqeNT7KPosVdphvULBdV03p8kdkLIPwNO/WA6uwKALFhPx
         kjy0xkHrgoM0qTqZQuJ/erc0E+v2q437hit8ChARmT+jVHuqSZuJA3h39JLgPFqN3sXG
         hWWNfIS3Gyyjt10fafo8pSnai0gsOPnuMLRrHFgiwQz/ZqWrqLZpQllVsx4c/spoDmle
         N5o8e0e41V85cfN4wrwybyl06DZ/DIARBceRKc0XVCZB15eQt3fMJ8pH+18gkfqQGwDO
         cPhprDQWDPADORB0gx6LTdrq5LtA+9T+P8Xnpkm202O74ivracIhCxTVv5QxGqGm08LX
         tRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXSLMAWNOlRyU/2p1tz9ApY2q9h4gPxmlfumq00K1dfn+b1X/KCYKFmOyrALJL1P0i5HMzJcqqGbBuO18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8E1u5DgmvGFkLdUhDnRJOgQqE5F7qABR+rOGub0V006N5DcUX
	vR0lw9kWyk05pvBqFL8vHxW7ZSlM1Nnvp3MgATnQ2lQeYzvwvZcmUls28cWhqSs=
X-Gm-Gg: ASbGncvHWWdHfkV0+fW+F9am/ZIOnU3BBO9kWod3EOAvu+ib/vvDXo0InHs7nxUFNOV
	X/BrZ0tb+vl162RyOa77uY2ZkJVGp5KIktHne7czKGytEo3mQ4YkKSZVrHR+xhEMyeRbLUJdjSG
	tRO4EEJXwcyIoOpVDPWtYEMkzvvhY57gDCVTCqna9fFfQT1pOAw/BQ7BeVG1HKinlS0W5REyvmm
	hLtVhY4SDkTbjjKeC4ScAAjmq/GhWsryybnPGUWgtwokZTmtoYHMZu48/30UrubZXyOvfDaW/8=
X-Google-Smtp-Source: AGHT+IHX+ruqdSKlA8Ez3jIo3QBzTHDopn6mPaNmwt/kl5a2XU/RrhjyNjnbO9p4e1jPi2fQKIYeSQ==
X-Received: by 2002:a05:600c:3546:b0:42f:823d:dde9 with SMTP id 5b1f17b1804b1-434a9df6de4mr161027935e9.21.1733122427037;
        Sun, 01 Dec 2024 22:53:47 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a5d56da3sm129993795e9.0.2024.12.01.22.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 22:53:46 -0800 (PST)
Message-ID: <f9753978-6505-43ad-a224-a78ab5141f45@suse.com>
Date: Mon, 2 Dec 2024 08:53:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Chen Yu <yu.c.chen@intel.com>,
 Len Brown <len.brown@intel.com>, Radu Rendec <rrendec@redhat.com>,
 Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Huang Ying <ying.huang@intel.com>, Ricardo Neri <ricardo.neri@intel.com>,
 linux-kernel@vger.kernel.org
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.11.24 г. 2:22 ч., Ricardo Neri wrote:
> Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> adds functionality that architectures can use to optionally allocate and
> build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> arch specific early level initializer") lets secondary CPUs correct (and
> reallocate memory) cacheinfo data if needed.
> 
> If the early build functionality is not used and cacheinfo does not need
> correction, memory for cacheinfo is never allocated. x86 does not use the
> early build functionality. Consequently, during the cacheinfo CPU hotplug
> callback, last_level_cache_is_valid() attempts to dereference a NULL
> pointer:
> 
>       BUG: kernel NULL pointer dereference, address: 0000000000000100
>       #PF: supervisor read access in kernel mode
>       #PF: error_code(0x0000) - not present page
>       PGD 0 P4D 0
>       Oops: 0000 [#1] PREEPMT SMP NOPTI
>       CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
>       RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> 
> Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> not done earlier.
> 
> Moreover, before determining the validity of the last-level cache info,
> ensure that it has been allocated. Simply checking for non-zero
> cache_leaves() is not sufficient, as some architectures (e.g., Intel
> processors) have non-zero cache_leaves() before allocation.
> 
> Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
> This function iterates over all online CPUs. However, a CPU may have come
> online recently, but its cacheinfo may not have been allocated yet.
> 
> While here, remove an unnecessary indentation in allocate_cache_info().
> 
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Radu Rendec <rrendec@redhat.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Andreas Herrmann <aherrmann@suse.de>
> Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

