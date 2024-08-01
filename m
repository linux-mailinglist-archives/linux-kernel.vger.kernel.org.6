Return-Path: <linux-kernel+bounces-271336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D252944D00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02511F2530B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F71A00D4;
	Thu,  1 Aug 2024 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocxCsQhi"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3916EB4F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518251; cv=none; b=G/ZZzT3IiSNAZWeL66+uu2mDSjB3pcF51VoqNBcKgUe8h4RM8UZVFVhG8Gyu3s6hZ0ZvPukj5J0IdcglZb6cq/izksr9NOcib+pRq93J2uW1mCkhmMpzTaSoiGefciVdCV3ff16wNIE4yZF5NxmzDUDtR84XsINTrbRbLO2punE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518251; c=relaxed/simple;
	bh=riUFCSAxIX1wYAdAKbt3NvslI0aoaxYg18DMexzaLXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+h+H5/tOMNrVBhGTKb/b5x8wDkcfJM5d+LU79BJ3dSBMQmuCZW9MJcJ/XH1g1Qlfa4GUwhUGGlNHpqIii9f0WByqBm2vYwfVqXqmVouRWMB8Dg/ZyFIGDVXZ4mtXciOPoubjanU3eZrkh3Hm1+CYEALAwaZ/Zn2PcOVvnqdoDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ocxCsQhi; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1d3874c1eso404835885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722518248; x=1723123048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ituu7XR/DhELbO/jAokzr9hjXaeC2nwefVHgABpHf7Y=;
        b=ocxCsQhiB2FtKF06w2eCR59SsTSkQNdQH2F8nMDMOT37KBOZ+cJahhDTgMjjZw0haB
         zNvAyZroe7YjRl6VYDqNLV6g8MxbNGnLr1lSz/WYkihi0PiB7m666/fFhQAxZuXmoGBv
         eFlP41eTlRWf2jOZtDqHrlhMlSiKMPlM71xdb18sBqaGAMS178P+5ErslZaXf6BtkKSB
         OFylwK+E03T6QGIzdT+2prLpwL0ZOvbx3wuZAsqIMgNZWFfCNGGIbLTNw0QUHtCUyJjy
         IOQgGhlmiMvkukBEho6Th9ZgRdRcJCSxVRwA8+XsHMlCIp49IvYW4uLY7immFzziv8x4
         QHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722518248; x=1723123048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ituu7XR/DhELbO/jAokzr9hjXaeC2nwefVHgABpHf7Y=;
        b=SIZB74p4WOPy8ZEfsmYzmYxu4MunvIIbtbvapvKfcTMrf7YV5cI68wkSHdWCVCPxC7
         bGZ/MApfLMVODvpwdHLwtsXWeQzTeRD8IAlMiqxogWgh4Pbz3/AuFz0/6EcSfqAh3Ph9
         FHrrmwufLAgptojZumaLK8dNgkIi2Ug5xlOHmdTGqxPBvC0axiGUWbtzlewH0FRwRCLt
         sRGw05VyE2EQH3jYC4ZCl0ndrmjGBjSR5t14+//lReRjdVwhCW24VRqOHhXq+mvFPAt9
         lf2Gd0Mju1yITTny+9diZjEmhqtBIW9MB+Ta0BZfhMS5PwtAezXVEGdFnHeNocOg5wwK
         RXbQ==
X-Forwarded-Encrypted: i=1; AJvYcCURpBZCw3YRwOC2t18aXkFwRpsVvgi/qHDJ8rVOjKgtpuFopkWwiN0Rnf0gA75AomZ3YK3YY2ZIOk7dlXx3Xz5xit8wKgiqhUooiH39
X-Gm-Message-State: AOJu0YyJAPbQN256eVJmY25MAWzruFqwGuF9CTRAn761f3H7PViMbcy7
	BdVN3QQ9irqv3mc2ac4DX/zQSQNhbzzDWIw12eopyOGbJpoj3sC+9fpzdE4OmfU=
X-Google-Smtp-Source: AGHT+IGULwRue6J39V2Pt8e6HLGmbrFB3ZrmAZlfo4mFSBpV9+w6RlH9yVQ3MCtaj0bcK/QNg6Hu/A==
X-Received: by 2002:a05:620a:4144:b0:79f:637:b63b with SMTP id af79cd13be357-7a30c70fd72mr248746385a.65.1722518248362;
        Thu, 01 Aug 2024 06:17:28 -0700 (PDT)
Received: from p14s ([2001:56b:dc1d:7300:5196:6a43:e999:d728])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1edaf5169sm536372485a.76.2024.08.01.06.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:17:27 -0700 (PDT)
Date: Thu, 1 Aug 2024 07:17:24 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Marek Vasut <marex@denx.de>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] remoteproc: imx_rproc: handle system off for
 i.MX7ULP
Message-ID: <ZquK5CNtRJTTtlkD@p14s>
References: <20240719-imx_rproc-v2-0-cd8549aa3f1f@nxp.com>
 <20240719-imx_rproc-v2-2-cd8549aa3f1f@nxp.com>
 <Zqe23DlboRPSXiQO@p14s>
 <DB9PR04MB84615384294C38EEA5B95F0088B02@DB9PR04MB8461.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB84615384294C38EEA5B95F0088B02@DB9PR04MB8461.eurprd04.prod.outlook.com>

On Tue, Jul 30, 2024 at 08:06:22AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v2 2/2] remoteproc: imx_rproc: handle system off
> > for i.MX7ULP
> > 
> > On Fri, Jul 19, 2024 at 04:49:04PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The i.MX7ULP Cortex-A7 is under control of Cortex-M4. The
> > i.MX7ULP
> > > Linux poweroff and restart rely on rpmsg driver to send a message to
> > > Cortex-M4 firmware. Then Cortex-A7 could poweroff or restart by
> > > Cortex-M4 to configure the i.MX7ULP power controller properly.
> > >
> > > However the reboot and restart kernel common code use atomic
> > notifier,
> > > so with blocking tx mailbox will trigger kernel dump, because of
> > > blocking mailbox will use wait_for_completion_timeout. In such case,
> > > linux no need to wait for completion.
> > >
> > > Current patch is to use non-blocking tx mailbox channel when system
> > is
> > > going to poweroff or restart.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 36
> > > ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index
> > 01cf1dfb2e87..e1abf110abc9
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/of_reserved_mem.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_domain.h>
> > > +#include <linux/reboot.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/remoteproc.h>
> > >  #include <linux/workqueue.h>
> > > @@ -114,6 +115,7 @@ struct imx_rproc {
> > >  	u32				entry;		/* cpu start
> > address */
> > >  	u32				core_index;
> > >  	struct dev_pm_domain_list	*pd_list;
> > > +	struct sys_off_data		data;
> > 
> > What is this for?  I don't see it used in this patch.
> 
> Oh, it was added when I was developing this feature, but in the end
> this seems not needed.
> 
> > 
> > >  };
> > >
> > >  static const struct imx_rproc_att imx_rproc_att_imx93[] = { @@
> > > -1050,6 +1052,22 @@ static int imx_rproc_clk_enable(struct
> > imx_rproc *priv)
> > >  	return 0;
> > >  }
> > >
> > > +static int imx_rproc_sys_off_handler(struct sys_off_data *data) {
> > > +	struct rproc *rproc = data->cb_data;
> > > +	int ret;
> > > +
> > > +	imx_rproc_free_mbox(rproc);
> > > +
> > > +	ret = imx_rproc_xtr_mbox_init(rproc, false);
> > > +	if (ret) {
> > > +		dev_err(&rproc->dev, "Failed to request non-blocking
> > mbox\n");
> > > +		return NOTIFY_BAD;
> > > +	}
> > > +
> > > +	return NOTIFY_DONE;
> > > +}
> > > +
> > >  static int imx_rproc_probe(struct platform_device *pdev)  {
> > >  	struct device *dev = &pdev->dev;
> > > @@ -1104,6 +1122,24 @@ static int imx_rproc_probe(struct
> > platform_device *pdev)
> > >  	if (rproc->state != RPROC_DETACHED)
> > >  		rproc->auto_boot = of_property_read_bool(np,
> > "fsl,auto-boot");
> > >
> > > +	if (of_device_is_compatible(dev->of_node, "fsl,imx7ulp-cm4"))
> > {
> > > +		ret = devm_register_sys_off_handler(dev,
> > SYS_OFF_MODE_POWER_OFF_PREPARE,
> > > +
> > SYS_OFF_PRIO_DEFAULT,
> > > +
> > imx_rproc_sys_off_handler, rproc);
> > 
> > Why does the mailbox needs to be set up again when the system is
> > going down...
> 
> As wrote in commit message:
> "i.MX7ULP Linux poweroff and restart rely on rpmsg driver to send a
> message," so need to set up mailbox in non-blocking way to send
> a message to M4 side.
> 
> > 
> > > +		if (ret) {
> > > +			dev_err(dev, "register power off handler
> > failure\n");
> > > +			goto err_put_clk;
> > > +		}
> > > +
> > > +		ret = devm_register_sys_off_handler(dev,
> > SYS_OFF_MODE_RESTART_PREPARE,
> > > +
> > SYS_OFF_PRIO_DEFAULT,
> > > +
> > imx_rproc_sys_off_handler, rproc);
> > 
> > ... and why does it need to be free'd when the system is going up?
> 
> 
> Sorry, I not get your point. The free is in imx_rproc_sys_off_handler.
> During system booting, the mailbox is not freed.

Why is the same operation done at both startup and shutdown - that is not clear.

I am currently away from the office, returning on August 12th.  As such I will
not be following up on this thread until then.

> 
> Thanks,
> Peng.
> 
> > 
> > > +		if (ret) {
> > > +			dev_err(dev, "register restart handler
> > failure\n");
> > > +			goto err_put_clk;
> > > +		}
> > > +	}
> > > +
> > >  	ret = rproc_add(rproc);
> > >  	if (ret) {
> > >  		dev_err(dev, "rproc_add failed\n");
> > >
> > > --
> > > 2.37.1
> > >
> > >

