Return-Path: <linux-kernel+bounces-370045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A439A2697
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE74EB22C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55911DE4D2;
	Thu, 17 Oct 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z7hdP4Gn"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CC36127
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179038; cv=none; b=T0xbmx6OFQOUhO/oJYXqm9tMmXueDzqmLDYdD40Vv3gWVPReoS1yow8tuDP85Q+qYFUSTtLGpJJfQdmBdjaRU5L7WSUz0uKYcJk2jZKSyh65xk7edL/Mao2e07P9ShWIgoLdDLGL7E0BYiOE9buMLuOKswmMtBktcRR+JfaV1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179038; c=relaxed/simple;
	bh=PNSn8JdwfjZRo0oZBmbRvsDOcpUti8AOvdEcLNSDHQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYdOti0AJmMgqdnLQUA9VaIUEM2PHpYVL3iB99O48kFbPLD1FQD2f1nNHB+6H7EBV74f9emh7xxIe84H3VvnBsApYCyIsG1p6KWAMNSsguqg/u+vuFejHRhq59xyeZ0C3IIVIHvTDvMTbSxOJEqubefhTzFnKZybErkFGBL086U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z7hdP4Gn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so861972f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729179031; x=1729783831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Feo93T3IFXNm4HhOpDPpsqYNq1DOXUicGO+5dcU2cWc=;
        b=Z7hdP4Gn/mOzrtOS+vLTcw+fnNSqxShHOg1CrY7wk2VYROdDRrfinNOq7Zd2nKbmpY
         C9yFLRJksyADiWoEma8fKw7g7jH0apbPI9nQ9N7Y3XDCpwU30jP4IcFbrPqojY2H3b2z
         dJ2hL5n8Zmqmm2IU9s07YrG0p7Ga3TV/kllBGpW3LJZ8PkIWgTvjTnTvBKCxVCaw8HlH
         CvW7+ntGGqBHPeu+Ua7iZKzIevS10RsRP3HZk+i0EJ1FDa4BhJgg0KjBc0dukFwSqdao
         UfmwRjii5ZhSy3tbuZBTA2CTy1uDQWgWe7FQuYH6KjuGQ3Z9Spg5iub0Sq+VqLQuIrG/
         0+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729179031; x=1729783831;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Feo93T3IFXNm4HhOpDPpsqYNq1DOXUicGO+5dcU2cWc=;
        b=HUi5v7kDxjDC/mCQnpNNA6RBtMUb1pemaktw0ScC2QHl3MRjz8aWOXQ8oZ5qmwlSMc
         tZDp466V1KJd2CMXsSmV1+THYOmBrliqWNOn8DJuVPBDBi+/x1UWj7Vf6oi9ZMd7q99M
         nAIASWyObRuMl/+FCzmOSx/OtVTl9INBsUpL2kc58nJtQnzYVhTfF4ofj53z67GVug0i
         9vw86hCvKFVWpYV7kmtKEt6yhkycrjhbCtKAOOCfBgdVAbbEaBeYPmFm12d5tznIvG6X
         cey9zNXP3W5MytBf02aMw6mglFZQaBaRObKHUAWqyVAQ1amoJp4f+HQp73XVbJQAGGJu
         ZGIA==
X-Forwarded-Encrypted: i=1; AJvYcCWE9CWm3thqYu7r+zS8EguE+NME1PKR4uza0qvXwTFcSvLqEFCb5CMCefja2T8OB6strPWxA4ZrYfA5yRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7dkUwETccIyn+Y+mHG7PRDmNzVEwVSGX5BzTu+SSwaJY6WkQO
	Qvt4RRHsHE3CcabPX/8CJqauaZ8Sr6GJ8qCYK1xdRBo93mvgpj9dr6BLqjvsYnY=
X-Google-Smtp-Source: AGHT+IHK3ud9hFvyUrnv43neEFvGAqfaknzHE9GK2ql0JjMBxyb/Yb0oE9sW+8FwTmGY0ZDnMPmdHQ==
X-Received: by 2002:a5d:608e:0:b0:37d:3eec:6214 with SMTP id ffacd0b85a97d-37d5529d96fmr15420694f8f.50.1729179030922;
        Thu, 17 Oct 2024 08:30:30 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7465:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7465:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf838dsm7644671f8f.78.2024.10.17.08.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 08:30:30 -0700 (PDT)
Message-ID: <5e9f6bf7-5c4b-4536-a443-5415413992a6@suse.com>
Date: Thu, 17 Oct 2024 18:30:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] x86/mce: Clean up some x86/mce code
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, tony.luck@intel.com, bp@alien8.de
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
 hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.10.24 г. 15:30 ч., Qiuxu Zhuo wrote:
> 1. Clean up some x86/mce code as below. No functional changes intended.
> 
>      - Simplify some code.
> 
>      - Remove some unnecessary code.
> 
>      - Improve readability for some code.
> 
>      - Fix some typos.
> 
>      [ Reduce the text segment size by ~116 bytes. ]
> 
> 2. Pass the following basic tests:
> 
>     - Compile test.
> 
>     - Correctable/uncorrectable memory errors can be notified via CMCI/MCE interrupts.
> 
>     - Correctable/uncorrectable memory errors can be dispatched to the mcelog daemon and the EDAC driver.
> 
>     [ Tested on an Intel Sapphire Rapids server. ]
> 
> 3. This patch series is based on v6.12-rc3.
> 
> 4. Changes in v2:
> 
>     - Collect "Reviewed-by:" tags for patch {1-8,10}.
> 
>     - Update the commit message of patch 9 to include the names of all
>       variables that don't need NULL pointer initializations.
> 
> Thanks Tony for reviewing this patch series.
> 
> Qiuxu Zhuo (10):
>    x86/mce/dev-mcelog: Use xchg() to get and clear the flags
>    x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff
>    x86/mce: Make several functions return bool
>    x86/mce/threshold: Remove the redundant this_cpu_dec_return()
>    x86/mce/genpool: Make mce_gen_pool_create() return explicit error codes
>    x86/mce: Convert multiple if () statements into a switch() statement
>    x86/mce: Remove the unnecessary {}
>    x86/mce: Remove the redundant zeroing assignments
>    x86/mce/amd: Remove unnecessary NULL pointer initializations
>    x86/mce: Fix typos in comments
> 
>   arch/x86/include/asm/mce.h           |  4 +--
>   arch/x86/kernel/cpu/mce/amd.c        | 18 +++++------
>   arch/x86/kernel/cpu/mce/core.c       | 47 ++++++++++++++--------------
>   arch/x86/kernel/cpu/mce/dev-mcelog.c | 11 ++-----
>   arch/x86/kernel/cpu/mce/genpool.c    |  8 ++---
>   arch/x86/kernel/cpu/mce/intel.c      | 11 ++++---
>   arch/x86/kernel/cpu/mce/threshold.c  |  2 +-
>   7 files changed, 46 insertions(+), 55 deletions(-)
> 
> 
> base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

