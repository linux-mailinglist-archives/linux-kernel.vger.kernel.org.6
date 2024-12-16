Return-Path: <linux-kernel+bounces-448274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272B59F3E05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E416BA70
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D51D8A0D;
	Mon, 16 Dec 2024 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EEMjdNxb"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462501C2443
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390504; cv=none; b=idGCosGh6TmxXgHVLbtz2bPSZcImO1IS07UvI/b8fn5d9mXsn+Pw7MePHoDo9xVaob8vK188vAmeujUFCwM9lZ3YAFqGWe7Q795LA6kkuLFLxOSyIQkveYZSUirXFioe4w7FERZUuspdd+dh2/k7A42IMZv/brvuEwdBbzPU8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390504; c=relaxed/simple;
	bh=BOY3hgn9j9vkltOI8aTIIoi8jv+JFmY0EGyzVvQu70g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPvevvjy2i9DWtehmkVEjUSYOXkHrNggx4RLnVOy3xD2kGP32mk15KcphfvEoKygHlPcknKKCeTk1s/YxK21RRPzghcmAGhB8abwB0UkRMfXVLBFhHh5TS89998to2NYIl3grFKztEBOabg3I+XHhbuQupx6bLDMVxeHw/KHNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EEMjdNxb; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844d67eb693so336220539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734390500; x=1734995300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OS94voLSWfEjTx6K2R3aOqE+lStws7kGltqqRCQYk5M=;
        b=EEMjdNxb4BgOSyvaym+dKnvFTSTIr2HsSljauEE4UsVqBPIWQ+2fQVioMOzLy5yIcV
         nk4EHFTYlz1L6+zo4kMPshM95sABvhi1sVXP7IUSMXVq5/cGOPZt4Xzrs/CJjf6+q7pJ
         0tft9DxyLZnSzpyutIOxhiOlAPwbr4usQeu7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734390500; x=1734995300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OS94voLSWfEjTx6K2R3aOqE+lStws7kGltqqRCQYk5M=;
        b=Cp6iXEvMV4rlBa3Clebjirodwq1Q3tHbCWbqaj7bvbWR9Vi/efyzNsiPel/zPtr6CI
         6x9W9O9EEqOAPXdEatMO8z5bIUq1kEVdPOTaQaZlqCumk4RIchuIp3bEWdmC2SXZSYf4
         /k2n8XJTDPsN+cg+seXlMYx8e/Sc0On6KxFHFOxYfQbIVYtZvpmjQ1qD7I6thT0y+Sy7
         f3NozCPMq3brbswfWEo8en1z1A8Qr1Cs/75ce6G9+oFKRO+q0Z12N7yKAxGBDMAfI2F8
         YOkZy7mQp90rrKe7H8c5ihBK/73mO0+dG02Uoytsfu6xI/kaUp+8rD0pd8LmgS+xdDu5
         PUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYOGNznFGy6Xk/9XxD7BWOSotwbDkZFJDQIPAIVc8FXsh8HFNa2ShktaKntpK8ZyGSoe3AhxDrC+W52Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Xia57lggspKoP3vIr1higpb5bdtsqEqUSRVRVM4I4zFvgpG7
	z0RwRAn36AorvDs37rvSNn1ZlF0mJy1X03cnjblJls6foYkLOgNsXHQUg1CsYS1l3syUVTJiKW3
	O
X-Gm-Gg: ASbGncvouTgLoiKfxPoJXcWsAKgkFypoeun/TGPSpp27wD2oUu4gP7LW8qkhgIN1ovY
	R8Zx9hn/b6FlsD+BYmuZz7SnnMFnHkh1egcowwYBvcNF+4QdLkXvNBwFXbONXUfYtyww1d5Z//D
	8imu6m4HXJ/BmeL8AphJ/wz/W1tO6rYe7xMzYqTCa7qZ1VONitRpSp6i3SIT6tB+UxJEyhVjtfg
	4tShXdQbyRoyUeK01fJR9uPEhMkVNjaiQckLnjbll5qndt+jnFgvjviNMOKR61QXjE5
X-Google-Smtp-Source: AGHT+IHev4woPz3cPHVkrgHa5mG+siQEsm5AhB3LOex5FrUR07AUAr4fPtANg5m/efCiubNYW+tcmw==
X-Received: by 2002:a05:6602:b85:b0:847:37fb:80f0 with SMTP id ca18e2360f4ac-84737fb8a2amr446343439f.15.1734390500470;
        Mon, 16 Dec 2024 15:08:20 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f6239ad3sm152616439f.7.2024.12.16.15.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 15:08:19 -0800 (PST)
Message-ID: <16657ef3-72e5-4da3-8785-9f4391cc0002@linuxfoundation.org>
Date: Mon, 16 Dec 2024 16:08:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 resend] selftests: timers: clocksource-switch: Adapt
 progress to kselftest framework
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7dd4b9ab6e43268846e250878ebf25ae6d3d01ce.1733994134.git.geert+renesas@glider.be>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <7dd4b9ab6e43268846e250878ebf25ae6d3d01ce.1733994134.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 02:02, Geert Uytterhoeven wrote:
> When adapting the test to the kselftest framework, a few printf() calls
> indicating test progress were not updated.
> 
> Fix this by replacing these printf() calls by ksft_print_msg() calls.
> 
> Fixes: ce7d101750ff8450 ("selftests: timers: clocksource-switch: adapt to kselftest framework")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> v2:
>    - Add Reviewed-by.
> 
> When just running the test, the output looks like:
> 
>      # Validating clocksource arch_sys_counter
>      TAP version 13
>      1..12
>      ok 1 CLOCK_REALTIME
>      ...
>      # Validating clocksource ffca0000.timer
>      TAP version 13
>      1..12
>      ok 1 CLOCK_REALTIME
>      ...
> 
> When redirecting the test output to a file, the progress prints are not
> interspersed with the test output, but collated at the end:
> 
>      TAP version 13
>      1..12
>      ok 1 CLOCK_REALTIME
>      ...
>      TAP version 13
>      1..12
>      ok 1 CLOCK_REALTIME
>      ...
>      # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:6 error:0
>      # Validating clocksource arch_sys_counter
>      # Validating clocksource ffca0000.timer
>      ...
> 
> This makes it hard to match the test results with the timer under test.
> Is there a way to fix this?  The test does use fork().
> 
> Thanks!
> ---
>   tools/testing/selftests/timers/clocksource-switch.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
> index c5264594064c8516..83faa4e354e389c2 100644
> --- a/tools/testing/selftests/timers/clocksource-switch.c
> +++ b/tools/testing/selftests/timers/clocksource-switch.c
> @@ -156,8 +156,8 @@ int main(int argc, char **argv)
>   	/* Check everything is sane before we start switching asynchronously */
>   	if (do_sanity_check) {
>   		for (i = 0; i < count; i++) {
> -			printf("Validating clocksource %s\n",
> -				clocksource_list[i]);
> +			ksft_print_msg("Validating clocksource %s\n",
> +					clocksource_list[i]);
>   			if (change_clocksource(clocksource_list[i])) {
>   				status = -1;
>   				goto out;
> @@ -169,7 +169,7 @@ int main(int argc, char **argv)
>   		}
>   	}
>   
> -	printf("Running Asynchronous Switching Tests...\n");
> +	ksft_print_msg("Running Asynchronous Switching Tests...\n");
>   	pid = fork();
>   	if (!pid)
>   		return run_tests(runtime);

Applied to linux-kselftest next for Linux 6.14-rc1.

thanks,
-- Shuah

