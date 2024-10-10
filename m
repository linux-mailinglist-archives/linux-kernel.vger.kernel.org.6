Return-Path: <linux-kernel+bounces-359017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C015C998654
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497D61F21A54
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B58B1C6F4B;
	Thu, 10 Oct 2024 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvQOwJu1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51B1C68A8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564054; cv=none; b=kAwNA0oQ20DLRvO+FLBTLEEp6n2VhkdzTMKS5LV44yksNevhmGFl8iKPgljzpNw7xEbZHxXPwlyh9TEgpusfU21l69UOY2vsLZjvG2/KpjPuzdnfW2Aj8ydNGHBbGDu4bp/rPcE+P72mCth3KeaSoj6hKrgLiPTM4FCsXzCDUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564054; c=relaxed/simple;
	bh=hj6/rJOhBAPj9FAjBFl/0JgbYaSLLJuXDxMIjgHM29g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COMa+iQWcDJnM5bbet/OKocjiyy3awXrXLnZXykkA/hBpHfQjE2wtARUUH6Yd7ZA99xL+EUj6D9Kf5Dvbja1fFUFQXrwB/PhvucVvChAHYw96vvm3ysSCh1tjX6tG8gawm4/v93mA7RNnW1wu//87dDPbepb4AleApwK21cP320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvQOwJu1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728564052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lMFODkR2vW9a0hERyrHa5UI56idc0n9E0W4rHG9DS2g=;
	b=WvQOwJu1drxxue2JtZrOsz/C6wzKYzR/pOV86TS0oCuEzV4ZkN24s1QNHfT4IWLsLz9zX7
	I2GXHaEJP6aLEu+iRIe8KFns7a2ky/vVkaDM58AzEuUwFBo2W7FDBiAKu4qr+6sa7fan6a
	bOcac17efUekizYzwImJ2E47ii9F+u4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-FiuXOROANrepzR7BPr5dMA-1; Thu, 10 Oct 2024 08:40:51 -0400
X-MC-Unique: FiuXOROANrepzR7BPr5dMA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d462b64e3so310066f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564050; x=1729168850;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lMFODkR2vW9a0hERyrHa5UI56idc0n9E0W4rHG9DS2g=;
        b=esCwJm0LAGtElk1RYZzwGLkUdhTMKWbv/AcoxbnVV7qlp4DMhbeXZX0j+PkMzaCIrw
         zdtztiKInPgFTgNqUowrtAAchopqhy7GeDltldhaLwmlxm0ER5X02bvzGt/iGtN0bIG6
         Hy+kmShooGtq6BFoZ990vA9xSlmNg9KyMnP+kTRRen6eAJZTSddM575ZTMDImDOLHr0b
         XrHOz+1KkJ8FNwkr7U/zZLAnjt/xR0Vw0DM1aWBL6eZZ95NJYSrU5mnmbIZOJvFnfzgV
         sTHzauKNAgrOf5nyPRhsaX9GgTimroZxuJ98BIzmCsb2F0h6RASHmNgdpzxOKMy3UUjK
         D+0g==
X-Forwarded-Encrypted: i=1; AJvYcCXkvIarJlviP8HDzW5Dd1G/OpK6pq5eHAz6es+KA6i4kX0KR2hwrpSk4h+HLyzPmdreLIOloKIV7Z2UVL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vCZ7TKJjBGi9GkJ3yeoWXFMmclK8cpZOYoFhvq9Q7Q41pG+F
	gcAXuMg/c+KxPeVHz7zV2Z9ZU/qfroJPGDcD3cF8+98Mix2wwzPjrI4i4p245x+lmoxI0u3s3iM
	c/9PAMUbLKsVpbWFFLsFbYSGJrZ6cqsl2Afjs2SC+aECASM9vWLp2wimoFajlmw==
X-Received: by 2002:adf:f6d1:0:b0:37c:d569:97b with SMTP id ffacd0b85a97d-37d3a9d3c7dmr3829041f8f.19.1728564049959;
        Thu, 10 Oct 2024 05:40:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhRH0ZpjXpF9EqcbW90ozg8Hyr1TAYd4ehAfCcOhkuuhD0Unrx1FsjGmhIuRLbrpNtk4DKGw==
X-Received: by 2002:adf:f6d1:0:b0:37c:d569:97b with SMTP id ffacd0b85a97d-37d3a9d3c7dmr3829026f8f.19.1728564049570;
        Thu, 10 Oct 2024 05:40:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:9200:eb2e:74f9:6f5c:3040? (p200300cbc7429200eb2e74f96f5c3040.dip0.t-ipconnect.de. [2003:cb:c742:9200:eb2e:74f9:6f5c:3040])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd266sm1469333f8f.40.2024.10.10.05.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 05:40:49 -0700 (PDT)
Message-ID: <037801d9-8923-4d49-8423-072fd7c73069@redhat.com>
Date: Thu, 10 Oct 2024 14:40:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -V2] tdx, memory hotplug: Check whole hot-adding memory
 range for TDX
To: Huang Ying <ying.huang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Kai Huang <kai.huang@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Oscar Salvador <osalvador@suse.de>
References: <20241010074726.1397820-1-ying.huang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241010074726.1397820-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   extern u64 max_mem_size;
>   
>   extern int mhp_online_type_from_str(const char *str);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 621ae1015106..c4769f24b1e2 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1305,6 +1305,11 @@ int try_online_node(int nid)
>   	return ret;
>   }
>   
> +int __weak arch_check_hotplug_memory_range(u64 start, u64 size)
> +{
> +	return 0;
> +}

BTW, I remember that "__weak" doesn't always behave the way it would 
seem, which is the reason we're usually using

#define arch_check_hotplug_memory_range arch_check_hotplug_memory_range

#ifndef arch_check_hotplug_memory_range
...
#endif


Not that I remember the details, just that it can result in rather 
surprising outcomes (e.g., the wrong function getting called).

-- 
Cheers,

David / dhildenb


