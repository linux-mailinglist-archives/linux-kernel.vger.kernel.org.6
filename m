Return-Path: <linux-kernel+bounces-548679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2CA547E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F070B170C2C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C101F63E1;
	Thu,  6 Mar 2025 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RddjQ8eS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD771A76BC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257402; cv=none; b=ahp8ZAwTpUDxC5CvEYbwzBeyk9cCEuRACAmGjv/SOr8lBhgXejYygiN2spSDzQ2ibG10ruk8uZJr4hliPODluBOLKv3wf32qsVpq0Ua9XFg0CEuyWv3brBwY4dSH0hYSWUUgi6GpV588Si1YWpiyR//XCWclJVa51V4h8XbSR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257402; c=relaxed/simple;
	bh=eIviFgFwPx2HwSUMq5kkwtsNyVo5QezffE+/FRZmj/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZRpwKmGRk/169l+lnmBrVcwpsmZakfIDToJKSeh5fX8gZeWLLkdyB/Xvt5Mr8zi9jEMQIfKO6b91rSFu1U+9VKMt81n8ss2ET8q/OfTKFjn++k9K56moHR29CvXw/di8vuXHEZofy0oRVjtpCcUkuD80obEVTHTTLZr1WCvQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RddjQ8eS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741257399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnglbAYEIKKaWGbc5/Ze6UFS6cRYwDkRCxuVuAD5S7Q=;
	b=RddjQ8eSVs7JuMUGuaPulc0h5IdDOf0daNyK7Sx+6837SIdBjGBYq0IPm98Zj2y2Upt32u
	YZL9YV2m6MRqLw1F5G+ujtqnNA1USCfrWPitOOCTH24Bb+mrisUOE4v0UTkV2LUpClTZe+
	vIITf6dT4KNOnd1V3nE6ab5CVihrTq8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-t3jiLCL0PgaxlBsLVMT97A-1; Thu, 06 Mar 2025 05:36:38 -0500
X-MC-Unique: t3jiLCL0PgaxlBsLVMT97A-1
X-Mimecast-MFC-AGG-ID: t3jiLCL0PgaxlBsLVMT97A_1741257397
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fc9861cso48043f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257397; x=1741862197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnglbAYEIKKaWGbc5/Ze6UFS6cRYwDkRCxuVuAD5S7Q=;
        b=CxxQubLxbDYmxglJ7i2tBkNglvxlb3A8cjom5xf6E3Wuq2KHoRvZlxYEQhZFygNghd
         keKgsMCLcGb4ameC6edcQv+6wzK2YVrCSGHcustjR4Mwqp97bEHFL+yXDS027ZhiPFpd
         QYHbKNSU/NcdYM1FKRRQghq0afp/aLMsYB8FFUJ8IBT7/fA48kZM/SoAc6oBta9U/8d9
         wgnHndOxNBr6AZ+9YU1YVoF/ASUfpsWpsOxQ5c9QJc62d5AUdYe9SWIhCxGih/JviUs3
         mlfWP9VK6MNdzQ8duSkV/GaPNOQk0XhII0MvM2ibuMP6AJerlt49BHdA2uXcie11pOQx
         a5lA==
X-Forwarded-Encrypted: i=1; AJvYcCU9taYordOlS37wwbEhzSRPOSxMlq/fZ5TZWO8KFTYcZOeq5AdWZOJGfTLOaYmQruOEcqjjHhA9FIvVU1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CqEAmjwdr645onb86/Cpq3bYd4NjEDYDFBLZVuovrfFxwJ0i
	4kWWlJ834eC/0+cQ99NJLASvAj/gb3DwuuKwZFy2SiY4rnRNL0WfKN7kJjZ/KjJfPdKleAXq2Al
	YGnJtJio+10FO+BoT3HRcqg7lK986q7sSRPrlfOzDOuXphd2c3Vq6Qku4Ym6vNA==
X-Gm-Gg: ASbGncuTRhyILqbCOaOc/HiYXhDs8sPPV2fbOp1TwKf+X5wQI+BbiXSZxNRFsAT9uqj
	6Sqi+VMbMci0KEDgNFM8CSaiNMNwCMuLKny9OGMPBjR60MZtJLMp7Lf84sV4RV7lsWiNYL5okyw
	NkL7gWmkiAWOX085le5fQdhQcWjPipGtbwdvQ3p8tgb0oywbFVr/NYNtvNmLMFj9mIRitzf0urO
	/715qarxgXc0BAzR3jKJ6I19I2fkUsJgoqYWorHaYpIoNkva4YXgykEhO2/xBCTbhHFpCFUIeag
	Y2dHNxzifseSUOfRSekaLVN1TlWGeE0qGT1juL02TpU11g==
X-Received: by 2002:a5d:47cd:0:b0:38f:260f:b319 with SMTP id ffacd0b85a97d-3911f7bd90bmr6778425f8f.44.1741257396878;
        Thu, 06 Mar 2025 02:36:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxqUdlV1rQR47fVsjY5mR2qgd1ZZUfY4cR3vuzXwjWACsfsXX/46BAzCY25BIGbrKimMUnRg==
X-Received: by 2002:a5d:47cd:0:b0:38f:260f:b319 with SMTP id ffacd0b85a97d-3911f7bd90bmr6778406f8f.44.1741257396568;
        Thu, 06 Mar 2025 02:36:36 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba66esm1658819f8f.18.2025.03.06.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:36:36 -0800 (PST)
Message-ID: <7e4122c2-0c0b-4d55-a3aa-e4c15e28c5d5@redhat.com>
Date: Thu, 6 Mar 2025 11:36:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qlcnic: fix a memory leak in __qlcnic_pci_sriov_enable()
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 jiasheng@iscas.ac.cn
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250305101831.4003106-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250305101831.4003106-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 11:18 AM, Haoxiang Li wrote:
> Add qlcnic_sriov_free_vlans() to free the memory allocated by
> qlcnic_sriov_alloc_vlans() if qlcnic_sriov_alloc_vlans() fails.
> 
> Fixes: 60ec7fcfe768 ("qlcnic: potential dereference null pointer of rx_queue->page_ring")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

I think we are better off addressing the problem in
qlcnic_sriov_alloc_vlans(), so that eventual future callers of such
fuction will not need special handling.

Thanks,

Paolo


