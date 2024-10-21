Return-Path: <linux-kernel+bounces-374978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5649A72B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655141F227E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE4D1FB3F2;
	Mon, 21 Oct 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTM2z5W6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888B1FB3DD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537042; cv=none; b=LWGuMpzOTyiwK0J5HlB45yS8jKb+MglWXqs0AYTwsL4udSzQiEG34I1c/e51r3pfcZw2avGD9Hrg2qD4NYoE/hT/qNBQjlUdNofJbi/IThxqO4WToS1T+Sp54i2uvnM4XQWih1fN8ymgCHQpScux6uduOxlVgHJo7FXtdIlbE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537042; c=relaxed/simple;
	bh=Poj40m4XWjZmZW67V/R29Zyaoz6g/1vZbJUcwa8dRBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n6hYxQAm765Z5Q+bzjNTwJm3D5g0dvq+ZdYyrx06/w+e8C7tjDXzDT4/jIPSjo83uoGVXZSZD3JJYnC8qqtkoHkeo6u9ctrW5r7uk5X5NP493fFDD5YFA/kIUTExtPjxsMrjPNGmUPAOjVZwXBlAzQqjKuLkhiGmTWTHnUZahiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTM2z5W6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729537035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JVcG4b9DpqHn6ILLTpsyd6A8EriJ9ALphdfVTy5yis=;
	b=OTM2z5W6QQj4XOshxepF1NL1Z/Lvlgg8OCmwXgmCc9NGRmGlJTldOhu4YBZBvK1pr+FBf2
	8XExTkSPrcX6UcBf/XGZoug1T8+CCjDPXpSMy5vI2nCHkYMGuAC3R1nQPQDgCdfUkDM+M+
	6i/rWyzDn3TEcC3m/kBQ+9gNnx4JUII=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-_oCufogSPN6o3nUSsSmP3Q-1; Mon, 21 Oct 2024 14:57:14 -0400
X-MC-Unique: _oCufogSPN6o3nUSsSmP3Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbd2cb2f78so104767536d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537034; x=1730141834;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JVcG4b9DpqHn6ILLTpsyd6A8EriJ9ALphdfVTy5yis=;
        b=HwYb/6Gd04xx6f/XXr6YlY8X98QQVTl6JSRIzljGxsEC5ntLVb9wW0e4h0QMlCaTtT
         WobzLRvRxmw9xGdg6XamwhWW23NJJ3MLZG6vLjI+N/DknfvByK8W8y18DdIzPQtTr9uY
         1VqCEEbR9c1KcDZc+p8VyZefSBCe7bLfh1biBCL8wcUIqU5I33WV5HMJ9v8Qw/F+MZwc
         RnSMvvRf15ehePhuSMpdfVVVYosdVKQ8no6taAzSrfrFmiZNGXPWGJL4RAMim7zkbkdz
         S2B6g/jwZfeIlO9Zg/XIie4+qwM0NccFDXLRU+thvoCajYxg0hsoLQenQZ/YoeVZ94XZ
         fS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAFhOuk+Il0pUKfBNv144eDYqPtW95CxReiDxqNLeEUkUu8qK0Rm+skjhWnm2DQ6xbsZ1AVMB+FiLwQYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRm75bCJ63b4ebp5cDNbMp5Cqp5Q3AiILmdTbytcj7uaiQ3eom
	w4mq+IYOzoghdaa2zSiZjpyT8vcq0gncFmzrv05wOaClhCl9JJkIcpPzpyt3Pk3LtQIRN+QGvhh
	dCGX/f6O1gPvMM3T98wAr9LpTO47hwukK785LUUbqrTIrJfwYoXKQ6pC4WZIsgw==
X-Received: by 2002:a05:6214:2dc7:b0:6cb:81ba:8ac1 with SMTP id 6a1803df08f44-6ce211dd0b9mr13770816d6.0.1729537033897;
        Mon, 21 Oct 2024 11:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhRNbKYg3FJuhV3JjrTQoeIMJwfDsagQ1cKT7l7Ble51qnCXFHBL3v35PoAgmawwvbY02KeA==
X-Received: by 2002:a05:6214:2dc7:b0:6cb:81ba:8ac1 with SMTP id 6a1803df08f44-6ce211dd0b9mr13770476d6.0.1729537033558;
        Mon, 21 Oct 2024 11:57:13 -0700 (PDT)
Received: from [192.168.1.18] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fb90dsm20433686d6.43.2024.10.21.11.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 11:57:13 -0700 (PDT)
Message-ID: <94cddfbb-bbef-73cc-2bb6-ad7474df08bf@redhat.com>
Date: Mon, 21 Oct 2024 14:57:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/3] selftests: livepatch: test livepatching a kprobed
 function
Content-Language: en-US
To: Michael Vetter <mvetter@suse.com>, linux-kselftest@vger.kernel.org,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017200132.21946-1-mvetter@suse.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <20241017200132.21946-1-mvetter@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 16:01, Michael Vetter wrote:
> Thanks for all the reviews.
> 
> V5:
> Replace /sys/kernel/livepatch also in other/already existing tests.
> Improve commit message of 3rd patch.
> 
> V4:
> Use variable for /sys/kernel/debug.
> Be consistent with "" around variables.
> Fix path in commit message to /sys/kernel/debug/kprobes/enabled.
> 
> V3:
> Save and restore kprobe state also when test fails, by integrating it
> into setup_config() and cleanup().
> Rename SYSFS variables in a more logical way.
> Sort test modules in alphabetical order.
> Rename module description.
> 
> V2:
> Save and restore kprobe state.
> 
> Michael Vetter (3):
>   selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
>   selftests: livepatch: save and restore kprobe state
>   selftests: livepatch: test livepatching a kprobed function
> 
>  tools/testing/selftests/livepatch/Makefile    |  3 +-
>  .../testing/selftests/livepatch/functions.sh  | 29 +++++----
>  .../selftests/livepatch/test-callbacks.sh     | 24 +++----
>  .../selftests/livepatch/test-ftrace.sh        |  2 +-
>  .../selftests/livepatch/test-kprobe.sh        | 62 +++++++++++++++++++
>  .../selftests/livepatch/test-livepatch.sh     | 12 ++--
>  .../testing/selftests/livepatch/test-state.sh |  8 +--
>  .../selftests/livepatch/test-syscall.sh       |  2 +-
>  .../testing/selftests/livepatch/test-sysfs.sh |  8 +--
>  .../selftests/livepatch/test_modules/Makefile |  3 +-
>  .../livepatch/test_modules/test_klp_kprobe.c  | 38 ++++++++++++
>  11 files changed, 150 insertions(+), 41 deletions(-)
>  create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
>  create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
> 

With the small syntax error fixed in unload_lp(),

Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>

Thanks, Michael, this is a good test to add to the suite.

-- 
Joe


