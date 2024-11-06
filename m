Return-Path: <linux-kernel+bounces-397955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435D69BE2F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2342847AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40271DACAF;
	Wed,  6 Nov 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="D4LdaYL7"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71A1D2784;
	Wed,  6 Nov 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886250; cv=none; b=uvp2/fXUqg1XyjzNHHCNXSRcmiGYLhFPQG+p8eedIfYbTBjNAgMfYtoZjoH5oLGb+RawnttX4sZQdzDD2BgJjB/znm7CKQFOFmXENeUrX6R/Bm76OXRhi49MbYufd4m/65jvNbKWil1D9jDvjk+D7zXTnPdRrb2U7sEIO4v7rH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886250; c=relaxed/simple;
	bh=qpvIF5bBMn6fjijfJvJmrNnTtvGt1KcrPHRFWsxDUFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXlQGmh15dvPHH0EtfJOcxixK86F/f0cva/uiLovamWw6mcNzJrZ7ENEiolcSnOzU2s74yfSnSNb63ksJOnCZatI27svcaFLNY2xdt0hlrqNw31hZTXprc9OB80B11988lmPQKCNyGjEb7FXbBvvA+xWuplyL+YkkyDAaLBu7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=D4LdaYL7; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=55zvySz6mffWQ+++ZbZ/oF+SBTtaOs4T74NYodmXzqA=; b=D4LdaYL70wPDH+ZYvWP1kv/GRX
	86a/H/2vzVYvjhlAmVf5xv5Pzb2T6Myj9Q2aNBx/kDUYkMOFIXvJY1pjNXQh/pYn0xxnPGVE8T9GG
	lBp2unVeZVU/h83ROlppwJ4hUcwhqp3i1EdbRdnaWNsXFS0sff+CYBSSTgUkPqZzGPcacaSlGZPum
	PKyqSfOIZ6VbeiQjC68KiNA7VyJsEoRZY+A3tc52HmlSb5oe6sr6PPz2VpRvsK/fMZ50AJpgyxK7v
	yeGZIDtJOBOEit6X0qRZ1Blr19HP6iWXZ3X2O5SxDZwJ9NdF1mmNIVNKqWyJnC+7Vfy1lP9g8AwO6
	MR9oZnAQ==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t8ca4-000639-VL; Wed, 06 Nov 2024 10:44:05 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>
Subject:
 Re: [RESEND PATCH v3 2/2] phy: rockchip-naneng-combo: add rk3576 support
Date: Wed, 06 Nov 2024 10:44:04 +0100
Message-ID: <1809753.VLH7GnMWUR@diego>
In-Reply-To: <20241106021357.19782-2-frawang.cn@gmail.com>
References:
 <20241106021357.19782-1-frawang.cn@gmail.com>
 <20241106021357.19782-2-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 6. November 2024, 03:13:57 CET schrieb Frank Wang:
> From: Kever Yang <kever.yang@rock-chips.com>
> 
> Rockchip RK3576 integrates two naneng-combo PHY, PHY0 is used for
> PCIE and SATA, PHY1 is used for PCIE, SATA and USB3.
> 
> This adds device specific data support.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

With less magic values, everything looks a bit nicer now, thanks a lot.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



