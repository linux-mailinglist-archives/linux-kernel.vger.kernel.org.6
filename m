Return-Path: <linux-kernel+bounces-543235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55833A4D30F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82133188CB44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A431F0990;
	Tue,  4 Mar 2025 05:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4YhKpkn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841E155335
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066738; cv=none; b=nu5cx9ecM6SNZgharZzvR3zYpn94OCUAYGa13AJQyQoAYIxBV4ZZEBxces5f8ijTJl+bZRDoIOQXBHyfDNq6E3bBvgVBPd4uO6ZxH45Xw5TXWMtRaKFCxwBF35WwAt0qSWXNxtFyzPLEfWz+1JqJ9b48b5EAcuhZxWYeeZs9Rn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066738; c=relaxed/simple;
	bh=bq1rEvMgUCO+z9mqMh3toWqnhddFvqq5Jt040KPfC+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEldMEGctHGOetwYZzVOhrr+Z6F2KDDOd1feBzWZQeHPBxcrH4045YNMTrRqBlYCn08b7NWAcrwisY/8TgOS2Xwkne/9yaz8sRuu1r3JyXF26M8b3uNbzW8x3EbFFTzknyAeYg1C1Icp/U1MSmDi0vWbYpVSgh5pDPZPndPyWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4YhKpkn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741066735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhnvguDUl9b0lKjHpwaAt3YEx23OG5Tvc8nGcNEISp4=;
	b=N4YhKpkn7RpyiX2ystlmN7saIPLp9BlaPv56TSpcROEZ4LLgIbzAE6NNOelAfoIZxKzG1n
	1HIVvojy3PNymCRmGI4ixm29RzNMEMamacJk6VepOpPKpUQgLWDBn5VqpNgYyiyJY9sgVR
	B3t72xkhxHCTzIdWAX1d8dArdn68htc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694--tZ0h7BqPFOAut1GaX7AQw-1; Tue, 04 Mar 2025 00:38:37 -0500
X-MC-Unique: -tZ0h7BqPFOAut1GaX7AQw-1
X-Mimecast-MFC-AGG-ID: -tZ0h7BqPFOAut1GaX7AQw_1741066717
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fe9527c041so10496817a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741066717; x=1741671517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhnvguDUl9b0lKjHpwaAt3YEx23OG5Tvc8nGcNEISp4=;
        b=DeCeQdCl/O9QYH7JyZ60ASara7KHIQDAq6rIQHuQKgVQ3uiMERlOhiKCY8MImxnScw
         SbZAB4nUAv0f1uvoXiAsOXa/+gQ1ag9xp4Lca6cgUG/zvuUQtjozzewau6q3IeryoYT+
         i8/fgRIaRMe4M8389wxRsJOzYJajfWhyXeyw0hq2J6SdXUmsck8lCSIjnzg/ftbJYeMr
         YEXVB9TA+ZCNLJA0jwRgJYo6CD34ERq6MhuFVQ1/3Mad2ysKczkN3ZGydnTRfD41pWcq
         O8NSR5laCLyIkLD/PgrCHIHEbLTiqNnyy877oDfcIhb9y0ijpbUbdXbMUCqttAuakd1S
         HqKA==
X-Forwarded-Encrypted: i=1; AJvYcCVwhNmw4OSYoD552/f7lw86sAR8wuX1+5mhC6sNQ6CoFtqbJzOx7Yi0gPSu9GZ32fcnMHECoPXCTCGPjD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKm7BJP3/Zs1Pg7gatqwSLWGDyFKdWzQ7ZEqKgnyWMlcBoc2H
	dCa4YhGZ1l4O7yd+kNpGpcZJEP3oLr/fyP5QKZ/vSgEMcFxl1f0P53eb/9zMA4u3yK7QI+3IN2x
	s5iPHSqfTYSSRblexnGFHsI7HiyZ63Bqce5g0EKTt3jeF14wmfbhdl+ebHV1jgw==
X-Gm-Gg: ASbGnctm86D1jWraBz6mueFb1+m4RXoEk5E8aoroNSGp2TKgb4xW2hCEDyh/0ZMJYuw
	Q3xi8lNu+D5JWNXUo+kiBznvy7dE0Y2+JCqhFSDE54TireomSVXm47RmsCD7J7HGtU2v6srrjSN
	C05vYzJeGsgj2mMpiApM4UqFgMKzTdaVGSQD919sVEknS4/xuAyJxvFcVzWrK6HhESsWacSvSDu
	Y+QqYNvVf2V3Y1WNeg2WMmruIf/wxvW+jT8dAHZU8gYgDyhhuAMUWbv+UqOUxufxZyLAK8pz+ld
	uU0jJEItEEEO62qM7Q==
X-Received: by 2002:a17:90b:2f8d:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-2febab6c68emr25331692a91.15.1741066716883;
        Mon, 03 Mar 2025 21:38:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF612ZxdojGbx89Aqh0mhvbM65hIZPcepIXHF98wxNJcpuaTGS26LwyEfOvsNmDG1/FgXRbOg==
X-Received: by 2002:a17:90b:2f8d:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-2febab6c68emr25331658a91.15.1741066716552;
        Mon, 03 Mar 2025 21:38:36 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050d7c1sm87354825ad.198.2025.03.03.21.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 21:38:35 -0800 (PST)
Message-ID: <5008db08-c153-48c0-90b3-39fa0297ba1e@redhat.com>
Date: Tue, 4 Mar 2025 15:38:27 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/45] KVM: arm64: Handle Realm PSCI requests
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
 <20250213161426.102987-25-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-25-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> The RMM needs to be informed of the target REC when a PSCI call is made
> with an MPIDR argument. Expose an ioctl to the userspace in case the PSCI
> is handled by it.
> 
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v6:
>   * Use vcpu_is_rec() rather than kvm_is_realm(vcpu->kvm).
>   * Minor renaming/formatting fixes.
> ---
>   arch/arm64/include/asm/kvm_rme.h |  3 +++
>   arch/arm64/kvm/arm.c             | 25 +++++++++++++++++++++++++
>   arch/arm64/kvm/psci.c            | 30 ++++++++++++++++++++++++++++++
>   arch/arm64/kvm/rme.c             | 14 ++++++++++++++
>   4 files changed, 72 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


