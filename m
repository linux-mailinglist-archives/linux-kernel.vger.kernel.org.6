Return-Path: <linux-kernel+bounces-536702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0CA48329
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FF9188A719
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1B226A1CF;
	Thu, 27 Feb 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DESr8ksR"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E6925F790
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670728; cv=none; b=HMcup/43296ywsSOAExqXsD4MSxBSuVwcZ3YoBmIyNvqJAvcvKD01YFdTvipbIJIeSQI8qunuNTjEWRi+2lZFpLrPYO96jDHMmcVge41SQt13vdXAilobxV95iX+0VQ39jSF+jzHkM5AirGVa1q3TVFbC+XIBgyXeoUdnW6tPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670728; c=relaxed/simple;
	bh=6eAW2AaO6El97M04g7Ltr2OugcTyLJec8L7LtDutNTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DShwG2mD0hYth03E5rn3apm2jqDs94BsI0EsUBfi/Y4s4bJ77Nlax8qTwA2fII8at5RyMfvzb8yhqJKN3YxGjMTbdQnchUD4aDr1Rs0nlSzAEgO8j7aFe+9cxk0GoWUhShmB8KieHZBiIQbqjRQHKoPj60pDjDFAoyh5OUZLwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DESr8ksR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54838cd334cso1258578e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740670723; x=1741275523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmJa4nq3xcrEbO8I6gQ8yH2cvEg/RJVZoqiHM7UJBfs=;
        b=DESr8ksROIw4BsjpFqUo239D20MqFOZg+Dbn8FgRT77qFVrh5WYyjvFXcU4L9Gk3Qk
         0042DHYTBXGZFH2wfuQ9+D8RaTgjY2EYKhq8u0ZD3jYrTB6DNV+s9K4mBHrd7Zovr46A
         iFM6JJuuEHX+AqfS9DRVexqmKp4ZYXPC/WEqiqj25mGlO+4wGPwmXpeYqBnfBw0dtmPF
         OLZuxHzGxXWOtWH4xrqMOBcZrv4WZai+bnkKKN99lipY/KaqSSSGXpybU26INrI5+1qK
         V8er13PtXRJedrLxHYYstVxtSibRRCirKxXOuJWKEIzddxfzhWMj/0eg1jsRzRaC4Qyr
         GakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740670723; x=1741275523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmJa4nq3xcrEbO8I6gQ8yH2cvEg/RJVZoqiHM7UJBfs=;
        b=w9fxBH3+5F53OrgNZ5bD86WxRpunOzPIcFEPGp29efGegX0LmO4qIQgunW3657uomf
         tUUKTrDal563EEXz2TirCGFXsKYwJaN8CKPZvx5iX2q0godoQzeeqIyc5h21Ll4v0lND
         DSq0yBubuDuGwdcxtpu6QO31Jry5rzbJtHycXPl8bS9S3LPFMw3WXkYJVRciS526rnqY
         7rd60fLWAJ1aDrml9zQoR+albFDe5jkIPE2ukb9M1feCrDOjgekDMQK4rYGAP8C447xO
         TwGiMP8i4VIFZdfx4NZBedD9TdAuV/eA8kdjWAIl21wR+ROD9di2Tn+15MWv53Yx16mA
         RzqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe9GNm0itwrGUx71cTf2NwjcJvz/Jj9O5oJuE+tPx22ikZeHVLUgln9/jql/bqGpWheFP+vMJLfkWmYNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15y/VgECjbKMI8Pp1U10BZUzUVm2wRv/3RqwVpfgyFDmexwd+
	m+gg9cOZSv1sRdEvsa5vsEnS4a8rotPBFcXAR6VtO1RSJ61ZFtPwwQnoacmNWGE=
X-Gm-Gg: ASbGncvlEYgLpCxmyoYXsIZwI5AMOA94xrRxTmyiP/PyHmHdw2625fb9NMnlcghAH1Q
	kyztbxVuxGh9FAFaRJvC+qW1iGxdSZiLshJJjoa9FkOg4etAXkNpbnfk9O7SUCH1WiUFh+u2L2r
	pzrBkHDPko8k+mBGu36qT2XZ/o75Ahvd4mLzUgF5NctSJUQ/dUnJDiYEagxoFfGwadSh3xQDUFP
	hVWzAaBOmgdpaSWSAIaayE46msJaFjzZ9yQ7T4+1Cag9BBQ0GWeB69K8Va4op2vYXZUSgmtBxRN
	Sqv7MiH+TJwGqBIYN4m2+iA/bB0GBJjhujaoMI/LiGz+iIgbdeNufHxYF2zP69sHVMm37RdVpl1
	oXveJFw==
X-Google-Smtp-Source: AGHT+IGLNuY/DiXj5lSnsG6IMOYZEwkpNVtYtEF8TL4nLURfU4/52wLS36QXQ1sPlbQ5r323ZGXWiw==
X-Received: by 2002:a05:6512:3f07:b0:545:a1a:556b with SMTP id 2adb3069b0e04-5493c373156mr5089100e87.0.1740670723108;
        Thu, 27 Feb 2025 07:38:43 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cd443sm185769e87.253.2025.02.27.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:38:42 -0800 (PST)
Date: Thu, 27 Feb 2025 17:38:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
Message-ID: <4hicem4rbz5l7wnzaaz3krrl3euh2dmvlah2rb7errrdq5fann@44dvdxirkuzh>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-8-shiyongbang@huawei.com>
 <reqpxlbvlz5qssgy6gbjuou33h4zevo4xeztqbsr4keehplyhx@utv22a5ihohx>
 <eef68fc7-30f4-4246-a82e-4f90cd6a665d@huawei.com>
 <6jx5ldpidy2ycrqognfiv5ttqr5ia4dtbryta3kc2mkndrvvgo@qzuakucz765k>
 <6634386b-afc1-4e31-a2f4-9c1afed2d1d8@huawei.com>
 <CAA8EJpqHmhUxLE57XNeh-nVtSP7WvtBE=FiFWk9kqM_P+AC=0A@mail.gmail.com>
 <5af62fa9-e71b-412f-8640-502f03fcaa52@huawei.com>
 <vrsy4hao4qu3hlcbmjyfyibeearhhjgtik3e6o3v2eyzkatdve@kdb7cyvl45tu>
 <ade54ddd-79ea-4335-9058-c17e4525e83f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade54ddd-79ea-4335-9058-c17e4525e83f@huawei.com>

On Thu, Feb 27, 2025 at 09:46:10PM +0800, Yongbang Shi wrote:
> 
> > On Tue, Feb 25, 2025 at 09:57:17PM +0800, Yongbang Shi wrote:
> > > > On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
> > > > > > On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
> > > > > > > > > +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
> > > > > > > > > +{
> > > > > > > > > +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
> > > > > > > > > +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
> > > > > > > > > +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
> > > > > > > > > +  int ret;
> > > > > > > > > +
> > > > > > > > > +  if (dp->hpd_status) {
> > > > > > > > > +          hibmc_dp_hpd_cfg(&priv->dp);
> > > > > > > > > +          ret = hibmc_dp_prepare(dp, mode);
> > > > > > > > > +          if (ret)
> > > > > > > > > +                  return ret;
> > > > > > > > > +
> > > > > > > > > +          hibmc_dp_display_en(dp, true);
> > > > > > > > > +  } else {
> > > > > > > > > +          hibmc_dp_display_en(dp, false);
> > > > > > > > > +          hibmc_dp_reset_link(&priv->dp);
> > > > > > > > > +  }
> > > > > > > > If I understand this correctly, you are using a separate drm_client to
> > > > > > > > enable and disable the link & display. Why is it necessary? Existing
> > > > > > > > drm_clients and userspace compositors use drm framework, they should be
> > > > > > > > able to turn the display on and off as required.
> > > > > > > > 
> > > > > > > Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
> > > > > > > We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
> > > > > > > the different video modes into DP registers.
> > > > > > Why? The link training and mode programming should happen during
> > > > > > pre_enable / enable stage (legacy or atomic).
> > > > > Hi Dmitry,
> > > > > 
> > > > > Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
> > > > > And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I
> > > > It should be userspace, who triggers the enable/disable (or it should
> > > > be the in-kernel fbdev / fbcon, which interface through the generic
> > > > drm_fbdev client).
> > > Right, I knew it. When I insmode my driver firstly (or restart display service), it will call disable, modeset and enable,
> > > by user, but it won't call when HPD triggered .
> > - Is HPD even properly delivered to userspace? What kind of compsitor
> >    are you using? Is .detect working properly and reporting a correct
> >    plug-in state?
> 
> Thanks for your answering. I'm not very good understanding about userspace in framework. In my opinion, when I call
> this drm_connector_helper_hpd_irq_event(), the HPD will deliver to userspace.
> I use Xorg, and the display service is GDM.
> The .detect is called and the getting modes info is correct.
> I find that it would only trigger(disable, modeset and enable), when I changed resolutions, restart display service and insmod driver.

You can go to the display settings in GDM. It would be interesting to
observe if it notes the second monitor or not. Last, but not least, you
can use a simple tool like 'xrandr' under your XOrg session to set the
display resolution.

-- 
With best wishes
Dmitry

