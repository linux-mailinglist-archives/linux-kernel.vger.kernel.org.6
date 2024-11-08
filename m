Return-Path: <linux-kernel+bounces-401874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18399C2074
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D041C22C73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5522B2071E8;
	Fri,  8 Nov 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co6uKOq0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90937DA82
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079844; cv=none; b=K7/r4HKJ9alqE/de+uFviHymM2WHJfFJJ4o05sNIWpwm5v+dkcmCchspPevv3W1L/3EMKr01BcP5R+hoQcCsISfKHkLl2ZIy3f/zwQFmc3l3qGBoK3HMx8UadsdE54ygl18sc/kzTGSsVL7y0o6Vli9BVTiiGTq2LK9axZ6i8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079844; c=relaxed/simple;
	bh=SptMHUZmsM8jnbOCtVFaLKT2qTpx+zPQmVZN3Bgia0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CX5bixVvId3jGam86PgRU5J2hoMc3khUZwOUZL91++XWWLVTZeL4OUzCcZky8yaUGTtE85ul6dCN+rxpSDScBIJ09lPgY8i8351qMi/3Y4fCD130z1tDYCetOFwkpxjUIaLhm2LNrtktUS8vfNKqiRmDqV1AtKhnOduymesW4Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Co6uKOq0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731079841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o+Lxhe/DWwh0xPxUn+xIw5L6G/P/DekkvNid3KQ/xkQ=;
	b=Co6uKOq0ThSFIF12sAhjXWNnx8Wq4SwbrCVHjIXq9UwZZNwT7KFSs9i4XPV754PS8/2s68
	SSvBf6qbY+F3hIpU7/Xsk8sVPKaXr+5lzitt1uizQKcrCPBJChpGfRu5cGiCacL/W7FCnq
	Mfgifznk8+WJgA+hBLvJJeckc+txzv0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-TUYbmFTnNRq_ix7W6hgt-w-1; Fri, 08 Nov 2024 10:30:40 -0500
X-MC-Unique: TUYbmFTnNRq_ix7W6hgt-w-1
X-Mimecast-MFC-AGG-ID: TUYbmFTnNRq_ix7W6hgt-w
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d537292d7so1601908f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731079839; x=1731684639;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o+Lxhe/DWwh0xPxUn+xIw5L6G/P/DekkvNid3KQ/xkQ=;
        b=AgPPf9AHt0QPME4klYRGS+vssIfHh5w4zQ1QLfVFf+2bXMHD+qhcZ3/N4+UwFBh54R
         kOI0vJ32eJ6R5QmXHCCYCnHowVrkkm+d57VTcIWu+laH0AUHCCq+5rw/6qeks/iuEJx+
         AFmwQhYkMqDDZM2RFB6BfBuqIVAxFsd2Mnh3RYMgcttDU6Tmir9ZvjYa7ZDMP3ENFt5M
         ATh3wSx7DyWD74DKlADyMHt+qrZJH4sBAoyUt7UxpJuxW2WQAlO2gBUsS8/V1LaYnDvY
         dcusXPZxtOBzpAc93aZnFAdiw8bpBMp9mHAt2dVd98t102SjlkwIYglgqhTozM03px7a
         7dwA==
X-Forwarded-Encrypted: i=1; AJvYcCV0S7X8na9UbsGQ/QCORdZSEJ7Yq1m4yT08CqfU4N/3++sPb2AqGdimv0tC9UNorVu2u9YxbpTvxjW8U00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyisK/vPHFCeTCMYC0ZYQW3z4EaJncYSOUIgmJeVml8CF3vdxYe
	EcThrP3gIyJ8fwTJ2Gs0lXVlhIlX92HEI9BZkRgx5fzDZXk/OctOe4EwRQ36feI/H9nalwlEJGj
	xlzfI+51hwmaTu/6079wsIrcUixIOfE0h7OUMbVfp4iXXvCxInpNSklCO4qZnkw==
X-Received: by 2002:a05:6000:2d11:b0:381:f443:21c0 with SMTP id ffacd0b85a97d-381f44325f1mr1335875f8f.57.1731079838866;
        Fri, 08 Nov 2024 07:30:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX1iEJZ7CjT+mTTs0CcBJqpCe/P3krBg7NohiUhEA6znD0DmYBWrK+kcIbmgf2S5nzo3Rf8g==
X-Received: by 2002:a05:6000:2d11:b0:381:f443:21c0 with SMTP id ffacd0b85a97d-381f44325f1mr1335837f8f.57.1731079838334;
        Fri, 08 Nov 2024 07:30:38 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5? (p200300d82f3acb003f4e68943a3b36b5.dip0.t-ipconnect.de. [2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04049sm5151978f8f.93.2024.11.08.07.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 07:30:37 -0800 (PST)
Message-ID: <3d49fbf8-866f-485b-b7fa-a89bbfb3cd7c@redhat.com>
Date: Fri, 8 Nov 2024 16:30:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Support large folios for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.11.24 05:12, Baolin Wang wrote:
> Traditionally, tmpfs only supported PMD-sized huge folios. However nowadays
> with other file systems supporting any sized large folios, and extending
> anonymous to support mTHP, we should not restrict tmpfs to allocating only
> PMD-sized huge folios, making it more special. Instead, we should allow
> tmpfs can allocate any sized large folios.
> 
> Considering that tmpfs already has the 'huge=' option to control the huge
> folios allocation, we can extend the 'huge=' option to allow any sized huge
> folios. The semantics of the 'huge=' mount option are:
> 
> huge=never: no any sized huge folios
> huge=always: any sized huge folios
> huge=within_size: like 'always' but respect the i_size
> huge=advise: like 'always' if requested with fadvise()/madvise()
> 
> Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
> allocate the PMD-sized huge folios if huge=always/within_size/advise is set.

So, no fallback to smaller sizes for now in case we fail to allocate a 
PMD one? Of course, this can be added later fairly easily.

> 
> Moreover, the 'deny' and 'force' testing options controlled by
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
> semantics. The 'deny' can disable any sized large folios for tmpfs, while
> the 'force' can enable PMD sized large folios for tmpfs.
> 
> Any comments and suggestions are appreciated. Thanks.
> 
> Hi David,
> I did not add a new Kconfig option to control the default behavior of 'huge='
> in the current version. I have not changed the default behavior at this
> time, and let's see if there is a need for this.

Likely we want to change the default at some point so people might get a 
benefit in more scenarios automatically. But I did not investigate how 
/tmp is mapped as default by Fedora, for example.

-- 
Cheers,

David / dhildenb


