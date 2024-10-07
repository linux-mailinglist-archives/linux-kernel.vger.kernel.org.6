Return-Path: <linux-kernel+bounces-353425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8BE992D97
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242941F252D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE31D356C;
	Mon,  7 Oct 2024 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oh26Mz/T"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625351D3560
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308506; cv=none; b=POC+ui4JVc0W4oWMofGTmnaZypY19lFX65/h/Y5zTCOPLnd4OfXb2fXDS+xAR56dZ/bdg6rtxuBb8pYAiSkfyxV+EL6KcvtsknIcFRzAWuR6y8sb6Jr0q4GlmNvMIiF0D9e37Z+blHD+H8eN5yan9K2RMwJB7Z43GWmBEID0Cp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308506; c=relaxed/simple;
	bh=uM5smsRB0oK9XJ2vSQdpt5pMXyvoBotS/6L3+4eM/8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODAbedylqOwpdHRmNufbRKyAGpkMY7+a3m17z2eNgwyYU1DNHA9umfJhbMZQ1+r3lLAGI43jRgdkGL3j9eFxiPHtkbANj02z+AH/wLicih1xRLA1QJI4wWk6TiIJy85rzl26B/YYFgCTRdr35VEKR+GHhjc5BtiMD6lOQJN9/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oh26Mz/T; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so45623105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728308503; x=1728913303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzeEyz/cOnu9eFfRF8lZ6etQaWiihzfTD4S66Eb3rRM=;
        b=oh26Mz/TuORY48d5NBvm1iZvF5ZpOE70N9jgdf6tgvSJxq9+aLum1lS/WwjdOs5mCg
         clHB+Lq0sT2zEGtN1x0DSiLA8T2voBYa644ncIqMfkfCSAefUp/3R3IFP+esd8lwSn4R
         5ROQLT/7TP2jjkp83CaIeAbpUsf3kaH608mbB7qus3CeLIiIkEBTfNUfQSK+cENnBSwD
         q1eIfNPWYDSIpn0D9dv7bPKSELt3QBkpSyVa0y9cgN4xcfgq32YqIv74FdAoVYSs9dYP
         CZLuQ3Ngu9/EcDTDCWqn1vafQBTvBUsvkNJzT26v5M+hLl/f9b1mSNZlumhouFE8ElRx
         LrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308503; x=1728913303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzeEyz/cOnu9eFfRF8lZ6etQaWiihzfTD4S66Eb3rRM=;
        b=iRkz79OxXz54P9DeQEcCnwwst+6h4yNkN49Tp9ll61Vqf+4h/t1vGTR6fVJiTdyguX
         fAT0D8feQkUMc8ByrSk3u6OqB5N/Aowb3JZNe3/HEByL4FUEWd//MDjB54Pr0eJPyuEi
         5jUk78Pk+20TnWbzu2+hudTzjm0d/Ew8Nd2Xvmf+3tiRmy6Xcqf0myT3TVC5TOlcWWQV
         fNhgPBNURb2E8ggQ8fMJeKHxIn674uKMennHBoiZ6b1bljnhS2QQOABNgfi8x5kGhDmE
         fQm9TOMWvI3ZXWuYD5sQ8nliHNlQDEXWBqglXRIVJK14eCQZGqJyBszs9S0rzMNfcYCv
         7mOA==
X-Forwarded-Encrypted: i=1; AJvYcCWBw1+ueu4QvfunnHuHxeR6J43BZNpiOpAWlLe2Dl0/a8+HIZuOukGhDZ6BgrfGceai3Gpr3kPvCyZLOBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Wd1F9/o6va1VQR7wVGLaSqmu9yV3L+Slw/3WXIhs8WVztVrZ
	aQJ40kocI0blp6QKHqD/1MBHUwwzebBo6O27xDuFK2d40uv4WtrXUdR/yOn2zvs=
X-Google-Smtp-Source: AGHT+IEfSlzTFX+xhCmXnkxLlEFXJxX/mSroE+4R1cqiuqw0qhOr4h5RlzoMNy84m3giMXo2AyUjCQ==
X-Received: by 2002:a05:600c:3b96:b0:42f:6878:a696 with SMTP id 5b1f17b1804b1-42f85ab9c1amr92214405e9.21.1728308502725;
        Mon, 07 Oct 2024 06:41:42 -0700 (PDT)
Received: from linaro.org ([82.77.84.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695f113sm5740783f8f.80.2024.10.07.06.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:41:42 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:41:40 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100: Switch PCIe 6a to 4 lanes
 mode
Message-ID: <ZwPlFBVXPKupE1Ux@linaro.org>
References: <20241004-x1e80100-dts-fixes-pcie6a-v2-1-3af9ff7a5a71@linaro.org>
 <ZwPDxd9JJbgDeJTi@hovoldconsulting.com>
 <ZwPNsTL+5f/6Gtte@linaro.org>
 <ZwPS9AB27h7KbtqB@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwPS9AB27h7KbtqB@hovoldconsulting.com>

On 24-10-07 14:24:20, Johan Hovold wrote:
> On Mon, Oct 07, 2024 at 03:01:53PM +0300, Abel Vesa wrote:
> > On 24-10-07 13:19:33, Johan Hovold wrote:
> 
> > > So you should perhaps rather say that you are fixing the description and
> > > compatible of pcie6a, which *is* a 4-lane controller, that can also be
> > > used in 2-lane mode. Or similar.
> > 
> > Agreed. Will reword to say fixing the description as suggested.
> > 
> > Just to be sure. We still don't want this backported (even with such
> > rewording), so no fixes tag, right?
> 
> We don't want this one backported (because of the missing deps) but you
> can still add a Fixes tag. Just tell Sasha to drop the patch if autosel
> picks it up anyway or use the new do-not-backport stable tag to achieve
> the same:

Makes sense. Will do that.

> 
> 	Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present
> 
> See Documentation/process/stable-kernel-rules.rst.
> 
> Johan

Thanks.

Abel

