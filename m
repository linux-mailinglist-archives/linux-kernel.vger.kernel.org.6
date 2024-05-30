Return-Path: <linux-kernel+bounces-195399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB4A8D4C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F42284A00
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2C183060;
	Thu, 30 May 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ED8paIrY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855617CA10
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074067; cv=none; b=cjh9VRsQvsyIgbcvp3TAbfAQGTId/qUyfqsxO6N5+zI3djmBdYqoM3PeJpTsHoC6TghAywRzq4PTClAYMZ5DCjcsv8xK7VhqJJITUhKlFcjaCiC+Kyj2OaFw4gHDBLylbPornX1Lk2xjFYPMtbN/noBNNzn7Mjwk1jcVkdxtvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074067; c=relaxed/simple;
	bh=QbG0ygvFhemxwXbo8UH3vbamKCGJA+4BeTD1i2CVlnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mySV7eKe/Cjmt8CZ+hMT9/Xjob2pvHt+e4iLAr0zH8b93ryCDFvLfx1hySyWPVtiP3Jpm54lQhZL8ChyS23slVIm/P+Wv7xrEj5lsXCjWZ/d8Y3s93qxlz4fEqWMxGkRTXc2/XQ4EdQKSCemmEuvDFSOyOW4V090IKJXOnqPgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ED8paIrY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717074065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qH6bqXZWDj2VvkhQa8r0x2CDiDZr/N+uYFn9yj//1U=;
	b=ED8paIrYZWhr4SIW2g1q+PCn8bQ7osKJaRdKp8lT4MvvwYdT/ydcskt2lk+LJpnaoxDWxV
	LVCpyXtamtEEbTJDvFQM25zQamDPAJhs85LptYY+QsZPnbm1hzNojN2s332h1qHMWMi69M
	0iE+zYKFttKEEqEgdV+7dLlUcxJXNqw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-bls7KdYsPWmsqtLQu_quZw-1; Thu, 30 May 2024 09:01:03 -0400
X-MC-Unique: bls7KdYsPWmsqtLQu_quZw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43fb02db6d2so8923751cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074063; x=1717678863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qH6bqXZWDj2VvkhQa8r0x2CDiDZr/N+uYFn9yj//1U=;
        b=Fr91aO6a2rkG5/2+D8/4b2TEr5LbFRkWUntgp3E3GZ1YE3nH1fPbmU/mTXYBixUNxV
         eUkeiePCYORR7XVZZNbPdScXMs+dY8M9+Qlj0HMKUdS90/ZfvsCrCDj2+ObbrYbZLHu1
         c5YarWy59RfUwZHwDvMea0CzsmePPPnevbg0uCQrmi4s/0SbyIuFyotPIuSqM+LctNjH
         Sb1nKuSidhPF9kMagscSTD1HwmGD4BEcV65+xNMe87y9FC8LGe3Nd1fE5JpyZqrLWq4Y
         GWLxPzWurnl7UXyzuVVRPtvI9PrTCrSacHxh69FD9cGopqh2Ag1ibHLvDRkbBdgxgi7R
         VYww==
X-Forwarded-Encrypted: i=1; AJvYcCVhAoLYLhMVk1MsJJ4M1ljG+9dBCl+XNKPMrnS2sBdfHQSHgAD4mkZgIUXfEO45ZyQ2lUC/3ZzdfGgSEhZfoBLxNdJ2ztxFkdLcE5gt
X-Gm-Message-State: AOJu0Yz3SvFNB/+0fnFjrIfd/zJIFO4wOJZ2FvQZd2ymdTekKPbIpTwY
	/GrjNSwph71bQjNyZl1dtB6m43c/UCv8jn31SYIbsMKx4/peWJQ5vAVq0t+pRhddGdI5+b37yur
	s71usGrjw0+Wz5MnNI0iIW6WSNSmXGlajWTS/Cm1nlov82wk7ot1qyE+gKwL/FdsMrD1vWw==
X-Received: by 2002:a05:622a:83:b0:43e:3d8b:b6b9 with SMTP id d75a77b69052e-43fe930e9e0mr21741941cf.44.1717074061989;
        Thu, 30 May 2024 06:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmqMkYgzTY+K+MR+AsBjg7npPdMxiUXyD3C6fsmskBzvTeam+eNVGfcssNbpZMomvAfvLBqQ==
X-Received: by 2002:a05:622a:83:b0:43e:3d8b:b6b9 with SMTP id d75a77b69052e-43fe930e9e0mr21741561cf.44.1717074061340;
        Thu, 30 May 2024 06:01:01 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18b0e3bsm65135651cf.68.2024.05.30.06.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:01:00 -0700 (PDT)
Date: Thu, 30 May 2024 08:00:58 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Jochen Henneberg <jh@henneberg-systemdesign.com>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac-qcom-ethqos: Configure host DMA width
Message-ID: <busrdvbjh7eigqgpgwl4k5tergt263gfjcpti7jutdyk37cnse@iotdvflbsca6>
References: <20240529-configure_ethernet_host_dma_width-v1-1-3f2707851adf@quicinc.com>
 <7w5bibuejmd5kg3ssozaql4urews26kpj57zvsaoq2pva3vrlo@agfxwq5i65pc>
 <d8ad4e59-5725-4a7d-a2ad-ce5d92553525@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ad4e59-5725-4a7d-a2ad-ce5d92553525@lunn.ch>

On Thu, May 30, 2024 at 12:22:52AM GMT, Andrew Lunn wrote:
> On Wed, May 29, 2024 at 03:50:28PM -0500, Andrew Halaney wrote:
> > $Subject should be have [PATCH net] since this targets the net tree:
> > 
> > https://docs.kernel.org/process/maintainer-netdev.html
> > 
> > On Wed, May 29, 2024 at 11:39:04AM GMT, Sagar Cheluvegowda wrote:
> > > Fixes: 070246e4674b ("net: stmmac: Fix for mismatched host/device DMA address width")
> > > Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> 
> > Also, I think the Fixes: here would be for adding support for this SoC
> > in the driver, not what's listed? Might make more sense after you have a
> > proper body though.
> 
> This is a tricky one. 
> 
> Fixes: 070246e4674b ("net: stmmac: Fix for mismatched host/device DMA
> address width") is when support for different DMA address widths was
> added. This fix cannot easily be back ported past that.
> 
> 070246e4674b first appears in v6.3-rc4.
> 
> dwmac-qcom-ethqos.c first appears in v5.1-rc1. However, Qualcomm did
> not start hacking on it until v6.7-rc6. It is unclear to me without a
> deep dive when Qualcomm actually started using this driver.
> 
> We might actually be looking at this the wrong way, and should in fact
> be looking at when a DT patch was added that made use of the driver,
> not the driver itself. If it was not used, it cannot be broken....
> 

I should have been more specific, sorry.

I think this should be:

    Fixes: 8c4d92e82d500 ("net: stmmac: dwmac-qcom-ethqos: add support for emac4 on sa8775p platforms")

Which appears after 070246e4674b ("net: stmmac: Fix for mismatched host/device DMA address width").

Reason being that specifically Sagar's patch is indicating that for the
SoC's/compatibles that currently use emac_v4_0_0_data structure, the DMA
address width needs to be specified.

If we were modifying structs that were added prior to 070246e4674b then
I agree, but at least the change as is I think could indicate the above
Fixes.

Thanks,
Andrew


