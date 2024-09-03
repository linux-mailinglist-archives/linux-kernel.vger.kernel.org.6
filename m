Return-Path: <linux-kernel+bounces-312556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA71969829
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EC12872D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED41C1A3050;
	Tue,  3 Sep 2024 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJ4nHeFU"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D919F42B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354098; cv=none; b=lUFNEBA9vfuj4OOHkjjMDTq5uNsqZErrfDGqiw9h7D8+gJfHyat88ZftsFeUTmj/tL89ezbpTBbLKdao4O2U94p8oHRZuOBq3Pqr/y9/KeorgDXoiYwxw8lkshk0bPh6n060ecTsmzqz/hDxap1mD1Lg8NhgrY2f5JAtuP5WHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354098; c=relaxed/simple;
	bh=XXc/crLCNHxzSDDZAy6Ddze/85mA/zk8QXL4gwHqt3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/wJ1yPhQR1tCG4vmmmErpxauNPuFoIIt+3h7lADvYqrPm8FfuTWn2Yzq8i+qcwyioRzccG2+5o98OzO1eoFYjf2A7kt+kaTYWmgxP/AqvJOVpXJB+IWIQ3FVcuON6gtGmU3vRf3fqO/2eoI9fg0RNYVZgV9ElWgiHTg3e2WZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJ4nHeFU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8b96c18f0so1536563a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725354096; x=1725958896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwokYJJ36zRTwb7Es++/p8+iOX4crE17pq6UetC4fjY=;
        b=MJ4nHeFUi0xDMiwI9XuzFqVgEPN79IcIFcczV3Enr/d4bfMPvzg2rwSmgoRRqBtCVk
         czDGfda94LEulrdcFckapJqmwkBCVm/SHxmhy94CiugFxQbttBndP1NXTO7iMfnthdqv
         Ef5TothsreELnYucaCnxyAo/GQe7SE3XtYdthepXzqaFRPEPhdkAKllYiPHSMUwnYYFf
         hGlqWtikPI3XYfPQsQeMUCPtkS+MMjvwCEiiZTPgckvkXdt0Hq9IkZWynpqtMY+g/H0V
         hPa6wFHMYimJe1iK5I1qo+U0tIDFIdUjsXS3Y5eUGSg8mMPfxR3xpqKGaC60LrknqUUF
         1hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725354096; x=1725958896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwokYJJ36zRTwb7Es++/p8+iOX4crE17pq6UetC4fjY=;
        b=RRJLWlHjBN8sIFgRYYgsbHNb4BqfACekq6Dk+IeIDxTyw5XR+t+ZlpXYVp/SAivTzW
         TlyovlrDaFi8/PFv5CHp/+ZGkC4ceJS89ix3zVHhu0zoCIO8zNr5tQC0XC7SCpOTod00
         e3+w7L0//OAXawRa6dgRFangGc/11YnqNI0NOV5CIeEVHFvlIIw5+ajaB1PFM1vfKkCL
         4zH4Sj8Zf3eVoYilnV1nBXNhvTUVkYWKt0xIeOjY8Hk6hvdnnWweaQtQKmerogBfad6X
         O/2XdFT0QGkwdmUARGsiqJ4ityDSWioApXLkoN9FbYCF+0v6IIFJTz1Dm+dnMhJYFrwG
         HFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZS5q24FU4Ds/FOdqpO+Wa+wnIK1MJYMLcv9GEVcFAuURWlTGbwq/UQ9ydUAdgvwrRilT2gw3KxLicSB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymnmyuWB67kdi6ofLN5Td2LClFnncR7CHcU5/e5CGb2GlqeE1T
	Zs2iAPRSJQ5ystieme6CP46WG23Ximr8EWP43it0CjmSxqF3DQ9t0qn84lP4zx6GzwG8tHiuDsX
	N
X-Google-Smtp-Source: AGHT+IHpyFwad5VKly9RnWl8Lsn1HCK4hUN/kvD8gp4deaWLKbgiLnxTpU8gsD2DZXdwowBQlTervw==
X-Received: by 2002:a17:90b:4b0a:b0:2d8:99c4:3cd9 with SMTP id 98e67ed59e1d1-2da7482c876mr189982a91.3.1725354096268;
        Tue, 03 Sep 2024 02:01:36 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b119b3dsm10803545a91.13.2024.09.03.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:01:35 -0700 (PDT)
Date: Tue, 3 Sep 2024 14:31:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Xi Ruoyao <xry111@xry111.site>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH] cpufreq: loongson3: Use raw_smp_processor_id() in
 do_service_request()
Message-ID: <20240903090133.tqmsitybuutzsup5@vireshk-i7>
References: <20240828062459.1853837-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828062459.1853837-1-chenhuacai@loongson.cn>

On 28-08-24, 14:24, Huacai Chen wrote:
> Use raw_smp_processor_id() instead of plain smp_processor_id() in
> do_service_request(), otherwise we may get some errors with the driver
> enabled:
> 
>  BUG: using smp_processor_id() in preemptible [00000000] code: (udev-worker)/208
>  caller is loongson3_cpufreq_probe+0x5c/0x250 [loongson3_cpufreq]
> 
> Reported-by: Xi Ruoyao <xry111@xry111.site>
> Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/cpufreq/loongson3_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

