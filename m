Return-Path: <linux-kernel+bounces-242748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1572B928C89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57141F21EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFA816D33A;
	Fri,  5 Jul 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NROOo9Kp"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CA32F5E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198503; cv=none; b=HNpBNMO7Tv7/Cyv9mL/OO5M8uK6f4vwsEei8AjHmME0msEPCx0c4frlhNsSNIuk2UKoRoNF8+Knofy0mCKD9ozlkaPT3IJyMDrihIueSs5tNRRkcl8YLVA6QiC95SAHiZFOzeyOq5yzEXgoh3qrqM5XGNxGnVrusfUx45CKXW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198503; c=relaxed/simple;
	bh=JbpMAAp767cJMVvvsfmlKOVKEDBe1tv8WSltj4UH6v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEIQepEZXplMqp92dvmLqdI3WccKUiquk/LQi444bdrQivKMDUr1/d1NO93n++CFcItXxBNn+GaFML0pydDcT1WnUUNY4AKdzHONmV2Jq/zYSqQviWiKyxILeBXfCNi1R/5xe+VPe97OBw7TvnpuF3nNszZhewG18lRSwmPADss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NROOo9Kp; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7eeecebb313so7841739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720198500; x=1720803300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+6p2HoNrUHHa/yVChF/+f6ARUdHwWa9m3WGICPV8zw=;
        b=NROOo9KpWSPZfPUGqznxS507ekb+9dNphmCi46NCzAbVkDaYaca8H8Pfkgq52smB1H
         ccJE27E49j1KUMmx/kzc9MrLrzm87a58Kd1gNtjNPAOmLNwjxD0PQySmxqNbcsJqoV2S
         wtM2BWQ+WpeF1AmKE+R7FTfdlyf6BSwDe6bWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720198500; x=1720803300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+6p2HoNrUHHa/yVChF/+f6ARUdHwWa9m3WGICPV8zw=;
        b=HM6R/s8sGBEPSQt8rOPOt1i6BfZiNTTed03xsIEyqFv7BV9ycS86FEgUf9bHdHs1Jk
         ZSoO2fazxReqgDbFza3TSMMnDT9df78iZ4+Z64bXWQWkPqWoMSiuNULnMtAZbahrED4+
         Tp6d7eK1NElb9QHol/0ys6vX+T3fM2+RZmqYbhOWkY6b+pSmDN0nfGEjjBiNBn5W+9c/
         EpZC/E8n7fp3oq/0QP8vRm2ntWc5qs4wKXTWkMf0FaogIDHkQZ2YG5evVW/flz/mLYvx
         nXyK6heg8v9qB2Wm+6p0Nnk+I0FU4fMSJNgWVhK4MPVRa27BpbARuL+EiMAiWWRTyHtM
         5QyA==
X-Forwarded-Encrypted: i=1; AJvYcCVp/wVmI/He+F1EifJnAXQnLhmJTnexAOMBDP4ErItIbQPfw0FhaALgbxgSEBnf8W61/jXNVpy17a1/3C18KzhupVYO2Z3munTSxpse
X-Gm-Message-State: AOJu0YwgXMRT//V6Hn8Of7QyVMkRCqgsekyvUq6blp+5rWJoZDeVWeOm
	ceFne/7SJC8Xhso8LwfzhNmO4Ra2U15UiItI7oM16VlSej+3fszBxB5jDMW+4wc=
X-Google-Smtp-Source: AGHT+IHY3in/e9Yxt3K+EtGGW2Ojce03GKiDSgxyEYqs6zBH6DryDUXwKCb6gpUav66FAfp/eAhNgg==
X-Received: by 2002:a05:6602:6211:b0:7f6:5178:8607 with SMTP id ca18e2360f4ac-7f66df05100mr601855839f.2.1720198500122;
        Fri, 05 Jul 2024 09:55:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73f910fdsm4521403173.91.2024.07.05.09.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 09:54:59 -0700 (PDT)
Message-ID: <9262c7ff-41e6-4df2-a335-e81897381ed0@linuxfoundation.org>
Date: Fri, 5 Jul 2024 10:54:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] selftests/vDSO: fix clang build errors, and
 Makefile cleanup
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704023324.83564-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240704023324.83564-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 20:33, John Hubbard wrote:
> Hi,
> 
> This is basically a resend, with a rebase onto today's latest Linux
> main, in order to show that the patches are still relevant and correct.
> 
> Changes since v3:
> 
> 1. Rebased onto Linux 6.10-rc6+.
> 
> Cover letter for v3:
> 
> Jason A. Donenfeld, I've added you because I ended up looking through
> your latest "implement getrandom() in vDSO" series [1], which also
> touches this Makefile, so just a heads up about upcoming (minor) merge
> conflicts.
> 
> Changes since v2:
> 
> 1. Added two patches, both of which apply solely to the Makefile.
> These provide a smaller, cleaner, and more accurate Makefile.
> 
> 2. Added Reviewed-by and Tested-by tags for the original patch, which
> fixes all of the clang errors and warnings for this selftest.
> 
> 3. Removed an obsolete blurb from the commit description of the original
> patch, now that Valentin Obst LLVM build fix has been merged.
> 
> John Hubbard (3):
>    selftests/vDSO: fix clang build errors and warnings
>    selftests/mm: remove partially duplicated "all:" target in Makefile
>    selftests/vDSO: remove duplicate compiler invocations from Makefile
> 
>   tools/testing/selftests/vDSO/Makefile         | 29 ++++++++-----------
>   tools/testing/selftests/vDSO/parse_vdso.c     | 16 ++++++----
>   .../selftests/vDSO/vdso_standalone_test_x86.c | 18 ++++++++++--
>   3 files changed, 39 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 8a9c6c40432e265600232b864f97d7c675e8be52

Applied all 3 patches to linux_kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah


