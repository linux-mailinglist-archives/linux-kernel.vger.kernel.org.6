Return-Path: <linux-kernel+bounces-336014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31DF97EE07
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298151F224BC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E9D19CD0E;
	Mon, 23 Sep 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icRXQYO+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C3126C01
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105018; cv=none; b=BznCSuZIAMcaMzKWefKvbOMWNIb407UtP6Hk9V14ru/npsHjexgDjep3xoi1M9E8YGgD1mASVH4aklxu8SnqrHvH1c5d1/vWq9s6QIg1a1nkonaU/HhG67MFMgQEKT3iukWg30gvEvdjgrGM7PHCt3ndM4Pmgh5DONC6h0r9IMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105018; c=relaxed/simple;
	bh=chni6m5ygtuDwRoF6V+gFQNB7x71iFc5SxV/SVlbXpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtnUYpGHGuHqxcDJFthr5B9r5vGybOjQ+Jk+KiWAPwMH84l6qkjeKbauPFkyL8gKJxsfyVIwnzYq6oU71M+yzM+ZaQQKZnw3lqHEbgxL31NjCv93buUsBry5KzGdXfNeO9B4QkjnWWKFwFy/s7fvqvRLjjczY4BUswH5gJYn2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icRXQYO+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727105016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HJEzSoxzDM0AW+lTYFcxtoZ0BysvvVxy6Rx35EAn8Po=;
	b=icRXQYO+BKIrGov1drpnNvP2ig05tYm9qCY6nczYZCVEKqnnna7Nn02ELwENjefBJI/nyl
	AFWKS2oBMNlmmA2eFdMjVjXKApC4YA5omGlJ46LhnE/51glS5dvm4MBfDG1V9vY4PX5SSS
	r1L1eZAaiwhIxnUnLqHqIr2l1YwUlZ8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-wFVU3tJVPCaQ5BDmF_qCuA-1; Mon, 23 Sep 2024 11:23:34 -0400
X-MC-Unique: wFVU3tJVPCaQ5BDmF_qCuA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a92ab4dd0so290500966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105014; x=1727709814;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJEzSoxzDM0AW+lTYFcxtoZ0BysvvVxy6Rx35EAn8Po=;
        b=wSUqnzLIzRkuin9bjG7bbPrdFXS9cM91GlNkbZNyayO2YZJYxck9g7XmakSpt1R1sH
         GXZsCphCzObsgcIYb0L9Vg5Vras7eW+J5ITQhapdquRLAft87+7GOQhB9f8ZpKfXl8Sn
         mbt5Jo4wTWnNqJvPjcsY6RIvUILQ+YfHAPBXHUDOd75+eq/ygj4TtKx9iTKghIix9oXO
         uWOclFJaOW9tW0GMXdtHBapoSEUTyFnT+FwH0tff7GybUQTyH6wGnyiDWmvHqxhkyClC
         k1iSF00+0Oa6LB6Uo6wuIcZuGdfcG4LhLMs8kBTP/QIyjZAlIeXTe/iCAX/6dT401DBp
         bDIw==
X-Forwarded-Encrypted: i=1; AJvYcCXmXj3QzDNhMQwWFBUU9gP41iqD3nT8ChXQcLiykFC/uguauPFsi1adbhsWNtKL61+7MNRP8JualtVTs+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCsbSD2j1Rj8E4ZI7oMKynDklE95fLCsdTDCIAGfVOzwyYGJ+/
	nRhH2KdrG23kefxnPlZjD8QCYWJ17G/tAQ78cawxkuk+htWNSU/jjCxaVvMIRw1Qo0477BQFPaj
	7j0iP9CidwemOjECuDekRW1j4PdNrezhOLa5egNSuhPmU70qAC/X5Rm/q5eTkziS5ildIIObC
X-Received: by 2002:a17:907:d848:b0:a8d:250a:52b2 with SMTP id a640c23a62f3a-a90d4fca80cmr1145491466b.6.1727105013708;
        Mon, 23 Sep 2024 08:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkNAV5bhP2nLaYJwbWRSOqXMB7IwTaknfXoFkyW6UzI848T86c8HHBPxmi4tm2PYkvUaYnhQ==
X-Received: by 2002:a17:907:d848:b0:a8d:250a:52b2 with SMTP id a640c23a62f3a-a90d4fca80cmr1145489866b.6.1727105013256;
        Mon, 23 Sep 2024 08:23:33 -0700 (PDT)
Received: from [172.20.10.9] (tmo-087-151.customers.d1-online.com. [80.187.87.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b38d3sm1238381566b.120.2024.09.23.08.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 08:23:32 -0700 (PDT)
Message-ID: <f15ff981-e725-40f0-8d2f-856b4b6a65b3@redhat.com>
Date: Mon, 23 Sep 2024 17:23:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Make SPLIT_PTE_PTLOCKS depend on the existence of
 NR_CPUS
To: Guenter Roeck <linux@roeck-us.net>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240923142533.1197982-1-linux@roeck-us.net>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240923142533.1197982-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.24 16:25, Guenter Roeck wrote:
> SPLIT_PTE_PTLOCKS already depends on "NR_CPUS >= 4", but that evaluates
> to true if there is no NR_CPUS configuration option (such as for m68k).
> This results in CONFIG_SPLIT_PTE_PTLOCKS=y for mac_defconfig.
> This in turn causes the m68k "q800" machine to crash in qemu.

Oh, that's why my compile tests still worked ... I even removed the 
additional NR_CPUS check, assuming it's not required ...

Thanks for debugging and fixing!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


