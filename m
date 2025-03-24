Return-Path: <linux-kernel+bounces-573363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35231A6D64B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07B7188CF5F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A325D539;
	Mon, 24 Mar 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oPyNA8TW"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253C200CB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805453; cv=none; b=dtM8AfGkW2VDXusqX0gJi28hG1zKN4y9rVGRIbMiMXvZ5BJB8/36FgQyMuDxqLTTy/WNcs1iAD4ECp7y0trTYFTxDN+TITKqCR11iDhTag58E7NGgSeHsIJw4SO0iMuTGPwO5AUTC/dyQGsZNuiB+3op1wZJTi+UTY2wYAXV18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805453; c=relaxed/simple;
	bh=x7M8kfO9ZWk0O+/183B2qw+TXk5OXy89eMjQrV+Shxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIGhdzA+H/T6iV1rapHyWTk886CeySUFgoXTwHIeaIoKGlRYupchFTq1ZPpvfBlsUor3Ini6PPLdSxvKx+lI048VWDT2i6frfjOf6vbJ3vTiaKAJcsS8xVkmIuOEE1tSOlKGRR4XhSvjwcHkIazjSQocEpWInmZuffNc/l5rcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oPyNA8TW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22435603572so69652015ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742805449; x=1743410249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2s6YbLy4nW+jYW+2j4zgOCotGnhPTE4p9OSJFGAI4n8=;
        b=oPyNA8TWKv6xm6QyLf3mPW4Mxt1v/RPJkmw2/tmVb7N2R06hjGGe2EppOnZyYCXfhT
         U1hbNkT2wUBkLhsl9TEsauXfycQlY2lOF1lkVIyT4UjDSsG7svLISKgENLquakFbrR95
         dWt08uF4THhTYe5kS5saq8poS1qU2LQR9khNBIXTMIrmdHSW/ZYmfcE4qyB6oxSPgSmY
         EX5QQQi0G1F/k4emeNDAgkbFu87gUYVVsNoRPo+6SYtWh8kuvnlMG6DXr8CuzbCmKuFM
         T8UHtkxG0xY6tcK/3HcBZK0WBM5Rl0V/g4sGd7cVR4CwfI3JtLU+G/4K3AiUSBfDvLMV
         qC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742805449; x=1743410249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2s6YbLy4nW+jYW+2j4zgOCotGnhPTE4p9OSJFGAI4n8=;
        b=R9KguMWgeLIAbpz8SEFhpi8ZLEeW3nFwGBGlvoznTzCiwKiC3mHRkcSaFmStg+OSd1
         3rqlngW60JT0tTk1y4ifdavbNEKknktaTfrhGjaQGkSoTXPTaSfUhZsfiyM9L/XZMoVw
         IDOq9J+PCMyKqduunKomnUct3DhnG+3JtpQgYwR6RQekaF7mEU3VYJIhAqKYBtKo68jj
         AFF2uzyMduEGXwGo5hKYxs/f6t7121LkU8A1Er0/VpBXoHLJblvwwwzyL7leQp5W3CGh
         LZccLibW1Qy2ArSCgW5haXfVwFcQURntJeL9KuUG20+Cn86wXsscXSiS294C3oYK17u5
         u04g==
X-Forwarded-Encrypted: i=1; AJvYcCUbcKWGjttTI7E0WqflA2LhFMxmqy/Hlf862EKAYHZMoRrEctBry6k69/V+ifbPP1Mthaa0hfj0RaRyKxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX60/qAQxABIW6CM2M81XVFVVUHtBR05CCKY0A1fMkc43a5k5l
	TKXTLv2gs/M6y9DrA+9bBdvprlE8sjS0ZbR1axdkgB4i9TEGqu4+Wo8N/jtivGo=
X-Gm-Gg: ASbGncuxU8UQPNbifwaxU51wtddi1jCXWTzTvGNtASFUTWT9K50d9jCqVe/sn+L/fad
	SAM+vC9v6kmfuEiVCXWxGRzDWPFXimSsdX1fGtlkMJuNESRkzjlUCYeXuQ6e0LU/9tVAuCV7Dr7
	euX6DuNC34tvnh/Rl7AwHNHJe5yS+oMTTJ4k9ygDsuyIei+0muGwjurWff3bNbJvhpsUSj/w4PA
	cmh9mRCgyUwFnh4jLVaMjPLikKxk6hcg8b11e+Tym9n0gTc+tn5MUDKsEGhk04+zzqspKTkYByb
	OzV51E88N3EEsA/Tb1o4K6/KusRxnILr+rZjzmMfIoRtdfX3hMVPY15njcXOK8AjXTkRj1gVV47
	VsY+bfOQz0uzwXA==
X-Google-Smtp-Source: AGHT+IGyDIlFsMFtDafxJbgUfgP/qTb6rCAL5yHNPveThhrNUx+dqUwr1+vxGkhJvulgvlhTLqQIxQ==
X-Received: by 2002:a05:6a21:7a90:b0:1f5:902e:1e97 with SMTP id adf61e73a8af0-1fe4331934bmr20590058637.41.1742805449356;
        Mon, 24 Mar 2025 01:37:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa980asm7587742b3a.11.2025.03.24.01.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 01:37:28 -0700 (PDT)
Message-ID: <ea14978a-f29f-45a2-acff-5585c81f4ca6@rivosinc.com>
Date: Mon, 24 Mar 2025 09:37:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/18] riscv: sbi: add SBI FWFT extension calls
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
 <20250317170625.1142870-5-cleger@rivosinc.com>
 <20250322-62ad16eaf41abd98170fa6bb@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250322-62ad16eaf41abd98170fa6bb@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/03/2025 13:14, Andrew Jones wrote:
> On Mon, Mar 17, 2025 at 06:06:10PM +0100, Clément Léger wrote:
>> Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
>> provided as a separate commit that can be left out if needed.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/kernel/sbi.c | 30 ++++++++++++++++++++++++++++--
>>  1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>> index d41a5642be24..54d9ceb7b723 100644
>> --- a/arch/riscv/kernel/sbi.c
>> +++ b/arch/riscv/kernel/sbi.c
>> @@ -299,6 +299,8 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>>  	return 0;
>>  }
>>  
>> +static bool sbi_fwft_supported;
>> +
>>  /**
>>   * sbi_fwft_get() - Get a feature for the local hart
>>   * @feature: The feature ID to be set
>> @@ -308,7 +310,15 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>>   */
>>  int sbi_fwft_get(u32 feature, unsigned long *value)
>>  {
>> -	return -EOPNOTSUPP;
>> +	struct sbiret ret;
>> +
>> +	if (!sbi_fwft_supported)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_GET,
>> +			feature, 0, 0, 0, 0, 0);
> 
> We're missing the
> 
>  if (!ret)
>     *value = ret.value;
> 
> part.

Damn, and even worse it isn't used at all. I'll probably remove it
entirely and keep the strict minimum for this series.

Thanks,

Clément

> 
>> +
>> +	return sbi_err_map_linux_errno(ret.error);
>>  }
>>  
>>  /**
>> @@ -321,7 +331,15 @@ int sbi_fwft_get(u32 feature, unsigned long *value)
>>   */
>>  int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
>>  {
>> -	return -EOPNOTSUPP;
>> +	struct sbiret ret;
>> +
>> +	if (!sbi_fwft_supported)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_SET,
>> +			feature, value, flags, 0, 0, 0);
>> +
>> +	return sbi_err_map_linux_errno(ret.error);
>>  }
>>  
>>  struct fwft_set_req {
>> @@ -360,6 +378,9 @@ int sbi_fwft_local_set_cpumask(const cpumask_t *mask, u32 feature,
>>  		.error = ATOMIC_INIT(0),
>>  	};
>>  
>> +	if (!sbi_fwft_supported)
>> +		return -EOPNOTSUPP;
>> +
>>  	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
>>  		return -EINVAL;
>>  
>> @@ -691,6 +712,11 @@ void __init sbi_init(void)
>>  			pr_info("SBI DBCN extension detected\n");
>>  			sbi_debug_console_available = true;
>>  		}
>> +		if ((sbi_spec_version >= sbi_mk_version(3, 0)) &&
>> +		    (sbi_probe_extension(SBI_EXT_FWFT) > 0)) {
>> +			pr_info("SBI FWFT extension detected\n");
>> +			sbi_fwft_supported = true;
>> +		}
>>  	} else {
>>  		__sbi_set_timer = __sbi_set_timer_v01;
>>  		__sbi_send_ipi	= __sbi_send_ipi_v01;
>> -- 
>> 2.47.2
>>
> 
> Thanks,
> drew


