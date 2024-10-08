Return-Path: <linux-kernel+bounces-354471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF7993DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62F9286520
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A1980604;
	Tue,  8 Oct 2024 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifPkfQT+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559F2AE90
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 04:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361043; cv=none; b=Abs/aA4ZCDNpHEwG+dOb60OxT0uMwUgkzJgagtsICKcaeLRTNvo6TgTJz99h58I+n43/qEjSLk5np8s2Qe4oWC7Hz2IfG8MJi3orC6MlNRZ241ry8wHS4+HbNRUM5FEXJKXr490EZEPSkUVdOEYSS+NuvJkLslMgbRLi+Egyl0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361043; c=relaxed/simple;
	bh=iMlXn95lsVNsLjKDst9hTcZBOaf6Cfjj7y6Z9vIOTog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnAdnD3qZc5K+omedB0IgDxBRbsTYbiQSugYhf0cJ9V9oRmsqe9vNsCKaKKeOHG/iITzy5feQRYhuuxq5DaJqirK/Duj/qa844tFDXR70AXLStJl5OV5BPk2m6wisAZda6/dlKU9ebWcjgqsdr+KaJLPN4jnOz8zxD7xUUvOirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifPkfQT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728361038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f61bqhCr/dcQZbMurDXm0sPwEi+RQMeAt5XgpaR2Hcw=;
	b=ifPkfQT+mnlKnVddsS17i+2AHQN3wsZt/+TXlXoEu0PNK4V2cnlkDfjtDxw40IPNm+HCkj
	8B6ekNIdOWcK+0iwIBKaf+pMHm4/GauonRWeMWk1qN0eccGVYzk9s0MMh/dewH5bdMkQz5
	rFUHsXuIQgVOssDVKrqHtuAnb3vficE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-1IF_NT2LMquL4U5mmS8ncQ-1; Tue, 08 Oct 2024 00:17:15 -0400
X-MC-Unique: 1IF_NT2LMquL4U5mmS8ncQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71df2e5e4beso2782604b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 21:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728361034; x=1728965834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f61bqhCr/dcQZbMurDXm0sPwEi+RQMeAt5XgpaR2Hcw=;
        b=MJ3dHyWj1pnHJOOenJQ6sKmi2VJHbHSgFKRjDdbhcsjwp2PJs4iYRxWsR6w4XHI7n/
         mgovaz4TA3ciu+VHrOrfADZicUxE/t0av+r+BqCVdWd4Dp8JtaJ2LPyrp0xNxld7g1tu
         RZHmFuVr1FSdBuUfD/YY4OfDxAVtFhoV7cd1/jHwo5TbgaqkBI0W0suRtr4qhJD1jBo7
         0bCo4aX+r9jCKfi5SOHnadFff6F3ewYbES/HnQa7Ovs2XIKDlFMt9R1izMa+/q7pEUFX
         ntbuwXMGrPJPFkp17N+4ea9ffetWtgpYi7rhVvSQ/BFB986iqQkQ+Mkx02lP0WjFHjY1
         e7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+UbQo0kAqm/8kt3K7UqNB8bgQb+R/X7IyZMggvbdPCWAQ6AjtPvR3uWrfMedwbKVwTOO41zati29W2+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCN+l8nAa3HMb73LEqBMcx/plR3xCk9x9c9bTbCAMwM3FPm3w
	jtIHzdBYMU2EOrV64U5ZAPZvumClsBX72r0io3U57fkTNaUn7BzJDnqqZbrmBWA5npqsLNv/2Dv
	qZCiNot5D039jIUaAY0mKBQOrXCqOGSaJo6unSiCb1smDKLcJiB99lQkdnjwuCg==
X-Received: by 2002:a05:6a00:a96:b0:714:2dc9:fbaf with SMTP id d2e1a72fcca58-71de24514e3mr21564728b3a.18.1728361034332;
        Mon, 07 Oct 2024 21:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpPFYi5/75nkediY8DO4Wu6TCkkIkTn8IxFnQ74JNSHVIEvH9PD/xbYAIthgHX0w8NyyIQ8g==
X-Received: by 2002:a05:6a00:a96:b0:714:2dc9:fbaf with SMTP id d2e1a72fcca58-71de24514e3mr21564704b3a.18.1728361033989;
        Mon, 07 Oct 2024 21:17:13 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7ced7sm5196665b3a.191.2024.10.07.21.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 21:17:13 -0700 (PDT)
Message-ID: <f0e83860-15a5-48d2-a256-60db70c974a3@redhat.com>
Date: Tue, 8 Oct 2024 14:17:04 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] arm64: Document Arm Confidential Compute
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
References: <20241004144307.66199-1-steven.price@arm.com>
 <20241004144307.66199-12-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241004144307.66199-12-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/24 12:43 AM, Steven Price wrote:
> Add some documentation on Arm CCA and the requirements for running Linux
> as a Realm guest. Also update booting.rst to describe the requirement
> for RIPAS RAM.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   Documentation/arch/arm64/arm-cca.rst | 67 ++++++++++++++++++++++++++++
>   Documentation/arch/arm64/booting.rst |  3 ++
>   Documentation/arch/arm64/index.rst   |  1 +
>   3 files changed, 71 insertions(+)
>   create mode 100644 Documentation/arch/arm64/arm-cca.rst
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


