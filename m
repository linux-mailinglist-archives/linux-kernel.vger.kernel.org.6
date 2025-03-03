Return-Path: <linux-kernel+bounces-541057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F59AA4B7E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844BF16BDE8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923CC1E5B99;
	Mon,  3 Mar 2025 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRHLFwbq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAC1E51F8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740983163; cv=none; b=GjFeo3NTexYg2S0m1H8q3wuBZc1vcW8o7SYsTFcGAofGQoTGs/uQ5S9HT2RM/P1m5QFV4WWd62NgDLUWspOxbHbTNnRK0PwS2Fpv7hZx9IjXBUukDUHr8kHq48PPkI9b+ce/EEWTlSEsKGAufYxvpGsrgYYBhwllSwGKO7/ZJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740983163; c=relaxed/simple;
	bh=7M+DRz2hm03rBgj2x3UrNt6vpeHXng5+xitohQvfcAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RphNCALukHtb3az33MeMlpCP8ehYVAok2H+t54xErDUO3YtDeliBNjmGYSS3bibYH1pOMI7wYsZdFD6ZrWn9GHRCA9D/oyYlVLgHgKBJBx8K9uaQULf0/ujWwKy3V5YZo/lOse4oGO2chH7nntm51n1WI6+IarQ/qtcrzsaqvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRHLFwbq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740983160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+ANXerGfs05Qx5JuBBnd1YtOYkq281duKe5pNwiLBs=;
	b=cRHLFwbqujy8cwVVN0Sqa7MjT2F9hOhYL/LYLqke7XM81u8cZSIq5XKfO2lW5plSkSRhT8
	DoQauMnnpzGSEXf5oB3tXoBVKYO2xkP7jbdjDlzwlFzkRtOeQ+pGmCwIIeqIX+3I/G028Z
	P8Ms06ZRcWsg/pweQpOn+84/TcGx01c=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-j67iePG9MXmtqJrtzMRhlw-1; Mon, 03 Mar 2025 01:25:59 -0500
X-MC-Unique: j67iePG9MXmtqJrtzMRhlw-1
X-Mimecast-MFC-AGG-ID: j67iePG9MXmtqJrtzMRhlw_1740983158
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22339923628so76600715ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 22:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740983157; x=1741587957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+ANXerGfs05Qx5JuBBnd1YtOYkq281duKe5pNwiLBs=;
        b=rmp1JhpFdVTQoL7Gj2vemF1v8d4xyrXuehh2/KIrtLONO2Pc8gl1g0p+GoefGr0MJh
         L/GXu5myL4WUJ8dVQ0ucMNPkjyGr9xCvQLanVr23ZmvtYweG+rxivsQHWdYO3Yl0TNDq
         rzsG2y5NR+Bq9KmZY2Pa1VW4H9PnE6+EcAK9E+6to3bwx8bgefVrmdLF2OhzTNb9Feb4
         fF8j+rBTfvB0pjgo87lopLBRr/kvklEBxS+Xy+7Nhd/6v8V4dgHMDeHbInz4mHOFEy8E
         SgHziGtgcKkWOOvgGrDX64qNu2Dn3muk0QnlphSC5F3Z1NGGR+awNxqICn8OtKBYOaGe
         pSBg==
X-Forwarded-Encrypted: i=1; AJvYcCWoHXW2Bm4nPCNdQC+F1XQGEifNUBuDVIhFGDnBJXHRjfcX/O/K1KS/X22kaYBUFNiWFQhG6GmjGwCrqKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWh68pJqMbBa423vA6JN7lKQH9V/tu1okLmHVbDetCwcfldVAd
	XR+trWWTWCwgyC9dEYupWt89HYBugHJW4jKbSt35YCTrghAcvUOXxsrExJHSMZyrpCdql+b62w9
	9mLOsxGm6gNVGY2aIWe6qQxr8GJHVt9P/TGmhDDmuyZIpJm6Py5eVa9WeQE368PPeJghtvg==
X-Gm-Gg: ASbGnctqQ/LO9Pble73i1EVuIXBFJFOEZLfMuD9i8j0K2GQrRSAoYbdkzNkQKkukiGe
	IkodpawZ215vWZtFoUjKeUDS0vQ8pReREv+rb/CEzxew9C27N4q4bie6/qKZDOuvkynJgZFb6iK
	UJRlGUze4iz84cycdDtrDborQpa9otszhhj6X3Uo0YooVvUTNIb5UVVqE/fZVMW7IuDagiQ5O1F
	qJAEjS/soUXCLT2aMHpZn00thV6vLGURU2MriBb3zK5P6Alwj9xvjcTo22R7uAoyNUJIv3M5PZn
	Klk82m6qLwTC28a8dA==
X-Received: by 2002:a17:902:e5cf:b0:220:ff82:1c60 with SMTP id d9443c01a7336-2234a4891c5mr239752305ad.14.1740983157570;
        Sun, 02 Mar 2025 22:25:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpXtcArHUqT2hI5ax8evJjGCyGJEtPHCAmH1OVzs9dnw0tbzauezRsGnlG5Grz1mEDveiZtg==
X-Received: by 2002:a17:902:e5cf:b0:220:ff82:1c60 with SMTP id d9443c01a7336-2234a4891c5mr239752075ad.14.1740983157279;
        Sun, 02 Mar 2025 22:25:57 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c59e1sm70112765ad.158.2025.03.02.22.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 22:25:56 -0800 (PST)
Message-ID: <e432ee67-6afb-40c8-9542-48770834ee40@redhat.com>
Date: Mon, 3 Mar 2025 16:25:48 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/45] arm64: RME: RTT tear down
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
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
 <20250213161426.102987-12-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-12-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> The RMM owns the stage 2 page tables for a realm, and KVM must request
> that the RMM creates/destroys entries as necessary. The physical pages
> to store the page tables are delegated to the realm as required, and can
> be undelegated when no longer used.
> 
> Creating new RTTs is the easy part, tearing down is a little more
> tricky. The result of realm_rtt_destroy() can be used to effectively
> walk the tree and destroy the entries (undelegating pages that were
> given to the realm).
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v6:
>   * Move rme_rtt_level_mapsize() and supporting defines from kvm_rme.h
>     into rme.c as they are only used in that file.
> Changes since v5:
>   * Rename some RME_xxx defines to do with page sizes as RMM_xxx - they are
>     a property of the RMM specification not the RME architecture.
> Changes since v2:
>   * Moved {alloc,free}_delegated_page() and ensure_spare_page() to a
>     later patch when they are actually used.
>   * Some simplifications now rmi_xxx() functions allow NULL as an output
>     parameter.
>   * Improved comments and code layout.
> ---
>   arch/arm64/include/asm/kvm_rme.h |   7 ++
>   arch/arm64/kvm/mmu.c             |   6 +-
>   arch/arm64/kvm/rme.c             | 128 +++++++++++++++++++++++++++++++
>   3 files changed, 138 insertions(+), 3 deletions(-)

Reviewed-by: Gavin Shan <gshan@redhat.com>


