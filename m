Return-Path: <linux-kernel+bounces-333395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532D497C7EC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18701F25802
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3097F19ABB7;
	Thu, 19 Sep 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAid2qNR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB5168BD
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726741558; cv=none; b=q6T7RANgI3+bqiWw8y2fTID/e+Dhc9vk5C+L4gWkMZ+DoQUkwzPdBpa27abrt0GD0I0FgSTzvHQoY0sSaRnwBOzpZVv5vo7PK2ca9X4sRECrAII5NZ8G5qwzxo9jIGHFKvdcTmqmeJw7Kz33FyFKLLqljIuj9/kDSPLCF7Ydto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726741558; c=relaxed/simple;
	bh=dh5zZ67iZsKWQUM5ux2qEPzByYk5k3zqWIy2lvo59n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhblQiWWnCrHacKRiaN7WMTr4Jw9hb8Sv0NoKKE6Zb+N1IjBfbba8O61eyVnrTyKvhFbsWOKZ/BN2OhZOcl3yZghKon0C2JqLT7DeAtmxf2Sm+VR1huLhW9ZL8QbgaA0EWQyx1T7gRp04akRebMTMTj19qfRMhKRGFGFfewBDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAid2qNR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726741554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU37wya+IdTRVawKsRg1bySPViVfaBomPKDjH3Cb2/o=;
	b=KAid2qNRgXPDw51QaXJEa8IJ0aXMQdUPSsHjsm7xJgB2EQkRg+hWLYCtpi5+Gbq+/TQOro
	hVECKYLlFUz9K+LyElhmU2fD9vP3LmGUykGhPpr2NeT5yWyt9quA3PI+q0aAxjCZJdiYrF
	0gq+D07H42US7UCaTqo1zBrhFYmBo1c=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-pIx0RyICNdC2UzX3HX4oUA-1; Thu, 19 Sep 2024 06:25:53 -0400
X-MC-Unique: pIx0RyICNdC2UzX3HX4oUA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f7593fbcecso5569871fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726741552; x=1727346352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iU37wya+IdTRVawKsRg1bySPViVfaBomPKDjH3Cb2/o=;
        b=EGRTXOQnQ0js0OlRq44LO5Hkg5j+wc7h5Dwb412mS0iD2ZaDgji0klpdQBRmvW6RWs
         4WziQWMugn42BZG+DiBIhdIXqK1a/5jLkgSo/ob+U1uyGTRSMqdl4bumyLgnuqULYI6t
         L2IpnjGE1AiAdRqL7ysVsPRAauuSaJTvbcRRJtAluZ1y7UF/17eL765ruO43HQ2mqI/Z
         ZgtUp3rveFj2NOEcVRdFAXyzmbHpe5Rxxf9dhJrTlGRE3p/0th4Ks7eEHBSR5uV+emz4
         /csROQzYz/Si9H0KQpQkbX7M6nJ1td69i4awckdfDf+JL0uFuLJdyurPyUCj151Flyyv
         NvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiJRDLHxyUMhdjBTD5Lptm/qGcO83W6aTtsUkk8HI7rVfQ/L4nWdhU9/ZJ35bhWIy5ryPUBRy2RlEDJGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRFXlzcyfd0fEtGLL56PqTd3WCryFZinBfOp6qdSyK4BkPUxge
	L+fRtY9LGahHDKUjLLGk4BtvZcOraCCkU8cI4ukg7xmOKrJZRadH0xBADbEVxdflPCqeCOA1UWU
	QwXe9ydgoRSxiM3XES5sfW7n7mSY9HxTF5KY+3Dd+ALNnCR72RkQmYt3CTm8g2w==
X-Received: by 2002:a05:6512:10d0:b0:536:5339:35a6 with SMTP id 2adb3069b0e04-5367ff32b6amr13726382e87.53.1726741551651;
        Thu, 19 Sep 2024 03:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD+DJ5YDiNMnKzQb29hvyFQu3OUsT/R6K216mf/QQcWtGw4xhgMjTdU+zmbzcZtq1IeizPpQ==
X-Received: by 2002:a05:6512:10d0:b0:536:5339:35a6 with SMTP id 2adb3069b0e04-5367ff32b6amr13726362e87.53.1726741551232;
        Thu, 19 Sep 2024 03:25:51 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4375sm704469466b.73.2024.09.19.03.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 03:25:50 -0700 (PDT)
Message-ID: <7bbeed88-5ad1-41c1-a742-8a1737eb7ffa@redhat.com>
Date: Thu, 19 Sep 2024 12:25:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP
 is enabled
To: Furong Xu <0x1207@gmail.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com
References: <20240913110259.1220314-1-0x1207@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240913110259.1220314-1-0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 13:02, Furong Xu wrote:
> When XDP is not enabled, the page which holds the received buffer
> will be recycled once the buffer is copied into SKB by
> skb_copy_to_linear_data(), then the MAC core will never reuse this
> page any longer. Set PP_FLAG_DMA_SYNC_DEV wastes CPU cycles.
> 
> This patch brings up to 9% noticeable performance improvement on
> certain platforms.
> 
> Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
> Signed-off-by: Furong Xu <0x1207@gmail.com>

I'm quite unconvinced that every performance improvement would be 
eligible to be considered a fix.

Reading the code it looks like this change actually addresses a 
regression introduced by the blamed commit, is that correct? If so 
please re-phrase the commit message accordingly.

Thanks,

Paolo


