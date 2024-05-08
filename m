Return-Path: <linux-kernel+bounces-172854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926D8BF786
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238D428561A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202836AF3;
	Wed,  8 May 2024 07:49:01 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363572C86A;
	Wed,  8 May 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154540; cv=none; b=hn9aYXvHe/MY4WFQP4sT9m9JWifWewnlSe3JtKCsAf2MEgQHZziPB93vV4uSKnOJ44bFNbs2b0HuvAAuhU2hGuP9kEEzMSYsyXAWR/bCNrRAP/YEPxd9ywTwUVToHcsvmXHwIIyyyl6d4405Y9Q1QIOj8wusLB3xBgx6RzkP+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154540; c=relaxed/simple;
	bh=UNGBSeWj3kAH9AELmuz/k/gmtKWSoXSE1ObAtSSeO60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYz6JbwUS6pj109EwfPSspIZcYrpomo3f0b1jhAWEVjuxHCj7FhfStqKyH8FbWYYPyb0CHNnly4GTSpgXE/cXV3r2CFy1xLU+hgLgA15HjhxqyeC8wv8ww9xDRTyA6y/Qj98mbSOjvM10eORx2s7LaDtyhhKwhDxIFONZrOltlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41bd8bdd065so5417355e9.3;
        Wed, 08 May 2024 00:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154537; x=1715759337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmLhDLEbQWMnT0//LtWrCQUQbiuEglzaZJL+YZYy2Po=;
        b=LLlDwucRz53E/4B7a7OuMT3ADBXX0asqsNBl809xR65QaFagtLItgrvj3iVS0Cnhus
         78F6jBEKSPUFtgvHT6EVRUuoZjUObjPbnId4FpIoLHkJCRnzhrGqbO1ZAv5S8aqJ2fVL
         gLZl16b0JAVid88GfaOGFl64kuKTlywVOGuXGPBrYsBPaT97ld3s0qRU2PLjc3o3AALA
         xSr5HFI8PnkR49UzOM4V1kKERn4Olhipd0fE156eavALV9hj65dRkMFgR91XkIYkUzKW
         B8JLu101oBbUV9U45VqzPrXx4rttKQ6NZMSCMQ2s9D4oi2js5DSbwtDnpJ067WKEIYaA
         78Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVgLCHUJq3DAjn9p5QJbVZxExdne7jkvpGk0egtamXFSBVI5te5YKSsK4BngX4feJaHQSm7+NhZ01Ea75nUQNvq1mqBGTUQt/dkCCniobIyLUC1wzwN1A5Si7dUiG5ZOtShnbbOAfj/EB/w6w76
X-Gm-Message-State: AOJu0YzTkBhuTVuvJKZITOKNIsP5zmhKWorENT28Lqk0zsqJgoZuKXZZ
	+2V82nxtx/fdLdT0cBYs4XPgPCelrLUe2/7qYpSf7rvs/mN3zqms
X-Google-Smtp-Source: AGHT+IG4mhZU+iZGlVuQL/dtlaoa362Ho4dw89FrUrZPN55PAl1v3JqBEC3sfZqmhJqrpcwdBukWJA==
X-Received: by 2002:a5d:4a4f:0:b0:34f:4e00:876f with SMTP id ffacd0b85a97d-34fca8104bfmr1476690f8f.1.1715154537202;
        Wed, 08 May 2024 00:48:57 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id q27-20020adfab1b000000b0034e24be18a1sm14783292wrc.15.2024.05.08.00.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 00:48:56 -0700 (PDT)
Message-ID: <80d7474a-3a94-44a9-8e82-5831f1961ef5@grimberg.me>
Date: Wed, 8 May 2024 10:48:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: prevent sprintf() overflow in
 nvmet_subsys_nsid_exists()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <25e9c58d-d192-4a91-ad40-4c2ea01fbdf5@moroto.mountain>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <25e9c58d-d192-4a91-ad40-4c2ea01fbdf5@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/05/2024 10:43, Dan Carpenter wrote:
> The nsid value is a u32 that comes from nvmet_req_find_ns().  It's
> endian data and we're on an error path and both of those raise red
> flags.  So let's make this safer.
>
> 1) Make the buffer large enough for any u32.
> 2) Remove the unnecessary initialization.
> 3) Use snprintf() instead of sprintf() for even more safety.
> 4) The sprintf() function returns the number of bytes printed, not
>     counting the NUL terminator. It is impossible for the return value to
>     be <= 0 so delete that.
>
> Fixes: 505363957fad ("nvmet: fix nvme status code when namespace is disabled")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

