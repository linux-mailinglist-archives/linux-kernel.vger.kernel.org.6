Return-Path: <linux-kernel+bounces-347605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF48D98D700
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF821F21128
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8ED1D097D;
	Wed,  2 Oct 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRPWUyjC"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306971D07B1
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876692; cv=none; b=d2SLstNMkZ4iMrWL25wrcdHnSUBFaKxeyxqQAU8lLuGdXsv2tl37Mbu/6fVDz7bIhtTu3UJbyDmk7m/0LZkrCh/fPOxNSvhd5noOLfbo6Vpmbq5BtKewQypYyyGybGwkGRfezk5xXrI7faKi6LLu1vX5+kFtxF8vMJofcV6zbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876692; c=relaxed/simple;
	bh=cv3Wi9/dS6P016r+S0RzNBBBYM5AuDvKiZ7EU/GpwM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSDQCTYMKhvFnufNPXLoxE8rADYmuEcZxrMZEa4P6XNLPzDkoWuqNS/ut4Wq1gkM021Jg65zlBU3JHnZbnyAjXIaAgcZRm9nI+GqevZH32ezVLxL+VgP1sWkc7qQYE2wB2yUN97dYNDMn3AwutKUm9QG83IonBGDSkhwhvtW23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRPWUyjC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71b0722f221so5196872b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727876690; x=1728481490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YE8urfYiXbQFqJICPyefZGx5NOOnXfSSbBf64RDrHVg=;
        b=jRPWUyjCuxVSS4ZuzBfcvNgycMA/pdiPJy3AkTtneLjd/bPsJFu624e9y+V0nKlo3t
         IjLRb8g9f8wsKgVG6CeuSxDgQJq77ZNZWG+bM0BKqWg4qrNbCcKYcT0rTyaitnvbVkR+
         yGLwSg6UxRa9svdHCBi2uVBPqHycE9dgPNRDF3g+4mOlZxjIm6CYPHnjyFEVC2AiOsab
         UbQyQnHmZUdTpX6rgXhj+bQl3hSxWaRPiH2byCh+eLncKTPkjW+J6PjzQWydaY+vPgJu
         pgWIGiLqm1hSQl4KDPzjOAcX+wda+3Wi7nf4g3PBoWPWz4/jewCS+HL/2gFFxwRWFr7V
         ednw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876690; x=1728481490;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE8urfYiXbQFqJICPyefZGx5NOOnXfSSbBf64RDrHVg=;
        b=Opf1fq2Hbx+/Z+gYvldmXARcrhauppcGuGfuQqLWCbRDbsvO8nQ3dNljEmIQCgKcve
         A1y520VzFXMmlwArUOfvuoIZZ4C2ESC0muoB66VhYbjyHSfd+TVUJj3sOx1+o9pARz41
         +ns7vglbXNSJfwpkg1ymyCLaRyKHW2dSEIgW05V9LMxLW33fEifiBpWu0MX0bgMUL8yK
         AlD4K75sQj61DsFwujStnobw7v5K1ToedGxptob/+9irM6Vtuq7qKGi3hCF/OLz7ox7F
         wfC+e7gQb/QlXspaNKmqNpL88xG9h2sHTkSuIXqBKC/P90laQ9/7roCcyrUJXAK4Di53
         t36Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUra/Bo6b6G91b9ldHKOU0E6unUVANbm67DGyRWYqJz8R08Hwhp+w1DVcmA1/7rQQw4GK/V41UsmhuEO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2oGH5d3qzumlnYTtHcuZbqNPsKUY1l6ktQ+ssEA4gvI67Pgs
	yK9E98SHRxurx1gPdERvBKmS1M8hPVJhCHwbh+F6ttW3Ba2qjH3D
X-Google-Smtp-Source: AGHT+IEVMcXyTUDlxSJ9r6BoTZNOT3G4o8OCZgkZkTnidUvzqpoGP7L+MfxdIEUKvvlOYixouvvxXA==
X-Received: by 2002:a05:6a00:2d06:b0:717:d4e3:df21 with SMTP id d2e1a72fcca58-71dc5d8707emr5071072b3a.23.1727876690320;
        Wed, 02 Oct 2024 06:44:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649ca2dsm9800664b3a.41.2024.10.02.06.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 06:44:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5dd5035c-e924-42e1-8088-225552e53036@roeck-us.net>
Date: Wed, 2 Oct 2024 06:44:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab hotfixes v2 1/2] mm, slab: suppress warnings in
 test_leak_destroy kunit test
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel test robot <oliver.sang@intel.com>
References: <20241001-b4-slub-kunit-fix-v2-0-2d995d3ecb49@suse.cz>
 <20241001-b4-slub-kunit-fix-v2-1-2d995d3ecb49@suse.cz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241001-b4-slub-kunit-fix-v2-1-2d995d3ecb49@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/24 09:20, Vlastimil Babka wrote:
> The test_leak_destroy kunit test intends to test the detection of stray
> objects in kmem_cache_destroy(), which normally produces a warning. The
> other slab kunit tests suppress the warnings in the kunit test context,
> so suppress warnings and related printk output in this test as well.
> Automated test running environments then don't need to learn to filter
> the warnings.
> 
> Also rename the test's kmem_cache, the name was wrongly copy-pasted from
> test_kfree_rcu.
> 
> Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202408251723.42f3d902-oliver.sang@intel.com
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Closes: https://lore.kernel.org/all/CAB=+i9RHHbfSkmUuLshXGY_ifEZg9vCZi3fqr99+kmmnpDus7Q@mail.gmail.com/
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net/
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter


