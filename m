Return-Path: <linux-kernel+bounces-386263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AE79B411C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2B31C215C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D27F1FCF60;
	Tue, 29 Oct 2024 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cVAmbBPP"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A861FB8B5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173173; cv=none; b=kKWK9DDLd7uD2I5ehC40Pry68tDfeiiHRxr5LxP6BgjlKXAILFWr7J+ADr2eyc35p2oNgAwYtpqCU/vKrj4utpH2iK2I2quR26SXrx6wJKyYpgGVoRegARwn3nG+BI0XftWuk/7/W575MRq/cgEqwxQc2+Zsuh36CS+isTC7ORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173173; c=relaxed/simple;
	bh=7MTEDU/9KSAVKWqOtGz0SMhvzWL4F3+EUhfaTE/fXb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1uZr/yuXFWVlz90wr49PPem0RySVjGf/285VwzxuUZFbsvo8ox7JOaAya7BZMIWvjAHrmSL+4Gzu25thM2tBAYTxs/bNStNlaQ2wesP9G48bQuz16ryQqmxrHmRrCEM368jGtiPs7fDpqae1d/D0BOFFuxttDOi2k1JCjet0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cVAmbBPP; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71806621d42so2907271a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730173170; x=1730777970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gWeiUgOpqvVG172Cf4CPPhJE+kydeiEANPZ1xGY/Xg=;
        b=cVAmbBPPCBjvSAkHo4i8xRRhrN2b1z2Ien+ra2YKGTPc8RCGlMyG15aFEVydjX0Wf3
         Yy+7HC1WOJPK4uq4mJCIDZqVj7MAOHSjBwnKm91+0SFIAI0yCZV3fsqIfIMr6kPTInv4
         o7Aze8AqgFu7LmhwlWPZlYZTPQzYGlugWQvQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730173170; x=1730777970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gWeiUgOpqvVG172Cf4CPPhJE+kydeiEANPZ1xGY/Xg=;
        b=bHMvBWwIizLRYBGRPImGaPZzqv677PRxA25BM49A8XLBkhcTEa31EqtLiUA4Rk+3Cs
         KFmKvWrnrE0rI3M4QpKVqsdM8L8tsWQryTkAPhALb2wsA/gisvY3ktfqSsCZHJugg1e9
         aHDpUy6NSFIg/zX4jnkDbNiCu/J0XeguFlmZ585+PoLHI7GDJvwcl19J6KlJz97jcrX/
         J+8ufd7h3cl3zHxqh3GabsTGE92lLxAsfUEjBLlNd0HUy7h9UsvkQkWqF4+QkITYUMqY
         7R2O8jgyPZCLlNe4amd8isz//K/KEiUYaTsxOWHEQF2ZSrXnh9D+Pn1s1bREoiPe1sXT
         mZDQ==
X-Gm-Message-State: AOJu0Yy+uEhLzns8UNuhJrMn/n+ffX/GaU6RJtkftGZ8qO1fbI11nQ1B
	xpuNzN1rX8xAF8JM30SUsXFptoMEBvlN38nQoKpJ63p2l56tCXtseH27MvYWW50=
X-Google-Smtp-Source: AGHT+IFVFjxSPDCFIqOm9TkyhztXbygtp6FgdfjFTfr/YQK7P48YubWfGMFc6tYAcGYM8Y/shO+ngQ==
X-Received: by 2002:a05:6830:700a:b0:717:d012:a513 with SMTP id 46e09a7af769-7186822c96fmr9756363a34.19.1730173169752;
        Mon, 28 Oct 2024 20:39:29 -0700 (PDT)
Received: from [10.200.3.216] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0cf9fsm6537368b3a.124.2024.10.28.20.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 20:39:29 -0700 (PDT)
Message-ID: <f9d8f7a6-22a4-4d03-ab1e-e488dfdbbd51@linuxfoundation.org>
Date: Mon, 28 Oct 2024 21:39:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/watchdog-test: Fix system accidentally reset
 after watchdog-test
To: Li Zhijian <lizhijian@fujitsu.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241029031324.482800-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241029031324.482800-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 21:13, Li Zhijian wrote:
> When running watchdog-test with 'make run_tests', the watchdog-test will
> be terminated by a timeout signal(SIGTERM) due to the test timemout.
> 
> And then, a system reboot would happen due to watchdog not stop. see
> the dmesg as below:
> ```
> [ 1367.185172] watchdog: watchdog0: watchdog did not stop!
> ```
> 
> Fix it by registering more signals(including SIGTERM) in watchdog-test,
> where its signal handler will stop the watchdog.
> 
> After that
>   # timeout 1 ./watchdog-test
>   Watchdog Ticking Away!
>   .
>   Stopping watchdog ticks...
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index bc71cbca0dde..a1f506ba5578 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -334,7 +334,13 @@ int main(int argc, char *argv[])
>   
>   	printf("Watchdog Ticking Away!\n");
>   
> +	/*
> +	 * Register the signals
> +	 */
>   	signal(SIGINT, term);
> +	signal(SIGTERM, term);
> +	signal(SIGKILL, term);
> +	signal(SIGQUIT, term);
>   
>   	while (1) {
>   		keep_alive();


Thank you applied to kselftest fixes for next rc.

thanks,
-- Shuah

