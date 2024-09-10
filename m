Return-Path: <linux-kernel+bounces-323625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81299740C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FE5289A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8371A4F2D;
	Tue, 10 Sep 2024 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP3GsCDx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D81A3BBA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989770; cv=none; b=crpguYu5yD2xuIucYN9vkRsTsAD7fWTEujg8me5Dj3rb6emXKGCxR+ramNmcy0OM+qQLmDCdzx0ZSDAbN7iLVjk7kTdftVI1HH78CCUh9ulmMREp+6X0u1VlbUunWu1v7UjYZY3syEZIMDU3R9maOyPgpos6NlNiRfApwbuiF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989770; c=relaxed/simple;
	bh=gGmwWNkb7X9IcLdAb4i6xtsiWbKqXSL8gjAYa5ULFDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uToj15ReNaTfMuiQdCtqyCH1aSKCYXesGm28TLciTgprNvyyvAc7n2aYf/rNVUYxeBpD3ka3t3WHYsJwvJpLAzPnml54h4Vw3vKiKg2Mv4ldOyE6qFKdWFEPkujCC6heIxBIqLBzWwSU1pTbuo3nBYqBb0OqE6GmYfNCUiD6lqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RP3GsCDx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725989767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6j+AAlTwoPTrJSZ2EtbnnKh435cb2m9WmbTK55uDcrI=;
	b=RP3GsCDxbmTH0fy/Ttg9wJaogCzaJ0pdsm6dd6s3jm/kEImICgwPwY+vyra53qq6HaAXVy
	Vld6S6NQC3GUOapHmJop5CbTGVLDbPcwcvPMHqUZ/tuK7uxq4QptexCDx1rtsqo0y94Ddl
	3Q73007e+mmepWsN7+WFcwQhzy/U4fw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-h3FJMX-uPsKEeKYZSzeRWg-1; Tue, 10 Sep 2024 13:36:04 -0400
X-MC-Unique: h3FJMX-uPsKEeKYZSzeRWg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c90d24e3so3996943f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725989763; x=1726594563;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6j+AAlTwoPTrJSZ2EtbnnKh435cb2m9WmbTK55uDcrI=;
        b=ZnOr6JNI3JXHqAYtfDw0JNYN4ISOpWtfORsbA7mfLkHxJD7F9JJqc5GmGv3ZsUdXgc
         g/6iHUgL2Gwmh8jjuwQVPsxlAwE0rhXWd4/7hJCTb1damLjtMvQn7MIRCyBqrvsrczlz
         B0kkoj/2uArei+js+Pr5AHjhmvo2Y7obZ+yVf6hSJMLXVS8iMR2KydkesoweobT9fI5B
         6FmRywLqqv70HStPmm9nKTflA4Kc0L6tme6w11s1BySOvh58EbERlZSts2jmMMi/46zY
         y+h+HHP0HHDDwQFNxpcusqXLu79KfaH5CMOUL8dhEkLX6XlIicz+qPyAGXfKwV6Np8ve
         FQfg==
X-Forwarded-Encrypted: i=1; AJvYcCXw2MA1CZV152a3i6lNQxQf6Ooe4KPGypgM83I5iBTkpMXIXBEOtbKITIwQuttx7AafUSH/FjNecSQkfHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmayijUrQOnObbuW1rrS+xWg/D9gZu5atLUrGfdSoRvxuB/yxd
	efMSkbLLyqt9NbJoxBAL34iupRp08W/Y/1QTWyrsPZ4eLUNrmjMKttw7lH2tIkmX0XrRz9kzzP3
	JDyZGvhUekOBc/xWErf9DNZIwf57KANRr5HB044tO4zSJBDfC+jstI4PWi8iPfw==
X-Received: by 2002:a5d:66d1:0:b0:376:f482:8fdf with SMTP id ffacd0b85a97d-3789229b089mr8893665f8f.4.1725989762931;
        Tue, 10 Sep 2024 10:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ul+JVf5qzaHHD427uksE9QrWJzIkCDQbnRTeJjUVJVl9CgbYtaENlX0I+ODWQwym3oyjJQ==
X-Received: by 2002:a5d:66d1:0:b0:376:f482:8fdf with SMTP id ffacd0b85a97d-3789229b089mr8893642f8f.4.1725989762449;
        Tue, 10 Sep 2024 10:36:02 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37895665762sm9498696f8f.45.2024.09.10.10.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:36:01 -0700 (PDT)
Message-ID: <dc87af84-d531-4938-a525-9bbbf7d714ec@redhat.com>
Date: Tue, 10 Sep 2024 19:36:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] KVM: x86: Filter directly configurable TDX CPUID
 bits
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org
Cc: kai.huang@intel.com, isaku.yamahata@gmail.com,
 tony.lindgren@linux.intel.com, xiaoyao.li@intel.com,
 linux-kernel@vger.kernel.org
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-25-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240812224820.34826-25-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 00:48, Rick Edgecombe wrote:
> +
> +		cpuid_e = kvm_find_cpuid_entry2(supported_cpuid->entries, supported_cpuid->nent,
> +						dest->leaf, dest->sub_leaf);
> +		if (!cpuid_e) {
> +			dest->eax = dest->ebx = dest->ecx = dest->edx = 0;
> +		} else {
> +			dest->eax &= cpuid_e->eax;
> +			dest->ebx &= cpuid_e->ebx;
> +			dest->ecx &= cpuid_e->ecx;
> +			dest->edx &= cpuid_e->edx;
> +		}

This can only work with CPUID entries that consists of 4*32 features, so 
it has to be done specifically for each leaf, unfortunately.  I suggest 
defining a kvm_merge_cpuid_entries in cpuid.c that takes two struct 
cpuid_entry2* that refer to the same leaf and subleaf.

Paolo


