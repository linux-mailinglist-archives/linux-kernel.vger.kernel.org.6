Return-Path: <linux-kernel+bounces-337274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B619F9847F4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F9C1F2126C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B701AAE09;
	Tue, 24 Sep 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+bgSzWB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B61AAE2B
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189108; cv=none; b=dee4JHK78UEniRuSDbmYbHeYS5MZLLP6aeghzHsZDnwrX6Pcb7pwa7y1g5buKXi0e3uFHyjkJqNeydZa++idihclGbqowqqs26UAS1Xe3L5VqYhB9ZwEYSm5x3sCNXx1inqLtJ5WFXbYmC2+bCFUc4XJPYkKkKBGOV8hc9xaFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189108; c=relaxed/simple;
	bh=irFZ7IQbkLIruT4tlcgtpfR+4NkhJoqumokyLsbmEZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rp0ChYjXOVekupek9Z8eh4OSjHSrti295V4LnNTSlI96umA9SiyqhbMn00qmI+kFikWc1cvk+tZStpwauMB+BQbP6R/bvV3pIsMhWhgWME7qJ/G2ZFgTmS5zxEDS02ER1qr/Hvum41UjDxxu1TCzO9Yf68ftCBSV9iD6/LtgjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+bgSzWB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727189105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLsuvsY7wD16XLBqCozW1RebhtorMDtXjx8EqpSjAPs=;
	b=N+bgSzWBUBePv/TIv5qzoC7Aj6KlHf/hHVch2itV1A7DTIHaWwnhlPCLc2wbCg1CI4EGpy
	8G7Dh8dwg6DuxGPHTfh8sYD8m6NddpAupOTUfsluJ3ewIjf/MFqtFH1j2ai1g+aUIX975s
	3Q8JlNcTxkYK2LKYbcjUeN/jjVb9upU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-TH-RowbsPIKy7CfMEhiDBg-1; Tue, 24 Sep 2024 10:45:04 -0400
X-MC-Unique: TH-RowbsPIKy7CfMEhiDBg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cbadcbb6eso43879095e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727189103; x=1727793903;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLsuvsY7wD16XLBqCozW1RebhtorMDtXjx8EqpSjAPs=;
        b=EwdvZp1xnXOkWMEJ8OhP0VFTPjien9FguC69IbwVksysDY0YuVip5UZM8BSxF+FWth
         +v4vRXywg78VhgHCr0G2zpuqsvkN0M0OkiNGx5TaMWz9KOtFI4ZJulLwBRKN8pSuwQ/p
         7Il9kgBnveaV6ZXNquTevoDmkD/Z6AiRkdNXNf3ZYknz2E7elKyRFQGXnz9xH00eFzsF
         /jNpplB30oYhTyLWrzQN9jvFc0e1c0SSQ+DruEzvfRCo5nTH/UvGlGv1q4g0yCn+JXSz
         mr3VIzP9pt0snIoRzeJchwnpv+KYY6xs4+VxhXnipZ8KEAiLLsAnKn/ncRpUniLaihpS
         IKXg==
X-Forwarded-Encrypted: i=1; AJvYcCVKzpImQ9fmEOqMSBJQ6Yn9DoePSj1/2qNzUDiiju4tTa1zyOh4UGz7Qlhyg3zTwq52nEE3AmAz/1m8shk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jxEBHhh7hVER3dtwBvttCdDxf7lH0zQjdtYhL0e1Hxd9hev2
	SrUortExMzSa1CVJUELqsGF1iR6snNaekJ7ZwhEdZ8xDyXxVD27vVCMhBXm8Gdwut2CG8ekPz6b
	OVAsc3Rtkb8LgzB8fQ3EDE1lyXBn8RI+kmL0RNGNorSUUx2/o6mZSetIVxEh6Ig==
X-Received: by 2002:a05:600c:458d:b0:42c:a8cb:6a75 with SMTP id 5b1f17b1804b1-42e7ac35e0fmr132486325e9.17.1727189102818;
        Tue, 24 Sep 2024 07:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGadHK2t2/qKCxi+EjpJA+UzC2fr49rFuFN1iHJDIhhzmYSspZSf3UNcSTUkPFYISvGZg7bzA==
X-Received: by 2002:a05:600c:458d:b0:42c:a8cb:6a75 with SMTP id 5b1f17b1804b1-42e7ac35e0fmr132486095e9.17.1727189102364;
        Tue, 24 Sep 2024 07:45:02 -0700 (PDT)
Received: from [10.202.151.204] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e902b6434sm24770025e9.31.2024.09.24.07.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:45:01 -0700 (PDT)
Message-ID: <4f96130c-12b7-4afa-ada3-bec354576112@redhat.com>
Date: Tue, 24 Sep 2024 16:45:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in copy_huge_pmd
To: syzbot <syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, jgg@ziepe.ca, leitao@debian.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
 rppt@kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
 x86@kernel.org, peterx@redhat.com
References: <66f15c8d.050a0220.c23dd.000f.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <66f15c8d.050a0220.c23dd.000f.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.24 14:18, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c36c27980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
> dashboard link: https://syzkaller.appspot.com/bug?extid=bf2c35fa302ebe3c7471
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12773080580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed5e9f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0e011ac37c93/disk-88264981.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f5c65577e19e/vmlinux-88264981.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/984d963c8ea1/bzImage-88264981.xz
> 
> The issue was bisected to:
> 
> commit 75182022a0439788415b2dd1db3086e07aa506f7
> Author: Peter Xu <peterx@redhat.com>
> Date:   Mon Aug 26 20:43:51 2024 +0000
> 
>      mm/x86: support large pfn mappings
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17df9c27980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=143f9c27980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=103f9c27980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
> Fixes: 75182022a043 ("mm/x86: support large pfn mappings")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5508 at mm/huge_memory.c:1602 copy_huge_pmd+0x102c/0x1c60 mm/huge_memory.c:1602

This is the

VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd))

So we have a special-marked PMD in a COW mapping.

The reproducer seems to involve fuse, but not sure if that makes a 
difference here.

-- 
Cheers,

David / dhildenb


