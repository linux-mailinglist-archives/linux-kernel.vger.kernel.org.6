Return-Path: <linux-kernel+bounces-269126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F577942DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE65D284C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E4A1B1414;
	Wed, 31 Jul 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pp3MJdwy"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822A1B0101
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428318; cv=none; b=Vogl0Zm0nB9bbU5bkPoCb6l6kYEyUMSj5oZ/sNEqRpNLnBRVzzgGZ+UD2M9zNBXjXbCyaRAZxF65cTDlDtFZEmTCFHjlluJ4/9fG11ssNOwBNuvdwpub1Bz1TzLghOvFQ9n1zQ/dlr2fEPAdvLuWJhRTclFmdETOFBS5MNFHSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428318; c=relaxed/simple;
	bh=Jyjn/pTQp4CpvvPtf69J7fVM/fArCGIkQyNV83qVTvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j66jLzk2dOu/CdsfDoHS1Lk4LI+IwVxzakP3UgmhOkQyTNUXITauX/QzRHZ7Iv/3/sAXTsYKUIIy6/Im/7Wm4OVDyNbekDC59HO9FadcRbsf/wIsIqCcmJ8ns4S7IuW9X6vHHcFLn4SEOrDRD4hem/Fmlw2tUzMTwe3/ynz0Zgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pp3MJdwy; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso6777856e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722428314; x=1723033114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef8AtdFgaOFukIlkgGOXCKezxspkLpfoqsDfZ+2AvFA=;
        b=Pp3MJdwyhVaSBpUJoiUwZxxV0L1Ppx9IGtCzalmLWzqjzgweB/ekCl2xr9NOuXVnyX
         WNJnL4en5CsqI7W4Lv0WBGQtxLNQ2/Je2++tNkYEIhJ8qjWGhZFhKpCiqeGJxDz2l8nW
         stGDN7dH1Lhu8EhLl3XyLbZSgPFfhqtCnlqjMc4ci31End095WsVR7bf0aqVAMcfEmYI
         RzmSvZtIEVcHqEh+OVRDoxHt0adp2/H+yHh6uAtjJ3oj1MUNc+9fVCKWB9qcg7TN/I1R
         HOPjSvArbZ2RyFF9IQz66/VjTlFSt6twcKW5dSVdsZPDEewgyOsqSCWzuAVcLo02LfGK
         2smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722428314; x=1723033114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef8AtdFgaOFukIlkgGOXCKezxspkLpfoqsDfZ+2AvFA=;
        b=YS1m4yMq9+y7pGFhdJxlWFjdw715bU7rKvnuOkHfz9t5LDYVEDsguJflR1jpq3u5OZ
         d1h5j0nJ8t5ndgFS5ECUnbV0oh86WtFW/TOzvzBSFSbdGV9dswa14oskLQ3gb8xLDbPv
         olRHiSopmNcLArievGWqibNfSTH2GdfheBAWQeEioXs/iPtVomzhQ+H4SMi5KIopyJeU
         nKxQ66hIexYAdQy9kwTjtwuKLeiAYo9B9bUBGMGR9kLRtFFvhBbgLBYXaOzAoHfbL1WA
         i5zwRsVLP+wvQPS+WtZ7KhGf44N005iLgMqAamK1Dpf3e8JyWZzBYdsLFrpVsikR0kwC
         bOqg==
X-Forwarded-Encrypted: i=1; AJvYcCXdXz1Lk4KTYyAam732d8QgWCgH+Fx5QIi+O4R9HlEIzAUmHx8TNVH8EDVyTiyhGzyP23RpsGJBiC1oC2V/LoCniWxGKqr1jVBgPF6J
X-Gm-Message-State: AOJu0YzI7XhE88q534QfxO8Wla7/5utKZ4WA2bKemXgYn0BJmxy56lsi
	q2OPmK15mOkiaXesIG5HvqNIBHh15ncxkfJnpYihwLQ5Rdd0M4FWuIZLkgIjhZU=
X-Google-Smtp-Source: AGHT+IH2dwcdWcsCN5LSSxUGg3P495Lui57f35rqpd5CqDHf/YYIimlDAmIlZZClVTpdVINKDMF6sQ==
X-Received: by 2002:ac2:48a7:0:b0:52f:c24b:1767 with SMTP id 2adb3069b0e04-5309b27228bmr7804179e87.19.1722428314320;
        Wed, 31 Jul 2024 05:18:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c19febsm2196526e87.225.2024.07.31.05.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:18:33 -0700 (PDT)
Date: Wed, 31 Jul 2024 15:18:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	kishon@kernel.org, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom: qmp: Add debug prints for register writes
Message-ID: <knjl4q5zyqz3wrqp5aawgpxk6aqggvteb72enpsgweulgrxmnu@ol42qtug4xvi>
References: <20240730100351.51454-1-manivannan.sadhasivam@linaro.org>
 <ZqoY5kFLDEmkb495@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqoY5kFLDEmkb495@matsya>

On Wed, Jul 31, 2024 at 04:28:46PM GMT, Vinod Koul wrote:
> On 30-07-24, 15:33, Manivannan Sadhasivam wrote:
> > These register prints are useful to validate the init sequence against the
> > Qcom internal documentation and also to share with the Qcom hw engineers to
> > debug issues related to PHY.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-common.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-common.h b/drivers/phy/qualcomm/phy-qcom-qmp-common.h
> > index 799384210509..e6a6bcfcac28 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-common.h
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-common.h
> > @@ -9,6 +9,7 @@
> >  struct qmp_phy_init_tbl {
> >  	unsigned int offset;
> >  	unsigned int val;
> > +	char *name;
> >  	/*
> >  	 * mask of lanes for which this register is written
> >  	 * for cases when second lane needs different values
> > @@ -20,6 +21,7 @@ struct qmp_phy_init_tbl {
> >  	{				\
> >  		.offset = o,		\
> >  		.val = v,		\
> > +		.name = #o,		\
> >  		.lane_mask = 0xff,	\
> >  	}
> >  
> > @@ -27,6 +29,7 @@ struct qmp_phy_init_tbl {
> >  	{				\
> >  		.offset = o,		\
> >  		.val = v,		\
> > +		.name = #o,		\
> >  		.lane_mask = l,		\
> >  	}
> >  
> > @@ -45,6 +48,7 @@ static inline void qmp_configure_lane(void __iomem *base,
> >  		if (!(t->lane_mask & lane_mask))
> >  			continue;
> >  
> > +		pr_debug("QMP PHY: Writing: %s --> 0x%02x\n", t->name, t->val);
> 
> This lgtm, but fails to help when offset _might_ be incorrect, including
> the offset value as well (not just the name) would be better imo... 

Can we please use dev_vdbg instead? Having dev_ part makes sure that we
can not mismatch PHYs and the sequences. _vdbg is less important, but
I don't think we want this in the log messages unless absolutely
required.

Also, could you possibly apply this to all other QMP drivers?

> 
> >  		writel(t->val, base + t->offset);
> >  	}
> >  }
> > -- 
> > 2.25.1
> 
> -- 
> ~Vinod
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

