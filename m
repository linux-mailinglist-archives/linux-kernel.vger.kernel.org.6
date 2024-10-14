Return-Path: <linux-kernel+bounces-363392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1F99C1BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122DCB2503E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9E214A629;
	Mon, 14 Oct 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XaDW9Hi2"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86512149C7A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891756; cv=none; b=aNow7Sz9lXAEW2xnUbNJQglgCCa7YKNQbNjMnCs9FAjDO29NY9t9QlJKiItNz38z4xg9GetdvZILsAJW67dj2hgFTr/SshUZQUIjeD4LIfi3FNiHwGO1cJQ+l/1P9Xgzp9LfS+fLQBfOb1KsmwKYdhcYivKuylb8qHmwKHhyAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891756; c=relaxed/simple;
	bh=ccthqq9Qaz/ka/xZ9c3A0h9XmyfDnbOxeCbGTnUBO6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GizEW6ha9pjPJ5Bq2eL3ojwRGogopNpv1e5D7PZLQfoPn3Uag9r3Q5KFpOlMp7/7PVbjUN9TmA8FTQ8GQyHgCK+m83BxFMNRnhxvyLWCkc7hizjfao7RG50ww+O/v3g7s0TuY8RIf4CBRGHlm5ZIez0wsg90E5sqoIf5ar6mSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XaDW9Hi2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431195c3538so26463865e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728891753; x=1729496553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9t4KOrJ/R0HIh4Oi2Hi2ljtMc3Xm34F35qmS10HV9mE=;
        b=XaDW9Hi2mauWDhSLYK4pDDJ/SB1WrboIzf53sq03O5Ggl06VIJ9nQhS6K3cZXDnGKX
         6u26Cxl5DGKscBSuINeWKWLCwBlwGjnFbkIXsORLhr6RgqI6neIboz48+IcsxRzH3lz6
         7E8L3LXY5qeZbnY1cuMXJnQKnso1rRsc6u4GmfTSVn0CQa/M+APVCOmhMELlqTIwnMsg
         CI65dK/FbZTY8c1Soitk4gFAFuaZ2V6ZcGRnkZqdUxNppENoFVn5+YOk2CJh8mgwKJsf
         M8rT0woL8rKDgKPTYWTaIktbAtvJo88kznCsDmGMv/JtHyZfQQMcMx/uPwlfPEjeCzpD
         gAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891753; x=1729496553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t4KOrJ/R0HIh4Oi2Hi2ljtMc3Xm34F35qmS10HV9mE=;
        b=mKoVox5cEF6cP5pTp7sAabtc8HwBx/aU6Jh43wDAD/oajp2XiCjCa3445gIDUmg5Iz
         SKxVRMF2xcP7bwMnR9xIO+eeJHstFssgDkSCgg0C69JP5AP6WCEk3lKnRraUYTxiJ6qP
         fTR9GHwJ9YDaVyAEu+2UoFgS1Tesyv6jwan1cXwQT/pU3H775+dRgbGsDVF002gHXFKn
         Q1cPPJ8FKQyz/vJhWdwkwP0K4Iaxq97Qu+RWNy3NEkRZRWGOHCUjYHSqAzYURKbc04j8
         Wsnx6nZ/Cn8/tbybjRyhBAN5bGQOp7/1XoSCp6AsRn839E4vsZy4rEoc2zlORF3t73aK
         4TDA==
X-Forwarded-Encrypted: i=1; AJvYcCXkBfanhoD+oihr9IxymQSSd3HjdH9wVS9hI3cLjM49kSd+IS12z44pyea3ufWG+TG+8ilqM2gFElDoe7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxajZrd0f7LW38s8y1tTDH75ll43EoDM2Swh+fBVJEUxlIRHJjm
	aLA9A+KS6Bby5t94awVg0kZkgpnC5IYfb03GuANZFmnzU4vfxCgJkj5kzPQ7fUr3FpINQ/WnWhj
	e
X-Google-Smtp-Source: AGHT+IHbXDZvx+hMnsX37MGPNRmvYyxA4A/oS77NNLdVzFd8ltXdQukA0V11mv2KDJXFzmsPPqd6Fw==
X-Received: by 2002:a05:600c:c0d:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-4311de0041fmr87447955e9.0.1728891752800;
        Mon, 14 Oct 2024 00:42:32 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183567a6sm112470895e9.35.2024.10.14.00.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:42:31 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:42:29 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Add Broadcast_AND region in
 LLCC block
Message-ID: <ZwzLZfrUqc3+l/My@linaro.org>
References: <20240718-x1e80100-dts-llcc-add-broadcastand_region-v1-1-20b6edf4557e@linaro.org>
 <39df7ff4-7f22-4715-a0f7-eb2475bd7b55@linaro.org>
 <Zpj8cWfcqYj8rUOP@hovoldconsulting.com>
 <ZpkOgpGCKp/w13la@linaro.org>
 <ZwawkF17sxYRk_vC@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwawkF17sxYRk_vC@hovoldconsulting.com>

On 24-10-09 18:34:24, Johan Hovold wrote:
> On Thu, Jul 18, 2024 at 03:45:54PM +0300, Abel Vesa wrote:
> > On 24-07-18 13:28:49, Johan Hovold wrote:
> > > On Thu, Jul 18, 2024 at 01:20:37PM +0200, Konrad Dybcio wrote:
> > > > On 18.07.2024 12:20 PM, Abel Vesa wrote:
> > > > > Add missing Broadcast_AND region to the LLCC block for x1e80100,
> > > > > as the LLCC version on this platform is 4.1 and it provides the region.
> > > > > 
> > > > > This also fixes the following error caused by the missing region:
> > > > > 
> > > > > [    3.797768] qcom-llcc 25000000.system-cache-controller: error -EINVAL: invalid resource (null)
> > > 
> > > Please say something about this error only showing up in linux-next,
> > > which has 055afc34fd21 ("soc: qcom: llcc: Add regmap for Broadcast_AND region"
> > > region")).
> > 
> > Hm, now that I think of it, maybe I should drop the fixes tag
> > altogether, as it fits more into the "new support" category strictly
> > because of that commit you mentioned.
> 
> Looks like you forgot to respin this one so that the error is now logged
> with mainline since 6.11 and commit 055afc34fd21 ("soc: qcom: llcc: Add
> regmap for Broadcast_AND region"):
> 
> 	qcom-llcc 25000000.system-cache-controller: error -EINVAL: invalid resource (null)
> 
> Can you please respin as soon as possible with an updated commit message
> and a CC stable tag to suppress the error?

Sorry about the delay.

Just sent the v2 now.

https://lore.kernel.org/all/20241014-x1e80100-dts-llcc-add-broadcastand_region-v2-1-5ee6ac128627@linaro.org/

> 
> > > > > Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
> > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > ---
> > > > 
> > > > Please fix the commit title
> > > 
> > > And that.
> > 
> > Yep. Will do.
> 
> Don't forget to update Subject.

Done.

> 
> Johan

Thanks for reviewing.

Abel

