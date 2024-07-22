Return-Path: <linux-kernel+bounces-259265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA293933C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429F2B21287
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFE16EB6F;
	Mon, 22 Jul 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2iDSwe9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95816D318
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669559; cv=none; b=KD9v4QAremiUalmatnyyBtR0SM/9HAgHX5BxPPMHDwkrPtdCB0BwqQace2h/c2DcmeK7UZp0HDRy2eOo0y/qOQtTyk1oe9TPiFmpVTkKmM/Xxtq1uHm7VntZnxwOhuNpETg/Qan7C0H3ujX3/NGOowngb1RRRGaSG/Y7lz0XrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669559; c=relaxed/simple;
	bh=YCbBVPoRujTuH/IzgyukSKeM2NatIxPQihrHU3dth28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnMNMwH5E2CK2OOLtZYOa0GgQOcuFt4BC74TzrZ1+6UDmnuk3kXVFz4amYDsLja+E+0HSXbSxgfv4R/j6TAHeL2hl8U+mOFfPuEVvp+wyr6xG6/RRJ7Y6MYG7sn1NxG6DLkgwQUpsevpMQuSc3+o4VtbqvM24uElmKxcH92dK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2iDSwe9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc57d0f15aso13005ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721669557; x=1722274357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKLoLrXld5zXnC2TPTdAAWRPh8tguM0xPjqljzcPI8c=;
        b=G2iDSwe9G1ARXc/lWQbtNNMp+65WCD0mucZy7aQchBd2cmic6wS5YXLs2wfdKxivHn
         ybtHuWWHOT2rIcoC62gwjJ8fY1oGFrDOK1Rc9Q4XKlFHOYDNa+ebMMgoWsKN64wcRlxn
         9K1srYrs4Ep7RR0ODvtUUV9d/acQ4orhwOzPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721669557; x=1722274357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKLoLrXld5zXnC2TPTdAAWRPh8tguM0xPjqljzcPI8c=;
        b=vgv8kSRKXGEm4Dy4ZBzvB6zIrN+d5Xhh8mYh9FHZYpJZKvMjn2ZKUrv9n38RIfekQL
         +sSDw8e0qCzuaISbnv/JOs3rs7O58K6kp658JVcvgIvUutWTHkZOXKVB/yF6IpDuxudN
         n9ko2gMzpQpjc0ft1/ZA9eos+gG/w0CGyRVQT7JAFovuWqvpOB7llDYD4r1GbMRY9F4M
         d2E9qMZOi3XeBIRNLChIGi05XKDI75hPI40dEGkl4epTwgcFQIe6CeiK0wH2MTvJtEen
         1FNaX+ng/rRMNIfL7OqqkfcfRiLBhXReoQvZgb9dqx/arfsWLLyGbY1KSI7ZQ+dWq7OF
         SpKw==
X-Forwarded-Encrypted: i=1; AJvYcCXDYA/yxotr3kprmrKceL49Qy4u+2KXgRjmn36r/CMEcemoDt7Sy1IL56UzkpG3VsM7f2fwuvOacsKUml9r4E6NfZ99gawBfQ9+UC8D
X-Gm-Message-State: AOJu0Yzjc7GWgHWooKPjv5c1Nv4fGaNKL/pT/GTYjbUCTxo69vnnXqWf
	ZIMatBeGxxHBNETCE9lsDyBIGNkPfhIRjir7kg/c/XZcUu7JT2sNVBgCRGtRPoY=
X-Google-Smtp-Source: AGHT+IECCFv46PbolkfKo+kIFuV5CZ3MQLZEEljYyHDsZgCM/hHd4/Oq4TnhT5ElcnZlWhyLVoS2WQ==
X-Received: by 2002:a17:902:f691:b0:1fd:a0b9:2be6 with SMTP id d9443c01a7336-1fda0b93152mr24604135ad.2.1721669557153;
        Mon, 22 Jul 2024 10:32:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f4530cbsm57316135ad.221.2024.07.22.10.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 10:32:36 -0700 (PDT)
Message-ID: <0fe1b57e-4557-4020-878a-7eec13a2fdb1@linuxfoundation.org>
Date: Mon, 22 Jul 2024 11:32:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the
 test suite
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: gregkh@linuxfoundation.org, nfraprado@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240722154319.619944-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240722154319.619944-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/24 09:43, Laura Nao wrote:
> Consider skipped tests in addition to passed tests when evaluating the
> overall result of the test suite in the finished() helper.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   tools/testing/selftests/kselftest/ksft.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
> index cd89fb2bc10e..bf215790a89d 100644
> --- a/tools/testing/selftests/kselftest/ksft.py
> +++ b/tools/testing/selftests/kselftest/ksft.py
> @@ -70,7 +70,7 @@ def test_result(condition, description=""):
>   
>   
>   def finished():
> -    if ksft_cnt["pass"] == ksft_num_tests:
> +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:

Please don't. Counting skips in pass or fail isn't accurate
reporting. skips need to be reported as skips.

thanks,
-- Shuah

