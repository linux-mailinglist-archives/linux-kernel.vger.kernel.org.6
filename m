Return-Path: <linux-kernel+bounces-374685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B4E9A6E86
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8156C282C50
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C5B1C462A;
	Mon, 21 Oct 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="AqyZg8lC"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A4131182;
	Mon, 21 Oct 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525495; cv=none; b=OdeHTBPd7skwd7Kf2Fym41PZcMZDCmDk0l9yDEaMuKf3eFncsBYUR3dOmdBgFRIyc9wSOn7khiEZ+ezJH3+qb9EuOImPc5k97n7B87v/4vdV4GAoCF+4+x+IBkwR/G6UyFxH08wIVdMQiUhpAj2H57DII+uZ1WhCpqShn+D5t7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525495; c=relaxed/simple;
	bh=Cjc06XI2GhWJ6FI2E1qR0/8bohtKy1vZnU1ehiTblu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yzn5BFfiBviMQac+3eEmvNntEWUHlnwPQ903W/lThf/x2lZS/jLqgKfDEUJIpq19qvzZlg9LnRf3v861tRzH4X0S441HB2XlzHvElc1jg9AaXh0olc4oREWXD6QqMcunWLh1jgSz70z1KIGVqe0gfzzDa7rexW3tc9rHuaF3RhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=AqyZg8lC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0oWtOYnA73loOhyV40IAoAues5z9mLwqAuV3XkIA9qA=; b=AqyZg8lCW5dKB1h3bICL9RhXsE
	RGHyfYY7ecSs9HlkuE/jLmn5t3loN4rOTiipaJwxecaDW+Nzw+TInaAATl8XO+xRFSBujGGNCwuFH
	kVS0a+nnizjYvEkZvmlHb15j9SPQWVfsr70lLCDV/rQOdcLFxEFEifsrgP+XZi3UyGrG+azy2vb1R
	8Cz7EMmsSEqfaQx0JIHb7WUrslUmGI9Ztl2cE4WAU7T+Vp0jgzNJmnkZElry+9we9cABBcnaSUA+N
	oB6LF4NsZY7HnvZHNHWb0G/vLshsNZctPTudhJaTKywUO/S79j43e7ABDdMwPA4htJrUhY5wtY0dt
	HktEJhRw==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t2uaH-0005jR-Rj; Mon, 21 Oct 2024 17:44:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Correct GPIO polarity on brcm BT nodes
Date: Mon, 21 Oct 2024 17:44:34 +0200
Message-ID: <172952545662.1342338.14959789702494070152.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018145053.11928-2-didi.debian@cknow.org>
References: <20241018145053.11928-2-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 18 Oct 2024 16:45:50 +0200, Diederik de Haas wrote:
> Paragraph "3.4 Power up Timing Sequence" of the AzureWave-CM256SM
> datasheet mentions the following about the BT_REG_ON pin, which is
> connected to GPIO0_C4_d:
> 
>   When this pin is low and WL_REG_ON is high,
>   the BT section is in reset.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Correct GPIO polarity on brcm BT nodes
      commit: 273070dad96f046e622173b595e4719b82188376

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

