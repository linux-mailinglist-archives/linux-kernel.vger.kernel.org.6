Return-Path: <linux-kernel+bounces-381137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16F9AFADE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEBA1C2241B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9F1B21A7;
	Fri, 25 Oct 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IovrI5Gl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F514D8C8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840781; cv=none; b=ns8KG2WyfjwsA2uznn0G/TUhYhaHN4/J6urz7m1FohdNVr749zYLBrxBtDhU1v542kUYt8MWffl6QK0Q7Zni/4qpFdYzWB8z4Nb9HIFddsw95Ptrd9NAqb/n8wpggk8NhWMds9njUJgGlKwtxwVBXU9z5HUzlZr/6dUcyUymaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840781; c=relaxed/simple;
	bh=/wSStfEhPSHeZJiEUePtTfIBSJEUMkwEljOu59Vn9no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFn1U40yH7rAx7brK2PzQp4Km16xr6GpjWKt9qweKxJ5RQr+haozBUBSckkVrjpuTlFHZKdTvcJtoRtoqvIxJjLhmw0+HZ5+tzL+0R8V5UPNYjVUIRb1bLh5gmdaieVsP+cQqzBU6edjnqbC1APZ81qfk/D/uW/c2XXmMdGiJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IovrI5Gl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43161c0068bso17302295e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729840777; x=1730445577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3bss9bc42ivC2cChRotwSlxrtitEdG/EsNtcIe7xud4=;
        b=IovrI5GlqpD/bEsLkANXE4tsafEhlYseEUpxh7cEtqusFB4JSm10Y8Notj3XnGeKBi
         x4iTf/MCce+P+pXCeDrW+rwVcx0rQxTCW+IUGAXWD+q5Ce0O3AVyZO26couMYHhzaiCm
         KqBn+n0D73c04FqeHMohCbwkubd91J63JFwKy+OMHfOW8mZP7hteuPjYX+V0EMQNZDE8
         ySgYNAVbQFXbVIlni1BSQnN4CTVpOEPBl48jBmkA6lMb8jkKawxpzYts5zo/3MVr+ISu
         m/HTKvYg4L7uj2sqBME+clDBpKm/EMsR8vL8opwAywswFl5P/ZvaQ98IneXHpobJYUzm
         YSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729840777; x=1730445577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bss9bc42ivC2cChRotwSlxrtitEdG/EsNtcIe7xud4=;
        b=eCRNtxSZbRhyjbp7tw+gTzo/4zUaPdj4gT9+U8sEn6mtRu0jCb5MDNsxE5KtNTfSuO
         gnMaJLez+s6ayHvOOqecwHZdsWtFhTZS9L76wQz9iUqbXIBAU3sivyJp7dmCPJ644SON
         /SqpBImZl+Qx+v7u6tqBJmmg/eJBgJNHa1e3DDTYbfPaxj4UpxO9dwkcXMeFRDoGrv9b
         TqjsksP+Gs59eCl4HovOFCcA7mVJx3kQKDdX4kohRvBsRsoM7pb/TQKGy3zT03xBkqaC
         BHOJ4x5InJdemxTjqc559UgCmAW+qlHMnQfjlaZWK1u22cuP4/j+hgF4Wn3p+GtYpNrc
         PJwg==
X-Forwarded-Encrypted: i=1; AJvYcCVlOt5NCUU0QqycM8NXKD6+TnAuD072SkpbgYZYJDiOAGN8UXUbHIMHUQMW8HW5klr1cOfsX/dhhdcI7YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1bJ4d5iP43C5SS+TV6c5WGUs0rDrGQZBN8KadxrzB0Cwsd8K
	5Cs4TyGHZVOJRcVoa4r3wV89njc6Gdw0Fv4irytsVfmQcJTPrLpkPMJjZyverPI=
X-Google-Smtp-Source: AGHT+IHNFvL9ngLdJ2Ef8zFL1tFE3yh5k72SJ5sriFGjDAW8ul7HkN6Susi0cERRtc5r9wYwLcmsfw==
X-Received: by 2002:a05:600c:19c7:b0:431:5ce5:4864 with SMTP id 5b1f17b1804b1-43184254536mr60334325e9.35.1729840777477;
        Fri, 25 Oct 2024 00:19:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b579613sm39381865e9.38.2024.10.25.00.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:19:36 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:19:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, philipp.g.hortmann@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: staging: rtl8723bs: change remaining printk to proper api
Message-ID: <e12bc7eb-07ed-4bec-84f7-5b178ba802c2@stanley.mountain>
References: <f61d8272-4af3-40d6-a333-e7731c3fc5ae@stanley.mountain>
 <20241024225512.7464-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024225512.7464-1-rodrigo.gobbi.7@gmail.com>

On Thu, Oct 24, 2024 at 07:55:12PM -0300, Rodrigo Gobbi wrote:
> First, tks for the answer, Dan.
> 
> > little broken with -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA, maybe we can 
> > fix that in a next patch. 
> > How is it broken?
> 
> make -j<> ./drivers/staging/rtl8723bs/r8723bs.ko EXTRA_CFLAGS="-DDBG_RX_SIGNAL_DISPLAY_RAW_DATA"

Why are you pasing -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA?  Is there some document
somewhere which says to do that?  Normally we would just say "Nothing ever
enables DDBG_RX_SIGNAL_DISPLAY_RAW_DATA so just delete that code" and delete
it.  But if there is some external document which says to enable it, and it's
useful stuff then maybe we should keep it?

> 
> drivers/staging/rtl8723bs/hal/hal_com.c: In function ‘rtw_store_phy_info’:
> drivers/staging/rtl8723bs/hal/hal_com.c:927:43: error: ‘PODM_PHY_INFO_T’ undeclared (first use in this function)
>   927 |         struct odm_phy_info *pPhyInfo  = (PODM_PHY_INFO_T)(&pattrib->phy_info);
>       |                                           ^~~~~~~~~~~~~~~
> drivers/staging/rtl8723bs/hal/hal_com.c:927:43: note: each undeclared identifier is reported only once for each function it appears in
> drivers/staging/rtl8723bs/hal/hal_com.c:940:73: error: ‘struct odm_phy_info’ has no member named ‘RxPwr’; did you mean ‘rx_pwr’?
>   940 |                         psample_pkt_rssi->ofdm_pwr[rf_path] = pPhyInfo->RxPwr[rf_path];
>       |                                                                         ^~~~~
>       |                                                                         rx_pwr
> drivers/staging/rtl8723bs/hal/hal_com.c:941:71: error: ‘struct odm_phy_info’ has no member named ‘RxSNR’
>   941 |                         psample_pkt_rssi->ofdm_snr[rf_path] = pPhyInfo->RxSNR[rf_path];
> 
> Actually it's not exaclty in the same line of pr_debug/netdev_dbg replacement. Do you think
> we can do the replacement at:
> 

This has nothing to do with pr_debug/netdev_dbg replacement as you say.

On the other hand, how useful can DDBG_RX_SIGNAL_DISPLAY_RAW_DATA be if it
doesn't compile?  If you sent a patch to delete it, we will apply that patch.

> > +			pr_debug(", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",...
> 
> regardless of this build errors? I mean, fixing it here in this patch
> would not be related to the purpose of this simple patch.
> 
> > Just delete this line.
> Ok.
> 
> > -		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
> > +		pr_crit("%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
> >                ^^^^^^^?
> 
> Originally, I didn't replace this because at dvobj of sdio_alloc_irq(struct dvobj_priv *dvobj)  
> there are two adapter fields:
> 
> struct dvobj_priv {
> 	struct adapter *if1; /* PRIMARY_ADAPTER */
> ...
> 	struct adapter *padapters;
> ...
> }
> 
> Checking the "counter part" function of sdio_alloc_irq(), the sdio_free_irq() (which is not used), 
> the if1 (primary) is used for debug purpose:

If it's not used, just delete it?

> 
> netdev_err(dvobj->if1->pnetdev...
> 
> And checking the initialization path, if1 should be ok at this point.
> But since I can't test this, do you suggest to replace anyway?

Most drivers/staging patches are not tested before sending.  The printk
conversions are a leading source of bugs.  The common bug with these conversions
looks like this:

	if (!dev)
		netdev_err(dev, "no device\n");

Anyway, it's fine to send untested patches so long as you've looked at the
initialization path and it's okay as you said.

regards,
dan carpenter


