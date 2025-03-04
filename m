Return-Path: <linux-kernel+bounces-545806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2A3A4F1BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12EF97A4E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A73255250;
	Tue,  4 Mar 2025 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLlzSB8r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D9BA2D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132015; cv=none; b=WPgiVfclV75xttsOdzD6n6Kcn9Srq4AKZAD6/omujRqA76uBWXznjtPwrDPck5fJci8V859r1i9HDma0X8V1bJ8u68SWGALCOS0lNGjpjwXW/QDhpcc1qcZ6lMv2ML14VtHiRT+7hx1ZtVZ/qKQ6alhyJP25m+T0DXmVR0pW0co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132015; c=relaxed/simple;
	bh=0vaMK1EzqAclihJeDZxRkFMmTm4waXR3LR9AN19QWDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvKpkEnZrxW73OGe+UZeXgR0NSgh3cSh/PRPVN0NxwsaGDp29xvZMAACwfFDSpAEcYE690KhO7uTJ6GV66uX9DefWt70cWV2HOO2SbPbWjk+1gJLuDv4unwWGLIOHiX/BMx0F/z/+u9g1+HblOS5HHUv2LcOKptncPmbTJKTu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLlzSB8r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741132013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6FYqCr6QwRqz7j744DqHTGMlLhF5qSIjaDfjqoangk=;
	b=QLlzSB8rgXR0/UpCMdkAimuZLuVx1q8B8dAu5zp/zvV6xHXNQl9CNGjQtNOJROJQKDop/s
	hUBL89VP5hS+nNBt+zY0aa8Wmf94sXOcz0W4bJFOLIH5GVLr7Vrkcua6ih13LIIUoF6UBy
	tgpnfeoa+v18rzNPQ69R2UhxcK7Td38=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-fVymJ7OePMyTMB8zSzZBZg-1; Tue, 04 Mar 2025 18:46:42 -0500
X-MC-Unique: fVymJ7OePMyTMB8zSzZBZg-1
X-Mimecast-MFC-AGG-ID: fVymJ7OePMyTMB8zSzZBZg_1741132001
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22339923628so4268875ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 15:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741132001; x=1741736801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6FYqCr6QwRqz7j744DqHTGMlLhF5qSIjaDfjqoangk=;
        b=FVigki6eY8epc5q8U1b/+8A1oJSlkANOnVsBfGVNFuSmJnI2dgcbEZ4wJ/xqBwd/v7
         B1ysx1ChC0QHOKsEJey/FPKupsNND39+TJ3luaXvcPbqimJFL/KfAteG1ip8+L+K6OVr
         USFWA3RHugTQgGiKzBT44z7Mk+FEXCPrVLwPHXGrRcOlwgYLouU5hz6XBJ9jVE3/g4LK
         DnuWFWxJ1E7jwnP8ZihiJolD84xQTwZuSyk88zUXEOrgUFtWz3YBVIbQqHelfmx1LGR1
         MAK3+giP0dFQtYfY6/RameDvC/xg3EqoktGKgEkZENcg5UVKxwsOpJMhHVYNicCmOuFw
         iLsg==
X-Forwarded-Encrypted: i=1; AJvYcCV89IRUuyZPxySK2g47lEM/GsmDqlFHgqIyGUPiX1aKN/kH3ufmCvkqS3BVNiHI1YYWNflF/w6JamJIyuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUMt+it5F9xfD7eqVq0ruV5EWD3YaLJPsgx6ySkRTvNkfdx9Y
	Ffyw0lUepnX1vup5xzThc2V+ruoxiBavdy576TloUxb1XpSUVkRdpYnZEesJx2C+G9uVZ8odD1S
	hZcLLgamaKrBHsNQOnA+4maJmQOaq3Bt7C5Tkap/oZlZD/cyUL7uWPSp3/Qfxuw==
X-Gm-Gg: ASbGncuj3s3T95EKX72d1C67lKy5FsZK5tC82kordRELUFBX06WOUAA2x6tvmbTOG5k
	WgZrOWRaIktGzNDv4dKHo2KbTsvnaFsGMyZO4SLOyLIwrL5oE2KOvToeTR0LhV+kW2qb+mUzMzx
	0N/gBc7xS8293jDu7EIXu96JJ8w/SYVk2wmKqRT4ciAH0/z9BzW/+ODB2wuqOnw8haxUlf39epi
	AEKbvDI46Sekq34+phLiK8qBfD9RIWdi2xfLxk7stGSE/h9Cp7Xw/2DdMH6qvbjh2oFORTZFJps
	8qPerkgnvs7ANG8=
X-Received: by 2002:a05:6a00:139c:b0:730:9637:b2ff with SMTP id d2e1a72fcca58-73681ea12f8mr1622607b3a.7.1741132001110;
        Tue, 04 Mar 2025 15:46:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi8JMyb0mWMUpD1PTtuv+YTTWcm/STeWKBdnRr6BiZi8G3Jvspyz2BgiTf4N+sfAjC+o/22Q==
X-Received: by 2002:a05:6a00:139c:b0:730:9637:b2ff with SMTP id d2e1a72fcca58-73681ea12f8mr1622559b3a.7.1741132000737;
        Tue, 04 Mar 2025 15:46:40 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363f2e8a34sm6324254b3a.168.2025.03.04.15.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 15:46:40 -0800 (PST)
Message-ID: <f331382f-5747-4837-ae60-42e9cb37ecd4@redhat.com>
Date: Wed, 5 Mar 2025 09:46:31 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 36/45] arm64: RME: Set breakpoint parameters through
 SET_ONE_REG
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-37-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-37-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Allow userspace to configure the number of breakpoints and watchpoints
> of a Realm VM through KVM_SET_ONE_REG ID_AA64DFR0_EL1.
> 
> The KVM sys_reg handler checks the user value against the maximum value
> given by RMM (arm64_check_features() gets it from the
> read_sanitised_id_aa64dfr0_el1() reset handler).
> 
> Userspace discovers that it can write these fields by issuing a
> KVM_ARM_GET_REG_WRITABLE_MASKS ioctl.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   arch/arm64/kvm/guest.c    |  2 ++
>   arch/arm64/kvm/rme.c      |  3 +++
>   arch/arm64/kvm/sys_regs.c | 17 +++++++++++------
>   3 files changed, 16 insertions(+), 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


