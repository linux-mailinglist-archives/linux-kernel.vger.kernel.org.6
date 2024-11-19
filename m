Return-Path: <linux-kernel+bounces-413905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB259D2078
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251441F226CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9EB14D6F6;
	Tue, 19 Nov 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g2gNzhwE"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA51146A60
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999244; cv=none; b=PzYDe2STniUqTf6bvzXEqZOPuj5ltunKXgTvU6zbXWhOm+/04VJQL4gGXGlHaGzt+lOgQj7bxhGND2gWzbEQldz0opO7Z7frvrLO4q8PqlYnBpIcCxzF5oTZuWGPsTiPB5bOqZkGSDNNUdCAwRE3mmd7ejJjoy6ItexYpVRHKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999244; c=relaxed/simple;
	bh=Je2NIDFQgc4fqKAf0CTt2K4VOqjbiErRQuOoHhPr1yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBLvBirE2cU6Lb9cjXve/+17At/tvMnA39g746OF8M9ikrEk22HAR/D4wfKRz81DjtqquyJX5xICWmf8Noo/PNTA1rUrPB33+BBn5Pk9Wah9you1U09TX5GkDXc8+JaMQqaqgU3G5gFyjk0pM5f4qPdLVE3iHSYN16JBVD0OC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g2gNzhwE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e681bc315so3546287b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731999241; x=1732604041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0MK2ZZbNRTSnFf6mDYAT1AUItf075doEb65NCpj4NE=;
        b=g2gNzhwEo2/xpj7mIcHbSPrJ/VJZkeGbN7+cQj+HZ+EjhBYeZlB0y0L6OlanDYJ4ei
         xBUYzHcW6JupTsdG7IbDeu2TN5Gqcscd0E2YzR4/2C+9JcmGUzdyeCpG3njFBCWJ2Uwh
         Smv4nJ70x+1T6RIl3Q7jlzkIwiALMfjXSzn0FExjglDxGwsFGxHje3M6VJ1T/uIVmqAy
         qGNC+AvFdJpl02G7EBrHCi2+Dk2zlGi7uKGMAZ43Kjc31NpJhR8dXtDt+p30t2a1CalL
         J1JPqWGKBqhdg3PPngTV1TZhIevgO6v0ZhPao8R4Ik07sk+CnjBKxMnfOS9eDR0V2Jon
         fNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731999241; x=1732604041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0MK2ZZbNRTSnFf6mDYAT1AUItf075doEb65NCpj4NE=;
        b=iqHrBBacss3QsZwucNBQqig41qyv1yA1apN0/UkJ1gYoRYUe5npm1RfV/ZYK4davlN
         PxropZwmu3KU5bETVKhRdAZ7S8kmlEkjAQEHHDyVD2VpCjZ9ap7pnm67c+nLdIfwsSXr
         2KtdOkMwSq38Uz7e7GiIPMxyYP3U/ccOSppAX2KoKN1XDMxsu/7sABHKqOkPHcqmLdcH
         0FmXKkMd2IFm2Sq62EGAxs04ig9EQ61nYcwnG5zFZtsiPHkYGfdso6hMqPZ7VYx0Xc9N
         GvHzXtCPytRgavD9TerD/teP0iYmswg3fxaFvbkgL/IXtUM45UVW7l11eaJ/pkFdGB9G
         Z7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBATRPoCApCvGV0QSTbZOHc5zcB7cGaNlBUYteYh1bhDHTzqFUOn2A0wM5afgtYPSs7BP3MAKkbCz502Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLo3GK0FIfNfCzXvp8Psj26UB0x2F0dQ+FOasP3jWc4RvZKlv
	55HgVsNBCR8et8dldleo4OZW1lHQZS70EuiFSSrilaQGisj/PRfYAvGFwGQrFzg=
X-Google-Smtp-Source: AGHT+IHfZRlZ8R2nO4xU50Ru5p5Gp0v1FYpibD2q1Y3+p7G14fuKNvzXcu2cpcp/DsRLb1th9cZOGw==
X-Received: by 2002:a05:6a00:3285:b0:724:6abf:b63e with SMTP id d2e1a72fcca58-724af8eaad2mr4231511b3a.5.1731999241414;
        Mon, 18 Nov 2024 22:54:01 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fb9bb066easm336579a12.45.2024.11.18.22.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 22:54:00 -0800 (PST)
Message-ID: <21195425-53d9-4007-a020-8106f94158dc@bytedance.com>
Date: Tue, 19 Nov 2024 14:53:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/mm: add more warnings around page table access
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matteo Rizzo <matteorizzo@google.com>
References: <20241118-vma-docs-addition1-onv3-v2-1-c9d5395b72ee@google.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241118-vma-docs-addition1-onv3-v2-1-c9d5395b72ee@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/19 00:47, Jann Horn wrote:
> Make it clearer that holding the mmap lock in read mode is not enough
> to traverse page tables, and that just having a stable VMA is not enough
> to read PTEs.
> 
> Suggested-by: Matteo Rizzo <matteorizzo@google.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

> +
> +* On 32-bit architectures, they may be in high memory (meaning they need to be
> +  mapped into kernel memory to be accessible).
> +* When empty, they can be unlinked and RCU-freed while holding an mmap lock or
> +  rmap lock for reading in combination with the PTE and PMD page table locks.
> +  In particular, this happens in :c:func:`!retract_page_tables` when handling
> +  :c:macro:`!MADV_COLLAPSE`.
> +  So accessing PTE-level page tables requires at least holding an RCU read lock;
> +  but that only suffices for readers that can tolerate racing with concurrent
> +  page table updates such that an empty PTE is observed (in a page table that
> +  has actually already been detached and marked for RCU freeing) while another
> +  new page table has been installed in the same location and filled with
> +  entries. Writers normally need to take the PTE lock and revalidate that the
> +  PMD entry still refers to the same PTE-level page table.
> +

In practice, this also happens in the retract_page_tables(). Maybe can
add a note about this after my patch[1] is merged. ;)

[1]. 
https://lore.kernel.org/lkml/e5b321ffc3ebfcc46e53830e917ad246f7d2825f.1731566457.git.zhengqi.arch@bytedance.com/

Thanks!

> 

