Return-Path: <linux-kernel+bounces-359243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E999893F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294F71C20D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A51CB337;
	Thu, 10 Oct 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3hur5hv"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9911C9B63
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569637; cv=none; b=MyEzHRXClL/bagcLcnojODDlb+9RyJXQyjjlZseXHPM5LHiKji2GF+arbA0BAUWdkHG7FU2wJqlI4TF121mCNqGVOmGgpALSgsS2U8bwl1kp4/wQL7bHx9ZXaOfo0eDMF/FRnJPnU7JxJDwP3Vo/GPBLj9FcwVw0EFzdNzMOw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569637; c=relaxed/simple;
	bh=v96PNN4MVU8BpK8vBy975YovAlUghAh49thgBno3qUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dalW5CV4eb+/+U9bfE8+fYKyKJMCXNw08voxXLcfGDa3ApcUQLJrl8BWiywaUi2IEU8mIiiq9s4lMgzyygjTrDu6ZasUXRFU1f17gc/jDAfV23C+Ytty8jHud5k/zmZLC+CNH/x76+g+6Seltfw7tgbmfBYFwbzsZmeWHMKgBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d3hur5hv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b93887decso8806385ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728569636; x=1729174436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DawD8n4X/r4xaXiJGTeAEfpBOv40vnqoSHm9Owz94ss=;
        b=d3hur5hv1thiqZSsoRIMsQMLoCkZXZxD2HiqwJBpMnV6inODcclIdF7x5/rLYARt4M
         q8YaFwp9QwcPwD8tTbr9lTwrp1SkkdGOLuWQhu69CLFGbsrDXWuN2huYDUsC6YZEymsv
         Gsadx+BlNXzCtZu4klo3FtJG6Dqr/s5mEAKlkIhJf5wldNuvMklBTmNu4oxOHlybCQhH
         wOoBGnq+nuMeunJQzZLyfr3HEE0xVUX8kWXFci+lq0/E7S+vblo5EjvWpYpt2mIRxhx0
         OtPAYFIoUvN/lX2609kVdsuSOpvhvhpqxoDJwRmNqQBVt/1/QY48r+xpZaghUvMgmvWl
         QAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728569636; x=1729174436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DawD8n4X/r4xaXiJGTeAEfpBOv40vnqoSHm9Owz94ss=;
        b=T0UH8L8rPl9mKl1Oo4WQlQQqTJhV/wDfE4XN2D3yGMVBWv6bGG2liFvvO/UOnr4jj/
         hFe7o5yIe7enwSd+eRx1xOti6MTkKCG7kxoUFRYFx6VvRxSqK5x4sB8pE1cEWN4xPENk
         eJYgYr/qVru9cYTAjKZ6766jLrJ/qCXfl7upeyrRSFc5MhBNjw5cRj/UHWFACK+WhlxR
         rWPD9RjjPmKe6K9tw7e8MrIbDSplgk5MvKg5j5P6u1XTs/XTxMCCv9o92cfavzPdc3Ma
         AcDBs+E/ZnCO8KPKZ990YZuyP9Sd/007HjKRbZ+IbKwKRAP9N/oZINUHQprKBI4p0mTN
         8K1g==
X-Forwarded-Encrypted: i=1; AJvYcCVZd7EI6zU/k3+iO3wzJSJiIRvtPRls0/CY3Nj+vxS5/vI9iP24WmnD9dPMpJn5t5MmC2ri9dwMN2eBnhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW3QWLNbXrRtFDFJBUpDRZh+tSBjNSPXocEixMlaFHL+iQuorw
	V5QYg02dWXw6Wo7H4jIpWYUqMTSm5qL1vWH1Jm0E2J+snxCtlBnejTGTODQvgIWiCUtlNP0S8k3
	HaDIszcnmkP7rkPCDXdR0o3KRfzpMAEJIneQoQQ==
X-Google-Smtp-Source: AGHT+IH99waZBuY+BmuZLoXnqUMIgsfr9Dg8xvuA8Cec2W/RAxuOqyAufJdeE6Cmv/k4m+tI9LwHTSeCcz7iXHTzNXA=
X-Received: by 2002:a17:902:e811:b0:20b:b75d:e8c0 with SMTP id
 d9443c01a7336-20c6377c836mr102102855ad.45.1728569635812; Thu, 10 Oct 2024
 07:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010074246.15725-1-johan+linaro@kernel.org>
 <CAA8EJpoiu2hwKWGMTeA=Kr+ZaPL=JJFq1qQOJhUnYz6-uTmHWw@mail.gmail.com>
 <ZweoZwz73GaVlnLB@hovoldconsulting.com> <CAA8EJprg0ip=ejFOzBe3iisKHX14w0BnAQUDPqzuPRX6d8fvRA@mail.gmail.com>
 <Zwe-DYZKQpLJgUtp@hovoldconsulting.com> <c84dd670-d417-4df7-b95f-c0fbc1703c2d@linaro.org>
 <ZwfVg89DAIE74KGB@hovoldconsulting.com> <jtxci47paynh3uuulwempryixgbdvcnx3fhtkru733s6rkip7l@jxoaaxdxvp3d>
 <Zwffi40TyaMZruHj@hovoldconsulting.com>
In-Reply-To: <Zwffi40TyaMZruHj@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 10 Oct 2024 17:13:44 +0300
Message-ID: <CAA8EJppWgcyzS14rY2TfX2UNR1iqKBo1=qxHAbwkbeXLrZ2MPw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: mark pd-mapper as broken
To: Johan Hovold <johan@kernel.org>
Cc: neil.armstrong@linaro.org, Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Chris Lew <quic_clew@quicinc.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 17:07, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Oct 10, 2024 at 04:45:57PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Oct 10, 2024 at 03:24:19PM GMT, Johan Hovold wrote:
>
> > > Again, you may just be lucky, we have x1e users that also don't hit
> > > these issues due to how things are timed during boot in their setups.
> > >
> > > If there's some actual evidence that suggests that this is limited to
> > > x1e, then that would of course be a different matter, but I'm not aware
> > > of anything like that currently.
> >
> > Is there an evidence that it is broken on other platforms? I have been
> > daily driving the pd-mapper in my testing kernels for a long period of
> > time.
>
> Yes, Chris's analysis of the ECANCELED issue suggests that this is not
> SoC specific.

"When the firmware implements the glink channel this way...", etc.
Yes, it doesn't sound like being SoC-specific, but we don't know which
SoC use this implementation.

>
> Johan



-- 
With best wishes
Dmitry

