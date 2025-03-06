Return-Path: <linux-kernel+bounces-548666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF177A547D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472AB188AE42
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B66B201034;
	Thu,  6 Mar 2025 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eH9m5ZV/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABE18A6B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257160; cv=none; b=uXbwO4MCHrzQZVt/AXBqCs8V4TpSmvh68V6BXntQIHQTqJxelKWWoGIYGKWBx/hWfkB4MH5aAY8YiEv8Al91sCmIp+aBNxWWcKecT7zGrdY0Ld34DYefyF1J6rnXZtkjIaMZVPX8GTH7LA4sJg9+sA9aFIDGm+Qplp4pIgd1Za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257160; c=relaxed/simple;
	bh=IGVAuJkuiiv0B8e7SlGUhgx4yCx9vKQqqr7RUi5IhrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4/8K5rSrEfFyj1EFRO8Fezq8+osIKRrZAF/KDxGmAURad4vgpm1WSpRgUO33WOTWPgZzfFweNtY1hHJUTi2AVU5S25Uku8QaRB8atB4K6AwnZIMHKzgRTkjiwGQAFBzzpLuvBEh9NctytIRWCAjlHe1SW133LgVrNvkd6wJNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eH9m5ZV/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741257156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMqW1t44N97ihf+A97Lk88vZ7a/tf/Mv4rMOKlQe5oc=;
	b=eH9m5ZV/e21mWYUU1cSCyOfdZNAoGhc6aUbTi+lIALLyPSIA7GzAV+PAGccXYbaC506ia7
	JW2QMwuRW87roaeEUIAFoI9MKL+Yc/1iOmNha/I370Jxz9UrgkcA46Nf20xSwZ1Ovi7n4Z
	H3RrfhecQXCBPap94xG0nZAz0g9YSiI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-ECkjq6kIOOq8Ut2c4CtVLw-1; Thu, 06 Mar 2025 05:32:17 -0500
X-MC-Unique: ECkjq6kIOOq8Ut2c4CtVLw-1
X-Mimecast-MFC-AGG-ID: ECkjq6kIOOq8Ut2c4CtVLw_1741257135
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so2118855e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257134; x=1741861934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMqW1t44N97ihf+A97Lk88vZ7a/tf/Mv4rMOKlQe5oc=;
        b=VDEcQYxv8WOaR3KTMldN8eyINeZWNREVqUbOBuFrA/9PkMdjXsrTqOksptk/lJo8QR
         nzTfE9l8FjsIiEVfi82X4abdM6+sMeJUlk7rFyiJpgW59Kd+LFvGGTQizQd/df6dWVRX
         QyfGxoNgif8wo6QmMsQyvWCkwCyYirgCXlUG85915JV5lepFsNFbnB4jGUNRQZbRWIci
         KgEBH6QVVVs1frpPh7xCl6rya2p455AkaJTdAL8a1wpAtg0qzwOJiU6bSRkHFX8B0xo5
         xXsr3ROv4l6OsDlsbvE5ZtluhI6CsEItKyheVRpvfpT+efOVau9qSdIzM1Qn6Vnfacuq
         EyHw==
X-Forwarded-Encrypted: i=1; AJvYcCWO4fdNlYV6ujVjGDCnSRLpJcvTD+TsgqIkyUa6X6T6udJqA0SSQMWHPxk+MBfTH7+4q+F2nSgXb6gBlgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqqFc9WZ8aO5WDf/9GepVjbMm1jaJUaPyf0sz5/YrHnTDv8Gd
	vVoLxpuxUgkPuFy072PeNLskYjQLvjHMNndWiFIfVV3Iw3joNuemBb3VSCSS7cMgdlnUikXaAAk
	7tRR3aDKE/q+R/V9QkRY1vqgfgWCobno4i816hFprSn4f7Stbxqp4/4BAx35Rag==
X-Gm-Gg: ASbGncuH4TKFGiBj2lPNr87v7N3N9wR3EG8V0356+ZyRfMt+Gk+mCSCmqFA9PoqmXRv
	RKC6wqWDpyow8sXBgX5HuJda06RMV7uU8NvqsBHLzHn3sKGWjdFpRqsCcpBTsoGeI/iaJmINdL/
	TVPLq8nBAVRqea4WzODVBKA6SBg33I61yWdf8IsC1YF0QCA0hdRXk873NWfHL91Bt4Ee+7davrT
	vptKZidgIkWo2yVicxpz0Jm+VJmrKZ721K7eFEJwx64PwTw0QudlZmnH2ix01eg66SxdiBzTD8I
	H+Y1sCFCJox5w9yNOOLp68G94GoAPKQdu6mw4GAgM1b1wQ==
X-Received: by 2002:a05:600c:4e8d:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-43bd28a73f2mr56130325e9.0.1741257133325;
        Thu, 06 Mar 2025 02:32:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjneL1v6mm7CN1Ta5I26BcghZEUJFnb1sJCU6KoCgTgUbp+nI7Nhqiox0FcMr5Gc2xWIH6mA==
X-Received: by 2002:a05:600c:4e8d:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-43bd28a73f2mr56128875e9.0.1741257130527;
        Thu, 06 Mar 2025 02:32:10 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba888sm1639761f8f.16.2025.03.06.02.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:32:10 -0800 (PST)
Message-ID: <8ec75d7c-0fcf-4f7f-9505-31ec3dae4bdd@redhat.com>
Date: Thu, 6 Mar 2025 11:32:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qlcnic: fix a memory leak in
 qlcnic_sriov_set_guest_vlan_mode()
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 rajesh.borundia@qlogic.com, sucheta.chakraborty@qlogic.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250305100950.4001113-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250305100950.4001113-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 11:09 AM, Haoxiang Li wrote:
> Add qlcnic_sriov_free_vlans() to free the memory allocated by
> qlcnic_sriov_alloc_vlans() if qlcnic_sriov_alloc_vlans() fails
> or "sriov->allowed_vlans" fails to be allocated.
> 
> Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Add qlcnic_sriov_free_vlans() if qlcnic_sriov_alloc_vlans() fails.
> - Modify the patch description.
> vf_info was allocated by kcalloc, no need to do more checks cause
> kfree(NULL) is safe. Thanks, Paolo! 
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
> index f9dd50152b1e..0dd9d7cb1de9 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
> @@ -446,16 +446,20 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
>  		 sriov->num_allowed_vlans);
>  
>  	ret = qlcnic_sriov_alloc_vlans(adapter);
> -	if (ret)
> +	if (ret) {
> +		qlcnic_sriov_free_vlans(adapter);

I'm sorry for the lack of clarity in my previous reply. I think it would
be better to do this cleanup inside qlcnic_sriov_alloc_vlans(), so that
on error it returns with no vlan allocated.

There is another caller of qlcnic_sriov_alloc_vlans() which AFAICS still
leak memory on error. Handling the deallocation in
qlcnic_sriov_alloc_vlans() will address even that caller.

Thanks,

Paolo


