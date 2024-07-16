Return-Path: <linux-kernel+bounces-254510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27836933413
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58041F23F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D413BAE2;
	Tue, 16 Jul 2024 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YPmLbW6N"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C550297
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167550; cv=none; b=UhMhuyv/60z9qBmMLWYFwrU0iRbN/dez95gUQ8nQ/pS+lyahdfTwsOzpS2nP3yrsBLikzBYL0EsImA1ebkMHwa6hzqJ2EZkdyueCeUDyrs0BSaZrdQ+5d1wJUCac2WTzOF3DtPyEsWu5+P49fRbbWPQdHK4b4V2W85avHe98lAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167550; c=relaxed/simple;
	bh=CkJucEGBKi1vFXk+FISBw52fe94XEUxPABdSrJGtnik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8WuOcOfxto1cw9/MHZ5jcms/nXUxzaUbFfbV4KcJ8GlHnMHz0A0WmcrcuSBZsHfkoAuIOfl4lTkfOnh26kQHm4+n180cmjxnRTL9Y+Fs+dku7KRx/AS3b/d8z+ljluqLBLc9Sx4NUBiMgKWstagRKWbLpm37QoIiS55nj9q4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YPmLbW6N; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-805f8db779cso1673339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721167547; x=1721772347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTy42Fs8+Jr95ikyca40F3ZZbw68C7koXGwHU5+AQvI=;
        b=YPmLbW6Nidm326ajsTyBNUfVf0nQQmO2D4fjVqbxDFjBdNkaJHFyE0qW+/Yzyyea/V
         gWbOA5KO20Pglw1+b/z1LWF5O1/gdehIyrbSCvnESKe09vuYwmfsQHeq92sHBxzY73Cx
         pwQwSmb+WRE1X6G62NqjLIQtvmaOS6fYdeftE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721167547; x=1721772347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTy42Fs8+Jr95ikyca40F3ZZbw68C7koXGwHU5+AQvI=;
        b=NycD0+2UdCyBgkx6I3zLYdxqp/bGgnFTp65q9HM83sZT/jfwuBAEfeGpKU68C+VhNI
         hxEfVljkBmZK+7onS3RXY/K5cC/qct37MlpVBcXkq6DiKw8gIB0obGz55DwbUHSrcrOL
         j5Y+9V0E1sMyF397mnw/TuDW0tlEnJfzadYV9x7PuO/PucGnPc1Z9q0Y9PVPvBz56nTN
         K17gMKB9wG6tXhm08c6WO37oPEuPF9rldzbdUC/aMX1gODfj0BVwU3eBkkfUHtC5Xpja
         qCwm9fK72Htgnx30+UO3qLgBWml/cqnHWHlj/jIczxcT5XdJ3EWBNUyS0qHhGi++Uqrd
         Ax+A==
X-Forwarded-Encrypted: i=1; AJvYcCUEbaWgERmDS0kA/hOQbwEFMcKCZd1NowlJU4jINwIXU81h6adihk21NGdeAD1KsOc+yVq+2Ju1TpwpD+aquqszFxgHZznN7Lrmys4A
X-Gm-Message-State: AOJu0YwwCdkPLMwBiFuGhLjpBPcweGGVdcmYPz42uJbn6F3QwICt7HR3
	MZNNyZ7vigGzaMYaz0uFJrafyn0LK0Lv/E9qJJcqaElSxL0MW5VPs7h4PrkVj3o=
X-Google-Smtp-Source: AGHT+IE2IqcYbobmy7qTVhbdZ3wHj43JwoI1DCRUg7A9WkyucXMp8aVsR4PxvOlGGhZEtgFjK7AWYw==
X-Received: by 2002:a05:6e02:1ca5:b0:383:297a:bdfb with SMTP id e9e14a558f8ab-3950caf0331mr6268715ab.2.1721167547604;
        Tue, 16 Jul 2024 15:05:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950b6ad7bbsm2002345ab.42.2024.07.16.15.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 15:05:47 -0700 (PDT)
Message-ID: <4fe7c1f5-e2bd-41ed-8302-876d2eb73a50@linuxfoundation.org>
Date: Tue, 16 Jul 2024 16:05:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] selftest: x86: conform tests to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240712084625.297249-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240712084625.297249-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 02:46, Muhammad Usama Anjum wrote:
> In this series, 4 tests are being conformed to TAP.
> 
> Changes since v1:
> - Correct the description of patches with what improvements they are
>    bringing and why they are required
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

Please check the submitting patches document on writing change logs.
The change logs in this series are bullet items without complete
sentences. I would like to see before and after output for the
changes you are making.

thanks,
-- Shuah

