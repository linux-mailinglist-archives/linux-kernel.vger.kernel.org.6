Return-Path: <linux-kernel+bounces-555735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC72A5BC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830741729D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435B22C35C;
	Tue, 11 Mar 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpIfQsS8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F1226177
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685118; cv=none; b=IbnuwU1jU8/VooP3cO4X2t6fClhWuRspp2SjSmiKr8NBC6tzFOP2kpZ0dnYQ8zBdqQ5aGqiErUZ0h/vZglTtWaOz+UaL8vVlRvdtHV5Oc5CIUoHgEmjKZztPtJLVhxfsfktgv+txI+ojp5M/NvLj/bA+JFd0uVxXthSBCixMEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685118; c=relaxed/simple;
	bh=AqhQEZMgKAb1ifuwL1FBr3WdjgDEuno+K3aftA8cbus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ku94GCxiPseUHr0weBqK3v1IEBPJi6SykFeLBKpVDi+4INDofQl+ga9QcC5jFBKVDT2S4FgJvJkJhdFdgrDmm2nA8nxymSu+n1zX5hQzLWEoI6dbzNRFUWqeqLK+W1EXTa7GZgTxHA61mqUQoiNSngeyoUlSWVUZMZG5M3wE9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpIfQsS8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741685114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/SZDq6Z6N3N3ep/tmjky/rB67JOIGO9Ha7z2u/VzHQ=;
	b=IpIfQsS8OT4HRyZ0BXLFyHZZ44F5pPl6nDBLvjdwzyLb8cqjabuNgf6DBEsCrFIplB/I5J
	IsUsXjuW0IovArhUC4And8GdD7g8P8mup2SZRTWwM1qPgBBKKzjl33kaN4wFXJR/4IJRdn
	kEA1IpTm+NI5TKCWIfLTMfcCcz97QTQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-s50oRPMBNx-Qp7aL0eGyxQ-1; Tue, 11 Mar 2025 05:25:12 -0400
X-MC-Unique: s50oRPMBNx-Qp7aL0eGyxQ-1
X-Mimecast-MFC-AGG-ID: s50oRPMBNx-Qp7aL0eGyxQ_1741685111
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf446681cso11364785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685111; x=1742289911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/SZDq6Z6N3N3ep/tmjky/rB67JOIGO9Ha7z2u/VzHQ=;
        b=Uaj1UBBFl8g9pK/4zLNqf1CzAHscOhIgQ0O4cWNFgAiSQW2cStVQB50KdPMqUXZxwn
         rtmGHk8mNCQ9uB2DN9nf6x/bFczyzcLfFa4TgRrx3BX583XODAQCQMWWtFcYW7g31sAk
         m+yAQIMOM/ZGEBUL+P2cPmldteNAFlw5/hP9GYxIJtErLePvk/3+Zvq7yAmcHjr+njRE
         rRlFKWOG1M328nggI9WInsOrLcjyvqrs6GBL8Ks3kShd0R6ptAspn06LelbWoCIYprfj
         laSTcPeSpEw6f+V7PXtoshUhVEidMgQ7vu4QtPiBwmlm2nDKV3WOHqzLOFCL1fVINNPK
         /2lg==
X-Forwarded-Encrypted: i=1; AJvYcCVbIVwnihbuIm/rkUPaNh+SsRqod3BN/BdLxqflfXRTvRXDOycnD2f5UvWvYkbO1zFkwk1nBW4qKnJikOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhpn2KJKtBXtkaCv6pNR5WSl+Gy6S8E25DVeuDvaJ1qg4GPzD0
	dbyVwUAh5zI6zRDtdI0SpUFi4iVFR6PmHrMwjbKc/PWEDlyg45TSq60M7R7yNN4bKT9BBagNOmt
	2QwwL4NMkUsDvVuMHmHSeycqv7wrf9v3gDOsi8+FY19YBkDk2VFSKjsr/bgREOQ==
X-Gm-Gg: ASbGncul4GMLmXnxy0Wt485oMUl5+7TwdI3bCTWpeqFrwT8a3Wz/KRogkg3CLZTKIZq
	ZcrPAapbhc6HXq7+1CVVTVKZQ8l4adDEODl5Kpb7sOSElGtVh3xMyfXuTDA0ga5eI/KvKSJhoEy
	YPTe0eM6zK/f/xS6x4tSaUGGlr4WrFgVFoPVukHe+nkrQGMQoeZQOYB8YDvKrH+bxb2EfNOOJii
	E4HSdi45HJaskRjqmImP1rfrp3aClxRZtfxR69TDs1qxAVrAbFFRJ3uVrLtZ3PPsVYxgbVXmyEt
	/WiQ94ZSFaZUFEka+nLLhSM9g9tPW/UPBqKsnA/T3euF+w==
X-Received: by 2002:a05:600c:510e:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-43d068397bemr9363295e9.15.1741685111361;
        Tue, 11 Mar 2025 02:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqZDh76W9UzPli/AM+ArV3FiA6G6KprrtJ2Fr44sE+79dvvLKGAWbiOxHsNDTPh/JHiULugQ==
X-Received: by 2002:a05:600c:510e:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-43d068397bemr9362935e9.15.1741685111020;
        Tue, 11 Mar 2025 02:25:11 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfb16sm17334070f8f.29.2025.03.11.02.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:25:10 -0700 (PDT)
Message-ID: <978a9d2c-b82c-4209-ba95-8674b149294a@redhat.com>
Date: Tue, 11 Mar 2025 10:25:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] enic:enable 32, 64 byte cqes and get max
 rx/tx ring size from hw
To: Simon Horman <horms@kernel.org>, satishkh@cisco.com
Cc: Christian Benvenuti <benve@cisco.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>
References: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
 <20250306145604.GB3666230@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250306145604.GB3666230@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 3:56 PM, Simon Horman wrote:
> On Tue, Mar 04, 2025 at 07:56:36PM -0500, Satish Kharat via B4 Relay wrote:
>> This series enables using the max rx and tx ring sizes read from hw.
>> For newer hw that can be up to 16k entries. This requires bigger
>> completion entries for rx queues. This series enables the use of the
>> 32 and 64 byte completion queues entries for enic rx queues on
>> supported hw versions. This is in addition to the exiting (default)
>> 16 byte rx cqes.
>>
>> Signed-off-by: Satish Kharat <satishkh@cisco.com>
>> ---
>> Changes in v2:
>> - Added net-next to the subject line.
>> - Removed inlines from function defs in .c file.
>> - Fixed function local variable style issues.
>> - Added couple of helper functions to common code.
>> - Fixed checkpatch errors and warnings.
>> - Link to v1: https://lore.kernel.org/r/20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com
>>
>> ---
>> Satish Kharat (8):
>>       enic: Move function from header file to c file
>>       enic: enic rq code reorg
>>       enic: enic rq extended cq defines
>>       enic: enable rq extended cq support
>>       enic : remove unused function cq_enet_wq_desc_dec
>>       enic : added enic_wq.c and enic_wq.h
>>       enic : cleanup of enic wq request completion path
>>       enic : get max rq & wq entries supported by hw, 16K queues
> 
> nit: please consistently use "enic: " as the subject prefix for
>      the cover-letter and all patches in this patch-set.

Since it looks otherwise good to me, I'll adjust the above while
applying the patches.

Thanks,

Paolo


