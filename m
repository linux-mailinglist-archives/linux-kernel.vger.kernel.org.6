Return-Path: <linux-kernel+bounces-199539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828648D884F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC41FB231B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F1B137C27;
	Mon,  3 Jun 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYiyfTax"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91E97E579
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437499; cv=none; b=mxchTM3Xxg4W6auSojZ1ftlqB83wOxr5FjsGyJD0d8XfbNIMrfnBZxuo1bdsDJGk87zX2YtYzmxAbnzG1eLy5Waf/Spk4myDoGg2Mdw2FxfMXaodVXTxPRPqb91RfmEsBtw+5NxGHSZxEI3mxKWRQ7pqXsTm8UluZ1sm4F0XWcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437499; c=relaxed/simple;
	bh=RI95dbQA79CVBh5SV9S53aHsuN/eUszv0cRTFQAWzqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AU8VpNGOElwW/5iVeVxvln/9WkYNN0bJcNZbkwusXoG2itcnQCgoU8QrHT2AgnBHSnBIIA0IyTQQmu0ZIkcwXWcppcE2XIBsRgZUL5bvvZ/96sI5GNEI2n8r1r8sHh5RM5qdlCV69+ZjtTR+WiVP5gKci2aLf+C0rzpHk0U0dYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYiyfTax; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717437496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZhKzrinOPa+LJLxiGlKxPpoFhujVeaZR4zaTStdiN/w=;
	b=hYiyfTaxHVa7Q47zkO9GOG/BWKkceoHdGoDPIL3jQsWx9WZT6NXlTBvtBP04AsZEFgn1dD
	WiO3q8R9XzIVrNPUy1SP/9n+H9gWyON78Kc0Oph7CId0OJswFX86vB6EtXpDzIBl3n9fUo
	8a9OAKT5jOGU0/fYO4yBQJh9QQvMh7E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-By9OR5v1PVi2lJnm9JyaXA-1; Mon, 03 Jun 2024 13:58:15 -0400
X-MC-Unique: By9OR5v1PVi2lJnm9JyaXA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42129affd18so22009595e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437494; x=1718042294;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZhKzrinOPa+LJLxiGlKxPpoFhujVeaZR4zaTStdiN/w=;
        b=EFYhsnOWo4pfaiMCQ/mZ2CTP8gdBSLQ9tLR4o+hSDRSewchvb6e9wCmp9bDgQ0kZdP
         KlfSdjRXiUcgAoqN5mv+4ACisF2pj3eMmsZx7yfz9d8p9yIGvZUT98z71NnDeuvqxEgS
         zB5p1ZFbIijHUdvp+mqRsG4e9rJMZgbWjnUEdeQit8ft6OgEg1t6kQHo/6CSIEZUQNnQ
         mUxMod3VpMRtubobk7pA0jy40ZJCf1Oeil7r3rV6DVDhUnDoeuD1IhfBAlm7CFXZrdd2
         R4EJevYF2tFwwwHEcq6j0bXK06+d+PV8GTEjC1cagjawP9Ooqqadur9Xz0e8T85ccMea
         L24A==
X-Forwarded-Encrypted: i=1; AJvYcCUXLJyd8y98jMPqdI5uGBO6W+8tRaIGZBFXlUMZGmjK7lOnFzxNbHafvYX0v8XHmXDcwtt+kAERmDVtDYmjktl1FmqH5q38B1MKQ5Oy
X-Gm-Message-State: AOJu0Yxavwapd3xkcdX9Eehlbk0xXj1I4hJiDG12G5kMTj+hnRXoxSEZ
	5erND5Lvbz6Bq0Wd/xoEjJqzZgPV4sdD3Nz9ok6QzBhnBLaH8cfUiGanIzwWLkyNfuKRNV8I10l
	QpOTV+s0tqk6JayENqMOJDzCGdzwQLYgLRlZwQm+B8uMs4/xI9mCgxsP5cBjOig==
X-Received: by 2002:a05:600c:3b22:b0:41a:8b39:8040 with SMTP id 5b1f17b1804b1-4212e0619bbmr79988975e9.20.1717437493880;
        Mon, 03 Jun 2024 10:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbA5kYzyT3IQZ0xDZw/dNHFGjxWu9vmLppArFpBQzO4G92OPsYCQUslLVo+bgBqm18bo3YVQ==
X-Received: by 2002:a05:600c:3b22:b0:41a:8b39:8040 with SMTP id 5b1f17b1804b1-4212e0619bbmr79988865e9.20.1717437493520;
        Mon, 03 Jun 2024 10:58:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:3d00:918f:ce94:4280:80f0? (p200300cbc7313d00918fce94428080f0.dip0.t-ipconnect.de. [2003:cb:c731:3d00:918f:ce94:4280:80f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8b5747sm123145165e9.45.2024.06.03.10.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 10:58:13 -0700 (PDT)
Message-ID: <bec46a43-bd0d-483d-bc75-cd8cb6557e34@redhat.com>
Date: Mon, 3 Jun 2024 19:58:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory_hotplug: prevent accessing by index=-1
To: Oscar Salvador <osalvador@suse.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240603112830.7432-1-abelova@astralinux.ru>
 <3c2b1b1e-c9b3-442e-8f7b-5c7518d3fbdb@redhat.com>
 <Zl4DM_4ll3gFnYLw@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zl4DM_4ll3gFnYLw@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.24 19:53, Oscar Salvador wrote:
> On Mon, Jun 03, 2024 at 06:07:39PM +0200, David Hildenbrand wrote:
>> pgdat is never dereferenced when "nid == NUMA_NO_NODE".
> 
> Right.
> 
>> NODE_DATA is defined as
>>
>> arch/arm64/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[(nid)])
>> arch/loongarch/include/asm/mmzone.h:#define NODE_DATA(nid)      (node_data[(nid)])
>> arch/mips/include/asm/mach-ip27/mmzone.h:#define NODE_DATA(n)           (&__node_data[(n)]->pglist)
> 
> All look fine, but mips.

$ git grep MEMORY_HOTPLUG | grep mips | wc -l
0

I think it owuld be problematic, if mips would support memory hotplug.

Or am I missing something?

-- 
Cheers,

David / dhildenb


