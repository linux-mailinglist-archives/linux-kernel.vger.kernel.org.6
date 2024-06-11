Return-Path: <linux-kernel+bounces-209648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7EF9038E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8489D2879DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1AE178397;
	Tue, 11 Jun 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbRsF+5b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0557407C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101972; cv=none; b=iBISPk3Dm3cJxWpXZkYGoMwh0qlWSCmoqkJZaG18lImiviMsMqvmbbu+gBL2fH70ImEhgvTXeaUes4rPovyR1bmsOSYLXrT2F0/MenFnjkiTDTSOFjm/HtQyeCszOHYAWPqggTRgb08MMKIR4yue7q/GC96+WOO/a4j+gJHeenI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101972; c=relaxed/simple;
	bh=ocXWZLZt4vRGWQexMoBknOG7B28MXYu3HXsM4wdDmWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+oP84MCCJLGbMl3WLE3q3+4rlk4FVkaIkwAiMlk2yAvh1VsYNt1m7XOQtWXiJ1U4tyyyvai4vq+O0Zl4GvssYYk2PP/pbOMqFuustTKF4NWL+WjGZZi16W1vxCAH1n2csmy94nkEUJycQwBnkHSEfKf48cjC/zWaXmUBvOwftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbRsF+5b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718101970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8IJjvPlYTgGby4QteaSEpbc44xLD1xUOwtVSJzbAX64=;
	b=ZbRsF+5bjHXIhuSUqLVybtaqyuan8sPrLZU4fZPxRh6qWIJt4F1c/FD9PYbJWsmz4gdwnv
	J+EGuq35ndVSZR+VCTq43baIjQ+v+bm7W649zofkkUyOwMSbqWkR4N3rzzJ4L1QcmgwacX
	80YPcm5MTVi4iXU7ZPVuShL+A7wCIQQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-ogmibgVEPAi6VHrNidoQwA-1; Tue, 11 Jun 2024 06:32:48 -0400
X-MC-Unique: ogmibgVEPAi6VHrNidoQwA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ebd5d5e151so25739861fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718101967; x=1718706767;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8IJjvPlYTgGby4QteaSEpbc44xLD1xUOwtVSJzbAX64=;
        b=jYy9kTgyCxReuGW2dbUsFXXPTez7dFj4xJJ/6hdSY5Vf2PcMurr8AmDxlxpN7/fPe/
         cErk8DSOLVDH4op0505CLDLrgJzRmoTVdsd1CRIT+V4EvG9YdQnznMMEuqkYOraOZVzQ
         Iw82ZhxTjB9wP1vzvVHkhgjhWDajMTB27ZP1Wx+O5bJnshm308QfojMEFH23sBXXnjvl
         jLBk6BPzp5BPsvbWYfATNgvPFXq94m5K6mtPIkjSj8xyTzwrz+Eb7vSQpPqHebwjftLr
         dexbymciegkkFAPsdb6SVEg5Rxhe+zg8R3LIuqFvraPcyWA0Iy+s+V0x0qDpNBF3E312
         5KaA==
X-Forwarded-Encrypted: i=1; AJvYcCXAnVGQnywzjWlIa/YxeWesbw3HII9J9UNvjGiRWALpzxK3VDTV06yaqrPwkmh/qxLOJUezpMt2a8SWAUqqHA7P4j3LsB8MMWbl8yuJ
X-Gm-Message-State: AOJu0Yxzo8Vy/fFjpOf6EpKdSeSug2bJJyn9HPukrgieY9VErHA6p/PU
	9f7Wxb4PblZrHfc7/WoflC3wz1HL6Cgi+ngCBbo3heDSJ5ACx2cKMSnqQ9MWzU55rb0L6oQ5PXW
	3r2U1wvo2fYbeC+nxqkIuZ8qkTlHCjPudl7CDdwdbe2+gYte+ByRYj7LexTxkxA==
X-Received: by 2002:a2e:8086:0:b0:2eb:f7a4:7289 with SMTP id 38308e7fff4ca-2ebf7a47357mr3010131fa.51.1718101967291;
        Tue, 11 Jun 2024 03:32:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCS1UWr/Lav9vU3zkbBMu6I34lHIPbNjgCjn12ARLt40UU4azZziKE3ue0rx4T0xu5wLLNBQ==
X-Received: by 2002:a2e:8086:0:b0:2eb:f7a4:7289 with SMTP id 38308e7fff4ca-2ebf7a47357mr3009921fa.51.1718101966743;
        Tue, 11 Jun 2024 03:32:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4223da03f46sm26935365e9.23.2024.06.11.03.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 03:32:46 -0700 (PDT)
Message-ID: <e8c10a52-61f9-4b46-bc50-e2c267b1aa56@redhat.com>
Date: Tue, 11 Jun 2024 12:32:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline
 6.10.rc3
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <baohua@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 12:14, Naresh Kamboju wrote:
> The kernel panic was noticed while running LTP syscalls fork13 (long running) on
> the mainline master 6.10.rc3 kernel on arm64 rk3399-rock-pi-4 device.
> 
> Please find detailed logs in the links,
> 
> As you know fork13 is a stress test case trying to generate a maximum number
> of PID's in a 100,000 loop.
> 
> This device is running via NFS mounted filesystem.
> 
> I have tried to reproduce this problem in a loop but failed to reproduce the
> crash.
> 
> 
> Crash flow:
> ------
> fork13 run started
> BUG: Bad page map in process fork13
> BUG: Bad rss-counter state mm:
> Unable to handle kernel paging request at virtual address
> Internal error: Oops: 0000000096000046
> run for 800 secs ( 13 minutes) and more.
> fork14 run started and completed
> 
> fpathconf01 run started and completed
> sugov:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 
> Insufficient stack space to handle exception!
> end Kernel panic - not syncing: kernel stack overflow
> 
> I have tried to decode stack dump by not being useful [1].
> [1] https://people.linaro.org/~naresh.kamboju/output-rk3399.txt
> 
> Test log :
> --------
> tst_test.c:1733: TINFO: LTP version: 20240524
> tst_test.c:1617: TINFO: Timeout per run is 0h 15m 00s
> [  904.280569] BUG: Bad page map in process fork13  pte:2000000019ffc3
> pmd:80000000df55003
> [  904.281397] page: refcount:1 mapcount:-1 mapping:0000000000000000
> index:0x0 pfn:0x19f

Mapcount underflow on a small folio (head: not printed).

[...]

> [  904.294564] BUG: Bad page map in process fork13  pte:200000002e4fc3
> pmd:80000000df55003
> [  904.295275] page: refcount:2 mapcount:-1 mapping:000000007885152f
> index:0x6 pfn:0x2e4

Another mapcount underflow on a small folio (head: not printed).


> [  904.309309] BUG: Bad page map in process fork13  pte:20000000cc6fc3
> pmd:80000000df55003
> [  904.310031] page: refcount:1 mapcount:-1 mapping:0000000000000000
> index:0x6 pfn:0xcc6
> [  904.310728] head: order:3 mapcount:-1 entire_mapcount:0
> nr_pages_mapped:8388607 pincount:0

Mapcount underflow on a large folio.

...

> [  904.326666] BUG: Bad page map in process fork13  pte:20000000268fc3
> pmd:80000000df55003
> [  904.327390] page: refcount:1 mapcount:-1 mapping:00000000f0624181
> index:0x1b pfn:0x268

Another mapcount underflow on a small folio (head: not printed).

> [  904.328094] memcg:ffff0000016b4000
> [  904.328401] aops:nfs_file_aops ino:8526e6 dentry
> name:"libgpg-error.so.0.36.0"
> [  904.329051] flags:
> 0x3fffe000000002c(referenced|uptodate|lru|node=0|zone=0|lastcpupid=0x1ffff)
> [  904.329878] raw: 03fffe000000002c fffffdffc0009a48 fffffdffc022f3c8
> ffff00000688bd60
> [  904.330561] raw: 000000000000001b 0000000000000000 00000001fffffffe
> ffff0000016b4000
> [  904.331240] page dumped because: bad pte
> [  904.331590] addr:0000aaaad9afe000 vm_flags:00000075
> anon_vma:0000000000000000 mapping:ffff0000300d4188 index:2e
> [  904.332476] file:fork13 fault:filemap_fault mmap:nfs_file_mmap
> read_folio:nfs_read_folio
> [  904.333245] CPU: 5 PID: 22685 Comm: fork13 Tainted: G    B


Are these maybe side-effects due to

https://lkml.kernel.org/r/20240607103241.1298388-1-wangkefeng.wang@huawei.com


How reproducible is this?

-- 
Cheers,

David / dhildenb


