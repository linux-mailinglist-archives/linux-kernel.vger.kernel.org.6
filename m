Return-Path: <linux-kernel+bounces-543244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D07A4D31F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37433AE1C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052E51F416B;
	Tue,  4 Mar 2025 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDYZOCKS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFAC156F3C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741067284; cv=none; b=DJzHqjcOE+I7vSrI5SZGO4IHKHyijxuFpteyBd1R5dWI8+zxU51jvrKCZQCqKh7sRrribGBHwYIkJZOEUhhQYcrMrBotF+XIHJ6MhDIjc82t5TgbJYKqgVd83DKIWGSieniIWyBYYc2wa5yfeTL81im4Bz0q1l0rkmgKrJsSy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741067284; c=relaxed/simple;
	bh=uIUop+r/l6xH3Ly39qJ0Hh+UtGOGfUCQ1Gk41ZgJy6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWB7UYsHygq/f8c2eNtI/AWJ9TYGIzjhv7HzmFRPXE8r1ZdGGofT4lfycms0kBa/hu7ckcKm6OSQhPUM0HzEZ5e1e+hZN2xIfXVuENahZVeAo/FubMjXacu4FZDDGkaDV+jDQerOOaUhdr4T7X1mqLXL8gT2hN6wC6HF8PBP3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDYZOCKS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741067281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALe8gaqPx0ivwZMUhNjC7kbkgwdK+iS+cXrLOMiOcsg=;
	b=cDYZOCKSbxHn4yVmmzNX4T1//MQ5xNEZvrJzW90+cf/xSm2FDmRY2QpwhTNhsxjFZqyQkl
	L/0KOZNWERGgROCSkRYyWgtY07SXmrTeqdFJsvBzZGoN6FH6zL4oVO5fm+cLOY9BO3or31
	bHB5CiXiVg0ux4H0lOQS2UWKusD6jK4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-CAdhMdqwP8qxyep0UmGrUg-1; Tue, 04 Mar 2025 00:48:00 -0500
X-MC-Unique: CAdhMdqwP8qxyep0UmGrUg-1
X-Mimecast-MFC-AGG-ID: CAdhMdqwP8qxyep0UmGrUg_1741067279
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22367f4e9b9so70123285ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741067279; x=1741672079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALe8gaqPx0ivwZMUhNjC7kbkgwdK+iS+cXrLOMiOcsg=;
        b=u128XrXBrvUpewecDSqD1BtRq4G6Bw3M4aMOxoU8VoOsGVzuiir8XtrMDb/2lJSJbG
         7qpm1h6/NN3M7oUYJ5d/Xnn5W/O3dRWTz5XQBcbdB9AC9V0FKs2odAJZ8mj4NDYvcur0
         XSvP+LU5eSSEZrSUoJqf1gs18uAyWmeKL0TE/L9WtxmKm6uceY7mKwfvNL5M3x3qeg9Y
         vCyO5/5DTefqbFJbNc4+SIZiP8a3Ml4j9wOBT721y+1HGcCV18GGfpXghIqU108/eE/t
         tIRlNwZ0NAanj4OF69oSgRw8Y+jQPwBi6OR4EBRTtyfdK0ovMf9iyOXLCxPP7HSx3TOb
         pVIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQxEQBCppLpslJ5rWaZuHo3pJy11Qmp0cNDqyyKhzS01Gj+wuA/njHK8rRb1T7eHRbrHHHBguYzBEbiCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXeg4oBLgio/K1gEqwHPlqgNTkdiUVqcGboyovvyxoaG92wj0
	XdungAIgJGoHqDMtKs7fvKG4bqrUwzUHcsW9hVWTFdUkeVG92tC4wVZqGWGE8qEd71l9cKKe++4
	BaQyHoxLnooZ/b/de6Z163P3fIYzRDgcbPTMuVsbFmZYs/wKWVRBHkEDcEsDrWg==
X-Gm-Gg: ASbGnctCaRsfNcid81loGLf20FsiUbdILn3pNlkV6T2FgKjup0G0BqemCJByK2vQDdA
	JX+jJmfu2fiwTxH/fbHuNhJaLLxyOXa/gV39UqLyXCO6dybQFk+4mU7Vg538iCJuWOPQtqOz/8z
	UGjYTGKpd+H/bjKC/ia1eg8IQeq7hV9Hwz7qrxU9hycBCChADkntJCyVCL2Udfq0uTUYE78uqe3
	v+pBHpsuIeGJzgOE2/LBpf/FmiYUBWJu9hGWn9dyCVzwzccE6JClPPFMRnUp+L36//BDGTiHLB/
	AWAILNBAoZ+x+wvBQg==
X-Received: by 2002:a17:903:1988:b0:220:eade:d77e with SMTP id d9443c01a7336-22369255615mr277878305ad.40.1741067279415;
        Mon, 03 Mar 2025 21:47:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx0Lhe2HGT1KmpDnS5ZyyAdNkSfy6p9uQW7gR79fCGqriIN6Hj8entskHLAJfXfbmV6sWD4Q==
X-Received: by 2002:a17:903:1988:b0:220:eade:d77e with SMTP id d9443c01a7336-22369255615mr277877915ad.40.1741067279165;
        Mon, 03 Mar 2025 21:47:59 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fae0esm87110695ad.93.2025.03.03.21.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 21:47:58 -0800 (PST)
Message-ID: <2505ead3-64a6-4135-a96c-85c5dfef26d0@redhat.com>
Date: Tue, 4 Mar 2025 15:47:50 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 27/45] arm64: rme: allow userspace to inject aborts
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Joey Gouly <joey.gouly@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-28-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-28-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> From: Joey Gouly <joey.gouly@arm.com>
> 
> Extend KVM_SET_VCPU_EVENTS to support realms, where KVM cannot set the
> system registers, and the RMM must perform it on next REC entry.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   Documentation/virt/kvm/api.rst |  2 ++
>   arch/arm64/kvm/guest.c         | 24 ++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


