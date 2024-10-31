Return-Path: <linux-kernel+bounces-391127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CDA9B82FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A431C21C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CD1C9EA1;
	Thu, 31 Oct 2024 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsU8tOaO"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658264437
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401324; cv=none; b=tWpta5Iuj5+mKJrn4WocpC9+cX6TuG/+Rimz9oNEK+SifHHj4s3teCGotmlkYw6wgtXUq34oxWkw/DKqYPA3e5Qqh11+U2njJmCvIlsVDAbXxslDF57WSOLJPizTV2067o/VjueFRFxaWNBL4PWUeJR26UjXRzJYBZOLvKKfVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401324; c=relaxed/simple;
	bh=gbJYUdfgCKw/rRKOhbMx2szkGQp2Ixn9Fkw/N9wbhGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JipkdGgmPQswqHkStHX8cMExHg01rmNpZayVmKYNLu6371UbcSc/+8ixWqzcawIAQxRlJTCwgCCGHRIirsvpqKzH7ar5GdRC6fCk6N+Ej9URNfcfw5VC1H/oMy6cjHmadt/Zu5wt99SML4KAVBFDPa38RCjxa8048FJSLZKubmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xsU8tOaO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso9452031fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730401321; x=1731006121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wAnENA8ogJfTOc3zoMO7WnZA1QX8UI1GpRKP5HXdqQ=;
        b=xsU8tOaOw5LczELN0EGTbxWFjBI+wXmYQrzTvEJZ5bOki5BdoreNP3xNSj0/fZ/oJ+
         NRoJvDg/5nuFSaBHqDkfY2VbBakg9ZKs9seWYqxIp9rXJGlcSI8dtH68h21ODGyCDU9n
         bEsx6dfFj1tkgRSXVj6mnzyHD6kE/QyDX0cFSNh492PLxWXZiOXI1wPDn8AwiV/dfB+P
         Ww/vHWVxjnnisaUuGnlhev4kKKC8EqtxVbCQlByB1/pnY0UPknh2zSxpAzBLze6bmb1H
         VhWZ1eEESnEQU82h2txp5MiO7u6aPJwm+rfrBCbcLGcfTnzTgphuhl7zf2pZD14KbMW/
         zttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730401321; x=1731006121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wAnENA8ogJfTOc3zoMO7WnZA1QX8UI1GpRKP5HXdqQ=;
        b=oVZhln2zrABFkcFVr5sXKYFrhl4J5TfDOh9hDWyH0m+s/rBp+JlaIiK8MKtqrx7FgC
         /I9Q+XOXpySXyDigV49CfQJnGNtB7hdZvzIDWF90lzJdOI+g6x7c3clpi5P7gRSEDWBn
         vmegd9PHN7aeKZP3107ET7X0t58E3yf9iIpdMDqfO86Jmxadp72w7+wHQjyWfFxfybbv
         71gmu/1bpdb80+6QCvCSgHW7kkHhCXZ/iuGASoiZ4ufKMVHjdUOFDP4+R3/PjwOcYFtg
         q91NMlLHffJa1VIqxnbG+t3/ozHJBxuaMZHjdJRLcGqgeNbWVAMH8/USxhgRA8PAc5Y2
         SEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxSuteiRRkHkFtUz9EZeRL4StcBGloVYoEoT8HZiNELdU1pHY4r+bKY9HxnVSAmRSuvxtwrV1mQeJGs7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsaUbrN0+DI0461hL2jeJYOajAijItQyyPOd9jw+brOFAQLi7C
	Q0tScq5jRbSB0bcA7lLRrljGIvhVhU48oE8BD/fdQTegLWzr5IHdhauj+0hF9X0=
X-Google-Smtp-Source: AGHT+IFi5F4lkwKY82nrXE+8A/PgvuukB0g3gFwNfuoaN/1U/pVNyOoFpOy9Uuyr9977lLV6rh20zQ==
X-Received: by 2002:a2e:bc13:0:b0:2fb:6277:71d0 with SMTP id 38308e7fff4ca-2fdec8586b9mr24132641fa.22.1730401320540;
        Thu, 31 Oct 2024 12:02:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a6410sm3035011fa.97.2024.10.31.12.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:01:59 -0700 (PDT)
Date: Thu, 31 Oct 2024 21:01:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] clk: qcom: gcc: Add support for QCS615 GCC clocks
Message-ID: <gg2khw4ekb76uikyp2jlvl2bitfovr4grjfqw3wj33jnv5qkwr@p5ulhtixc6b6>
References: <20241022-qcs615-clock-driver-v4-0-3d716ad0d987@quicinc.com>
 <20241022-qcs615-clock-driver-v4-4-3d716ad0d987@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-qcs615-clock-driver-v4-4-3d716ad0d987@quicinc.com>

On Tue, Oct 22, 2024 at 05:22:53PM +0530, Taniya Das wrote:
> Add the global clock controller support for QCS615 SoC.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig      |    9 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-qcs615.c | 3034 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 3044 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

