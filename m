Return-Path: <linux-kernel+bounces-350840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F44990A59
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E911C21B97
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDA11CACF8;
	Fri,  4 Oct 2024 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S7MqRoLY"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FD1E376B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064016; cv=none; b=WvplziTgW0B/nocGz1YHTwEpL8f6HgTucp1F9Ov7M5/LarTArfoFrKuQH5MeHCOoXBMgKCvzfMY/Wnjc/U5IPTcR6j8hCvGtD4QRVgZE+rjWNKMlUDk0TyN2pWTi6V30rzF0Sf4T4wslX0PMfO+ScWcUfnzFSQ4CTrPaqx0nMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064016; c=relaxed/simple;
	bh=GwoXEC+JDw3AOgTRVFZNEvsljq1NfcUkok84EeESg7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loKr2Y7vFXR4xeLOkJ6Qj3GywZQgs15z1uvfMK8o5PsyeZ0P1yssZg+0wRDKaB9GsphAlIHkOrxnzyJc80S/gQHDExREZP7DvmU8bCEey7q/qFo7pRoZaamHRTfHTtFVu7gDyNnJxmZYeHZRolFzQTlAfa1P5u1cezfoj8O+FuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7MqRoLY; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3445ab7b5so10771855ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728064014; x=1728668814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXmmCzvSCA40I9sZAZE8zqvwLWduBtnIuV1E1NtN9Hw=;
        b=S7MqRoLY3kVu6m/HorMGqSrdcKPCr8Al5f+urgd68E8GIR1SyyWZtMORP7+GwLJ147
         2p1BIS5zFybWuhZG4gZY38lVsVHgn+GH0zZ11aOi/q28HhpV1MG4VPGxdqlPvf5Mo6+J
         xHTJdZaaScyTJtkNTCvnHel8XiFYvXBaCr8eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728064014; x=1728668814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXmmCzvSCA40I9sZAZE8zqvwLWduBtnIuV1E1NtN9Hw=;
        b=wzlmqqRBcNYu1igA+fUwHWllzE5+/uPvfHvVWoux0bBG77EeKGHh96inEXLnkR8WVu
         5SvVykTpbraOf4XZrwgtXplUTD9u5FuiyggI9inl+EHuItDR/xzkxHdCJDlxi0U7AC0U
         j102QYjQsqScP39iR1RrPs3GJZieoSqV3zwXB9Gq0LiQmvAhz5P4XoQgTTFEjIjRDXAr
         slHbVOHP5ym91V1iGwLmd9f4Vm2jj7APYiyfC0IQQaSLOhDPOlQTiQFj5v8dX1zRpxS3
         zoFG3mpAVdaOaP/91iN1hqOfUcBr0bvAQ8Q/L0o/DMUDSKYRmey8YAp3mHsZTJ6Spwdw
         /o4g==
X-Forwarded-Encrypted: i=1; AJvYcCUxDtArm6BA7ApEW1/YnyAnxlYY+wH65nooXI/IEDp00PFycyTzYox7rg4fTpZxDNyY/eNqg84uU55DIM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxdyNCX8IdDP39dlHcdtlTZ50K2jQUR3mWZrf73y3QR+Ky5xi
	6dj6X1UFSPCfW0AffXS8rTII1TJOnSL1SLQrStbumXi2p355N46c/0ZlTSY0BGc=
X-Google-Smtp-Source: AGHT+IHqCu+1mXToIuh6Tj4b/PxFjs4AwlFkKnHoWB5eAWJ3yVV9VQlGQ32A8LuSsorPiDQr9x55Pw==
X-Received: by 2002:a05:6e02:1886:b0:39f:325f:78e6 with SMTP id e9e14a558f8ab-3a375baaad3mr27799905ab.0.1728064014394;
        Fri, 04 Oct 2024 10:46:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a7fd6cdsm656365ab.21.2024.10.04.10.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:46:53 -0700 (PDT)
Message-ID: <60dd0240-8e45-4958-acf2-7eeee917785b@linuxfoundation.org>
Date: Fri, 4 Oct 2024 11:46:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: sched_ext: Add sched_ext as proper selftest
 target
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241004094247.795385-1-bjorn@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241004094247.795385-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/24 03:42, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The sched_ext selftests is missing proper cross-compilation support, a
> proper target entry, and out-of-tree build support.
> 
> When building the kselftest suite, e.g.:
> 
>    make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
>      SKIP_TARGETS="" O=/output/foo -C tools/testing/selftests install
> 
> The expectation is that the sched_ext is included, cross-built, and
> placed into /output/foo.
> 
> Add CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
> selftest.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   tools/testing/selftests/Makefile           |  1 +
>   tools/testing/selftests/sched_ext/Makefile | 59 +++++++++++++++-------
>   2 files changed, 41 insertions(+), 19 deletions(-)
> 

Thank you for the find. It appears *sched* is also missing
from the default TARGETS in selftests/Makefile

This change looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Tejun, Do let me know if you like me to take this through kselftest tree.

thanks,
-- Shuah



thanks,
-- Shuah




