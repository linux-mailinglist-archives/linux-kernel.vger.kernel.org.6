Return-Path: <linux-kernel+bounces-269636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8641943527
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167F51C21649
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2671738FA6;
	Wed, 31 Jul 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QFYJJGWO"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF051BDCF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722448075; cv=none; b=Fj3NNMZ7RhrrgFRz78LiK/N5+2Dvg7x+gjoakbAMYi8LoEoywBHX3rCcYV3+gZpYbOAGx2J1bsC+S7hPwuYkpmPDBy8wziPP0bw3F2GgzFOuF79GNtQstUte6vqSVhIe8qg5xS9sfnCgck8rk67cLZORs+d0BERVKkdZEefpXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722448075; c=relaxed/simple;
	bh=6jAUuW7/ivNq+Elvq+AsbUz2cQ7h+vFt+C9fBmkMu1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7aBT7tSWdxvJCWoxnC73ZBRdxs70wOYvKJP4I0ptn8cUJbiFK37f5emb8ojFD7ASI6k8lL1nlVzLzUrUc61xm8/CjBqJCAsTVFfStnWdW36xrPtKuGiSr/bTQ7RnuB11jMHsaVsYN17L5uvXskdhPRhumjeBcwV+4nZc9OPQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QFYJJGWO; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8075313cc7aso33562339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722448073; x=1723052873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89oZyEHSOTKQRd9fOydMJ2/AkOE+4xTOTMGuEKoBp3k=;
        b=QFYJJGWOhD8sMtSKnPz2iG8qgnWbyJ/SQb/kQjdBaPxrHE/D96SRs8TNNv44EOBDTh
         eFzPOTltoo15r7qovNSHTpSBf1/FSeRt8ZjAjclFketqMTFyhOt6YkLIbGYz+s7GlEuV
         imqtGJHguuOkLADieVI2l8tEYBiffyEhv4kFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722448073; x=1723052873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89oZyEHSOTKQRd9fOydMJ2/AkOE+4xTOTMGuEKoBp3k=;
        b=Ub2SXEbfti4ZHe2j1+1/1uoqoGI/bum/TMPGnJ/BcNlrTSqJmhQy1NYnQ9fMXMq/nI
         inygKHrRRMDI5uj6v7GBgHYoZmRqVzfSwnHTU5l8zSn3+hpGeVt/j7+LoJ9kwQbqrIk/
         fyAsw3rPsxEkaWPIdW1giB4MaIj6uKdJpGzOD1E6wHExSvQiyZs8FqxOhe9aaKoW/7SI
         zZqK6rP4YMdGrjoXplfAzPJcCTHUCHBKLOJ5D5QnaePHtlR5VHVW3u8co7zXtAcn7E6i
         QFoQlvh9l4tYREjyMs0dZozwKrpYb8MNiQb4dQWYU6Ir3hdWy4P+sweyKUABBZQ3NiGy
         1Q4A==
X-Forwarded-Encrypted: i=1; AJvYcCUzWYPH+1oElDwzrHToGsSAFGjDzd6XVaUHPE3gKuuWR1mlIqoQiRATpcNZ3sj6s71c23X0wKecPBr4eBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7ffxYgnkiV6zOGD6mW8hJQZx594CTIMkTfNknwL87LR4UAuU
	hnBOIQ5O+aehWigZvMrJjg279WUyWBAGL8tGVRJlNGSNJsDucShbeIQIdxVpmUw=
X-Google-Smtp-Source: AGHT+IEhJu3l0EIAj6YjUUurkN2Co+0z9S6OdQ7KpdRzQff+24Fw5qN8NoTOnlbNR3NsSWXea1YNyg==
X-Received: by 2002:a05:6602:586:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-81fcc17995bmr1839239f.3.1722448073025;
        Wed, 31 Jul 2024 10:47:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa40509sm3268043173.7.2024.07.31.10.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 10:47:52 -0700 (PDT)
Message-ID: <2a62bb4c-f701-482c-b83d-ec3e489b0f7e@linuxfoundation.org>
Date: Wed, 31 Jul 2024 11:47:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: ksft: Fix finished() helper exit code on
 skipped tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: gregkh@linuxfoundation.org, nfraprado@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240730102928.33182-1-laura.nao@collabora.com>
 <ffea6ae8-a5e3-47f9-8d01-efe5e58ab2c8@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ffea6ae8-a5e3-47f9-8d01-efe5e58ab2c8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/31/24 07:05, Muhammad Usama Anjum wrote:
> On 7/30/24 3:29 PM, Laura Nao wrote:
>> The Python finished() helper currently exits with KSFT_FAIL when there
>> are only passed and skipped tests. Fix the logic to exit with KSFT_PASS
>> instead, making it consistent with its C and bash counterparts
>> (ksft_finished() and ktap_finished() respectively).
>>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from discoverable buses")
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
>> ---
>> This is a revised version of the patch initially submitted as "[PATCH]
>> selftests: ksft: Track skipped tests when finishing the test suite":
>> https://lore.kernel.org/all/20240722154319.619944-1-laura.nao@collabora.com/
>>
>> Depends on "[PATCH v2 2/3] kselftest: Move ksft helper module to common
>> directory":
>> https://lore.kernel.org/all/20240705-dev-err-log-selftest-v2-2-163b9cd7b3c1@collabora.com/
>> (picked through the usb tree, queued for 6.11-rc1)
>>
>> Changes in v2:
>> - Reworded the commit title and message to more accurately describe the
>> incorrect behavior of the finished() helper addressed by the patch.

Thank you - Applied to linux-kselftest fixes for Linux 6.11-rc2

thanks,
-- Shuah

