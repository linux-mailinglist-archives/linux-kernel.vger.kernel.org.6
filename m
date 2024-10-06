Return-Path: <linux-kernel+bounces-352491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DDC991FF8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483B71F20FFE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F3D189F47;
	Sun,  6 Oct 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifDeqqwp"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECDF189B8C
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728235987; cv=none; b=LaMgZbfPtlnfwx4SG8gXj9ux8BqI3pvHPLMng5b+pg0X4qoH4bYKeqDORa/Zwu8y4j6BRixflrKl125ujUXE60XJ35SowfDLQ67UPQmj1g4ViFKVWkFGvpgBbCKV6kHKaSp1/Bh+hfCvg79DrXCE1pnXOlGkz0KRky7wsLI5Yu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728235987; c=relaxed/simple;
	bh=QhCyGOkQgiBpgvjvqjxBH9vOLjNZpa8j8B//L6DyBoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZXvtOUMkj/YqwHR+8UCX7HykCrHDmgAUx+Ojas+MJb3AFMu+vb4cOzhto8/Yb+OdI3RiiRNfONF2w6SAdtnggvgtftV3TARR3wR1MaU0SRV0hJWwmnztk4tr2kF89Luy1T9A57mDHzpKDctnTe/kRJd38TKM4jhqlXWOiuK1U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ifDeqqwp; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2facaa16826so32087451fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728235984; x=1728840784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIFhis9nbzOYzg4QwZr7uypPsNR98pceYiIiC4Gv7+c=;
        b=ifDeqqwpeKFCj0KXxkmJnX9bZNi5iT/ntmaGhATi/PUwJg1Qv450psSoO5SZ+hrpru
         oPw5iMfZcBTUUDg3kPTCI2hMKcVSlg56tBNJvuMvxODmrbcYaf8Ft/ot4QnxWcsbxpER
         jVXg39Wn0xpDk1qCeLD84p9901ibNlZRGmt52Hc4qz2kNNJ6hMAwHotPvv0TwEdZJsVd
         o87gbalHS8jmo9mlAt7wvPqP4Bek05hw2T8renKY5wTWq05OV759aDGn2tmw2IJrZgFD
         S3yp+JAnpNUiWzzqR0b3dU3BP/KSKmdGpyY7j9syEgE/L0FmYXPHX1NvKWFVYARGm8eP
         64IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728235984; x=1728840784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIFhis9nbzOYzg4QwZr7uypPsNR98pceYiIiC4Gv7+c=;
        b=mWQrJ3FoUF1G8QXthsyj8ioT7EAmZg2Go/GHd4STmSye5S7CT9EemidrUZZcYMsH4P
         rtsnfcQnhjA3d17pur8E3laEPWiQCcdPRfnn3hg03WKPMKNjFUFuF8xlZFxGMLWKgqBm
         IMNtpb37sEDM3tWYZwhbAXmY/qWbzhUBjAYuso3mlEkL6XXR9hdgIEChSRP+Hd00zjG4
         b5Gfiy9VpeRYCHACu38gbus5L88CrWqCJfYFIhXo2Q2w+vgcNQxP7ZI5XglKqum84wJ6
         TvCYrOug+iaa4cqeJ8LCvDUvlQORAlp2Kg1usTcc0oCqGx1KjBrECSpgcAAk19WKQJVl
         5YAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2QuP9tx/a8gLRGbKpTaJ8UGnvUBSgkyVXboZhgkD7e6CgDx3hMj7IhsL0ToMLGoxc5/WGmL1+t0p+YrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOYF9ClinNe4WGGRhB4VHn1UW9knDfbP5PwyhTUfMWLD03nBt
	3WptZ0EjyX1b85WnQAl6xlgWTKE4Wuasda+PBfuFliwBM0r+IrCAKu9QFaNPyIc=
X-Google-Smtp-Source: AGHT+IEsWkHJHdD9uuGdPDeF23ZAzVVLlr+LsqBI8Z+Fbqrl+fN88PTSQcf204i5YPdtXnCiwFww3g==
X-Received: by 2002:a2e:1309:0:b0:2f6:484d:cd61 with SMTP id 38308e7fff4ca-2faf3d91a05mr30834981fa.43.1728235983593;
        Sun, 06 Oct 2024 10:33:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9b3374bsm5704401fa.117.2024.10.06.10.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:33:02 -0700 (PDT)
Date: Sun, 6 Oct 2024 20:32:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: qcom: videocc-sm8550: depend on either gcc-sm8550
 or gcc-sm8650
Message-ID: <vaovefjpxyzrcobv5vinepfdbgfsmng2cdhuzkph44ojrpvui5@7ckz43wyddsk>
References: <20241005144047.2226-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005144047.2226-1-jonathan@marek.ca>

On Sat, Oct 05, 2024 at 10:40:46AM GMT, Jonathan Marek wrote:
> This driver is compatible with both sm8550 and sm8650, fix the Kconfig
> entry to reflect that.
> 
> Fixes: da1f361c887c ("clk: qcom: videocc-sm8550: Add SM8650 video clock controller")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/clk/qcom/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

