Return-Path: <linux-kernel+bounces-568404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F6A694F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FACF19C7E34
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1681DF72F;
	Wed, 19 Mar 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q/JguylS"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69E1DE899
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401659; cv=none; b=apjbd8WSMrUjiMp5OhjCUep7NdV02qAEtiY5HNyo/kd+SyZZ5rwiKS5hSExQ3BQwW78XJXZvI3odGIE9a5SdzmH0xdDraeOUuNV0YpATtUv9uVuNbOFhgVcew9Vdh6kTyH+8Zc4ha1ULZNGjUEYIUcMdvSXMcoyle2LXd/57xsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401659; c=relaxed/simple;
	bh=861KZ/v/MNaCvdfgulmkMSG+2pyydvhoHYZdDNeaHVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkQO/CIS46sCQplGzPGEbmysWUBcLxGbIIM650lykjxgnMgy6d5vKkKvFMd7nk1Xte+qebblv6sCr/Z2yNe/Lq5aCLG/bDmDXDOShqmn84HDOqKvImyPy24k+eJ6CamEru/5DNpZVMHTqSK53MXQCPaslVOW49LkRHPuIM6U9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q/JguylS; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476ac73c76fso69025071cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742401655; x=1743006455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZQzSC8a1gBcckIEyeBizPuOhyfX7HkjAwSrwZqw84Y=;
        b=Q/JguylStbewD2Mnb2WGx6pCH1LmogARij2+Fv071o/HqUrtjSKgTFcniXOJRVi0zm
         kfAQShYWxZxDqhQYUxf58cyr9Hqud2zxaeLsMAyxa8GpU/c8spJFiVtOljbfZs3JrRqP
         E2MJPkbNCp7G+gHOfp2nf3vQy8O26xnUXSD+JO8mhzMJp74P6tofMvn2ApHiaYvrBUwE
         BfmrMuJ5d32Imvm+mQWLwpEK5x4dcvzOsc/ffHvhJlmbPk1ZDRmsLHoChryZwJmo+VL8
         t30YAR2SYC0/8uCktd+1YP5iT2BMgpOS/X/a24LdIaWuDs4BrvNXI8LxDrO7RdVVnbMJ
         t5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401655; x=1743006455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZQzSC8a1gBcckIEyeBizPuOhyfX7HkjAwSrwZqw84Y=;
        b=VOq9Fpz2gKCGojIrbRA/R4uclChsa/k4wt5jNifMCZz+vyrQ4Ys07tmOx6+ZUG+TV3
         Zdt1N6gycaE9GexCEogKW4aDAqRpTu9TFmvBWheLn4O9n1tMqc3vhiFRkyJmnBgrSQpC
         kX5EzutPHFm/xysRFXnKvsGjh39MOBK0qR6uBD3MIU8F9o4uk3XB/33djNQ4ublUdjWQ
         B15TDthT0j1VtwdD+oQRW6UNnq8sm1l4MafbCi3uuq9ndAMfCs/npptoIgkVnWDa3e3D
         9+1WzwUT43RJfZFKY8OirWH2cCrZPTNut5ZLlPlQa/T+6trbB8cVJJ793bJcUOst0jQ4
         V4pg==
X-Forwarded-Encrypted: i=1; AJvYcCUqFBRBfY4nmQzfm+/jr8e/cK099JDCRCdZAMynGvJfgNwYDk67vaGJFBqMgWEl5bvKw92XLloNMlb4Wjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg5qlN7b3k7kSh+UhQ9LCvhOlbQWfBx4NMU6oW/tzOTciO8GEn
	2MMzSCETLbueQKPXAxvxQGUafz+i2sTV2lpUmw0XwOl7onwCrtQmSVladaav7Cw=
X-Gm-Gg: ASbGncsxvB2Bi0xYSgEWTea0G3JyxyqCvf41oaKNw+KHRJBM33FGKiANT03lnhvruqr
	76H7QXmtruTVwNv6PUtYpEugYOZXrNpW1B24JKf0ItWZfXNBtscAXuEX852M/AHTz12xTvAAZit
	FP65ImA0KwvLs2LHWw6hMOR6gQlBwH/qiQNIhIlJhF9enSR97SIIakM/cwKfTTD2DMyGauzWfJA
	1UNJB8hTQEUSmBGLxn9QoMkHXwL342/bNxYqUKwyFJZT0vs4thh5URIPwxyUXZQfGI7/cMHMphY
	14b50nBTKuRMrwSckVhSaA6OLB/gh4MkpoTfswXc+u1EUMREuVn1Ubu7d0S83JfMiAOdVUo7qAU
	+tA+mVdhY8UTpj7AQYw==
X-Google-Smtp-Source: AGHT+IHPt9cwLnClhhTzeAYHEY3JKm4ml3GTboDl8SFxdRoEZ9M5TgGWgwNpQwQACershsnWxLdGjA==
X-Received: by 2002:a05:622a:2b48:b0:476:8db0:8caf with SMTP id d75a77b69052e-47710ca8e23mr1951951cf.1.1742401655076;
        Wed, 19 Mar 2025 09:27:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63baabsm82354151cf.28.2025.03.19.09.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:27:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuwGU-00000000Vpp-03X3;
	Wed, 19 Mar 2025 13:27:34 -0300
Date: Wed, 19 Mar 2025 13:27:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] pds_fwctl: Fix a NULL vs IS_ERR() check in
 pdsfc_validate_rpc()
Message-ID: <20250319162733.GE10600@ziepe.ca>
References: <925355aa-c98b-4fa7-8e49-b97f6d551a86@stanley.mountain>
 <b9f49f34-1a69-41bc-8324-2e969e53f9eb@amd.com>
 <f391dc76-946f-45c2-af81-a5cb107ec783@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f391dc76-946f-45c2-af81-a5cb107ec783@stanley.mountain>

On Wed, Mar 19, 2025 at 07:26:10PM +0300, Dan Carpenter wrote:
> On Wed, Mar 19, 2025 at 09:18:31AM -0700, Nelson, Shannon wrote:
> > On 3/19/2025 12:06 AM, Dan Carpenter wrote:
> > > 
> > > The pdsfc_get_operations() function returns error pointers, it doesn't
> > > return NULL.  However, the "ep_info->operations" pointer should be set
> > > to either a valid pointer or NULL because the rest of the driver checks
> > > for that.
> > > 
> > > Fixes: 804294d75ac5 ("pds_fwctl: add rpc and query support")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > 
> > Hi Dan, thanks for this patch.  We also have this same fix in the patchset
> > update that I was expecting to push out today, but you beat me to it.
> > 
> > Shall I continue with our v4 patchset, or should I now be sending smaller
> > patches to update from earlier review comments?
> > 
> 
> I don't track how these things are merged.  If you were going to fix
> it in a v4 patchset then just ignore this patch.  Typically in that
> case you would fold the fix into the patchset anyway.

Right, please just send v4 and include a fix Dan's report.

Thanks,
Jason

