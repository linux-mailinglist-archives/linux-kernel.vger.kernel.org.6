Return-Path: <linux-kernel+bounces-543251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35025A4D339
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7303AB918
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639F1F4629;
	Tue,  4 Mar 2025 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dg1QdK/+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344951F3FCB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068198; cv=none; b=ecl8B6vRU6lNC6IoWGFY9LuhBBpvCsGxSZOFDnBYyY0TyZojsdPAxpvMQsa5L9o86WtvPplGxLsuFgvciK4jLn0UmAkX2h1j7ZkR+WklNYOfl2EJhqqCtcNWsr19IwsIAk3s36pwHir1q/e/AjXSvsov5iQXmfngvrYVHxmhaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068198; c=relaxed/simple;
	bh=yzDD33Es1OjfbExLpccU0Xk3cqZvakHg4nxFLrMGGCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzTAOBvDaqlCfHU1oqIdPuPdbO1cna71gomQ0tdaew+8GHuPqbMQ8YQFStedYfrseD/KRonPg2tBV0E9Fv+rU5zb5rvBZrkhy6k/alrqd4drTHyaFTRCtpoy9EoUyE/zvbKEQ9hYbO92bIzw9DG4pqZ5D3lURrEJ/RHfbQjLzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dg1QdK/+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741068196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYQ+hp2BxThyEpl72nHuJbwMjHhQjin3JtMynxdNsGU=;
	b=Dg1QdK/+3d+GieAnPr5xcSqZOxbnysApE4LDYBss2BN/u4rdE+KNhjS3dwyXb2McaruzdW
	qd/r6MKjeFD0SAjlwYl0IRELROEewAPKmYl8+Mv/YED9B620RowAzMGHCuxDWz0MGovtJP
	JuteqgaPE8svVy0ew5cGE/QTGtb36jI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-sb2PPT-UPke5fQEhIU5yiQ-1; Tue, 04 Mar 2025 01:02:55 -0500
X-MC-Unique: sb2PPT-UPke5fQEhIU5yiQ-1
X-Mimecast-MFC-AGG-ID: sb2PPT-UPke5fQEhIU5yiQ_1741068174
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2234c09241fso155727865ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741068174; x=1741672974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYQ+hp2BxThyEpl72nHuJbwMjHhQjin3JtMynxdNsGU=;
        b=YEDtTVDcxIcuTJcRL3K8m7pS4TfDFZDxnsEZsn+d/pUaIT0xhi5aXsUdY/8outsukr
         ZLHbzW/l8DY36sZRvYKDgwet40tENWPjkGW94noEd8B0owIn7HBaMquGmigRLL86ZID/
         wRKZr5DQblfDMNiu/4pqMjW96YKm/mqoSAAZoN0a5RgICNiJSotmXlolb/3XHE/0oiQG
         c7SQICLYy5S07+9X+dYpAlR6zryV/MBYgmZEbQY7WmFKsc1bGI4cHmTXslk52nJvPjfP
         uLPNvsrcV9J8HnXO+FKZeEbVO8mb464t6GnMJlrZ1n/TNYcI+U7fizMpM6fzGL9QmNyW
         LI2A==
X-Forwarded-Encrypted: i=1; AJvYcCUeEWRktsei0a5IHJ8iBb5Tu0fsqoqmX6FKwx/zq0n422RO677WfOwX/F+Yq3n0mv/a6AwBwhy1kcYmuA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwo04IV1uKnWobyQKDVcGV/OPpsHxDqV3VRNd4Nuwbg+m6mcq
	8/8r/kHYXvR198tBQFO/vn+tlA20pE//MxYQOR2AHNlQm3i8tkyyTzgFvN/VoUTnWZ+FEWbt+2h
	bLcLyP/X7id8g3ymM/V3Iy4sY1dcv0nj67SyIqyY51Z8tyDxTXsK0du2wex74Jg==
X-Gm-Gg: ASbGnctX8BqJogsI0vJXw+SQQtjShEFSfQi/ZlfG3FZlwNMEwpyRBK0l/iIXZLkuAUd
	/YLk3xbk3EEK35nwtuRUQaq91TP0DKWLOmLwFFck3vwC1410g+QPDuk8tV/Eo7ikFfhGbh5B1rh
	rxFnGgErlGW3Q3qVu1saGIDyhHg0A8bWRyyJZute7bSiRqkGlBq0qjAwzjfZoeeFTetbXLmwNTT
	ovS3fByBATDzgk95IhaSSGNX4a7XnjFqWk/iZ4NyhGdUoA1bQhGy5mSO3oL+7SpBmjXqDkpF4N5
	YlC+AQHQ8J6DXw8C1g==
X-Received: by 2002:a17:902:e84a:b0:220:c143:90a0 with SMTP id d9443c01a7336-223690e0257mr268865415ad.24.1741068174603;
        Mon, 03 Mar 2025 22:02:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF17jp+SvVB8oKouybsWd/JrJXK2VcB5np1hjZzRt0dKWL0IvRPywYjYwGiuuPFEXE57B3yZw==
X-Received: by 2002:a17:902:e84a:b0:220:c143:90a0 with SMTP id d9443c01a7336-223690e0257mr268864905ad.24.1741068174278;
        Mon, 03 Mar 2025 22:02:54 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2234fdb5b02sm87962675ad.0.2025.03.03.22.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 22:02:53 -0800 (PST)
Message-ID: <5587ca83-bb19-42ae-8297-676588502e5e@redhat.com>
Date: Tue, 4 Mar 2025 16:02:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 29/45] arm64: rme: Allow checking SVE on VM instance
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
 <20250213161426.102987-30-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-30-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Given we have different types of VMs supported, check the
> support for SVE for the given instance of the VM to accurately
> report the status.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   arch/arm64/include/asm/kvm_rme.h | 2 ++
>   arch/arm64/kvm/arm.c             | 5 ++++-
>   arch/arm64/kvm/rme.c             | 5 +++++
>   3 files changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


