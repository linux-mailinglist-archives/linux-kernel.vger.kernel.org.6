Return-Path: <linux-kernel+bounces-380102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140369AE8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459FA1C209EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2A1F5825;
	Thu, 24 Oct 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0mVq7YV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993181E261F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780318; cv=none; b=lLRlNOjK1G2vejTDJ49CNM0RlMQFbMSlZs8yw8m4oFQ5T+cwW5oi4lbwLfNY5gFQc05eeqMnS0fqkDm1azaa0eLDw/ZqSZUjdzeXMM8caB6bwMqt7YvgquzdfhLv7SfRIboUSwKVYq5UnBUHIP+adyCccL/b5yk8cKwdKB0azRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780318; c=relaxed/simple;
	bh=xad9qDTJ77uXZmffW6CAN7OyU5XpNOihDHJ7RvRFEZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPYS6j6D+qCEY0j5kSVLu5/0bbRugmOZUmyK9h2GABabS+Hio7fVmL1ubbDjOwdt/mFFBrBHiibKjd8q7FLymEHiDQX9Qgk/81iESFRaFKDAUxEtMLEE8BuAYkYyVLNiC7ngszJqNmQ7o0S3ZHMILB0rYvSS5FXYQIVFW+yVhVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0mVq7YV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729780315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jR+VwXj6YZP0qk74Xd3gIPDpX5LBmmYd7HXdnCBtZXQ=;
	b=Q0mVq7YVF/DnB3tGt0mWq1vCkZjGOszjfiuL0dNzDgLVRelTtHTJ/ipbL+Q8Dsz5SKuMW0
	1KKp5j5JIUsh3cx28jCcIWEc8xwGHBe+7aTnKR1NuRkIbsjjXhYoFL3ZNLR6d5vf6k2J2p
	PNrOfQpUMkJ6AJX8yK+eR4mGn4r8a3U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-PFFDxnwPMC2nlD_3sPKH4w-1; Thu, 24 Oct 2024 10:31:54 -0400
X-MC-Unique: PFFDxnwPMC2nlD_3sPKH4w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c95b1771a1so309849a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780312; x=1730385112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jR+VwXj6YZP0qk74Xd3gIPDpX5LBmmYd7HXdnCBtZXQ=;
        b=dGXu+T2jBSO3jQqSTWhaLKoTVwSphqRLljz1TsHbApbWwTxUqY2PQ0kUM/jec7iZfN
         toclPhASCWRPhcJ31dkp74llExIw4TKHj4FId1UdH+EsMUhl6hDoQZiGJzBX7PRULd5Y
         Kh6qAUCJJkXvxCx3S3SrnEZr6gawLjVqasdo78niq1RwX4owazIrilq6gDgGvhSuH3Rx
         TV45QP8OUh2bVRDwKCgove5MJyzLNYvIQ9eEIo6UgkeG9ATObbw56CvKPxO1Q8Ew5272
         EyevjA8YjEVgRYcaVzhB598db3nOg+8FkrhPAA6R0VFEsBlqVkpPaijKKRDOOl1ONuFe
         kNdw==
X-Forwarded-Encrypted: i=1; AJvYcCUV5RoTXQ8ytuzKhYlvfVEtgqJhku1rADvcDF4XOkRklmYWo2ioT5aFbL138SvJQ4u3F0pWfMfgVmWShI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkx9/+Bufz1RuBH42GXqV0FO148K/Ro67rZa21/Dj942M0ZMIP
	MgVCgMfNR5NT6IAX2tlIu0yIUe1nPq7/ihoD6mRm1Rm8jFuICdbZw/eUESBxj3Mg8l1PMlLuh+H
	4R9JgGnpqyON8PrUELho+JJwenkTt9VE5YwNRNzQ69vPXHgvnFYguwZp98ZMbmw==
X-Received: by 2002:a05:6402:2685:b0:5cb:6841:ede5 with SMTP id 4fb4d7f45d1cf-5cb8b267f63mr7961945a12.28.1729780312406;
        Thu, 24 Oct 2024 07:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExWL5QkywW9E3UW9axkod4Rwc4fsE2dLlLJp7ky3B58bsU0/9/2KoD9McnXVsWHisgySoyMQ==
X-Received: by 2002:a05:6402:2685:b0:5cb:6841:ede5 with SMTP id 4fb4d7f45d1cf-5cb8b267f63mr7961911a12.28.1729780311940;
        Thu, 24 Oct 2024 07:31:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b556sm5714708a12.63.2024.10.24.07.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:31:51 -0700 (PDT)
Message-ID: <0f2b58a6-7454-4579-9d20-be62de62573e@redhat.com>
Date: Thu, 24 Oct 2024 16:31:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 1/3] net/udp: Add a new struct for hash2 slot
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241018114535.35712-1-lulie@linux.alibaba.com>
 <20241018114535.35712-2-lulie@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241018114535.35712-2-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 13:45, Philo Lu wrote:
> @@ -3438,16 +3436,17 @@ void __init udp_table_init(struct udp_table *table, const char *name)
>  					      UDP_HTABLE_SIZE_MIN,
>  					      UDP_HTABLE_SIZE_MAX);
>  
> -	table->hash2 = table->hash + (table->mask + 1);
> +	table->hash2 = (void *)(table->hash + (table->mask + 1));
>  	for (i = 0; i <= table->mask; i++) {
>  		INIT_HLIST_HEAD(&table->hash[i].head);
>  		table->hash[i].count = 0;
>  		spin_lock_init(&table->hash[i].lock);
>  	}
>  	for (i = 0; i <= table->mask; i++) {
> -		INIT_HLIST_HEAD(&table->hash2[i].head);
> -		table->hash2[i].count = 0;
> -		spin_lock_init(&table->hash2[i].lock);
> +		INIT_HLIST_HEAD(&table->hash2[i].hslot.head);
> +		table->hash2[i].hslot.count = 0;
> +		spin_lock_init(&table->hash2[i].hslot.lock);
> +		table->hash2[i].hash4_cnt = 0;

Does not build for CONFIG_BASE_SMALL=y kernels. You need to put all the
hash4_cnt access under compiler guards.

Cheers,

Paolo


