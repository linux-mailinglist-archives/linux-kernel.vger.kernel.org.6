Return-Path: <linux-kernel+bounces-513262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D239A34636
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476017A1FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACDF187550;
	Thu, 13 Feb 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQr0BAOQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8B26B0B9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460210; cv=none; b=WksoF3I3Zj3EzwWSxKx8+KEdg7HUPD1rbSpPDGvDGo3saD8k8/0mqP1riDLLDbhCQM7SKTEk5LmmBoHUezFsokD275I9BWiL3URc3H4n481e6yDiBVC4erbiRJZ2JA51sywRm0RqVCeCAieyzbdoxw2p6l/MOoPTXyetn8kBoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460210; c=relaxed/simple;
	bh=nnr4AHIDTiSh+ro1sSaSryEfSwd5H8ZFo1YEnu+rzI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1sKYSEBSH8IIfAkAfBz24dE+O7mAhaF6mmmoDTWxchzbF0i6mb1e+rhGXx0W8gd76mir5o2ylgVMuVBVkfovsSWPBFUyPrXFo72XPoTMYfix/6x53CSiPDqImj79TTrgEQ5tpo9CNWnzVzkVmctjOJfhvPLPzJiPntFyfk7Tqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQr0BAOQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739460208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JRSwFTLcKJvaGUhd7mNWEaWNfTd1j4s92cCD0xMuMs=;
	b=IQr0BAOQK0Ld4jk01ZeFd0gjVK8R9JcmvXcx5nPA7IRxBDUTEDIuFbc4qeCE4Xxvb8Jm+O
	AVcgBVV4IAxSZRBM1ehC1ZKRVbz6gcHkfoIBjBzLUVv2xOiAqq+1cZGnl4N1NJ4hk4uECm
	egv/+i60+MxA8BllyE74T50lrQyPunU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-4c-wAfd3PtSQtmrZbYVnKA-1; Thu, 13 Feb 2025 10:23:26 -0500
X-MC-Unique: 4c-wAfd3PtSQtmrZbYVnKA-1
X-Mimecast-MFC-AGG-ID: 4c-wAfd3PtSQtmrZbYVnKA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393e873962so5163115e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460204; x=1740065004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/JRSwFTLcKJvaGUhd7mNWEaWNfTd1j4s92cCD0xMuMs=;
        b=hkoweq2Oo38W+pEcHzsIKnnd/uAO9YclfBZcEO2oyQi3uXFwJSZSlNmkJpDK3utC0g
         SuMVMUo7g5i8+UXfw1XxT+3HTNMCQ0ELDfk1vVo5NRxXp8Ik0CWSJ5+FoBCMkKGE9RdC
         w+J/VscZDuJmz1ZnZla3IpimKW08Lmq6VXV0x9xRv69sIDymx06xXvqWfs6Z1YxYoQBz
         jb3nZai6+cXD/N3vSETGfS/v+Q3pvATjAk6Pwa0yVSlE+ZJjNbLsQCuzUufJunBMF5IA
         K2s2HvIguo+9cDDQBWbUQ/swBDjFevrRxGc7/EtQJT0Sm8CxucQ+FhUKq50y79rassmp
         E7MA==
X-Forwarded-Encrypted: i=1; AJvYcCV/w7I7gePBvxyL4LTG4WN80Mlypd6F5ydkFHTYf2//4HqANbqNsWwA9pOPWhOyCYm71qNvw0cl6SMLMwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9nx5zfsRJcj3QGSpZIsCS3BLqIki8YBG5TzcMGXZcmoGqa7S
	i14FEz+iGRYXBBVpleOvOUP6cb53VsLALUj4xzn2OcACdAyE06877YjXyIc4TkJUvkcF1mXBKDa
	V9XbEf+xxoQU42SpibBl7fcPeSjnybVh24kPHbC6uXUn6dP9upIDOoPg/BzS7sA==
X-Gm-Gg: ASbGnctjrmLAlmI2qT6sodRLQSpbSYYvBsxjM3dglEDpLTN3rUW1Snmfwyb8NSkOJ+H
	46ZidnhKyzR6pVUwOZOoOFue+e8+RM09IHBHlWHee3St1TsBiBAbPOCztmg59eEKvUV3s7Twi1T
	FuivsK4W1Ywq/J+C3ZT1LGuEBPzaTD8ONTj2+21Fljt2FdF8Ft+u7jYVhLA12c6BizPFI0ojVoP
	3fR+RuUk3DA9nvTvhXXKMuARnHxPRSnzQDlrYUnJD3Uhhnr5glaXPRkidxlNRld1KhdcpZxSzWZ
	+ZgNfLAgtL6KVF3F8DHXw9I7lxS/TKV8uSE=
X-Received: by 2002:a05:600c:3485:b0:439:4a1f:cf8b with SMTP id 5b1f17b1804b1-439600fd7dfmr54743655e9.0.1739460204566;
        Thu, 13 Feb 2025 07:23:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGymZURXlriQ+0kCVr74FRJDVtnnFD1vedc8hYAtNzuqdxLQ8CZrwzTUv5N0m6aIs3OGJqbiw==
X-Received: by 2002:a05:600c:3485:b0:439:4a1f:cf8b with SMTP id 5b1f17b1804b1-439600fd7dfmr54743035e9.0.1739460204161;
        Thu, 13 Feb 2025 07:23:24 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5655sm2157953f8f.77.2025.02.13.07.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:23:23 -0800 (PST)
Message-ID: <6032f70f-4609-46d7-bbfa-c29a63f402ec@redhat.com>
Date: Thu, 13 Feb 2025 16:23:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ethernet: mediatek: add EEE support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20250210125246.1950142-1-dqfext@gmail.com>
 <a42ec2d4-2e4f-4d1d-b204-b637c1106690@redhat.com>
 <Z623GQHI_FHyDyjE@shell.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z623GQHI_FHyDyjE@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 10:10 AM, Russell King (Oracle) wrote:
> On Thu, Feb 13, 2025 at 10:04:50AM +0100, Paolo Abeni wrote:
>> On 2/10/25 1:52 PM, Qingfang Deng wrote:
>>> Add EEE support to MediaTek SoC Ethernet. The register fields are
>>> similar to the ones in MT7531, except that the LPI threshold is in
>>> milliseconds.
>>>
>>> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
>>
>> @Felix, @Sean, @Lorenzo: could you please have a look?
> 
> That would be a waste of time, because it's implementing the "old way"
> including using phy_init_eee() which Andrew wants to get rid of. It
> should be using phylink's EEE management.
> 
> The patches for the mt753x driver converting that over have now been
> apparently merged last night according to patchwork into net-next, but
> something's gone wrong because there's no updates to the git trees
> on korg,

this series:

https://lore.kernel.org/all/Z6nWujbjxlkzK_3P@shell.armlinux.org.uk/

is in net-next commit 443b5ca4d7245eec9a9192461113a4c341e441e5.

In the past few days there has been a few slowdowns in the kernel infra.
Perhaps some mirror or cache not updated?

Cheers,

Paolo


