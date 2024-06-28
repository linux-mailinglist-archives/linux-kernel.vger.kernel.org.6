Return-Path: <linux-kernel+bounces-233599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88691BA11
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131F41F20F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2A153575;
	Fri, 28 Jun 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfKvL5gl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C0E14F9C9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563549; cv=none; b=m6Mbqpp4jeNhnqoojPW02xUz/F7wyk64MzVLyBWeWmrDZV1OoUSB0ikPl3doiLSNfd95EMcQfvcFKzz1WJLnfrSkDoh+ouy1UiJeAjX13HyYqGmRAUDYA4GW40GCkDzzAfyDIIMEa7lSvKcHTIS0EwGpX4prwNfUbgxGw0sDiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563549; c=relaxed/simple;
	bh=r7+eakRvT7ZiZ9WyL9rTTM6ysWPSIZYFNimdjEgNIJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI3NrZJivY7BWW9YEOGc1NsvOMdb9mZNUnaWijvPN6Rvpr1HAHW43l6Z5CxGr8+nVWMeC8CltIWFOY1j2QJsk0yjqju5xZxIv9kPThm2+qdolqN0PdbtIUqiVk45c1Ku9IanDtOuRlc3X3RoV6kYubHcTE7dP33ptyuGAob1zVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hfKvL5gl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e7693c369so446785e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719563545; x=1720168345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJwxeW+GDgd+YjrwH0bRPELomJst4fhgHNABgR77E/Q=;
        b=hfKvL5glJDWnkKCm3Pt3eedbEmaBuw/7vyCk3OJF9HGv9Ejiav107XtJRaoLPNwhCL
         iFXdyy1BmoZHSSLowdvwOqnsHlrIYE+f43kdkrUWdAitJHMZIVrf2ZQ1BgjZSAT3/FCa
         l959aEQhv82XzlWxSnBKtmAHNBiYuP/1Rd0nBSDKcxJfBhIMaDuNkNspmTQv2RsqKnu+
         Ep4QlT78UaLmdgzKIzK5uqem0ABVikJ+s7OodD7AaLuynb4Ee9sOci+QAm5sphY6il77
         F5yIBE6DgooLxFKvsmsCL9ghj80UidYQTSr+KXPfvwQrPp0B7ETLJKhItPKXt6HDtLN3
         xNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719563545; x=1720168345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJwxeW+GDgd+YjrwH0bRPELomJst4fhgHNABgR77E/Q=;
        b=Dy7g5WeVlzkkZyteW4MKy3Y2UROS4xOdmXX4wTb572/SD0mRvkb0lqxsY6JT9c0cAM
         7UwWHikqsPNQA7qaKW7c9+TxH2iIMo25iUYhV4qA95aqesTHGB26JuOJnofkn3+GmUmD
         TlK4JuIQ3QTdlh3VNl5EcS+9DxJrdcDvDFqlSKlprQ6VBZKWoIRXl/ynF/OIkXuP8aW4
         WrU4xuFQjJthRjmlm4X7x3wkR5ekWlN5D0fo9ET/Wkk1+SwWdM/TulBTwopA6vPwtQ1M
         sZTTNjOn9TW796epwPJS3+rofhPuNtjCBmZMtCy0+EzoI3RflGTV880iu13N00glQdZD
         YiEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTtje8f3qI1zqsvhXJCLscUnlCbW/PcjJTF27IHxrZDogbkuchp5bgfThyP57Ki2tixYMQF+ovg2K3xZ1UtQEwtFdM3KoOPTggUikq
X-Gm-Message-State: AOJu0YwYEV2VxCuDf7dMHozkB0j7CSgtRPPeUZ3wWqe1YOqI0bmya5Xv
	MFxnQp6r1jyix8fz0WBQ4uUsmDX5Nn0WeJM0CVjf+KdbQ4FUAGebCz1Ux1oJXLM5eJdsb1YGixv
	Edls0dA==
X-Google-Smtp-Source: AGHT+IEBqgq8/ijDLYuWtZgrlxH0PdT/BNEB0C1UNr460C7LtzL4BXpKkJbR3oMqpmu0RY60Od9/Ag==
X-Received: by 2002:a19:ee17:0:b0:52c:def6:7c97 with SMTP id 2adb3069b0e04-52ce064146emr10914325e87.45.1719563545317;
        Fri, 28 Jun 2024 01:32:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b4cdsm208851e87.294.2024.06.28.01.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:32:24 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:32:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-x1e80100: Set parent rate for USB3 sec
 and tert PHY pipe clks
Message-ID: <6fr22a5ehq2vcd2ueeaphtzhauscpaj4llt2j62cj5m5wydw32@6ma244renp33>
References: <20240530-x1e80100-clk-gcc-usb3-sec-tert-set-parent-rate-v1-1-7b2b04cad545@linaro.org>
 <3ukguewuqqm5gmbd3afl62ihysdzkk44j3f2nuqht4gjuf5ruo@zu7jmmnbrpdj>
 <Zn5w9zKxIT/2OvB4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn5w9zKxIT/2OvB4@linaro.org>

On Fri, Jun 28, 2024 at 11:14:47AM GMT, Abel Vesa wrote:
> On 24-05-31 02:56:12, Dmitry Baryshkov wrote:
> > On Thu, May 30, 2024 at 05:05:24PM +0300, Abel Vesa wrote:
> > > Allow the USB3 second and third GCC PHY pipe clocks to propagate the
> > > rate to the pipe clocks provided by the QMP combo PHYs. The first
> > > instance is already doing that.
> > 
> > Which driver changes the rate of those clocks?
> 
> Sorry for the late reply.
> 
> These clocks are consumed by the combo PHYs, so driver is
> phy-qcom-qmp-combo. This driver doesn't change the rates of the pipe
> clocks as of yet.
> 
> The fix is still good, even if it's just to align all three clocks.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

