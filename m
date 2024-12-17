Return-Path: <linux-kernel+bounces-449627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F99F51B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F35F1881FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE91F757B;
	Tue, 17 Dec 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjpPef0l"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A91F707D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455297; cv=none; b=l2h82PDktAnDlywJ4hzihlrz/9xQzzdqjlF5kfuiPwKgrF+x8sXGxCDT54nwR9l/eXFkroIw629KJvAECiZCQc8n26lBYjp39W2O2KW247by5+hgHWLhRkgOiJcM+E36nrwFVCpWpBEE33XoOX8SOfb9BWwTgNCyzyGawyqWwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455297; c=relaxed/simple;
	bh=S6v7WSivSjBUez5PTCTh16YSRYv6qadD4q7B0AooY9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAkrWy1V/mRbaYQR25hH8QjNDCMY+RYDEyluIrLstff9cTOkDwkWWXwcDahBgWoMmkSR5tpgJ7P5j6afG0s/a02AygwoUwWpOjJiqiULKugILYwGq64QpC7d5k9WnONe87vp+XdOXoUZZ05RzESgvgGyGcTB4JZSJpM4oL5xaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjpPef0l; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a8146a8ddaso17352135ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734455294; x=1735060094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKFj36ds5zWF4MA+dLgI3GSVqGF0UVLm3yTW7/ZJ33o=;
        b=hjpPef0l8a6iq+p/fsxYmAGVhhQkd7+kmCfkv5WliePBYtK8cxo2S5lMrC5WANqpj+
         wQHTPxqj/hmml/q6iN4/ZoQHFbEWcKeKUkf7e8o3/2Y0JDTM/aYg7dOG9ek/Tq9fqPY8
         FXLvU7I09BsSY7np4GSHmS2P1Nhd0+mSlk1w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455294; x=1735060094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKFj36ds5zWF4MA+dLgI3GSVqGF0UVLm3yTW7/ZJ33o=;
        b=TkZIvVSS5RNisoEi4Bxd0f/HW82mtoEKUmd4rRkVfX/J5zFnPniB19c9JKFoPCbfLa
         FM5voCps7xaTqIJHHeB7b6On1K41NH44vrhDvWjlU6DuXLO+b5KKHc2opciIiiKIppjj
         AYjH2GrA3Xyh/Pk5A2kmxjtzo1V3bUp7YDCQo+8pStv8WcOfwzACdFBCTZ1jXrbrhO17
         m71wjxfDP1NTDk8V+gCFJ7vjOWUQvNTgU5qdPTLI7XntTMa2vq+Bg/XHBC6B4+aIIU9O
         82rccltfzksUu96rzCUUnxAp5GLJl4PfrB+hLXhTJH2zS2ES8lDVA+vCR0qyn+YvOEh7
         kx1w==
X-Forwarded-Encrypted: i=1; AJvYcCX8FM4hpaMtf6nuKQEk29s+9DH8BGVIEYejUjyGzKrGStYVAyhv8BNTZ/GZ5JfJz9kPcPdxG6XpksHdbwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQPXWd+xc7yj0FDkPyIwML8kkCc4aZ7GcA+BnC4O/M4YaMV9+
	FJavCGepCgXrmy1uvYP2r7sH3es9XawULj5k/ZyPh6IAFttvCbD1PsMZugmMYgk=
X-Gm-Gg: ASbGnctjAesxLaIbz7u4bxtcgGnEt3YdrkAzDDXJZZIbmnAXMHysdh0e514oKdE5m1Y
	/1XwBEx3KbvygzGg9WrcEQ8YePfQGO5gu5DggqzZdToRYRWmQcmMOJ/ogmOVufNCDpzI941yazI
	XpbmCPyi29HFKjN3CzVtiG/VOCM6EFzaQ/UUoUqAa5qlP9ENGf3AKi5UrHsKRI0i8lsXVUNkvSQ
	r3BC6Pm60A8wcZsu8RZPIAXftPW1HfxPcLMnwYpRBo54RHZF03uBalLBCnOQISfWFOw
X-Google-Smtp-Source: AGHT+IHBZO4CyjBa0QSKmLGcO5i/oNBDAGxpfIe8iEXVZ5M5jCAf2CDCco9lHuxZFTxebBDMOz4lDg==
X-Received: by 2002:a05:6e02:1c86:b0:3a7:8270:3e69 with SMTP id e9e14a558f8ab-3aff7f1864dmr159436775ab.15.1734455292884;
        Tue, 17 Dec 2024 09:08:12 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b24d9d2d5bsm21905325ab.73.2024.12.17.09.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:08:12 -0800 (PST)
Message-ID: <a498d632-3ca3-4658-8300-59d2110274f2@linuxfoundation.org>
Date: Tue, 17 Dec 2024 10:08:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: acct: Add ksft_exit_skip if not running as
 root
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org,
 abdulrasaqolawani@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210123212.332050-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241210123212.332050-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 05:32, Shivam Chaudhary wrote:
> If the selftest is not running as root, it should skip not
> fail and give an appropriate warning to the user. This patch adds
> ksft_exit_skip() if the test is not running as root.
> 
> Logs:
> 
> Before change:
> 
> TAP version 13
> 1..1
> ok 1 # SKIP This test needs root to run!
> 
> After change:
> 
> TAP version 13
> 1..1
> ok 2 # SKIP This test needs root to run!
> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
> 
> v1->v2 : Replace ksft_exit_fail_msg -> ksft_exit_skip
> v1 : https://lore.kernel.org/all/20241115191721.621381-1-cvam0000@gmail.com/
> 
>   tools/testing/selftests/acct/acct_syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
> index e44e8fe1f4a3..87c044fb9293 100644
> --- a/tools/testing/selftests/acct/acct_syscall.c
> +++ b/tools/testing/selftests/acct/acct_syscall.c
> @@ -24,7 +24,7 @@ int main(void)
>   
>   	// Check if test is run a root
>   	if (geteuid()) {
> -		ksft_test_result_skip("This test needs root to run!\n");
> +		ksft_exit_skip("This test needs root to run!\n");
>   		return 1;
>   	}
>   

Applied to linux-kselftest next for Linux 6.14-rc1

thanks,
-- Shuah

