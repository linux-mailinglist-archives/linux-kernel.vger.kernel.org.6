Return-Path: <linux-kernel+bounces-210264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278390418A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327A31C231A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E641C6C;
	Tue, 11 Jun 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdKcmH8O"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5D17578
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124334; cv=none; b=OXduKt1QsRef0+Twr6OkcetWxyAfjZtKlSO/EbgIXz2BVUAlEtsGL2v6MxU6+GcRRNEzCu8Yv2LFPxKoIjtVnAEpDqgCRYbH6BDgEUvAIYBGYRdadRuFgg0EOQDwDeAHghH76PnuNQu5LsWeQsQc83OLaDHZ8I7h290ZKKurzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124334; c=relaxed/simple;
	bh=2Bh/7FdcoRKuZHm/1cMaXHw/SlFeSlV4+dQAjyZVxpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAlJp7r5c9Ab4W41cLN9YmMHuwS7Evkc+jtGtbanB9f2xuQG1rp8CMHCWMueQefpQe3zEpZl8MMmuBWPJsEf80HeaaRdQuuHXQVTOnLB8YYSp+dNCPe6hvaOZ+vwt8tLuucoLfPpptt94LLPzCcmJhk9mKV8+hC670w/zmo/t3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LdKcmH8O; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-681ad26f4a5so862814a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718124331; x=1718729131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxh4vIrmKNIXaNnO4GUj7kMvMIp/Jmb4kSQsyNNbs0M=;
        b=LdKcmH8OvcA0Uho2MDCQY/rgzCyhtcueR3v2nQSB8ZHBOyoog4bUUknYUWihcf2D3t
         TYu2CmREqd8x3+kYl3TqQH91TexyQw3jXEY3o6SARyS/SyqwvxdOkhmQ4ig3h8jNOKtJ
         4G4YhF1Lndbd7913iqghAZ5iRaEQ/BHVPLKF9W1gna16nIC2GEs12jFXXInlMcOU37Gc
         59G1//WcA7/XrVP/k9d4adwiS0L8yWnQzbIJU5/z8hfnTgV50/d1AW9XV0EFcmoiT8ib
         D/3X/ynPy/JfybeVMo2p//IQoEufPkpTOoSTT0NW8C4E+hwL7yN4toy1vm7PpAClyyrW
         48+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124331; x=1718729131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxh4vIrmKNIXaNnO4GUj7kMvMIp/Jmb4kSQsyNNbs0M=;
        b=MsHSwVaMXTcZ9DYGR0meZcGlOiTNT0hQQtjz/jvmWvfQbfZ7xhjU6o0nQI8ZYnNu7u
         DVBCF3SQ3d8dbS8w4PmtO39Vq9zZO8nA8NU7VRMV+HPpuoTi/cIcrr/HQHzftpEbaNx7
         TCKQmY7Jmb/dthpETrHZDspKMRRv2KvI7yDUvlYlwMs4ULlNsBLEc5VfmA16VKNy71XP
         20QrrdYxHJdtTJjtwpQmdHGIQW2wUgD5m+tB02wy11m/89wGajuv0GR9C4b5rNpp31Sa
         JuwNsLx5KF2MHz3PoB5pDxOuYnG+n6ef/7Q4mRpk0Pz+WPGkCwGnzC5T+2UGE+uRK+mA
         ARCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV8j9UuN5LhifYrG7il10QGZ6Za31/+oihRfOQXpHhTX9Am+cTDuNhHv1UfN+3fX6BAAJyUhLfwOU11/f5eGk2B7E5wKw2Y46miTiW
X-Gm-Message-State: AOJu0YzLSd595iwdf/bwyPyhcpLTBZvYuTWE2NRhOVOU+F/vXHEAAZ0X
	KfV5F8ikCVlhdphEfXb1QT67eAwEmLP0fTJWlrW8/4B40+6bGaXHDvCEwSiPImc=
X-Google-Smtp-Source: AGHT+IH+FSYIcHzGX5O1UrgkGqxESmaE4sfiuSdN7cxUsK+Rn4rESv7cVAMHJ/TaGzdgKg0Ddd7uUA==
X-Received: by 2002:a17:90a:d588:b0:2c1:ea2e:20b2 with SMTP id 98e67ed59e1d1-2c2bcc6c9ddmr11095209a91.30.1718124331202;
        Tue, 11 Jun 2024 09:45:31 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:74af:2f2d:5f50:e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c32ba3d59fsm2219845a91.25.2024.06.11.09.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:45:30 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:45:27 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Aleksandr Mishin <amishin@t-argos.ru>, imx@lists.linux.dev,
	lvc-project@linuxtesting.org, Shawn Guo <shawnguo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [lvc-project] [PATCH] remoteproc: imx_rproc: Adjust phandle
 parsing issue while remapping optional addresses in imx_rproc_addr_init()
Message-ID: <Zmh/J0hvTT1Jwvjc@p14s>
References: <20240606075204.12354-1-amishin@t-argos.ru>
 <ZmcuFRfjKRQG9OXI@p14s>
 <20240610-4fb504648421659114538a50-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610-4fb504648421659114538a50-pchelkin@ispras.ru>

On Mon, Jun 10, 2024 at 08:36:19PM +0300, Fedor Pchelkin wrote:
> On Mon, 10. Jun 10:47, Mathieu Poirier wrote:
> > On Thu, Jun 06, 2024 at 10:52:04AM +0300, Aleksandr Mishin wrote:
> > > In imx_rproc_addr_init() "nph = of_count_phandle_with_args()" just counts
> > > number of phandles. But phandles may be empty. So of_parse_phandle() in
> > > the parsing loop (0 < a < nph) may return NULL which is later dereferenced.
> > > Adjust this issue by adding NULL-return check.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > 
> > > Fixes: a0ff4aa6f010 ("remoteproc: imx_rproc: add a NXP/Freescale imx_rproc driver")
> > > Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > > index 5a3fb902acc9..39eacd90af14 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -726,6 +726,8 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
> > >  		struct resource res;
> > >  
> > >  		node = of_parse_phandle(np, "memory-region", a);
> > > +		if (!node)
> > 
> > You're missing an "of_node_put()" before continuing.
> > 
> 
> The node is NULL in this case so of_node_put() is not needed..?

Oh yeah, doing a of_node_put() with a NULL value is are really good idea...

I will pickup this patch.

> 
> Btw, there is a "rsc-table" node->name check in the the end of the loop
> body. It was added recently with commit 5e4c1243071d ("remoteproc:
> imx_rproc: support remote cores booted before Linux Kernel"). Seems to me
> it forgot that of_node_put() is called way before that.
> 

I agree.

> Also commit 61afafe8b938 ("remoteproc: imx_rproc: Fix refcount leak in
> imx_rproc_addr_init") was dealing with the last of_node_put() call here
> but it's still not in the right place I'd say.
>

You mean becaue of node->name being used after the last of_node_put() or is
there something else?

Aleksandr - Can you send another patch for the above?

Thanks,
Mathieu

> > > +			continue;
> > >  		/* Not map vdevbuffer, vdevring region */
> > >  		if (!strncmp(node->name, "vdev", strlen("vdev"))) {
> > >  			of_node_put(node);
> > > -- 
> > > 2.30.2
> > > 
> > > 

