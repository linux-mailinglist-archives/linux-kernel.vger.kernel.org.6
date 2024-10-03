Return-Path: <linux-kernel+bounces-348842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CBB98EC7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98B4280ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39B21494CA;
	Thu,  3 Oct 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgsWC5JW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A35148314
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949051; cv=none; b=Kv2luYMmwDJJVTUuvU3RrbtYwKN7+qlrn5k+2Jmmp6i71IwYrYFqdiGPHQsCzxLsK6JSGsEV4dDJ90Q4Ww2cg37E0wqqZXm0YIaD71bYIhzi0sPTJM+/2iqqsjlUnnwfFXqxGOI/X0cU2/uX8okhIm5iDppdk9itbSN4GBgIq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949051; c=relaxed/simple;
	bh=LnLn3TXq7HUeThgKc9tyAyYeYfpK3xWdJiN3uL7GNGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESYFYsDh+0ot5vfxnb1oX8nDaC6O8LnPTpagQ7uvE9qEZpJwWHffM9cLX70phzc9ix7fDGseHJO1+lo0NTjwVjcRwtQjCUc6CZ97R6U+kDIAa2zp5wdXRN3xCh0xFCbxpqgDJpcuDWznrzsqoODPD+mqUQ3rh6A1DrBGswtUw8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgsWC5JW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727949048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/RuQVfSp4B/jhWvYNQEIFzwdmMTh0ClVMBMD7H3uxA=;
	b=HgsWC5JW6T2TL2TJjrYOO9IJSD1FFgjUoa5bd5LA3KBgBBzsQMf6Sp8XWEAxRSccMQF4qS
	XoeIEI1IKyj1k7g4DMm3s2AC0yW+0zS067hWh+LZ5wOBP6OWXzr0y8fb71dEsA45mQrumh
	Mk2sPVu2bW1m53BZtFm7JxGjwJC76iE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-SPOmIIh0NHOVAuJNdZ_gng-1; Thu, 03 Oct 2024 05:50:45 -0400
X-MC-Unique: SPOmIIh0NHOVAuJNdZ_gng-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso6124115e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 02:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949044; x=1728553844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/RuQVfSp4B/jhWvYNQEIFzwdmMTh0ClVMBMD7H3uxA=;
        b=YEsYtdZmh+BPCg//ujuEWHzFVdEo6Sp65wrDeFPLsyIHDHk4de3rSVvVmr7Xa2dwBa
         4KK4ikkZMvwviU7GhLIkikSpZ4X8MvwlJ0pRtCQrAIx6ny/HiZMfuEd/85XF2NqzKxTC
         0wLGMZfHDiLQcuVNUIZF8Q4dYGr2YFbk3bYAUyae387NiauuNSOUoRlC69Nr6QFtOgoW
         ZT723iXE7CSDWmHE5m8WxcPldE2rt8tkQD+smrMEEDlLCjC9+vSq0vZzBnLVNCQSm01y
         EEpeEhQFZlPaPBTiF4iarDNmYkWnt3EfPW7kNICKwlypjZhj9U7yOinvyVvQnEWR0rw1
         UHIw==
X-Forwarded-Encrypted: i=1; AJvYcCXzZYdgVDgZVYivEAtWlSecId8vUEf7O9g0BdlwilRQ5M6LGoGyn3uh16QyZ6NkOcZbYQtbehia2UxRRD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX05y8N47ptPbZ5NJodYT0OMovZ0nsbPl0XVkVCSCmAxWaUr7f
	V9YK60/qHXzDLCIClnDYtTy+e2JksXRUQ07s4fv4tohWRZTManC1tNi1K3AIfz7gqT+glXgmjju
	h99N//3LTnjsYjNVH0dZp/Hrj+OLmn8tOP5I6P6ckGwlVhS2c71c3wATCVe5HJA==
X-Received: by 2002:a05:600c:ccf:b0:42c:c401:6d6f with SMTP id 5b1f17b1804b1-42f777c3179mr62631815e9.16.1727949044345;
        Thu, 03 Oct 2024 02:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9Rb4vcbokhJiJ3XMyfAYK8mwmSDCGAb/etwlWLB9WeYZgxjagPgRTCmkzmXfKn1c9Rrjnmw==
X-Received: by 2002:a05:600c:ccf:b0:42c:c401:6d6f with SMTP id 5b1f17b1804b1-42f777c3179mr62631625e9.16.1727949043967;
        Thu, 03 Oct 2024 02:50:43 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082e6f35sm886502f8f.113.2024.10.03.02.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 02:50:43 -0700 (PDT)
Message-ID: <79a8e6f0-ff81-4b12-bfb8-f615069b1faa@redhat.com>
Date: Thu, 3 Oct 2024 11:50:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] octeon_ep: Add SKB allocation failures handling in
 __octep_oq_process_rx()
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Veerasenareddy Burru <vburru@marvell.com>
Cc: Sathesh Edara <sedara@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Abhijit Ayarekar <aayarekar@marvell.com>,
 Satananda Burla <sburla@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Simon Horman <horms@kernel.org>
References: <20240930053328.9618-1-amishin@t-argos.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240930053328.9618-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 07:33, Aleksandr Mishin wrote:
> build_skb() returns NULL in case of a memory allocation failure so handle
> it inside __octep_oq_process_rx() to avoid NULL pointer dereference.
> 
> __octep_oq_process_rx() is called during NAPI polling by the driver. If
> skb allocation fails, keep on pulling packets out of the Rx DMA queue: we
> shouldn't break the polling immediately and thus falsely indicate to the
> octep_napi_poll() that the Rx pressure is going down. As there is no
> associated skb in this case, don't process the packets and don't push them
> up the network stack - they are skipped.
> 
> The common code with skb and some index manipulations is extracted to make
> the fix more readable and avoid code duplication. Also helper function is
> implemented to unmmap/flush all the fragment buffers used by the dropped
> packet. 'alloc_failures' counter is incremented to mark the skb allocation
> error in driver statistics.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> A similar situation is present in the __octep_vf_oq_process_rx() of the
> Octeon VF driver. First we want to try the fix on __octep_oq_process_rx().
> 
> Compile tested only.

@Marvel folks: it would be great if you could test this patch and report 
here, otherwise this is going to be merged with build test only...

Thanks,

Paolo


