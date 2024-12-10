Return-Path: <linux-kernel+bounces-439977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCC49EB6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B0B168149
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA071A76AC;
	Tue, 10 Dec 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBwH5guz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA222FE03;
	Tue, 10 Dec 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849286; cv=none; b=DD7GzicB/CcAeqmqFmu7WT3fKLdYUhxKyAJxY2gIZOEo+S2uoHmB1lbGqeO3e+5npgXuPiMtIjhthovbvjnIOaA/+r/LykD8KvOcuFepMHK17YBV1C3TUL6tD/x9s21VYVmymEH0BO4mx+C9uS/qReoRstvxgx2mGcP/gKftjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849286; c=relaxed/simple;
	bh=FMfWM6Y9s+rwrC3upwCiV+b+s/ByE6z8taj2rlKoDn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWSQTJyClebm0ZoYv7xPWRtzgTXNxC5qlrSveuwuf30lCyVQz6pb4FQxRnTTabNiScjt5a1brp3BUA5gijphmeUKDpNu235ZTjQ48yitVJMs3VGVBzrRNjLCOrh4qy/3p2o0qHwHAEXcIPFF0eiX/pz6fJc+TPJT63LpW3gf7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBwH5guz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AA9C4CED6;
	Tue, 10 Dec 2024 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733849286;
	bh=FMfWM6Y9s+rwrC3upwCiV+b+s/ByE6z8taj2rlKoDn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBwH5guzxXhBqhtgCAPQa98tB5jcGCfzz0ig/4vhMGcWKAyG8TKKLX1qJDaTnplUR
	 j1Z2ZxvBgQPEVRjrrWd0LcOMcNeP/GXGO1iImQ/fRR5Kw+eGVc20/hmhEyghEsZuPG
	 frVlv2fp1kg89UpCWMaNydEDbUY+5cxRziyQ1WdGGLIe+3vA4oGYpXELAM4+Vi6Xhc
	 zi+NrNAF954dm1BQkCcKcHILXVZB3h+vjDn3T1GyzbQm0dMxCtvEijTiM3500yFUKN
	 6oVo1gs3ZNjUTYxOGBnK3oW1jbL5iYEv4Bg7MIVXwBey92yiOdrbavYwS9Oxw0FHwb
	 4rZtXMsFD2Cbw==
Date: Tue, 10 Dec 2024 10:48:04 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Stefan Wiehler <stefan.wiehler@nokia.com>,
	Grant Likely <grant.likely@linaro.org>,
	Tony Lindgren <tony@atomide.com>, Kumar Gala <galak@codeaurora.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jamie Iles <jamie@jamieiles.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 2/8] of/irq: Correct element count for array @dummy_imask
 in API of_irq_parse_raw()
Message-ID: <20241210164804.GA3771389-robh@kernel.org>
References: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
 <20241209-of_irq_fix-v1-2-782f1419c8a1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-of_irq_fix-v1-2-782f1419c8a1@quicinc.com>

On Mon, Dec 09, 2024 at 09:25:00PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Array @dummy_imask only needs MAX_PHANDLE_ARGS elements, but it actually
> has (MAX_PHANDLE_ARGS + 1) elements.
> 
> Fix by using (MAX_PHANDLE_ARGS - 1) as max element index in initializer.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob

