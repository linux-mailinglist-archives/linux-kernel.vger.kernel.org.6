Return-Path: <linux-kernel+bounces-566317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E964A67652
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A1C1889129
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D4120E30C;
	Tue, 18 Mar 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CB+e8JKb"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FA20E001
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307687; cv=none; b=a/nYoDhprRepsPB3AViDwl3sohmgOQz0j+E3EyMmcwaqWCyS53zOjZpCzeEmvcSTfkqWkuDn2cB9fqITzPBb8LErepSPvU5n6Nfs+Aqx0eA45YJSjHWzKK+SAOnCa/rp1RzeyUrAmntzDjq7RpDQ8SJjQ2LarazptKDvApYzZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307687; c=relaxed/simple;
	bh=bSK+2TFYlBo+88nBmG72X8WSTHc6hfb3JBW4AQsB7/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NO9BqDZA3KaSSMK6XpWDNIIt1W9DNRC+8EgX4066oQuaAWIgE7+aKOCUKcBt6xuj7YzdBlSWb2nggiQ5V8ocPCJygoBCY8LctbGr3YbE0tZjcSvu4Moopxnrgknw40+/Gy2DLQzUD8inNkR93Rp7xd6R15jQf63zYFch6wN2B6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CB+e8JKb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso24391645e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742307683; x=1742912483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxR27kQuwBEt7OQtqQ55XSsL464ltVf3GaX2mQdx5wY=;
        b=CB+e8JKbjgGRwjoX6nEnX+ssj1YLDzU5YYVYgxTSyTZpumS5K98NRHJjWBMLQx3/y0
         TR1db9bWiZitlZVNZwlV6egNjShNmHdMfNCzhrdOXq/TNc83Rtzn/LwsgtR9qqj8GTyp
         Xk4QqG9+5oxingu7GtrYAWvqCB4+7nuwG0V5K8cgCw7sU5G6XExdXTAWFMwQNkUgNTAG
         iYFCr8FIkWDOWUOJskezUnijE7ULJvtBTdEMdJoLkvzYfepAkEfznrdQTGylHYkZ++Gw
         Gvot8DIQ2KgKHBJXhf3wu+6QBm7u0Nb3f1IVjWUfbpYBIpNTAbMP9+3oZBzHLHHDaIa1
         9gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742307683; x=1742912483;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxR27kQuwBEt7OQtqQ55XSsL464ltVf3GaX2mQdx5wY=;
        b=bKk6i08PEMPhL3uLNnlCUE3wDbsUpEfyeKLY3CijCkx8d1QTKsJ5K6M/l4GxPM0IG/
         WzJBuJ4nBERbsGF8c00jALYcWW2i5jjF6cp3ABN7JbfrdxkEqIMhGUi65glGSTG29hKl
         t6bYLGiDCh+cjSoxVoxsdVEP13fiY6dbHP6c4S39Ro0WwFIQ6Xm/vwJkzpHrJsSGhOkm
         oCwA3vQ70EM637D9U8W8BY21XXxIpZ96YjR8S1dUc8ufwvJtK5AliOZrJGod54XExNsD
         52KFhvd6+Van3Za6BDrMFND/JZVa7SmB7xtjzuHeCms0xzCw4SJ0xj/eFbvETgku9sl7
         GAyg==
X-Forwarded-Encrypted: i=1; AJvYcCVB7Nr4Bu/vOkPrptsaRSiLqW2Uozg4zfCTBJ5jAztc2TOMmfjNVhrnmmYgtlFi+yiFOaALn69Th4Kd7BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCIzZ/pv8Nsae4MyxteVxQIypEJGff1y+7KLM+U2OUUW4/k3Fi
	cwMD1OUz3d4PiMBkIX2GRiayPUBib7LfPJorUeC52PERfXAMjVRBiwzD0TMjiHM=
X-Gm-Gg: ASbGnculhJ0sbVDDzb6tef2W6/3YfLd10GEiYt97dsvxzx6zb1dG9EIvgjBiI87hbL9
	ik/QeVT5yOfAEtG8+AOTuPftPN4hqkHNJnObi0ZZVUwIrKcAgL2Tcn1NcFpcWSpEZQsEy3UbtOR
	qvPdgC5lhTAwXxRhiHDyMPKkXs8f2UsoaA9nyX7N+4CKleK/eZBIcXK8KprHGd8e9JICmt7wTnm
	+tdnM+Ka/fxGvoC8DAcNEhlnfhLwoV+qiStYABpkn4xZCkG1nt5eNAlXiF35aC8QqBNRcjpXqIA
	y5vDO5vCliXNbzjXh/CJvbXVRetzGyMsbMMTifA4nwPeHr0HnGtRrWsDyjb5XDKWw5hJ/C+9
X-Google-Smtp-Source: AGHT+IEHOb/2Ant15/B6B1CZFyAfapecsnnjB92EQqFBYGik1Jl1z+dobqVz/+A0Y+HNe7ocgqsSLw==
X-Received: by 2002:a05:600c:5106:b0:43d:d06:3798 with SMTP id 5b1f17b1804b1-43d3b9c09bcmr24196435e9.20.1742307683481;
        Tue, 18 Mar 2025 07:21:23 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3ae040f9sm17700535e9.0.2025.03.18.07.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:21:23 -0700 (PDT)
Message-ID: <d0891544-98b9-447a-a382-bfc078865243@suse.com>
Date: Tue, 18 Mar 2025 16:21:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, x86@kernel.org,
 linux-kernel@vger.kernel.org, vannapurve@google.com,
 Elena Reshetova <elena.reshetova@intel.com>
References: <20250318113604.297726-1-nik.borisov@suse.com>
 <guatjzjzipzjzvj4oou2gktxmzileawshxmxj22hsa5kmet5g4@2rhf7tzaiytw>
 <b6d132a7-b259-46f4-8bde-fc517bd9d294@suse.com>
 <auno67lcikllqdlgdsad72hvsmym4lqxnaqaohmvtvf2boscxu@54ftt6342jxy>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <auno67lcikllqdlgdsad72hvsmym4lqxnaqaohmvtvf2boscxu@54ftt6342jxy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.03.25 г. 15:27 ч., Kirill A. Shutemov wrote:
> On Tue, Mar 18, 2025 at 02:53:34PM +0200, Nikolay Borisov wrote:
>>> I think we need to think wider. What about applying a subset of LOCKDOWN_*
>>> in all coco guests by default. Many of them are relevant for the guest security.
>>
>> How do you envision this to work, by introducing another
>> CONFIG_LOCK_DOWN_KERNEL_FORCE_COCO or some such ? Will it be opt-in or
>> mandatory?
> 
> I think cc_platform_has(CC_ATTR_xxx) should enabled some subset of
> LOCKDOWN_*. No need in new config options.

Care to suggest which ones should be included? The way lockdown works at 
the moment is that it only supports 2 levels (check lock_kernel_down() 
and lockdown_is_locked_down()) at which you can lockdown - INTEGRITY_MAX 
and CONFIDENTIALITY_MAX,  where each level includes everything below it. 
So by choosing integrity max you get:

     19         LOCKDOWN_MODULE_SIGNATURE, 

     18         LOCKDOWN_DEV_MEM, 

     17         LOCKDOWN_EFI_TEST, 

     16         LOCKDOWN_KEXEC, 

     15         LOCKDOWN_HIBERNATION, 

     14         LOCKDOWN_PCI_ACCESS, 

     13         LOCKDOWN_IOPORT, 

     12         LOCKDOWN_MSR, 

     11         LOCKDOWN_ACPI_TABLES, 

     10         LOCKDOWN_DEVICE_TREE, 

      9         LOCKDOWN_PCMCIA_CIS, 

      8         LOCKDOWN_TIOCSSERIAL, 

      7         LOCKDOWN_MODULE_PARAMETERS, 

      6         LOCKDOWN_MMIOTRACE, 

      5         LOCKDOWN_DEBUGFS, 

      4         LOCKDOWN_XMON_WR, 

      3         LOCKDOWN_BPF_WRITE_USER, 

      2         LOCKDOWN_DBG_WRITE_KERNEL, 

      1         LOCKDOWN_RTAS_ERROR_INJECTION,

Given this if we for example choose to lockdown the kernel for DEV_MEM, 
we'll also get the MODULE_SIGNATURE lockdown as well. I find this 
somewhat inflexible as we might have to rejuggle the current ordering.

> 
>> Should we decide to follow the lockdown route this means the owner of the
>> coco guest will have the ability to disable it and a misbehaving userspace
>> process will still be able to induce an EPT violation.
> 
> Sure. It can shoot itself in the foot.
> 


