Return-Path: <linux-kernel+bounces-417030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A093D9D4E05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDD9282A38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8FD1D90B6;
	Thu, 21 Nov 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUScXwMP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31791CD1EE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732196686; cv=none; b=Dg4aciEBJHdN3mCXTDjG0ZDMwhDWCLaLJ7cdBWymGIs2+TA5OE9wn6/4a6VoA5oxUs7B2onMuVdRDoH7KlmOFQ16a79Ufr7M2p0ir9ZS9gbjPlahzFYYgzEuL7A742clYJfJjiMT2th6FRgD1LtHM6rxCLaC59D7A8mptH6TIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732196686; c=relaxed/simple;
	bh=DynCw4XfUx+Wf86vDjAAsgv4ycv6anlFfyo96v9eYPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhCruvcBlAk2SKtogV0si1cec7DClxDvKO2XtQgWcHBDXsz8Wri2P8fNpKRW5r1+YCkqCO5TTUtaf4kb8UCaVgMIqI20/pQiTjRXhhKyczki5HiuJnXlXX4gcj5tKwE2YfxSSFgA9c4ZO0q2XnKU+Fh5hXiXmCviPWFO/q1V/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUScXwMP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732196683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QiKq40kADGw/i2kCfp5/KzfMuaQ4J7QQN9sLUOYlBLk=;
	b=IUScXwMPrAjKY7FsT66pWnRtgIW2psbEIhWZmve0P+3GeQVkbpIONYm9OGOKW6FKkCJ50m
	anzTQ2tdncEzD2kTHKNB5FfKH39grTW9P/QyFBP0Yv4I5UugVyRnRDasPcPbfTuoIeCWLh
	G29Mwl6umWWAVjMTTAe84UqouUO5Td0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-aTWikmAHOmSUmWksHb9kKQ-1; Thu, 21 Nov 2024 08:44:42 -0500
X-MC-Unique: aTWikmAHOmSUmWksHb9kKQ-1
X-Mimecast-MFC-AGG-ID: aTWikmAHOmSUmWksHb9kKQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3822ec50b64so503679f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 05:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732196681; x=1732801481;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiKq40kADGw/i2kCfp5/KzfMuaQ4J7QQN9sLUOYlBLk=;
        b=MCERMHrsHGHF+1LERvhEs+0HLJjbfpr8aIYrURldzT7YrEpXxCaKZl7HJ25VElXVcn
         lvLpqVZz3m7kzg1VuzLhwrliBGSDH0B+H7FSGiGf00LtE1NHV/DDSLZucBxhhhXLufUq
         c5pBCOKoxX305MSujxNeJBvTVMpYjkYn692fump3IJdY5nXm8Mw9Lhk3CS6JdtMRI4iT
         nrgr3HtRky0N8pw4iYOH81qlIAdC/azQIxGuIsNIMfS/ciRZ+CMzmBfIEDLRePCqKavR
         WZikwFAVX/6uEeMa6qhc2XMiS96XFideWCPYqzvt4Yr3sQiHxDJjiGidQsAwj5FntrJW
         DIrw==
X-Forwarded-Encrypted: i=1; AJvYcCUY1nsgEAcABGZiNX9w0hkwF/AoLSyGGP/prNj/S/B/MJ6LyLJCLmL03W5ffgCqc3r0fTKxKYo38BdqTZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoqBvatN/711HBl9wvKoWg086Nv/YBFXwI6ZisYzOnwXLKPidk
	5dZfOZIt5zX4KxyNBctg3rj1IgpHGTqCGBi6Oz60wn1yLtOVOK71X8ho8u41UxVDvXZKAXCPN/D
	lkWQ0+WBEs/d8KliPfvhZ5bcWoeKv1q847GxuIUc8lymh9EfFfnLQ6fSCX+eA1A==
X-Gm-Gg: ASbGnctTL6yKqe8XzyWnwV5BcNskVlnUdn+EhZK/Qtz1Mwxx/eXxOu0ad1onpZZA/+l
	rTPzEdZWCMxaF9GRm5T3+Cdkm472nRnT4Jk50xdU0suiqLbOboz/TVt1rbPO4LkIe1a0EtB3sir
	evnHRHox59/5Fq5lKwThdKoQKjSCysEWx0A97N6fDfskvEm0noOfErKNly408j+m+i2EnFH6Xh3
	wCUscY0bhGji6QkjDTVrAnFbqJpBjb3+H8CU+KWkwxCkz0a44FoOmFtff/0Ri9IhU4UyvGmsWA3
	nn4ClOgXCsDJlEZMLIJjk37aEp2ZQtJuVr4kDAYAoL9OCLaBHWFFJWspOAYskr2p8izbt5UbXnw
	=
X-Received: by 2002:a5d:648a:0:b0:382:4eef:26e with SMTP id ffacd0b85a97d-38254b1c86amr5009778f8f.51.1732196681234;
        Thu, 21 Nov 2024 05:44:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVnrdC30GKAhFUaf2lQE/XQCHVL4NBJxOu3+ucxhq2+Dmct/wiZ2WWhO6tSTTyyviZC/sK8w==
X-Received: by 2002:a5d:648a:0:b0:382:4eef:26e with SMTP id ffacd0b85a97d-38254b1c86amr5009762f8f.51.1732196680885;
        Thu, 21 Nov 2024 05:44:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:de00:1200:8636:b63b:f43? (p200300cbc70cde0012008636b63b0f43.dip0.t-ipconnect.de. [2003:cb:c70c:de00:1200:8636:b63b:f43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254933d39sm5184954f8f.83.2024.11.21.05.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 05:44:39 -0800 (PST)
Message-ID: <26b82074-891f-4e26-b0a7-328ee2fa08d3@redhat.com>
Date: Thu, 21 Nov 2024 14:44:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: Fix to make vma_adjust_trans_huge() use
 find_vma() correctly
To: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org
Cc: dave@stgolabs.net, willy@infradead.org, Liam.Howlett@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241121124113.66166-1-aha310510@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241121124113.66166-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.11.24 13:41, Jeongjun Park wrote:
> vma_adjust_trans_huge() uses find_vma() to get the VMA, but find_vma() uses
> the returned pointer without any verification, even though it may return NULL.
> In this case, NULL pointer dereference may occur, so to prevent this,
> vma_adjust_trans_huge() should be fix to verify the return value of find_vma().
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 685405020b9f ("mm/khugepaged: stop using vma linked list")

If that's an issue, wouldn't it have predated that commit?

struct vm_area_struct *next = vma->vm_next;
unsigned long nstart = next->vm_start;

Would have also assumed that there is a next VMA that can be 
dereferenced, no?

-- 
Cheers,

David / dhildenb


