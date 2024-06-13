Return-Path: <linux-kernel+bounces-213003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17BC9069B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A31F1F245E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB81419AA;
	Thu, 13 Jun 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+jejdCP"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1BD1411E0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273441; cv=none; b=Ko3e3vzVd/hhi+/n00veSGavkRZ7Rz0oy5W+pCtstpOgTeC6AcVGSxFz4aEn88XibCC/K34S+vWDD2dzelv7mdEu/nwILOBoEXHoG7Sw6UNwJSy/0ro6bQHDnfbh8nLqD13NjdsuC2Zw75sO0P68887CkEMMr0zJ49NOhZ28eHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273441; c=relaxed/simple;
	bh=mOMZE1BImQgQqVos0pSrYVwUrtiIOEk/BT5krayXtjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIWVNVuYnTQq0RtbCH5hzB+SG5cXise955oVKV0eZbnGimwKLUx1iiYiAXZFHEdJXPez4UfnsejNxIRN419NeK/za39ljeSHBJ0qgOBGIJBsWVsDpueg3nzrIewg7EfuG1JRz1XFXLteaaxP4n+NBMU/dFAnCA3D7r1i+kMSYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S+jejdCP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c8c0d73d3so1050572e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718273437; x=1718878237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOXzfBQPF+LHXjU6pXBEMJF3WvZiisnuKFTk0ZYuAo=;
        b=S+jejdCPSgiDz1ZDqAOPS79cij4ikRaQJnFPWZjdD6wTKuVVopRz3lllO8SKqrvFSw
         C90yFR52ZUGIC0jUbbhnFrMnlGlJw2Rb7NxesuEnfpSPlotY+yvJbQkmKJLZBR6MxRiE
         rROuYy8ZlhB4EEa7viqg/m7j/qZ5OjoTPN6qMxxzgCfv6PNH4qg6xNGwyfKbValyW/LL
         KQ6omeOHDMuupUUycGOIoea0n/vhIJIND5ooye/jIqWVIy8A/3WbkuPnVyHoG/3WXX5l
         gFnbiNT9GeExEqiCHSl77azExi6zvAVccfQfR/TbFMaq5WWCzZgevXbU5Ev5FhxqKuOM
         Biiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718273437; x=1718878237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnOXzfBQPF+LHXjU6pXBEMJF3WvZiisnuKFTk0ZYuAo=;
        b=PmGrfpg2snawJ9WqcX5k1UiYZZXYNjATU7sO9oJ4m5nNoJXVRdXiUGSCCw5Y62R3sO
         LXqXboF1tHMc9R/SiIuA6/ZfpnTLWyCWJuIaA6Mg4+KlMULZfXAfPdgBhWKXyB9IfnjO
         C93Yj2Uy2Jb5IXojF1Nk9kdcihWusH9bIukWJwHY3DnDsuXgirX+FHinnvlLAmi6+JVj
         2DSf11IyQx0iz1m1asM7J+ZqsALeIWtp/9hCwuBoCxVA09MkHKQE85Hife6LKL/9Lib9
         TwW0zIG5VPRqBtJ0vJxR1Bo74jib5ajpzYwsZs7Aamhyi+vtaeHni9YD4zzVb9QM+bHA
         3ttw==
X-Forwarded-Encrypted: i=1; AJvYcCXWF84p/f//DRaTbE8eti6sUkPdw2qKb5b3idYgaxsaFCDi4T8PVTOoh7FF1HOXPuv2hez3pQnowmOGmRq9OHP6FJjOtRYsIvDPqsyh
X-Gm-Message-State: AOJu0YzktI05qvsRyjeXm2hpaNcBKLuZKqbxQ6vFDmTWapyCNLIqIcUZ
	namw08L0TrUXfMyk7bdW1m5LtsjWjvqi6wYSloqHrprv75tq51Wlyng2OywvYIM=
X-Google-Smtp-Source: AGHT+IEnmrWgnM5SGxICW1vWwc2O/mTW96VNMeI3/JiExHdDPaxx2NlTGNeh1bZrVaDWkM08FDbyLQ==
X-Received: by 2002:a05:6512:44a:b0:52c:8a4e:f4bf with SMTP id 2adb3069b0e04-52c9a400d27mr2332640e87.51.1718273437098;
        Thu, 13 Jun 2024 03:10:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287ad17sm146604e87.225.2024.06.13.03.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 03:10:36 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:10:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-crd: fix DAI used for
 headset recording
Message-ID: <7rfoogp7w3gmtyawmil5lilx4blbpnb3nzl5tv2onydmzblcqw@qooqesspnrp4>
References: <20240611142555.994675-1-krzysztof.kozlowski@linaro.org>
 <20240611142555.994675-2-krzysztof.kozlowski@linaro.org>
 <90f5ad41-7192-4c01-90c0-ad9c54094917@linaro.org>
 <9e9cbc0b-f9fd-439c-93d1-054179f7b07f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9cbc0b-f9fd-439c-93d1-054179f7b07f@linaro.org>

On Thu, Jun 13, 2024 at 11:11:05AM +0200, Krzysztof Kozlowski wrote:
> On 13/06/2024 09:45, Konrad Dybcio wrote:
> > 
> > 
> > On 6/11/24 16:25, Krzysztof Kozlowski wrote:
> >> The SWR2 Soundwire instance has 1 output and 4 input ports, so for the
> >> headset recording (via the WCD9385 codec and the TX macro codec) we want
> >> to use the next DAI, not the first one (see qcom,dout-ports and
> >> qcom,din-ports for soundwire@6d30000 node).
> >>
> >> Original code was copied from other devices like SM8450 and SM8550.  On
> >> the SM8450 this was a correct setting, however on the SM8550 this worked
> >> probably only by coincidence, because the DTS defined no output ports on
> >> SWR2 Soundwire.
> > 
> > Planning to send a fix for that?
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Not really, because microphone works on these targets and changing it
> would require testing. I don't have boards suitable for testing, so
> let's just leave it.

If you provide instructions, I can test microphones on SM8450 HDK.

-- 
With best wishes
Dmitry

