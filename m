Return-Path: <linux-kernel+bounces-256559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B093502C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CA91C218DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFE11448F6;
	Thu, 18 Jul 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XXoQeCYH"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684A6F312
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317798; cv=none; b=YYaYLI/2SmFpbp0kSpbSILxl7ArwT5wV0F1CfOk8ZxY8EVUQ3Gjh22l2B3aRuEFawJVryzwGj6/t8x7runUN75Kqzp43ip90uS6Twjm7g4NL+Rr8ciKEZMWbrobEZ2AEf4NeIFiKS0FSRDU+KlmJ+OhSsOIl3/ixhdb5Wlc0NEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317798; c=relaxed/simple;
	bh=K6uWnfuv142hlHOwyPvV9QaMIF3hOqI8R61T7G6sy70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Smaltt1Fmuss42jw3004OyxeJp4ZrFS8daNRm72BVM/yi03l6EBbBtBwziJsYdcw5bUNOCbXWlRxm4/xtedEDjWGTwFOWVWoqb7N8mAyUYnhRnrrgjJZERFeqftFMGZziq2hwa+sjccRSIHdzF7PQdziK4vQHnE3dWvqnTMQEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XXoQeCYH; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39633f58414so489835ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721317796; x=1721922596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eyHkRuLKLIt7CJvpBlLgR3VZUiSSFQM6pSNtuomMfA=;
        b=XXoQeCYHw3aTZAeLODFAZpggTv2AohjEO0befitX441EvB4IJ7JXs2ocHDG5n0CnJt
         DVgN4BKqEKMeBFvPqtG4xqwqrRql+yF6RNswCL7nd5VlmsZ5zPLCqIfzkpfrLdIiNmU0
         OgmFMFcn3OotMwHdIsHGvfGehf/taxd213L5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721317796; x=1721922596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eyHkRuLKLIt7CJvpBlLgR3VZUiSSFQM6pSNtuomMfA=;
        b=Bh83szCgYB/AQeNzCr+8d35YwLHytlTaD42AG8Va8P2PBIXrThZRjzsk92aod51q+W
         i00QVFzlcAOFS7AddygP3LSyGgSmXInqnfeDnwMDJk5BYEyhhNOymZLOK1xpM5tGfnc2
         hyn49nIlox2Gw8VbfEkzLC89c0lE/bI1Js/dEEgI8z40uu33nPnAPhmmEaobSKWtILyV
         SL/+eR2mcHL31sGky9HA/K3bkFJgp4kreNw3InpwWUBdIEVBozk1lzgMaBwqzx7pz+sS
         Fn4ulrmnETcgvZxlKCqLy5hw6mNK6aMQjibpnSqlRhOWt1hLy+n6KWGi0EpP/GNn1/rk
         XtpA==
X-Forwarded-Encrypted: i=1; AJvYcCVzu9taGcLw+sCGZSQpFK0bUjge97k5tsVV1Ddnx4h7wbTxFQW/aOOHdP4mjNSiPc95gFDB8Xb7ElCVwMH5LHN91o4WbasrSIF8hQA9
X-Gm-Message-State: AOJu0YxKNaoaHWpxMUv+EaXwF6DdWS81PalDVQacrgCfGqQthCeFx85N
	6HkXhICJRUnLLVnC5cesMBX24xFQaiyfA6RqrHl8cwltgrp3MElehpguVpftmEachcBAlO8LO1Z
	5
X-Google-Smtp-Source: AGHT+IGYVhzxctOAfexOX7dw/ZA1MYSWwnjpUm6O3VzclkmAK0Ta8nPrxGaK2sLPC/XIQG20xNaCow==
X-Received: by 2002:a05:6602:1dca:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-817124ec4ffmr365322539f.3.1721317796336;
        Thu, 18 Jul 2024 08:49:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210c3aeb6sm1566811173.51.2024.07.18.08.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 08:49:56 -0700 (PDT)
Message-ID: <10a3905c-d9b0-4d26-bd8a-104851773745@linuxfoundation.org>
Date: Thu, 18 Jul 2024 09:49:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] selftest: x86: improve tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240718113222.867116-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240718113222.867116-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 05:32, Muhammad Usama Anjum wrote:
> Changes since v1:
> - Correct the description of patches with what improvements they are
>    bringing and why they are required
> 
> Changes since v2:
> - Update descriptions of patches and add output before/after
> 
> Muhammad Usama Anjum (4):
>    selftests: x86: check_initial_reg_state: remove manual counting and
>      increase maintainability
>    selftests: x86: corrupt_xstate_header: remove manual counting and
>      increase maintainability
>    selftests: x86: fsgsbase_restore: remove manual counting and increase
>      maintainability
>    selftests: x86: entry_from_vm86: remove manual counting and increase
>      maintainability
> 
>   .../selftests/x86/check_initial_reg_state.c   |  24 ++--
>   .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
>   tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
>   .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
>   4 files changed, 139 insertions(+), 141 deletions(-)
> 

I am still not convinced what how these changes improve reporting
over running "make kselftest TARGETS=x86"

thanks,
-- Shuah

