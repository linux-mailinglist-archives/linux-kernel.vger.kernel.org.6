Return-Path: <linux-kernel+bounces-243516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD756929713
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9121B281893
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539910A22;
	Sun,  7 Jul 2024 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JM8pCKLJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1B79F2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720340826; cv=none; b=deYanSlQ9ffslq+kyH1zkepD7ASnxBFiqzKfh5JzhwtUmj/FxBBJYGvThQje5gdn2KtXsumvFFJWHWr1choQBYU35DCOA8cuwV4CZKU0GEb7RB1x+KgIpkVUqNrD4cNua+rH+pzXH8J3cgVnik0iV7LBLeIkRxP0dOitkFxWhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720340826; c=relaxed/simple;
	bh=z1Ie+swoxknZq9zY55UOI5qIeBXSF+/KBwodL1npwbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKWpb0AZAzfTF8MJEqR8bOOtdSZbQlnU1qF/jfm2hYapxGocQfbHPgFWuVNQCjlb3JbAxvIebyZp9gmNxtMHNwcgN1SDnUsBGBfeaLfUQx/9/nuKK+Ii8QWx/5BlExhOxYoM7PRts3MP0807ec2K4oVgeZDmTQOFgIB/bfOlrUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JM8pCKLJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720340824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZFJq99cRrVpFdbGjaQAOcEkCS5wr5Uww391pCw7GQrY=;
	b=JM8pCKLJFNoD/E3+AYl4JrLfBvPiDtj8isbMmx7Z0m2XMhiMMhu6C/70RgPchj3SECH2Vr
	zKxVB7yruXJPjzdKlONd0emWBf7ucHcw91rfAeDHunjTudYqcbij0iT2Rk9eyvZvAJKi8j
	zXVmYJYCGSFZ2fi2ofmA6GNa6aGG9U4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Gj842JbxN0GJPdFt7YKVAw-1; Sun, 07 Jul 2024 04:27:02 -0400
X-MC-Unique: Gj842JbxN0GJPdFt7YKVAw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4257db9d71fso23283375e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 01:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720340821; x=1720945621;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFJq99cRrVpFdbGjaQAOcEkCS5wr5Uww391pCw7GQrY=;
        b=WybuFpi2hLAAW7YXRWfjm7svPRUeKzeblu9Z878rBJZ/d4iySSu7yKeGf0lCRgpsr1
         lGEzW6RCWIxYBmjNvAkoKofNJYUZtGdVFKZ7KtxCsIb+tuhH7r9IpQvVyMETRsq/HLoa
         FJC2/tWUJ28VIDzJ7FvqI/K8tdmvSBaWtORoKC/fIVPavWzViiqRHy4pZns8vA6izjTx
         o1fcvOW777U00G5PBVRy2M9YDTIxwBP1pMqs4janRZSl+L3yxBIjJeEZyWMdSS0/jKxZ
         tVbOTHojKkrHMAN6HKvmBkrxTKY9Pfy2+yMN4YY2mhbAbcaDV0QZLuyC38nF8M3be8vS
         APmw==
X-Forwarded-Encrypted: i=1; AJvYcCVGrvl+r7Xrq5hw9U8OZulnzr5ZuuUjIjdWpsi3iKY9xohsuGNTFLI1+lgzw3Tfu2rJwTMJQaefgj18XM+bOpkQZHwltmEUn0KMYZCb
X-Gm-Message-State: AOJu0YztTCkUXKrgQxKWpeOBtzNPzDGeyqblRMhH+p7LXoRPAH1QN+5s
	2sPPTEVaBPKmITewXeMQk2ploMCu2j/68J6m2oE+54QcS36n2nr2wrsOLDuUg3JEKbCVuA8OHPP
	PVg35xGJn6bDs5EjiImCTpFo16doMDicMrFrfmCIBCRcMHKSK0gk57dGIWqbcjw==
X-Received: by 2002:a05:600c:48a1:b0:426:5471:12e2 with SMTP id 5b1f17b1804b1-4265471145emr42272015e9.4.1720340821270;
        Sun, 07 Jul 2024 01:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsR1GhISub8sMIvLPq9JIwL70uvt6AQVbMO9tqAlT2YwA8PN2oV//rNBmcX1sSakwVgndcUw==
X-Received: by 2002:a05:600c:48a1:b0:426:5471:12e2 with SMTP id 5b1f17b1804b1-4265471145emr42271905e9.4.1720340820875;
        Sun, 07 Jul 2024 01:27:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c00:10f0:d1a8:c206:17ac? (p200300cbc72f0c0010f0d1a8c20617ac.dip0.t-ipconnect.de. [2003:cb:c72f:c00:10f0:d1a8:c206:17ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42662a21066sm31957355e9.22.2024.07.07.01.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 01:27:00 -0700 (PDT)
Message-ID: <82ca055a-4b51-4db4-be7d-27b84aa70bd7@redhat.com>
Date: Sun, 7 Jul 2024 10:26:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] synchronously scan and reclaim empty user PTE
 pages
To: Qi Zheng <zhengqi.arch@bytedance.com>,
 the arch/x86 maintainers <x86@kernel.org>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
 <e7a8ddb2-52b5-4267-859b-e212644440b1@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e7a8ddb2-52b5-4267-859b-e212644440b1@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.24 09:16, Qi Zheng wrote:
> Add the x86 mailing list that I forgot to CC before.

Hi,

I'm planning on looking into this (again, I'm very interested!), but 
I'll be a bit (understatement) busy the next 1.5 weeks.

If I don't look into this within the next 3 weeks, an you please remind 
me? Thanks!

-- 
Cheers,

David / dhildenb


