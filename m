Return-Path: <linux-kernel+bounces-339939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E72986C66
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE23B25492
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25BD188014;
	Thu, 26 Sep 2024 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H2LOkvf6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E1185941
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331681; cv=none; b=JiJm84mhRbiGMmbWif6KoMVh1+jrjNO3xXVW09RiQCd/bndXPL8OwqN1G5ggNT60Zr57Q6FUVJb9tvGeR2Qisp8M9QGAOhsoQudxB8I9y40WYqX02VOAulUQtCvo50bGCu19Ly+T+QG/N3Rn993KLzKR8n+fINwG8JrwYsmasJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331681; c=relaxed/simple;
	bh=1pLxbC8I7m5jJNxnqEC6sj7C1ca8cV6A29jVK2+lQFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIp/PL0Sg1YdIehrZmhOhrmedOOHA8WsJ2hJVGzNlmYEOVVIRLjyDZ6TLyhcB3Vihkmnk3vOqAcRH3lhWex63xPVCvRqqJ1iG8IoQXGZNAeCSzQ/dNnWZZP4h71SdeT/Trx5Lb0Swotug1lI8v8PRP1MAKo3RUJEafQsikQ5yWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H2LOkvf6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so62911166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727331677; x=1727936477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYMCwkQPVxKJ+cMHOHVL5c+5ytaGE64SeE8g5ixOBss=;
        b=H2LOkvf6723jQxMkj0NU2J6eql+i7LeBQKQvCat1N7UMPIXKjsNbUWeeW8xqmLtalZ
         NZ8rlt+785Jqhuc12DOF0JjbBzQaR6PD718oHoOfWD1ZsxdlKQtOsPT0B3YLuP8/4/2T
         n7tgZzoebTKdVmEbXKqTnqSsCs3V5/jdM0SfvylZf15iABMHkpFm3vfEjNizE+95QqTH
         yt+L22pElkbXqpnic8SBF9ElsSAiwtEU7NkRrkHEXcY11CMpnlu1waIQ6fflEd0bKWqZ
         wKsC5itTeWWkz1iT0fAixEHenRgtdobaFuBIxfPoG4D6s+f0OYURqbGs10k46QBrBAHS
         AxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727331677; x=1727936477;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYMCwkQPVxKJ+cMHOHVL5c+5ytaGE64SeE8g5ixOBss=;
        b=HCm7TyAj5Rx9jn8nNGVqJzHF/V6wULrKB+avzWQa8ub2dJdu2N8SViZG/adqm0H8J/
         te69NwQ1OKQzWvBPrCUXvimUsXQilrH0nl/QKgSMSva40K37WWQar0pqn4up/3GwXIYJ
         NNVzTsMForV44GHPPv4OnQQJOT5EZt0L0/aZyoDmpbUoNW3evrWRp+qUJuFDzjiJwMqv
         WHpGob/XIOW5gCmby1jj8T3QNZsYOm0MyaZe9XPbiWVNjhW3d+IfTPGBjxtv+7xUU2oV
         /WZO9Hm7/YnFMWyvOihEatoa28H0umuuWGrFwlOaUmLaUcP0sECQMkJMjBDh53/8rYVV
         y9Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWnb0WObyl3fNZmpazbTo7pUfa1eFsJsSJDco9r+nZ3y3ZD/rqU1XWlUoOr/gPgm8IFsDohiBYBnnSTgNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBm3QVPVGK8KPDKW+gDWRmYjde6izs++J+Wgb+YDms0krA1Dr
	kxWAxI/Q2rPztzrlH66nNs+H6kUfD5bkJZyKmI99g3ejr3qIzh5dSEPGdIsPZUQ=
X-Google-Smtp-Source: AGHT+IGq6JdSzSznwPxVPi2beVS6+2KfvKJjCPl73nGi+bdpGccswpYOVUmzs63z0PbobAmD2I0QlQ==
X-Received: by 2002:a17:907:940c:b0:a86:bb90:93fa with SMTP id a640c23a62f3a-a93a05e7e73mr470458966b.44.1727331677393;
        Wed, 25 Sep 2024 23:21:17 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:75b8:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:75b8:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f34076sm308151066b.7.2024.09.25.23.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 23:21:17 -0700 (PDT)
Message-ID: <d8351d41-b7ee-48b4-a11c-5d1cd7f39ae2@suse.com>
Date: Thu, 26 Sep 2024 09:21:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] x86/virt/tdx: Start to track all global metadata
 in one structure
To: Kai Huang <kai.huang@intel.com>, dave.hansen@intel.com,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
 peterz@infradead.org, mingo@redhat.com, hpa@zytor.com,
 dan.j.williams@intel.com, seanjc@google.com, pbonzini@redhat.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, isaku.yamahata@intel.com, adrian.hunter@intel.com
References: <cover.1727173372.git.kai.huang@intel.com>
 <014302e0bd2f0797aa7d27ed8b730603d2859c2d.1727173372.git.kai.huang@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <014302e0bd2f0797aa7d27ed8b730603d2859c2d.1727173372.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24.09.24 г. 14:28 ч., Kai Huang wrote:
> The TDX module provides a set of "Global Metadata Fields".  They report
> things like TDX module version, supported features, and fields related
> to create/run TDX guests and so on.
> 
> Currently the kernel only reads "TD Memory Region" (TDMR) related fields
> for module initialization.  There are immediate needs which require the
> TDX module initialization to read more global metadata including module
> version, supported features and "Convertible Memory Regions" (CMRs).
> 
> Also, KVM will need to read more metadata fields to support baseline TDX
> guests.  In the longer term, other TDX features like TDX Connect (which
> supports assigning trusted IO devices to TDX guest) may also require
> other kernel components such as pci/vt-d to access global metadata.
> 
> To meet all those requirements, the idea is the TDX host core-kernel to
> to provide a centralized, canonical, and read-only structure for the
> global metadata that comes out from the TDX module for all kernel
> components to use.
> 
> As the first step, introduce a new 'struct tdx_sys_info' to track all
> global metadata fields.
> 
> TDX categories global metadata fields into different "Classes".  E.g.,
> the TDMR related fields are under class "TDMR Info".  Instead of making
> 'struct tdx_sys_info' a plain structure to contain all metadata fields,
> organize them in smaller structures based on the "Class".
> 
> This allows those metadata fields to be used in finer granularity thus
> makes the code more clear.  E.g., the construct_tdmr() can just take the
> structure which contains "TDMR Info" metadata fields.
> 
> Add a new function get_tdx_sys_info() as the placeholder to read all
> metadata fields, and call it at the beginning of init_tdx_module().  For
> now it only calls get_tdx_sys_info_tdmr() to read TDMR related fields.
> 
> Note there is a functional change: get_tdx_sys_info_tdmr() is moved from
> after build_tdx_memlist() to before it, but it is fine to do so.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

