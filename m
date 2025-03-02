Return-Path: <linux-kernel+bounces-540823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C304A4B586
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 00:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6693AED92
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 23:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D111EBA19;
	Sun,  2 Mar 2025 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjuO6F5h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FAB1D63F0
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740959046; cv=none; b=U59eHMUrwTKYzYjvhFhbOYRyOiF/DjGNVWLO1EgB3jpoI+pEys5AqVEM7Nw6hjNFFKp0vYJYUgGKt2WSUyA2Lu0N6au4KuAFMuIImkHy/AqEnfGWFWDhdtUPJJRAIZuAqZMu1rxaKl8/V1ho67CErznS+3bjLkDDW5piOs4N2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740959046; c=relaxed/simple;
	bh=sTCLWPm34augivVf+k+p8TpTc7zDld5RdFOwiFSrPQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCB03RYdo6JfGN7y46k/B+RhONZnEfsL7bwSYXf19sb6aXbXLTxBJbzDcZoEXesmuQLnSd87DHmu6DHOoKcimKDEubSNUoQxXYlVvrpqq01UktvcUFcxIvB73XThszB3QkjGMH9y2qrfTBP0wb5XtvkJswAknaep1t+qqYaH7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjuO6F5h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740959043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apls3JT829ifJDsJne75u3rNFMkdEv5XlW99N9rTPso=;
	b=UjuO6F5hR2Ylkj2tPt2cBDqVvmTz4M/DjPoAWMNpzpP/T8xLxbTM/5WdKNFJqGH5uVR7Dt
	1uXgoCZ6UPBUHXYU1Z/YP80b3+nwkjMwkfHj5A5SjOvJplpLtDkfz8MbbdwZotRQpBXMii
	vOn64nZUbvHujjgAsaK2G2DMAAq2/wo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-FHFgrpCzPPOit234E4yLpA-1; Sun, 02 Mar 2025 18:44:02 -0500
X-MC-Unique: FHFgrpCzPPOit234E4yLpA-1
X-Mimecast-MFC-AGG-ID: FHFgrpCzPPOit234E4yLpA_1740959042
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22387acb40eso40108435ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 15:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740959041; x=1741563841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apls3JT829ifJDsJne75u3rNFMkdEv5XlW99N9rTPso=;
        b=F9oyd1pBzW2UlM6nzuu6fVsQaR+8RfnsMicwMn2gy/dYOjudJeVPCTwsTZxuUUnTB9
         h245m5JRvPbDKhgAds6pJ9WSm6BKQGAlql80fENudikzKhbIz9dEU5CCCo8vohHF1fby
         anOlJy5Ufd/xkOjiVIFySHE/RJ49bcktNZtu4ViqC9TQjorupOwvD3lJFyYTy3V8jIOC
         5tGm45WHexHXpgnKUj381oRz00jKwP4/TOdJwF3Z0qywNmDgq5R1QffyT+9c6GKZ+Fh7
         NmVWDvahHgn/ZDLaaDEr5Q9xsDBwkt1NB9vh4RU1Mo9D/IpLNmvKy9nuHkVwNo9B8DvZ
         HTGg==
X-Forwarded-Encrypted: i=1; AJvYcCW5EV6Cgixl7/II40QiGLNRIr0mTMx92gU+dyncGf4geRfwwldn1lFbbr0epQy35cEFhdPajaPM/j/ZfuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1DPSvzP0Wgz+xinZkycr8PGGCqT+1QjKVbrl2zATTahRjdcE
	PWUqTmXXJ0zwQbyIg5HJ+3HsLrXxzoL7+OqqDkMhNlJ2tsyVC3wQKGEVxs/cIQ3rnnFhrY8xL0q
	qYIO6gvXo0MCy6RvMNHrUHQoc2rWzBxoA06tgbZjndFzCla+NL8glRedVZvNTxQ==
X-Gm-Gg: ASbGncsY9iok072w+xyJa0wgd7t8/thNi68i9bnYa8yj3iNZko4N65R74RbS6ZvsMwq
	i5Kh0HB/W2zDg9n2hOj8ZB4OTK+/+hXS4xvGHZ1nRm0FqGezFmRc4GBaoe9wkWh0AAlrNSaSCqu
	8/mehFaVlYF6FOPBQWLjV3+e8k7/qRMdgJfXqQXNNgJzts07NAIlAUOyqEkM/53v/YuzfEnsR4Z
	pzRp0+GjrwhW24fRIQxuecZMmblATcxhRDcEcnFQtQMTUFPDD58aJ0SQl8SUdPBfdJAUSiilWdZ
	s29CjjxL1jNQlrzcRw==
X-Received: by 2002:a17:903:1252:b0:223:26da:4b6f with SMTP id d9443c01a7336-22368f74891mr183107325ad.14.1740959041706;
        Sun, 02 Mar 2025 15:44:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFYssys7UGoPXMBxe9bSswsi7jbUP9yKeJMmGxQGuBfHCIW8f2mxFgGu/EUcQbiuyd2gk6SQ==
X-Received: by 2002:a17:903:1252:b0:223:26da:4b6f with SMTP id d9443c01a7336-22368f74891mr183107165ad.14.1740959041447;
        Sun, 02 Mar 2025 15:44:01 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fd28dsm65811695ad.94.2025.03.02.15.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 15:44:00 -0800 (PST)
Message-ID: <9dbebd7b-b441-405d-8c45-0dfa4d3df9e3@redhat.com>
Date: Mon, 3 Mar 2025 09:43:52 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/45] arm64: RME: Handle Granule Protection Faults
 (GPFs)
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
 <20250213161426.102987-4-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-4-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> If the host attempts to access granules that have been delegated for use
> in a realm these accesses will be caught and will trigger a Granule
> Protection Fault (GPF).
> 
> A fault during a page walk signals a bug in the kernel and is handled by
> oopsing the kernel. A non-page walk fault could be caused by user space
> having access to a page which has been delegated to the kernel and will
> trigger a SIGBUS to allow debugging why user space is trying to access a
> delegated page.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v2:
>   * Include missing "Granule Protection Fault at level -1"
> ---
>   arch/arm64/mm/fault.c | 31 +++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


