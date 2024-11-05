Return-Path: <linux-kernel+bounces-396375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5580C9BCC4F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796771C21A89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1831D54D8;
	Tue,  5 Nov 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U57L0zr6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E511D516B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808239; cv=none; b=Dh6IJkwNYxZEWki7FGPK9yaZt/fARhV5xkRrjB52VbytvwivhefMs6ihfjVS6hMT/xpGTllkpt/0mNx0DdOV2N+5fKDkNptQoTyGMhuJoDJXTKcSpH+67IGJRhAZbj6ZxxnL0n2xcwH7/Ycc/6yhcJHH1clP12IBZIPdBljx+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808239; c=relaxed/simple;
	bh=8i/lpIxGwf0sE3ojTEC/E21LtzD0K12tS4qACMZtX3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhWU284hJ8bnNHwN3Pjp75rZrP8Vd4Blz7qvlDnIyGgFhnJumDH+ZwdJPJsEK0fiTj/7mZ4O0SxXbdGNpYm/bd7vizUyg/aMcACHREh7+eHEAWM9JCMTkOU1JNB7tB1sBN9equGeM55dXs/BtWNeSOklgLCPjtROjfSUBxSFA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U57L0zr6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730808236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vPkfmAok4kG1nusb72lPJZYTJyNKgYKg3E0njLY3Z1A=;
	b=U57L0zr6KquMEHkN/4d6RA6GEPm6phaB+mRRzUdcYZa8tA3uAyYbpxc+JF+LKgOSardbDG
	QKpPrzEX5k+UrgUogFDIg9Z0T0lSyTeCd8UnH9jVR7nzug9fCrll5j2QNkb7yBDvIYFk6s
	/xXRF+cQ4tMH0p7S9pUdrYjD7H4Vhk8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-wKmOLzKBNQSWlrOAq9FPkw-1; Tue, 05 Nov 2024 07:03:55 -0500
X-MC-Unique: wKmOLzKBNQSWlrOAq9FPkw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43159603c92so36317905e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 04:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730808234; x=1731413034;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vPkfmAok4kG1nusb72lPJZYTJyNKgYKg3E0njLY3Z1A=;
        b=eGsDUTjAilgDex4UM4dOv50k7qvx94uhFe+bV/ayuJyCJStvAbsQmVa6Bim5z8bJdg
         iNaQuU0Z19XYQxTcWQEOEb8iuqFCaLcShdbuWYhsAvP3SgjV+0ifBbxGSBXwD9SNu3CI
         SJBBmklHV0i/teldLor7Kptgg2dqZ2Vv6hniHh9n4EaqYI7+lma8Mf/6a3etjRKh9m1w
         Y4I9frxGK7KCTM+DIyGYq/wRtGfBFVsugnYUNhMqHe35c2fEVLs4He55AOnlEQb7Jq/N
         wjz3sldc71DzinZaU7v/pc0HFivqOILnYMDA3lsuQO/Wt8TGxyDoE/PCnGmK8pB9nIW5
         6Isw==
X-Forwarded-Encrypted: i=1; AJvYcCXiKUrk5wJ3tZfPHKtPk4FusV3Z1roRMVJJsrPcQ6gU/Cx/C9IHQzOIhrTJAjcX2Cb2CfdqUtNrV/rYzqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMzgoiU8A8n38mr3naj3aGFN+LZORedGN7nxHMcWsCRh6ww18
	g/8VeS04KW4Fa2wF1hMrm3FVLt4Is2XIICy7HJ5Z4cwn0r0kiZIWUsnKmhIyIta6UeaiZaP9nuo
	5BnPm9jdFa9uvzvQzE3266vCD05ZkSCqMnbKncyE2L9WMEcB8l9HENDXu63uptw==
X-Received: by 2002:a05:600c:1909:b0:431:542d:2592 with SMTP id 5b1f17b1804b1-4328327eba3mr120289375e9.27.1730808233941;
        Tue, 05 Nov 2024 04:03:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT6GGKui0DyxLQGtNRkzDhWZrzbkpIjJ/M1htGh1UOtOMz8baNBV6p5U297gkG0sLrW9IAwQ==
X-Received: by 2002:a05:600c:1909:b0:431:542d:2592 with SMTP id 5b1f17b1804b1-4328327eba3mr120289155e9.27.1730808233473;
        Tue, 05 Nov 2024 04:03:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:db00:b0d7:66ca:e3e9:6528? (p200300cbc73bdb00b0d766cae3e96528.dip0.t-ipconnect.de. [2003:cb:c73b:db00:b0d7:66ca:e3e9:6528])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7449sm16015220f8f.49.2024.11.05.04.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 04:03:52 -0800 (PST)
Message-ID: <c00226ea-6e29-4432-a1c4-a25e9e05df9c@redhat.com>
Date: Tue, 5 Nov 2024 13:03:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix __wp_page_copy_user fallback path for remote mm
To: Asahi Lina <lina@asahilina.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Sergio Lopez Pascual <slp@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20241101-mm-remote-pfn-v1-1-080b609270b7@asahilina.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241101-mm-remote-pfn-v1-1-080b609270b7@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.11.24 13:08, Asahi Lina wrote:
> If the source page is a PFN mapping, we copy back from userspace.
> However, if this fault is a remote access, we cannot use
> __copy_from_user_inatomic. Instead, use access_remote_vm() in this case.
> 
> Fixes WARN and incorrect zero-filling when writing to CoW mappings in
> a remote process, such as when using gdb on a binary present on a DAX
> filesystem.
> 
> [  143.683782] ------------[ cut here ]------------
> [  143.683784] WARNING: CPU: 1 PID: 350 at mm/memory.c:2904 __wp_page_copy_user+0x120/0x2bc
> [  143.683793] CPU: 1 PID: 350 Comm: gdb Not tainted 6.6.52 #1
> [  143.683794] Hardware name: linux,dummy-virt (DT)
> [  143.683795] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [  143.683796] pc : __wp_page_copy_user+0x120/0x2bc
> [  143.683798] lr : __wp_page_copy_user+0x254/0x2bc
> [  143.683799] sp : ffff80008272b8b0
> [  143.683799] x29: ffff80008272b8b0 x28: 0000000000000000 x27: ffff000083bad580
> [  143.683801] x26: 0000000000000000 x25: 0000fffff7fd5000 x24: ffff000081db04c0
> [  143.683802] x23: ffff00014f24b000 x22: fffffc00053c92c0 x21: ffff000083502150
> [  143.683803] x20: 0000fffff7fd5000 x19: ffff80008272b9d0 x18: 0000000000000000
> [  143.683804] x17: ffff000081db0500 x16: ffff800080fe52a0 x15: 0000fffff7fd5000
> [  143.683804] x14: 0000000000bb1845 x13: 0000000000000080 x12: ffff80008272b880
> [  143.683805] x11: ffff000081d13600 x10: ffff000081d13608 x9 : ffff000081d1360c
> [  143.683806] x8 : ffff000083a16f00 x7 : 0000000000000010 x6 : ffff00014f24b000
> [  143.683807] x5 : ffff00014f24c000 x4 : 0000000000000000 x3 : ffff000083582000
> [  143.683807] x2 : 0000000000000f80 x1 : 0000fffff7fd5000 x0 : 0000000000001000
> [  143.683808] Call trace:
> [  143.683809]  __wp_page_copy_user+0x120/0x2bc
> [  143.683810]  wp_page_copy+0x98/0x5c0
> [  143.683813]  do_wp_page+0x250/0x530
> [  143.683814]  __handle_mm_fault+0x278/0x284
> [  143.683817]  handle_mm_fault+0x64/0x1e8
> [  143.683819]  faultin_page+0x5c/0x110
> [  143.683820]  __get_user_pages+0xc8/0x2f4
> [  143.683821]  get_user_pages_remote+0xac/0x30c
> [  143.683823]  __access_remote_vm+0xb4/0x368
> [  143.683824]  access_remote_vm+0x10/0x1c
> [  143.683826]  mem_rw.isra.0+0xc4/0x218
> [  143.683831]  mem_write+0x18/0x24
> [  143.683831]  vfs_write+0xa0/0x37c
> [  143.683834]  ksys_pwrite64+0x7c/0xc0
> [  143.683834]  __arm64_sys_pwrite64+0x20/0x2c
> [  143.683835]  invoke_syscall+0x48/0x10c
> [  143.683837]  el0_svc_common.constprop.0+0x40/0xe0
> [  143.683839]  do_el0_svc+0x1c/0x28
> [  143.683841]  el0_svc+0x3c/0xdc
> [  143.683846]  el0t_64_sync_handler+0x120/0x12c
> [  143.683848]  el0t_64_sync+0x194/0x198
> [  143.683849] ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>   mm/memory.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 3ccee51adfbbd007b24331fe6874265f231a877b..dba25d9734063ac02cdaeb0a5cd5432473f6372e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3081,13 +3081,18 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
>   			update_mmu_cache_range(vmf, vma, addr, vmf->pte, 1);
>   	}
>   
> +	/* If the mm is a remote mm, copy in the page using access_remote_vm() */
> +	if (current->mm != mm) {
> +		if (access_remote_vm(mm, (unsigned long)uaddr, kaddr, PAGE_SIZE, 0) != PAGE_SIZE)

access_remote_vm() will do a mmap_read_lock_killable() and then call 
into get_user_page_vma_remote() -- fortunately read-access, otherwise 
we'd be in trouble :) .

So we should already be holding the mmap read lock from the previous 
access_remote_vm() users (who we end up here) ... doesn't this complain 
with lockdep about recursive locking?

I keep forgetting locking rules, so I might just be wrong.

-- 
Cheers,

David / dhildenb


