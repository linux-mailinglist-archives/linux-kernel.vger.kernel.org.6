Return-Path: <linux-kernel+bounces-277747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8B94A5B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0101F21140
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFE91DD398;
	Wed,  7 Aug 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PjCuGerk"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8D13F435
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027045; cv=none; b=tBdDGZsK6O+jofAmqgnFE6gIc9lGAUge/8emTb66oH+tUefPiPV4E5wUnTqK9X1M8RuqX0bZ3bfUtRbAiYtmDk1KI20zmioci8M3DY8kZpV0CnsEiCQGtvmnZErYg1X7FKSUSkFlumlVrlxwnVW0FW8mx4ajf0hKbUr6neCz+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027045; c=relaxed/simple;
	bh=+eVNZMHRCsv7bg+ozffFmWdiRY6EWZcQF8pTOvaPYi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9jxqHmjKSpJm9WCMXjsq3Jb7QK7EVF1rndQY0U+0XSO9RQMEKcq0E+fy4AJH41EuJM/98+B13Lxya2fCzgwIW3EdZe2MqiZuNSoBbYN6G1fiekVN16cfLvGtkj/NJFf5hHgyGo0wAfAOoBua3RZ3A74Miu7b9HNa0ZdqS6jWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PjCuGerk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efa16aad9so2154163e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723027042; x=1723631842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtCQR4llpSQl4Ce3bHRxPr7DOi5yHbkr62zhtLRBZ+U=;
        b=PjCuGerkf2noJoqWj2tMKINqc6T1GCNcji3R7+n3O5CnVDV782r2Xv6HzoWP08guZf
         0oE6b4T3h0+YCkEUWJDNswf6wKX5HT/jJGps44xGs3bINEkW/yhnmvM0lnIgc64pRr50
         kBEOrg8sAH+rYGlYsBdKx7A/L97lJVnqOZyNa6TRNfDhYt34riuNH99F6mM+p01aka1o
         szAukrRW9OgjjDezg5J4fl/wE1AYkt3q39Ui3RQlPwaiCy1HLDF80kmk6hcmdl+cHG9j
         /ETE2RjUJOZHIkjyH/t6SHXpj2k1G3Ma6scoeKxrYo7dTG/0jVEuVuTmzi6hafnFvYm4
         jpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027042; x=1723631842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtCQR4llpSQl4Ce3bHRxPr7DOi5yHbkr62zhtLRBZ+U=;
        b=clOTLLTPs1TCiSeUXwijlemB1neE35Nd+r+6frOTarGxGTHAJV4unQnq48hpwTpeq+
         t0Iwc92O2qT+NBZqvO5khQHckHlgNCJbV9cJFE5G7YoXFMtYOQwuvtmaU1WBMZK8vsjt
         yQ5hrw/FJKSh3tOJKFtsJRkrmSG7sUj5FURJAQRLuQ09y7HzB7WhjECLR5SLBEXW26Nt
         /KC4GakaydK+1z4Edg6kYRN1Tsx41spMDQwJU4AV9YYf2DdR3N9Uw3bFUfKmiakQIsb+
         D/XhseJ+TxZCAbD06xJ1qo79P4fVvhZDFmQl3TgZ2MvrCfgGH9wwfm8h/DZZ0fSqm53k
         SA7w==
X-Gm-Message-State: AOJu0YxonpjXpRa4bW6LSUW795+/i92efwGxRltffbdNnz0H2i8xM46N
	MGfL4g2Xx6CNgBPIFQw94NeqijdJS8f8HKMutq2HEZLeX8/A+olGx0IRfrPdyBVHY+FpNWWwUg8
	H
X-Google-Smtp-Source: AGHT+IFWwx7rLRv7+flp6Qt7KN7Rfr939cJSrryBKNbjkCy0kv0cVckwj4XS6cvKdooZF/iTAYmZoA==
X-Received: by 2002:a05:6512:1094:b0:52e:9ebe:7325 with SMTP id 2adb3069b0e04-530bb374627mr11571201e87.31.1723027041666;
        Wed, 07 Aug 2024 03:37:21 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c83cbf0sm55134536d6.83.2024.08.07.03.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:37:21 -0700 (PDT)
Message-ID: <b46c051f-98c2-4748-8423-3e3a4511b043@suse.com>
Date: Wed, 7 Aug 2024 12:37:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] xen: fix dom0 PV boot on some AMD machines
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20240807103338.22007-1-jgross@suse.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240807103338.22007-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 12:33, Juergen Gross wrote:
> There have been reports of failed boots with Xen due to an overlap of
> the kernel's memory with ACPI NVS reported in the E820 map of the host.
> 
> This series fixes this issue by moving the NVS area in dom0 to some
> higher address.
> 
> Juergen Gross (5):
>    xen: use correct end address of kernel for conflict checking
>    xen: introduce generic helper checking for memory map conflicts
>    xen: move checks for e820 conflicts further up
>    xen: move max_pfn in xen_memory_setup() out of function scope
>    xen: tolerate ACPI NVS memory overlapping with Xen allocated memory
> 
>   arch/x86/xen/mmu_pv.c  |   5 +-
>   arch/x86/xen/setup.c   | 242 +++++++++++++++++++++++++++++++++--------
>   arch/x86/xen/xen-ops.h |   3 +-
>   3 files changed, 201 insertions(+), 49 deletions(-)
> 

Please ignore this series, messed up the "Tested-by:" of Marek by omitting
the tag. Will resend.


Juergen

