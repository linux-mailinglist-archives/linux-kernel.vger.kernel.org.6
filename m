Return-Path: <linux-kernel+bounces-195804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15D48D520C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEAC1C2136B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994C75677C;
	Thu, 30 May 2024 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMPlwtAB"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984D5674E
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717095808; cv=none; b=D3EOD4Yz66gM/XVL/+wh28y4rcee9rxr612Lrmon07YXdhTlp1KVazy9cnAbd6jd3t2hqj/flerHJ3nJ12QPjGk1g+/GB64mgKTGtT56IeYvrv3cJc5LTRt8FLiNSv8wepjtqOIzX4Sc25C+bXTVXkWQhRmPNn5yQqDJjdaKPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717095808; c=relaxed/simple;
	bh=gVV3+IFYD1OxH/Wqhf1iWQFzYnfj7Ay2H+idOty2pyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uK2fHIVhp1nOQyZ0ocxYeKSWLxGnlqlpNRHxDEBQ0f7QpIeRCCo140nE5sqdM3jG7eOyIxFlv0lg9hKythjZRznqotH6Rl32oKMuD6MpGBE1EnRlmIjhWszzvQ+Fseev3avH0+CPElWIpdPiVnd5XWc48RblBCkWBsLmlRFnA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMPlwtAB; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7eaf9e5681aso4939439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717095805; x=1717700605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ypmVzNDeZplp2odL/zLGgH80NvTjOKRz+Qmx+RXyRY=;
        b=QMPlwtABxb6varGIhZXdwk8f3EDnI1006FUZPLFIKKF4WFUZ0ajsRmAx3Y8YeDUc6/
         pEKSrZveI7r7KVAyTnfFEZFwI8W1IB9Byry98YkCRKEbUqC92RDPTzFnqta33dw8iXRu
         mcBmoCY26bFlGuyVzqV4eEC4Mu1A+qowzCgTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717095805; x=1717700605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ypmVzNDeZplp2odL/zLGgH80NvTjOKRz+Qmx+RXyRY=;
        b=dDrXED6C1fTnc8URIaCq1mCFeNgWWxz5o+c3/l4L+5GjqPPB3r/+Q1DI+2W0x+19rH
         lVLlx8h4ms1jPr3wBbVLTHrIxkzmvWC17bkT23vP7oPnOSItKGdIvAvT/XfCZBXkfptU
         IvQRtjK3gR8PBq53HE918+XSN1QJXqiUzFlhbZiQZdPUzldv2OkGmZKN/VsurmNTKUyA
         AJ3V2ukhylsAbWfNAXAUX2rPYnFTE69cER3MPfKcao0fj6O4SPLi30g7gqgbXugzQDXY
         FoeY/3U8ZbQbKzmeKJSNeE9FQ7ASULZEbbVjsbViKHg4Knk3q2wgkRpa1NKRkoxj8TLm
         zdNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJMgJCkOEcwyKPvlbDi2Be/SeZZsvwzmOM3PQLYyCTB2OL1ImzW4KBBwABghP6OtQywypxDZCiK0vS1HKmKg12h2Wa0SkevyXlczkJ
X-Gm-Message-State: AOJu0YxXL3JdfSVAeaJ5r0tgaX6DLIRQNEKvgCoOusNU4xYay/WG6f7z
	rp3wuwI5loiIeLnUJZgoDZVII6t2geuOs6D4MamZLziz5blsMTwiPoj5WsRkjb4=
X-Google-Smtp-Source: AGHT+IHL2RIktWzDYsXqMYxWTYOSCdmd0gSX4cuLtu57cIFNBVH+YBART6vih1ekHP9lPpA0zCGiCg==
X-Received: by 2002:a05:6602:3344:b0:7de:b279:fb3e with SMTP id ca18e2360f4ac-7eaf5d6865bmr293265239f.1.1717095804736;
        Thu, 30 May 2024 12:03:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48b8a6db0sm61826173.98.2024.05.30.12.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 12:03:24 -0700 (PDT)
Message-ID: <ceb9182e-b6d4-4f6d-bb53-87efe5337230@linuxfoundation.org>
Date: Thu, 30 May 2024 13:03:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/futex: don't redefine .PHONY targets
 (all, clean)
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
 <20240529022938.129624-2-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529022938.129624-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 20:29, John Hubbard wrote:
> The .PHONY targets "all" and "clean"  are both defined in the file that
> is included in the very next line: ../lib.mk.
> 

What problems are you seeing without this patch?
If I recall correctly, futex needs these defined.

Please provide information on why this change is
needed.

> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/futex/Makefile | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
> index 11e157d7533b..78ab2cd111f6 100644
> --- a/tools/testing/selftests/futex/Makefile
> +++ b/tools/testing/selftests/futex/Makefile
> @@ -3,8 +3,6 @@ SUBDIRS := functional
>   
>   TEST_PROGS := run.sh
>   
> -.PHONY: all clean
> -
>   include ../lib.mk
>   
>   all:

thanks,
-- Shuah

