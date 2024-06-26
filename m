Return-Path: <linux-kernel+bounces-230647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A05917FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4E91C231A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E582317F4F0;
	Wed, 26 Jun 2024 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TGt/ZUz1"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728717F378
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401779; cv=none; b=dtMATkX8cj5swUZeGjZ83U2OHxeVvLzTXfeEFDXnCV5f99bhi8lg+ObdizzGx8qDSkISf2h0WEqJ6V+ZSl65Udp5pkZkU1En17rlpbhL5hK1+HYAjfeS8uwWgRH40d5og1+BcMk1RrBw63FFKgPvJtmPEUFwTpxv/Dsw8GHpwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401779; c=relaxed/simple;
	bh=7kxtBK25xovD9hnasOmXym1Dqzb8xYXCkDVgPyX+fcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6IR6b9Skklwjn3Ks5a//i3/GncuLamdEPalmNB3IglsKWW9TQZm1pHLdrTzRaFHRs/Gk8GJpJJsG/EdqFqyTXPXG35g0VJd6sBUHxrqOLW1RStSXloiKuOVuwDdgO9Lk+K/JL6Y6Nm1FprN7H6HjCwzZTWZkJ6+bXMa3M/0yZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TGt/ZUz1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52caebc6137so6266345e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719401775; x=1720006575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMuzpY4Z872AyWI1aK61/MVe81tb/rCrS4Gors5C2F0=;
        b=TGt/ZUz1HGQGhfzvWKYGkdEocIa85dHpu/hO2yWQHIOzwwV4mtPXq3Rv2pPZ/0NElF
         81oKUjwvWUX95cUf6kDWpyM6Hg5pr09cPg1ykvzyDTW56b1NFaH1Mvhz3ROLZYD/wYjf
         G429Gym3StU2gXb6adrajCkZnwh5qD/1cT+9dCSbtgV9gKQMYc4DzZReZr4XCgEuNCzT
         Itwg5xklgJ1y3wGDuVAYGg2eMJ4YUWznmyTwXUkWSyikLsz8fs/IBLj4OvYZxCuZ5sCS
         p3I0bqTs5hwoyRA563UWrCZj3DnAL0fUV4PisOLJSRiETcPWYYVwYa3G3ETtQarqxt6l
         NJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401775; x=1720006575;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMuzpY4Z872AyWI1aK61/MVe81tb/rCrS4Gors5C2F0=;
        b=nSPnvQBnK4WaeRfLjQuoPBXWHBgYdcPtRHcUGJoz0tpd0tm6cCXZXvxk+T5iC1+zc8
         2Py26DyXdobnGL4VXk3pCaBzRpalrgKuiIZAjCE0GtYxP3rgVt1vZQwFrraYWIeKOaKu
         LJizJkDL6YWOTXTM4RkI0wsFF8CZ9MkRyEYulTLoGnLBKS3oAMvJGCmbmBjBWrMrhKil
         TflugfWHonCnwOzamnNZlbZykQTXz/47mSFOg5D7qFASNrZyf34ZNqcO8EYLR1LufbXl
         7dImdX08iYaWTpYu9jbNSIf8sCUhnICMwPgOWVXVHRUKwV6J3lWgSCQgSLeItMxDbcsA
         ha0A==
X-Forwarded-Encrypted: i=1; AJvYcCWIbIMKXxsGfQc3NZBTg8UI9bJv6Tz0fsFkcYF4mjAbAMzTMO4GO6Qrb1NaeF3BmU5gE6ps0KFg1Zi9BMm7LMxMlQQNT0IMn9Ux8AWO
X-Gm-Message-State: AOJu0YzJTNoo+9GHbeR43XtjWB7GuMlitq8gP/do9MCB4QjKMjxh0k+n
	X7PinSt/3ciNyp4+E7j1Sa/UYCxRt0UrsSmXLpdBech5k2gEXQ5VCS6N4Xv/N5w=
X-Google-Smtp-Source: AGHT+IEPEpCRb3cEZBmhNT1f7PAwFW+p+uWIp3od7KrxRjrljO66wKi6YdCFGUJvQkzMblj3tBvohQ==
X-Received: by 2002:a05:6512:31d2:b0:52c:e3bd:c708 with SMTP id 2adb3069b0e04-52ce3bdc757mr8165299e87.10.1719401774812;
        Wed, 26 Jun 2024 04:36:14 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366f973b7e5sm6762226f8f.14.2024.06.26.04.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 04:36:14 -0700 (PDT)
Message-ID: <5aeaaecf-0eb6-4934-b14e-2285eff6cc62@suse.com>
Date: Wed, 26 Jun 2024 14:36:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] x86/cpufeatures: Generate a feature mask header
 based on build config
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
 namhyung@kernel.org, brgerst@gmail.com
References: <20240622171435.3725548-1-xin@zytor.com>
 <20240622171435.3725548-3-xin@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240622171435.3725548-3-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22.06.24 г. 20:14 ч., Xin Li (Intel) wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Introduce an AWK script to auto-generate a header with required and
> disabled feature masks based on <asm/cpufeatures.h> and current build
> config. Thus for any CPU feature with a build config, e.g., X86_FRED,
> simply add
> 
> config X86_DISABLED_FEATURE_FRED
> 	def_bool y
> 	depends on !X86_FRED
> 
> to arch/x86/Kconfig.cpufeatures, instead of adding a conditional CPU
> feature disable flag, e.g., DISABLE_FRED.
> 
> Lastly the generated required and disabled feature masks will be added
> to their corresponding feature masks for this particular compile-time
> configuration.
> 
> [ Xin: build integration improvements ]
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

Overall LGTM, some minor points below.


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


<snip>

> diff --git a/arch/x86/tools/featuremasks.awk b/arch/x86/tools/featuremasks.awk
> new file mode 100755
> index 000000000000..989b021e73d3
> --- /dev/null
> +++ b/arch/x86/tools/featuremasks.awk
> @@ -0,0 +1,84 @@
> +#!/usr/bin/awk
> +#
> +# Convert cpufeatures.h to a list of compile-time masks
> +# Note: this blithly assumes that each word has at least one
> +# feature defined in it; if not, something else is wrong!
> +#
> +
> +BEGIN {
> +	printf "#ifndef _ASM_X86_FEATUREMASKS_H\n";
> +	printf "#define _ASM_X86_FEATUREMASKS_H\n\n";
> +
> +	file = 0
> +}
> +
> +BEGINFILE {
> +	switch (++file) {
> +	case 1:			# cpufeatures.h
> +		FPAT = "#[ \t]*[a-z]+|[A-Za-z0-9_]+|[^ \t]";
> +		break;
> +	case 2:			# .config
> +		FPAT = "CONFIG_[A-Z0-9_]+|is not set|[yn]";
> +		break;
> +	}
> +}
> +

IMO this script could use a bit of high-level comments. Something like:


# Create a dictionary of sorts, containing all defined feature bits
> +file == 1 && $1 ~ /^#[ \t]*define$/ && $2 ~ /^X86_FEATURE_/ &&
> +$3 == "(" && $5 == "*" && $7 == "+" && $9 == ")" {
> +	nfeat = $4 * $6 + $8;
> +	feat = $2;
> +	sub(/^X86_FEATURE_/, "", feat);
> +	feats[nfeat] = feat;
> +}

> +file == 1 && $1 ~ /^#[ \t]*define$/ && $2 == "NCAPINTS" {
> +	ncapints = strtonum($3);
> +}
> +

# Create a dictionary featstat[REQUIRED|DISABLED, FEATURE_NAME] = on | off

> +file == 2 && $1 ~ /^CONFIG_X86_[A-Z]*_FEATURE_/ {
> +	on = ($2 == "y");
> +	if (split($1, fs, "CONFIG_X86_|_FEATURE_") == 3)
> +		featstat[fs[2], fs[3]] = on;
> +}
> +
> +END {
> +	sets[1] = "REQUIRED";
> +	sets[2] = "DISABLED";
> +
> +	for (ns in sets) {
> +		s = sets[ns];
> +
> +		printf "/*\n";
> +		printf " * %s features:\n", s;
> +		printf " *\n";
> +		fstr = "";
> +		for (i = 0; i < ncapints; i++) {
> +			mask = 0;
> +			for (j = 0; j < 32; j++) {
> +				nfeat = i*32 + j;
> +				feat = feats[nfeat];
> +				if (feat) {
> +					st = !!featstat[s, feat];
> +					if (st) {
> +						nfstr = fstr " " feat;
> +						if (length(nfstr) > 72) {
> +							printf " *   %s\n", fstr;
> +							nfstr = " " feat;
> +						}
> +						fstr = nfstr;
> +					}
> +					mask += st * (2 ^ j);

nit: This expression can be changed to mask += (2 ^j) and moved inside 
the 'if (st)' branch. Essentially only add a bit iff that status of the 
relevant feature in the kconfig is y, which is signified by the value of 
'st' variable.

> +				}
> +			}
> +			masks[i] = mask;
> +		}
> +		printf " *   %s\n */\n\n", fstr;
> +
> +		for (i = 0; i < ncapints; i++) {
> +			printf "#define %s_MASK%d\t0x%08x\n", s, i, masks[i];
> +		}
> +
> +		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
> +	}
> +
> +	printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
> +}

