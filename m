Return-Path: <linux-kernel+bounces-377795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953909AC6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415081F22CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B251946C2;
	Wed, 23 Oct 2024 09:46:27 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BBE136357
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676786; cv=none; b=O8ifWetDp/+76Zsol5aX8crQDLw2jKdeKZ5baG8UHg6eTsjE+uKVJp4IJydrUIAFg49J24etqJGRKMuEQp10u+/kJ+5IGZcTncyrZ0Y3/ofUPNg9mlI+S8dzmUtNPMnCY+lOT1ElskEcO6MMGu7FqRKbLiCPGScTS4RGh103VaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676786; c=relaxed/simple;
	bh=7WWfdSSU0dZIz8uOzoqjntDQGqpbRKRIIMl8L+iALiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AK8rp1VmurVW7zuNN/YA0O5GdhcSqXfXqhVXvE4qP3xWw1F7umjesa8h+S0lHoZde83gWTkAijHKdlyL0rHjYQOVWcxEsqMoqgKHWyP4Awr10lm+0pkP2Abx79cTqQLIxa8zHqwxsVT64hrZ0mBSi6QhvjIsEqtQs5+OGiRY8io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso943644566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676784; x=1730281584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBpqt7O1UVowxWQhdRzPD2AUA5xa75SUt7TL+T99+jU=;
        b=Ax0ohv3Oh9gUn61uaNcPlLgWWQbkAPAuDnGbcLUYKmJs27KJ7QX4D0PS9BXMxOH+o3
         u/0HbxxLPv7BDofpd6ZLiIkXelSqFScdH6tcY+Orz8qYRzE2N0pvAir9lY53nRMkhGZB
         F6EMiq/g8Y36f5XT8E5UMXi8LVQ1CZTm1d/CW/SBdWWZVejWE4aJIv/t5WmnMp1NpE6F
         bYu3bIgVnfCIE7sTgmcN+JCIqsdvmJVvlYGPvRtm/gVd04Dtwkhnjb4izYZnmKMdJrsa
         AQBbdp/qyWzJQ6A5j8UYRs5kus1Exuw8cYi3FcZbfuBAxJCnk4kS3Xcg7MbwSfmo2BxT
         J68A==
X-Forwarded-Encrypted: i=1; AJvYcCWhN3pnPMAZe1FBOV7iy8nPouZMCdu8btFI4RdHIMQrzbToUTGeNPhfPtCHspaVpywEwpd73OPsa69955U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbSC0AtIg9bChVHDBzzU+M6oc3KlFvxVY1LRflOvY4Ka38+NW
	Q5rxcukm6cq0P8CJC/U6RuUYxWG6ff67X/BVe5Za8eqLbBmRzH4j
X-Google-Smtp-Source: AGHT+IGRZlRgRkyJtIDZdMdsrw1KKYaTyrzKxbx8XqOmFjRdlUXYJfrbO/clap8pTJnoJhes2xhzGA==
X-Received: by 2002:a17:907:7247:b0:a9a:33c:f6e1 with SMTP id a640c23a62f3a-a9abf851e2dmr181732466b.5.1729676783442;
        Wed, 23 Oct 2024 02:46:23 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370723sm450767366b.100.2024.10.23.02.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:46:23 -0700 (PDT)
Message-ID: <8a1e78e9-c064-4fce-9ab4-f2beea053d97@grimberg.me>
Date: Wed, 23 Oct 2024 12:46:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
 Prashant Malani <pmalani@google.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
 <Zxe8e2zS5dA61Jou@kbusch-mbp> <20241023052403.GC1341@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241023052403.GC1341@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 23/10/2024 8:24, Christoph Hellwig wrote:
> On Tue, Oct 22, 2024 at 08:53:47AM -0600, Keith Busch wrote:
>> You'd may want to know max_sectors_kb, dma_alignment, nr_requests,
>> virt_boundary_mask. Maybe some others.
>>
>> The request_queue is owned by the block layer, so that seems like an
>> okay place to export it, but attached to some other device's sysfs
>> directory instead of a gendisk.
>>
>> I'm just suggesting this because it doesn't sound like this is an nvme
>> specific problem.
> Well, it's a problem specific to passthrough without a gendisk, which is
> the NVMe admin queue and the /dev/sg device.  So it's common-ish :)
>
>
> Note that for the programs using passthrough sysfs isn't actually a very
> good interface, as finding the right directory is pain, as is opening,
> reading and parsing one ASCIII file per limit.
>
> One thing I've been wanting to do also for mkfs tools and similar is a
> generic extensible ioctl to dump all the queue limits.  That's a lot
> easier and faster for the tools and would work very well here.
>
> Note that we could still be adding new limits at any point of time
> (although I have a hard time thinking what limit we don't have yet),
> so we still can't guarantee that non-trivial I/O will always work.

Makes sense to me. Although people would still like to be able to
see this value outside of an application context. We can probably
extend nvme-cli to display this info...

