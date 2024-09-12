Return-Path: <linux-kernel+bounces-326916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDC3976E71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F0D1C23960
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D12D126BEC;
	Thu, 12 Sep 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhpZfSVm"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E764529CFE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157408; cv=none; b=IIHOkl0pi10jAyX6GJbGsinTf7CMDSptImyPe+cjFqvYtAfrDkKEw+itIWwh2FMBVVFUtDFTGVdS3BIdH4lAffxHFc2V/KqnJuXiQz8HJHfltdDfaTy8IDhscKVJt/fksM4PLre2+Hml2AYGzklA10Pa+sBqQLTFvW3XK0p/CLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157408; c=relaxed/simple;
	bh=HsACV9qkTEWC0gpHuRxcM67abJHmPCw5KrKY8TCaUHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upjPras3RJpT41R6K10xRXWLCN0oCqi/AAcjlxuXbAyCgcMtOHaivJufUFh/Kphkak2AZdxwnkdpPm2cm2M4OcwVBLr9N1VvoVBX5VLrlyVAapTkzuGuZFCqYIsoCrDZ6IE8eRJzYhYgIJo5rEyWNlDXnD+jpc5pLgcbnSvCqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhpZfSVm; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a08489f757so3431605ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726157406; x=1726762206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4YRLuNUgSWopISY8++0gxqGMIlZgrgvlLfTtwvHiqc=;
        b=hhpZfSVmYUXHMzSN1lmeEpCLBx5KUudwLyoou+y1JwY3n8kt2niR3lbHwyxLlfle+c
         Nk9HRIO9/UKdUaidROpmLEynDDQDYJ6D0zI+y2XnWAdpGFhR833w7yYBHYhs9Atrj4R1
         LIN+hV55flSPTl093dSbfBmHWoXQweHDCeVQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726157406; x=1726762206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4YRLuNUgSWopISY8++0gxqGMIlZgrgvlLfTtwvHiqc=;
        b=PRm/LRCH/2erwvMd6LIHG5BSuWqvEUaKBC47CzgbWGQha4a/147e0lRCh+fj6OPG2W
         dJVJPvjPycDflTsjduiVgmp5P0iEiiIuppU+Zo/ewIM77jwnCVD/cKNLPa/XR4Sb8kvN
         5jy4F/Q+YBCjdXI/iwiPqjNnPvE8YmMDVFl6s1cus441Mdr2H0jwtOyg2z/q/B8YClLa
         A2ZT4TiCPl/BF+03FBHM/TlHu8jRuziXxMaznTJkGYY7/I0hKDTeteG8OtVc4GeMtbnF
         EvFVji88kupDWd6WtWbVUZHX6Fu4VjVOSLRyXHgkywTcRPS+tY3wItfIGyucA1eU22Ds
         iXWA==
X-Forwarded-Encrypted: i=1; AJvYcCWwFZj+pUQAFIJmlRErxz4lwVcZ3zRz2s1Gzd74mpCw6utLu9q5LbbqUHQ/XGrAiShG3GlaOqNnDRVGjtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3Fvv9gYRGV1UWL8Tionv7WTs3CITMmAnFMvJNTvqQHMWGJd0
	brb5fW4XXbnzTyhXRPCWNByXSCM3Zqi+IqUPArL5+FZIfF681IzBuvYWL6E2tfQ=
X-Google-Smtp-Source: AGHT+IGnS9TE/OydSI4yqMHXeq5iZE4Pmnu5pLtOOIdRRqk2ravQJ1hGZCVSj5FbU4ycOavc1l8rFA==
X-Received: by 2002:a05:6e02:1565:b0:39f:5783:fbbb with SMTP id e9e14a558f8ab-3a084611adamr24909165ab.3.1726157405966;
        Thu, 12 Sep 2024 09:10:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a059016161sm32481005ab.73.2024.09.12.09.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 09:10:05 -0700 (PDT)
Message-ID: <3b700650-159d-45ad-91a3-59fca3019766@linuxfoundation.org>
Date: Thu, 12 Sep 2024 10:10:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kselftests: mm: Fail the test if userfaultfd syscall
 isn't found
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <20240912103151.1520254-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240912103151.1520254-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 04:31, Muhammad Usama Anjum wrote:
> The userfaultfd is enabled in the config fragment of mm selftest suite.
> It must always be present. If it isn't present, we should throw error
> and not just skip. This would have helped us catch the test breakage.

Please elaborate on this to help understand the what breakage was
missed.

Also this commit log doesn't look right to me. syscall() could
fail for any reason. Do you mean to see skip is incorrect in this
error leg? Please see comments below.

> Adding this now to catch the future breakages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/mm/pagemap_ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index bcc73b4e805c6..d83dda8edf62c 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -95,7 +95,7 @@ int init_uffd(void)
>   
>   	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
>   	if (uffd == -1)
> -		return uffd;
> +		ksft_exit_fail_perror("Userfaultfd syscall failed");

This looks wrong to me - Is missing config the only reason this syscall
would fail?

>   
>   	uffdio_api.api = UFFD_API;
>   	uffdio_api.features = UFFD_FEATURE_WP_UNPOPULATED | UFFD_FEATURE_WP_ASYNC |

thanks,
-- Shuah

