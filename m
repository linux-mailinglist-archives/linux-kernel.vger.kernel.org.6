Return-Path: <linux-kernel+bounces-219712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89E690D8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F89DB33201
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85913E05F;
	Tue, 18 Jun 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XTSKyQpx"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49722F1C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723538; cv=none; b=isg7maQIQzxpqB5UXOhoE5D13yyIrV72auvuFHdjKZY1pnGIFIcumv4zq7rTvt9/mp7o8vc/bJJ0sZsllKpkoctC0EPpIuv4cWO5K/3tDpc4Gf7Nw2EvEJuA4mmY3KSwmF+OYBGhZjNtZ9At5poMoV12SdRmrf5vrc64wws365g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723538; c=relaxed/simple;
	bh=k6l3TQ4MXgrNxiL1bUyoqnmaoZN0afZoN1L/ohLrSX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKI0gRdEAEWZqASAA1vnJl4TEVMxi2werBRQW6sBoC3LQQx4s8vJ3Jf1ktaS8dttQsq1Rv6aDoU3AmGjDU04D0TTOAJns6b7mrD4fMd4fxKe6ZdwXkmn2p/iULdG4MP3iuyhtEBUIstw/4MDEY1yY0oMsSnCkblQJQnhlLZGSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XTSKyQpx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42172ed3487so40488385e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718723535; x=1719328335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zktM13vzE16WFMh5/Cr5Qz12DI4f5rptllhEcUwb5wU=;
        b=XTSKyQpxUBEjWnc/9jcslQnzYjjWMbTYomTFYO+LYcq588cadf6wSFdeS2dA0lCa6d
         VivL3oguQzlS94oYmfS0g9IbpAvXWB7H6lNJRP3zqRyjTplxfWmXI2fM6uQbDmt79w1N
         jffL5L6rC8yO8asJfNktEc+uxv+No38P4EvBzyeN30SSDKtw4jfhOeDoYQ/wW4XCSZbu
         iWAaQtjiihf3wPlaTk/L0A2xHO21c+YAOLnyJA/LHa3kuvlNDFvXIzTwuFFifROrzTOx
         EGq7b6JOVUNsjN8cd+cuHVqDKXd2EcWaSNL0QnC7pX20u+rObjlrEJ6Hp/95Ik2FcI3s
         HyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718723535; x=1719328335;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zktM13vzE16WFMh5/Cr5Qz12DI4f5rptllhEcUwb5wU=;
        b=wep5u07nC7kIU7VX9uhjooE9l/GFYS2OD61qBXbrsRucD6pXnShw+lzy9cWMF3nD10
         22zSl/HlzL4KH9es7jJgx86SKaxessqR7HjfAGBuK+bj+NgDndjokM5f/njA3GXVDtN0
         mgaJBYboWkLZxmo1JQ2gb2XNfeX/I3CeAoucdVpCRqZVffRXMof+eKy/gJ/ix+vL1uEo
         lS+OAIzRRQhsglMJywEmd3W/dEHxycndIiFOjicukKhVKjxtL9bWeEVapWS+ye3bMKu5
         4bvuGchM/x3nok0GYX4ds25lOW8FWlPu+GBioFBIY8LZ8wVI/VNeXWYkg41bl0d6kbho
         mn3w==
X-Forwarded-Encrypted: i=1; AJvYcCXuTpGdi0Nr45gT55JnIPVclV4ZwE15pTKrk6+grw6li6pjrzhPql9iUQhjbCJPUQgvJ8vw7rn0XraVJdPpWaZ5dk5Nkgsatxw16pFh
X-Gm-Message-State: AOJu0Yw+ZoyDi3I56O1YDyCGiXonYT52IbTMSVyanAQhfTZwCIlKlCkD
	nidZi/x0IlUHoRcMp18/QdjKCnmbaJVjoN+ft0jL3ZCZl5vKfbcihRP98yAr8KpSppSwCmzQQTX
	C
X-Google-Smtp-Source: AGHT+IG96jprIRpe2giPfPgMSPu759yfEY2E+LThuHU3LLVf+jK2d0vhVUkcHLs7aRCIT6x8Cb1v2g==
X-Received: by 2002:a05:600c:4586:b0:421:2711:cde9 with SMTP id 5b1f17b1804b1-42304824f0dmr111067575e9.22.1718723535254;
        Tue, 18 Jun 2024 08:12:15 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229c60f758sm212680845e9.20.2024.06.18.08.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 08:12:15 -0700 (PDT)
Message-ID: <8524dec4-be7a-4423-8d02-92cc1bb4bf3c@suse.com>
Date: Tue, 18 Jun 2024 18:12:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] x86/virt/tdx: Don't initialize module that doesn't
 support NO_RBP_MOD feature
To: Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, dan.j.williams@intel.com,
 kirill.shutemov@linux.intel.com, rick.p.edgecombe@intel.com,
 peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
 hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 isaku.yamahata@intel.com, binbin.wu@linux.intel.com
References: <cover.1718538552.git.kai.huang@intel.com>
 <909d809d0a37e51babfe28f88c7fd1fdefa53e88.1718538552.git.kai.huang@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <909d809d0a37e51babfe28f88c7fd1fdefa53e88.1718538552.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.06.24 г. 15:01 ч., Kai Huang wrote:
> Old TDX modules can clobber RBP in the TDH.VP.ENTER SEAMCALL.  However
> RBP is used as frame pointer in the x86_64 calling convention, and
> clobbering RBP could result in bad things like being unable to unwind
> the stack if any non-maskable exceptions (NMI, #MC etc) happens in that
> gap.
> 
> A new "NO_RBP_MOD" feature was introduced to more recent TDX modules to
> not clobber RBP.  This feature is reported in the TDX_FEATURES0 global
> metadata field via bit 18.
> 
> Don't initialize the TDX module if this feature is not supported [1].
> 
> Link: https://lore.kernel.org/all/c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com/T/#mef98469c51e2382ead2c537ea189752360bd2bef [1]
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

