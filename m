Return-Path: <linux-kernel+bounces-194034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C78D35B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062C5282B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4881802DB;
	Wed, 29 May 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gucEyGED"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A61802A8
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982780; cv=none; b=kcjDtRr2ZQ9x1leF+VSWIkaXbDprRVXL7Ujv04xG4n+ZU8OiKtsw3ES9QIH0cmxfTxVurIL7+MmXqTxcxRmIcMZmBsc30oTlLLW8xP7t4iAznsIqZaTafTAhowHim+4RC7oP9RiSRvH+HKYGumr04vH3/5Pw4R5dibdVTpnBpzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982780; c=relaxed/simple;
	bh=ydja5ABopWv3H3E435qacVly16lftEf0fcwfsjpRf8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqyuR2zdSgp+bMAQOAUagBZWZRRv9X3hYJqPCnwo0eraL2X2vFUSClw7TaDHaOUrI0fmYrzQqt8QlygFyaZs9byYMx9Gda1/OZFqtpMwSlCAvzME8gI1vwPJY4iSaFcIW7/loGTswFnBuyPVXdDgkVCtTjTQiIMmPkQMtQHYfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gucEyGED; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42125bfa28fso1190425e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716982776; x=1717587576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EdFeXZ0iZQwHyJpJ9sEUFEvxz5pnqM5Lhk7k33g54Ts=;
        b=gucEyGEDBr4+17MeUfIyWpapTdoZUGFkq7sJUPEX5qLfvB37BuOdznOrkykyQxEDiQ
         qjZJ0A5kFHAVor7oU6aaUk6oYMnv2x6/sP+8qeexusOT7wNUqvVTEc783c1KdjL96Jr/
         8iSTSzvNejMqGduLqo5SM3Y0F5Dcltm1fPbOY9t6Ucu/pPi927nqyTIuC2CWdCd3gYEA
         /Bpoy2xknX8tFadJCHlAXMoc1YwJv5EBOl6gfA/Cb0agkS8VNz2ZsCrplSj+8PR4O41O
         4RDsIn2mW6LuDnMPFU5PifDxYIFEmIbNOF/aGfKea8+Y1B4AnNe3MovqQzWW14JYnPkk
         t0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716982776; x=1717587576;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdFeXZ0iZQwHyJpJ9sEUFEvxz5pnqM5Lhk7k33g54Ts=;
        b=QOac8i2ZGe6/26Kcf9Xnv7r2X3X2EeUwVQmtaQU85IiAZsR/3B0nj0c++2HprvTqo3
         wKl2gf0QEIIveflE6bopbyuD+dmTzz0bd3mXJSwUB1gcHRfIsvh7lD7b3mhgpFgZJ8Pc
         9Z1ZJ1r3NNUFJ+Vvjey83+doRt4eZQ2AYAQv7YGw0/bmE3SWQzEEUDHBnL7iqpv30HwA
         fich7BEydxxMUtGhROsm/xJV0FASVOdSDlrJzGRFsh2hzYsskw7w93VmqNWt99cTDQmE
         RFg6cbKI40j3RAlm03p87JrBurABK1hbKeh3q6XNV1KOjJ333itOGl4u7yM5+G3cnvk6
         wCDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZLMQXbYYHNXghfknPQtxkgZtd6TytdGZeJYOF2t7itJXI7rFsm8xGWbJiZi20QBOIY/E1TnrSg2wT2vA7PZK5KVFuxlDYDKvAmlhD
X-Gm-Message-State: AOJu0YyRUrbGh7wUMITq9Bh9LzZJX6jdPxP3RdAjNPMk/dpHWI/oF8hI
	bp3pZ0HVRNQW/39xQh5rhx0C1xX348erIqlLFLPT0t655ZHreAg1Gi/lVH28BWk=
X-Google-Smtp-Source: AGHT+IGhbyPCV7mhFEb+wa2zxVQsRfFFyIuyAeyXPnnporhcsU+et7sVZoAC9sjK3Qz8qHTU2qJsiQ==
X-Received: by 2002:a5d:62cc:0:b0:354:d098:8d67 with SMTP id ffacd0b85a97d-3552fe179a1mr12680946f8f.57.1716982776439;
        Wed, 29 May 2024 04:39:36 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:5de0:ca17:8dd8:7313:d6fd? ([2a10:bac0:b000:5de0:ca17:8dd8:7313:d6fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c93a5sm14633282f8f.70.2024.05.29.04.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 04:39:36 -0700 (PDT)
Message-ID: <46ddc54e-f7bb-4de3-b311-faee12e5a6b9@suse.com>
Date: Wed, 29 May 2024 14:39:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-7-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240528095522.509667-7-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.05.24 г. 12:55 ч., Kirill A. Shutemov wrote:
> TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
> that bit is cleared during CR4 register reprogramming during boot or
> kexec flows, a #VE exception will be raised which the guest kernel
> cannot handle it.
> 
> Therefore, make sure the CR4.MCE setting is preserved over kexec too and
> avoid raising any #VEs.
> 
> The change doesn't affect non-TDX-guest environments.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

