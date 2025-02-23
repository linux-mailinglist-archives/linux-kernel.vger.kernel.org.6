Return-Path: <linux-kernel+bounces-528004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3033A41266
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C19A3B149E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86E20FA94;
	Sun, 23 Feb 2025 23:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvRt9oGk"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2A1519BB
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740355014; cv=none; b=nanJMyOHbtdBYFUBk/dJ13YWHmXGAXEw8/quEV5r2Gh32yJPU3ii4/UtAlqabQd4Bb8/+hTDDpUvgwQfFYqOun7cvbxvs5FHTU3LjWS+mDfYMtZw/Q7D18dA7B2sj7a8I0bT7iWoKvUyQHNN3gN8SaI2OcqFZou53QdlokKxDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740355014; c=relaxed/simple;
	bh=M+zusfD2VKVuEAnmyGa3eOk8yYx5cS2qKUUBEMHbkHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZjb/WOwX67j0dety92lbH7JpSwReVWZTDp2RFKT8l7gFarD7nA1hVI8LvaTCXCuzub0x1B3h8TJsyt4dpOT8xVtrRcToMJcGwueoRewupEjzajQ3NLsC5no/qm61BjJY2c/8GqoNHWOidYnoIbIAPdILipsLL+4fLc4qqckwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GvRt9oGk; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso44384261fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 15:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740355011; x=1740959811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2DHKJmVwTszsc5jF4SMA+P5E4zML2jBXCCxXSpwdHM=;
        b=GvRt9oGktC89aPlk7HINfbpk4kpXShDLxajMqZ68AcKCHwzDSiicxPFR8UdNg12jqd
         DuxqzZOMnGXlk2ZT9N48BYvQmQeZ8gKIe/uEJXxQQIP6N3/2mJdflEWxsIStO5f4z0Ig
         GtiuzOVZkuj3ZyJAiEENfLN/U0oVwaYjHtkx+wtauXMu6l7QxMPJ97tn+LmDioJHeNYQ
         i3S0TRFdsbzlECL8KBL/+XxoeK13gXbOmtHnL63dc86+wEph4yQku1qvaJRQq6spupBj
         6EoGxqILslDJ74tP3ARi3pa+mmB/U2UvLBjmT7wYzR2dI0/wyynjX6LjU9lTdT9HRmju
         ztqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740355011; x=1740959811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2DHKJmVwTszsc5jF4SMA+P5E4zML2jBXCCxXSpwdHM=;
        b=Ytq00IcGPh/3EK/jAIVlQ8cxKkmKsNLuepAOz5KQvVnqO87s0O6BdWVYdX/vYAP6Gq
         p9a39R4hJuTNR/ZtovZqvG8EJJ+lCngy7yp3Rm8W0KgxloIbzZBeeFpUfmYjLqLyuVgI
         d0jVQQO8oUR6ph8avmGjoFa2q6CpGlxSrzSR+b5UWI562lVTUu9KqDOiGmnomignWJqX
         W2SWSkOAjYONTMX0zv6K9vg5FKV+hm+oLsGFbbsYi1Ph3k49Y4gi6G2EsNGFjcRMBgL6
         Kw/1b3G6T5Uufc/1b5N6apRxaiCXa4OvMKXiR6BsnsobzPAZwFbVG3Rae6h8NkX58rJr
         279Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkP4GDcjzUCKDGyeYz4Tex6Sd6CW0NTvs2zQnujTMybeR0oRwqGV8DFP3fldnKVEPo84LpT7EAf/XbJQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+BCTlnbnWKpVOm2f9SF/jUW8n6m1+J4GDffc+2ewXI+lyjJz
	WqPoprRGKX43b98bF3LUO5dX0iPpP3VJ4Cp7VThNzPYlMgrOfvMWYK/YAVDt1Hg=
X-Gm-Gg: ASbGnct+TfTQoKfKK5P3dPaqzwppFXsxSeCVl1Uv21DTp7+2Fhh8wLFBeddHlNARY0X
	X+7ragdlY8XgWgX0XUu7GrAZc8ldRyIVtlFsHTy9uHnZePsTgz86hCvTZnqJEo7EHCSXS/P301k
	AxfZCZ2yypYJauM1WrC5Byq+S/vvoy/md00XcdkWiNZpVLEOgvxBZTRlC11zzhV6nFa3ribB+Uh
	PhwviezqrRve6KQkkuKZNmuNY7GD33Zh5RZvSrs+/nSEcgi8jS6SXoCR6lYrNOIi+999A7P3baz
	XxudMj8vo0mnUgniBwjjy/WXKCN4uGnxUuPGeo5oo5B32PVDXFjZKMzHGT/yi8UHBvE8SHJc7ud
	j2Ijg6g==
X-Google-Smtp-Source: AGHT+IF6OJYcSWoSlziCksaDaytWusPnVDJAPswi6mIFSpxY5wclK5bI3z0d9DXLCUpBnh5gcaD5sQ==
X-Received: by 2002:a05:6512:3a89:b0:545:2a96:34fc with SMTP id 2adb3069b0e04-5483914820dmr4522273e87.31.1740355010753;
        Sun, 23 Feb 2025 15:56:50 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452eee91ebsm2863951e87.129.2025.02.23.15.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 15:56:49 -0800 (PST)
Date: Mon, 24 Feb 2025 01:56:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Fix clock for spi0 to spi7
Message-ID: <53bunpmzcdlmjg25k3g2a7aiif4jemzrfs5uerefjeefjbenal@5vkfrlnqr4ar>
References: <20250223110152.47192-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223110152.47192-1-mitltlatltl@gmail.com>

On Sun, Feb 23, 2025 at 07:01:51PM +0800, Pengyu Luo wrote:
> Enabling spi6 caused boot loop on my device(Huawei Matebook E Go),
> 
> 	&spi6 {
> 		pinctrl-0 = <&spi6_default>;
> 		pinctrl-names = "default";
> 
> 		status = "okay";
> 	};
> 
> After looking into this, I found the clocks for spi0 to spi7 are
> wrong, we can derive the correct clocks from the regular pattern
> between spi8 to spi15, spi16 to spi23. Or we can verify it according
> to the hex file of BSRC_QSPI.bin(From windows driver qcspi8280.cab)
> 
> 000035d0: 0700 4445 5649 4345 0001 000a 005c 5f53  ..DEVICE.....\_S
> 000035e0: 422e 5350 4937 0003 0076 0001 000a 0043  B.SPI7...v.....C
> 000035f0: 4f4d 504f 4e45 4e54 0000 0008 0000 0000  OMPONENT........
> 00003600: 0000 0000 0003 0017 0001 0007 0046 5354  .............FST
> 00003610: 4154 4500 0000 0800 0000 0000 0000 0000  ATE.............
> 00003620: 0300 3d00 0100 1400 4449 5343 4f56 4552  ..=.....DISCOVER
> 00003630: 4142 4c45 5f50 5354 4154 4500 0100 0600  ABLE_PSTATE.....
> 00003640: 434c 4f43 4b00 0100 1700 6763 635f 7175  CLOCK.....gcc_qu
> 00003650: 7076 335f 7772 6170 305f 7336 5f63 6c6b  pv3_wrap0_s6_clk
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

