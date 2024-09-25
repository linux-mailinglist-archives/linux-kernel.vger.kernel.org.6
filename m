Return-Path: <linux-kernel+bounces-339436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E8986506
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC661F26B25
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F231B5A7B8;
	Wed, 25 Sep 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cIkU1HrO"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB813CABC
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282485; cv=none; b=kmiQOdqv137qBbUHl1ddMMTm/nAF47u/Oe4DvjfzDEvFjfGmhaJDSbzaAEeb3wAJ6YDfvn2qulek5u0VBHMDY0V7zu+ycDEO6ouO16YF5B2voLLXgtskC4JlCFUkm9wQaEVnSxgjITarxR87jMO5dueiR8/etYNylc+fowOB6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282485; c=relaxed/simple;
	bh=PI67tLirlz221GqZjEYs9n3s8qaQlx8hfCr23HTlcm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyHgLiX9Og61QTqGGrzicesnmjKCaCmkEkjk549spydt3l3UDYi4yF7BPaKcru/muF5p1FaTySwCC0i+XBNChl0g3wROTqFeJA4U3Sm/+I+GR6JegzWHrc7SvzRf/wrNaIq8Fh2WijbvhY5mmpF5FmNYWjAA0mnqOnZcq4vrJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cIkU1HrO; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27d045a73easo100428fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727282482; x=1727887282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ooWKkaH8UA51S7NKCStf2gXeN7ic3yySCOlAB9zd8A=;
        b=cIkU1HrOEtjVGDPshVSdsT6rSNS0sMD6xZVk5OvU9L5BdUw5iAqTVtklXvA0HyHn9N
         gFthYUMf8ecP54K1fbCXasO2BKcNb7qLTg1F/7SrjRqyTXKhXXPxB+VPqTctcJNVRIhk
         C5fExHjkS8XmQKBBC7OJbvtt+2RyhFAxMpFLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282482; x=1727887282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ooWKkaH8UA51S7NKCStf2gXeN7ic3yySCOlAB9zd8A=;
        b=gl5AIQy+rAIEHX9+oa7i12P+Pnuth8w4HqWPg1dCWm2TT2cdxHJCRnTBfHgnUK/QsC
         TbXDsCc4w4t7gXW1RphSOyGZozb8m+i/UjNlw1RFDgbV8GL30n6daxkg5M4Ft7ni4WJn
         z182A6+TxrXMm72aj8737DKtkl34wfmcXp0HViDZ5tGT2agsqhpMrDVnI5nRQk/lFPkz
         v0Rn2MquNIkKIpUBMitkoc2+Bp7CvaSVPp+fmK7cHGH4dEY6JTLhJJjkO4w1t8FBIHDC
         6lkSkixffNhLyXbvJuvcLELwWn/v/BF0no5J6YQq/PMweC/qS54z9ueQJLr4N7Q8eIxo
         /hIA==
X-Forwarded-Encrypted: i=1; AJvYcCWP5deYMA9q6MQw6b2CS9n2qvJPMHmcjgIRBB9MObYjLDj155tc7AKQFBMk1Sjf8RAabqCtqrUr2mO5drY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOhOavONRTe4CKpNM4S4QV5hd68Pu36e+0zrpPzbBdo/GxTwH
	UWOTJRYWTc5tAB0PlEzARptSqhpG78vsL8gPEybmcW2ZtxjKxhCV6brTSZXaHXqUPKtuwYKNOeo
	Y
X-Google-Smtp-Source: AGHT+IEu+wsD5M8hLLJhawisq6UBLFx5/tPt56xJ6tx3Ztxg/IR/TZ9MyYAirmSPX4RgkZwIftpF1A==
X-Received: by 2002:a05:6871:e01a:b0:27c:df8c:8dac with SMTP id 586e51a60fabf-286e13655e6mr2784227fac.13.1727282482594;
        Wed, 25 Sep 2024 09:41:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-283afabfcffsm1399050fac.58.2024.09.25.09.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:41:21 -0700 (PDT)
Message-ID: <62f52cb9-1173-46aa-96a0-d48de011fdc2@linuxfoundation.org>
Date: Wed, 25 Sep 2024 10:41:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] selftests: add unshare_test and msg_oob to
 gitignore
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
 <20240925-selftests-gitignore-v2-1-bbbbdef21959@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240925-selftests-gitignore-v2-1-bbbbdef21959@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 06:23, Javier Carrasco wrote:
> These executables are missing from their corresponding gitignore files.
> Add them to the lists.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   tools/testing/selftests/core/.gitignore | 1 +
>   tools/testing/selftests/net/.gitignore  | 1 +
>   2 files changed, 2 insertions(+)
> 

Can you split these into two patches. It will be easier
for the net patch to go through the net tree.

I take the core changes through my tree. net changes go
through net tree.

Also helps avoid any future merge conflicts if new tests
get added to net

> diff --git a/tools/testing/selftests/core/.gitignore b/tools/testing/selftests/core/.gitignore
> index 6e6712ce5817..7999361992aa 100644
> --- a/tools/testing/selftests/core/.gitignore
> +++ b/tools/testing/selftests/core/.gitignore
> @@ -1 +1,2 @@
>   close_range_test
> +unshare_test
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> index 1c04c780db66..9dcdff533414 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -17,6 +17,7 @@ ipv6_flowlabel
>   ipv6_flowlabel_mgr
>   log.txt
>   msg_zerocopy
> +msg_oob
>   ncdevmem
>   nettest
>   psock_fanout
> 

thanks,
-- Shuah

