Return-Path: <linux-kernel+bounces-248090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89E92D847
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D6E1C20BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA8194AFE;
	Wed, 10 Jul 2024 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPmxA8FR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A2257D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636219; cv=none; b=sad33eP4+uPBbkjpZYLOCsKw04uDATBKWb/fWs/U/OUwc0DGgZ+DM859Ii8Qd0vTNUGs7hxL/BRk+J84URl4vPfoXl1GmINak8rdJ+if4tXqYmWREaLxBVUNsfH/xUGDWN743lwrSfRprhsbuMsuknJmWcS/iYaZWl45q00eL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636219; c=relaxed/simple;
	bh=iDoO3XlDpvayILJ/ZNj9ksw/IoYWu7k2Jub0GRN71xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=env+4vnXEFzJaP/LxdtWf0PG9bi3Cswlt+nUz7OZA/1S0WLAN0PX3JUl/wMRCjQyPKSjzbXwYt6foB0ltvu2dOiaoJj8AsqRfKa9qwpBEiZrjtduVV/lh/CyTR1XWaYv3ich5iOfdgVlOkU6VWeMxy+7RRlzxBD6u8sqtISQciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPmxA8FR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720636216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c/PZTGvWi1sY7TqVXDdMDOZplwNBIymfOsECaOJy86Y=;
	b=cPmxA8FR8e6cjH6e9xHnIpgqyBCc95D8kPGjzva5AJze11G3Jz4+23QziIpWiztqiyez5s
	4NkZN2Tm5kntXESAIOK3r8bbg/YfiR13Gnfx2E6dsDP4+1TcH2xZLXRDUHzI0HzLHMqgyA
	5oBw3dxQo003sNbLA7QhhLr5Kp9C05o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-ahmNo47VM7uTQkP3_3AGqw-1; Wed, 10 Jul 2024 14:30:15 -0400
X-MC-Unique: ahmNo47VM7uTQkP3_3AGqw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c9fca572adso97330a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636214; x=1721241014;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c/PZTGvWi1sY7TqVXDdMDOZplwNBIymfOsECaOJy86Y=;
        b=IQZ73JpdbaxcY5WcOhspEBU4C9oWcNbvd4CzEZnxDOMVvQsLvW7vo2eIH8jwp6KJiF
         4o3XgjvK+4KVTs9iRrtGyPjd13QU0vVSWmWY/pMKB1Cl2T/F65tj3OiorZ//XAkenBTf
         3TLGJ2iS+ZKYJ0gTsPyK7KabIj4MXYLZPg9ihkVBrT/LTiy8gR7D6DSoB+TZO8pZjjIL
         jymYkRWr3VZGY/jUf28N2D8HG5vhFUkhdmf57KOLiE2Xc+NBuEmuDn1VnHSjCu1KOxht
         kXul/LHtl8cUzt5gEoDzWNRMx4ji4SjgzVC59bL0gVIs7/AXmVGg83nTD6CUK7n/EOw+
         HtrA==
X-Gm-Message-State: AOJu0YyV2dWNVaNT6tltYOn5yoBlgvt0B4xqTTuPjqcy177/OVfd/4ga
	ZpRWfp6xRJmVs7TLloGPVq2I4RhUSzkA0lu2FvCcxsRgKGmmcQrWnBHOR2MpjcaA0pZXolUcYrj
	Mol0DZqq4xHXnP3xCgaKkh1JUXC/zX8silVbCk5v66fFKZ1ESKbr9HmHJN4cjOQ==
X-Received: by 2002:a17:90b:3a8a:b0:2c9:77d7:261c with SMTP id 98e67ed59e1d1-2ca35d5c8e7mr4972576a91.44.1720636213950;
        Wed, 10 Jul 2024 11:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv3Dp71Ge6Ve++BKdXkUWp9zl+fE17KjUG7zmrHp6K85mGf3BI+DaCAyASlMPORQ2z/i+DEw==
X-Received: by 2002:a17:90b:3a8a:b0:2c9:77d7:261c with SMTP id 98e67ed59e1d1-2ca35d5c8e7mr4972561a91.44.1720636213556;
        Wed, 10 Jul 2024 11:30:13 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a95197asm12291010a91.16.2024.07.10.11.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:30:13 -0700 (PDT)
Message-ID: <efa45499-0080-4bb1-85b3-e88ed19688dd@redhat.com>
Date: Wed, 10 Jul 2024 20:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shmem: Rename mTHP shmem counters
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Zi Yan <ziy@nvidia.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240710095503.3193901-1-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240710095503.3193901-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.24 11:55, Ryan Roberts wrote:
> The legacy PMD-sized THP counters at /proc/vmstat include
> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
> rather confusingly refer to shmem THP and do not include any other types
> of file pages. This is inconsistent since in most other places in the
> kernel, THP counters are explicitly separated for anon, shmem and file
> flavours. However, we are stuck with it since it constitutes a user ABI.
> 
> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
> same "file_" prefix in the names. But in future, we may want to add
> extra stats to cover actual file pages, at which point, it would all
> become very confusing.
> 
> So let's take the opportunity to rename these new counters "shmem_"
> before the change makes it upstream and the ABI becomes immutable. While
> we are at it, let's improve the documentation for the legacy counters to
> make it clear that they count shmem pages only.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lance Yang <ioworker0@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


