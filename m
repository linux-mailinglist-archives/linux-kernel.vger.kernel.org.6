Return-Path: <linux-kernel+bounces-544027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC3A4DC93
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA44188A044
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D611FF7C3;
	Tue,  4 Mar 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHi3r0aS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C41FF5F9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087726; cv=none; b=o3uyvl02zpqn/4md43RrSWMz2IRxjZ0ifTIbr3JiFYXvTAuMBsrPTlX+U9m1LUo0aT9czFYbJR5GdjTDwI2sXnk8WTbbwAb6UftcTVcaFP76bFXhCPuU7/qh3nvxE+X0wrKmMjteNLJnivmqk4QJT6TPk5yxeS94WYaCkxjOhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087726; c=relaxed/simple;
	bh=KnUdtItjGNYgdCcN9y5Rg4Cul1YLre/02YFHO8L2ZVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdK4GIVu7VOxgz1c5NoAv6fPIRpzNnIRIWMj40snvKr39e6oPXILA2AHX9tXwGGlslzUgcMF9ajIqycdPZZlcYDeplJTB+wV+Ijukuc886x0tC6aKtXDb3yPKDhx7yuJL7wlqHvdXp1/uDy0DK2V+5QoQ0nudNZ4Fg/LoYqifow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHi3r0aS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741087724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eh0+rygjvEWvFpambZXtqMxwPMY88Yx0JvlayLr7tDE=;
	b=XHi3r0aSKl+qT2debhqZ2hgu0pCHclxbvnUzrDUdRO0EJ9T1Uz1jr/3ZyIR8wFhV/Awvtt
	957YQ7eZH1Ffq5tYSMT9VabWlS+6Xhq+dN+L6dohuJgGrrsDSgUDnAGQSWtwSg2VJnLcg/
	TmCrA+5tktHWFv6yldUb3ArVGvRQpXg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-jh6gVdkzMXaZEAdONGpXog-1; Tue, 04 Mar 2025 06:28:33 -0500
X-MC-Unique: jh6gVdkzMXaZEAdONGpXog-1
X-Mimecast-MFC-AGG-ID: jh6gVdkzMXaZEAdONGpXog_1741087712
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bc1aa0673so9729475e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741087712; x=1741692512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh0+rygjvEWvFpambZXtqMxwPMY88Yx0JvlayLr7tDE=;
        b=EIO7v8UJcoSDD5XhFNNa52YBhfRm8m/UCVdiK85vKS4Xde8OMAfIlsA5qXEBKmm5lo
         0kDuWxT2xILGH0O6SwKoIrBEQ5rNZKPYdC+uEOU/+PsRWhP+o6C+H0ewDFpZZtyya3G7
         YEC3AgPUoekgJcgWNPYx6bO9iVCUAFbCYwk+kWIvRfGFnZy03C5rM+p3vZCrYjp7etD7
         j4K57qc6nKJ1QeTq8p7pZwymRYP9HzcQC15n0iUIHVxnDq/DkpFQSwQmrKQ+CGw2xxra
         fVcqGwmstq9ZHmOXJzVw0lBn4v3+KEEvbfRJ+b0FJhbZC08i/JuINe6TAHfMHe2X+tbU
         UlEA==
X-Forwarded-Encrypted: i=1; AJvYcCUai2cGG0dujcBz8f4g+0Q6dyf5+114q0Smg7LsFM5r1NMKGx+DWB1SFM9XmRz7bgIbSLR51QT0VAt4bto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlITEsrIJQxNXz7BK/HkxNyP1kBa8zsd1peYi6wrOEUw/Grll
	AONZjm27nAQgLYV5ek13T+uoOjdIslZYG04yXG++RIriL3x/AWnLJvJg/agxB0sYns3QVoyVmVg
	NlK6p4X6M25hYmC9c/COdtvLUt8wqVi98G+j1Mhh0MFvIeceA3sDbwEY87PCKmg==
X-Gm-Gg: ASbGncuztZP1d2GOP2iWgus5cIRtJJ2p+oxC0rq71Nggw+H141sZ85PQSDY8kV9Z027
	nDOKAqO3lsPvZ0P83Xxqj3C8/266QbaGziUOWkmLr35mfPY34NTGj1OYyZuxOOixEuAvSWuxgWx
	h053Xmt0XKG/VosY9XyQR4ph6V7BJ5MYrX3JGWEFi89GSiW7dxStgI7mqH12Pb5eqw0jq3MigjU
	K6DULgtRZeNSL5fp47iL/Tx5h7rRW6CNjkFv+yb4+HLLj+7wkRyy63gm6iSqmkugGXRG82dAXYL
	mszzosurAWOr1+Mld9uJoH1FOE5oPXbWRBUv0As4DfiNwA==
X-Received: by 2002:a5d:5f89:0:b0:390:f698:691c with SMTP id ffacd0b85a97d-390f698696emr15424447f8f.43.1741087711875;
        Tue, 04 Mar 2025 03:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqZ/TRGcqVpyJ16gAgzdOfvndPozt1EifipipyO5TrSqSLkUzB4NwQLxlVOUb/6RXZ9PIEUQ==
X-Received: by 2002:a5d:5f89:0:b0:390:f698:691c with SMTP id ffacd0b85a97d-390f698696emr15424428f8f.43.1741087711524;
        Tue, 04 Mar 2025 03:28:31 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm231184535e9.26.2025.03.04.03.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 03:28:31 -0800 (PST)
Message-ID: <63e68624-3672-4473-be15-ce04eb3cd2ed@redhat.com>
Date: Tue, 4 Mar 2025 12:28:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qlcnic: fix a memory leak in
 qlcnic_sriov_set_guest_vlan_mode()
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 rajesh.borundia@qlogic.com, sucheta.chakraborty@qlogic.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250228092449.3759573-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250228092449.3759573-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/28/25 10:24 AM, Haoxiang Li wrote:
> Add qlcnic_sriov_free_vlans() to free the memory allocated by
> qlcnic_sriov_alloc_vlans() if "sriov->allowed_vlans" fails to
> be allocated.
> 
> Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

AFAICS the fix is not complete: sriov vlans could still be leaked when
qlcnic_sriov_alloc_vlans() fails on any VF with id > 0.

Please handle even such scenario.

Thanks!

Paolo


