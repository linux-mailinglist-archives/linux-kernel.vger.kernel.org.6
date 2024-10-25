Return-Path: <linux-kernel+bounces-381558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170B9B00D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8B91C2089D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191871E378A;
	Fri, 25 Oct 2024 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSoW3J+z"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D71D356E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854288; cv=none; b=LocjBOjncxu3PX9zTWeahapS8lr/dBDPAC336CrLwtKypYGgGXdrUO2yn6+D0BZ7pYt0A9VAMmoO+z8lvxL/yB6pyZaUi6ixMei9bCPPCf8JOQzu+nUANOScsjMGpoRRtysqnRXiJhPHC5Qd6R3rQ3UJzIfsch3ue8gBECg3SRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854288; c=relaxed/simple;
	bh=f1oZLRWi1iceQY+AnZhdiGRT5xb+TXAIA7EVsI6RjVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhDGZkuC/vungEE0lTmajsEftSBmMHniMmjbJ2AkiguBhVW2ygUqPZrelhoyAyIGc+jZVNec3C8vJ7tHjlE41vmAzyBXFstIaiYb3nNuTde7e4tCyo3qxL6ONuIFIMXCH8Vi60SKuZFAGw05tUYB3zBhq4gCFi9pbz5LoaAnEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSoW3J+z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f7606199so2397748e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729854284; x=1730459084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0npUi/QQj/8hAzQtbz5IYAGn1L/kq6JvsHfxRiCt458=;
        b=sSoW3J+zOTlKtxZwUFGJF5GpSDAkz2KxWybEJoPv149b8Vqq2Q4h87j6wlAArPsvWE
         u/0uNPFF0DWXJv2SFjgPTLJhRPMHEf+IUeU61UTUGliDnO++SP5b3I5mhqvuRMgzkbfj
         AWsMRyo35n8Ci/JZXFxk8tgsIS7ogGt/QqJtWRLO8XrJez72DuLmjTX3f2hNdMbbwEGC
         ZC8JZ6wrZoeGbNx1Ompd67+WpPRakh4OvfCtC+RQjqHpf5UaEpiQNaq93Ir6nfLku4bf
         oCRDH6BO6O1/YUCvFFQJdDwHZGTjc1P1gyFOXIqirxSwcmL7qEM8hUtod5urWYvasoJe
         VolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729854284; x=1730459084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0npUi/QQj/8hAzQtbz5IYAGn1L/kq6JvsHfxRiCt458=;
        b=dKQAUzoETEaZ9HJqK0fVhe8FeEzjkJAwMY28f3CVAomb1o3XIGwBgCD1RlwVbKIxan
         PjiP4msPo29QQMdHYo30CWrKglhikwkeGPKosxQN1wt6VvCydU/0j4WJSxoY8ASBKV5x
         bWzecqUoAKLRZ9Y6XIJExYt1cjCnKlpS0ndp1uOj7e2L78XaNarRCbgQM8jIcjPiFnGg
         2r6I6OTQhyc19pZrSrMQHJz2AbtL+VGwV2htlpjuS1702e/EDrz2qBljlqdEvy9ImhiH
         YOdBrCVBvgUAZzF6bow4lxN5Yl6y0XjncPD/OYuTxPCLiilq3hHNX6H2Oc6uk0Kk3kxK
         RvQw==
X-Forwarded-Encrypted: i=1; AJvYcCVZrd8F5REfbcuu3F3J5rGn8NFf0AmNdUiHWKx4H/UnRw/4AcO5BXm2YGmqgaoSPsvNSlAg8BZs22GHoo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOnzi9RCzX3Wz/PlSuiR1f3Mdo0zRvX3T0/VuiIQKfJ5EXmcB
	fOeAmUOfIJ1aUGX3Rlw/SfOT9JlntObqtaEXngt91Xb+nyTHmZGnNRhlXBbFqmI=
X-Google-Smtp-Source: AGHT+IFBLlidK1lSRc4guNpkuXJCSvMxBnTQgcK54ic6c+sgh480iBRvsq4Il+3SdkKU9IlNSqXOpw==
X-Received: by 2002:a05:6512:124c:b0:539:f699:4954 with SMTP id 2adb3069b0e04-53b1a39772bmr4551085e87.58.1729854284214;
        Fri, 25 Oct 2024 04:04:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a555sm138281e87.34.2024.10.25.04.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:04:42 -0700 (PDT)
Date: Fri, 25 Oct 2024 14:04:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jiajie Chen <c@jia.je>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Add performance hint for
 boost clock
Message-ID: <dbnc6kq2heyva2c4c4bt6kwo62sifi4kws6nup7etnnyyzawes@uag66bceq6is>
References: <20241025031257.6284-2-c@jia.je>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025031257.6284-2-c@jia.je>

On Fri, Oct 25, 2024 at 11:12:58AM +0800, Jiajie Chen wrote:
> The x1e80100 CPU can have up to two cores running at 4.0 GHz, with one
> core in the second cluster (cores 4-7) and the other in the third
> cluster (cores 8-11). However, the scheduler is currently unaware of
> this, leading to scenarios where a single core benchmark might run at
> 3.4 GHz when scheduled to the first cluster.
> 
> This patch introduces capacity-dmips-mhz nodes to each CPU node in the
> DTS. For cores numbered 4 and 8, the capacities are set to 1200, while
> others are set to 1024. This ensures that the two cores can be
> prioritized for scheduling. The value 1200 is derived from approximately
> `1024/3.4*4.0`.
> 
> Note that capacity-dmips-mhz is not ideally suited for this purpose, as
> it was designed to differentiate between performance and efficient
> cores, not for core boosting. According to its definition, DMIPS/MHz
> actually decreases with higher frequencies. However, since the CPU does
> not support AMU, and no elegant solution was found, this approach is
> used as a workaround.
> 
> With this patch, we observe two cores running at full 4.0 GHz without
> core binding. The single core score of Geekbench 6 increases from 2452
> to 2892, both without core binding. Tested on Surface Laptop 7.

I think this is a nice hack, but I'd prefer to see scheduler being
improved instead. From my (ignorant) point of view this should be close
to SMT-based scheduling. We should split the jobs between the clusters,
if that provides better power utilisation.

> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

-- 
With best wishes
Dmitry

