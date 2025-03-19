Return-Path: <linux-kernel+bounces-567868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B270A68B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726061B62D68
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C57253F31;
	Wed, 19 Mar 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWnRIgl9"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA2254877
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383183; cv=none; b=WTwMOc5do5tCPrQaZoZE5cjKF0aNcc5iXG1simfujxaxZH8w7IyIiv9Rea7GoEPyEZB9DHy5zUFAjkl+Q5+iigAuTJ97owC/izO5Xsq3DmtGCwaA3ClFSeTFlw1euqnt/GwKZWU0Ma68xfvUVvfpW5P7ly7Uyom1iK10zj02e4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383183; c=relaxed/simple;
	bh=kRYvrjq7DytW/WOiIIlhrJ0KgxILkT5Jk9Kx+3CE9NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RL2cEehNV3DOZ8dgso650rJ0uyN1A6FXx9oycKhDYV5LN1uxDfCnCrjFclmdBKn5xaQwYkg5UkYmC92wDTOfo7yIo6KYurqGMtB/scfPEhft8XGt7NR8L93dIl0Tt/Q7CIvHZIEbeF7wQM5t7yOX8IcwT2nx8+3K/VR2bS84oBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWnRIgl9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39127512371so4052366f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742383180; x=1742987980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6XscEC5H8Sc/fAaekZZ9BeaM5hq/2aJGQbefQgjm1A=;
        b=tWnRIgl9DG591aKNLNdOKs5oZk5YRVV1Xkq3OHqzSWD2Zke6Bqw6KMXA8awQj17AM2
         sw9b+faAvlusblc7VcAAltf61TROE3PqxESIKWhShb9ZzaLvsXIaZ4k9HXx7wnGVWkKe
         PV4KMbMa8TIf/I745HToQFekUTY3wc6PhqCv4DROXxxoldTNabVPHrh6K/drvC1A98Wf
         oYT+hxqaWnX1JDKQhVK9oRvcKI3Ta5c6rhx8NwAbAYb8tbLvMvR3OpbopcWCMvE7cJKU
         0IYF/mfoRYnhPse1i9T0rnlYM+VNTJ5Gm5DVXZD3InADhDNwSdZOQ8xkhLASIn0X6Unl
         5+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383180; x=1742987980;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6XscEC5H8Sc/fAaekZZ9BeaM5hq/2aJGQbefQgjm1A=;
        b=c4QoDcZ+GfxTwNcT+v560rbIQW29CzB7IYFipYPk9aPCMWYGYi4EIJ4tHkTjm0WY5B
         m/uRDtBOxbATsoZBHK1ITVWBa9dNQF67XGVk3Vzz9OLHXUa/ZJ2mVJKAUBJAOaB57+ag
         3S1db79UUFXeDsCWuOHjmMqcbC8cVmLKVyjA9FU/8v/dcVbEzXcWKScP35f8uAeS7NMM
         9wUzI8HiB3AKRHu8AtVGlvNpIkM094mnzKT9HkGpxz6bwxK1cKL5k4SAGrz0y7GoGD5Q
         XQ6BJ0va/rfHDIyK2jgE4GOUOL/5/vyjoVp2NrWrZxxANTD0RvVGLUdoVBcdQTb5aF3b
         cbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Q9R8TOOKPiCIgNzrTUqoTTu/EwyEwRsXOKspS1TV2KsF9ngfAQWxE+7wZ7ucP4z3AZaWzToOkbvvkOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyasFS+JY11Jah7by8EwCGes+MBuDpyzByg6vPxbvDp2qP0g9z
	e7r3pGXpAeBHi8+rbMP0XPU/omoLKWfAzePcfXgUHCQ9ivECCiIzIflMiVUhnRA=
X-Gm-Gg: ASbGncuy8Bl3GPzbRmYP4giKCL9MPGhDuD9LETYmvBNrpZL1xxCP/ZIk/Za/xIVY5sz
	7z4DFqm6JOA48/kKQrHccDCU97G63VdEJ7ZQduGVgH0XTnIPTFcL8VZcVzS1bf1IFGjw3jJL7wW
	mLsACbm2gFeKNJaM83Nov7eEeMSUw/3DNQr+ruF4Fy2xfG7HH6e493+kuppX+g9fJYwujFJFKdw
	jc3zAI991IyKIfNgMRm7h0b3WZpAWzBwEhmecKj4gR9MGPs4yJV6sv4HSFYSuhwUHqtbBzyodvd
	Rp6/K2K8+uB+h9k3iVp9btemKnr9G4wBYOgbqxDkkCZnGN60cG6W3g==
X-Google-Smtp-Source: AGHT+IEmvRWyNcLC8Ne4gaIzJhWSj0yaZy9nEAmonrYwH0HXdmLqsnjLA6NpepM/AOZ41I/Acw0rNg==
X-Received: by 2002:a05:6000:1563:b0:390:e1c5:fe2 with SMTP id ffacd0b85a97d-39973b028b8mr2582840f8f.38.1742383180328;
        Wed, 19 Mar 2025 04:19:40 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b37sm20954170f8f.37.2025.03.19.04.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 04:19:39 -0700 (PDT)
Message-ID: <16b146f7-7568-437d-8ee5-f26bfb0354bd@linaro.org>
Date: Wed, 19 Mar 2025 11:19:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Restore {0} initializer since GCC-15
To: Leo Yan <leo.yan@arm.com>
References: <20250319110454.3230687-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250319110454.3230687-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/03/2025 11:04 am, Leo Yan wrote:
> GCC-15 release claims [1]:
> 
>   {0} initializer in C or C++ for unions no longer guarantees clearing
>   of the whole union (except for static storage duration initialization),
>   it just initializes the first union member to zero. If initialization
>   of the whole union including padding bits is desirable, use {} (valid
>   in C23 or C++) or use -fzero-init-padding-bits=unions option to
>   restore old GCC behavior.
> 
> This new behaviour might cause stale and unexpected data we defined in
> Perf.  Add the -fzero-init-padding-bits=unions option for entirely
> zeroing union structures.
> 

Do we need this? I don't see any unions initialized in that way. In fact 
there is only one struct initialized with {0}, the other handful are 
char*s but I don't think either are affected.

Adding options that allow people to add more non standard code doesn't 
feel very portable or in the spirit of doing it the right way. Maybe 
there's an argument that it guards against future mistakes, but it's not 
mentioned in the commit message.


