Return-Path: <linux-kernel+bounces-359043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966FD9986B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94D91C23AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FAC1C7B64;
	Thu, 10 Oct 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld7bUSNa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAEE1C7B70
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564881; cv=none; b=BeWZHBQIInrAeDiLAK0bkF1SK5E/8Ve/3Zb/b4pGPIvkr5yMokCGl164PfrNVVvm0pvZzaPh/ksg1RT8NlFtFz2dfLdIio5otK8MemE/alCzfGttyQHSX884RWZz5p59an/MaM9zZF2QznSXbAXcAbsA7HCpR6A2J23C4ILQ3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564881; c=relaxed/simple;
	bh=b7gxtVekXd5R3td+Z0Cu5zRIBs3g2P0ZEA517vflQkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njAdUK1Yfg6hxSrTqf2szsAPhOTEVWQXDnqxdCV+TQamv3IhmuAw3KMKod1GMzdvyj6h79GexZ03OpmCFh7tcd/LGm7eSbnKt2ZfHssIC9Wcvg+hG8jyl4tbMkmnxdKRWvs8ZKSJbZIopbQl9XHBf/lK7onEvvYIylPVKitjax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ld7bUSNa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728564878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cZL6g0fMpa/mgW56phL714cp05p/JmPmKoNz8gp0+y0=;
	b=Ld7bUSNan79Leea62U2g6KXlZNXa+zFatB7rpXE/aNMPJnpfwYo+EJqukGuQBPdVE2tRkw
	AeN6UT1UJEJ5uSwUBRzjPcPSUZNQcnNp4TiQSt8FPm80FchLQlC97+3mExdUyG3MiKNi9I
	mW7F6j2v0UGowKRMn2g3wu32Bkx7unw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-mG-yzIrCOM6r3S4gtQG7Cw-1; Thu, 10 Oct 2024 08:54:37 -0400
X-MC-Unique: mG-yzIrCOM6r3S4gtQG7Cw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42f8ceb8783so7236105e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564876; x=1729169676;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZL6g0fMpa/mgW56phL714cp05p/JmPmKoNz8gp0+y0=;
        b=QTwEnSLcHDEvRxZVQ6hDJwpvaPkqjFRNaD0mWE6knEBscHMpC/vMFz98NBNHDYm3mW
         h/ttFezAkX+/iyee0aXAeUlR8pB9Kcn+GWUVmcvO2F+CB3Sp/ybC0N95x3IS3CO2BFnn
         c6d4stHxEErXcfViMhvBVXwpKctoI8Q4LKj3OpEu2Uii2QXjh3907GKpXoLe6g+Y+zzA
         oli/VC8UJcUifgLJ2uCy5XO7Q3p82DyNKbPqpAJwH+SCzIehoRo/c8rLv8qenFL3H40B
         KBNoyqmZMsUpcokBQbyV8Qm05uRBQooeJ9riucWXUGMIzfwGlSpIZmhHD1xu6zfoyLZf
         nONA==
X-Forwarded-Encrypted: i=1; AJvYcCV4mrqxkBY55/yg839ica5xBeuOzbB+/oszI5GddOkw8uFaZ+0w+3wRZRY8fzClK+Z78yAb+Wlf9bgPlHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZHqLfOk/Llmr6rGEYxOzvutSWxR8IX7zhryB9veH5gBSeeYh
	Ubqx3N4lmL4AmAn1geo8blLmTI/MqUjU29WW/4j/DQJP7udP65EVt7SuIGdBd/38nvynOEp6XAL
	XEyrWLPnsKd/I2n1SbygPNHgyUxFPcAHUea7gWQGIjn1uPo7i/EMlId8KGZtsvw==
X-Received: by 2002:a05:600c:3148:b0:42c:a89e:b0e6 with SMTP id 5b1f17b1804b1-431157aa5cbmr32393965e9.11.1728564876366;
        Thu, 10 Oct 2024 05:54:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2p8L8ELIXrumoPAPLW1IaY8NSi4pHxZ0J4QVILie3z6IAvUH/Ukh/rrSs7O2Sy2/qpzBUWA==
X-Received: by 2002:a05:600c:3148:b0:42c:a89e:b0e6 with SMTP id 5b1f17b1804b1-431157aa5cbmr32393715e9.11.1728564875932;
        Thu, 10 Oct 2024 05:54:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:9200:eb2e:74f9:6f5c:3040? (p200300cbc7429200eb2e74f96f5c3040.dip0.t-ipconnect.de. [2003:cb:c742:9200:eb2e:74f9:6f5c:3040])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4674sm48380265e9.38.2024.10.10.05.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 05:54:34 -0700 (PDT)
Message-ID: <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
Date: Thu, 10 Oct 2024 14:54:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
To: Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20241010065558.1347018-1-ying.huang@intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241010065558.1347018-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.10.24 08:55, Huang Ying wrote:
> Currently, if __region_intersects() finds any overlapped but unmatched
> resource, it walks the descendant resource tree to check for
> overlapped and matched descendant resources.  This is achieved using
> for_each_resource(), which iterates not only the descent tree, but
> also subsequent sibling trees in certain scenarios.  While this
> doesn't introduce bugs, it makes code hard to be understood and
> potentially inefficient.
> 
> So, the patch renames next_resource() to __next_resource() and
> modified it to return NULL after traversing all descent resources.
> Test shows that this avoids unnecessary resource tree walking in
> __region_intersects().
> 
> It appears even better to revise for_each_resource() to traverse the
> descendant resource tree of "_root" only.  But that will cause "_root"
> to be evaluated twice, which I don't find a good way to eliminate.

I'm not sure I'm enjoying below code, it makes it harder for me to
understand what's happening.

I'm also not 100% sure why "p" becomes "root" and "dp" becomes "p" when
calling the function :) Likely this works as intended, but it's confusing
(IOW, bad naming, especially for dp).


I think you should just leave next_resource() alone and rather add
a new function that doesn't conditionally consume NULL pointers
(and also no skip_children because you're passing false either way).

static struct resource *next_resource_XXX(struct resource *root,
		struct resource *p)
{
	while (!p->sibling && p->parent) {
		p = p->parent;
		if (p == root)
			return NULL;
	}
	return p->sibling;
}

Maybe even better, add a new for_each_resource() macro that expresses the intended semantics.

#define for_each_resource_XXX(_root, _p) \
	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))

XXX TBD

Or do you think this should not only be "improved" for the __region_intersects() use case
but for all for_each_resource() users? I cannot tell easily.

-- 
Cheers,

David / dhildenb


