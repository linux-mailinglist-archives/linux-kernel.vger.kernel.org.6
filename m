Return-Path: <linux-kernel+bounces-270973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8C09447FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528C01C24584
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D505114F9C4;
	Thu,  1 Aug 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8M3SMow"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC02189518
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503706; cv=none; b=fCPpAyNzBZ1y/8PhqBBMRol5q1i40Mv5FkFuXF691JHaH/P6PIqAM48W1Eb8szF5rmEXdrYwf0XZQQ0GmNljG/1n7pDoLdNUCG9tq6j76esSOQttGa422DVZ2dB6yZuAc+x3cQwMxdYX8GnUmgALrAocXrjKXpHHghDTWGwwp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503706; c=relaxed/simple;
	bh=4QLNURbGmj6pPY4/JZEtDEFhGbuLkoYULBp/+uPr5ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGy+YIP2AXl2kZK0fEbdH+O9ccJVsb7cd3rK4BT2XYkz8DXWzg4c4Rbpm3VONaAhdV82879JjDAUNjb+mqcJ0p4fKatVGxrWsJiwMhOLl5+/P4x72zTPeqFLkVOg0RGZwNTMutZuQOB8/G2XAzVaqJE8LhKZELV50mLGJbL2Gk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8M3SMow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722503703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MrfY/jv9YmGr6hzqUbjuvzqEnlVAC1NlJvmT30hlOQk=;
	b=G8M3SMowzKtqcWuOo9VlU625KXoeNXOpkQeYaUkjqMyHVL+m8nByTFqm18kLD5PT4Llqmq
	bWWBiScOWioeE2zNKrvXDnOZo1UoJbFW/bdROYLJQvRv9JkCeEPUcSrO/T837txck93QC2
	uVz+1Gdc7Hs14m38StnucSLJweC+j30=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-VHdvA-flPHeMKtrTFMpUzA-1; Thu, 01 Aug 2024 05:15:02 -0400
X-MC-Unique: VHdvA-flPHeMKtrTFMpUzA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36bb24c86d9so188229f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722503701; x=1723108501;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MrfY/jv9YmGr6hzqUbjuvzqEnlVAC1NlJvmT30hlOQk=;
        b=oQeKhiMltC3QOo0ql4hitzXwRUocupOofu+FFj6cWshfEKl8/aI25tDfTlIMEvGjU7
         x6gzfZk74Zp3/qTEJUaiNGIb6DSPXwXjprNr3/dB939SEAWdWt0Jtyhru19ilbaLwPyJ
         mKJUehR76Ybnul4SAnxN0m1ReElZY8DIqQ+31/U/qDHZ9GpevC970rdgjbAgLDnNXCho
         BkXrOuC3dIfvI1kJyg2XNLpRGXe5OCzvQ4dCQdCmv3KlvbkUex2hyxuksEcj5uQIvbBz
         Xr59X/F5H0nY53bZiHDsZOKTWq5mpemCl/VbWK6IZNXgT98bsAaCZudQVGwm3C6j5TYM
         6Wpg==
X-Forwarded-Encrypted: i=1; AJvYcCWJDMI2t6s18t/w+2Rm4q4BElr1WUrSCptPKmlFqTZ24kezgBFwUKoqMcPa7YMf3ax9CsG/M45HEknOY/nqJrdoYAZFbpaHSjieZmrb
X-Gm-Message-State: AOJu0YyKguqZSSepKGGa+p3jnAmFI+wZc7mFYN5F7OOFbNXr5l+2RYpi
	gP+YIUH+WPsYIx3O3Vc5SpSoOiyWvLkgyfHJz4tO/c7eqhJqLu8DRhGHnfFo0QIGxqBY6MKGm86
	VPlT2mmfU/5J6361KiVMcT5EjLR6MubIbITzCUxAHR6UUpS3Wfuh6W7+ySGP2gQ==
X-Received: by 2002:adf:e84d:0:b0:368:5d2:9e58 with SMTP id ffacd0b85a97d-36baa9ed82dmr1314047f8f.0.1722503701024;
        Thu, 01 Aug 2024 02:15:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQP6VKhFLpPHnc9rVvpn9YN2wwiTFzJNZPK5OEp5YI30gp08OxomYmTJmbIB1gbQHA7Gz+8w==
X-Received: by 2002:adf:e84d:0:b0:368:5d2:9e58 with SMTP id ffacd0b85a97d-36baa9ed82dmr1314022f8f.0.1722503700470;
        Thu, 01 Aug 2024 02:15:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e49bdsm19017199f8f.44.2024.08.01.02.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 02:15:00 -0700 (PDT)
Message-ID: <3c79021a-e9a0-4669-a4e7-7060edf12d58@redhat.com>
Date: Thu, 1 Aug 2024 11:14:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster
 order
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Barry Song <baohua@kernel.org>
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.24 08:49, Chris Li wrote:
> This is the short term solutions "swap cluster order" listed
> in my "Swap Abstraction" discussion slice 8 in the recent
> LSF/MM conference.
> 

Running the cow.c selftest on mm/mm-unstable, I get:

# [RUN] Basic COW after fork() with mprotect() optimization ... with swapped-out, PTE-mapped THP (1024 kB)
[   51.865309] Oops: general protection fault, probably for non-canonical address 0xdead000000000108: 0000 [#1] PREEMPT SMP NOPTI
[   51.867738] CPU: 21 UID: 0 PID: 282 Comm: kworker/21:1 Not tainted 6.11.0-rc1+ #11
[   51.869566] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
[   51.871298] Workqueue: events swap_discard_work
[   51.872211] RIP: 0010:__free_cluster+0x27/0x90
[   51.873101] Code: 90 90 90 0f 1f 44 00 00 8b 0d 8d 95 96 01 55 48 89 fd 53 48 89 f3 85 c9 75 3a 48 8b 43 50 48 8b 4b 48 48 8d 53 48 48 83 c5 60 <48> 89 41 08 48 89 08 48 8b 45 08 48 89 55 08 48 89 43 50 48 89 6b
[   51.876720] RSP: 0018:ffffa3dcc0aafdc8 EFLAGS: 00010286
[   51.877752] RAX: dead000000000122 RBX: ffff8e7ed9686e00 RCX: dead000000000100
[   51.879186] RDX: ffff8e7ed9686e48 RSI: ffff8e7ed9686e18 RDI: ffff8e7ec37831c0
[   51.880577] RBP: ffff8e7ec5d10860 R08: 0000000000000001 R09: 0000000000000028
[   51.881972] R10: 0000000000000200 R11: 00000000000004cb R12: ffff8e7ed9686e00
[   51.883393] R13: 0000000000028200 R14: 0000000000028000 R15: 0000000000000000
[   51.884827] FS:  0000000000000000(0000) GS:ffff8e822f480000(0000) knlGS:0000000000000000
[   51.886412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.887532] CR2: 00007f37d7e17840 CR3: 0000000335a3a001 CR4: 0000000000770ef0
[   51.888931] PKRU: 55555554
[   51.889471] Call Trace:
[   51.889964]  <TASK>
[   51.890391]  ? __die_body.cold+0x19/0x27
[   51.891174]  ? die_addr+0x3c/0x60
[   51.891824]  ? exc_general_protection+0x14f/0x430
[   51.892754]  ? asm_exc_general_protection+0x26/0x30
[   51.893717]  ? __free_cluster+0x27/0x90
[   51.894483]  ? __free_cluster+0x7e/0x90
[   51.895245]  swap_do_scheduled_discard+0x142/0x1b0
[   51.896189]  swap_discard_work+0x26/0x30
[   51.896958]  process_one_work+0x211/0x5a0
[   51.897750]  ? srso_alias_return_thunk+0x5/0xfbef5
[   51.898693]  worker_thread+0x1c9/0x3c0
[   51.899438]  ? __pfx_worker_thread+0x10/0x10
[   51.900287]  kthread+0xe3/0x110
[   51.900913]  ? __pfx_kthread+0x10/0x10
[   51.901656]  ret_from_fork+0x34/0x50
[   51.902377]  ? __pfx_kthread+0x10/0x10
[   51.903114]  ret_from_fork_asm+0x1a/0x30
[   51.903896]  </TASK>


Maybe related to this series?

-- 
Cheers,

David / dhildenb


