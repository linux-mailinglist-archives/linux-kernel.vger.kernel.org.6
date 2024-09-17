Return-Path: <linux-kernel+bounces-331711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7097B05E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6E61F24EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE3171E76;
	Tue, 17 Sep 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cv4i9oVE"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439216F824
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577463; cv=none; b=Ajsvr+wN9aHfeHJdh+BZMVXiGWhSH6kj2+Fz60uHK6j/5+mUAiXX2MKyI7JDdR0HJBfuea190tczVDPFopukPlbhMBtddua9n78xDu1Xc+RqelruGFgZRJKkahRConx8luL3p3MqdeZszgQePCIwxpq6Wr8UK3w525pF2KYJxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577463; c=relaxed/simple;
	bh=LOnl61i5yaHSFQnEP2WWcBmc7qf0GvjjHdn6bzOcbM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwPqOMRFPwVOSMqd/2v9ChjnNC7Por/33sN/ZPmLfNlr27nk32Fymzqzv/U/WZVEFS0JsfSnm8KzlX5bo8bXLlHb2G9hNeAYyWKrn8/mU534FqIpJM3e8/EC4qCKRFHbkWG+TBkgf3pPT6IWQWwrrUtBOJzglfoDk3Bgmj77DMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cv4i9oVE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3787f30d892so2891719f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726577459; x=1727182259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUTBhNze3sC2k9kiTyc2HdFztKFwUkSpznTsJN319TY=;
        b=cv4i9oVE6j2osbedvHANNeFw3a3BE81zSx5RF+t6g9v5ziCc+u0T6k0j4trGzDgCd1
         e7Md8pMtxFa1MorW+5KPlSl2iHlECGAZuZTVIBY8KHOZIvW4zQlA/wL3sbZ+MYqRSgFz
         PmAiE+Q+ds8XeuuvXJ5g6lo/3e/kDZ/lETau9rGkNma9mSJBnU7r6VL3abZp3G4QFPNM
         3w3rEny9sh82rAEO2jgkjIWoZRMlCaoxwNLV/hjVB8fzOKaCKEC0h8bGaSw2dodT0a3C
         l7s8/zNuQZkAGTtYMipT8h5bOS7oUua2Hdl2m3CBZy9OYOoqhsikZDm1OGpEg6k4PvNe
         qINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726577459; x=1727182259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUTBhNze3sC2k9kiTyc2HdFztKFwUkSpznTsJN319TY=;
        b=r1+5Zzyylc1NVqYO95RBQYyX/HPF/AiSthYEsA2Qt/il0Xh7/U6BUazer9mF+v7ZP5
         m1dlmre2J+48H47aLmTLQnA+hp+YgWUpEjxpbQhBb63PfmmZ5eGerq4ZOZ510Fu73sGl
         osp12F2wh0PiNhf1CIXf2KtoTh/nRkI1qmZWBWxgtXP5UotcDCdtaoF/QEbcb6SLxYBp
         etjYJyrzsiHNKXVjzWDNAlZ5/AXjvfV9xNYhgRc3AW8Kbyb2du7+aUEZ/1YJtJdYrs2G
         QTF4BAnTiSxVqxu0M4Y784Zpau1jGRf59oy5P9A3CQik4FzwP/5zC6zpgXWmPw2y6K0G
         ZEtg==
X-Forwarded-Encrypted: i=1; AJvYcCWfw7mvTNwbl566kebDeQeCz21wFbNKhRpplh2s1uDx980EonUoBs4myBCv6/ImdnJXaepXZOoCM0yWp1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxosRAsnQbA/IpY2MJVOEZ49G7PgK2F5OOLn2ruBch/xfRQ4A99
	i6xCiLsQ3WvgA4Sj4YP08W8Ng/jaw4Ws7sNHkWs5XEL6aA/QmHYaQ3Wmm9Y/yDM=
X-Google-Smtp-Source: AGHT+IFBHyltxI2+tj0F+uYDwJZi1t4xUbRYWPMXM+AxyVq8Wjkr6SNm+/JFFF8Ed/fo6TIPtJeuZg==
X-Received: by 2002:a5d:58d4:0:b0:36b:aa9d:785c with SMTP id ffacd0b85a97d-378d625a662mr8463566f8f.52.1726577459523;
        Tue, 17 Sep 2024 05:50:59 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780024fsm9506444f8f.81.2024.09.17.05.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 05:50:59 -0700 (PDT)
Message-ID: <538898bc-3f74-4d21-971e-f61e77b50abe@linaro.org>
Date: Tue, 17 Sep 2024 13:51:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/test: Speed up test case perf annotate basic tests
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com
References: <20240917085706.249691-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240917085706.249691-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/09/2024 09:57, Thomas Richter wrote:
> perf test 70 takes a long time. One culprit is the output of command
> perf annotate. Per default enabled are
>   - demangle symbol names
>   - interleave source code with assembly code.
> Disable demangle of symbols and abort the annotation
> after the first 250 lines.
> 
> This speeds up the test case considerable, for example
> on s390:
> 
> Output before:
>   # time  perf test 70
>   70: perf annotate basic tests             : Ok
>   .....
>   real   2m7.467s
>   user   1m26.869s
>   sys    0m34.086s
>   #
> 
>   Output after:
>   # time perf test 70
>   70: perf annotate basic tests             : Ok
> 
>   real   0m3.341s
>   user   0m1.606s
>   sys    0m0.362s
>   #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>   tools/perf/tests/shell/annotate.sh | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
> index b072d9b97387..b28cd95b1d83 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh
> @@ -43,7 +43,7 @@ test_basic() {
>     fi
>   
>     # Generate the annotated output file
> -  perf annotate -i "${perfdata}" --stdio 2> /dev/null > "${perfout}"
> +  perf annotate --no-demangle -i "${perfdata}" --stdio 2> /dev/null | head -250 > "${perfout}"
>   
>     # check if it has the target symbol
>     if ! grep "${testsym}" "${perfout}"
> @@ -62,8 +62,8 @@ test_basic() {
>     fi
>   
>     # check again with a target symbol name
> -  if ! perf annotate -i "${perfdata}" "${testsym}" 2> /dev/null | \
> -	  grep -m 3 "${disasm_regex}"
> +  if ! perf annotate --no-demangle -i "${perfdata}" "${testsym}" 2> /dev/null | \
> +	  head -250 | grep -m 3 "${disasm_regex}"
>     then
>       echo "Basic annotate [Failed: missing disasm output when specifying the target symbol]"
>       err=1
> @@ -71,8 +71,8 @@ test_basic() {
>     fi
>   
>     # check one more with external objdump tool (forced by --objdump option)
> -  if ! perf annotate -i "${perfdata}" --objdump=objdump 2> /dev/null | \
> -	  grep -m 3 "${disasm_regex}"
> +  if ! perf annotate --no-demangle -i "${perfdata}" --objdump=objdump 2> /dev/null | \
> +	  head -250 | grep -m 3 "${disasm_regex}"
>     then
>       echo "Basic annotate [Failed: missing disasm output from non default disassembler (using --objdump)]"
>       err=1

