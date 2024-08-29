Return-Path: <linux-kernel+bounces-306671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DDF9641EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F761F232E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD11A76D3;
	Thu, 29 Aug 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8PaUcA5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9F191F77
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927087; cv=none; b=VaJHhqVU1MLSuGlrgx+OXuz4Ns9kKMVat2+sC+elc86lv8UuCqHjWvoZTYMDPPNmGBbxgWaGD6RdJ+UyutWZRe9E7B/wgbEN5UVN6O961t5hqpjq8wJ8cH0MwxIVE3e1NmZA38M5KE42L1p/0IY5MWR6INkKha/Uizw5/76CzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927087; c=relaxed/simple;
	bh=85nAiCVJwW62QrE2b6r88lCjF1lPmNgCQtLklbdsK4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIAWBwI1qnI5QrlZS9zVJHqKrOyFNlfZdnCmabn51r8NkYGXOOOLx/J5ganvzxVqy63BUv6EcaHVBhDI5CLESMOGAitKLXcFsb3hanQVtQ1mvP8GVdLBiXEHgo9MFS84kJgaHiJ6vNM88F7v9sNdBRMkqR6N8GiWVTiggrJD1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y8PaUcA5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5343e75c642so629296e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724927083; x=1725531883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ/w73AaDcXnHgRTfa/18n3sPpKrgC+SUsJfs6EyD5I=;
        b=Y8PaUcA5moJt9cLegY3MzGmNXt1jn6nP/fptdePOHLYDlWP6mMxUeIx5LnjFiLLdS8
         D88yl3TiB9vksXbY+bWWnffkYyMTWdFrhdGSLCAt0jgrfcH6rFKi8xxX0ToDmWYh89xk
         vEVuH8zsnBDO1I52+38E2Ku8T73NuiBea3fzs4OiFe4WCzL7eOpHshFx2rPnRNLfjXvW
         Q6OdkOjERhVTzj21EyU/BuT0TKL77Ndpa6AVDjx1uq8l87yNiQDkPxmScIxb2EbQDT2N
         QzrAWHEmZnLileDmOAHppoJGLUR3Qq25xsWQYrqUABeBARydWIzyugts+PuZczmzxQL6
         /hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724927083; x=1725531883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ/w73AaDcXnHgRTfa/18n3sPpKrgC+SUsJfs6EyD5I=;
        b=sODHLP8YpGPSi5gjMFW35g+9eof6VLu6J4/vtAdUCVVOtBsJ66tG7tvPohXrHmigW3
         h41Sj2JoTWxvELwX7sAnfzbc8BIkw3j55tDkpRMt+hHFRMjH/IkyxkjgHRs6OvWtaRpl
         MTlmpMpAWQM+yoLanggjhW0+HWHtyu8qkeB31cxwM7/5E9HBVo58gm1595zPdaaLupMV
         qDd/z0ajhW32Gzt7ULREyrO3velZRT0jGMzK9DiY2vpQmYu/TWCVZJKMkKq0BvvhtdJi
         acNDQfI84Z4yqGag6ED3mA7E9LtzPv9eXgTZFPfEn9BSXRSaOpxTbrpJRQhfWdzwkFd5
         9Now==
X-Forwarded-Encrypted: i=1; AJvYcCWFRUcd9tP+T7kHEwGFEZJABCbKeJCBnfCt3VJk5GbBIgB93TltXgOl42lRBZlDW9gxIgL4Ro5f4zegyCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0IKfybQdrrGqq714auCxFbHEhr7CrLh263zJteFYXYStc3AT
	KNxSEH5B466mzSdxsNwNaQt3E8ZMhCD3aVUCUsMLlPdhw8aQ2m8Bkerqc1J90mc=
X-Google-Smtp-Source: AGHT+IFvU8hzzwqySK6Z6GUIQ8oD4NTRyF61j/91mZyR2mOx6xG0K5M+rBICRiQtcdWNMlY5YDmVng==
X-Received: by 2002:a05:6512:b0b:b0:533:3fc8:88b1 with SMTP id 2adb3069b0e04-5353e5bf859mr1504710e87.54.1724927082870;
        Thu, 29 Aug 2024 03:24:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540840f44sm117424e87.202.2024.08.29.03.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:24:42 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:24:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, djakov@kernel.org, richardcochran@gmail.com, 
	geert+renesas@glider.be, neil.armstrong@linaro.org, arnd@arndb.de, 
	nfraprado@collabora.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 5/8] clk: qcom: ipq5332: Add couple of more
 interconnects
Message-ID: <kscjtfse3rkdg2sp2uzxiueadf5l66g253vrahfir364yk57lv@jbk4qfbricxx>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
 <20240829082830.56959-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829082830.56959-6-quic_varada@quicinc.com>

On Thu, Aug 29, 2024 at 01:58:27PM GMT, Varadarajan Narayanan wrote:
> Update the GCC master/slave list to include couple of
> more interfaces needed by the Network Subsystem Clock
> Controller (NSSCC)
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq5332.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

