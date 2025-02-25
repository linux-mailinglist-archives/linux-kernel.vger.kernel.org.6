Return-Path: <linux-kernel+bounces-531918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD0A4467D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321847A1F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D6219ABAB;
	Tue, 25 Feb 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wsv91M02"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC071993BD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501624; cv=none; b=OkxYG76zzHFwPaSTHcyeHzeBkxqOh4j6N/9nU62KFxVVYEUOZMGepy1nnr3oWGUWcje9cAU1KBB9/dTEc3bQOp3I6QiAXj4ZkgYYHGZJarmKqa1RaO+fIZYtS5qG7tWG+qDU6iZ5301fO/KZAM9Mp9LWKM9rS325/veAZNWgEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501624; c=relaxed/simple;
	bh=dq+8HNDg8BRX02I5OO99g0tSfk4ytsT+m17eFQ8uGaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcUHgGvpYWSj5rQ2RTl6F5lqfjlYA4wq5mgj2l27UzC9dYGFgg+a8FgbiV2/RmwjolJR4o9WMoErfPEAmoNUU+tYPAKwRzWUyQc6iSn/CW14X4x/UdsTstp63GhrkDeX+DJSrxQvcCn/tdrwjzJsTRVM44VjAWAORNjzXXhFkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wsv91M02; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740501621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U4Oh3/vrBSkk374/Z7EKEQKPnh3zVuDKGXwtuNZoi1A=;
	b=Wsv91M020nZQ3T98hfrChHJAqihW2sJPag9OMAlGo9QmKDAcixmSKeBVTsv3hPbKLwDHI/
	quz625eQn69ib0DcS06i6r1bMkCY1yfy6ucVVmaDVy1JWpHcn3XMFNTzJ5pe+ular7S36y
	tl9jqxl+cWdKzXVU6JGQHHyfckoRCSc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-5uzIJfASNuixgyQkMdLd_A-1; Tue, 25 Feb 2025 11:40:20 -0500
X-MC-Unique: 5uzIJfASNuixgyQkMdLd_A-1
X-Mimecast-MFC-AGG-ID: 5uzIJfASNuixgyQkMdLd_A_1740501618
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f36f03312so2386334f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501618; x=1741106418;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U4Oh3/vrBSkk374/Z7EKEQKPnh3zVuDKGXwtuNZoi1A=;
        b=Byp8AOq637OphnK3uQoq+LlefGAgkjNAkwZT/NnjvJhMGnNos9yiWE/Pq65wWJIKcb
         xeQLxLEBUtSQWdQeM4F36sLIJ7RPvTDQTPkQMbg3Y8FbVsAdMZuQ8zqDKGqRw6yXWRAO
         sQtYIFzRohyYQ9wXhkWicChUYdRueblgg9CrTgwXxKQUNmGDGE5xus5nRg4XnQ4XvG4E
         FI+PTZgoQdpaflINwzNCDYzVWOF6SYeN+GHoLApIHtmGLdf4ZO7xbZoU8N4gHivsqa/X
         F/qkJcqEnQOKW6xO3MB8Dbdkn1kar6bQ5ZQi2ejxX7E+6S/i9jpYn3vEupSCsuZnRAi2
         JM8g==
X-Forwarded-Encrypted: i=1; AJvYcCU4qi4VyVdbLkU13XZ5nfqO0nxnSvqcGXfII8MirUyRfEH9VoFiZeZPucWPhZFgjdtqwhfsZmTO3IHi/gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+pwuH2yapmrcajVh6bNUOTt0e3gjA94bVmkYBWF14vFugTGU
	du1sd24n0hF0oaLAwqega7kZK4LrPboTy21lMn9CGuHmEBUKR1FAet8CoNyF6wYtxqz+Cu9PLhE
	DSWWfGF2H+x7NuHsVw3m1/X8vMEYqPZsZOgitvhF4E9ww+GMW/nXQ392uGWRuJA==
X-Gm-Gg: ASbGnctlIwtEbhmGrpVgQ8h4GnvZfvWTnLcKgOyCmoRSCkcJ4ntF4CoEtOufgrmqHh5
	DN0N8bY5aGXzOxzhwuyWXP/m0PAQIdg/l+DThREP7Ivf0+6zbbASuKGAK894+JicyaVwgOc1E3I
	+JwOlOQldV6n1XpLr74zEzqB50MogfdBJWpTqfj/kzFJUZmsTqr7/WgyzJkkDUKaXoLawXF8I77
	YsLDBwOZLqG5pcutXVZGuFoyx0zu5sS0fzc+eHSl4s987Pn6wAVlwV2+LM4bpiPuCIi282+T63E
	xDAQjZMH/A5H/pk/h/O0uiEaxSemaWJL8/NoGYCNg/SzdHrMFjRUKHgCIXTa4qxtgLH+XZXG772
	5zGWIEh684wHYioQ7ggIaWcAQk8Vt85tINQF1UhwLNd4=
X-Received: by 2002:a5d:6486:0:b0:38e:ae25:6d66 with SMTP id ffacd0b85a97d-390cc602d90mr3723992f8f.19.1740501617754;
        Tue, 25 Feb 2025 08:40:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4Z192yRUSNIoq69lenbZIq8sh7z3C8+8z6i4QqM/6kAzk3/hxUTTncEv3Wq8IYHfakawYKg==
X-Received: by 2002:a5d:6486:0:b0:38e:ae25:6d66 with SMTP id ffacd0b85a97d-390cc602d90mr3723964f8f.19.1740501617419;
        Tue, 25 Feb 2025 08:40:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fc8adsm2889357f8f.98.2025.02.25.08.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:40:17 -0800 (PST)
Message-ID: <80482fc2-393c-431f-b982-acb11de1e037@redhat.com>
Date: Tue, 25 Feb 2025 17:40:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mm: page_table_check: use new iteration API
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1740434344.git.luizcap@redhat.com>
 <30d246e83e73073451dc3d5fe189b733afbefd07.1740434344.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <30d246e83e73073451dc3d5fe189b733afbefd07.1740434344.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 22:59, Luiz Capitulino wrote:
> The page_ext_next() function assumes that page extension objects for a
> page order allocation always reside in the same memory section, which
> may not be true and could lead to crashes. Use the new page_ext
> iteration API instead.
> 
> Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


