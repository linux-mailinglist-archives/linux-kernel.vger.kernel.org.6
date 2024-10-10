Return-Path: <linux-kernel+bounces-359349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9A998A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE341F24C06
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DC1CEAD8;
	Thu, 10 Oct 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFwvTDLR"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3198D1E3766
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571333; cv=none; b=D97A+IXTcG0tABWjo8XehFOVTTwL0d/koihQZcrRSO5CQSVQ+rP5KJSLU14YR3KfVG8sTuTkbf0qltsahY1ggoh+y/UWVVJ+8zL0t7djo9Ai86bu7BdJUDz/5FdzmgNhKqToUMWObcK2sqqZlqOstkbFRyg58iJiZ96kIxx2oC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571333; c=relaxed/simple;
	bh=J8h7ZogSRVYi3JZp242VuIB8P5Hx5C5R4FBhWsIGOgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Npqm0cNYlAo1WN2Ip8SXCzXkk7WIbwgqSTUtVQGbVwBbSJ9o0Bv5X9v4NPtD1bd45WDGb+y0cW5fDdKGjMRI62e67lgQ9lMcU4bsXTkoqjnOK7XpCOpSh+WKn00rM2h9sZF2/MqDhjz1ol6mxXGAS4SG1hAL0lWZqL5x8kRWEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sFwvTDLR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so15904851fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728571330; x=1729176130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TSCYi8JcMLXDaF73CrzXwPeVuGXfVTJYUL9WPyu/FF4=;
        b=sFwvTDLRAUoUFyGMt2lhgs0iOLJL8JKxM/29HP3LIkkwC1lvLo4hcExukLDQqOVAuf
         GfnINho++2kGxZwwAWCLLEDZAGPARBdPetTTsz7BL479RaJHfeG/KT1RmQ95av20eQgf
         D4xG/XXcw6QZQhwaYJmZJ64d5D8LSsOGe0KiHBYR2KCIp7nsttZ3OKaFeekT6QvOQ6tr
         DMCp1idfFO2mrqYFwazzrOft5p3CBxvXhA7eTNXpOdCSakU6D7+h5Gh8gAA5Lbfrgs36
         WugVMPPXgXcLGA+oY2dm4V3476VvctmoUYpQghM4VoR5hrTfHFSE3oqcKWzyfuZl1jEY
         Otvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728571330; x=1729176130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSCYi8JcMLXDaF73CrzXwPeVuGXfVTJYUL9WPyu/FF4=;
        b=VH1s+AAFPxDXdNdHPKLO6HT6OX1v3f1FyDSm6SlZ34d6hj8oguyZoQaqa8ETFVFYnI
         oF3JKFVZbwIsy8Qwiq1mB1z3z2jUyS2VOJ5OuWPyoAhDA2qga9Aq/joOmZpIZbkz3zv0
         SmyFqoTuAWDCWvuDt3lApU07GExE4/u9bcAE+WzkPZohfZ+Ep11u3wLvt0lfGuQ24Zzb
         4R6l0suytOzJhIxFO10xVxZucZwG08cPeLAIRMbpgiY2d53TLFuq4DMNvhJVYDso69hk
         Eq0oM/zhoR6UF6JyNaxK+mae8bZCUr21ahcCe7xhCoOIZfTNB+6MTveQKrsRBRWl7Nhe
         a/SA==
X-Forwarded-Encrypted: i=1; AJvYcCUiONsTyOK5xp7i5JGyus3QBBl+cd2wW3hpq2OyvTgm6z9MhudGSZKlfongUXX4Oq6UgdzR5n+ClOpU7w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXU9cnoPGEhjP58/WE287MOtxs52RGxKK4gfNkgNiZo5VSY4Qz
	qQS8t/Az6AOdkbbc9WxRX1W6XFx9kP1E01KeqhFLQlzRcfmC8A21gAg5+1ihamI=
X-Google-Smtp-Source: AGHT+IHTXbpgPQx1CNya5s++GATNvkC8R0h710vIpZWBj7Fxa5x0RbTR+gUaQHMlnVb3y0lAfmds6g==
X-Received: by 2002:a2e:be23:0:b0:2ef:1b1b:7f42 with SMTP id 38308e7fff4ca-2fb187e7de2mr63367001fa.36.1728571330142;
        Thu, 10 Oct 2024 07:42:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb2459c93esm2249621fa.55.2024.10.10.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:42:08 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:42:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: neil.armstrong@linaro.org, Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Chris Lew <quic_clew@quicinc.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: mark pd-mapper as broken
Message-ID: <2fqd3hkj7j2lppxzfl2fjfzrik3jql2gk7chexaajeybcrz3kc@rvx565zzmlmp>
References: <CAA8EJpoiu2hwKWGMTeA=Kr+ZaPL=JJFq1qQOJhUnYz6-uTmHWw@mail.gmail.com>
 <ZweoZwz73GaVlnLB@hovoldconsulting.com>
 <CAA8EJprg0ip=ejFOzBe3iisKHX14w0BnAQUDPqzuPRX6d8fvRA@mail.gmail.com>
 <Zwe-DYZKQpLJgUtp@hovoldconsulting.com>
 <c84dd670-d417-4df7-b95f-c0fbc1703c2d@linaro.org>
 <ZwfVg89DAIE74KGB@hovoldconsulting.com>
 <jtxci47paynh3uuulwempryixgbdvcnx3fhtkru733s6rkip7l@jxoaaxdxvp3d>
 <Zwffi40TyaMZruHj@hovoldconsulting.com>
 <CAA8EJppWgcyzS14rY2TfX2UNR1iqKBo1=qxHAbwkbeXLrZ2MPw@mail.gmail.com>
 <ZwfiuJW1gkYPFic1@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwfiuJW1gkYPFic1@hovoldconsulting.com>

On Thu, Oct 10, 2024 at 04:20:40PM GMT, Johan Hovold wrote:
> On Thu, Oct 10, 2024 at 05:13:44PM +0300, Dmitry Baryshkov wrote:
> > On Thu, 10 Oct 2024 at 17:07, Johan Hovold <johan@kernel.org> wrote:
> 
> > > Yes, Chris's analysis of the ECANCELED issue suggests that this is not
> > > SoC specific.
> > 
> > "When the firmware implements the glink channel this way...", etc.
> > Yes, it doesn't sound like being SoC-specific, but we don't know which
> > SoC use this implementation.
> 
> So let's err on the safe side until we have more information and avoid
> having distros drop the user-space daemon until these known bugs exposed
> by the in-kernel pd-mapper have been fixed.

Then default n + revert X1E sounds like a better approach?

> 
> Johan

-- 
With best wishes
Dmitry

