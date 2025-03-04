Return-Path: <linux-kernel+bounces-543289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6524A4D3D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3451883C5C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C354D1F5423;
	Tue,  4 Mar 2025 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EogGRYdL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E61F4734
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069683; cv=none; b=NIq0R0njSRhLs9X74bUbWrl1Zmep93uChyx5JQLJYIT8j+EEw/QvlXZdAw+vpdFSsmQW4F/irILsgjOQSxTLRr6e59iF8FEGzanVLwhEq8nzyZK5rfu6LQhh9lhJ6nhu8GNeaBCLR+xV+wG4cuwAXEoGuUYmR8/l2FCSAezcluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069683; c=relaxed/simple;
	bh=sANxphPEpJhSoJRv2v+wz0k0ncvT/idn6pMCGmv7Dyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3GyhUxHM21cN5bt3xHOycUy0Eo46gb+CWZi+W3DXpY2Gq8azIx3XXhD2YqlelTPIfNKKMgvTk6rLhmyI0xCZ1R/N87COAG1YOZi03WNFDcjBZfMHBWQFGnXpjDWoXY1tIftFnhbERI3rp2W7o025kzGHc4jhvTnMYn6uKYp3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EogGRYdL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741069679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAefvd9tbj7LNYMHtdDRot9Yl7dRO2WNDbwoA2ZpIZQ=;
	b=EogGRYdL3R8QdP8PDF9Qm/ly4gKxoo5uvwzGZrLnGS3lVSmoH6uPfdU05qh4JBEegaqDjA
	g6hRs8/b0KCNyYwC4XRhnLYwx34z+HWOmTWdayZ2p7HqFYvqd4njpn8Pcf1facS9Zz45WC
	ypcDz6FQbaBSDWcqZ1vkX+EHqOOIkWI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-1lk8s1C9NiWj-xJVuw9_dQ-1; Tue, 04 Mar 2025 01:27:58 -0500
X-MC-Unique: 1lk8s1C9NiWj-xJVuw9_dQ-1
X-Mimecast-MFC-AGG-ID: 1lk8s1C9NiWj-xJVuw9_dQ_1741069677
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22367f4e9b9so70747465ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069677; x=1741674477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAefvd9tbj7LNYMHtdDRot9Yl7dRO2WNDbwoA2ZpIZQ=;
        b=rDuqKnWKbZcDqCZfxBCIV6+zCgSH8QMhqNvUypY97ZFFGM1iLcWbCoejQOViBUuKSm
         p/O9rmJNy/pC7losey9YD0doCmvc1nqTKYcvNtgnIneNxomsAUvS3YBKzCIdt9YJ3UT2
         3qprq5cRru9UdXUNFlnnegYd5UbykWs/GwuXZ9Y1dYWB0vsx400u3XD7XKumxxdElqeo
         pwE/h5I9Tx13Zy9hYcV28I1b962nZm1OxvH7DpeiBhFAryP95eqJi3HzpUa1x1E3CIOo
         k4XfYm+s82GMGO9iuP3Myv6YEWNKxWA2H37Auh7VG4qbZ5jFADJ8ZkN0WLTqSPNc+wjC
         XSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVJjsUSyUR07MVvO2d3SjXjt7O2tsSKT6BjPmG4d8Z85Pk4nfrNM/UZBGdl+hud2E8uspXLNWWykt3fnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD2nEY66czlPurRKbyAu2TwmLOMUiCqmYwtbo4WQQYM8NuF4vc
	yEipNsMYst+644xXENy3VI9u6n/Q1uxpQoA7WBTchHaAF0VmbTGhH99DGoLmxYsJpjZ0M+KSU5V
	uALUET27MNL8UXe6eS11kP3NNMR0B5wuXMI5mGNW+nopCwhetCZ/68OMEk3smbw==
X-Gm-Gg: ASbGncv0i6/Uz3emaH0DKLR77gxfT1AL3JKlts7HSV7+ef4gOqTl/SnelACmGD5X4Dc
	QKum6KBJJcGPs8ReIHZRnycUYBBUfTbvizgKkvwIym8yrnzJwSFJuzlRto2ZR7YLhbJLb3OlKxF
	5HiMpFzugcu1edG0UbGjwHFAKAgb8f8lJqTYu/HSKmqy04kR1SvkBO6X1u7+Ab8muGUK+VHUjC2
	wKXHclUcfPzRkDioEQTGbRn5X5rv4HwA6iIm0q5FbYcoXTBgh6+/7dkfuHjTIKn2p4lMm1tdLOe
	bFfrduUOKCLMwLyw5A==
X-Received: by 2002:a05:6a00:230c:b0:736:7270:4d18 with SMTP id d2e1a72fcca58-73672704d81mr1945034b3a.14.1741069677570;
        Mon, 03 Mar 2025 22:27:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMjQLRj3AUSUbMsClYXUXqxqJWhk5KrbeXBQgXSoViyrHJ8djjcdkYHY0nBVtVH5e57rXWYg==
X-Received: by 2002:a05:6a00:230c:b0:736:7270:4d18 with SMTP id d2e1a72fcca58-73672704d81mr1945005b3a.14.1741069677191;
        Mon, 03 Mar 2025 22:27:57 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363986010asm5850843b3a.52.2025.03.03.22.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 22:27:56 -0800 (PST)
Message-ID: <780f593c-81cd-495c-8ca6-38ecd64ddb35@redhat.com>
Date: Tue, 4 Mar 2025 16:27:48 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 31/45] arm64: rme: Prevent Device mappings for Realms
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
 <20250213161426.102987-32-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-32-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> Physical device assignment is not yet supported by the RMM, so it
> doesn't make much sense to allow device mappings within the realm.
> Prevent them when the guest is a realm.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes from v6:
>   * Fix the check in user_mem_abort() to prevent all pages that are not
>     guest_memfd() from being mapped into the protected half of the IPA.
> Changes from v5:
>   * Also prevent accesses in user_mem_abort()
> ---
>   arch/arm64/kvm/mmu.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


