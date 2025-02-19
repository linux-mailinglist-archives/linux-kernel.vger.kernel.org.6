Return-Path: <linux-kernel+bounces-520742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E3BA3AEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F77A165C99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA31E4AB;
	Wed, 19 Feb 2025 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EVnl/hN5"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F21E885
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927391; cv=none; b=j6LOc8EHAyO6v6htFE/5IpT1v0U1TERbXyqjgFJ0r8BSRmMT862Xsjze55FAceL0FtKKUGOJNfFbK8uitNPFeYilfNsHGVmHPYYeelLb0DJkOMrd2BSbQ42sGwD1eb+hKydf9U9PUoHmycfhv1M/kpK5UPtK1J38Od0nsmzZFOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927391; c=relaxed/simple;
	bh=N9HYiKAzIYICHkevEmGii0QS0aosYLi2lJDrliQrdjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDGwK+sQOiMg6lG7RCu5XGQyVzQRzJvtu8C6JF/FICbdqApXMI1bT9kcnKKi0gtLjQ7MAAqQwKixDU7jstI4q4XEMCYoQ5fuKu8WQWtwDrSLIATXCypcrz3rMRp+l834ueM9qRYC7ET9jMK2XnTdLUu7U6GoI0l5+ipqlvPy/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EVnl/hN5; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46fa764aac2so50380281cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739927386; x=1740532186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhFcj8FNnOMQY209sd3DQ8BUWimeVSt0pBldsBEl40Q=;
        b=EVnl/hN5WpV0RNCklh8OUnR6IjJMMgXdf11CR+grCtWbi1BcYAHZfs/PkID76Vw0gy
         kb6eoU4fNGpQPghFuEO8Jxs/t6fEgBW7eIWQ+y/5t8sOFgPua6qMbFdrxQKqvbqiFmS7
         FgrVEPRqxoewlsaqCqu9xh1sb1OtKnWRoz7M3T0uGUCZzolksKVjFIcoYm0kk4ifIVnj
         0WEdkHkjnaL4o/x8hzHCDy5bkIrUEhizhsh3OBseVxQ54MuUSX3ybTjV/waMgaTZOwWf
         shoaBlph/Nm/iHZAW1DUEVhuDG3msOLc7Uhr45cBsdXhDETHFeHp21ndYk/Mxk4EbcIk
         CWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739927386; x=1740532186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhFcj8FNnOMQY209sd3DQ8BUWimeVSt0pBldsBEl40Q=;
        b=FnR2U7qS0eBOBtRxjtiHhC7HNwgxufaz65XItvY4J7pHFof5v9ihfabcAQKHmzRywt
         fUenyA8aV4zt6XviGkLs/b1//AHWmLC2vChOQVh67ST7wzMlU+KQ85sPQUxJ1PhMoazG
         B+hNSkK6OY+JiAh5pg8Q+ntg+YYQQe+ETMc0dSNoHqQDTM90lAu5M/u1wiMyCyQPkeY8
         xvfTomLRrF1jztaxpIgEIbL6D9lBJZiu63/ptEvgmZ70L2QqIuisOeq5Z0H2k0yx6m6s
         U0wIr9zCYcpM1fL7bgq2G246DH6y2OcwJvS0gewADqcU2ddm7Liwim3voy267n4jofBi
         Df8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8LOcDQm4Lt5Yhs3ge/am2/3dtY03iI7ba+VCPlOtmL5QbRPSvvOK3IYZHZ8Goj7+TkUCwlTxji8YtOdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjmQOk4Mbkrz3u/0z1xkDfW2mqN9Vejq+ZfwW6kFTRZVxlU7F5
	/11ayVWGVy5tmvPmClZZKjOS3QRN0QKQco14BU++MZAYxxNSTGre0jEiwFPAFQA=
X-Gm-Gg: ASbGncusXlIkfOwMxOnl60ZSAayy9GHrrwMGPeGi+gDu8LcrlbFB0dK298lhfGcl9eD
	LIAHqLuVCMn3cPPvmIJ/b5eCrz3rEAqCE+eYop1k/ynbvAm9nNxAAhVfwT4MKsEwZg50Us8KTpQ
	DwnmWBN+pCAe7XtoklkHHM2lrJBY9rM2sSoxkie1Txpx2vEsXPailGCBsZk3qeUYCkPyAeV236M
	7zrA7tt7nDiA+A0y9c8tdRQSin7qruIJaCRzWUYFGCtTHEFYHO/Y+ZOIKwttSeI46asXtHR6ai0
	yWH0W+djoGByk0zqckJ0y4z83WLNLnaLWjVXv298mSpBIWHTe0X7VP7sKuA=
X-Google-Smtp-Source: AGHT+IGIImyr8vXM8aoEAFX4jw+veWvhRzvUOjQ6ykQZGmD9QHL01qCTPEVDTI2/NSadsnBmXDnhew==
X-Received: by 2002:ac8:5d8c:0:b0:472:447:ad6a with SMTP id d75a77b69052e-4720447b020mr53202851cf.36.1739927386536;
        Tue, 18 Feb 2025 17:09:46 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47201c9eecesm12727831cf.37.2025.02.18.17.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 17:09:45 -0800 (PST)
Message-ID: <3f5fe015-20f8-4a88-bf28-86b224bc1349@baylibre.com>
Date: Tue, 18 Feb 2025 20:09:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: adc: ad4695: fix out of bounds array access
To: David Lechner <dlechner@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-02-18 18:17, David Lechner wrote:
> I was doing some more testing and found a bug with the
> in_temp_sampling_frequency attribute being corrupted. This is a patch
> to fix that, plus a bonus patch that cleans up some related code (it
> wasn't strictly part of the fix, hence the separate patch).
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> David Lechner (2):
>        iio: adc: ad4695: fix out of bounds array access
>        iio: adc: ad4695: simplify getting oversampling_ratio
>
>   drivers/iio/adc/ad4695.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> ---
> base-commit: ac856912f210bcff6a1cf8cf9cb2f6a1dfe85798
> change-id: 20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-7f16ebc3be14
>
> Best regards,

