Return-Path: <linux-kernel+bounces-198571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB28D7A71
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7461F213D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB5A182AF;
	Mon,  3 Jun 2024 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QkHpPYmX"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9655E57B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717385167; cv=none; b=Zx4T2CJmJ2nm+T+kFpZ4J8NgY9iwLPhacNBIRFT/wjGeRPG++Y14xcFQHFG+wHwTLEL0eLtf1x/5nCcJqoBuM6aBBzk8jWEz0BvrockBfEeaa7BHfd3egE2OOfLggx1p35UeFqVbuEqYELZ3oic7nVVFHzZ1KTi/FPwt/8QDEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717385167; c=relaxed/simple;
	bh=yvv+ByU0rbcx7vOWOy8x/ELh363v8vdXoWdPA0FsBRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQlzeB2folrIZniKUQIb8zEc+l+zUKg9YnVDjniknIXV/EnO9rE4n/mjvNj9bMy2dC2Q+rL43dlhrcbMmPo0mvgqL/kT18VYp/0dn+n+wyafQ4rvXrL0LX1wwURw9Tjnxolx2cREJK27qRZ2XNb0T8U15I38E420vJHmmx98PXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QkHpPYmX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c3b5c5e32cso1791762a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 20:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1717385164; x=1717989964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LwQ1ur+Zw6epC8fpHSOEy3Qv64zBOx9AxtVqgOruovc=;
        b=QkHpPYmXrasO/8RyRcjZhPSGgPB6j0ZoliQg9ulUvQB6wetMcTmz3wSGkFoxqeXlvc
         hh7EHYVv6s8DkiwDuG7mpNV8OkJ9+gspYhB/O4jYlJx5jTBhemf4C272sx/8b4K4LvlO
         O1RUPrJmSlA0lwGyQSJUK46dWLXrZn6B5VYKmT/gGePJo87cS2oeoy7D0Y4MLNYwVFX7
         Y2Y3DQPVEs3Y7vWak1RTMq7avUVv43bdx1Fu7QoIKszybrTFVTejBPPRk88v8PDIkjv3
         shwMvQNzxQxrOdij6H4Zoun7wFm44GLhVHbq28mBXaeMfrFLfaTAzKnzJZ5l/ibhLOPi
         Zkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717385164; x=1717989964;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwQ1ur+Zw6epC8fpHSOEy3Qv64zBOx9AxtVqgOruovc=;
        b=P4Kr+o+4PT85JRabIlDPA6cwdfPpwo8hk0AvwfsAOVTpW0tFeE5WCt+uts3pRu4AhZ
         SMSITlMVtY9jnfsufHtVoHdQTFO1CkeEHQR15PNg01XCqEq0R4ZX4wn7nTHqBD90f150
         TwbhEdFB3FUWojhzjooIL27YLltm8i6voI3qdNrjLoQ+RgVwIhkPOqmKm7ke+WKS5lX4
         jVlG4sxKR2r7nbmw/TVGzJOz8vM505pFtJ9IrP6rBQoegNU3eXvKtsJ1ah0hcLvRVMYb
         5Apg7X5NPnLgEu+u7c3TQxsyBGFXKF6CQu60EglHNp+2anSUrbWC98xe6jDV3en+OKWW
         IsWA==
X-Gm-Message-State: AOJu0YxOWU1q8hS4XCPWbaJQtpelBT9T4duEKdz0tJCjQeO8h/ODX4Ye
	iEH0CbUOtjyHkszwis5lncXkQqiGRTG4HgzYJzI4WhFvi5PMttYouWlzKIkMC6g=
X-Google-Smtp-Source: AGHT+IH2Tv4cKiRNQVhD1wf6Teq/PgQ5BlkpaRe+RFniaQBz77llJw3MbV2CLQoabS7NExxdNZni6g==
X-Received: by 2002:a17:903:2448:b0:1f6:74e6:1ec1 with SMTP id d9443c01a7336-1f674e62022mr24566395ad.68.1717385164007;
        Sun, 02 Jun 2024 20:26:04 -0700 (PDT)
Received: from [192.168.6.6] ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f683d1a770sm1403735ad.13.2024.06.02.20.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 20:26:03 -0700 (PDT)
Message-ID: <7ba64e00-373b-4c13-a30a-113646dad588@bytedance.com>
Date: Mon, 3 Jun 2024 11:25:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: test_objpool: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20240531-md-lib-test_objpool-v1-1-516efee92a05@quicinc.com>
Content-Language: en-US
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <20240531-md-lib-test_objpool-v1-1-516efee92a05@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/1 08:31, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   lib/test_objpool.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/test_objpool.c b/lib/test_objpool.c
> index bfdb81599832..5a3f6961a70f 100644
> --- a/lib/test_objpool.c
> +++ b/lib/test_objpool.c
> @@ -687,4 +687,5 @@ static void __exit ot_mod_exit(void)
>   module_init(ot_mod_init);
>   module_exit(ot_mod_exit);
>   
> -MODULE_LICENSE("GPL");
> \ No newline at end of file
> +MODULE_DESCRIPTION("Test module for lockless object pool");
> +MODULE_LICENSE("GPL");
> 
> ---
> base-commit: b050496579632f86ee1ef7e7501906db579f3457
> change-id: 20240531-md-lib-test_objpool-338d937f8666
> 

Looks good to me. Thanks for the update.

I added Masami Hiramatsu and linux-trace in the loop.

Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>

Regards,
Matt Wu


