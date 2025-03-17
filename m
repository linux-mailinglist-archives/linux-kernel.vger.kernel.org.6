Return-Path: <linux-kernel+bounces-563874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B1A649F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AE818848F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483221D3F6;
	Mon, 17 Mar 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8meO48B"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4A71A08B8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207210; cv=none; b=ZFgGCSLMp5AKkQUrTtDU32HAFipq7oC705ErkS3+EC/+gSoJdt8cmBzRnbmdqhcPUxcpguCJjTss+IOPR9an8SxLeO5CkKVUl9kh59TNRwjpuP+fQVZfBLKSR8Bo7yALpC7iwA0Jx7QbM1/WDcpQVliXknUJ+5m38d1MMhr4les=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207210; c=relaxed/simple;
	bh=dLoz0EqgH+2ayW70DkHm7D86BlzG8oHIxB6X0i+YFG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmAO1tvtR1vVmUrg/lWWJAwRdnr9lzINqfkTPVm+oUD1DtXRDQCKTQJNTwRHkaafMdJOa3wAjd5St88WYZwUvvCdwpKQPJFhBF+ac5+XmZKXg4iCA5v/qRvxv2YB0iDBL6xo8+Db7KYLKivqR78vJ1NfkEilmgEMEphlPwjx4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K8meO48B; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso3272862f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742207206; x=1742812006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvPPPRDaspsoA4k2Dj6ph9FjCMOMwv56adQmuxz0BxQ=;
        b=K8meO48Bv+liNADsMllxVSaQAKrhHdmZDzGlE0WDLMGlkMiGwuj6M0Fes6Y1+SlxKa
         FO/2TIEQK+ffHp16umiceR1DCDJBH4YkNBhFCcVG3V9YXf1qhO+qtSylmVG4j+e4x6Iq
         vpyphuZHWnQGG27YnrMxdoewpuIpc3E43KW1FJ01oer1+1BbeAlWAvTHlg5ufmMTw14H
         PqcIS94ToFobeeQ4BdPWRJWlep8P6LLjMm5vE7caVfLC86k4NnES4mVFJwl6zMJ2UfSq
         Xh1HugZZaFwVkEpkBhjAtK8jwlOjAxnXJXcF2aS29k78Kr07lA4Ga9wdDgOmztafMuuo
         82cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207206; x=1742812006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvPPPRDaspsoA4k2Dj6ph9FjCMOMwv56adQmuxz0BxQ=;
        b=FJWNDDefk5irH49rvn21l4BCiO6bkHIQFeXsYMgJj2i1bj2bNHqkxyYM5Valo3VZEy
         1a2QDl7W4VTDlkO6n7U6Ji5t8yyfg7lV/GV+VsgjUTzdzCxD5/RAEHJ+KqKh4/7R+P/7
         VSU+fI7ZOZ0yHbPKGg2xQW/nzY2rm8jZFe5M+JracVeWfg6G3+eQUQItuOPpq45sqy0e
         MzY7ipape8flfdi53eoVkPBKXW6et6U66onFcmpPCl3lXFPGHvT06YCWEr6eHS84Oxwy
         2fcWyDLOIpTcj73fAh88unNIkY5nuT62sNmDKYgwJJfj8bP/XR8HTu5L3SrdVfJ7vxWc
         KuXA==
X-Forwarded-Encrypted: i=1; AJvYcCWE6iYFBA/aom8PZXGvnGXPaR81iviNON6hq5Ay741Px4BFZWrWjoqZpuyyAOA3vkFXFmsi2qWTYPMdUCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10vf2eLhhVRY8dEaQcOuzeftS2RfD3qjVbLJ//ckUZiuiwgOa
	ptgM9YnQOc50M7Gw14VUJd7ODUqbSKypN7EEJDAvDYxCPZS4o2YsCRF2QhLIlME=
X-Gm-Gg: ASbGncspmfe7PvRxIyHqDy7ryr5Gc4tAWpALg1g4Km6G/3pjbGeGiQI1bJaRPWpi3N8
	JHSr7NXc6HmwOWuhQe6NuTsGNNX8JHmPVsTww426oFd78XvyJu1FH1LCYOyZLJtXgE0pvSqge0I
	D+FDXu9uYFJCifvem+bNpLw8TJP4QGcfAeO+XbfVcUM6KZwzlFUqgK86KOWUjDUVhA4TShRIRE5
	GE6ffHVIaXKaL3YFCraQ1L5AymsfmBiofPSj+dVSHsAJ1Cl6Gus5zNPq7VazJfhTu9x0W+6Bg+i
	8oFzFNGIYNLANBM/TtnLrp7YxN+EPb7U8JcTWZNO+ZhLIK2y1wk83F1TO8AKJuUBlUVA5tEHo44
	P7pZYtv4Xj84NZKRKTOY=
X-Google-Smtp-Source: AGHT+IEl2lf5EodXDcMOp4zSumpDeUgpvHv7ZiCprUcc+z1261XnZYzYUr5LHoaWJbWt0CgfV/KCKA==
X-Received: by 2002:a05:6000:2cf:b0:390:f116:d220 with SMTP id ffacd0b85a97d-3971c97ba0cmr10611286f8f.17.1742207206352;
        Mon, 17 Mar 2025 03:26:46 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:900a:ff00:eb98:2c37:6a77:39? ([2a02:2f04:900a:ff00:eb98:2c37:6a77:39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3506sm14950791f8f.11.2025.03.17.03.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:26:45 -0700 (PDT)
Message-ID: <638cf070-9fd1-416e-8172-75f189ab0dfe@linaro.org>
Date: Mon, 17 Mar 2025 10:26:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] firmware: exynos-acpm: silence EPROBE_DEFER error on
 boot
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250314-acpm-fixes-v1-0-ab03ca8e723f@linaro.org>
 <20250314-acpm-fixes-v1-2-ab03ca8e723f@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250314-acpm-fixes-v1-2-ab03ca8e723f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/14/25 4:40 PM, André Draszik wrote:
> This driver emits error messages when client drivers are trying to get
> an interface handle to this driver here before this driver has
> completed _probe().
> 
> Given this driver returns -EPROBE_DEFER in that case, this is not an
> error and shouldn't be emitted to the log, so just remove them.
> 
> Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

