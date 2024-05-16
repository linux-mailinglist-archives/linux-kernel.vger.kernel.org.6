Return-Path: <linux-kernel+bounces-181159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062898C7851
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003E2280ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C014A097;
	Thu, 16 May 2024 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iau85TuQ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EFB147C6E;
	Thu, 16 May 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868846; cv=none; b=YYs/V5fjMNNnUvBl+bLglSLkSLgo83Vo15ZVKNx9uIaW1LAKDvvDJlunM+G4uKTd4WuRr5Nn9xgCn4Pxp3UjAYB/ymaj0HD6EMxbyfSrIO+45lpsGjsri/Sj+3es1z/b78HxH1nv/3Oo8Lf3WLb1uEITKYmea6Ij0muqNY4luV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868846; c=relaxed/simple;
	bh=DljRi1gAVLhNjMhkBNML4Mys92kIb7fRsmAUlbeVYeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm8WzyIP56aif0YLpV+A54K7lJtmiks5EhwV7gZ5GJxRTqxLMCBXpyzHBreW/SZKnZMalkFxjRsKerphenKTKrQyFTSSJzD6bCh8JREsx5EOX3A0ZJfsgf4crIQ5xAQlLCLEBRgeE9HXRdr8wgpuLcL6kI+ZhmDR1eclITlAdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iau85TuQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=srq/5gaQL99coY1BQJnPkM6P8FfTUHHR+hVB7Lf6F+M=; b=iau85TuQEkJez5Yl3zhXy2V6Cg
	yFX5SZvFaO+fP924k3+pywvz67iHXYoT2e+58jXEMk4aB5F2A+U3Dgat/crReZ53l4ZYfN1YXtFw4
	YHVyw3r+SSli9XzIohJI9knG7Z/0cop7BaY34DHbb3pYNeVFmCtwaz415hcw3grKvryI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7bra-00FW3d-Qz; Thu, 16 May 2024 16:13:42 +0200
Date: Thu, 16 May 2024 16:13:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] net: smc91x: Fix pointer types
Message-ID: <b15d7689-0385-4d9c-b5e0-afc525ac9578@lunn.ch>
References: <20240516121142.181934-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516121142.181934-3-thorsten.blum@toblux.com>

> -#define SMC_PUSH_DATA(lp, p, l)					\
> +#define SMC_PUSH_DATA(lp, p, l)						\
>  	do {								\
> -		if (SMC_32BIT(lp)) {				\
> +		void __iomem *__ioaddr = ioaddr;			\

ioaddr is not a parameter passed to this macro. 

> +		if (SMC_32BIT(lp)) {					\
>  			void *__ptr = (p);				\
>  			int __len = (l);				\
> -			void __iomem *__ioaddr = ioaddr;		\
>  			if (__len >= 2 && (unsigned long)__ptr & 2) {	\
>  				__len -= 2;				\
> -				SMC_outsw(ioaddr, DATA_REG(lp), __ptr, 1); \
> +				SMC_outsw(__ioaddr, DATA_REG(lp), __ptr, 1); \

You probably should use lp->base here, which is passed into this
macro, and should have the correct type.

> @@ -1072,7 +1072,7 @@ static const char * chip_ids[ 16 ] =  {
>  				 */					\
>  				__ptr -= 2;				\
>  				__len += 2;				\
> -				SMC_SET_PTR(lp,			\
> +				SMC_SET_PTR(lp,				\
>  					2|PTR_READ|PTR_RCV|PTR_AUTOINC); \
>  			}						\
>  			if (SMC_CAN_USE_DATACS && lp->datacs)		\

This is just a whitespace change. Please put that into a different
patch.

	Andrew

