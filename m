Return-Path: <linux-kernel+bounces-232182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C599B91A49C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038451C21A95
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1A2147C8B;
	Thu, 27 Jun 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SniUivUt"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1EA46B83
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486504; cv=none; b=KFx++zL4ed47lCG3SOyQwlVoMlh5OT1dm2BKliDekphZjrzOScZssfN6sOHxmxuHnWFVoFWaw0MgEznq60dZ6towC6RgHReh9vFnuVu+mAjYA9Y0tGoMKIMxPh5Qj8F1fmZRIde1/V7gXQkzTF8/6RAhnH6LDUFs/7ZLPqzrYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486504; c=relaxed/simple;
	bh=d2qDTrmbKUsr+Rx4meYIaCNy4rxF3QmIbu+x1J2u7qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDcIak/6CXlZiyOmyq65TJ3HTbctz217uwKfKOuu6/xRNlF34mfL0HbCwQ4UbOuYRw8qeKYYWaXEOgoFRZnORwwfu0oIVK2AEgPjMqeKS0owqiazqf6WzWU9n8nR4ECWWb+KGf+ZF2MrUG3uAy1OQ7KSwsTGJOllmyw/AtXrgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SniUivUt; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee4ab5958dso4207461fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719486500; x=1720091300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LDIZ8jZNwgR+9ADgTc91LrJE3ciGgVcooiq9Tz2ImAg=;
        b=SniUivUtEHA81Og4mGlKsZA9+IR1j9Q772AfYEmvjB8/n3PbkqmwkGqBKql7FvyehN
         Cy0R4bAmDLQSO69VBDni1T0y28rYVwz9oLz9Xyq+Ra9RCg/eaECGCDo5enyJMCXwuIqv
         7M1/uImXvC4aTDG8O9JZ5KyYncFyiQf8nQcWSnRRYJ0/suhRVdDHto+xPJnP0T6993Ze
         tlOW/+bzDImw4xYOUFeDJ1hkNeLK+e5qYboUGWzVCk46dYHJLkufJhWtZaGJXJgC/E37
         iH3cFaCcL7d7R5oyP25IzfTmtKEUAE6OAko2YNSDu51BM41n8coFf9UWGJ3gU3+VSIj8
         HjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719486500; x=1720091300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDIZ8jZNwgR+9ADgTc91LrJE3ciGgVcooiq9Tz2ImAg=;
        b=hcbILkCjL9ezaJ+vVqEHBH7UxWZJZMD2snthH6ZnAckF15Hn5Gsoo3o816+JA6rXGr
         aix/FdYb8fjlfdyDPPARbiDfVOHJlCtxGSIfWXV/X5i8srkFGX3tH9nKqbQiwcdfyldA
         gepADjE4IJpSyMg9QRkeqHbvz4cqOGxnzzqUnLrheohSWTuWjkDpbbu2OEN9VXqOhd0/
         dufM1VC/VsSaT1QpdzcaciTXDefuXBoKquw6wpow0hRtKGavWyDkYz6VrmdzNR0/Ca0Z
         APlsMoiuC1rDM0gO9c1XICqWa2hEk7KTJZU7LmS3xGojcolaCJjchUA+F7Uxk5DjIKo6
         Greg==
X-Forwarded-Encrypted: i=1; AJvYcCVcj+Xfc3o9i+9MR2jMOVCecIlJ0q+bqELyAZcbmB4RAE23ky9pKwLVzHim/N7O9KojU22iOHxGbuNq4sD3cSg1cGfaF/jsV5/32y17
X-Gm-Message-State: AOJu0YylEPYP6sv6/eYRyr7NAHcqgLrUk5PIqCZ64M/lhfOhKurO/NQ/
	DD7Wij8/xoX1IujhCp4DOCDrlijGaF7FxOsLIwfh3a2F6ajEqsO6p0G7CP/C1+c=
X-Google-Smtp-Source: AGHT+IHwZv+z93couUdcfrBSYJbEjitjwBpwPIxQ5GGLRkyBz5sbtXa96C/INZ7K24jqhX2BnvOu1Q==
X-Received: by 2002:a2e:9e8f:0:b0:2ec:514f:89af with SMTP id 38308e7fff4ca-2ee4803f58bmr7341271fa.6.1719486500528;
        Thu, 27 Jun 2024 04:08:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a4bef67sm2157101fa.122.2024.06.27.04.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:08:20 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:08:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Gokul Sriram P <quic_gokulsri@quicinc.com>
Cc: sboyd@kernel.org, andersson@kernel.org, bjorn.andersson@linaro.org, 
	david.brown@linaro.org, devicetree@vger.kernel.org, jassisinghbrar@gmail.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, ohad@wizery.com, 
	robh@kernel.org, sricharan@codeaurora.org, gokulsri@codeaurora.org
Subject: Re: [PATCH v9 1/8] remoteproc: qcom: Add PRNG proxy clock
Message-ID: <dyh3vxosjjfztgwgpb5jtoqhzfyf5jyfndaujqoslepzvbet4o@kx6xaotzazcs>
References: <20240621114659.2958170-1-quic_gokulsri@quicinc.com>
 <20240621114659.2958170-2-quic_gokulsri@quicinc.com>
 <chi3pzh5ss3mivnhs3qeoen5hsecfcgzaj6qnrgxantvinrri2@bxsbmpufuqpe>
 <73cb638e-4982-49a2-ba79-0e78402b59ad@quicinc.com>
 <ga5kczcyn3dqoky4525c74rr7dct5uizun2smvyx3p3u6z6vtm@5vshoozpttod>
 <2617940e-72ad-4214-be26-7a5b15374609@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2617940e-72ad-4214-be26-7a5b15374609@quicinc.com>

On Thu, Jun 27, 2024 at 03:31:01PM GMT, Gokul Sriram P wrote:
> 
> On 6/27/2024 12:47 AM, Dmitry Baryshkov wrote:
> > On Tue, Jun 25, 2024 at 11:03:30AM GMT, Gokul Sriram P wrote:
> > > On 6/22/2024 2:38 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Jun 21, 2024 at 05:16:52PM GMT, Gokul Sriram Palanisamy wrote:
> > > > > PRNG clock is needed by the secure PIL, support for the same
> > > > > is added in subsequent patches.
> > > > Which 'same'?
> > > > What is 'secure PIL'?
> > >    will elaborate in the updated version.
> > >    To answer your question, secure PIL is signed PIL image which only
> > > TrustZone can authenticate and load.
> > Fine. So, the current driver can not load WCSS firmware on IPQ8074, is
> > that correct? Or was there some kind of firmware interface change? The
> > driver was added in 2018, so I can only hope that at that point it
> > worked. Could you please explain, what happened?
> The existing wcss driver can load unsigned PIL images without the
> involvement of TrustZone. That works even now.
> With the current change, we are trying to add signed PIL as an option based
> on "wcss->need_mem_protection" if set. For signed PIL alone, we send a PAS
> request to TrustZone to authenticate and load.

I see that you are enabling it unconditionally for IPQ8074. How is it
going to work?

> I also just noticed that Bjorn had suggested to submit a new driver for the
> PAS based IPQ WCSS instead of overloading this driver. Will also address
> that and post a new driver in updated revision.
> 
> Regards,
> Gokul
> > > > > Signed-off-by: Nikhil Prakash V <quic_nprakash@quicinc.com>
> > > > > Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> > > > > Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> > > > > ---
> > > > >    drivers/remoteproc/qcom_q6v5_wcss.c | 65 +++++++++++++++++++++--------
> > > > >    1 file changed, 47 insertions(+), 18 deletions(-)
> > 

-- 
With best wishes
Dmitry

