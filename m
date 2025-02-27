Return-Path: <linux-kernel+bounces-535233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB18DA47066
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C417716336C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223B618AFC;
	Thu, 27 Feb 2025 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5EvtkN8"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9D4A24
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616840; cv=none; b=VYk9r6ALQSwNgFdqjKVfxkq5oRhqKzfG3rN4e2MCcZ6zJPQL0Vye9TOwmVrdohTtImMeebFR97Vo6X8GpKdB+kGCuO8AK4EXjFL9w+KyzdmkulJ9C9uMNs9YHda+hvLCssmJ9xHhSG9cXauPdDnskjEMlQv3CKaBMNWHJ5YdG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616840; c=relaxed/simple;
	bh=jpLsczkirjl3znww0vHtEndaxD24N3ExtJwt48GA4Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRFv9WBfubbGHS8QTvRbRw5280zsQwX1qIi+6ZUacTJ9cSIFcmCz5QX98zzjY69r5NJQnhIcNxLectlO0dB9OWVNjoPSjWBI7lGiqHxPLS07PsjZmYCu0eK2pL4bg/o7eVa4ZZembBXHgA2IwsE9BNl3ICAk6UclETMlF3vdsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5EvtkN8; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-390e3b3d3bcso270755f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740616837; x=1741221637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpLsczkirjl3znww0vHtEndaxD24N3ExtJwt48GA4Ow=;
        b=j5EvtkN8N3A2HCls/pSAH0wrUZnMmuC3jvwNr7IKJ6Oj+ohHlDnC71rJLVHeAbrLvl
         znyl7vpN1abevrtVBo6W36Vc+qJ+/zRGYEkPDQKGE4FyPUgWVVgTw9Jz7h2f3JcA++iU
         SBSUhDJ7iMsXZ7Ye9gYMTaxHABnEmzgCpDU5ef9KK4ra39BCgaKNuvDcX0gUj8BTjKc0
         6O8tcuy6r2uyqiuEmWhB38WvuGSb9+18AZCdSZVpuUOuFl4HHgvquYOrysa+zHgGQeID
         HBX7VrD5WeVImbCye2jdzTPti7ANBLgUTm08PGOrUyUSUIu5jkvNnqmlRTw5NBSzvHtT
         8TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616837; x=1741221637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpLsczkirjl3znww0vHtEndaxD24N3ExtJwt48GA4Ow=;
        b=IRmtzN+5SxiU0DPTqLIMzg5ztU/9Tx13QjkMlJ9dBzPP5oA/m4IyPLtCBwQUnpCyej
         1AUyxJNqdTEcccOzoM4APwLMXhVwnuOrLDZkavOdDET4NBlbTyxVjfN0XCC26ENV19I5
         m2A09UivKLj3m10GV1B1x/4atCM3xIY1wXsC+xFbNuQEbpDJKyh4ftcoXeTLHoeoWL3s
         gqgxnahLJElXxaBwOIUhPjQJUdsQFjCRzrUvq73vgaeB/0H/IcYJkqNXOOssJLNaxztB
         s5K+8tdqJ49oSHEtEps1DRp5G+ykUYqezcCPBPgkphM/XMi9jqnT2K42RgcjXucqvBIB
         lIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8dIQQ1jGk/JSbhDIRo5fJZIb6F6XefN52I04Ha+l9F8R7FA99qtHzpvABdtaPlLER/tPg9shY+zujew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPotHdPkbsm7RsuLyAMTo59WYnHg1CzxL9+GSX0XPSQDtcxOyd
	VKuizs8g+z1a6Q1wjJZO8rh2W5ndj197z0diTcCaq7blWv25GTJ6
X-Gm-Gg: ASbGncvOD1I5ZGAp6oBVqPjeGSUVd1URNhMWY8d56Vr1jJcNQ7u4QB3MzO8V8Oo8lF5
	LdDyVLicfsOIC22nx82gCTWkyHJfG9vJ+/7HVGbZzCduviLTSJFjr4yV4+S3nlTQGmFMEsS+hyr
	oMdh8WdNo6GdpQ6fc1BRWtrJIl0MN/s9OcXKTRsdgfw6FVd6uB2IH6h8QsCO8HHAlJXazUS+cKA
	OI72+9llqsIwUtEnyU1Xab7/IzkUoAeQ/Ip/SWa8JhNRF2O3yPVOwDs0t7uRtjXLXl9ovZ4znri
	A5Nk6JX/xP9AiEYcbWQ0EbuqyvVeSQ5UtzHK1eoMJz+DsxXV6KayYa8qNNDYTtVfvW3cRJ2ps1F
	VFUAev/mv+UVJRqMiIVbOMoHKxAeM5W6n2Wz83ITNpQ==
X-Google-Smtp-Source: AGHT+IHrZFOinDSrmWi4+m1t5sYEIk52JDxPafuRYroaeZUSAqukvpFIFZVBSIhGoAPxRg+hZKGI9Q==
X-Received: by 2002:a5d:59a3:0:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-390cc631b55mr9933881f8f.36.1740616837065;
        Wed, 26 Feb 2025 16:40:37 -0800 (PST)
Received: from [26.26.26.1] (ec2-63-176-201-248.eu-central-1.compute.amazonaws.com. [63.176.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e46f580bsm402728f8f.0.2025.02.26.16.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:40:35 -0800 (PST)
Message-ID: <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>
Date: Thu, 27 Feb 2025 08:40:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Jason Gunthorpe <jgg@ziepe.ca>, Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Yunhui Cui
 <cuiyunhui@bytedance.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
 <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
 <20250226130423.GF5011@ziepe.ca>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250226130423.GF5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/26/2025 9:04 PM, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
>>> Provided the system does not respond to those events when this function
>>> is called, it's fine to remove the lock.
>> I agree.
> I think it is running the destruction of the iommu far too late in the
> process. IMHO it should be done after all the drivers have been
> shutdown, before the CPUs go single threaded.

Hmm... so far it is fine, the iommu_shutdown only has a little work to
do, disable the translation, the PMR disabling is just backward compatible,
was deprecated already. if we move it to one position where all CPUs are
cycling, we don't know what kind of user-land tasks left there (i.e. reboot -f
case), it would be hard to full-fill the requirement of Intel VT-d, no ongoing
transaction there on hardware when issue the translation disabling command.

Of course, once you have clear motivation to re-position it. we would like
to work on it.

Thanks,
Ethan

>
> Jason
>

