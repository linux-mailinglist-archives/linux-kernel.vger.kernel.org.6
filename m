Return-Path: <linux-kernel+bounces-428621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C879E1173
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF8B23A1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B713FD72;
	Tue,  3 Dec 2024 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1mHAhR/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DE537E9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733194075; cv=none; b=lB9cH2jzZt9PWbfhPkLQqya1v5PiiBv+PodsYQrZGMRh2OPJBBc1x3HpqdzRKRnLjiW6xNcINadyl22k8xfI2MLs9DnHVy+zlfrQ6RBf9/gBdpD9W6yg2mADh1ctIHlaS0REHYtHyRDjLVluezBOEiOnsboI8NHin3X9AJwOsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733194075; c=relaxed/simple;
	bh=S4+xF6GjwSYSUWbaTXnqyu84Jg7pa7CJNYiyHEKFuHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtJ5RjsHLEEOur2xQc9Y+tNEyCIassrBN3L/gAH0MCO6yD51a/td/tKap7M2ZTnXVi40SgeL7KEuexHqVE5irRmmQKrrQJHee13hb9kF/fbN1GkSs2vpnPwO0M4CwFQh3dpO/6GqIOYWHRIwwRVPj0Lt24/Z7a/RIxbY2EiB+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1mHAhR/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733194072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8uM5ZCf1NAiH2GbTE4Ns0QI3puCq6vIOnKhBpmBZKI=;
	b=Y1mHAhR/BZcohd/UpwmQ7+WDioxE81mJt76BYfBlqSImAJYHWmlGBky+f65COwF5bcnSgE
	GB4DCTxWeIXBZEJdTHI9xSRr+irphb9xhgN7HQW9nWbcUyLa7uMFXJizd7l9+IJT65s+Nl
	VjL6cDzrX9c5iez8Jj0md6ihpRqV7B8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-PLe9AJYoN76ppyre54lzeA-1; Mon, 02 Dec 2024 21:47:51 -0500
X-MC-Unique: PLe9AJYoN76ppyre54lzeA-1
X-Mimecast-MFC-AGG-ID: PLe9AJYoN76ppyre54lzeA
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-72467cd273dso4544202b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 18:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733194070; x=1733798870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8uM5ZCf1NAiH2GbTE4Ns0QI3puCq6vIOnKhBpmBZKI=;
        b=JmJuqupVbseGS87UOpjDkNOsjByPFaEzBUgV+2Uvz5JCnncJ45vVlN+HYCvERMlwMN
         mx8vFbF1mupZ78tAYQ3mgm3Xd/ZkBAICMXD9llVsOsN8aesVXsRd+orWRgrK6WoUUqCK
         SGZHubn2sxB5FikEobhMYuAqHUwrQafyuf2zdIcIHo0vFztkNd9qb/aPSSsrS3cKql3H
         rT5N5Xou/cX3y8og/zTrMqWQuCJmETXGqx/Ss8ngQOyGQensc/Po2u8eIKeoOIIcDAm0
         GzTfGiR+GinHB+m2Ps+PHMpSDuL4dXAbq1APjswN2MEvWUKJMPYBsr1HMci2UTwjBlvb
         Illg==
X-Forwarded-Encrypted: i=1; AJvYcCX0b5zGoIcZpnpOxAn5VCV8qE3sB7unRwvHUWxtq1TVV99ATVdljQ/iR4Zrs9odi+L4hPd+Nh6FrdSHavA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxydfvDtDQ1HcIpsC/lYtw02nIcN2J0WOe0tNGH496uZ4KQ/KYL
	BFD4kimhcVLvDufH/gr/xoI1AvkM0WiXah7G2uZOJwGziSdOoX5wRUP7jes1qEVLTcWE6zBxTBR
	aryzbf9JBhlodkeNBFhKiGPVEzE9ebi5zOwSvnsFGYZ66WVOdH9GcIc1Ootfy5A==
X-Gm-Gg: ASbGncu8Imus0IeSre+EogezSHeQG4xwp6RxEAN5U5utmm/KIRPiiqKydY2zpefjz23
	5amif33llC9sg3DVGSZuy6jgnyGtxSYFiDW76esSVFtJSIb9PzcVXpb56iLr/8JTK+M/DY90t84
	EpAYBFtGjWE808rfJvJMNFfZ1EVbdrNfQNyxxOqU5ivSuRfaAm2gDWurjLFsxwOy7CHEJEJ6jPH
	o5ToxNtmK2u6WDmFsXZI1ynatakmOMNZSA3OrUvDPDRgEvxhWY=
X-Received: by 2002:a17:902:db0f:b0:215:5d8c:7e3f with SMTP id d9443c01a7336-2155d8c8072mr148391205ad.23.1733194070086;
        Mon, 02 Dec 2024 18:47:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzeFJ+2ROTZvJnL0D3su2mbemsSdeUnJmTDHLP0c4GM9H7s7uGaM2AzZpaQluWaupBDBrvSw==
X-Received: by 2002:a17:902:db0f:b0:215:5d8c:7e3f with SMTP id d9443c01a7336-2155d8c8072mr148390975ad.23.1733194069802;
        Mon, 02 Dec 2024 18:47:49 -0800 (PST)
Received: from [10.72.112.107] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154dae56e8sm59832805ad.19.2024.12.02.18.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 18:47:49 -0800 (PST)
Message-ID: <e0e5d74c-5e5e-4448-aa83-9187daff5b2a@redhat.com>
Date: Tue, 3 Dec 2024 12:47:44 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Ensure adequate HUGE_MAX_HSTATE
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
References: <20241202064407.53807-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241202064407.53807-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 4:44 PM, Anshuman Khandual wrote:
> This asserts that HUGE_MAX_HSTATE is sufficient enough preventing potential
> hugetlb_max_hstate runtime overflow in hugetlb_add_hstate() thus triggering
> a BUG_ON() there after.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.13-rc1
> 
>   arch/arm64/mm/hugetlbpage.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


