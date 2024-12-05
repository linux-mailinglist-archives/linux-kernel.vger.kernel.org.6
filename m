Return-Path: <linux-kernel+bounces-433205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E89E551B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405351664E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DD8217725;
	Thu,  5 Dec 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4Cxk3En"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD33212B33
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400779; cv=none; b=tt1QNBYYYx72kk4xLQpPtr76uyp5Bjx6IoLDyzvoDeqbj0m9BGJJFGzRWmxA7dmxzT2uTV+lDkA/L/kmXxvEAWiRaNea+Y2c2BAlnJggmgs+0d8WDuFuFgyM3NKi+sXM50oIAH7l6aQdEMRCM+ffTJE467fg3lW8eAYmu/yprkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400779; c=relaxed/simple;
	bh=lHraNf/G3W+k4RP4IBrsMzFER5dRx+v5ZVKt3VtrQwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhG2qzUSOdRLCqnm2RZUxncK51CkFxhhf3WXeqCxO3XiES1P+jffjnbCn9XynrhsFI520PAUsaYAXVfgKrrMkZTJFp5xhnki+BYomT4KvZfzG/FYIMLY9DOsC9TV/upVP2AVcLO3Kc+Y+lVpTWHlFxNXFKUJl4JNO3NUEnn2JcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4Cxk3En; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733400776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RpxEfJR+2fv7husKwXZrasLKjioJkVv5Jzo7MA5xZBs=;
	b=D4Cxk3EnlWvCx26jEulXcX3LP7c6Bdm60lfvjiqQRtvL6KNJC19SoCvB/FAu4nl9avBfWX
	MK7ZtPPKPuejwEl41BwCALFYaaBfVS/R4RXTT1MU5qS7xHrdJiie6X2t84C/Myw4LqYtkR
	8EX7CCnUgb48sEa1sxQvZStfG0sjXQY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-l65Ok6INM_ScsPcXxkrusg-1; Thu, 05 Dec 2024 07:12:55 -0500
X-MC-Unique: l65Ok6INM_ScsPcXxkrusg-1
X-Mimecast-MFC-AGG-ID: l65Ok6INM_ScsPcXxkrusg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385df115288so416131f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400774; x=1734005574;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RpxEfJR+2fv7husKwXZrasLKjioJkVv5Jzo7MA5xZBs=;
        b=nMatzWJvlPUZeqiht29ce/20dmFUXjH5lVMG3XsoBtkv+pQHs0MOeZldBvqaBpzqxB
         sWwIFwQtlXU0fe0i15q4WXpP6J9LzkJ1ds74lWEhrfsZUg6BMvm9VmMN2edP65rbxEXY
         v795/CI3K2rUWMUyzzqVDUrKGWySPOZDDaYcqtGQOqiXzQ9B/wP58eZTS1PclK2sn++s
         9dF8g+jWDvX7szP87H6SxbOWXkfakzdturVZDzM/RDcZo2gkazu4xypT8F9Vf37BMh8x
         +V/eBId4LUL6c0yvpyXGgvnRLthzanVCxIcZfhzhPiK6RA3VylyQsvGPY6vwavNqmjTu
         xruw==
X-Gm-Message-State: AOJu0YzabvK+jtpOORXEp2cvH1Ye77HMxxIEQ2hskNjENfPVhk/HXXMt
	MsNQ1NZHVAoVH03itEK07PKUWSCPpS9YM/VmdTa6nvLJiMP2bb0tslHztpiEOqyNiGeVymA+YoR
	8otnHWgUMR5e+hfrKaVxSXaacFV9T13XPtx+1Z2pf7dZkoQQu6e3O0wLQc/m2OfTsJzX9ZvRtg8
	Ydy3h8p1maVHFHj/V47ujHor915TTKxIFl4D1fa/X7ETmQ
X-Gm-Gg: ASbGnctaqnCMkhc9bzIvkqy4rI4kXtbEwJs5ANhV+ISg4gez1v1zShJJClQz+Wn/hrl
	CQTM5sfOd9ia14N/q+ASwcfDo9jH9qhTGV6vfrHlKzkX2173l2gpB6jdG8E+uqSCxiYesMziTPB
	5wSm0rj0wDKqEXJpiX8yWKmopGuz9V+0M01+MAWYRyoiBVzbaJ9BUX+TdCbyhAnZPLGfElYoHiK
	ogtRmlXh5ztnCRt+KuQcB4mEtHtY3ZOm1a9CkxYR/3QjTWPF09O8YFVeJayGOcutRSCjGWbM5x7
	uClortn951d9SGcfiSBkUuVc0GggXIyFMaivCgqGnC9mbEW9xBa/jhU3xGMQz5whudXLcHgHRKX
	5Sw==
X-Received: by 2002:a5d:64c5:0:b0:385:dffb:4d70 with SMTP id ffacd0b85a97d-385fd435fb7mr8952463f8f.54.1733400773787;
        Thu, 05 Dec 2024 04:12:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE/IDlHTTWgSOO4Ba3fAyB2MPIh2SIn28MvGhVdAFZCtfY94/n9L7Psi7gNG2d1bkJPCXkyw==
X-Received: by 2002:a5d:64c5:0:b0:385:dffb:4d70 with SMTP id ffacd0b85a97d-385fd435fb7mr8952434f8f.54.1733400773455;
        Thu, 05 Dec 2024 04:12:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8? (p200300cbc70f7e0075dc9c4033fab5f8.dip0.t-ipconnect.de. [2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52723fasm58232715e9.10.2024.12.05.04.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 04:12:52 -0800 (PST)
Message-ID: <dc19ac6a-51ae-406a-85e9-c4acf2ecb80a@redhat.com>
Date: Thu, 5 Dec 2024 13:12:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: linux-mm mailing list problems
To: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 Zi Yan <ziy@nvidia.com>
References: <20241205085217.2086353-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241205085217.2086353-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.12.24 09:52, David Hildenbrand wrote:
> Sending this via the RH SMTP first, because IT doesn't see any obvious
> problems why the mails shouldn't be reaching linux-mm, so let's see if
> the problems are gone now. If this doesn't work, I'll resend them
> using the known-working gmail SMTP. Sorry already for the noise ...

I talked to RH IT, and it looks like the mails get delivered to 
linux-mm@kvack.org just fine, and linux-mm decides to silently drop them.

Does anybody know who maintains linux-mm@kvack.org? I wrote a mail to 
mbot@kvack.org, but I am pretty sure that is the wrong address.

-- 
Cheers,

David / dhildenb


