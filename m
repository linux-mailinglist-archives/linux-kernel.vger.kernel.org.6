Return-Path: <linux-kernel+bounces-210575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF769045BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35619B21907
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6201514D8;
	Tue, 11 Jun 2024 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KXdwrwqc"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E514F9F7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137677; cv=none; b=mSi0tUenvpDIBfOpueajASw+KhotvzgFc9hCipuajTOhEieVnBpTyJrdai6CaP4WSwrw3lEB7T035oeJKVTZaLnJo0RgXKL1Zb9GR2PD3any/uwllu9JIR5cFN6JdOhDzJEvh4Oibgq3Nvq1+dRBfLs+V9L4wCxYoXv3vR6AXyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137677; c=relaxed/simple;
	bh=ugUCm9Yr68u8EX9EKbsRWgLfIOOy1JUUSq6pq9fS/gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJ6dXj38P5Q0mNSNG6F8YYzUk7i2YfIdgwTvlbmdd1ab+JeEcu7ExZpoQ3030+0zWYXldESm+4ggnDvbE+0ddDWo/AmXVjg0XR2jCpWzKwfTPSmTx6TeopQPqrTXUTR7R0IKPeo9kaUWJjVbT+86IOPe1n9pqhLGQn/K79rLm3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KXdwrwqc; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfb16f9b047so359887276.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718137674; x=1718742474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=th6eKAq/LATBnFfZ8l1OQ1G8HtkktsMhv2cX9FNr94k=;
        b=KXdwrwqcCk5M6iChGThNz+ZKUxbkCpNfhpt17o6xLSYtIVnfdMW0SmceNSwOmSeFI1
         a1F48Q1Rqa6qvDfCyeJ4oLySMBN5LyIaRs5B5jsIQF3SYuU636z5E5tMUIBXuTW/c9oG
         pA/jpipkotPZcy5RcG3cOukp//cCtHuzaiFEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718137674; x=1718742474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=th6eKAq/LATBnFfZ8l1OQ1G8HtkktsMhv2cX9FNr94k=;
        b=rLIyqUtEmoDGzrc+KhqoMBiVp20ntVH9f8WYr2Vm7g3eQm/saUL/wPyYHm7ZCQDAJy
         D3dESgsZg90wo9Ui6T1CP69ekKNh5XBQG/jeYQJw5RUPoJEUr/ADfZcki/WKIFcqeNzm
         34HaBRGCb8opd9DZnSoicKgU0sj+kHZxVJzrD8gPBF52IAk2N6h/SuiQtj0M6B8FTdEK
         UGyAcdHCH+HBY5AXWYu+GfPGmlFSxuKmih5DTmMflXFPad4ryYFAYJ+fmTgF9pWeRnck
         T9UAhPPc0souWA5dsvJX0nTCwlIRh2vmu7ko2L3cRjunDXx/dHz0x4lyumzDdr6lS5kf
         S0mw==
X-Forwarded-Encrypted: i=1; AJvYcCXYmBihi+GEHYMrXCuHS/ObEsc81Jwco6vxBSScPTOc+gE9porBaDhkKC+PRvXw6G+NFjjWED3wsRpLpX7zp8m6UVZSm85rz3iFwinh
X-Gm-Message-State: AOJu0YykfQqh/AjGweA3eTEzoeF3+4KkkZ93eYD3Rya1e63cUb5NKxMl
	KS+v8aJFVclz6GXX3XhyIEE1gqxuj4lmyNyA29E7x8EmDPLNE9AhKdxl/XYIqR0=
X-Google-Smtp-Source: AGHT+IGTW02Hlw4hL7bwC4c8R5pzfb1VoGT9mdqeIkhRdG7AQbO2+vTAHG0mI8vT422bk0QHPx7l6w==
X-Received: by 2002:a05:6902:b27:b0:dfa:6f65:f068 with SMTP id 3f1490d57ef6-dfaf64befe7mr10269563276.2.1718137673572;
        Tue, 11 Jun 2024 13:27:53 -0700 (PDT)
Received: from [172.20.14.19] (ool-6c3a3e1d.static.optonline.net. [108.58.62.29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06cd275b7sm38092216d6.62.2024.06.11.13.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:27:53 -0700 (PDT)
Message-ID: <1f46ef8d-2435-4c73-88b0-f954d685d1a9@linuxfoundation.org>
Date: Tue, 11 Jun 2024 14:27:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Add information about TAP conformance in tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240610083245.1938001-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240610083245.1938001-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 02:32, Muhammad Usama Anjum wrote:
> Although "TAP" word is being used already in documentation, but it hasn't
> been defined in informative way for developers that how to write TAP
> conformant tests and what are the benefits. Write a short brief about it.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   Documentation/dev-tools/kselftest.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index dcf634e411bd9..b579f491f3e97 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -228,6 +228,14 @@ In general, the rules for selftests are
>    * Don't cause the top-level "make run_tests" to fail if your feature is
>      unconfigured.
>   
> + * The output of tests must conform to the TAP standard to ensure high
> +   testing quality and to capture failures/errors with specific details.
> +   The kselftest.h and kselftest_harness.h headers provide wrappers for
> +   outputting test results such as pass, fail, or skip etc. These wrappers
> +   should be used instead of reinventing the wheel or using raw printf and

When there are multiple tests supported by a test suite, it doesn't
make sense to convert every single print statement. That is the reason
why we have the run_tests wrapper that prints the summary in TAP format.

I would rephrase this to say "should be used for pass, fail, exit, and
skip messages".

This rule is applicable to only the tests that are in the selftests Makefile
and included in the default run.

There is no need to convert every single print statement in tests.

> +   exit statements. CI systems can easily parse TAP output messages to
> +   detect test failures.

I would rather see people spending energy writing new tests and fixing
warnings. TAP conversions need to be focused if they add value.

thanks,
-- Shuah

