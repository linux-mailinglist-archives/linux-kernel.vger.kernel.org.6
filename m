Return-Path: <linux-kernel+bounces-231182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4850D918738
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4881F22207
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764518EFE2;
	Wed, 26 Jun 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPGeOZel"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5318F2D4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418954; cv=none; b=m9GTIG2DfszFrBsZDBO9d9WzG5FICAtgsT+I9guqDyTmEPLAp8isTAy9x8BXNoDUv620VyLx+0MDm/LaJtphocIxGgiJ4DoYs0bDye7piXhkFC+QbuVwze6V2F3ti/Z3XSMS0XSXsA87j6Qq1W0k5Hc4RWT27pIhuiQi9r82+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418954; c=relaxed/simple;
	bh=9XhgXHG8+tusH/9LC9l7b0azJTE85BoDuG8tkGn7KF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8MZvJMzaCuVb9QEMF/UbJ89aZz/+u4fT3YZDxmo/3JhpwxV0eHPzmfPvoLkwykPevNSKnraMVvNIs+oCNrMXRzgwkwp4bu2PgXn83l+ECU8SE30+hLzpL+K4CNKSYLdg3N37mJTnZQQt9dZNKHHMFYTwsvP6g1I916eoHKEbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPGeOZel; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719418951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fGxp6Ukd0LTljOubDYeVT+TIf0qV9JZHHFrPwd/iFcE=;
	b=PPGeOZelEvCF9twefmkf/l9zcIo1PjOOdm3hFEtRgK7f9z2kxiYx2AF+s2OvRIOgDjL+Q+
	HGieXfHMFTK5pBJ9l4IzaKy7xCSieT9m4dzosobAWhz+K8NRtQS9j474wUpBAR989H0Rnl
	bPSy0kTTSzWFwQ6v0TbGZrc0PjikMSM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-PGsyOBztMk-ZTGvyOLZZoQ-1; Wed, 26 Jun 2024 12:22:30 -0400
X-MC-Unique: PGsyOBztMk-ZTGvyOLZZoQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52ce324c204so3668318e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719418948; x=1720023748;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fGxp6Ukd0LTljOubDYeVT+TIf0qV9JZHHFrPwd/iFcE=;
        b=GDy5Hfkna1q+0JtMD7z6SYJeHicttagirD4HJET+B/094aDudq/JexeIFS0Lddwsyf
         oy55v9PJ7qmbtD2VmcujDuIGr0AB4NQQs/xJcKBVB1DwYb03gXQT5E9FjImM5JmgQV0H
         S5xu9uO0hkglkYdatnwGbyYmRHCB33ct9LK/JK1ARaaMXbzLVrt/vR7zx9x+VEOnNqsy
         TIr5XcoVeTkmoTeHtIf6EPtXlTX6XsOhYTTHFFQDEF78Y78WTCZAq51uo0sfR6hHvXnH
         JQBxZwc5rSxA/vFKcNCEwV/XcjnSuCCIBPGuiumv7Z1ve1CjMI3Yj0x461LtxeqRRVEJ
         XeLQ==
X-Gm-Message-State: AOJu0YzaqvlFW8GMm+DoBOKQW2lgTv/pXJstDN6T6H+HX2LrLzKntwmh
	LTGCBAp6ixkw1nw8IsjJhXUUztfO7D80PeWOjYDTCrZoDOWPbdkSY5v2U1lbO+8PIQkas7Wfp2y
	YU0STdX2jOqVBY+XkyzQv6GRcgiuGw206uZg3ubavN5gFOskOEEjui4TdjIsWWdFwbslOCc7SFF
	p/C7Bdz+J6z40krM62dk1itNiHOiMcNVDLXd0ImYiGpQ==
X-Received: by 2002:a19:750d:0:b0:52c:df10:a8de with SMTP id 2adb3069b0e04-52ce1834580mr6267541e87.21.1719418948444;
        Wed, 26 Jun 2024 09:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiAMtKflpiz6Zx/dw1ERax0IBJ4gYhZCNcDVi0X2nNDaQR8PXtDtv3586cQ3Hi6OWEfwsKEA==
X-Received: by 2002:a19:750d:0:b0:52c:df10:a8de with SMTP id 2adb3069b0e04-52ce1834580mr6267518e87.21.1719418947860;
        Wed, 26 Jun 2024 09:22:27 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82519b0sm31626855e9.14.2024.06.26.09.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:22:27 -0700 (PDT)
Message-ID: <8f85c31a-e603-4578-bf49-136dae0d4b69@redhat.com>
Date: Wed, 26 Jun 2024 18:22:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Donet Tom <donettom@linux.ibm.com>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240620212935.656243-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.24 23:29, David Hildenbrand wrote:
> Currently we always take a folio reference even if migration will not
> even be tried or isolation failed, requiring us to grab+drop an additional
> reference.
> 
> Further, we end up calling folio_likely_mapped_shared() while the folio
> might have already been unmapped, because after we dropped the PTL, that
> can easily happen. We want to stop touching mapcounts and friends from
> such context, and only call folio_likely_mapped_shared() while the folio
> is still mapped: mapcount information is pretty much stale and unreliable
> otherwise.
> 
> So let's move checks into numamigrate_isolate_folio(), rename that
> function to migrate_misplaced_folio_prepare(), and call that function
> from callsites where we call migrate_misplaced_folio(), but still with
> the PTL held.
> 
> We can now stop taking temporary folio references, and really only take
> a reference if folio isolation succeeded. Doing the
> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
> to how we handle MADV_PAGEOUT.
> 
> While at it, combine the folio_is_file_lru() checks.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Donet just reported an issue. I suspect this fixes it -- in any case, this is
the right thing to do.

 From 0833b9896e98c8d88c521609c811a220d14a2e7e Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 26 Jun 2024 18:14:44 +0200
Subject: [PATCH] Fixup: mm/migrate: move NUMA hinting fault folio isolation +
  checks under PTL

Donet reports an issue during NUMA migration we haven't seen previously:

	[   71.422804] list_del corruption, c00c00000061b3c8->next is
	LIST_POISON1 (5deadbeef0000100)
	[   71.422839] ------------[ cut here ]------------
	[   71.422843] kernel BUG at lib/list_debug.c:56!
	[   71.422850] Oops: Exception in kernel mode, sig: 5 [#1]

We forgot to convert one "return 0;" to return an error instead from
migrate_misplaced_folio_prepare() in case the target node is nearly
full.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/migrate.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8beedbb42a93..9ed43c1eea5e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2564,7 +2564,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
  		int z;
  
  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
-			return 0;
+			return -EAGAIN;
  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
  			if (managed_zone(pgdat->node_zones + z))
  				break;

base-commit: 4b17ce353e02b47b00e2fe87b862f09e8b9a47e6
-- 
2.45.2


-- 
Cheers,

David / dhildenb


