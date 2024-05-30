Return-Path: <linux-kernel+bounces-195807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DAB8D5212
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2606F1C22419
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D466BB2F;
	Thu, 30 May 2024 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QTfwsmWE"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6D60DE9
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096054; cv=none; b=k0Fbw8mj0sHr1B+SREfLzAygpXQS3kJh8TKMPq3JAFt4O+uMnYRYSuokonAOlVYAUJpZWaHzHrp0WwuIDngCSozOJKwjFoOxDsKWRJSbKOqDANxSUYfE+rqvnRyhvk6cnQcxmP9OCevpN1bHtQsL5gnE4aH5OTc+zlM8D+Ci9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096054; c=relaxed/simple;
	bh=imZhQcOLo/A57RIklfhNXDPLYJZwF4mjSMXlBfn4bjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKpZgfZAsjD/ZWAiajANzKTnykMMrYHepMJKryn9IjRHmFXz2kHQnIhAcLSp2q1FTCy//Vfu8iWNgQWz0XH1arMDNL+ktCbxZ+/bhKvqW/TMkbWnLfElfMtEqwi2nTp76Nx3EyShzMz3b4RNcDW9mnN7jjwAJ3zvHGshXPbuXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QTfwsmWE; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3737ee27cb9so668605ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717096052; x=1717700852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bUYnIhpz2h+On3VZsj3Zd6/727awMN92YMgceCOy3k=;
        b=QTfwsmWEN4YXPGyWZyNfv8HoVgJhfzs9XxySraioDrTV7REQ8szrv/Y3wp95Ghij0x
         c1mBg+fHrBzs0sX6viDhM+XerI2Ku40nZO3P4FIZnu8cObFx15MSp0/8Klgad1ogZypd
         7Obwi9vsXY8i2DSCI/65bVKu1Orzqhp4ll32E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717096052; x=1717700852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bUYnIhpz2h+On3VZsj3Zd6/727awMN92YMgceCOy3k=;
        b=xVRcT76/0QIJTv02fPaZ+L+5N3i1357s5S3x9RsQ8hd/gQwB6JhNaB2pWToMgRBwYZ
         xobGddNLLVpHAeGpX2y7D1y010mg4Cg/ucrgt6kcZKSrp1H8wETSHaXKEe6b8+PEDVvJ
         8Rq8ixUH7lJ0EeQJls3znRWzoP0uPAolVxlM+Ls+RkubcGrJs+jk8TprchnbmeXHV23d
         Ail9aQl5kDXrcS79eK56hy7Cz87HNs5NyT0uDIE71GpEADcXVxEbVoPE74fGra1vlNXJ
         zrKkiREGhSMtlPagBGAPeZPZDh3qBOBilGvEEGMYckfvoqsXftfgfADznWdAkBGzI62G
         Uh4A==
X-Forwarded-Encrypted: i=1; AJvYcCWPtGwPQutD17Zq4XZvVsdTpGpNYDGqGuhGHTEZcRcb9fOdMoSNTVA50fxId6H4xmLsr2vL6GgEkI5mnryvT4JEjACCFsa11mqZ+F8Q
X-Gm-Message-State: AOJu0YwFXMkyjplVRR6YGAuENWEvqBC3duxa+LnEdyZ+vWG7WigmtTw9
	uGpT6rSiCQ5jgDEmjife6WmUFIJDJQWAx4uZhfxClbEeUpz8M9RhpOl1ACSpeMY=
X-Google-Smtp-Source: AGHT+IF9l7LBfGVRaO1lXseUgLjeTwRtLuQbVpQCUEF4bDP7enC9s+0s5gWCrSJYh2zfm16q0xSmUQ==
X-Received: by 2002:a5d:8601:0:b0:7d9:eeb8:ddeb with SMTP id ca18e2360f4ac-7eaf5d91d5fmr333582139f.2.1717096052448;
        Thu, 30 May 2024 12:07:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48764e4b8sm67181173.35.2024.05.30.12.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 12:07:32 -0700 (PDT)
Message-ID: <dd3f1b86-504e-4b65-b45f-2e36fc55f179@linuxfoundation.org>
Date: Thu, 30 May 2024 13:07:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/futex: pass _GNU_SOURCE without a value
 to the compiler
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <20240529022938.129624-4-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529022938.129624-4-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 20:29, John Hubbard wrote:
> It's slightly better to set _GNU_SOURCE in the source code, but if one
> must do it via the compiler invocation, then the best way to do so is
> this:
> 
>      $(CC) -D_GNU_SOURCE=
> 
> ...because otherwise, if this form is used:
> 
>      $(CC) -D_GNU_SOURCE
> 
> ...then that leads the compiler to set a value, as if you had passed in:
> 
>      $(CC) -D_GNU_SOURCE=1
> 
> That, in turn, leads to warnings under both gcc and clang, like this:
> 
>      futex_requeue_pi.c:20: warning: "_GNU_SOURCE" redefined
> 
> Fix this by using the "-D_GNU_SOURCE=" form.
> 
> Reviewed-by: Edward Liaw <edliaw@google.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/futex/functional/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index a392d0917b4e..994fa3468f17 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
> -CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
> +CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
>   LDLIBS := -lpthread -lrt
>   
>   LOCAL_HDRS := \

This looks fine. Applied now to linux-kselftest fixes branch

thanks,
-- Shuah

