Return-Path: <linux-kernel+bounces-308878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A5966302
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1D22837B0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22B11ACE00;
	Fri, 30 Aug 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E30l85fb"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F114199952
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024931; cv=none; b=cAGeUt/sGPq5fUJLFWKP/5JsiC0q6Z9dLNS1R8uPpSaE5+W5Dyv4X8HuOBTxoI56A23e/CPv7Zzh2OaJMhgUqghMJkgvFGcn3KwU0ZQnlKcrxdHNyS/NTYKsnPkuNbZyHXbCra2Aqk4IpT7UXIE1oN+YdyR1CU51QPggmNkzqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024931; c=relaxed/simple;
	bh=bG2QJU+RysPPNXXbdeo596snXbZUz33HdRuBGNnU1jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCVeoRFWOOLXWMhfZeb80JgXNdYF4BbP3FrwOM8/hiuTSbZmWJNiXvQ092etwuqB+HbLW5Aw0ZZL7w/ZNN+bsAKKdzBGavM2zMzNcdAZnI3ySXmGl2/1qpuT4e3LNlVM94NIS7QyorXMVeXPCZnr2S5P0+UlpCtezR6B39gV0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E30l85fb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-456768fb0a6so11071241cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725024928; x=1725629728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHvnH/4zOuzzT8TCzaUdUbOM1uEXUpCOxCXYL3PqkuU=;
        b=E30l85fbSojXnuXxRtMmnTpEUKNtWrxsvdSUjjbEYSm8o00Dzn0A3IjJQFbsRXUwlm
         3ogKcjjt8Eqyafsjm0s7aK3FbNAB3FZ79zoSH8pGvw4+DtkoZmSP9/lpcyKQZ4+dn0Tk
         lA55KuhOno7SkXmHj+L4IrB9EwdVfS8MU2BsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725024928; x=1725629728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHvnH/4zOuzzT8TCzaUdUbOM1uEXUpCOxCXYL3PqkuU=;
        b=npWhYw5ekJQ4H1SxlUp5Fnzzhn+k/4D7tX6iHPEx+yftv1VTJN0wtASwEPZuYB23OT
         L/xS/ljR0HJrIq09vE0MD2Nm3hHEziCXcZ9Npouv4B2gUM4p6XkBqt0u9ROGNTBR70Yv
         8udrf5kp3Ok4CvSyw6owbmfNYjX/vM0kfvMIOoHngizKkoKEkY8/y0pYtVGZJA/3tPGu
         ll/rJOB3jm8qER2QKYrwGN2tcWw+iNrcF8pOHiL3hrvDJzBcML6GdXEhfzGkSGRo21GF
         Xj9GDb/c9wh1bjOTLYqjZiaLWikSFuRyXnqkExEPpZVMwyajOMkmyt89d1pW3IWnBlxQ
         ol0g==
X-Forwarded-Encrypted: i=1; AJvYcCUEcfM6KoOPipz0eSfhaZySH+o50p0eBKWAZin59eDl3pcM8hnyS278YpKUOkT2jNsDvz9NbkbBTx6AfnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzOQIaGTUsGaDiTaVijmjSkVaqiNKEYEr2bvlBPmYwPRVZjZt6
	lhvr+U5beLQPoIFQ8cfA4yYVa/XqXSCMedr9NQ8F7j+fPQ3CiBulMVKW4PtNSck=
X-Google-Smtp-Source: AGHT+IG8cg3+iwNoBRjX29bHUWGerLYZqb/2lmBI6h5IfvZ9WYS6tunfEvRS+bcOhw4pt4KgG5PXtw==
X-Received: by 2002:a05:622a:40c8:b0:456:4688:d70b with SMTP id d75a77b69052e-4567f71c204mr79224871cf.61.1725024928201;
        Fri, 30 Aug 2024 06:35:28 -0700 (PDT)
Received: from [172.19.248.149] ([205.220.129.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d66c9dsm13869521cf.76.2024.08.30.06.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 06:35:27 -0700 (PDT)
Message-ID: <af63ebb4-af0c-4b0d-9b58-691be5087868@linuxfoundation.org>
Date: Fri, 30 Aug 2024 07:34:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] selftests: vdso: Fix vDSO name for powerpc
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Shuah Khan <shuah@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@mit.edu>,
 "H. Peter Anvin" <hpa@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Shuah Khan <skhan@linuxfoundation.org>
References: <6c5da802e72befecfa09046c489aa45d934d611f.1725020674.git.christophe.leroy@csgroup.eu>
 <ZtG-DqWo8kBMocVh@zx2c4.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZtG-DqWo8kBMocVh@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 06:41, Jason A. Donenfeld wrote:
> Hi Shuah,
> 
> No 0/5 patch, so replying to the first one.
> 
> These are fixes to the vDSO selftests that Christophe is ostensibly
> providing as a preamble to his work porting vgetrandom to PPC. Do you
> mind if I take these via my random tree so his PPC vgetrandom code can
> go on top of it?
> 
> Jason
> 

Yes - here is the Ack to apply to all patches in the series:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

