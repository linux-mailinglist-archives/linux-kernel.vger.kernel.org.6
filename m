Return-Path: <linux-kernel+bounces-525310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D626A3EE13
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30EEE7AB065
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950E220012D;
	Fri, 21 Feb 2025 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLsoHMLn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E71FFC60
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125536; cv=none; b=p668wnIeZbMOO1UhUH6YMte1xb2j0GDq5o3jERW/qLEWAtb8c9ILOeno2qCSEujhKUOOr4uUVVfIJWQAnh4HkvxCBsiVJEpSkEm9KhSBOL9YYMJU6ITe+JtUjHt/BGwTtAdBdhhqIZX7coGLsMS0ZbT47KuABlJUjUn1fV+5x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125536; c=relaxed/simple;
	bh=lzWxN1S1fKFRnF86+Gs+pAO61S9OlEWIgKWpyTFIpqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkcfvPQaq3RyIHDfwHJv34vE3Jbuex6aeyocKJV7GJJ1Ue6NUb3xCMV/9WzPeTF7d4MEuGQDbTmnfDBPVGjDN4rQ5cOKT8pMik5maxPC+phyBAiSVnIvcfASbt1/WWWAllYbZ8Whk/7Z5+CebTxLaxMRBpmhDsc5TCVFMF7wPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLsoHMLn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740125533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=snZPDRQfF3nkbAItK54JkAF0l4vF4hDbSlVfQh+HZLY=;
	b=QLsoHMLn4CfDDFIt4VDXIU5oF9R3j4oolvtwb43b9v8GHbVNpzVnNffhvwLDjuHCpXB/wF
	7pz8Kir2C70MOEY4pR96tGF/3et9HZ6T4o76SDt7J/g5BKjmt8nG36wsU3cfClOQEH+P7l
	mfS2b4eGDkRGi+A61QUhvzPrQqxdBoI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-271UASIrMIuo5tsf2L812w-1; Fri, 21 Feb 2025 03:12:12 -0500
X-MC-Unique: 271UASIrMIuo5tsf2L812w-1
X-Mimecast-MFC-AGG-ID: 271UASIrMIuo5tsf2L812w_1740125531
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so16798335e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740125531; x=1740730331;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snZPDRQfF3nkbAItK54JkAF0l4vF4hDbSlVfQh+HZLY=;
        b=DX7bRHt4qYXk4F+ZtNnw52TRcE848tQNcKI50EFhHAX1IfdFNIRIUtcmphyewy2Qbm
         LKI7XcvDzJbu5qZ+xYP/sGa4hPhIHOuoaEf7PMNNY4+iB3aTbPs6wMq+QfUb1BNoBsu4
         WC8h3P2XHxp119J9ScIZsor9Ebd5nnD6iYGyK/T6iEKlGRxt2YKQxG2pGNsT3m6iHVGC
         IJE3mV6mCwM6AmvONImyGptTFuTwD0vW+XmOjrWpQk9JnGARUfdYy4AYZPvYuHHfaO4E
         hjay92uchjiUYyzreZ1UY6rqYVnpPUakqaEjvwDfgIemCFUDlGn4zn8xmp89spokCCao
         aEKg==
X-Forwarded-Encrypted: i=1; AJvYcCVrJNnyqtGWmiaRvstbBmVKjskFKUbj/OTufejozFtd4+qcmit4Z5LBeCuZZ5bIILnehUEvu1UaxtqplLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxScLO+3DEL1V1Rz1QGNFXLDXY2ZLM4cW8vaVoK553qm06lpQY2
	7YQ+AB0F+iQckeZyK1LqTnyvPki5pRMKb2JTDpqINrxlpUn1iM2q9z3UeoyHgTujZEftpyUIzPc
	BUBWLFqYXDMyxpLreSsP0J8zSkgi57h77MmOj2/kaptrPqJ/ZryPotShHkC2EaQ==
X-Gm-Gg: ASbGncu1frN860At40jSoz2Eqt9xPbKCodaU3QNCFUyzA4uYzScKK+bMY/4nAVVcpI/
	ZGCRkF6wQtkwqFN0gBpebq7cmZO3BBLTwAh10+AIIJnLj7Ly8DPzB5C+8swiy3TMLAPz5UmCgYT
	asmB/oOUm6r1gc8jO399/edRzR0y/Mz/hd7gZUi0U+wPgc+uJIDCS/uXf/DPeFNk4hw97mEOU2a
	HXjgWkIm20wNbK/k6AJFuytZL4DLEtb53cUf7OMLOZBRyOaIiYQtM/fiiuIT0JSBMKkR6qXc08Y
	YIqeJr5e8Fpm/UlRxX1W+Q4qBVjWlKYDDh5cBobitvmAMQ==
X-Received: by 2002:a05:600c:45ca:b0:439:9a40:aa0b with SMTP id 5b1f17b1804b1-439ae21e36emr15273945e9.25.1740125531053;
        Fri, 21 Feb 2025 00:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG0dkekhehCKl02eUDjNK4+y+UHQN/7nOWkErBj+FTNK2mzW3HjK76Y3BDYHomyV9SXb1sTw==
X-Received: by 2002:a05:600c:45ca:b0:439:9a40:aa0b with SMTP id 5b1f17b1804b1-439ae21e36emr15273695e9.25.1740125530691;
        Fri, 21 Feb 2025 00:12:10 -0800 (PST)
Received: from [192.168.3.141] (p4ff23890.dip0.t-ipconnect.de. [79.242.56.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce404sm9811415e9.7.2025.02.21.00.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 00:12:09 -0800 (PST)
Message-ID: <bdc01d66-01a7-43f6-954f-12a274e294d4@redhat.com>
Date: Fri, 21 Feb 2025 09:12:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] uprobes: fix two zero old_folio bugs in
 __replace_page()
To: Tong Tiangen <tongtiangen@huawei.com>, Oleg Nesterov <oleg@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Peter Xu <peterx@redhat.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
References: <20250221015056.1269344-1-tongtiangen@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250221015056.1269344-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.25 02:50, Tong Tiangen wrote:
> We triggered the following error logs in syzkaller test:
> 
>    BUG: Bad page state in process syz.7.38  pfn:1eff3
>    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eff3
>    flags: 0x3fffff00004004(referenced|reserved|node=0|zone=1|lastcpupid=0x1fffff)
>    raw: 003fffff00004004 ffffe6c6c07bfcc8 ffffe6c6c07bfcc8 0000000000000000
>    raw: 0000000000000000 0000000000000000 00000000fffffffe 0000000000000000
>    page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x32/0x50
>     bad_page+0x69/0xf0
>     free_unref_page_prepare+0x401/0x500
>     free_unref_page+0x6d/0x1b0
>     uprobe_write_opcode+0x460/0x8e0
>     install_breakpoint.part.0+0x51/0x80
>     register_for_each_vma+0x1d9/0x2b0
>     __uprobe_register+0x245/0x300
>     bpf_uprobe_multi_link_attach+0x29b/0x4f0
>     link_create+0x1e2/0x280
>     __sys_bpf+0x75f/0xac0
>     __x64_sys_bpf+0x1a/0x30
>     do_syscall_64+0x56/0x100
>     entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
>     BUG: Bad rss-counter state mm:00000000452453e0 type:MM_FILEPAGES val:-1
> 
> The following syzkaller test case can be used to reproduce:
> 
>    r2 = creat(&(0x7f0000000000)='./file0\x00', 0x8)
>    write$nbd(r2, &(0x7f0000000580)=ANY=[], 0x10)
>    r4 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file0\x00', 0x42, 0x0)
>    mmap$IORING_OFF_SQ_RING(&(0x7f0000ffd000/0x3000)=nil, 0x3000, 0x0, 0x12, r4, 0x0)
>    r5 = userfaultfd(0x80801)
>    ioctl$UFFDIO_API(r5, 0xc018aa3f, &(0x7f0000000040)={0xaa, 0x20})
>    r6 = userfaultfd(0x80801)
>    ioctl$UFFDIO_API(r6, 0xc018aa3f, &(0x7f0000000140))
>    ioctl$UFFDIO_REGISTER(r6, 0xc020aa00, &(0x7f0000000100)={{&(0x7f0000ffc000/0x4000)=nil, 0x4000}, 0x2})
>    ioctl$UFFDIO_ZEROPAGE(r5, 0xc020aa04, &(0x7f0000000000)={{&(0x7f0000ffd000/0x1000)=nil, 0x1000}})
>    r7 = bpf$PROG_LOAD(0x5, &(0x7f0000000140)={0x2, 0x3, &(0x7f0000000200)=ANY=[@ANYBLOB="1800000000120000000000000000000095"], &(0x7f0000000000)='GPL\x00', 0x7, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, @fallback=0x30, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x10, 0x0, @void, @value}, 0x94)
>    bpf$BPF_LINK_CREATE_XDP(0x1c, &(0x7f0000000040)={r7, 0x0, 0x30, 0x1e, @val=@uprobe_multi={&(0x7f0000000080)='./file0\x00', &(0x7f0000000100)=[0x2], 0x0, 0x0, 0x1}}, 0x40)
> 
> The cause is that zero pfn is set to the pte without increasing the rss
> count in mfill_atomic_pte_zeropage() and the refcount of zero folio does
> not increase accordingly. Then, the operation on the same pfn is performed
> in uprobe_write_opcode()->__replace_page() to unconditional decrease the
> rss count and old_folio's refcount.
> 
> Therefore, two bugs are introduced:
> 1. The rss count is incorrect, when process exit, the check_mm() report
>     error "Bad rss-count".
> 2. The reserved folio (zero folio) is freed when folio->refcount is zero,
>     then free_pages_prepare->free_page_is_bad() report error
>     "Bad page state".

Well, there is more, like triggering the

	VM_WARN_ON_FOLIO(is_zero_folio(folio), folio);

in __folio_rmap_sanity_checks() I assume.

So maybe just call the patch

	"uprobes: reject the share zeropage in uprobe_write_opcode)()"

Thanks!

-- 
Cheers,

David / dhildenb


