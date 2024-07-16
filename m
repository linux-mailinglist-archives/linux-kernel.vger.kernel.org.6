Return-Path: <linux-kernel+bounces-254089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A94932EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09961F22F94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0B519F487;
	Tue, 16 Jul 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJ7Bu25y"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB119ADBE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148619; cv=none; b=AuhxeEtJu1pFGFP3OOqn+pLpF4MHo1j4EVHFzP4EUw3yCTOpl500ntZsXVMI+7e0low3N+biA23atqBlCIIcXQv5JXVak95ozfbxHNpwg7Tw6m7Bq6GEt30BN7EtNb46R+5SKc/FUaDPhsbKe2tDWnUr4yq0Od4PQ+1gt3n59Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148619; c=relaxed/simple;
	bh=n0cRdUVeuF+TPdkHtAJ4MrKQwsxnoyftuba7ho6uPoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SREOxc7zAwXJvkD5hyH7S54DRI8FzIUi4AY5nAxcnbVzBvUtjrNPej21A1F05crXytN3J0upT7YeG6Bhyh9JyV/4EbYmxGKNc7Rh9kjwbYUcReDHCxrp7kl/8bEZ4X6fZPPL4cDyvRXx5BTYT9wqgJ8kxQtEYSBMomdBbeE418c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJ7Bu25y; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eeb2d60efbso71352711fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721148616; x=1721753416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CutzVZbBuYdC//uAM2GMb6dlE9xUeemCkZXQmoieiZ4=;
        b=aJ7Bu25ydYMLDDnQ6mlFbjYFtDkUxHaHq75sn0yfh84JMMYOE6MKwOHDSMPa1lhPjL
         sU40m8vHvUEIwHgDwbGJpRVhDHv/yxiIOpdQ09rzoR+1sAJnrS/5oGrpBCPgoqm0Pd9l
         TE82ISbfmCZH1p4wbJvQTYD1qmqJqcKzw2Kw+6f+GQg4oV1Kez7MtcKJTmfWrvC6EF3k
         85BIyB127AMa1UCuM/kvMnF/e3HHf4L2SplJZKWsqWqttvAsylcaWIJsIitbgXJMPA4H
         xTW2CN80Xb8AeD5mDjnExyEG/uTv2jEP+YyPa8VVCHtnHMdb3bMi7V+uMiNOM6c3rfCG
         7vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721148616; x=1721753416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CutzVZbBuYdC//uAM2GMb6dlE9xUeemCkZXQmoieiZ4=;
        b=tPngus3cauaSJ0ibg8uQQrjMbdyJ1znvBOqUoqeChId8oTDS5sopIt8sU1HIQNkvnW
         620kXF5O8Zdi8srWRRI99Ar571m1gMz9ibN4hfH5jiYzwTbVGwMxWp6m5jo/cPHdsnLe
         P7mBJLMMFPmkRcT7Xu4WEGkkL8DEf9yYS6fBwVPPkora37Gf6KFaw9AKzcx6dtgE9GSk
         nwHu4Fs5XzgNo57GMkM2nrvt5NaVO37saSPaApZXwkP/W0ATJH8dHWEFlCRMtTIhBvsE
         0TYp9JSK3QwYyRgoI+5p6ywj9n/tkrTwyeDEcvc3gxz9II/X7+4SITBxVPyMdUbI+JJI
         94zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrJNueFeUFoLFo2A9exC2uDvdUklkCVdhlhEpyHrjRh27XWBdbwV3GTPHiKNwz6dqcXKkCi/vIQuyeJupAlMTnzJzJgCaHTm+1VmFR
X-Gm-Message-State: AOJu0YzIMcVhPYbWSIghNSpGnBopzqKaOX1L3sW3H/tQMl0zcDdQw4rS
	0avXGaiPkOnFWeA3dIWbFv9K0rQewn1fR/UnI4BAGjoRE+JCdjxcoqpOlrGG5J0=
X-Google-Smtp-Source: AGHT+IFNzQ6RluIrtq+29sTh2FoWPSICVDmNlgUVgLB+IhIvuT8dnx/WROGPT1B/1b2kj+htKCGLUg==
X-Received: by 2002:a2e:b911:0:b0:2ee:8d04:7689 with SMTP id 38308e7fff4ca-2eef416e131mr19983111fa.20.1721148616368;
        Tue, 16 Jul 2024 09:50:16 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eee1914abesm12155871fa.84.2024.07.16.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 09:50:15 -0700 (PDT)
Date: Tue, 16 Jul 2024 19:50:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rayyan Ansari <rayyan.ansari@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8939-samsung-a7: rename pwm node to
 conform to dtschema
Message-ID: <vcqlsi5d4eeejlh6ihfodkvsw46vxg3av65lhczqacwqljlj2g@4folnrsvxrg6>
References: <20240716135339.87192-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716135339.87192-1-rayyan.ansari@linaro.org>

On Tue, Jul 16, 2024 at 02:53:38PM GMT, Rayyan Ansari wrote:
> Rename the pwm node from "pwm-vibrator" to "pwm" to conform to the dt schema.
> 
> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

