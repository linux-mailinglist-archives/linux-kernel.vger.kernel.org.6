Return-Path: <linux-kernel+bounces-517152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E94A37CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988893B09FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14D1A08DB;
	Mon, 17 Feb 2025 08:08:08 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF418FDC9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779688; cv=none; b=YqorwCqVtUpurxkvllgNzYurblKgB32PzqwDlix1O0/aSz8kYlXkV1+DpIl0Z7pccFAbBKrRF7jnqjVqfN0Dnu5F+kyGZoiFon7bwfZ+l2ecA7oDrtYz0vBX9BbzeI69Z6RgXAzU8VcL1uaeZ/az+vlcRu0Kzq8GFi+dqGllhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779688; c=relaxed/simple;
	bh=rsho1jtu2mE/C0fXdcJoK81YtLdyywLTxubxvvs4+S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUDlYdoFBypAlpwJ5PNYseNMcguBuh+VHm5cjOKlJUH4KNiqBikC9X0ASho/m5YLnkmoKlujoU7nPa59Kmop+iAI8NCpLuJsv8iergE6M8zg37OdKXPXAi5/KEswZ0uEn8M50OL405pUxpoURRG2Bn0iq2G52IDgNUrCuST73v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so42262465e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779683; x=1740384483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2wFYX8dgaktOSAgfZPyadoLd/GGU3mSBDrqYC4o1Vc=;
        b=vjU2vbx0AX2/WpEUB43pZfeKhs1rfoVm8d5si4nRSg6/Wd6oMZsiDf0lxNTy/XoVFG
         kk4vgAi+YiNO86SCMU/79T3T90A5DLCH7tr/86IIQwxbJKsoLP2oAlJ5r+dSEC44Vo/R
         w72L+B8GQJNAZtnpbaKQJtr2ZvbC665md17kHFZ/Kkuijj2AlQElkCmhGPvJ51hBcyxa
         R0eVRxVZrjWhh1To9Fei0nfd0Ww6mOcW2tYwex9V3LB7HUdjVGVmvtb8gQzeto4hwR/c
         ZT9wqZBbz2dLoAlL5VHGGNjnxqN5WH3FT5z+UlUVv7PntjeCA4nqAor/lJgKT0xhpjr6
         83uA==
X-Forwarded-Encrypted: i=1; AJvYcCV4XarUfWeGCwvqRtSinK6E3Qp1LatDrZIc+4pvgqPhcx6Qa5dwNRPNClRwg0/TTZExbuO7YHqICzl2GQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0F5rsBDdnsgvGrajwYMCY3bAqiRbKBTvcaHrSeWSXiKfgsOGD
	oFuJPxdI0ZS8NTVFV5apzP2ye4IeylxTi5rnkWBge9H6RRi7QMjA
X-Gm-Gg: ASbGnct2A9ivT7DJRjNhSwa8ZnX+bRlW/L0IENmXm8XGIKwgmaXIRgw3I2e6SGgNxH3
	SxT8v7J5OwZSURt23LZLZI7VjC3UzjqmsmCWsM0vUa0y489q0gf5Q/KyRp38D7lXxadHsiQraHX
	jF1QgUIFRK8cMFz9j+YwuU+Pjg39QTjf7y+ujgJud2zwE71D1glZZRSUnaVlfeR8+4Devrp8Qdf
	mjdrzSKLolZHGPkLqirhe9oGhVilzRfBZuvYMlUQMSr2BN+8Nt1LlMBZKzCMMrPF0Wdj0e3caJk
	z3w6ZtB2gWo0NlerYOCiLfFo90oyJ3/TpGLqk67n49Vwi4hDCcm5kcAJWw==
X-Google-Smtp-Source: AGHT+IFNcTDOkaZQlTyUplPUqQ21ZWQqF0+0Rp/O3wOz3kPHGdMVBsJAT9nt0R2HPDY5n8OxJZJKPQ==
X-Received: by 2002:adf:ed48:0:b0:38f:2a3e:870c with SMTP id ffacd0b85a97d-38f33f38891mr8801531f8f.16.1739779683530;
        Mon, 17 Feb 2025 00:08:03 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4314sm11408949f8f.9.2025.02.17.00.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 00:08:03 -0800 (PST)
Message-ID: <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
Date: Mon, 17 Feb 2025 10:08:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de
Cc: bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 13/02/2025 22:37, John Meneghini wrote:
> Keith, Christoph and Sagi,
>
> This patch has been fully tested and analyzed by Red Hat's QA group 
> and no
> unexpected side effects or regressions have been found. Both NVMe/FC 
> and NVMe/TCP
> have been tested. Our QE engineer has asked me to report this upstream.
>
> Tested-by: Marco Patalano <mpatalan@redhat.com>
>
> Fixes: 32acab3181c7 ("nvme: implement multipath access to nvme 
> subsystems")
>
> As discussed in previous email threads, the nvme.core_multipath 
> parameter was included
> by Christoph in the original implementation of nvme/host/multipath.c 
> back in 2017
> at the request of Red Hat. At that time Red Hat was only supporting 
> DMMP multipath
> with NVMe and we needed a way to disable core native nvme multipathing 
> without
> reconfiging the kernel.
>
> The nvme.core_multipath parameter has been used by Red Hat, together 
> with some additional
> out-of-tree changes to nvme/host/core.c, to support DMMP multipath 
> with NVMe since RHEL-8.
> However, the plan all along has been to deprecate and remove support 
> for DMMP multipath with NVMe
> in RHEL and to remove this parameter. This change has been advertised 
> and communicated to our
> customers and partners, beginning with RHEL-9, through release notes 
> and other communications.
>
> In RHEL-9 we changed the default setting of this parameter from "N" to 
> "Y" to match the upstream
> kernel and the move our customers to native nvme multipath. DMMP 
> multipath w/NVMe was deprecated
> in RHEL-9 but still supported. Customers were still able to optionally 
> enabled DMMP multipath
> with NVMe if they wanted, by changing this parameter, and many of them 
> do.
>
> In the (soon to be released) RHEL-10 release DMMP multipath is longer 
> supported with NVMe and
> the out-of-tree patches needed to support DMMP multipath with NVMe 
> have been removed.
>
> Red Hat is proposing this patch to remove nvme.core_multipath 
> parameter from the kernel as we believe
> leaving this non-supported parameter in the kernel for future releases 
> will only lead to confusion.
>
> We plan to ship this patch with RHEL-10. So it would be really good if 
> we could get this
> change accepted and merged upstream, perhaps into v6.15.

Hey John,

This looks fine to me, I'm assuming this was also tested with 
CONFIG_NVME_MULTIPATH=n ?

