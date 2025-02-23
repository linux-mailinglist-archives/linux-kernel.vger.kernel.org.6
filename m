Return-Path: <linux-kernel+bounces-528001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C1A41259
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8BC1892AB2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6052036FE;
	Sun, 23 Feb 2025 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkLVvf2k"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F310E4
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740354494; cv=none; b=uVC56gyP1QK2304WuLygX1otXXIsWLPdUJWsagijcMZJ5Wke7jSBW+4s4SO7sQusguoBoMgiLkoDTMx5RcM1v65tA4tXOOunI91+G0hMRJ4W0E3mmXWv8IVPV6lovi5SF1ekiHw7SnHS3y/YWK1PhQXtK8MLhIu7Qw7hUl1Co4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740354494; c=relaxed/simple;
	bh=yBWzsyr/XNm6UaYOSTJcDGaRT2g3B3VBzdxrx9oo+LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrVPv6wHvx+EboEvCXFlRBc2ftHOM2h4UAB62sOWVDsUpQtsXD+9dBFF+PDjGz6lI4mxwQugApG+/Krzbsqf/fw6v7zJNJmVTsM8XjxjMD9NdVntTDKIl7MMWE8KoHVma0OdN7uZyEK5MrFRoHeSzbC39ZXA20cubmTocbmsT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bkLVvf2k; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5439a6179a7so4285079e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 15:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740354491; x=1740959291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wcnMV7bCjw+onbQP13XkDfLLYTKBRINzQvJtc5RrEM=;
        b=bkLVvf2kXf166mx8Xgj93WnecWs9Hqun8jP73qvFhH62NFs2nCEvYFMudYBCk3fhAQ
         lfnGM1Z8vW4rjqnaQpkbBLMk50ZT0E7KK3ZB0/OTCbw3WGWR7LE6f81SJIIME3xaKQC2
         UUVVegjIZrIho8atw04XG59r+5PdyF+8eCCIWopzy6Xw2UeaEqDFx5aIOmNS4r8+2TF5
         W2DzuT1T5sW/iwOIME9n2quQbcsc50ncz42C7ALc+2s/K4AGmjWEoc/Ifs2p1g7+W5+E
         WO7/ZlknJe53kSF5gfDb4yowV2LoANsyQPJOkvqc761V+yBCYILz6IvAC9cnbhPT5QQE
         9AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740354491; x=1740959291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wcnMV7bCjw+onbQP13XkDfLLYTKBRINzQvJtc5RrEM=;
        b=NaAxEy22AwUMfgmGHekEL0z+Telv4nOu8q+7g6g05lRwX29/k/i0n3rQ/PyQPmcL8m
         /anFc7JELcCcPHPF4PxfPFvpbPnqoIvBxDcRUz1gXY4nuH/YqjNXS4HZKwczuXGeLM33
         ACTsYx85BJx+JTfP+Yequ94DFdDXVLxXHv+xcErWuesynAEWjiFGCqLFNuJO0VLu2nNk
         97bzwI9P1KBMMjA1Gj3kAnG507We7FRYp0hRMuzK55/2FVOKxUjG1/NC5s1MHmtPMZ47
         ib3ZJiYAXzD62itY9Cq7Qk1LEYin0mI65dqDQKvcQKf0T4J6/o/PqMwaIla1PRVEJakI
         3Usw==
X-Forwarded-Encrypted: i=1; AJvYcCVTmhdbNQJUzinNCJuLJhZHFGwxAwKGek17MuvWLCLv24aiHqmqgmbuGpJGP4DFXYGZBuGiRo6DhZByCc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hK8NODKvunG/AX0cT75umoc7mXr7Ii7lKVfu6eWW5lds2Qbd
	dBPnswkHjG8mNXh9FE++JKBygGWkH1I70cXk8GM/ihOO6/dfIxdCVXEhaDdWteY=
X-Gm-Gg: ASbGncundb8lIQRyweCyWhpjbTV2A+plQJkpzWk1RTnKarsYCXFOTv0dxsAXYoK9hAx
	1H0AAuptwhCbRcEQy0JPLvYp2amkZKu+Hzv2f2UhsFuvh5T+/PPOH+/Xfa9jtByzRX8nM5DpSqb
	vd8KrIEVb1ffJMkCvhfHAXzT6kJnUUqgTPUjY28hW5nibxQJPmeKj76I9x/nypO+/LDWpnCVSr9
	mdGWX7UfZugVzjpFCnQinYoGZB4k6e92aX03mODAoSY7erTLM4TXbyPVG6k5A1C57dKD+VXYElJ
	IMcDH1zMD0IZp2hmgUnLgmIKllTmDWXSGk3VbCvXvjFa5Bn/B7ANu6TchHMl4TEZ6WwErvpXi9x
	SNUaSSg==
X-Google-Smtp-Source: AGHT+IGXmEWcaphU72erBHimrC5JqF3fr1E4pBz3cUxisqWzEmoQZicuyftwCeCY3akeN/V+TAZxhg==
X-Received: by 2002:a05:6512:3f29:b0:545:1049:eb4f with SMTP id 2adb3069b0e04-54838a00232mr4288474e87.0.1740354491225;
        Sun, 23 Feb 2025 15:48:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452a67e6c3sm2955721e87.1.2025.02.23.15.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 15:48:09 -0800 (PST)
Date: Mon, 24 Feb 2025 01:48:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] phy: phy-snps-eusb2: make reset control optional
Message-ID: <rcny5iaxs6gr6vcxmjep6hwtkt2fvtgzhbxlpu3ax6vj7maure@n5bg5y74vwc7>
References: <20250223122227.725233-1-ivo.ivanov.ivanov1@gmail.com>
 <20250223122227.725233-7-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223122227.725233-7-ivo.ivanov.ivanov1@gmail.com>

On Sun, Feb 23, 2025 at 02:22:25PM +0200, Ivaylo Ivanov wrote:
> Some SoCs don't provide explicit reset lines, so make them optional.

Is there an external reset or some other signal?

> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  drivers/phy/phy-snps-eusb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

