Return-Path: <linux-kernel+bounces-200743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E68FB43D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C761C22284
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B2D9476;
	Tue,  4 Jun 2024 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqUFthtZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA85E8F45
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508836; cv=none; b=rEX+ouwEkGOVfrjo1yMQEPYwGDE9DClgDf2fGr7LLV6ocJAozWUmUw7mPSIm5vDJFiMPklUOUFfR3LrEgNceH9DRE9NJiBmfJDaYsRl/FKaQj+z3HNZRa37B4nrp4E2XvF65cW63o0b1cvtp1TrJfmDFHoK/xeTrWOJaf1eX0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508836; c=relaxed/simple;
	bh=xcyNIN9iyRLtVEDvM3CKfI2Kj0V1Sni+Zer1GeAXDEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7Xx9JN86a+tNoGKwHxiNs7bd6pyD7r4Yvtp9lujfYVzx1zucO4HcjKwC6OCbeh/Go8nVirqQcx/kw6K6gHdl3kcHtYWuvfruuR6fPPq8WNCckRBQ1dQBFEc4B1Fs8LJ2misxY7f+PBkCaAqqnQs9SxY6yIpkZGyI6wsC6EKUZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqUFthtZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717508833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yMbmCAiowVSKw7W9moNE/x2fGNsBHZfDEwu/zot2o7c=;
	b=NqUFthtZHbz2F1A6CI5bVsg85CJO6UYvaI/GGx5S4gLBsfxKWA20ULoKc8VR/Tyx1dPxrI
	LxOMZ2KZQSk2cGNj6hFP8GR/UPHDvFVV7JThSrj1YJwR5Y3uf3GZayDNvPDlbeXFjcQ9UZ
	ZToqMu5FQicp1uGe1tUS1PqIwvtO7cQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-n4wpB9djNLiutzkLNu9zBA-1; Tue, 04 Jun 2024 09:47:12 -0400
X-MC-Unique: n4wpB9djNLiutzkLNu9zBA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42120611b0bso29613045e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508831; x=1718113631;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yMbmCAiowVSKw7W9moNE/x2fGNsBHZfDEwu/zot2o7c=;
        b=WyWWOyW6QKGWEOf3AZkSF7kteTpYFlEilltSyKbSbx2yJ6TX91ouAWxyKQ4OQHiXLg
         55by0jZ8FgJ0SlTPkywy2d30rjkzvmW2bFlJ7v2Ux4ShFI+H4eXpSryh/Y0ERzvPbp4Q
         EvNXSuKb5gh0v4TgczUUZ87H0ry9ycgGu5Eo987fvkusbYEgUd9Icjz/zwOOHjWlJg9Z
         wDlfKR6oq35ZW4OyzrNpBnsxz8elPxVzYuD+OAVwiJYWjJed9diQP4oGWMY8Sxyz0fuL
         WJWeOzGLI/7/c1MutQOnOUR0s0p1qWmeGu33cP/MDo/fSB7Mz/GpPDWEqPNBJIxcS2d0
         ZO+g==
X-Forwarded-Encrypted: i=1; AJvYcCV8y3P6N8Om/CJ7NbW3Lp6KLQrtNhBgUw3cS7bRM0AjLIJLnY3vzdRhr038hUkqX/JrcSR84fAmFInb9NflTo6cvheuwa64mFtGUTBs
X-Gm-Message-State: AOJu0Yy9e7hPlTPxR20kGTZMDO1/bZ5fXN2zc7LeWDTzr0kpWeRlxlLw
	m+++3IhAEniN942L4csE/gVPxD/iJnf3gc5tfrb4N9Uoe+Gn5OEL03eotGmpqdMyBgOJYsya9Q/
	qiWJ07yf9U0fu03KjwdY3efPH2dBbjtwwxzQb7RVqb6731UBHkmAyynbamWeWow==
X-Received: by 2002:a05:600c:3152:b0:421:794:9630 with SMTP id 5b1f17b1804b1-4212e0499d9mr88315315e9.9.1717508831024;
        Tue, 04 Jun 2024 06:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGpw168oErqt3u5yrQSWRtEhAJ44WH+7QdOvwB21PWxv3a6Z1jPfpU0r+q9XLflWsAy8ooTQ==
X-Received: by 2002:a05:600c:3152:b0:421:794:9630 with SMTP id 5b1f17b1804b1-4212e0499d9mr88315135e9.9.1717508830619;
        Tue, 04 Jun 2024 06:47:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42136e0d9fbsm113769835e9.28.2024.06.04.06.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 06:47:10 -0700 (PDT)
Message-ID: <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
Date: Tue, 4 Jun 2024 15:47:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1717498121-20926-1-git-send-email-yangge1116@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1717498121-20926-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 12:48, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> If a page is added in pagevec, its ref count increases one, remove
> the page from pagevec decreases one. Page migration requires the
> page is not referenced by others except page mapping. Before
> migrating a page, we should try to drain the page from pagevec in
> case the page is in it, however, folio_test_lru() is not sufficient
> to tell whether the page is in pagevec or not, if the page is in
> pagevec, the migration will fail.
> 
> Remove the condition and drain lru once to ensure the page is not
> referenced by pagevec.

What you are saying is that we might have a page on which 
folio_test_lru() succeeds, that was added to one of the cpu_fbatches, 
correct?

Can you describe under which circumstances that happens?

-- 
Cheers,

David / dhildenb


