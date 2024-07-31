Return-Path: <linux-kernel+bounces-269632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C002094351F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C46FB22AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4BE381A4;
	Wed, 31 Jul 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LdVO2YAl"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737EE18AE4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447932; cv=none; b=Goc3bJOORvE3fn5thCbChsXSGMRtWOEX0WQ8JcB6/Q49O0NO4+SGsZmu9B9FLzDWFGwJwxxSM1GIyPB+diCpECKXhggH2QeXxMHcPYqiouC2mE5mzkYCmIQyS+yEHtg8x+AZ9ONIvjee2JLN5DE5z1+zWtZbP22gZZrZ1ypx7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447932; c=relaxed/simple;
	bh=uu38UeVuWeQxn11k7eYvpVyA4qCCVtoxEkbcIXDmeBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0QIrG/q49kSGRDmzFABF0NqpnluiVHI7UPxJQaGF8oAXa6wVRVa/ANvf4XhXU2WlTQ5k6QF5HjRgBkPVpNO/Hibo5MDvJ1dkespLNa3Q74aqPbHmc9YHmgUr6fSMNuaXiaDoEbLeIrHj7D4WDZJehI+Dez1Cw3vhwXG/z0cb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LdVO2YAl; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-396d327b05cso1583465ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722447929; x=1723052729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKjIl2NyA76Ap6Ri9WultJJTbl2LafKjHjLFOLlGol8=;
        b=LdVO2YAl29z4LwHoEBTg6oZ7mQzFXvvf51+pScKXSseJUV3Ulu5m/N/CkeCb0KBw+S
         LktBPQWVJ79DCWyZMqTaMmY4OttYkDLz3dr+4TxiSY6W/LU8M2IHNAQCLxRuC5ABIvNH
         roa6uoxUET35H1xX1gefejb7zRrdGctrnKGwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722447929; x=1723052729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKjIl2NyA76Ap6Ri9WultJJTbl2LafKjHjLFOLlGol8=;
        b=opU/3qcNogdjSH64b/l8hOG8OFL+ESD1EbUBV05z1fLJIM+i00pSZA19pYQ3Agy6Yz
         EHWdTT7KdCRgKsiMLHokJp+AfKJ+YIsCVZ228FysIVsfaG1BOLAYSdxXXCbS421O++xd
         tKYKEZmslq0BMMIemJ01uDFK4iWckesaESZNbGf4hXBEJk46ktpmbSXL3k+/MuVt/oQh
         KyMZMI3Gl9uJdtENFHSVo7KCvcxLKsd5kZyiLvaP9hs0AwJI+GMyMO4x7xn2oAGcQ2tY
         CZXy6LLh9Uk0pzVsqZgdYVk37VpqJW1Vtneo3+LC+ZJ9JMtYayUOkkxx3ZbWBzCUuOSq
         N/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXj+UFn7baFHitN+vHkUYu5SnqrgReZAG4KKPdbow/MlbEH+TTTUMcn4bF1tbyt0XeZtwIYsXa3g0H1+vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IKv5vpQqkHwp26oweTF3OjllIZ5nDxgGAwFQp/3ixUYYSg1W
	PL6KiUA0j0YQiyhCQJL5HUPs101CuASN4YR/UaUTS4csf4DzZ4WJSLoMQTmPNgU=
X-Google-Smtp-Source: AGHT+IF9D8RaHtGbstnwGffEywKhxqDSCv45KeTpLutSLyuGo1KAlqXKjX7Uav0Wx6LiAnsE9rw57A==
X-Received: by 2002:a05:6602:1ccb:b0:81f:bf02:fd0a with SMTP id ca18e2360f4ac-81fbf0301ccmr348720239f.3.1722447929592;
        Wed, 31 Jul 2024 10:45:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc66b83sm3274393173.179.2024.07.31.10.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 10:45:29 -0700 (PDT)
Message-ID: <8696338c-fcd7-4c0f-87ec-9303c9c1ce88@linuxfoundation.org>
Date: Wed, 31 Jul 2024 11:45:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tpm2: redirect python unittest logs to stdout
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240710081539.1741132-1-usama.anjum@collabora.com>
 <47ea7423-3aae-4bb3-a41f-1fcb5c07e74b@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <47ea7423-3aae-4bb3-a41f-1fcb5c07e74b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 07:42, Muhammad Usama Anjum wrote:
> Reminder
> 

top post???

> On 7/10/24 1:15 PM, Muhammad Usama Anjum wrote:
>> The python unittest module writes all its output to stderr, even when
>> the run is clean. Redirect its output logs to stdout.
>>
>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   tools/testing/selftests/tpm2/test_async.sh | 2 +-
>>   tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
>>   tools/testing/selftests/tpm2/test_space.sh | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>

Applied to linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah


