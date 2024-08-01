Return-Path: <linux-kernel+bounces-271018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E40944880
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AD41C24EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF7716FF3B;
	Thu,  1 Aug 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqIfezDi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035F16FF26
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504772; cv=none; b=f6rmTXCgg5MaxTCmi1ghh0b/m7ot7n/ZjuAQqJzE6mugsqOQGBCqBLYWpxBNZxl8Mm5mF3k05M3MjE3YNp/Zfnwr5qjeVACyu6H3xdJta2e5OQJgpADdCvwAxGFRHBNL3Oy0lzjFhRnROL+L8oyU3VHjTlhY0TXt/2/pNJWKtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504772; c=relaxed/simple;
	bh=K8rCBoVElV3iEj5TWkL07WZw0NsZ9i83CoYEfDc4O+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eHFB87MQ6AyvgQgqg8k16bQGvKImhrL70fZWK0AqkuhBNX4wBYnu3H5wMl/fPb5cfq6iJXsZfFIESdS6IN/wHebOmTj1h5WTlZo54dU15rbwrm7LLHMjSY92hfbUXdwXSzq5ko03lqadS3KalNaUsYPIc2XZkIgD0P2wNAW2QJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqIfezDi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722504769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sw5SOgxFJSgBmErykEqUamBdOkiv8oEDCaJmGo6NtPI=;
	b=bqIfezDiQRbDJ1kCPUhsl5e7d1oCwRlxCXF0uDqj9E0G+8OMRrgYabMS/dPCQxz3mt/f5m
	KuoT5Pr1H8CeFfSSmyQL7G1X7syERsBWtfLkl+d4vLqA4xDYAp4XToctAF8ES9jEltIjQL
	uB5FRlBF7uPgSqjFmbOWO6gtRZSBCLY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-KvfwRBfePdulyMLVY0laVw-1; Thu, 01 Aug 2024 05:32:48 -0400
X-MC-Unique: KvfwRBfePdulyMLVY0laVw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42816aacabcso40143575e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722504767; x=1723109567;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw5SOgxFJSgBmErykEqUamBdOkiv8oEDCaJmGo6NtPI=;
        b=JWrI+eEngv+IE8AS932ByrPOVvOIK9txRFTzniwTL7a/TLNx4o2XFqoMPAQ175VzWL
         NqxIXmeAoEpJ146xjZfGFY8xmqvorPvYIHX4CsxBPDcz/esSGi1F5HVIbiIz7Z6IAVzD
         7FuXmocdJAtC2AjDykeYCy3t2fal8cYwwHpuxMCRItsOM1SpdMfaSwOqj43peBUxDtto
         O01RIf6uMR0RhTD5RridOuDRBz2xBHeYdZD2C7hX1w24WwjlbtRDpwmC6N4XvYyNyUql
         9iY0ZXFlJEWYd1612WYigQ801Ntrv8TrthB6SYQQ2WJiO5EkRhVvGh3fh76r9SkHUWd2
         fUhw==
X-Forwarded-Encrypted: i=1; AJvYcCWc24aVrs2/QBc3BBSVOe/h7R1VJX11RptzDaAh8HH9Fk5ljxHPQsgkCs0DcvmAuDB3Y279adojSdrPCHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNzQAAgNFvuDJyLqoc3oTBIubp7AwAOIQMmABOCYzsZ6bX6Fg
	cdB2CSz4JYnUoCYdjFo9qj+AD0RbI5D4t5FCpxrDEpIhdy4yRqZ3bIPbCcvY9xQ76+CqIjh9mWF
	uiDk7gaM4/AbopzUKEPbtvf68rtvraDw60s/DWqmLsQhlPWX7IwT2eRjLgvrhRBJfXJn+Wg==
X-Received: by 2002:a05:600c:4fc9:b0:426:5ee5:3130 with SMTP id 5b1f17b1804b1-428a99e02cdmr15140135e9.3.1722504766874;
        Thu, 01 Aug 2024 02:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnECXtLKkrHPwcBeF8vlngw0g5Idmoj1++C+3BD5cF7iBixTnonHzwO7bbaDkSTCQxCjUpcw==
X-Received: by 2002:a05:600c:4fc9:b0:426:5ee5:3130 with SMTP id 5b1f17b1804b1-428a99e02cdmr15139895e9.3.1722504766336;
        Thu, 01 Aug 2024 02:32:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb98109sm48914275e9.39.2024.08.01.02.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 02:32:45 -0700 (PDT)
Message-ID: <48b720d6-3cd6-4c0b-a887-385de9f39bd2@redhat.com>
Date: Thu, 1 Aug 2024 11:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying
 <ying.huang@intel.com>, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
References: <20240729021306.398286-1-hsiangkao@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240729021306.398286-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.07.24 04:13, Gao Xiang wrote:
> Currently, migrate_pages_batch() can lock multiple locked folios
> with an arbitrary order.  Although folio_trylock() is used to avoid
> deadlock as commit 2ef7dbb26990 ("migrate_pages: try migrate in batch
> asynchronously firstly") mentioned, it seems try_split_folio() is
> still missing.
> 
> It was found by compaction stress test when I explicitly enable EROFS
> compressed files to use large folios, which case I cannot reproduce with
> the same workload if large folio support is off (current mainline).
> Typically, filesystem reads (with locked file-backed folios) could use
> another bdev/meta inode to load some other I/Os (e.g. inode extent
> metadata or caching compressed data), so the locking order will be:
> 
>    file-backed folios  (A)
>       bdev/meta folios (B)
> 
> The following calltrace shows the deadlock:
>     Thread 1 takes (B) lock and tries to take folio (A) lock
>     Thread 2 takes (A) lock and tries to take folio (B) lock
> 
> [Thread 1]
> INFO: task stress:1824 blocked for more than 30 seconds.
>        Tainted: G           OE      6.10.0-rc7+ #6
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:stress          state:D stack:0     pid:1824  tgid:1824  ppid:1822   flags:0x0000000c
> Call trace:
>   __switch_to+0xec/0x138
>   __schedule+0x43c/0xcb0
>   schedule+0x54/0x198
>   io_schedule+0x44/0x70
>   folio_wait_bit_common+0x184/0x3f8
> 			<-- folio mapping ffff00036d69cb18 index 996  (**)
>   __folio_lock+0x24/0x38
>   migrate_pages_batch+0x77c/0xea0	// try_split_folio (mm/migrate.c:1486:2)
> 					// migrate_pages_batch (mm/migrate.c:1734:16)
> 		<--- LIST_HEAD(unmap_folios) has
> 			..
> 			folio mapping 0xffff0000d184f1d8 index 1711;   (*)
> 			folio mapping 0xffff0000d184f1d8 index 1712;
> 			..
>   migrate_pages+0xb28/0xe90
>   compact_zone+0xa08/0x10f0
>   compact_node+0x9c/0x180
>   sysctl_compaction_handler+0x8c/0x118
>   proc_sys_call_handler+0x1a8/0x280
>   proc_sys_write+0x1c/0x30
>   vfs_write+0x240/0x380
>   ksys_write+0x78/0x118
>   __arm64_sys_write+0x24/0x38
>   invoke_syscall+0x78/0x108
>   el0_svc_common.constprop.0+0x48/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x3c/0x148
>   el0t_64_sync_handler+0x100/0x130
>   el0t_64_sync+0x190/0x198
> 
> [Thread 2]
> INFO: task stress:1825 blocked for more than 30 seconds.
>        Tainted: G           OE      6.10.0-rc7+ #6
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:stress          state:D stack:0     pid:1825  tgid:1825  ppid:1822   flags:0x0000000c
> Call trace:
>   __switch_to+0xec/0x138
>   __schedule+0x43c/0xcb0
>   schedule+0x54/0x198
>   io_schedule+0x44/0x70
>   folio_wait_bit_common+0x184/0x3f8
> 			<-- folio = 0xfffffdffc6b503c0 (mapping == 0xffff0000d184f1d8 index == 1711) (*)
>   __folio_lock+0x24/0x38
>   z_erofs_runqueue+0x384/0x9c0 [erofs]
>   z_erofs_readahead+0x21c/0x350 [erofs]       <-- folio mapping 0xffff00036d69cb18 range from [992, 1024] (**)
>   read_pages+0x74/0x328
>   page_cache_ra_order+0x26c/0x348
>   ondemand_readahead+0x1c0/0x3a0
>   page_cache_sync_ra+0x9c/0xc0
>   filemap_get_pages+0xc4/0x708
>   filemap_read+0x104/0x3a8
>   generic_file_read_iter+0x4c/0x150
>   vfs_read+0x27c/0x330
>   ksys_pread64+0x84/0xd0
>   __arm64_sys_pread64+0x28/0x40
>   invoke_syscall+0x78/0x108
>   el0_svc_common.constprop.0+0x48/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x3c/0x148
>   el0t_64_sync_handler+0x100/0x130
>   el0t_64_sync+0x190/0x198
> 
> Fixes: 5dfab109d519 ("migrate_pages: batch _unmap and _move")
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


