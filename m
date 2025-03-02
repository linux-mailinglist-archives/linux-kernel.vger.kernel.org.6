Return-Path: <linux-kernel+bounces-540822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A36A4B585
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 00:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B531890665
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDE11EEA5E;
	Sun,  2 Mar 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxDJ+Q9Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408A1EE7D6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740958801; cv=none; b=oWNOoTrOqkVYyUvzbtz7+C2drZ8FtpNtcgoaH8oZqv2Jwpf8uZoKZ0CMDHbkyoQsNn4LUfEJVHWDk2d8zXKuUPHTpaGSJHWqQdNLIB2YTW7Pme5m2hrFDOTEwOnolajJhnVQ36Ski88HJ6Q+97zPGG1wZ37bTEeuud/ImYPFiMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740958801; c=relaxed/simple;
	bh=D9aHcBSNUOKIFyFQgdytxMHadQ9miqe4zl49cgpQmPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6pCbDl09fD49oFT3jn2ADSTb9OSACs3Nf3hk42mMQakW3XUjCouav6qQlb1V0s6oqLrturlC4r19usPKzPodmZ5pz8D03zvOxUt2D2Gum4FILqKmmM8HcEa6jd/xz19xwMqa8JOQh+Db0v4CStkIeYWYaCVecmAx7HbU6PMJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxDJ+Q9Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740958798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBo5+OYmEobg6wfjqU2wwAFpXo5iLmkJqiW1kfdikek=;
	b=AxDJ+Q9ZSGt3nlW/HDizDu5F8cw3DTYNQFmVjnnwSqTTWFFw71JJxmW1FPM8sBBiaCDVzu
	dpYZOgqQwXUU1moQyO6zttaV4OCbdbrcyNEsKuYHsBlpiOiJ2g1+rydyUbPbHzz1rJIJe6
	c2c15tnIH6jTq9JJE03Uw8r6c+8pbmk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-ouUOoKoXNKKPhTcfDYa-Bw-1; Sun, 02 Mar 2025 18:39:52 -0500
X-MC-Unique: ouUOoKoXNKKPhTcfDYa-Bw-1
X-Mimecast-MFC-AGG-ID: ouUOoKoXNKKPhTcfDYa-Bw_1740958792
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2234c09241fso113975615ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 15:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740958792; x=1741563592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBo5+OYmEobg6wfjqU2wwAFpXo5iLmkJqiW1kfdikek=;
        b=DUgUA08p/Suqjbu+TExUX9nLBcTbKw0Sp3X7UnNYmpyG9wE37PFct8qmEVy4/WOjUE
         diHj+52yWFpa9sOEf5WVdKniKqlldk7A+AJZsGC3OsfIQV2mopoPN8z9zGRLT4QXD5AE
         41+/F4hCSLEjpZV2nuueULH5l3dGh+i7RlSfOkTER0a1Tl7/kfJlsgofZ+uYWDkzvMJN
         tCxQH564K5AxJpJ+plLI1Ve+q1F4zmoLCe9K2XL6L7O/h9LM2KnksHyyzTMTQU7hMJhV
         KUXfpj7FU0zKulMy1hwIZpZIhwyWzTxdLzrHykUJkMjPMuFwBvQe3nXc5t3J5w/BW8Lw
         SZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVME4ShUSQw6Orhij4HpvbyUaMofs7y/NTlkyxBWIuz+tSQLJCY6Sct73N1GQ78SUHz5NNbSvBDB1DJ4m0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2YJudg8hUP4yQLsTz0+dNGtp25OA8YwD4jF/EMYPuOmDJAVGM
	qPEvyi8DD8eiQoSnyjMikbAQnupOQb8q6hHxFAkLaPL1RNqt0mfqyx422RVwTxQKIM1jfJ15wz4
	sq5qLWzbLyEem0f+R77DllzHzAwG5/qSPCF+sWAiTpgnA2gJj0cLpKi/xhRQ0XA==
X-Gm-Gg: ASbGncs1dEXuNelRiHWzRmIAZg42nLPa1KeaXZT75mjjtfq2++UAPblhWs/YeCDaPn2
	xfJYQtJcf6/0OFi9EeKkYELT3nXdlDazZYhptiuNRWzpaccrfrFxci5Ig+M9zooo5nFPYsZOVAz
	cbS72+6vxn3S5dI295IywvsCAyJM7zB0sLlRpzdsT+mMgbbxMiZpEjpedtSLFKawbdlwUiMzewr
	v8kdnnHtS0fTCYQrKNIHkCDObdptzm0y/paTOXKK/b2A0DVdHAWaZl59u7Mn8ZhQJ8pdh5CACdz
	m3JWKeduEAjteH6l0g==
X-Received: by 2002:a17:903:32c8:b0:220:be86:a421 with SMTP id d9443c01a7336-22369258505mr198701885ad.38.1740958791834;
        Sun, 02 Mar 2025 15:39:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtWQhLEYN86O3XnJuZetDZhwrb65+Q6vvyxqpw4uBVTdAA/3YJ21/tM+WdLRJLHGH6Np0Auw==
X-Received: by 2002:a17:903:32c8:b0:220:be86:a421 with SMTP id d9443c01a7336-22369258505mr198701625ad.38.1740958791506;
        Sun, 02 Mar 2025 15:39:51 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d26acsm66078035ad.9.2025.03.02.15.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 15:39:50 -0800 (PST)
Message-ID: <a7077902-4286-4b3d-913a-20083ff260f4@redhat.com>
Date: Mon, 3 Mar 2025 09:39:43 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/45] kvm: arm64: Include kvm_emulate.h in
 kvm/arm_psci.h
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-3-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-3-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/14/25 2:13 AM, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Fix a potential build error (like below, when asm/kvm_emulate.h gets
> included after the kvm/arm_psci.h) by including the missing header file
> in kvm/arm_psci.h:
> 
> ./include/kvm/arm_psci.h: In function ‘kvm_psci_version’:
> ./include/kvm/arm_psci.h:29:13: error: implicit declaration of function
>     ‘vcpu_has_feature’; did you mean ‘cpu_have_feature’? [-Werror=implicit-function-declaration]
>     29 |         if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_PSCI_0_2)) {
> 	         |             ^~~~~~~~~~~~~~~~
> 			       |             cpu_have_feature
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   include/kvm/arm_psci.h | 2 ++
>   1 file changed, 2 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


