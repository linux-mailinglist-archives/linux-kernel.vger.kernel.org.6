Return-Path: <linux-kernel+bounces-206134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173A69004B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB6228F5E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F6815B567;
	Fri,  7 Jun 2024 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOciSxvA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D718F2C9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766648; cv=none; b=EeIiXDthttihEdw8Nbq5FQgZ0HJFpVcGARnuqgHeWZXAES9Xl8XeXZkPUZUKnJlYAOWorcckXMZw0o7R7owUGkcm/jNY2jcFyUm1KpYkSE01FKwIRD7se3zQ2n+SD3c87N5F9ATGbBkBGyeOX2lOeAhe8UtE/gIDPeYpHWQ6MJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766648; c=relaxed/simple;
	bh=4sM4q5itO1Eb5xJyANREchHwndiUR9sJ2nfSR/sd0ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQWTbHxYL9qOuTg2MdkfTVHYOBWPXMCvT9HJBD9EdOPSfld4eIFilMRQlRMDzmrhMjB5YUzq8ZF6XUkpuKz9OOYUQ2lzDcaI7nZAsXbiGym0qfI2twlpyvj9vuTGoF6JFHkXCWnWTxQ/kJdGnA0tkmMwghxeI3BVctYRo7eRbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOciSxvA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717766645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0njwWl4Xr7B/zKqo02JfY8aEgwHTV+DbOrvBRuVJ/0=;
	b=YOciSxvAug6nc5BW8/tv2jzIOa+J/QxSBg5IBYPVN8QZw/SC5cgRn3zogtinPRfbGDrsk0
	CQ0tDCJe0L5fCkMk68qowhZnJYSo87Z7UdSuXlOnpaQkWHLGZTAj6//elvQmuKO1DovreD
	NnGqEML9XyXQAWxPaKl3Qm8PzbObshE=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-guVw0NZpObCejEqVaaNV-Q-1; Fri, 07 Jun 2024 09:24:04 -0400
X-MC-Unique: guVw0NZpObCejEqVaaNV-Q-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-25074cbcc9eso1962737fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766644; x=1718371444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0njwWl4Xr7B/zKqo02JfY8aEgwHTV+DbOrvBRuVJ/0=;
        b=f9vZDIdbdwM9nqzGAWkGD7kKyTAZ6JRpPiDtqMPERT+xGyHPMV5ma6iRD+N/13CdWg
         1+m/PGe9rDCkMVy63/TC8uykKc/AHmgR0QNnuy6IwFLxXydjnIzY+Janv2JBWMdLIOJK
         k6lqEcAkhaTmM0a+siZzugiv6pBblfu9CTGBv8CyeD9r/JyyNbi9tB8T9u4fJK00djPt
         /T7FBmUnPtsnmRU7kgBSWlk3PumMld3NwpO56ecUdIwGBvM48mKJJjUL6pAEfaiZ7R5N
         Gnt4lBEU5kqHykuMDwm07dAFckMS/nSR9Zu7M6dWK3Cju5LhFWVNFhXrwHyBipwxvB8G
         NsDg==
X-Forwarded-Encrypted: i=1; AJvYcCXFQMuqCIu+XXh5fJkODoK5FJ9O6qnBiF9f6Uki9aT6qWqrAi832hPOAHZ/S4q7M8Z8augIlpR1RYLrIx7Cfkec7GF5jncixsVnKwe7
X-Gm-Message-State: AOJu0Yxi1fY/u9p2SbS7cH847reUPX614AUaPV4S5Bx5k/tRPCAPE5tQ
	IkAPVP8PHtnHXUVtcLNzNXtRVGV8oG5J7VU4ZDEJSWmb1cEfOrGC0ypLHuTEf9c/Yuqe0OIAiqf
	N6evPi0lvhgoLlHM3koOvtoSILAmDcYfGezatf1ZKBwjwvJtGU0pUIssy1yyOVw==
X-Received: by 2002:a05:6870:1647:b0:250:7f7e:fa6a with SMTP id 586e51a60fabf-254644ebe85mr2654540fac.23.1717766643654;
        Fri, 07 Jun 2024 06:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwA2CSDWzl4DWmECTbOWHWFKZGJkdSO88z6FFhYWwsyVS9MiJccFJLIeEIllG1fQtMcqXfeA==
X-Received: by 2002:a05:6870:1647:b0:250:7f7e:fa6a with SMTP id 586e51a60fabf-254644ebe85mr2654518fac.23.1717766643236;
        Fri, 07 Jun 2024 06:24:03 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795332e2111sm163946885a.133.2024.06.07.06.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:24:02 -0700 (PDT)
Date: Fri, 7 Jun 2024 08:24:00 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jochen Henneberg <jh@henneberg-systemdesign.com>, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v2] net: stmmac: dwmac-qcom-ethqos: Configure host
 DMA width
Message-ID: <jtalwaityx7fyakigggyahhhor23fml76yic3e3xkeoimdqoj2@i7fiqzacowq3>
References: <20240605-configure_ethernet_host_dma_width-v2-1-4cc34edfa388@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-configure_ethernet_host_dma_width-v2-1-4cc34edfa388@quicinc.com>

On Wed, Jun 05, 2024 at 11:57:18AM GMT, Sagar Cheluvegowda wrote:
> Commit 070246e4674b ("net: stmmac: Fix for mismatched host/device DMA
> address width") added support in the stmmac driver for platform drivers
> to indicate the host DMA width, but left it up to authors of the
> specific platforms to indicate if their width differed from the addr64
> register read from the MAC itself.
> 
> Qualcomm's EMAC4 integration supports only up to 36 bit width (as
> opposed to the addr64 register indicating 40 bit width). Let's indicate
> that in the platform driver to avoid a scenario where the driver will
> allocate descriptors of size that is supported by the CPU which in our
> case is 36 bit, but as the addr64 register is still capable of 40 bits
> the device will use two descriptors as one address.
> 
> Fixes: 8c4d92e82d50 ("net: stmmac: dwmac-qcom-ethqos: add support for emac4 on sa8775p platforms")
> Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
> Changes in v2:
> Fix commit message to include a commit body
> Replace the proper fixes tag
> Remove the change-Id
> - Link to v1: https://lore.kernel.org/r/20240529-configure_ethernet_host_dma_width-v1-1-3f2707851adf@quicinc.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index e254b21fdb59..65d7370b47d5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -93,6 +93,7 @@ struct ethqos_emac_driver_data {
>  	bool has_emac_ge_3;
>  	const char *link_clk_name;
>  	bool has_integrated_pcs;
> +	u32 dma_addr_width;
>  	struct dwmac4_addrs dwmac4_addrs;
>  };
>  
> @@ -276,6 +277,7 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
>  	.has_emac_ge_3 = true,
>  	.link_clk_name = "phyaux",
>  	.has_integrated_pcs = true,
> +	.dma_addr_width = 36,
>  	.dwmac4_addrs = {
>  		.dma_chan = 0x00008100,
>  		.dma_chan_offset = 0x1000,
> @@ -845,6 +847,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		plat_dat->flags |= STMMAC_FLAG_RX_CLK_RUNS_IN_LPI;
>  	if (data->has_integrated_pcs)
>  		plat_dat->flags |= STMMAC_FLAG_HAS_INTEGRATED_PCS;
> +	if (data->dma_addr_width)
> +		plat_dat->host_dma_width = data->dma_addr_width;
>  
>  	if (ethqos->serdes_phy) {
>  		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
> 
> ---
> base-commit: 1b10b390d945a19747d75b34a6e01035ac7b9155
> change-id: 20240515-configure_ethernet_host_dma_width-c619d552992d
> 
> Best regards,
> -- 
> Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> 


