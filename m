Return-Path: <linux-kernel+bounces-566698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D6A67B71
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461EF19C2DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334C2212B28;
	Tue, 18 Mar 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UA+FicY7"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5E13D52F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320601; cv=none; b=bpQGLwpDuzAARDkY2YUXTzP4J68F5ETZt7CoqdgbW12wbVdvdAPuvJP0EQzgDhAQOwWyuLzZtBddLmMziNXBs85rpkg52yG7R15oNq4HL1HNZ2t1A0eBNUFy5xlz4FQaIg4alPkzM+aFuifFHoEcZSfzLHp1r2m5u6ODZRNOjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320601; c=relaxed/simple;
	bh=4PZfwGrp8v/V+a6ySydcmrMh5p9mr08FuVy3311xhwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIhReDtIC/GtBnpzTz3xjjVwGRJltj0XHIJW4nrPdR0R34czFkaIWRnDA2mL08ONEjJj8Ww/pdUtL0LIfTJ/jrVViwbTVhS1+QidDPF8JgZasIBvMlgRmq5PK7ynZ36FhLZOmpT9Fnt3kGf+llaQxTmyMpzCS71/L3kCRmUjoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UA+FicY7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac298c8fa50so1106962166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742320594; x=1742925394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBPjmyPyfiOdzrQpzRRrkTO8G9wlDGhtVrZqNtmDiH4=;
        b=UA+FicY7Snh4gxb+skyH4Nj9DeVSPwldhhwcHmJNom9oP9UwH38gNBzpBryJXtyUCv
         8ohOWexWmOuF+LMG8qVjdAtEYZfbYKR2REFynGbfaS9zc02Ofc/XzpexZflZts4HKZef
         iJwoxvyFkjBzxYSHLP40ay/bpwKqHkfoow9p+sJOXr1g3LlE6LBk8+vWkqVZFG9cvVlB
         ea1wBGThan4nJEwi1+YKlfLVdcCIkOYIeXrZR934b9LeyumFtYyRA4DGLqnw2w9iWbNz
         IlRkvyQPKc53WKKhgzsaQWj7XMBhJnJq7riIPJnhiIUDR0Grth7K6qW8naViozRvJebq
         LNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320594; x=1742925394;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBPjmyPyfiOdzrQpzRRrkTO8G9wlDGhtVrZqNtmDiH4=;
        b=W7HN6b7aeDX+hh/4dVNL1yatEH1yznT1sYGpvSzp0TYSiwnotj6wWbRLt4FL+djfaL
         ju7A9Kzv/Vq+d4lece/U34qjIfg5cKzrke+9RPWYPvt8ZUgG+k7d67ZtTK+TFN1XJ+Pi
         OtY/1KIABxyzqWHydC1wwreNv+69CVDXU1GUEOuf2hO+nYs6G0n5Lj5TmEOOezZWtneX
         abJyTfYlqjDmNyYc2OAHc8ZFXSFpawmjirA/NZ6NqpMybvrncWaSW2gJ/fZz6KVGf406
         cAmH67NXVezv0fysVIIF7AObAoVxhse7MIiksCDt0Fm13DSorOkuuS1Dg2ryZmaxD2Dx
         BqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsEiAWwIWytexeZvN9xtghT4LEDbqGPRIOk9LKi6BNOdYAwxM+dbExy84DAJCQvxh7ws7hTadG+RvEmUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmGzFCr/+gUUZ4D0NrPLxyCHI+YnrzE3siwj8hLw0dn1pfaYw
	wP0QvOumm5FDOBV5IVZ3vz9pxzdG86KqEBZRO5Y5RlhzUtjB0delCh27UYWShgk=
X-Gm-Gg: ASbGncumtr2zb8IvzQgckiPigBXLikmHRV7t3CHiaLZIFW010qN7s2jj+U5FunljgPW
	zgDMl33/Ita1g44ifulE6WRTtFeAQEXwiZyazVUSx/LQXD3ed7LCMm/nFwE4cApFWcH6KzU9oHa
	nIxxSDHIeym3Fu/3yNffWZB42IBuMlNjG9TVxr39n/FB7xZsCceNSytP+flDKPEKHd+5MLYYXUf
	mFht9DefAyq/ugBCu86Z3sIAWHiwUz9fGC1NGc5jnno2JvBtjUdHKmSQOrciS+mgxFl1EL7fFc8
	NI/m2DFczozMKyBr7dnNm9AKWsm/KLTHoDzykUa6HNImzqYb1BDKm2QiKIWRb0GJNHDcHU5x
X-Google-Smtp-Source: AGHT+IFMjkZ5IrHq4jLg0uEgl/6brC8Ml4DCkmZvAq2IsoOMSkCZ8VOYThwlQt5Wy+iO2RTDT/fpWg==
X-Received: by 2002:a17:907:728c:b0:ac2:4bfa:6f33 with SMTP id a640c23a62f3a-ac3b339ceddmr13164866b.54.1742320593886;
        Tue, 18 Mar 2025 10:56:33 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aef90sm887318466b.6.2025.03.18.10.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 10:56:33 -0700 (PDT)
Message-ID: <3a6889b3-114a-4921-adbb-0579891aca6c@suse.com>
Date: Tue, 18 Mar 2025 19:56:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
To: Dave Hansen <dave.hansen@intel.com>, dave.hansen@linux.intel.com
Cc: kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org, vannapurve@google.com
References: <20250318113604.297726-1-nik.borisov@suse.com>
 <babd4e40-0cb6-4796-af86-1944e32f89ee@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <babd4e40-0cb6-4796-af86-1944e32f89ee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.03.25 г. 16:48 ч., Dave Hansen wrote:
> On 3/18/25 04:36, Nikolay Borisov wrote:
>> 1. Should we forbid getting a descriptor to /dev/mem (this patch)
>> 2. Skip creating /dev/mem altogether3
> 
> Like Kirill mentioned, it would be nice to leverage the existing hooks:
> 
>          if (!capable(CAP_SYS_RAWIO))
>                  return -EPERM;
> 
>          rc = security_locked_down(LOCKDOWN_DEV_MEM);
>          if (rc)
>                  return rc;
> 
> Lockdown seems like a decent fit. We'd also ideally check
> lockdown_is_locked_down() in x86 code and spew epithets if someone is
> booting a CoCo guest without lockdown.
> 
>> 3. Possibly tinker with internals of ioremap to ensure that no memory which is
>> backed by kvm memslots is remapped as shared.
> 
> It's not just memslots, though. It's any TDX private memory which
> includes stuff the TDX module uses like the PAMT or SEPT pages.
> 
> 

How about something along those lines to warn when a CoCo guest is run 
but lockdown is not enabled:

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 9a0ddda3aa69..e34f6c0f9269 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -10,6 +10,7 @@

  #include <linux/export.h>
  #include <linux/cc_platform.h>
+#include <linux/security.h>
  #include <linux/string.h>
  #include <linux/random.h>

@@ -206,6 +207,25 @@ void cc_platform_set(enum cc_attr attr)
         }
  }

+static int __init cc_lockdown_warn(void)
+{
+       if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+               return 0;
+
+       /* Not a CoCo guest */
+       if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST) ||
+           cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+               return 0;
+
+
+       if (!security_locked_down(LOCKDOWN_DEV_MEM))
+               pr_warn("CoCo guest running with kernel lockdown 
disabled\n");
+
+       return 0;
+}
+late_initcall(cc_lockdown_warn);



