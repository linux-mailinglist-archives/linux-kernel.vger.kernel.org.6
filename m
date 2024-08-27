Return-Path: <linux-kernel+bounces-303221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C75960933
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E207C281968
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5C11A01B6;
	Tue, 27 Aug 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GqTMBOhi"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2A14D29C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759093; cv=none; b=RgAPSipTsJMnM8/IUl9tgVbYs+tsCkWoUwRgWP26XuupNqivWJ5zuhGW97iv3sSCxwQZIWugnGXquinTrL+fQdILEAzdu8MDkA+gQ0kSJyE+7ByK+AJOIem2TOc3nfI7EsKNiquVILnQ6NUAiU+bQ3cYBfB2aH1m9qTLB9IXvRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759093; c=relaxed/simple;
	bh=n7Xj5++MWNgSYnIAidpGGlpS/TZdD1vc2hWY2mJoXP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+zS9fzdnCLWLSCSLsKSomB3JAITrbXH2N+tM356FiCANv7M2kVZPSTj+X1Qa5kKkKDjEUtyBWBSw4Y1dr/v8YLgoIPe0sqfAE0Bdx6P+uzSijO6vpbl6YfLCptUU6iGOjhHeoLMgiYneFrvuaAFV2YJ9KJyPnyahZ468Xqk50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GqTMBOhi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-714187df604so3676916b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724759091; x=1725363891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7Xj5++MWNgSYnIAidpGGlpS/TZdD1vc2hWY2mJoXP8=;
        b=GqTMBOhi8gUCi07XDvVyq1t+Sb5fw1QQoG3qM0kNhN5utOF2E0Lbw4p2MqSRXfEUL6
         21en988PmLP4Uud8sEWwN+s2bYXMRJYVJCmBpzRB5qsM7reyKWf0uf0kIqPIMG0jUbeX
         De8ooSSxljSGXFVb7NDA4D5k4IQacA9vIOPus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724759091; x=1725363891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7Xj5++MWNgSYnIAidpGGlpS/TZdD1vc2hWY2mJoXP8=;
        b=Oyu2Td7lfBQfovHO4MDAByeuMq6uE7S1sy2ZNZCuSHlSl8OTsKKMk92Z2IZOakFKmp
         9LbZbkwVUECSP6+ad52yfKwcavSTG1MyX2aPF+h3Th8jpuOS4lKBaw6niDdSRaLBOLDZ
         E22lspfAB71XFkxvkMCyRiAUlOEyXdwwfxSkswCVqQJR14y6dPuDCOlFvIc0be2TFPc7
         a7VkJnQ1CrqfahqpLft1SjinuX2HZC0wMCtKMlmSJo0fR3GUxUiwtaoGuEi6YgGnK7wO
         +nbGjO+sJLU//vLmiwOoUCevUpUoEp92uv3+tH1jVNqKEueNIYz0rdWPttGsul8ZE7n+
         biSw==
X-Forwarded-Encrypted: i=1; AJvYcCUqxlnQ66pW843PNXMwRiUaFXAEz9EAHQ++EBcESMVg8IM0+ZqceNPQwRGPKMGYBbx88CktnYJ99cuwl7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10ctET4wp6GBkil8N0URicPXp4JiKMQlwrhDpHsYAZmP2xWg3
	EKhvs5Ka/HFuqMppgMbpz1Kr0aNAiT1dfGgNI98kFsKRhaNl2XLZwz2A6OYfzQ8=
X-Google-Smtp-Source: AGHT+IFGHgObn0rmwkspma77Vaiafu7mw8ExvIVCJJsO624LuRH1IwRUh1C2LjsM+sDvPaBol7yS/w==
X-Received: by 2002:a05:6a21:7795:b0:1c4:91f2:936a with SMTP id adf61e73a8af0-1ccc01fca1cmr3414259637.5.1724759091336;
        Tue, 27 Aug 2024 04:44:51 -0700 (PDT)
Received: from [192.168.121.153] ([218.49.71.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac98286sm7933489a12.5.2024.08.27.04.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 04:44:50 -0700 (PDT)
Message-ID: <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
Date: Tue, 27 Aug 2024 05:44:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240822121415.3589190-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 06:14, Dev Jain wrote:
> Rename sigaltstack to generic signal directory, to allow adding more
> signal tests in the future.

Sorry - I think I mentioned I don't like this test renamed. Why are you sending
this rename still included in the patch series?

thanks,
-- Shuah

