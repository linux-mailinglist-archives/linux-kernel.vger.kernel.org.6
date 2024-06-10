Return-Path: <linux-kernel+bounces-208305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D03902350
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695B01F2785B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8414C58C;
	Mon, 10 Jun 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCkfMBcC"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17712F582
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027774; cv=none; b=O0e+XvYjmJ+IuR/Tlnd8xiPTgd1nCn/HLsDJ5w9WCrqFc1CzuoZ5d5hj13e5/D3BtJD+5s6swhQvu1qRGm2L/7yKcxsyq+EDsabn0vTe9SWyYTj+6tVBDFb5l93JYs3m/NdxlKunxoZt1wioj5LzpmqA6fukKKJUeqqHy2ZE2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027774; c=relaxed/simple;
	bh=9pCIf4/xa3Edx4NF5IIWB8Hy+5spWmvph39KzHVLto4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evBt8+VFxnLdIfYzxzUJvD/B82B1otsRiiLmAtyMbNSJx7lfn28SSdXzgYp64Ri/c2Xh0djYyhzndeunchnkH54gVYW9WcSIZiiRiBAQ2URqt1Xe0tsEUIdxJmQZsMr5TewzNgC0RApS4iMI7jpBfAmjDtQmHIp7lBNRlpf//v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCkfMBcC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso447645166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718027771; x=1718632571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQ41PO/kyUDkz1qf8WP62Viu44Es8AhqI8N2duos8vw=;
        b=HCkfMBcCWE6eLdgcv1CX/5DWa35u9UgknCE/LwPYmHh/Zc+zp5ai7dW+3TLMGhWkK1
         eD6t7tk897oHonY7bvGSbIi9yaa9LwXHA9xUeRBniaGY5RdYfXQ0ttPKDlLygVEaEOAd
         jDb0/nmMX7IA5mt52LmW0KAwXa/X96RdOkdRKlYzKxjlMQ1x7sCB8jokjikP1kZYpBMD
         Bz2JVUjLGZ5H1TwuDg6H5L0vHutRZDcXt04QoXOztW7CnbAmWRbQQqcXg/Y4UhDqKS2M
         Jn4bl+rbW7wxsI/W77Tj+W04F/kpt51OovBBBkSyg2TRcrBaKYnAeKKWIVK/5u1uPV8I
         8n4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718027771; x=1718632571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ41PO/kyUDkz1qf8WP62Viu44Es8AhqI8N2duos8vw=;
        b=mG2vPnMPKwncEfjNGZt1/SVnXxkdKMq8Qly/fhItcHjNsucItQsSmDFFOrclbv/Xhh
         BPmQQx5ZJJNaCFJiAjRI/azKvx3KlbqsMSU6o94y5QN1bJWw/0Ne+R87A37ZNlDhnwxi
         spxeqlKfzQiOWgmm5tDUIji/4uWVjaKdLh5ANPjYyARxz8s3KIWZdiGwETD15p08ztH8
         jZ/IJYNzzY8LE0Yo5a2KZlaHaTzFXXOyozZRsXi94zuxq0WfakPIIF4ZC9/bY9/9wuqT
         GJcyEtfaAviTLDL67Gl9KEpAovkT/IlgZGRiwYyVRuRR33lc/6pxZ5daO4NX31jhVBjE
         8Uvw==
X-Forwarded-Encrypted: i=1; AJvYcCVbnz9OVmKGTA3+u3b7dp8vCLoFP6KyKu1SLtU+uOJcvePagnfj25RfGkIKoH5++zgmxGpOiYvvrmHS/J3/3T1BDdMyd+unPHSGnxv8
X-Gm-Message-State: AOJu0YyAf/5ac80mcwh+eCYntbARDb36opZTVQTZ8NUvwtcUiZg3yYMi
	wJY9nY104Eerl/BIcMr3KWUvhxBgL52zMeShnZoYYFeYmdigxyj0
X-Google-Smtp-Source: AGHT+IHQ/rOiObPfMmeBKsGdRFLQtrCxPbQVsHgRRg9IsrgMkC02S7nOAhNtOQxrNJLrkkDF0o0zng==
X-Received: by 2002:a17:906:a888:b0:a6e:5526:e574 with SMTP id a640c23a62f3a-a6e5526f9bemr432213666b.46.1718027770625;
        Mon, 10 Jun 2024 06:56:10 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:493])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0e858d7fsm299097566b.127.2024.06.10.06.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:56:10 -0700 (PDT)
Message-ID: <acb76cdb-a54e-48e0-ba18-a2272d84f0ab@gmail.com>
Date: Mon, 10 Jun 2024 14:56:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, yosryahmed@google.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com>
 <Zmb6r6vrP2UTDQrK@casper.infradead.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <Zmb6r6vrP2UTDQrK@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/06/2024 14:07, Matthew Wilcox wrote:
> On Mon, Jun 10, 2024 at 01:15:59PM +0100, Usama Arif wrote:
>> +	if (is_folio_zero_filled(folio)) {
>> +		swap_zeromap_folio_set(folio);
>> +		folio_start_writeback(folio);
>> +		folio_unlock(folio);
>> +		folio_end_writeback(folio);
> What's the point?  As far as I can see, the only thing this is going to
> do is spend a lot of time messing with various counters only to end up
> with incrementing NR_WRITTEN, which is wrong because you didn't actually
> write it.
>

I am guessing what you are suggesting is just do this?

     if (is_folio_zero_filled(folio)) {
         swap_zeromap_folio_set(folio);
         folio_unlock(folio);
         return 0;
     }

This is what I did initially while developing this, but when I started 
looking into why zswap_store does  folio_start_writeback, folio_unlock, 
folio_end_writeback I found:

https://elixir.bootlin.com/linux/v6.9.3/source/Documentation/filesystems/locking.rst#L336

"If no I/O is submitted, the filesystem must run end_page_writeback() 
against the page before returning from writepage."

and

https://elixir.bootlin.com/linux/v6.9.3/source/Documentation/filesystems/locking.rst#L349

"Note, failure to run either redirty_page_for_writepage() or the 
combination of
set_page_writeback()/end_page_writeback() on a page submitted to writepage
will leave the page itself marked clean but it will be tagged as dirty 
in the
radix tree.  This incoherency can lead to all sorts of hard-to-debug 
problems
in the filesystem like having dirty inodes at umount and losing written 
data.
"

If we have zswap enabled, the zero filled pages (infact any page that is 
compressed), will be saved in zswap_entry and NR_WRITTEN will be wrongly 
incremented. So the behaviour for NR_WRITTEN does not change in this 
patch when encountering zero pages with zswap enabled (even if its wrong).

This patch just extracts the optimization out from zswap [1] to swap, so 
that it always runs.

In order to fix NR_WRITTEN accounting for zswap, this patch series and 
any other cases where no I/O is submitted but end_page_writeback is 
called before returning to writepage, maybe we could add an argument to 
__folio_end_writeback like below? There are a lot of calls to 
folio_end_writeback and the behaviour of zeropage with regards to 
NR_WRITTEN doesnt change with or without this patchseries with zswap 
enabled, so maybe we could keep this independent of this series? I would 
be happy to submit this as separate patch if it makes sense.


diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 81b2e4128d26..415037f511c2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3042,7 +3042,7 @@ static void wb_inode_writeback_end(struct 
bdi_writeback *wb)
         spin_unlock_irqrestore(&wb->work_lock, flags);
  }

-bool __folio_end_writeback(struct folio *folio)
+bool __folio_end_writeback(struct folio *folio, bool nr_written_increment)
  {
         long nr = folio_nr_pages(folio);
         struct address_space *mapping = folio_mapping(folio);
@@ -3078,7 +3078,8 @@ bool __folio_end_writeback(struct folio *folio)

         lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
         zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
-       node_stat_mod_folio(folio, NR_WRITTEN, nr);
+       if (nr_written_increment)
+               node_stat_mod_folio(folio, NR_WRITTEN, nr);
         folio_memcg_unlock(folio);

         return ret;


[1] 
https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/






