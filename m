Return-Path: <linux-kernel+bounces-262417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE5393C6D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F7A1C21D10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A919D89E;
	Thu, 25 Jul 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fi6Adv0j"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142EB19B3E4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922645; cv=none; b=TOzBTygFIsu51/c5YVdLR50Xz9HNfQCJJQQkFVwm+RAhSu/JtVAa2IRB8RplvuiZ2bgpxixDSoClxiQOwx4nOjBq+dU0ntRYdMdL6Q731TPzStwAOSRqdiSgswPqNi2NzMIeYctnnhyNkI0peNv6cQqW12tJ9Z0pdagoZvI+YUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922645; c=relaxed/simple;
	bh=6m3+FHyJ+AmEj6vS4AHygVqkSGsQfYiClcdMM+4uSyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcFhDE/fASEz8l3gqOP83Mx6TeJnR/EvneAhC98qWXi6brE8Kurh02x4GLS8vp+cBjZvbTuoqJy3ZBtoO1vwSVbrA9tbR0aukXXHFHN+75tFlNhtPJpPR85s7Hhw7HbjtGxFda2JR1mq9nmTgzcyKQ9iqhWZkrKDEKXm1Zqvq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fi6Adv0j; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-805fc096a34so2086439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721922642; x=1722527442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aggvme3xKg7i4TrOmjlKCfE2kTRYsrbbuWQJNB9R3qE=;
        b=fi6Adv0j4YkmnIp1EwDxq4rYgTiWkMrxjWtLDifUIAzv2yuDE81xAyZ0YAWtibzcli
         oEjVzB3bMMYMcrBK/9ucZAenHI4+vl7RefU+GJ3nyXeah+akFGuOTGm88mgwZ3YtwyNt
         tfUl/pC89H+FaRYfQAFCG4l9o0vCZJmUrq9Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721922642; x=1722527442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aggvme3xKg7i4TrOmjlKCfE2kTRYsrbbuWQJNB9R3qE=;
        b=W7TCvPVuvWDn1/2LUPgAxcanxJXTn2dBR2W44O7kianIrAEt9Xp6f9i5CJIhrl7ibD
         UWo4MeCO6uRgNji9Kapp5mq1iua8fDggWb5yBIqNg26e69vAori7qp1KQqYCFPxz3I58
         A/pEVxNClICIvTMyq5L/R06mya+EK5UQCfuLGvKDqeFj7O1QDyRi0bntYpXUJMvzx64U
         bnedtIrDdJpjOave/oNa0xS/cShP0E0Rvb2FMum7cTqIdhk5C8dyiZXKRFcrGTaYtsbB
         pYMCJPOxr0rYGKcrIRQfp8eiv+cIHs8obVuTqqeVdR0fGoZaGbeCRhRpC53kFUNe9JLb
         uwww==
X-Gm-Message-State: AOJu0YyaHF8wN7J2GbNy/ZeUiaDjaiNB+YPsXeQ+zZgnpEg4GsDLJZYk
	6T2Ed/lUKahaF1qdzGU8lYKE/AFPHv7EqrOcK3w/DX96Fp2NZSCFZ3V2SRvFsb4=
X-Google-Smtp-Source: AGHT+IFEHsFN0I8fUwEQhH9FG5DtAKwnOj8OaKgLxrdAaSfCNz0gvGEdpltGEFJdn8E7GWzFxI4Qyw==
X-Received: by 2002:a6b:e810:0:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-81f7d016818mr216157639f.2.1721922642214;
        Thu, 25 Jul 2024 08:50:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fbd9b8asm382241173.108.2024.07.25.08.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:50:41 -0700 (PDT)
Message-ID: <65c59f75-3810-4490-991e-62b5aafe1f5a@linuxfoundation.org>
Date: Thu, 25 Jul 2024 09:50:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] kselftests: Add test to detect boot event
 slowdowns
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel@collabora.com, kernelci@lists.linux.dev, tim.bird@sony.com,
 mhiramat@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110622.96301-1-laura.nao@collabora.com>
 <20240725110622.96301-2-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725110622.96301-2-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 05:06, Laura Nao wrote:
> Introduce a new kselftest to identify slowdowns in key boot events.
> The test uses ftrace to track timings for specific boot events.
> The kprobe_timestamps_to_yaml.py script can be run once to generate a
> YAML file with the initial reference timestamps for these events.
> The test_boot_time.py script can then be run on subsequent boots to
> compare current timings against the reference values and check for
> significant slowdowns over time.
> The test ships with a bootconfig file for ftrace setup and a config
> fragment for the necessary kernel configurations.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

I am repeating the same comments I made on the cover letter here as
well.

What are the dependencies if any for this new test to work?
Please do remember that tests in default run needs to have
minimal dependencies so they can run on systems that have
minimal support.

As mentioned earlier take a look at the tools/power/pm-graph
bootgraph.py and sleepgraph.py to see if you can leverage
them - bootgraph detects slowdowns during boot.

We don't want to add duplicate scripts if the other one
serves the needs. Those can be moved to selftests if it
make sense.

I will review this once we figure out if bootgraph serves
the needs and I understand the dependencies for this test
to work.

thanks,
-- Shuah




