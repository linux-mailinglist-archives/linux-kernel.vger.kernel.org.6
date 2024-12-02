Return-Path: <linux-kernel+bounces-428491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0899E0F3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B51282729
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69D1DFD86;
	Mon,  2 Dec 2024 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="uN0nDRuQ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AC125B9;
	Mon,  2 Dec 2024 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181660; cv=none; b=VQ5VYKhmX/egTUbU99jfRlaf2OuQON1gI6I5qq510f1Kbs7O2OiMPR7kRFXYXluaTJTQMMNoRd/cKKTR48II9zWJldf+QnJTPeGJfrLkhlMMUWdXY1y0DyriSgCRQts7PBsH8tYd3C+Ud8sv5oEa8NX4Najx2xV0XspKZATs8xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181660; c=relaxed/simple;
	bh=hQ5AXtcZKk1gsdh6lTBqqAGsB0BQFP9rv51+RTOiQNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEpfWG/R0VCajirQQ0rZ6k7BZLJRV0P/9JReHVDj45qRS/EnBr8Al/iDyPL+GcBNFHelqbYG1RC66UCHeHL1G0ltBm9QBaAIp8KNKC1iHVfIP2samhlpUMRUgNmWLjhbQA9XuKwekzNP7w39DIg7sYzoGDk8Izfefqa6KXhdhso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=uN0nDRuQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N6vyL8Ww4bPTUOv9DIPeCa5gM8GLcmb1GkHr1Fn8DNE=; b=uN0nDRuQTjvIw5epJuIZ9QDMmg
	FK6dqrZAUcD7l6uMahWgsecPc9jm/8nhUvuhoqDfN4+OA7Qn1gZQ0Gk9LPyCz5X6S82cRFpPoIYi4
	WCVq7vU43JRbj0e94qBBy5xmufyBUZqOX4TT59ynoLSHL1a+OSZy2Hc4g7ZSzz2Ldz0c54sg/Dmp/
	JNf9ehEwe4ktg3rT/2e37TxQa3C65p3jw1KjZCUToRaqPv7bLZEXWr+QBTGDTyYMHv7pxFzgF7dVM
	ZxWAU839M74cJTLUdZ4Qtb/fZ+mdBdjkuIMMrylR0sIQZUnhiKcze1NPOKrXicmftMNOvPZpwnmou
	OqL31Lag==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tIFim-0000FU-Ft; Tue, 03 Dec 2024 00:20:52 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Remove unused and undocumented "num-slots"
 property
Date: Tue, 03 Dec 2024 00:20:51 +0100
Message-ID: <7106426.18pcnM708K@diego>
In-Reply-To: <20241115193424.3618568-1-robh@kernel.org>
References: <20241115193424.3618568-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 15. November 2024, 20:34:23 CET schrieb Rob Herring (Arm):
> Remove "num-slots" property which is both unused in the kernel and
> undocumented. Most likely they are leftovers from downstream.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

this was already fixed in 
commit b1f8d3b81d92 ("arm64: dts: rockchip: remove num-slots property from rk3328-nanopi-r2s-plus")
at the beginning of october.



