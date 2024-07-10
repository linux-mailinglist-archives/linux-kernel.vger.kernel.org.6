Return-Path: <linux-kernel+bounces-246807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6106292C6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49C51F22B73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38310E6;
	Wed, 10 Jul 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wa38ZzeO"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FA1A32
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570493; cv=none; b=fYUCzvI5oFhOqDgvhJW1f5LSEtTfQHthevTRSzb+wlfvTGK/PyHr1m8PM5/ULh1SCTqxl9bhVC2ZWMTlzlmWUaw2I7xjg6r1FSccPyY8Lk/IZMSSSDwg7sk6cSCUSY8i5lvIxEw4EjX83WNQytpmkBpqqh1KAwQ5pdMJEujfTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570493; c=relaxed/simple;
	bh=yio6J8mZFtI0CKcNb+diyJBsaGYSiTIVclXsOvtgp00=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QfwGaC6gFBKIDVVSpVAfR/OAwiafMCmf4YFweVYqX3VT9Rs/PCCOmfbZN9YYP4AM+4hdNw3hzodOtZV1xVWb/jmCcnZYuO+yhoRZc84QDVCvpxuitXX3yhFNXg2D5YkMN5dB5kFWCkgFZtZ8tUwo2oDYhMk7ozu5W5phpZd38ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wa38ZzeO; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-655fa53c64cso35195207b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720570491; x=1721175291; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYzCTDwEK2pMUJCfcFRfctFHDDdLzr2h8y801pHs+Og=;
        b=Wa38ZzeOcC+QUBTawfrBsD3yW+ol1ix/Kzfv38Win8/9sVubDp65M1W8nLtcmtRTI6
         vga7kT54ZnyPFPfGXteHbDPwLl+mhxpoxS54oJdwvWsTkTOnXB7P2wb/ljNNfnpCgaXE
         ByoWs1211qvc7qw/Hk2Q071oa4mpS8ykx9V/ebdNIAPtlXk41wFBrv3tCuB4TtZRN3Bs
         /JXmNs+Yr8b6eRbIP0lQrIlknktF5iMviN7RJp8aOMzlyBRBdXZJDIEOdw+UkmFPz0lT
         Ox31SdPRrb37kLVQftZa5zqqX1AWw9uobdLH0cqPaOjAMXWPyxv3qGmgEXxJc019IPi1
         BGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720570491; x=1721175291;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYzCTDwEK2pMUJCfcFRfctFHDDdLzr2h8y801pHs+Og=;
        b=LH3AqB974/X8Kdj4DwVB2JmecoyoM5xwBiYXMLqOJVMlQFgvqwqKEhMx2A0k9lzK7P
         0kDJApKKR3yDv0n2fzAf+/J/BDxMlpsbfaDlFi6dNdzObzRAPXjOONNFgjpit5ePnXyr
         wyQkpCX4CMljt9KxVM421A1l+e/O1VngDgMXdm7tB7brtZE9FuzIcmOUHXA6n+VLPAKM
         blmltL4yrKOrw5QTOwECgVqj3sxQtwSfJfOI0HvfIX2hfAkAgM47nxdCRGPnUFljbh1K
         Ki+CPoCH6UVzFNH3uPVkHt0sUupQdrOMfO87Ud6/CBV+eI1MSsIbrY0ngqskRmZnVwWl
         z/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXcfDLLcvXcNcgk3Eu6S6ZgPdgxco1i+L7YOW8vyL9d6WqeSajNhMyHbHU9okOrMDnmhE+OYbQ26yw2eKYGH0fePKuEEM8brDgofY1b
X-Gm-Message-State: AOJu0Yz2fpDktKVLMYkYpaL4XuWepaA0XTO9YSNtPuT048W3h/5VY7hX
	ATUqViztRD/96BFKNgNDI7PQ14HWpp1lNeQvESXGJQ03g0v6r2WS3chN5D/bBA==
X-Google-Smtp-Source: AGHT+IEJDg6S4NBLs9dJMYf+hcqE1vXc4OPxZz7GmEdH8VNMxw4eh6jmPRHrPp2NqBak+KIDmEPJ2g==
X-Received: by 2002:a05:690c:ed4:b0:64a:7040:2d8e with SMTP id 00721157ae682-658f02f56c2mr51883617b3.33.1720570490925;
        Tue, 09 Jul 2024 17:14:50 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e69da2a7sm5413497b3.115.2024.07.09.17.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 17:14:49 -0700 (PDT)
Date: Tue, 9 Jul 2024 17:14:01 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>
cc: akpm@linux-foundation.org, muchun.song@linux.dev, hughd@google.com, 
    willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mm/hugetlb: fix kernel NULL pointer dereference
 when migrating hugetlb folio
In-Reply-To: <20240709120433.4136700-1-linmiaohe@huawei.com>
Message-ID: <f40218df-40bf-c0e4-5463-c07023c10b4a@google.com>
References: <20240709120433.4136700-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 9 Jul 2024, Miaohe Lin wrote:

> A kernel crash was observed when migrating hugetlb folio:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> PGD 0 P4D 0
> Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
> CPU: 0 PID: 3435 Comm: bash Not tainted 6.10.0-rc6-00450-g8578ca01f21f #66
> RIP: 0010:__folio_undo_large_rmappable+0x70/0xb0
> RSP: 0018:ffffb165c98a7b38 EFLAGS: 00000097
> RAX: fffffbbc44528090 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffffa30e000a2800 RSI: 0000000000000246 RDI: ffffa3153ffffcc0
> RBP: fffffbbc44528000 R08: 0000000000002371 R09: ffffffffbe4e5868
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffa3153ffffcc0
> R13: fffffbbc44468000 R14: 0000000000000001 R15: 0000000000000001
> FS:  00007f5b3a716740(0000) GS:ffffa3151fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000010959a000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  __folio_migrate_mapping+0x59e/0x950
>  __migrate_folio.constprop.0+0x5f/0x120
>  move_to_new_folio+0xfd/0x250
>  migrate_pages+0x383/0xd70
>  soft_offline_page+0x2ab/0x7f0
>  soft_offline_page_store+0x52/0x90
>  kernfs_fop_write_iter+0x12c/0x1d0
>  vfs_write+0x380/0x540
>  ksys_write+0x64/0xe0
>  do_syscall_64+0xb9/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5b3a514887
> RSP: 002b:00007ffe138fce68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f5b3a514887
> RDX: 000000000000000c RSI: 0000556ab809ee10 RDI: 0000000000000001
> RBP: 0000556ab809ee10 R08: 00007f5b3a5d1460 R09: 000000007fffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
> R13: 00007f5b3a61b780 R14: 00007f5b3a617600 R15: 00007f5b3a616a00
> 
> It's because hugetlb folio is passed to __folio_undo_large_rmappable()
> unexpectedly. large_rmappable flag is imperceptibly set to hugetlb folio
> since commit f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to
> use a folio"). Then commit be9581ea8c05 ("mm: fix crashes from deferred
> split racing folio migration") makes folio_migrate_mapping() call
> folio_undo_large_rmappable() triggering the bug. Fix this issue by
> clearing large_rmappable flag for hugetlb folios. They don't need that
> flag set anyway.

Gosh, thanks a lot for catching this: it had not crossed my mind that
a folio which passes (folio_test_large and) folio_test_large_rmappable
might not be suitable for folio_undo_large_rmappable.

> 
> Fixes: f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to use a folio")

That's in 6.10-rc, isn't it?

> Fixes: be9581ea8c05 ("mm: fix crashes from deferred split racing folio migration")

And that's in mm-hotfixes-stable intended for 6.10 final.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>

So if all goes to plan, this shouldn't need the Cc stable.

I certainly deserve blame for not thinking of this possibility: but how
was it working before my commit, when the folio_undo_large_rmappable()
was being called from mem_cgroup_migrate()?  I think that was just as
liable to crash too.

I would like to hear definitively from Matthew, whether a hugetlb page
should or should not be reported as large_rmappable - is your patch here
just fixing a surprise, or in danger of adding another surprise somewhere?

Hugh

> ---
>  mm/hugetlb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6282dd9e37e3..45fd3bc75332 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2173,6 +2173,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
>  		nid = numa_mem_id();
>  retry:
>  	folio = __folio_alloc(gfp_mask, order, nid, nmask);
> +	/* Ensure hugetlb folio won't have large_rmappable flag set. */
> +	if (folio)
> +		folio_clear_large_rmappable(folio);
>  
>  	if (folio && !folio_ref_freeze(folio, 1)) {
>  		folio_put(folio);
> -- 
> 2.33.0

