Return-Path: <linux-kernel+bounces-240862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2C9273CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92EE1F2135E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B581AAE1A;
	Thu,  4 Jul 2024 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YdRfu8Gg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BDB13D630
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088242; cv=none; b=H8wlXvMo0AFqcBfcG4u77vKF68hC50ikVxsLWlHn3nAv/cBddRB+oIhmkwB+RbBo0OUgFieqzzv7qq5Nn1dll5OSicTqLNeZB1v36HTIlds3svCtlx2+zEhwfxcvi+1ogBK201nEXjPQkuUcMEGgT0fr1kdiQswkDsrub1zQkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088242; c=relaxed/simple;
	bh=DaPw7dhtBiHRIOzvHRhBDesbLihBnn9jCUdGqLgQESQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSGdiC5soiLFFV+wzHHrtiX5t00+VucloOlhumuprCNw7no3HQXkYmZ9+EEo3YO+2vclG5ILaYupSd26JMFoAdL1VTeRMWEg3u0jqv4+lpPen2XXW/L6QA77TvGBZbNGXLMwqGica/kLXQ4qQ3+Ybk0pmr4zTo8pm7cjZu3StmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YdRfu8Gg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424acf3226fso3228225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720088238; x=1720693038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMZja6vOfH2J15j5h8yKAKCQpQzNHB/MOqCeH7KtdDU=;
        b=YdRfu8Gg1xQRZsYkvoe7YKs/PLxTxS+AivrvS3pcFKuFkqqE8lHNnfmCQoFcWiR9Pn
         RboM8A/3+saV6sy0bWTye8E0tabPFEiZCT58J/x56LHklxn2Z6Ux207wvvra4XauWqZT
         /24BfVYUzQ68vAQrwD2I0jHYLHpnZMF4iQgxf4JkoOkfgxQtLCFbfG37Q3svYMLXzl/H
         QFbjRfefkbNy7rvo30ePGLmWqKltoMEPeubWWABlF1YmDq/KytBd2ClEMzpoNjgKc4z3
         asPWH55cc1sdR+vQcphVSnYNRv/w4iooOcqaPENz/LkMDCs6tPdnXIrEmTjn5eA80+KA
         atQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088238; x=1720693038;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMZja6vOfH2J15j5h8yKAKCQpQzNHB/MOqCeH7KtdDU=;
        b=NaOpadhkdeiTaIyv6cLa1cZJnkKZWe6B7j/TLNSE1W8+zb81gtjv957qnScboodDZ6
         P0sMYsf2ie/uDt2qIkZzNRhFfoylwjbhTwqwhz2jqKNLH3arYyBAuxgKXlSwGhE3hkcQ
         dB0Poi6PqM/WAwWdZucCkWUDxtPqT0TlD2ERW3gaeHB+Nqm+6Wqk+2gkBncdAnxL7hln
         yrM2RyjxMh0ls+WysqDfIoibRUhDWHMRdkOLNSbV3TYKgEJQ9vxg9pn2fQ/D1UTIVsBC
         MRs31CM8XSoAIGTbge7cPSdRm1nvd2B8rKbMGCpONEsWTIdZTYWjR4yyCr73L2zMbEBw
         FCbg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Ljv/E9gaLzoUOGNw0RH6yWh8eEGqZ4LdMmbwQdAAsO8l02cbjY3PO0ALg4g3v1E6x4Dyr4QMZGo5x4PfjILYYAOfbxNseC+P9TAA
X-Gm-Message-State: AOJu0YwHd/6ysIDM03WtfDahYxh4wvRE/MPqLt1aVyv2IMFZpRrfiFAX
	p8fp6gyWkQbMrmZn+YHOburWa2Mssl1cddoZw6f1ypLyZNWDfF/AFif7AcQxjoM=
X-Google-Smtp-Source: AGHT+IFLEULmeW45awVMyy9QHpYnbRzyVYZu9WLdgiVWKlySZDlomG45lfDJ0wofXRYQF3bN67KxQQ==
X-Received: by 2002:a05:600c:2147:b0:424:a516:13f8 with SMTP id 5b1f17b1804b1-4264a4694f1mr7953965e9.35.1720088237904;
        Thu, 04 Jul 2024 03:17:17 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:757f:bfc7:3301:6664:5531? ([2a10:bac0:b000:757f:bfc7:3301:6664:5531])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678a23b349sm6213305f8f.36.2024.07.04.03.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 03:17:14 -0700 (PDT)
Message-ID: <499db0a3-186c-4998-a1c6-ce774a2d6c25@suse.com>
Date: Thu, 4 Jul 2024 13:17:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 0/4] x86/tdx: Adjust TD settings on boot
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24.06.24 г. 14:41 ч., Kirill A. Shutemov wrote:
> The patchset adjusts a few TD settings on boot for the optimal functioning
> of the system:
> 
>    - Disable EPT violation #VE on private memory if TD can control it
> 
>      The newer TDX module allows the guest to control whether it wants to
>      see #VE on EPT violation on private memory. The Linux kernel does not
>      want such #VEs and needs to disable them.
> 
>    - Enable virtualization of topology-related CPUID leafs X2APIC_APICID MSR;
> 
>      The ENUM_TOPOLOGY feature allows the VMM to provide topology
>      information to the guest. Enabling the feature eliminates
>      topology-related #VEs: the TDX module virtualizes accesses to the
>      CPUID leafs and the MSR.
> 
>      It allows TDX guest to run with non-trivial topology configuration.


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

