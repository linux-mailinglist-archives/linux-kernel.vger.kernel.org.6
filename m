Return-Path: <linux-kernel+bounces-554605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF404A59A63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC031888A64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78B22D4FA;
	Mon, 10 Mar 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kj5QyiyX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20617A31A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621869; cv=none; b=tbBqdeAIbHBcIkv3p+yGrpOfHozm9PLilu3UB40aaKAF6yuQQSk98hhZLnAKFeC3T+d6YvnSsIoj1yCw4N5rkwxpfEkpR7R0VeNRNkVZMKFyhlYTo6LvFaBKNPpWGyjdOBG17CBjfXs415+HArqM0IZAhU3ssAuP4o59GSJHkGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621869; c=relaxed/simple;
	bh=5AWSQI8/Jl+oCnx27EpSynIrLzL++36B5f7kAfCZmRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwM8s2obPkhC9ZGv3fsCORKEg6ZdNODILjJ69rbHxLlwD6XVh2YWQkkLtMAjcJB2KPJCFKZMyXctHo/fJYi1KjuNi20vaip3/AdStax7tm9dTodr5h+dsk3MM+yB3Sm3Z/O6e4bkyaorRmDDOLikov1jzywxb6dGPMH4+zJiL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Kj5QyiyX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so83590195ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741621867; x=1742226667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xB4to/vwlXRWs8kY9XvkPSxIbn6I8rZXuqM4IRgKQQ=;
        b=Kj5QyiyXmJbjYDimIBGwGywEM2Ml3BAX5ebR1yj1AETUeICmiqPiIlXLs/ZjhZ86TT
         HcV2o5Ai2ggFepINJ7RpjX/kKw8TDbfe+uqq7MpxHnM1upn7ZvULX/ZtvGvX50+0T4Ei
         r3WKEu+JjZ9dtvLVMA7wHG9HNQtUHoBFmHCce88IFdkRi65Vx39lAWwU8x7u0DZiwEiA
         Uk5wr6CSr7T2oS8y4g1YsFh14U88iNHsiMBoHMAFldUWlnvoklvBqkGbY4bkHZ8+0EB2
         nCDukoOMf081mzRVdzrReCzFWYkGxmtqPcBS11bsQUrx/jfTqUfmQU5yM5OfQK2n3hn6
         gdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741621867; x=1742226667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2xB4to/vwlXRWs8kY9XvkPSxIbn6I8rZXuqM4IRgKQQ=;
        b=DoDzef/jWKBGfCqUXcJzEWCiMuWRRe2s/0AhVuqdGU/oNdeM8DS1IV79mZy75LdIP4
         I1FOuehRurESF6PToIIadJPJh4lWNXT+bV2uMCXSN22bmEvZHPmzDjIttmLifLYgcHPF
         vWifOvWyRlR48UjOq9Gj5AKvVQw52+O0WChrIObmgKmq4CA1X/Jp/d2m6arH+tht5AYR
         t/aq3EkhTAFg6B+NnNMP2lH9r7cM6gshDvp5Towyazb/xXwHAs/Ru54QSqoh0RWxWRgl
         1iixzZX7tQXtrXK20wCr7LPwTQ4YgNgbsclKegvhE1GrROGrxskYRpXQAc5lVU1bjynL
         2Dug==
X-Forwarded-Encrypted: i=1; AJvYcCVNxUEnpNjUOFg5pQ2GmS9HIkdlARyvF7bWnG9GT4033H+QRkDTLB6I7orp0a08+WUtLMpXPJL9e0YBqs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztxGRgXiVwo8f6zGdwU3hQuNBOkGU1tRMMe9NdFLiiog3pVxXE
	a62k9/4cPX2F3vtGLKv2yEA+E1ileqvdRnri1oT24qKmCXvX0FVo4OOOEN4mR+8=
X-Gm-Gg: ASbGncvbh9t4C1/EghxCtjoCfQymK1FXzOMVp5SbX3MA31425khEqBRL2hJzQ4YbZit
	haxaiZO6TsPMvrJ6SnYToP8o5UfAolV0vkMRx63Ho3iJaCq9ArV71VKPi+hiWFRgdYMBAJyvxxf
	jxuG7RIG8P8rZQe+moZVfb/YQhWnrYbqcBPdv6hfCX2sDjhq+ey6RW+3Oy+iHO6yIzmZ+/D//A+
	9WfD1aFZLfts5TL7EzqfP9BCLw5GAZ379hFcXbv+cxnw4sY0Z0CMP1tGOG/yAXtf3yNGE1hjGVs
	o0fqh9mPAoVdsEHmrPF7MOdlTIRVdIXH0eV3AvAVzkbarvQI+YHfrXpqzEuxdqeOrWEV
X-Google-Smtp-Source: AGHT+IFRPI/5e0bjG5Qm3pD9F4oNW6VZE0+KXf+GOKRkrJoPQgOOZc0Ik3EM1YQrZkfJWALjmWPd7g==
X-Received: by 2002:a17:902:ce89:b0:216:393b:23d4 with SMTP id d9443c01a7336-22592e2008fmr5512835ad.11.1741621867223;
        Mon, 10 Mar 2025 08:51:07 -0700 (PDT)
Received: from [10.68.122.90] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbf2sm79649835ad.18.2025.03.10.08.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 08:51:06 -0700 (PDT)
Message-ID: <f0d9986d-b3f0-42db-8fb6-d6087dd77f7d@bytedance.com>
Date: Mon, 10 Mar 2025 23:51:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: use ptep_get() instead of directly dereferencing
 pte_t*
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250310140418.1737409-1-ryan.roberts@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250310140418.1737409-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ryan,

On 3/10/25 10:04 PM, Ryan Roberts wrote:
> It is best practice for all pte accesses to go via the arch helpers, to
> ensure non-torn values and to allow the arch to intervene where needed
> (contpte for arm64 for example). While in this case it was probably safe
> to directly dereference, let's tidy it up for consistency.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   mm/migrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

This looks good to me. So

Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

BTW, there are many other places in the kernel that directly
dereference pmd_t* and pud_t*, etc.

For example:

root@debian:~# grep "*vmf->pmd" . -rwn
./mm/memory.c:5113:	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
./mm/memory.c:5207:	if (unlikely(!pmd_none(*vmf->pmd)))
./mm/memory.c:5339:	if (pmd_none(*vmf->pmd)) {
./mm/memory.c:5490:	if (pmd_none(*vmf->pmd)) {
./mm/memory.c:5996:	if (unlikely(pmd_none(*vmf->pmd))) {
./mm/filemap.c:3612:	if (pmd_trans_huge(*vmf->pmd)) {
./mm/filemap.c:3618:	if (pmd_none(*vmf->pmd) && 
folio_test_pmd_mappable(folio)) {
./mm/filemap.c:3628:	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
./mm/huge_memory.c:1237:	if (unlikely(!pmd_none(*vmf->pmd))) {
./mm/huge_memory.c:1352:		if (pmd_none(*vmf->pmd)) {
./mm/huge_memory.c:1496:	if (pmd_none(*vmf->pmd)) {
./mm/huge_memory.c:1882:	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd)))
./mm/huge_memory.c:1947:	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
./mm/huge_memory.c:1965:		if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
./fs/dax.c:1935:	if (pmd_trans_huge(*vmf->pmd) || pmd_devmap(*vmf->pmd)) {
./fs/dax.c:2058:	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
./fs/dax.c:2059:			!pmd_devmap(*vmf->pmd)) {

Would it be best to clean them up as well?

Thanks,
Qi

> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 22e270f727ed..33a22c2d6b20 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -202,7 +202,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>   		return false;
>   	VM_BUG_ON_PAGE(!PageAnon(page), page);
>   	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
> +	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
> 
>   	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
>   	    mm_forbids_zeropage(pvmw->vma->vm_mm))
> --
> 2.43.0
> 


