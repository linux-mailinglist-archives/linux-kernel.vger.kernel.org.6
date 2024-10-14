Return-Path: <linux-kernel+bounces-363764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966999C6B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914971C221EC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022215B966;
	Mon, 14 Oct 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwFUZOui"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF115AAB6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900433; cv=none; b=a8wlRxWVnRopMMHeAIztM9yoMsOjGe8dSv8k9tf05NjgovvY/N1q8RgLi9fddnAiNq3ayF6hTj67dp/iSszLsqx98DmTL51q591v9v/bpVFr12PXrTGW5NG8mVGsiEFM21T037gc5FbYLq9EFGEFd4UmOSsMt5OgUjF+LK76U4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900433; c=relaxed/simple;
	bh=AOYO1nqfzd2p/2L5E1KCttOr9dkTX6WpAatNEmQdtsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrF4B7lEovuDI1zNSlEvWGtXq79hjDax99js2Qgk9+kbg69ecYwitwZzDD7hPCwOORRhvYMsMwAunlK95vr9DUYS13xDqHIb0nfNR1+o4dZ5AugV8xQ9DmD2bsEHZGnJlnciDfDwLv2ypSG4uFMxpKZTFJd+3P5AZ4cw2aVT4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwFUZOui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728900429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Hb1WOmt9pWbQnwO9cKQur9sRAYIE4GJQUsNXDee6uU=;
	b=UwFUZOuiyszrndNqp6cgl/faGhIYl8cUdN0y6oTnVH9W4tTVY5ScCEtB5BDyzxC0efRpyO
	qKlMvLVesyvO4YuMt56b0R5SZQpWuJCifmbYuCnIOHtFFqukYPyfI57lhuIjC8l/3g69ai
	S9PvwLpm7HEEPaZuWTvF/89GU98VIm4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-_OebBGpNMD6wC3kY_uBBEQ-1; Mon, 14 Oct 2024 06:07:08 -0400
X-MC-Unique: _OebBGpNMD6wC3kY_uBBEQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43057c9b32bso27126745e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900427; x=1729505227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hb1WOmt9pWbQnwO9cKQur9sRAYIE4GJQUsNXDee6uU=;
        b=XXCd0esDQKMaOfm82/TygbVwrvPa3a5KBq/oVN6htuA2xsBMHwpigaoDhYqrlOHRQc
         x4fwP8QeoW9Q7gvaOii9GpUaGBb1RvyuHX5J6lMEKUajipa5sihq7tu8VHx+tSHFUG3d
         yF7hXjfpWRm/VNnIUTIc5FuNeRf7YN7inzVFxDBKKLDxnDXfOlptgu4VDvyn8sszE/6d
         GELKsYuppjvrMPu5SrSnNUhKvZ+od73/614ZCA1J7mJM9IjRcQjGBEhMSfR1t000QA8U
         TdMCW4kKPDpY7pnviHp7+vFlxDw24VomYQZ0Vymk7uAxtFZZ2Jev2d+sIhu7y0PRpI9+
         rAlA==
X-Forwarded-Encrypted: i=1; AJvYcCX7f76WJ36H0okLcgYW79WAuZpHI6wExGc5j/fLwinIz8/A2mIOjH4FctHuGwQbaqudRy5m6hrS+kAU2gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRXDBx25dVwEuv7/J7ZUgIeC4HnMcpOY+7ZWWvt67E5SHmD8M
	To6+nqLJtUZBZi94T2AGlc/085OK2BvrgRRQSmd925mCK9IiMtd08Zo0mI6bo2KIW4RuQnpMS8E
	Yb7JzevgRadQ7m/HANMCKjCi3xoD7nQluf+VIeYv06sze4GXDVIwdpVIzEYR2iQ==
X-Received: by 2002:a05:600c:358d:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4311df4236cmr95037455e9.25.1728900427293;
        Mon, 14 Oct 2024 03:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnwz8f2/PXCxuw1/TLZrYV1OXlFfmOwRpeB2gJl2AKxapYVqep+3JW9vo8ox2OTpXkBBxMhw==
X-Received: by 2002:a05:600c:358d:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4311df4236cmr95037155e9.25.1728900426901;
        Mon, 14 Oct 2024 03:07:06 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43118305ab8sm116309275e9.21.2024.10.14.03.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 03:07:06 -0700 (PDT)
Message-ID: <9d611cbc-3728-463d-ba8a-5732e28b8cf4@redhat.com>
Date: Mon, 14 Oct 2024 12:07:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 2/3] net/udp: Add 4-tuple hash list basis
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241012012918.70888-1-lulie@linux.alibaba.com>
 <20241012012918.70888-3-lulie@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241012012918.70888-3-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/12/24 03:29, Philo Lu wrote:
> @@ -3480,13 +3486,14 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
>   	if (!udptable)
>   		goto out;
>   
> -	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
> +	slot_size = 2 * sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
>   	udptable->hash = vmalloc_huge(hash_entries * slot_size,
>   				      GFP_KERNEL_ACCOUNT);

I'm sorry for the late feedback.

I think it would be better to make the hash4 infra a no op (no lookup, 
no additional memory used) for CONFIG_BASE_SMALL=y builds.

It would be great if you could please share some benchmark showing the 
raw max receive PPS performances for unconnected sockets, with and 
without this series applied, to ensure this does not cause any real 
regression for such workloads.

Thanks,

Paolo


