Return-Path: <linux-kernel+bounces-194084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721C58D365F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC762840CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6548F181305;
	Wed, 29 May 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aL40JY7N"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753C180A97
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985679; cv=none; b=RRMoYSR0QXlASgg8yMta+3wl+zvYHkdQnLrai5OWfJIUrkJhHmAgY/8FEc9t1KpH1N/jyuUwvM4btx5hDNJBNlidy4tNmp+LEeLBj4S6nZm9IrchYQxW9LnrORMACgSHpVM+7AgbwJF/JNuz2TCZDKPZALDwYNQZiktdDIIf+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985679; c=relaxed/simple;
	bh=A2PaivvbHJ6+z/fjXCVTj+U6wyPAAu3Zi6GtdqrEe/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEsavacvxkAuGUI8p4u5FPhw/6ZtfRAWYDK2Ol3Vn/TzEY96AK5TUxLI9cbfu1T5GVHbPnFJeJDs5x7RYBvdPz46Z2YDqQhQZOCnhP0TuwVeigsNKE7m3+OGSun3bw3WWtm0bcVv7tPxQvdFvPD8PMG0GHAnnd6PAzSJ4NjG8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aL40JY7N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so18459545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716985676; x=1717590476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0im46VMvTgzf4CgpxLpfyG0tO3nmPdi92aMWun6A3U=;
        b=aL40JY7NbITGm9rsaOajHY0od2yLPrcgjh1c+pwYeKC+MOx35gZgrD66vzfuNqMm7K
         mf9lcexXlKFBf8dI0oA6cSjAf1yNRYyT5sI7th4O2hbQE3rcm0Ilyo4fdugB4HGbtAJU
         bw2jZYPkHzr3uUZvZDetVSNCC9F9EZoGKODuGp27D/MffBcG3JdIg0YDABuvJkTN6650
         aOpPjePoIe73mNa3RqNv7YQuU2HkiUZ5xAp2U21nhbreedVpdK9OZK5oFhQOWkuASyWf
         WmHarB9QeLZs62XrL7EpMJIWRbezgPbswHldJQoXJ2Gg3w0fc+VsnlUma12ChjYS7U09
         +m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985676; x=1717590476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0im46VMvTgzf4CgpxLpfyG0tO3nmPdi92aMWun6A3U=;
        b=m269iKPo54hG5aSJtinVUyg4z2z1/sgIr3ECUrw7ADLwxWzEF6KDpuZkOlpDBEnTOR
         2YykkfJ25+cqP5thoWzIleWmuw6cOHv4/jOTD6Geav9AaKrf6mL1bfdcoWFyczOTlicV
         z26Nwiyjn3d3aWnxAu53R2AS36tEbMeANBgtaZ9mKI/roHBgJqhPr1hyjqgEDihltGPi
         lozXkwUoEmIQ0kbmVgEBTsBdPvC0/5o3YXdMgSAPBXwSx+XY/z/d8ZlX2BRUBOk+HNth
         PqJ56kVQX6aw0x7JZU12Yc+u7On5IjHCk3IS+WhaOosflec+hWWlyY2HtrFy5o6mD3IE
         nd+w==
X-Forwarded-Encrypted: i=1; AJvYcCWJwGzGoy7tj15NvUejGhgNOaaSLx1vU1KQl2Uh1s5iILA0x529GQZMLkMd3rArnStoEvnnC5AdD3PqLk5WRZUjlSZRhheK548bBzMp
X-Gm-Message-State: AOJu0YzV1LUUkBSTH9MyNcL/SLBw+HDPxTrAg9XvAcpubsKAeB0lQWuC
	zxCGhgG1kWqX5Y8t2SyUCE7LjIYgWaXyLF21FJsUpUlUMYbiFfqAxDc5KCDB3xQ=
X-Google-Smtp-Source: AGHT+IGh33p4hKsb6CQ/ea4derqiTxXb5sBTzSj5MqjCQx3uSuJyvMs24xDjjXfWO5KMwaEt87X2sA==
X-Received: by 2002:a05:600c:5593:b0:420:2b2e:f6e7 with SMTP id 5b1f17b1804b1-42108a79034mr125180765e9.17.1716985675868;
        Wed, 29 May 2024 05:27:55 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad7fasm211038455e9.38.2024.05.29.05.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 05:27:55 -0700 (PDT)
Message-ID: <0c53415d-3394-455a-a6b5-99d3efb92318@suse.com>
Date: Wed, 29 May 2024 14:27:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/xenbus: handle potential dangling pointer issue in
 xen_pcibk_xenbus_probe
To: yskelg@gmail.com, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: skhan@linuxfoundation.org, sj@kernel.org,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20240529122232.25360-1-yskelg@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240529122232.25360-1-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.05.24 14:22, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>
> 
> If 'xen_pcibk_init_devices()' fails. This ensures that 'pdev->xdev' does
> not point to 'xdev' when 'pdev' is freed.
> 
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>   drivers/xen/xen-pciback/xenbus.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
> index b11e401f1b1e..348d6803b8c0 100644
> --- a/drivers/xen/xen-pciback/xenbus.c
> +++ b/drivers/xen/xen-pciback/xenbus.c
> @@ -54,6 +54,7 @@ static struct xen_pcibk_device *alloc_pdev(struct xenbus_device *xdev)
>   	INIT_WORK(&pdev->op_work, xen_pcibk_do_op);
>   
>   	if (xen_pcibk_init_devices(pdev)) {
> +		pdev->xdev = NULL;
>   		kfree(pdev);
>   		pdev = NULL;
>   	}

NAK.

This doesn't make any sense, as pdev is freed.


Juergen

