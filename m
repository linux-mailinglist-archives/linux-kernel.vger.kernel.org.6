Return-Path: <linux-kernel+bounces-543237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BBAA4D314
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4EF188E742
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDCE1F419B;
	Tue,  4 Mar 2025 05:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8kOvKuk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7D1F3B8C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066810; cv=none; b=M/YRIixNkfAiF2CYWTXFsWPF2MxgPBznb6tB6TPFgta6tlCo+lvpeNn8Cgw2zOessGgutpWWdPDyWqOzHbAddCF3ko2ngHzR5ydyt29snxAyvJTPcxZNYPZ5fs5y3v9A7+bnetVwE/+xBZ0EWZ53trxVHoQD4nKPvzJ2536/a4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066810; c=relaxed/simple;
	bh=m1IRZ6JWrGXWz0hUht2VZ4u/oJafs19LSlUBPTVVrj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHpOAt6OxXeZxbyh1VobX1aU+d8TZWCyM+8raadhvtAzvV5kc1GIHqmOz6o6ewCm5/P3U1NPLzEcRx3QKmvvR4lvUbAzMQ7f5Tk+09cy6ThQoQLh+AyeQoCflOny0/O4c1+Bc1itKGctLDooSrldRgQkfjgcMOJPco8jLdeGu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8kOvKuk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741066807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnsiIq7MCp7MkWvaBWDURZ2QmGy76WgJakR0X9oQlAA=;
	b=S8kOvKukWKvBtYXvW+Dgt7doRhe82PkpzuCMFZAaIgNyUxJOAwcw3LReUmAA2+gLNMpMW9
	S+r3GJSydQfiCcflw3yGyD9R2WehIbHEGqRHdK4dG5pFhJUFPprvvTowmhLtQtfAssbdg7
	VdbKBe5brrKobSPf45T/rqQJStQjLvs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-RJZFW1X9NdKRvviAxTNn_A-1; Tue, 04 Mar 2025 00:40:01 -0500
X-MC-Unique: RJZFW1X9NdKRvviAxTNn_A-1
X-Mimecast-MFC-AGG-ID: RJZFW1X9NdKRvviAxTNn_A_1741066800
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2feb5cd04a0so8201594a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741066800; x=1741671600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnsiIq7MCp7MkWvaBWDURZ2QmGy76WgJakR0X9oQlAA=;
        b=dfslAycd6unW1KAQln9AjjwwlFozYGEZ6Sk07w6xxhRFv5ZqWWg9o5yJUDqNP7cpXo
         JnUQ/QerPS064OaDtHzvRsR2UxW1xuog2JKA5TXpr2aISZyRyl7oHTyejWLGxplX/L23
         5syF9eP159vCLc6acrA9C/RePVZ3ML4mA8Rqj6ffnimkFHT52nT1HvnlLFmP9VzhUVHZ
         7MW+okax72Yf8PAC8wl5kha3udGyO2KVMpBCFoMg1fUnb/P0aQoFTf6BKUABjWkl3ptl
         ghRd1LsrCnL4gBgpaq3ODJS5lNDFDQbkX+/q3EdBl5ME800x0NQSfJxYsRs9U3uaKdeW
         IWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlI22f0siypKxnQQpdubzpFq9xV450RS+j7+sf38rA0qITzosssYlgyEtcSkwAlKzvAAXSZrHj9k+4ANw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFOwICneJOSmOfJ17mvW7tOfrAJKcXqF3c0AfHJNQ7GcjSrqz
	qUZP8tztyqkBN2ILh9BgDasm8vCNpDiRWyVa+CJDR/QEYAVVgUxXsQitakDAVTnaoSDx0zzT8c+
	jZlOsKH7mvcgqjRHbEl8n6QNq29qUQpuULLckLVZa/eL60lbgk9SPwefDpBZ+PQ==
X-Gm-Gg: ASbGnctlNYMvZ77NvCYGNScBJ5kn6cszTYmokVK7ISFaNgr/JvkA0Td6KxQyMQ7dsVI
	p41y7ehd/0aum9I71kRZhSC+pyOypyQ8WfK3b0fut98C/USsXQgJ05T+bgz9OflK7sKi1MpuOdw
	5r6O7pI45FRi761iz3j/IXA2Y0+XMlGrfg8V9VL3NUH/tPBTEFquz+4YTy8h8AY6bslzuNFTvlA
	82Nx/asL1d9SwsLj7oCMzGN1v9Z9xazMJjwH5tM+6hrNuSL1LgYJxdLo7Jjrn6SmNL3QD3HFNPf
	sH5ARJ830YI9jbifuw==
X-Received: by 2002:a05:6a00:1e0f:b0:736:41ec:aaad with SMTP id d2e1a72fcca58-73641ecaf3cmr9917215b3a.14.1741066800346;
        Mon, 03 Mar 2025 21:40:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLv+2IvaT9lpwd7y3NyeB6C4SRMHYy3586SBjSpdbcGPeX0DUdvbJ57X14h7Gm8kD4TRZ84g==
X-Received: by 2002:a05:6a00:1e0f:b0:736:41ec:aaad with SMTP id d2e1a72fcca58-73641ecaf3cmr9917181b3a.14.1741066799979;
        Mon, 03 Mar 2025 21:39:59 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7365bb4090csm2607097b3a.35.2025.03.03.21.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 21:39:59 -0800 (PST)
Message-ID: <bf568862-5435-4c88-9364-0190f30a3d9a@redhat.com>
Date: Tue, 4 Mar 2025 15:39:51 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 25/45] KVM: arm64: WARN on injected undef exceptions
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
 <20250213161426.102987-26-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-26-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> The RMM doesn't allow injection of a undefined exception into a realm
> guest. Add a WARN to catch if this ever happens.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v6:
>   * if (x) WARN(1, ...) makes no sense, just WARN(x, ...)!
> ---
>   arch/arm64/kvm/inject_fault.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


