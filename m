Return-Path: <linux-kernel+bounces-333233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B96697C5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3281F22B23
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8927198E89;
	Thu, 19 Sep 2024 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPtebOXg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B7198A30
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733939; cv=none; b=XsKrW4Pv2SDPVbbxctbjYn3HWlUqQO5ti3KUBFcCFF4wCmM7MqkxmJZqAmX77OGkPh2TFi65UOWh2bIEVY3hBCaNk7FTSVJ0JUZqaXlqUlQGpEaNexDWRN1VVwLwC1Ex2uxzVxS2sCQkLxZEjcZKrBjnfmkLr5rEgNKr0YLihKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733939; c=relaxed/simple;
	bh=2mNjGAlnjEztP3JS7M9VSET/InivqnEVm9LPkwuS37M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFe5IRTV96LEfn7qgzm1HQYwQ9E57E2kq17CS5a9UvTRErlhpI0nGz+w5QYbqVeIQ2eUOt07ehag8TzCKc22ejBHmcRNC+0ywEdxjCHZwIvpEUSJ7C43s4l55gD7XnSdGPvLHUkOwBIcm+sbUjSma6f1BXspQC/JneO1rYGpWOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPtebOXg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726733936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBR7qTS56Xfn6z8tjqtE1OlYjkoY5xhmr1l/L289+go=;
	b=EPtebOXgvRBrLBgJuArdd0KjlIoUGtddpvbfb88QzdpzosDZB3lnMlmS4hkCbGtsylM2Ta
	2Ok/qCFJWMHAr/rB3jELNZ70E79Alk9CgHkxfunQdaXm/Ir2ZcWAUpXOr8tM89BQfSmnXP
	cJXu7F6MNL0+6PXPDsIv4kZ5XPX1wvo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-WXSlro7XNqCy78XG46MgNA-1; Thu, 19 Sep 2024 04:18:55 -0400
X-MC-Unique: WXSlro7XNqCy78XG46MgNA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f75b13c2c5so4018281fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733934; x=1727338734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBR7qTS56Xfn6z8tjqtE1OlYjkoY5xhmr1l/L289+go=;
        b=KyMAxTol7W/7cdv2PSIaTBB9nAHvD8PJdIagcFSzQAI35Sqb25R/qUc4WSH8IisNTl
         9AzQy2KOfXWjVxejIbQVHaF3YBesS79EeI/ZdPOosiRHa9htpapfqv1YsEtxoee+SguB
         jJbXW3Fft7OAuQGLRgwnsxB/Y+uBXuPhcZaCbF0T0RdbwsdTNjVqdToECmpk5zJq5k8e
         HdDGn6+DT558paavuLRJk84vpTSjRCxAkuDo4LC4BFz1epICSNtGoZoRFaemODPwYTsr
         OYhFG6msGdnAIGlo6P9mqYwePqyA5jDSKWBwNE3NtBvLPUAYf17EUl6D3gS7Q0QRPqIY
         ZOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7Xb4rVgHsF+pS7g5QhEWFGZcqK9g5cJ12LEzkY3p+Nhp11oItFw5RFI4R7sYQzW+TBelDkQGIXGEKDCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjBcm23BnQrbuVNGtmK3jNeE0AHbySyp3VoIbA97JQiueKz0o
	VbwlaPGqXwpnqSAQR3a2awv8JSdd+asYegm5Wa+rsSQT2k5hLVXHYXrZYfvl4yHwy0Ju1fA2KVu
	RSlXsefOvQ5IbltF5VpS/xG641ieD9hr55s9t/2ktZ1YgMn2Ztc/wprL4Yf/4Iw==
X-Received: by 2002:a2e:742:0:b0:2f7:4c9d:7a87 with SMTP id 38308e7fff4ca-2f7a4b01295mr61967351fa.21.1726733933782;
        Thu, 19 Sep 2024 01:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2MnzbbCEccaeuHDOdq1z+nha8ZSu64dyW4cRwQEWQve8JMuNOlcPjkPasse7ThPGS6D7L0Q==
X-Received: by 2002:a2e:742:0:b0:2f7:4c9d:7a87 with SMTP id 38308e7fff4ca-2f7a4b01295mr61967161fa.21.1726733933280;
        Thu, 19 Sep 2024 01:18:53 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c5404sm15336915e9.39.2024.09.19.01.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:18:52 -0700 (PDT)
Message-ID: <bc5988ca-4d43-41ce-a5c7-8d4cf67bed71@redhat.com>
Date: Thu, 19 Sep 2024 10:18:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: fec: Restart PPS after link state change
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>
References: <20240916141931.742734-1-csokas.bence@prolan.hu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240916141931.742734-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/24 16:19, Csókás, Bence wrote:
> On link state change, the controller gets reset,
> causing PPS to drop out. Re-enable PPS if it was
> enabled before the controller reset.
> 
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

This and the next patch look like a bugfix, as such they should target 
the 'net' tree:

https://elixir.bootlin.com/linux/v6.11/source/Documentation/process/maintainer-netdev.rst#L64

and you should include suitable fixes tag in each of them.

Thanks,

Paolo


