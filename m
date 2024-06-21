Return-Path: <linux-kernel+bounces-225321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7830912F14
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32A828553C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575017B51F;
	Fri, 21 Jun 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsIx0lbm"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE898155A57
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003672; cv=none; b=nkoH6PYpFF10mKKW27zXEdTj9mf1P+6mKfVhdFoVf/CSNs26oUFRaQRZyCV3jPedrFUpPsHiqsKo+w5xJ2dXxF+ijRUGnFkR0jyslVJp5bkRW3C+Ul/JzvR/EuyW7vkRn8uCQ6ZEB6m0klvIUfEite2pP5NIDq1qgBwCLNgEppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003672; c=relaxed/simple;
	bh=r1NowRJipfzB30i47UKAvLVjWIfE1kpajQsXNuqHCzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nojwOpTyl4rYmok5ba+akxhCDaVf7M9FM5vLT/4sD/bEmOBkvIFdVqRRZWFM+yvVliigSRm2aXaqJ7+Q3UZ1g0/OkD678szQH9250kBoHuKTzwG5Ce4dEAttbywoBX2lhG7uv5V1VHfgktMU80GzHKpxTk18Vn829lPDtGj7qwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LsIx0lbm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so1113018e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719003669; x=1719608469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MR0pq37AFaUSgmvqO3ZUjRvaH0Q8OniBl660xU6Kqts=;
        b=LsIx0lbm3GldOWpV5zcGt4iMMjm5jnNypwcWCJZ0FX7XFmyo9DY5PiBf8FjBLpcS6Q
         JamSA8v+D8P8b35xgvlkR3iVyrzwApTjhJwyDF0i7Bv1a9mLEjHOpMiEwlOHEwuoP50k
         AkUOTCUdJ26yNWKngwaEEemHWvKjWGkA8bYdVHjJICPRgI5GX3a1HuChNtqIanxTtD8Z
         y3bEgrfKFokwh3TESrn1OO05rHZsgG4ufOCC8K8kwUIYTn+kdWzTaXw1TyhyOmC40lET
         /5rnWuN4P9cD4t14R9bkIgleckqdemfiB+48EnisyA0C+HRY8L47/Hdblf/Oiks8mZL7
         KLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003669; x=1719608469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR0pq37AFaUSgmvqO3ZUjRvaH0Q8OniBl660xU6Kqts=;
        b=IhFFnnxfJtDVorAlzu9qftYNJ2sZnNEJYzwEGiiHsFR5mjMvJczD0NxSObjnz2bWFw
         vzlRw0grBCiyyXYK3AZVeROtkEidldgxnPh4Ijus6IKp3TKbdlUVwDTSjLNKsjciLyJF
         a6Kq7jhBiKHHUghohsrOS0sYvCoZ5cI2c/LLZ1wmc7bcU8gbUK4PYBy3GTtkoZlA9xoV
         ILhSJ3gHsFEPle6uhld53u2pKpPiVz53n23fLdpT9XtRyNKLaeXXMakkcJePGzbRg3pC
         ZPw2+RPnIybJFXLmcOL3olBhWXhUO60if5xVp4FQRixKYcvF5znLttM+o0OJl2vSHWnn
         SgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTAD3LJdXcQlvNlKZ51kRzirIMQ23JWkwMvjvCr/MfStc2lUHE2+XZXWnQP2grvVMriVi/2vPkzClIcwcMp3mZdvigCmrPNScVfIMm
X-Gm-Message-State: AOJu0YyhdVnRSUdX7yaMfew/6tcgciu21Inc2Uj0hIyMk2jQcXCEqfTU
	FcIWSCYLPZWhnyft+mXUnUCQqae3jNymwIfsvvZBtPBCyTLeA4l+hTTQ40hjOBc=
X-Google-Smtp-Source: AGHT+IEEW5ijUuPiugCxz/kwSbiittcMaFfgfc/yQbBM7kgngVvBeI7F/QcSaPHdfkNWuZnR0+uuOw==
X-Received: by 2002:a19:2d4c:0:b0:52c:d96d:7b4f with SMTP id 2adb3069b0e04-52cd96d7cfemr1352156e87.40.1719003669028;
        Fri, 21 Jun 2024 14:01:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdb4a7215sm170809e87.171.2024.06.21.14.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:01:08 -0700 (PDT)
Date: Sat, 22 Jun 2024 00:01:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Valeriy Klimin <vdos63@gmail.com>
Cc: ~postmarketos/upstreaming <~postmarketos/upstreaming@lists.sr.ht>, 
	phone-devel <phone-devel@vger.kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: qcom: Add Sony Xperia Z3 Compact smartphone
Message-ID: <4zpqdpeulfejfbnkp5prxvznohoqmdxcomztbbl6e3mazxdew2@tppmtxqxxpkk>
References: <20240621-sony-aries-v1-0-bcf96876980e@gmail.com>
 <20240621-sony-aries-v1-1-bcf96876980e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-sony-aries-v1-1-bcf96876980e@gmail.com>

On Fri, Jun 21, 2024 at 11:14:46AM GMT, Valeriy Klimin wrote:
> Add the dts for the Z3 Compact. This is currently almost the same
> as the plain Z3 as they share almost the same hardware and
> nothing device-specific is currently supported.
> 
> Signed-off-by: Valeriy Klimin <vdos63@gmail.com>
> ---
>  arch/arm/boot/dts/qcom/Makefile                    |  1 +
>  .../qcom-msm8974pro-sony-xperia-shinano-aries.dts  | 44 ++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

