Return-Path: <linux-kernel+bounces-259756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E49939CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB891F22794
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2C14BF90;
	Tue, 23 Jul 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFhUWX6d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD114AD22
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723303; cv=none; b=M2vuYRwsHH6lYzdRdT4of99wxL6GqoTbqUFsHnkgxNr4V+2Wagv8Pyr734AKv6FKi49GTUMDnqG68VFCW2kFIAWhF5uSbrYAthkxULcUEcpqq0lCVBP6Pkej5axqGIs2fU2jZh5wozQwQLCJXevRr1LdObvYNuqeENxwoFDlp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723303; c=relaxed/simple;
	bh=kWuaM8GtZRlsxrMBp3vycagdkqQSvEWak1sWven5hqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyZrxeXEoxWh7272RwIamzUlTAzK1eWzFdwZwk1nYKgfDGqlJoPoLq2szaX2KeI+FNSH0JtAxT3g4pGvbB0G1AjbHWPPfwts2J8cLBzR/B7GOG1bdCRW29um0tlCNPGB2gV5ojA41IWs++58TMDJlzMoR0wtwmJhHTyI0ys/NtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFhUWX6d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721723300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rxTezTxo6GKuuHDEKO5V3fYzrV/tq+hnpV84mQy4geA=;
	b=JFhUWX6dux60kPt+zcxAeIcSCmTv94b3ePtdgEu+ubo9wfe+Sdfz5kpOC7eaDUHMYjD/1N
	iCKiymzRlgrHxR/OumWJVbaRyyG9oz9tY5oFYMyjSslyUeVKnMbKG5tLGg1hvpCkLJ4jpE
	N32QmuCn+0bSr06qB0ZxXPiyxWvy8ic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-NaXxVBF_Oi6ylMTjG1zgrg-1; Tue, 23 Jul 2024 04:28:18 -0400
X-MC-Unique: NaXxVBF_Oi6ylMTjG1zgrg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4272718b9b0so39115355e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723297; x=1722328097;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rxTezTxo6GKuuHDEKO5V3fYzrV/tq+hnpV84mQy4geA=;
        b=wBzVg09XoklGjCjwpHdMKbgk0KnWTBDrP2h+qat3gJBX8+/QwcxNvsrsePebOe2Qq+
         L9/I2NaZf+uU97lm45fBptg6fXrqQTjPAJisdm/AcmORiv+P3PtbavoT2lewsbrj2RI6
         yFZkoUZXi/o/Ob2lTOGgwm6VJtJyAQWcGfd7HKqxpyfaMZrXxJxdT+WMMVc0yEpeXPoB
         do6j9CC7mlgcLXA8fR4TvnjjFvk7Bf8BDBKO+734Y1w8VDVW9lC6OqDYxqye8ZyoBJtQ
         p1Qf46lLViMX+dwTYQfWvLqu5wJH//MKISXS6YoIoNa4BBjyzjKrFwRrbB1UBr4bWcOj
         uDrA==
X-Forwarded-Encrypted: i=1; AJvYcCUEaHi+T+IOigfdetuav/XETbLtMDUQ/cLKV/nCtVVZ6nNoF08fuZW8wKNBssDMpW59Sh70f1IS/AyLIhkMfGx43afHTnAjNwc6jKTX
X-Gm-Message-State: AOJu0YynveGLUyGa72l2DFw36YhjNUfiEFyvB8Yt1jsmWmSxHcdG1gkl
	Q9iDbqYvsDVSyHlaGbHsDa1Rk10eBgEK4JSotNt8oNTVqonBw5Mzy0awZMGeOPkXKXv3+qmF3NP
	xURVIvuv/GulOVOp1HbWYEfE2Yz8qvReM8PbXSNMo233G+nSb2lPiI8EY1i6Cdw==
X-Received: by 2002:a05:600c:198f:b0:426:54c9:dfed with SMTP id 5b1f17b1804b1-427ed059c10mr14419555e9.28.1721723297022;
        Tue, 23 Jul 2024 01:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy4CEmA4JcAfxG7LLbAWl0jocVLaLoP0eyKUczhXGMI5C0jMj0h/iQ7jjGjokFXNKdvElyyA==
X-Received: by 2002:a05:600c:198f:b0:426:54c9:dfed with SMTP id 5b1f17b1804b1-427ed059c10mr14419425e9.28.1721723296578;
        Tue, 23 Jul 2024 01:28:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:ed00:9dc2:1adb:d133:4434? (p200300cbc72fed009dc21adbd1334434.dip0.t-ipconnect.de. [2003:cb:c72f:ed00:9dc2:1adb:d133:4434])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868ac54sm10652507f8f.28.2024.07.23.01.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 01:28:16 -0700 (PDT)
Message-ID: <c8db754f-57b0-4430-b22a-87f8f3758ce9@redhat.com>
Date: Tue, 23 Jul 2024 10:28:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mm/gup.o: warning: objtool: faultin_page_range+0x100: unreachable
 instruction
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <202407230630.3vGhnlFB-lkp@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <202407230630.3vGhnlFB-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.24 00:56, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   933069701c1b507825b514317d4edd5d3fd9d417
> commit: 631426ba1d45a8672b177ee85ad4cabe760dd131 mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly
> date:   3 months ago
> config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240723/202407230630.3vGhnlFB-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407230630.3vGhnlFB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407230630.3vGhnlFB-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     mm/gup.o: warning: objtool: get_user_pages_remote+0x160: unreachable instruction
>     mm/gup.o: warning: objtool: get_user_pages+0x12c: unreachable instruction
>     mm/gup.o: warning: objtool: get_user_pages_unlocked+0x138: unreachable instruction
>     mm/gup.o: warning: objtool: __gup_longterm_locked+0x3d8: unreachable instruction
>>> mm/gup.o: warning: objtool: faultin_page_range+0x100: unreachable instruction
> 
> 
> objdump-func vmlinux.o faultin_page_range:
> 

I'm afraid I don't know how serious I should take this report :/

The commit is 3 month old and was found on some toolchain with some 
randconfig on some architecture, in code that is not particularly 
architecture specific.

I wish I could even understand from the report what is happening here 
("unreachable instruction" -- isn't that the compilers fault if it 
generates that such that objtool would complain? Why is that a C code 
issue?)

Please, someone shout if I should take a closer look at this.

-- 
Cheers,

David / dhildenb


