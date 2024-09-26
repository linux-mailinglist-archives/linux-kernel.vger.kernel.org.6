Return-Path: <linux-kernel+bounces-339940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D14986C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001B02827AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD5188A32;
	Thu, 26 Sep 2024 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X7wcS/3p"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB81D5AB1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727332028; cv=none; b=drPYIzOUBNAMq3MBRr75bqdiAVOZC8Yop+t/JAkGc2uw99vmxa1FAKtWin7J47AG+bU1619b7ouzl+7J3QkJghsZATtB32nqiVlHieFnXej0xTveHbRSHOjc3FhAoA2N6uoBGX8UwzY5e+KLQdxBAS7UkM5/4dVCI/AuARzkYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727332028; c=relaxed/simple;
	bh=6fbhbxf6IoUQMR/4ZCUq9VkfWTkQmOsWs1P3OR8ipKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewF5l5KO40pgGbaD1kyELXGjnWtkNOIaXQ8XnbJicEmOeYgecvQWNpnwvRJyy8RSybDcuzb8qdsF7BHQpzufoOT2UwRrgfuOXo5PyvoGlw1G4FsmnYN0iRDLIOQEL1bS+VfN9UpaDzQJfdA24OokVygxffVL1ZCtubDv7M8rujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X7wcS/3p; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53568ffc525so752578e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727332023; x=1727936823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJyq5r7owmQ4fSxu3qvbINvtGvihvArgf60IEDytVxw=;
        b=X7wcS/3pG1/bHllqVoD5usiwkIPEtgFtusdi0MGU19D6n2JhUF0zeI0gPAGcmmCMR5
         YL6FUkOU6KL0XY8ODen5z+aXr9lf+UEQTPo6M44Qs+Hs3MO/h8arFG+vW4p+hJ6HVMMo
         V3dQbYNv5YhOEh6xtUckewWGCku6ZBQgTL2JyyXce/Xx89GPcWDAFHwC5LI6VhJvQoFK
         iJ6Q4Y8Yl0KZxgV8VTwItkS80eLa+90ieHPRWp+1vj/6C6Xaouq+86lma2gx7OCjjU8w
         0gMLqSOl6vc7KnzKNEeL5AjYwmESbytdaoggUEtdBkSgVXdWYshXWnL0QEejMAnBc3p+
         91ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727332023; x=1727936823;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJyq5r7owmQ4fSxu3qvbINvtGvihvArgf60IEDytVxw=;
        b=nplfpnZgQADKccdH3qBhPoAtlldbbXbT4OIkcPs/P4k/qc8H2sEDa7IkRKday2YoX/
         2hDbcTjQMbe08wlY/jcNCD+pEiLxX8lUbwmMtiPDY/aGXjOnD3I6jmBBSKZJ6tpHXijo
         P3CSYz0JSiqFBlbbFzjQJVvNQnFi7lkzbHmB3TcV92rF/mwv3XHBQ4aUepJC9Ldf9wuF
         mwd6wDZGSNaB0DGLQK5qvoghWxDkLZYo6IYACMWOPTyxngbT688CqIKYFkxLMGamqy0x
         MnUsakHA4vfNTegOAQ7/goAvDWhKiRj7VPUKuKotbcscu0ZsmS5mJg0WSotRuos4B26N
         spug==
X-Forwarded-Encrypted: i=1; AJvYcCXSqTr7KKbCRoMo+EKVVqWELarCSC6ly7f8ouMgXH8Vz+UMTr1bncXSCPtk+1nL3Xc5L7V68Ow9FYCFXdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5976uJpslQP1RaOTI0w6pwqOxteKxcHrE1vvR9y/6EutyQyJH
	zAmGzx2pc4rNIPdj9NhnzaY+HvZJVd1XzyxQXoM77ulqW9c7vPV3e1IKJ50u95g=
X-Google-Smtp-Source: AGHT+IEia7ugddIZ5i+C+qOLJmpmYAtyNjasa7jKxw0AtxbpnJ3u4LiXkycHhFhzq4yqO8GzFxLoSA==
X-Received: by 2002:a05:6512:3044:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-538775670eamr3406420e87.49.1727332022769;
        Wed, 25 Sep 2024 23:27:02 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:75b8:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:75b8:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c40asm2783859a12.1.2024.09.25.23.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 23:27:02 -0700 (PDT)
Message-ID: <fce898e6-0296-4c5e-9e6a-6b5e3fc87b95@suse.com>
Date: Thu, 26 Sep 2024 09:27:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] x86/virt/tdx: Prepare to support reading other
 global metadata fields
To: Kai Huang <kai.huang@intel.com>, dave.hansen@intel.com,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
 peterz@infradead.org, mingo@redhat.com, hpa@zytor.com,
 dan.j.williams@intel.com, seanjc@google.com, pbonzini@redhat.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, isaku.yamahata@intel.com, adrian.hunter@intel.com
References: <cover.1727173372.git.kai.huang@intel.com>
 <101f6f252db860ad7a7433596006da0d210dd5cb.1727173372.git.kai.huang@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <101f6f252db860ad7a7433596006da0d210dd5cb.1727173372.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24.09.24 г. 14:28 ч., Kai Huang wrote:
> The TDX module provides a set of "Global Metadata Fields".  They report
> things like TDX module version, supported features, and fields related
> to create/run TDX guests and so on.  TDX supports 8/16/32/64 bits
> metadata field element sizes.  For a given metadata field, the element
> size is encoded in the metadata field ID.
> 
> For now the kernel only reads "TD Memory Region" (TDMR) related metadata
> fields and they are all 16-bit.  Thus the kernel only has one primitive
> __read_sys_metadata_field16() to read 16-bit metadata field and the
> macro, read_sys_metadata_field16(), which does additional build-time
> check of the field ID makes sure the field is indeed 16-bit.
> 
> Future changes will need to read more metadata fields with different
> element sizes.  Choose to provide one primitive for each element size to
> support that.  Similar to the build_mmio_read() macro, reimplement the
> body of __read_sys_metadata_field16() as a macro build_sysmd_read(_size)
> in size-agnostic way, so it can be used to generate one primitive for
> each element size:
> 
>    build_sysmd_read(8)
>    build_sysmd_read(16)
>    ..
> 
> Also extend read_sys_metadata_field16() take the '_size' as argument
> (and rename it to read_sys_metadata_field() to make it size-agnostic) to
> allow the READ_SYS_INFO() macro to choose which primitive to use.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

<snip>

> +#define build_sysmd_read(_size)							\
> +static int __read_sys_metadata_field##_size(u64 field_id, u##_size *val)	\
> +{										\
> +	u64 tmp;								\
> +	int ret;								\
> +										\
> +	ret = tdh_sys_rd(field_id, &tmp);					\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	*val = tmp;								\
> +										\
> +	return 0;								\
>   }
>   
> -#define read_sys_metadata_field16(_field_id, _val)		\
> +build_sysmd_read(16)

nit: Generally the unwritten convention for this kind of macro 
definition is to capitalize them and be of the from:

DEFINE_xxxxx - similar to how event classes are defined.

perhaps naming this macro:

DEFINE_TDX_METADATA_READER() ought to be more descriptive, also the
"md" contraction of metadata also seems a bit quirky (at least to me).

It's not a deal breaker but if there is going to be another posting this 
might be something to consider.

<snip>

