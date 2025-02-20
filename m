Return-Path: <linux-kernel+bounces-524125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86529A3DF82
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68021894805
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CAB1FECC1;
	Thu, 20 Feb 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2HUu2HK"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A33F8F5B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066938; cv=none; b=pzs4RTBcXWoajCood51EQJdcIccFO5yxpLxqxCh3nzJXB+0GfifpjNuuPE2m5GCaGkqnz5TAuoMKhDtXLdonM44eDhBXsNbZvI0TvH0zeDI9dWZ6HEOnB8/u3eyY2RQnvJeeJ4dZGjE21lk4c1nsEDzzMBTBqx7JAsJ8kILBBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066938; c=relaxed/simple;
	bh=omAPwoso6uBL42xDlBreEMt1jkCkza3U/DeWmv3X2jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3vbismJzpYr4gWIKOjWi03cm0d1BFBjxB6TLNHaS5Zc/i7FzsxNpQCcbGwGAbMJdcp5pl5yr6GO+7ugK1SfKVhINZYeYHOBFVTiHZy8Xs0toshaYhiGsLlV6TVyNkssfsHxwlsf6KJByQX4QL/hhYw7m3pzHwo+vwfovm+LQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2HUu2HK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5439a6179a7so1254597e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740066934; x=1740671734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5uYsXTWYRSMPSzYeuorstCzH5NUmzaHqKU5zOS+Htmw=;
        b=z2HUu2HK7MqY3Zx+s91Qtgfa3WLcjBzI+cnMX7gWD5xAURM0WKnNDIVjzAOjUa3EQV
         c1Ij/6jkDGdn/9DngGzKnS3JmkxRc/WuDdENgl82Zr0CrTclnLMdmtJ7VvcnqHqPF2BO
         I1l2hOe4bTxTlWwB6fM4+KWuRxj2T2SgdVW+rG+WCLCFoSQ6x/LKW4VTWkjHhsMnZwEz
         zHCKtKJF+F5TcOQ16NuzIlk3SNwAw3RcvRrAA7D2cN6kDqmwvrYHnP0epUmbouDQeuNw
         mTwCRgFtOrGwv05g6+dbbK1J/ExtO53lhjZI4Bau2jf88mg7v/syazAiFKDJciNwvt9C
         ae6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066934; x=1740671734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uYsXTWYRSMPSzYeuorstCzH5NUmzaHqKU5zOS+Htmw=;
        b=HL2wGkK8DDV1eWSSs4deAkbQswkCRS9TBtjWWVGFgVZ1CwVS97SOERPpqFisfeiu4r
         TyKvwOkwTxjoRAaASJQ50CqmyMS8AwJjtjNjFD6IZeVrV9FHz/F7ggFCARI2PnXFaBJ1
         OeAWxZEa5OOuHgbhR1+J++KVXpK7VGcNuEBuNyCj9a7sKBpOfwFz9WFq88K5hbhtLIGm
         KWDjtWmSpCUJ78iOBIyEB9/HpYGpWrriY+A9HofSQOMA4Wgm88vNOCDDL1vYiewCw/Zf
         wLKc8st0x1HjeqfD+EWNLqqvfVW98OWxhQ1EdC3WmqpzhKnsTQ+XtBVl0xzoPGaUlmV6
         ETZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi26l4SpzCzMk+jYuqDOHCONE/P5MYua0MSrmKzjCv+PjuRrzqzsMcMbtBA4nJBVtJXcY18AwLS8alKOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOmfeL5zwT5R8GF/7Un4PMUVZpi/WXS47wX6+jYAZ9LmmnSS1
	tYVz5sVPnI+S1HourQW7mMOWvw97pIsFo2/mCQP1qwrvA1iH+8sNRfh6kUeDozo=
X-Gm-Gg: ASbGncvmUbVi1VE9g8wXghylLbw1rPJAE6gtx41Jv5OlQ9xn8+rEZZfSUb2USmSkV5C
	Gz7inDQ+soj5lA3xuhjzUyw5onmpUUHSx0j3s2lXbf2oE4YdEoCHGsoJV1ladgI5N4NBycZnA3y
	a4OVBLL48ld+nJTwhoaSXjpDThgzW1sIhKf0i0lnN2hf1jZNwPlcTBtnQ4cnwdkCeBQXAsDDGsQ
	asyCa8yLLRJAoOFhkPuLE8DDR1SZF5vBxsnqVQKDuFtrQN8aelfOtoSxrzPFjMBTyncFt0lbpPj
	nz4z5b3erxpcnlM/73h/kzNs8BECzMFLIDnS22Zylt8q38O6WGi0nFztpOGMp+gYMRQkHlU=
X-Google-Smtp-Source: AGHT+IEtf97SsjRtuL6d8IE3D1pgFUBRXbcvvxV4g3GwdxhA+EzzwQ1kj3+RIrBDm6cRLGQC3ggahA==
X-Received: by 2002:a05:6512:a90:b0:545:fdd:9ef4 with SMTP id 2adb3069b0e04-546e4569f20mr1523857e87.8.1740066934306;
        Thu, 20 Feb 2025 07:55:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461f6448adsm1414735e87.70.2025.02.20.07.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:55:33 -0800 (PST)
Date: Thu, 20 Feb 2025 17:55:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v2 1/5] drm/msm/dsi: add support VBIF_CTRL_PRIORITY to
 v2.8.0 controller
Message-ID: <xmamjbm67hxxmzwnilqwlb6esbpf3rtxayitzln4lvwfl4ok3c@7g6gsyp36f6y>
References: <20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org>
 <20250220-dual-dsi-v2-1-6c0038d5a2ef@linaro.org>
 <tu6aaz6whzkqz4at26o2h6pvcua53squfpgfmiw3i4qshojoij@2erqc3zmxmos>
 <CABymUCNYypP9h+r1mPhxtmJsFTfXW1DzvwRLk=6p+9qmY5ofFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCNYypP9h+r1mPhxtmJsFTfXW1DzvwRLk=6p+9qmY5ofFQ@mail.gmail.com>

On Thu, Feb 20, 2025 at 11:45:18PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> 于2025年2月20日周四 18:27写道：
> >
> > On Thu, Feb 20, 2025 at 06:07:52PM +0800, Jun Nie wrote:
> > > This change originates from the Qualcomm Android Linux driver. It is
> > > essential to support a dual-DSI configuration with two panels in
> > > some circumstances per testing. As the name suggests, this modification
> > > may enhance the bandwidth robustness of a bus.
> >
> > Please start by describing the problem and the result of the changes.
> > Otherwise it reads as it "may enhance or may worsen" the robustness.
> 
> OK, will re-test it with older branch. I remember it cause LCD to go
> to black without
> this patch, but not fully confident with my memory. With latest code,
> there is no
> difference to have this patch or not.

For the reference, this is the description from the display drivers
techpack:

    disp: msm: dsi: Adjust DSI priority level

    Sets DSI priority level to 7 before any commands are triggered.
    This DSI priority setting is recommended by systems team as DSI
    and Lutdma uses same Xin for fetch.

Maybe Abhinav can help with the proper problem description.

Also, see below.

> >
> > >
> > > Co-developed-by: Jonathan Marek <jonathan@marek.ca>
> > > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/dsi/dsi_host.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > > index 42e100a8adca09d7b55afce0e2553e76d898744f..f59c4cd6bc8cdb31c1302f8e3ff395486c0b4898 100644
> > > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > > @@ -2238,13 +2238,23 @@ int msm_dsi_host_cmd_rx(struct mipi_dsi_host *host,
> > >       return ret;
> > >  }
> > >
> > > +#define DSI_VBIF_CTRL                        (0x01CC - 4)

Register definition should go to the dsi.xml file. And anyway it should
have used lower case hex.

> > > +#define DSI_VBIF_CTRL_PRIORITY               0x07
> > > +
> > >  void msm_dsi_host_cmd_xfer_commit(struct mipi_dsi_host *host, u32 dma_base,
> > >                                 u32 len)
> > >  {
> > >       struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
> > > +     const struct msm_dsi_cfg_handler *cfg_hnd = msm_host->cfg_hnd;
> > > +     u32 reg;
> > >
> > >       dsi_write(msm_host, REG_DSI_DMA_BASE, dma_base);
> > >       dsi_write(msm_host, REG_DSI_DMA_LEN, len);
> > > +     if (cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V2_8_0) {
> > > +             reg = dsi_read(msm_host, DSI_VBIF_CTRL);
> > > +             reg |= (DSI_VBIF_CTRL_PRIORITY & 0x7);
> > > +             dsi_write(msm_host, DSI_VBIF_CTRL, reg);
> > > +     }
> > >       dsi_write(msm_host, REG_DSI_TRIG_DMA, 1);
> > >
> > >       /* Make sure trigger happens */
> > >
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

