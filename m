Return-Path: <linux-kernel+bounces-285673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5B95111D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95861C22750
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A08C04;
	Wed, 14 Aug 2024 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARmGskPJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB504A02
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596185; cv=none; b=pKKc1aOJusyPnppTPG9o4Q6ZYDkdOmwdc0Zd8jh6zRFZ7An/B0qykXS5YWa0yiKRLqXdz5cnDLMMnVVT6rgiqNRc1Gj8th9lmSxfK6yl++oTxlFBgH4R7JBv2L1aUy4ssDBwgeMYYpkr6Wzss4pSZR/9SviVjdB3EfdS7bbNj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596185; c=relaxed/simple;
	bh=zdtQWhP/q44ASsgIwXBKQbesMKZflcf6Gaq4cnOTTtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRwH1LmY4grsyl8fDTV/wPxgilG5kTAH2yLWiCusqE4v0XM5n1aebtvi8C140Mq7jWSTkqfir8c73DDhW92ECtMkwvbFYY8G3+eQLPchB7K5xmzwaVmbYxKdXY89+zCW7DPLcxR3idFBrhcC06Jy6qOCXkZ29cuq7JcF6ijs1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARmGskPJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723596182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=neqRTcEj9/zj+36l4CNYLscl48VCNlUw8+/D/Uqo/H8=;
	b=ARmGskPJWk+R829I3HxGtOQOak1LavSRpI7w23prpi3gCsUnEdKYd95/GALvefsIpEIvpG
	utIY47uJMA6O6T0JC4cKDJWJqkgzZlhH7WGo1qnOUG8i2Op6d0InWv1HV4U4ypbY+QbrZS
	HDfvJnPXlr3MGtz3/Bn6vlOYZ06xN8k=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-8gt9B5fONjyBeLsHTSMbPw-1; Tue, 13 Aug 2024 20:43:00 -0400
X-MC-Unique: 8gt9B5fONjyBeLsHTSMbPw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5d5ba96af29so6223136eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723596179; x=1724200979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neqRTcEj9/zj+36l4CNYLscl48VCNlUw8+/D/Uqo/H8=;
        b=H0pA8gfPH/ADIU3HWRdATc9w5gdCOshuKh3SOhC2q1dfXI3oxVxwLqHbV2bQsYg8Lv
         efazlMRjQdgEhQbQrWreJXuPqqy2hhdCH1oi37LFy+pwyQo1ZzJxzuFM27fGWqIf9o+4
         i1mTx7EATc0FA+DgWS649ZCztj289OMSElInI27zdmdLgW71eJ33XdeKHrocIm7N8Paw
         AkbmwoBgk7fCWIrC4auKja86ahHzI36waB7Qm1mCkKdpNh4M7yAXptU8jbrA/AYNbaty
         NS7G+UIqozQM0ydSvumAzBXbuAtsP5vcMcgGPsNRkKKc5nOCDmXXeJwRR+tBJUEOAmWq
         z53w==
X-Forwarded-Encrypted: i=1; AJvYcCXknPXRPXLxVgfX7mn1KrVLf6o0TxS3hWqb1kkGhlSXu33IU61T/P1arsArxUZ2CC+JiMwz2TQ7lx3X0f2ZPQsHjmv83QpJP2UPxHTg
X-Gm-Message-State: AOJu0YxaqYXcipxzFMur4Fdb4eQ1QhA58ECS8dRvXKzCA/SEtVgeQ2yS
	29ZQ8TmMON/poHwdEy+XiPxknMj5vovgIne6xNfvkkvM7pFf3R+e1zLJU9Bebv5itW/8VSpth50
	gGdYjsfWNccYJGxoIhYp93SvApJYIaS/adWfsi7d4pYFgPYgYJ7YsiXli7re7NA==
X-Received: by 2002:a05:6358:5709:b0:1aa:bde7:5725 with SMTP id e5c5f4694b2df-1b1aad56c0amr166435155d.28.1723596179305;
        Tue, 13 Aug 2024 17:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTcmIh03e3B7xSn2L7DkI7RRKwpSIiec73Jgf5I9h/tC3e+8R44UqAGwk+9QzPwWzu5FYJxQ==
X-Received: by 2002:a05:6358:5709:b0:1aa:bde7:5725 with SMTP id e5c5f4694b2df-1b1aad56c0amr166433455d.28.1723596179007;
        Tue, 13 Aug 2024 17:42:59 -0700 (PDT)
Received: from x1gen2nano ([184.81.59.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7ded208sm383575085a.89.2024.08.13.17.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 17:42:57 -0700 (PDT)
Date: Tue, 13 Aug 2024 19:42:55 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>, Russell King <linux@armlinux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Fix false "invalid port speed" warning
Message-ID: <lq326y6bjavnvrn4nre2kwetwnu2oiv7rrjbb7iol44xckgu5w@gjaedc7arxxb>
References: <20240809192150.32756-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809192150.32756-1-fancer.lancer@gmail.com>

On Fri, Aug 09, 2024 at 10:21:39PM GMT, Serge Semin wrote:
> If the internal SGMII/TBI/RTBI PCS is available in a DW GMAC or DW QoS Eth
> instance and there is no "snps,ps-speed" property specified (or the
> plat_stmmacenet_data::mac_port_sel_speed field is left zero), then the
> next warning will be printed to the system log:
> 
> > [  294.611899] stmmaceth 1f060000.ethernet: invalid port speed
> 
> By the original intention the "snps,ps-speed" property was supposed to be
> utilized on the platforms with the MAC2MAC link setup to fix the link
> speed with the specified value. But since it's possible to have a device
> with the DW *MAC with the SGMII/TBI/RTBI interface attached to a PHY, then
> the property is actually optional (which is also confirmed by the DW MAC
> DT-bindings). Thus it's absolutely normal to have the
> plat_stmmacenet_data::mac_port_sel_speed field zero initialized indicating
> that there is no need in the MAC-speed fixing and the denoted warning is
> false.
> 
> Fix the warning by permitting the plat_stmmacenet_data::mac_port_sel_speed
> field to have the zero value in case if the internal PCS is available.
> 
> Fixes: 02e57b9d7c8c ("drivers: net: stmmac: add port selection programming")
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


