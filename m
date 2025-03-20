Return-Path: <linux-kernel+bounces-570311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D6AA6AEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34FF3A7813
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506DA227EB4;
	Thu, 20 Mar 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="wCesXONS"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F4A2236E0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499754; cv=none; b=TBWol0V6G19kFVgIP6a0646jN5Jd2Oia0APHP25+FbLKv7VEFE5SQOQwFelGE6itM6/yGTfphyF7xv2LjcNNRuLa7+SGIzfYELptr8gjbvVhVZV/RAp50L+XXqXjeEkWTLm/Uwdzvh4KJDttU2Jk3r796G0sFg6PsdQOsI2N7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499754; c=relaxed/simple;
	bh=Tw7srVavTpepXJ5E4HqSISIYWw1eDvOWEZ7yq3/TDOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+11YYazEkDtGWBJYPxvYIlrgg/n0C9m1/tDU/54hk+hcL6CNmN2rHPz1b/iD2VdwSS0lXBkywFSZL68s0t74jHfiRf1smsKV4xHSJKdihXF8W8G16WohyEwSl2KHLklOLUNTf9+/3+qS3U/3DxP76k5AJpGFerX2qiEKwIkAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=wCesXONS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0618746bso8689515e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742499750; x=1743104550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KVzjHDBGRoClsphc/cxXIEyZMPWjslmvcnc0gvOOPR0=;
        b=wCesXONSbs7ldCOaLH+sVM7aVyhN7WP30qNkWi6toPn4uFRKMOc9Rc+CqzPHoNnWBc
         R7KW4Y976J6gbOdEH9jNVdnSVCjpkoVtJfiS9tNaHOkycU9gtnGNvCr+UTD/YLorq/xP
         MouKa5C/uMzCTTA7Qz30s/RzfghNaX+nIKk8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499750; x=1743104550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVzjHDBGRoClsphc/cxXIEyZMPWjslmvcnc0gvOOPR0=;
        b=raWm5tgDg8IPIFAhV32s0SW6iynJvipDOU0S5d41bJsld9/pWKMdD5PYeuRJJqlsJV
         ThdEwLRqmrj0JCYRXtKU5OyUPIyGcjPugLWEn3vjPbOGDYFDa6myU050Pw14xDucrA68
         FJDbPdX+pnY+zn9SgNz7OtmSdHh7X7uG2NGsFR3gnORhUlKl+I8CxMhyu3ufrooN6nt+
         P0VkFJcnHv32gZs3h2wJqdrUypbMBQAk8bZDXiAZhmTzHhSqHtyOKKICpuoyL5wjRmaA
         LskRfH+x9u54BdwLzC9E2LVOOCVsy/oZ81gI0cgAXjSo72v+CJM38uw/mcJezEsVbnUI
         zcRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx+N29aP3eQGZhwTM9Gu5pJ1Ierc5DS+aCoDv7siDd3YqK2ZLMpRzX1kRZjknuPbT5wSPuFOe2Y3tWAmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWoU/qIiQupXCjN8QFBF+Kn1B9foj/WIzwlwDqUPixOG+kIGU
	8xaWyRq+268N6qsfMSJNe67vLdW/f78n7cXW86TE77JFFFLzrsS+j1Lk+E48l0Y=
X-Gm-Gg: ASbGncvBWx90q4yb5ZVGUtQWdA0fQHmuZkhZaFQOk2DmfGqzPG73GPLZO3U4Meen3Cg
	0CY89byr5S36FqOl1CWH5wmYRKF2KQt2xQlSOmjvmJTfOBWUTPYR5aC4cSp6ZbnpaLMa5iBjoCI
	9oLWk2xJ3Fwa5ciNa1lI/4Rfni94gpXAXWw94mX0Pi2iAHZcjGTLDClA+0lgQEmjJwaq2Vxnb6Z
	sWpk43nd50n/M/96iXjYfUWKFSet2NlJsP2PHEucjwj7AMjfXojH0ZtdhOrWv3AIBlbehOCOjWP
	O7kS0z9kQ59tygAbX5Xi2sEbC5SK7GQjcg+XhDDwW+Ao3T3HcNDeb+Ezv4y3eR2kTqwJguLUGbo
	owSR7KvCzBQ==
X-Google-Smtp-Source: AGHT+IFtDHo2OHhyRuXz1Q0Bo9spFzYc/7qHyDdV24oTtwTcqf8HSrFKdRlEsE2s450QRc4nWKjsjw==
X-Received: by 2002:a05:600c:c16:b0:43c:fd27:a216 with SMTP id 5b1f17b1804b1-43d50a218f8mr3715655e9.23.1742499749785;
        Thu, 20 Mar 2025 12:42:29 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f995423sm416810f8f.20.2025.03.20.12.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 12:42:29 -0700 (PDT)
Message-ID: <d4fcfd91-cc92-4b3c-9dd2-56ecd754cecc@citrix.com>
Date: Thu, 20 Mar 2025 19:42:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [x86/cpuid] Question regarding historic leaf 0x80000000 code
To: "Ahmed S. Darwish" <darwi@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
 x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <Z9xtfC5pL-g4LYvK@lx-t490>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <Z9xtfC5pL-g4LYvK@lx-t490>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2025 7:33 pm, Ahmed S. Darwish wrote:
> Hi hpa,
>
> As you probably know by now, we're working on a centralized "CPUID table"
> data model, on top of the cleanups at:
>
>     https://lore.kernel.org/x86-cpuid/20250304085152.51092-1-darwi@linutronix.de
>     https://lore.kernel.org/x86-cpuid/20250319122137.4004-1-darwi@linutronix.de
>     https://lore.kernel.org/x86-cpuid/20250312143738.458507-1-darwi@linutronix.de
>
> The idea is to remove all the direct CPUID queries from the x86 code, and
> access a pre-filled table instead (with caveats outside the scope of this
> question.)
>
> While changing the CPUID queries one by one, I've stumbled with:
>
>     => arch/x86/kernel/cpu/common.c
>     void get_cpu_cap(struct cpuinfo_x86 *c)
>     {
> 	...
> 	/* AMD-defined flags: level 0x80000001 */
> 	eax = cpuid_eax(0x80000000);
> 	c->extended_cpuid_level = eax;
>
> 	if ((eax & 0xffff0000) == 0x80000000) {
> 		if (eax >= 0x80000001) {
> 			cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
>
> 			c->x86_capability[CPUID_8000_0001_ECX] = ecx;
> 			c->x86_capability[CPUID_8000_0001_EDX] = edx;
> 		}
> 	}
> 	...
>     }
>
> You've contributed that snippet here:
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?h=2.4.0-test11pre5&id=67ad24e6d39c3
>
> Do you remember what was the rationale for the "if (eax & 0xffff0000) ==
> 0x80000000" check?
>
> You've also contriubted a similar check to head_32.S:
>
>     https://lore.kernel.org/r/1258154897-6770-2-git-send-email-hpa@zytor.com
>
>     /* Check if extended functions are implemented */
>     movl $0x80000000, %eax
>     cpuid
>     /* Value must be in the range 0x80000001 to 0x8000ffff */
>     subl $0x80000001, %eax
>     cmpl $(0x8000ffff-0x80000001), %eax
>     ja .Lenable_paging
>
> So I would assume, it would be safe to have a similar check in our
> centralized "system CPUID table" scanner.
>
> In all cases, if you know more details, it would be great to know, so
> that I add it in the centralized CPUID table patch queue changelog (in a
> separate patch.)

The problem is that for an out-of-range leaf, Intel returns the data
from the maximum in-range leaf, rather than zeroes.

On pre-AMD64-capable Intel CPUs, you'll get what amounts to junk in a
query for leaf 0x80000000, where it's probably leaf 5 or so.

Checking for the upper half of the output matching the input is a way of
distinguishing Intel behaviour from all the other vendors.

~Andrew

