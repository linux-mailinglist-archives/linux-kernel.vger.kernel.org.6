Return-Path: <linux-kernel+bounces-519849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF15DA3A2BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9D21746D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122326B2D0;
	Tue, 18 Feb 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgtDht+V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D5241CA9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895879; cv=none; b=oFX6kyPL9mJGgpoIKI4dbJdTvr5wLQTU4wNiHhJAIkx6V+4N7zpvunxfPEjusFeXS1Du5vjmMO/aFSa4dWJ29ltYqw0gQM7L7khztbOPtPs3yn/hgbFqXgJC4Xb8+eNiSRxhACpe6DNlJRSvl7vNoJ4+Tto+jJAc3bzKMjMKUGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895879; c=relaxed/simple;
	bh=IKDoHpGUmfxPeBpjXsKYMmZ1A12qdzUwi/Q+qn7s55M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1n9Dg5Sm7OqRdqUak7U4cLrgRrybaBCHsCYgU5tRWRJxCvlg8RwPPJaFhqPCkev0CsHSpTyFTLVJ1SEVwm3KJXZarEqGkwAN7coVphNqXH7t8hyCmYEjHkl9JIn11KBeoVJwyacxpajNipycdJ2uE8+IOx3nN2uaxVsZ8m4/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgtDht+V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739895876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hRUi+wRJ+uHkvYz2KdheOXmJhPADMqcYjplj5sCFL/w=;
	b=UgtDht+VN5p0E3k6vEKebC+TWKm22u/ULJ1Mx5NAL6Q9kJq5Gj6Uk1CRuuoPeeRgyYEo4q
	Kr6N22KtWJpj4tC8eM+K5WS9esTc9k6JeuGlOKnnF3r+WmTeihMHAbcNHyw94iTVx/wCTd
	Zyr3FY2J7WDRDPKnePGv350/xYShH+I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-yOGJxiXCMoSsLEaT3SethA-1; Tue, 18 Feb 2025 11:24:35 -0500
X-MC-Unique: yOGJxiXCMoSsLEaT3SethA-1
X-Mimecast-MFC-AGG-ID: yOGJxiXCMoSsLEaT3SethA_1739895874
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-438e180821aso31380355e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895874; x=1740500674;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRUi+wRJ+uHkvYz2KdheOXmJhPADMqcYjplj5sCFL/w=;
        b=nV3dnEdIQY/2SN57cg2RJeMysYlfN/PEICYJeX/aZwfG6VdFXtd4hN3a9Cyz5DMCgM
         EMr97OSbhrZUIbWYxK310kNJyQZlaFFusF0Py2MMBaL3XyKZoWU227u8adGtlbp9oGfL
         dc9i4Nt62bDE8/BbMn+bBo6EJToKXbb2pfRvQPtDxCh4oZlUAZvs0/ZpQ/VZcnTeJ1yr
         gJkHipCZn/Kft/VOwQp5ndOMBoY7GMXrA9XI3NPaEVGbYJkJguhlrm80zm3tbUtEU4BR
         AYpFn6QKNa0w/ylB1KacKyF6M+GhXslrkw284Ag+BwaPrU6sZdKS8VYgKl+BkKgl4UYN
         m/lw==
X-Forwarded-Encrypted: i=1; AJvYcCUoZBA5oxUPt9HPNlhPa5uN92lgqLuTRnMlv1pFJiO+vZKXfOY50poEI34tqZ9UX4o8acVgFRkHinqvCe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5ceTmqK6xzVmvVsTZQPPzENH0f7SEi5g4hz1g8EX82ak6uRj
	HAepFb3GZnc+ZlQWX8c0UAGETwC05ZEixMwCbpSRCME8VIUrxYuHMB382vSIGDfzL/sr8dJzD6K
	9qKvkynB8ibR7wfFFvKRymU7c9qE3y28Rmdz8PmbItLtwXsaBeeBpcnT+WNoOp7aD8ErVvyTY
X-Gm-Gg: ASbGnct5WLfrtmviBL5MO1Lc7tdZ6I8shbZoYRo0ms1T5IRgH6f+nTb4ZzSrGSa3Kh8
	Rb+AS3DmGrV+xlm18IZ20smV5CltABD/67THFKsnoSZ8ZVCjqae3E3m4OV/0Pkqn8aaHpc8TdYM
	7TzGFZRlB1qlTZZqXCbdX4rspUqcAUJEUea8AuOHQyOPjQH894clSMJipHy/jpj6q9pAqPKHQAE
	YYhpqfUbv++rU0NdOiagvRPd3MhgHixZ0+kiQIChQls1f+0MvwIyRFB4ze3jLd5sZq7wbE6YcaJ
	ur6KOpE3A2wBiLuxy+yYkgF3Y0sylBnnUWgO74MCayGeYNAGs/0B5WwH7kR78bu0eSDliqOb9bJ
	Gg9cwUnnI6EcVXSosaGLX8gAANeKnqPx3
X-Received: by 2002:a05:600c:4f46:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-4396e779e07mr137823885e9.30.1739895873310;
        Tue, 18 Feb 2025 08:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiZ5rxlHdxPXpFFPr+JzM3cpCvVqgrwjDbUwnKiH44aMUSFkhzJPtpNvmRTDQhv+wflaXtjA==
X-Received: by 2002:a05:600c:4f46:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-4396e779e07mr137823665e9.30.1739895872917;
        Tue, 18 Feb 2025 08:24:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4423sm15693969f8f.11.2025.02.18.08.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 08:24:31 -0800 (PST)
Message-ID: <2f759351-a01f-4b1a-bf37-793a42a67c69@redhat.com>
Date: Tue, 18 Feb 2025 17:24:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
To: Gregory Price <gourry@gourry.net>, lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> ---------------------
> Step 9: Memory Zones.
> ---------------------
> We've alluded to "Memory Zones" in prior sections, with really the only
> detail about these concepts being that there are "Kernel-allocation
> compatible" and "Movable" zones, as well as some relationship between
> memory blocks and memory zones.
> 
> The two zones we really care about are `ZONE_NORMAL` and `ZONE_MOVABLE`.
> 
> For the purpose of this reading we'll consider two basic use-cases:
> - memory block hot-unplug
> - kernel resource allocation
> 
> You can (for the most part) consider these cases incompatible.  If the
> kernel allocates `struct page` memory from a block, then that block cannot
> be hot-unplugged.  This memory is typically unmovable (cannot be migrated),
> and its pages unlikely to be removed from the memory map.
> 
> There are other scenarios, such as page pinning, that can block hot-unplug.
> The individual mechanisms preventing hot-unplug are less important than
> their relationship to memory zones.
> 
> ZONE_NORMAL basically allows any allocations, including things like page
> tables, struct pages, and pinned memory.
> 
> ZONE_MOVABLE, under normal conditions, disallows most kernel allocations.
> 

In essence, only movable allocations (some kernel allcoations are movable).

> ZONE_MOVABLE does NOT make a *strong* guarantee of hut-unplug-ability.
> The kernel and privileged users can cause long-term pinning to occur -
> even in ZONE_MOVABLE.  It should be seen as a best-attempt at providing
> hot-unplug-ability under normal conditions.

Yes and no; actual long-term pinning is disallowed (FOLL_LONGTERM), but 
we have a bunch of cases that need fixing. [1]

Of course, new cases keep popping up. It's a constant fight to make 
hot-unplug as reliable as possible. So yes, we cannot give "strong" 
guarantees, but make it as reliable as possible in sane configurations.

[1] 
https://lkml.kernel.org/r/882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com


-- 
Cheers,

David / dhildenb


