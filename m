Return-Path: <linux-kernel+bounces-357277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86A4996EDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C441F21695
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1019DFA5;
	Wed,  9 Oct 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPKBd4uN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7841A0BE3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485730; cv=none; b=fJn/Jha5GnKDPAdaccGwAzNIPNypfpWwLGRKEegsjvI5KnUneQlGehEHb7fH1SY1Keb8KgGm+dZapwmFVoypArDLt95hWFGyHWGDFwxDb1ARFzanmHD4qAXE7GLqkExVXCn9Sng9Rwa9ExyzMIL3048tw/2A7ddBiptj3sCfCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485730; c=relaxed/simple;
	bh=JJjBSLsJM0MtkjToBksCvCNTou91yqQ/NQj32mNHgr4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JC7MTJU3qFaPZiuYrXpS44V74DOFx9aZuk2lqKtcTrzNdXxGN5QJ7nIVWegBLcpXhcUp0p0qCHqCowDDxRDmqElFQM9CgnbR/YMO4UnlSQfZAppmS9dsi321XdkyDcybClUuf+STiiyUBczVmKY2KB9suUJ2OcrEgKpwGnUAKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPKBd4uN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728485728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr2GmdWLUrJakLB0PoxbR7hJosmYg4HJLWejQbVI9dM=;
	b=GPKBd4uN1tUnK1Fb59kp8TXMsSyPEj7vjYvpwiw6CQM3imAmDDtztse2q7jM/NJ37gxwqf
	5Lx4vmekOfFIxWL2HAmNDdZnRPsKs1IxAimTfz6PiCXbFHGk2k4Yqt3ltw+vA6KU2v13AV
	ZhOraAqyzbr9WXDBRnzFCc2DpRAlLb0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-oWShhDmIOMOMk5WbPKp00w-1; Wed, 09 Oct 2024 10:55:26 -0400
X-MC-Unique: oWShhDmIOMOMk5WbPKp00w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a9af65cf73so656716385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485726; x=1729090526;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr2GmdWLUrJakLB0PoxbR7hJosmYg4HJLWejQbVI9dM=;
        b=WhhvW7juIWLxRzyjbAdznzLhutqY3HBT3hIXoLf7pvQzU5gfUZoxg9r6BbwvPs+uGN
         vRmscnMQEy3GzfkMrey48uLaDhD1fWZSatir3Sg679lXnDArnB6hlA2xkzBkbqnhFus1
         CZInLa0+p5pUubl4sogbCvLv8GDo3n/4F78Y2KDpOIx8LP+dHB2q4x2CKue6GsKZi/dl
         xEBD0Ckr/7/5VfczjHmsA10t6I9hxbIddW4arbTU4lCZej9ZhWDGIqdXKb/0h3KmtSJo
         tOiaeI6etR0Ju1fWZD/thm/m+pNUkyrfGM9Rpzs6VSmF6gm6+3vk0DRGDBgwvZduSrUH
         /P2g==
X-Forwarded-Encrypted: i=1; AJvYcCWqcKCGxYk/EdxyecuKtZ+zUhB92W1DYVaTzYdVgKL/n785uqf47cFTrS25OpJGf9hald/Yl1TmMa836MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQZadkCfbKQdIlSDTVryXlNXUyYwV7nAdanVGGZyvJUUnh0lG2
	kuF/8x4pdgznoIvg7Jo9oHlVjLqjpTVWEKEgHB+IdiT3r1zjZ6QpbbyvaweKXtBiCWAtymqELwE
	XwldyTeZx0qNy2ouEHdNOqHxntfBfAXRFQ/SzIvZQ5cEsWdesW9PPRinQXuwhcw==
X-Received: by 2002:a05:620a:471f:b0:7a9:ad65:f4a1 with SMTP id af79cd13be357-7b0795463ffmr334963685a.26.1728485726422;
        Wed, 09 Oct 2024 07:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmLDIV4eES9P+2ALaZiNFeGwuiPNW/l76dYT0Ylk2417i7g8oP+Vojxlobhj8QL3eJPwVZWA==
X-Received: by 2002:a05:620a:471f:b0:7a9:ad65:f4a1 with SMTP id af79cd13be357-7b0795463ffmr334960885a.26.1728485725990;
        Wed, 09 Oct 2024 07:55:25 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae757627fdsm459735085a.100.2024.10.09.07.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 07:55:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <39c0a1bf-ce23-4905-a014-0a9ba0dc24c8@redhat.com>
Date: Wed, 9 Oct 2024 10:55:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] lib/union_find: Add EXPORT_SYMBOL() for uf_find()
 and uf_union()
To: Kuan-Wei Chiu <visitorckw@gmail.com>, xavier_qy@163.com,
 lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <20241007152833.2282199-2-visitorckw@gmail.com>
Content-Language: en-US
In-Reply-To: <20241007152833.2282199-2-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 11:28 AM, Kuan-Wei Chiu wrote:
> Add EXPORT_SYMBOL() for the uf_find() and uf_union() functions to allow
> kernel modules, including the KUnit tests for the union-find data
> structure, to use these functions. This enhances the usability of the
> union-find implementation in a modular context, facilitating easier
> testing and integration.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>   lib/union_find.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/union_find.c b/lib/union_find.c
> index 413b0f8adf7a..c9fd30b8059c 100644
> --- a/lib/union_find.c
> +++ b/lib/union_find.c
> @@ -1,4 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
> +#include <linux/export.h>
>   #include <linux/union_find.h>
>   
>   /**
> @@ -21,6 +22,7 @@ struct uf_node *uf_find(struct uf_node *node)
>   	}
>   	return node;
>   }
> +EXPORT_SYMBOL(uf_find);
>   
>   /**
>    * uf_union - Merge two sets, using union by rank
> @@ -47,3 +49,4 @@ void uf_union(struct uf_node *node1, struct uf_node *node2)
>   		root1->rank++;
>   	}
>   }
> +EXPORT_SYMBOL(uf_union);

BTW, we don't need to export these functions until the time a kernel 
module starts to use it. That is the usual rule.

Cheers,
Longman


