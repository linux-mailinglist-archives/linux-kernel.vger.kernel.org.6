Return-Path: <linux-kernel+bounces-361218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC27B99A529
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0B9288C17
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022761D52B;
	Fri, 11 Oct 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0BWlzPG"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2021859C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653757; cv=none; b=SxK9m2hNZEqWcBkNzQyOY0WCAiUPaE4CctXLYOoVJQtJVBnZovU7WU51BZvgkpcikXzWJDFq8iBiqNSHWPV90T07E9agjfsygqf1fohV7wZv8heEtgwFcZyI3h0sAto52C2Ba0xlSsY+doBIHkSF+JWfD7WG5QX2AcKipdwpHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653757; c=relaxed/simple;
	bh=OiPjQ8MyGaquQDLyi6YQldxdwNs2wiBntXh0rQOlR2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkyW5cy98Czfo719yxT2q6lu6db1dM6ouLUzyPgP3N4+rGaQAmiOxC80wJ4bSTAD0hAVnIu56WJVjXI+Oml3TsA43Rf73VyIsHNR3jQwvqMo+uEmuspUoOWVOk0eOUYosANsEvMpFRnmD0ocEcxs+NIxGC0vhp2VRATe5Ma7bW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z0BWlzPG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398e3f43f3so2344703e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728653754; x=1729258554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lee9T2avC+D5UCI93ZOX/tuQVshXYhIDmaT3ML/ypgc=;
        b=z0BWlzPG3HnoqW88P3mSyqI+1tcuxJDfoQ4u1tSARQdKdCSjv0/6f/pr/ECKS3Gdjc
         EmIYbkahB1HT5kxjBD1PdreHwBRNw2E8YZCGeNsp13bkqFYGAWy+8/EXQYbIF28LRstp
         h7/jb8tdXijbEPJGxHowK9+QX2ryl1ToE9ZiuOgEcIgbJ/x6HPAWL1EtYmc3o9S91YB9
         cPxduth+ccBapVWd8BNTUPci3RnNZ+KmVMORR8C+Lt/7msPAMjPQz0OtEctWwK+7Z81n
         i7Xz7NGzhM1vT2/CWBGIM+UBkiodesppMVVteaMiSAtaSLudP8bXPiMDgIf3ZuSkrPwd
         nh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728653754; x=1729258554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lee9T2avC+D5UCI93ZOX/tuQVshXYhIDmaT3ML/ypgc=;
        b=ZZhR5O5xfQ1mLTUjKv3Ii4Y5sJxb3Dcq6PmYXSDn0N8TEVa+3bvbpnfwUNGH0CrFAP
         dkL3XjTLNXNCQxU6VRib4dd+XU0Vw+JHRHOs24WtNIS3y7ELDx2D0ANg6koESNlPD9Q5
         m9DwGAY8jdiATgWrCIbZw2hB4DqCv4jigFF9YqOq1GcQdYxZ9dPPqGbIapfxvouOETsv
         RqdfLJ19qr7amtCEfnqzYjZb/RDPipwVJZHOcEbkodSJ+t9i21z5b+YmBWcQbcmTWlZJ
         W80UU1C5FzsbKchs2BBgBPdyXgVaFAj9DzIfYnDRRetrSOXiPWWIK8IU1s8+lnPfM34t
         JV8A==
X-Forwarded-Encrypted: i=1; AJvYcCWZojSi7MXkxM9nUdEJrkq5JJE+li+Y9knGnONHYxyC2NakR/cYWjgyNTh4h0FS2Wqs2XQd6hCADvCLXCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwagRm6n6AlJpCt518kZAjLvkOTh0LhMK1X8vcP3ok3x+n2BpV4
	F8mnp4909dux7scXN4uY99ojgkgkGyzDJP0LOEH26DdUWjorgkhLMFB8nfqqrJnfwT4y8aMUizo
	R0vU=
X-Google-Smtp-Source: AGHT+IHgnh35xStpY2heWGmKZStShihyLmI1pL1o2CwQht4HKacsYK5EB3VbxRwl58nlG9lgbQbteQ==
X-Received: by 2002:a05:6512:114f:b0:535:6992:f2cb with SMTP id 2adb3069b0e04-539da586e45mr1410695e87.42.1728653754028;
        Fri, 11 Oct 2024 06:35:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e2d5adc2sm84809e87.302.2024.10.11.06.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:35:53 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:35:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 08/10] remoteproc: qcom_q6v5_pas: Simplify with
 dev_err_probe()
Message-ID: <qfeegspfgaxccc6zu6oyrhuhze2kejw6k46ovgea4557tlcnc4@gs2c2bgb2cpx>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
 <20241011-remote-proc-dev-err-probe-v1-8-5abb4fc61eca@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-8-5abb4fc61eca@linaro.org>

On Fri, Oct 11, 2024 at 03:09:16PM +0200, Krzysztof Kozlowski wrote:
> Use dev_err_probe() to make error and defer code handling simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

