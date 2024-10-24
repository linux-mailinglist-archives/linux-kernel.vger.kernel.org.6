Return-Path: <linux-kernel+bounces-380108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D49AE907
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEF01F21A21
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302F1E1311;
	Thu, 24 Oct 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFT3TZSW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD67CF16
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780704; cv=none; b=qBnJdWRVURjLyYj9kEoSMfZzt/JkJpam1iIS3rlGG1PDe8yxPujD69vcHPR1aKyax0+RFTvwA3LSyWg9fyifo/T3/VQ53XL9UOqEuu4vPA9xIq42dZlgaP/c6n+R4i2ZW7emPGrjihJ4LPsa/0NZ7W8m63rHZK8ZUHG9io5StyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780704; c=relaxed/simple;
	bh=VGq51NbjtrkGHL0P4GCk0DS1j7YOZJgVLdNTlhfQ8Yc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g4PKKu4XpaX34PcnRknmwBLzEswWwCP604hkyBz+s5flbYp5fi+2d3o0Qsk/FFEUxlvFTJQhAbGPLGxERTIaXkGFnZqph3zYFs5Elwq9x47ay7n2zK9IhdayqCkfw85Nc/r7xyTiwL84RvTY1Jwx7ImcO2w9VmkVk6Y9pavfOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFT3TZSW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729780701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmRLcEPOgBlNHa74OohKvYIj1c8ltGNbfHoL/vZIev8=;
	b=DFT3TZSW2/PViHBLa4tehh3wACvkKqWY+WtVFt8Qnq7by9dtD5/V9O8XUanFIdOZd5N8bS
	VVMnTEegnx4NfJVcmN/pNtIJ9ISCwH3p/gchd3IJcXPvpAQFhkCkIIowgUP6D+GST6bdFb
	x+0dtorHFc295xw8eiLQzQ/m/o8TVO4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-z8gyBTLsPvSWLF_WwypJOg-1; Thu, 24 Oct 2024 10:38:20 -0400
X-MC-Unique: z8gyBTLsPvSWLF_WwypJOg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d537292d7so732957f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780699; x=1730385499;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmRLcEPOgBlNHa74OohKvYIj1c8ltGNbfHoL/vZIev8=;
        b=aslYq2nhgzcbG4zjz9slB5MhKCSdyNffb6WLv9FLsMxbfYxilIRZD1lMLeRQQm9UH0
         2SVHmhoWYshO2UsU/fwPz1K2x12jjJCi16A5ROHD3eKZEwaGAAvKP+a/Egi29KPQ4DJk
         EyVIaz4OTem/kuUTwWbZygCPc9I5vzo7CR+A0h7cDcp6RWTE6NreAJcraz4wqqopITDH
         XbkdeNSTWedftwsAgRzFsn8tyIb/0xaJFsChUFcLV9TBpQRUE77oke8KUhYP1fCmx4Om
         JDV7vfUQnngovI9h1cWlxrBp3/7roPBSBBuajJ6IMxR2f350KG8QKX0SVn/t70KhM1EV
         VEdw==
X-Forwarded-Encrypted: i=1; AJvYcCUBNQQJs9BxznbI2jpO9+DuGjCgcFrq/ruufomXLc3sYgsV1iHEoL046blxV5JDNGr0R4YPqXHZTE/zrbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkQOLEIDK+E6l6ocIk+ldCl8fw46HwX0EmWEC91WES6WG3ETv
	mstvrKNc8knpmxxAKnd8ErqZS5QgeMlPEt8071CD7oIdMF1Axo69gGP0KB6GkTXN9U7USI1niIb
	0kjyVJ4S8eOADYL2ZfcsRY/VOLd1ddWaHyPalJG71Pvb8GID4986I8wYgnJ3ODQ==
X-Received: by 2002:a5d:5051:0:b0:37d:4c40:699 with SMTP id ffacd0b85a97d-37efcee5a1cmr5354883f8f.5.1729780699317;
        Thu, 24 Oct 2024 07:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoGTa2pYNQczqU2Q3MTNZk1MGtsBjDiOP2Dll3M934odinWvR+fupYrebxC7KsJQY62poFBQ==
X-Received: by 2002:a5d:5051:0:b0:37d:4c40:699 with SMTP id ffacd0b85a97d-37efcee5a1cmr5354862f8f.5.1729780698987;
        Thu, 24 Oct 2024 07:38:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a587f4sm11546175f8f.52.2024.10.24.07.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:38:18 -0700 (PDT)
Message-ID: <ecacf1f2-48e0-4132-bbce-1be9fffc2798@redhat.com>
Date: Thu, 24 Oct 2024 16:38:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 1/3] net/udp: Add a new struct for hash2 slot
From: Paolo Abeni <pabeni@redhat.com>
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241018114535.35712-1-lulie@linux.alibaba.com>
 <20241018114535.35712-2-lulie@linux.alibaba.com>
 <0f2b58a6-7454-4579-9d20-be62de62573e@redhat.com>
Content-Language: en-US
In-Reply-To: <0f2b58a6-7454-4579-9d20-be62de62573e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/24/24 16:31, Paolo Abeni wrote:
> On 10/18/24 13:45, Philo Lu wrote:
>> @@ -3438,16 +3436,17 @@ void __init udp_table_init(struct udp_table *table, const char *name)
>>  					      UDP_HTABLE_SIZE_MIN,
>>  					      UDP_HTABLE_SIZE_MAX);
>>  
>> -	table->hash2 = table->hash + (table->mask + 1);
>> +	table->hash2 = (void *)(table->hash + (table->mask + 1));
>>  	for (i = 0; i <= table->mask; i++) {
>>  		INIT_HLIST_HEAD(&table->hash[i].head);
>>  		table->hash[i].count = 0;
>>  		spin_lock_init(&table->hash[i].lock);
>>  	}
>>  	for (i = 0; i <= table->mask; i++) {
>> -		INIT_HLIST_HEAD(&table->hash2[i].head);
>> -		table->hash2[i].count = 0;
>> -		spin_lock_init(&table->hash2[i].lock);
>> +		INIT_HLIST_HEAD(&table->hash2[i].hslot.head);
>> +		table->hash2[i].hslot.count = 0;
>> +		spin_lock_init(&table->hash2[i].hslot.lock);
>> +		table->hash2[i].hash4_cnt = 0;
> 
> Does not build for CONFIG_BASE_SMALL=y kernels. You need to put all the
> hash4_cnt access under compiler guards.

I see now it's fixed in the next patch, but it's not good enough: we
want to preserve bisectability. You should introduce
udp_table_hash4_init() in this patch.

Thanks,

Paolo


