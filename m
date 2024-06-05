Return-Path: <linux-kernel+bounces-202046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5DE8FC719
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966261C2245F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862A218C33F;
	Wed,  5 Jun 2024 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG7GQkeC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365861946A0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577826; cv=none; b=uzD7aXz3tTrjSnwk3tgNMiVNIuo6haB24cF49bcloXMZ6jl35+WVJJyM1EkaOPgNspUhtvfiVOzTZcwc5GgRtE5qJej7fa/YS2gOlBCgdXJlcTniZR30FFJBbm2xTEmcGwjw/s4gdr+XN2K+50gKaGHsknd+tTvVU3g28rhFTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577826; c=relaxed/simple;
	bh=/QMnipj2G9Sr6fjvNnZzh6sOWlDwYxtbm93HhdrVGK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HX9xh7yu7c6NY+y+rGS0TXXgJCZmT3Sz1VobGm35b3RTWQjqdGGm+vAP5CiZ/JR/v+pVMNpFG/+010SrT+hRsgklkJOvekMpV4XawjLgIdp2ZGdpRpn0IW4BKDzKPKVO9zE63sZlnxTeZrEhxqz1U4auiD77+FA4vwiaCR4qrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG7GQkeC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717577824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w0bFqpSRQD21NgUftZIxEKz3765lHvDJTxmHllUFMzo=;
	b=JG7GQkeCfzputCq2mWXgzsTaSYx9Ot3MWRkbS8TOdDu2457tP1iYl3Hdvkxb3hpbchCwDa
	Xq+SaFBQNeqB98jk+liadEkgHb2WHQN+nmIQzj5CIahZewTAfVC/NMiCnvosvDyZKGnok1
	KzQmH6RLtJQ+QP/dFqfFCNgnWh4i6YU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-e1yGpMzcPpOHkZW0S_cP5w-1; Wed, 05 Jun 2024 04:56:58 -0400
X-MC-Unique: e1yGpMzcPpOHkZW0S_cP5w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4212e3418b1so32608905e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577816; x=1718182616;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w0bFqpSRQD21NgUftZIxEKz3765lHvDJTxmHllUFMzo=;
        b=aowC6r4MYqW/hBrNoB/L3ECAlkE55bZxSXk2nOfr0IdOGiBygbbkFR/AlFxz7g5i2+
         v9hWJ6XYMwiqOaHgIL5B5dTKS7xjjNivBekc+xkeLolO+tb9YJ2fsYJnAt0zannpOrXK
         2xbZx5XveIu/QymKYlyc4AmEDhV1USnaw/uogXsZTPjk3RZXN1mVRomk65PKG3EJ8q2E
         eegrZnIb2c9Q7/ZIngQWL3A81xGlHllx/b8NrlXw4fO9uy6KnJejwiMg2jv/4sTK4vhr
         LXutsXbb9JOnsazUjpozJ3Zr8mlpE9Gg5S05wSDDGQlRQOkg2RkRTdxKExZDExxmvLK4
         aMmg==
X-Forwarded-Encrypted: i=1; AJvYcCXiY97sBVkjyRtYMydVJ8iWOaimbJinAD0LDi7GHsv/cMX3Cwa4zr+2Rdg3pJpbDTXE0cuaReqpXhr4MozbM+UEuDsi//dZNs5DenlD
X-Gm-Message-State: AOJu0YxXpqqAoxGdm09PP5JDES8DwR8/jbkjIjU9vDm1XZTeC6SxCtdL
	99Ebbelul7k8l1bGgCfLfZYh0XNfexLnd8jPcq1ljmxVaJlAdoN/DqJleei8Fl4ZAHGbiPNv8NI
	G3nebYD4wPBD9DeqRX6r/hLcSJVDNpVcJD/MAGbA/Q4EFIjIfgL73X5AnyfMdDw==
X-Received: by 2002:a05:600c:1f82:b0:41f:e098:53e with SMTP id 5b1f17b1804b1-421562dd2f0mr14957925e9.17.1717577816081;
        Wed, 05 Jun 2024 01:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERrPQ9XbevODiO0C2X/pegy0DCj0b/2Hw86UPgVGS8bSD7QuD3FDizWmFk+x5RRppKoX/SkQ==
X-Received: by 2002:a05:600c:1f82:b0:41f:e098:53e with SMTP id 5b1f17b1804b1-421562dd2f0mr14957755e9.17.1717577815714;
        Wed, 05 Jun 2024 01:56:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e7d4ec8b3sm4397828f8f.48.2024.06.05.01.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:56:55 -0700 (PDT)
Message-ID: <4ec4dd03-abf1-42a2-9460-b15df6ca21c3@redhat.com>
Date: Wed, 5 Jun 2024 10:56:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] mm: huge_memory: remove
 is_transparent_hugepage()
To: xu.xin16@zte.com.cn, willy@infradead.org, ziy@nvidia.com,
 akpm@linux-foundation.org
Cc: ran.xiaokai@zte.com.cn, yang.yang29@zte.com.cn, mhocko@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240605163731027tu4GJzm7fzc00snHCyF_3@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240605163731027tu4GJzm7fzc00snHCyF_3@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 10:37, xu.xin16@zte.com.cn wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> is_transparent_hugepage() was first introduced to ensure the page is
> 2M THP page. After commit de53c05f2ae3 ("mm: add large_rmappable
> page flag") and commit fc4d182316bd ("mm: huge_memory: enable debugfs
> to split huge pages to any order"), any large folio of mTHP suitable order
> can be split, not only 2M THP page.

Yes.

> so the check in split_huge_pages_pid() is not needed here, instead
> a folio_test_large() check is sufficient. To ensure a 2M THP folio,
> we should use "folio_order(folio) == HPAGE_PMD_ORDER" for now.

What about some kernel-allocated large folio that got mapped using 
vm_insert_pages() and friends? Are we sure these pages (that are not 
large_rmappable and not splittable) are properly handled?

-- 
Cheers,

David / dhildenb


