Return-Path: <linux-kernel+bounces-536410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1247A47F45
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1879C174635
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FA322FF37;
	Thu, 27 Feb 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bBg4Du/f"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2B22FAC3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663013; cv=none; b=VclddE+3uYx3rCNFJjl7f8AeL/o3yg8gLnF86PPGDtePUTgAO4rU5NmVzZ5H6EzqRD7wb1jtLKb/7AaytYZqkTLkU9vZfoW5+0VMJiWzRLV0y9QcFAamNorYRXmPoAGh9/LwzZZtjeG83eowrxyyzf5qVG+9yqFeNpNWr0PS/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663013; c=relaxed/simple;
	bh=GDZ5BvPgy2lCmzewOwp+tGRhkqPTAxTh6RPXmssfyoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFBLONUgUYhGGvi1/JxDg1p3NnA0qCJEdZmUsE+W7XnLL3hIBAPxUIcODPzWFq+PH2sFpQLv9QshsONDferwQrSTAdTYr1AL10c4N2TH6aazarLVW/KJe3Eutd2pqAZKY9Oc1D5otUfiiNoI1xu3xj75bLOARbrgT6mkCmQDKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bBg4Du/f; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rSW8vY1Lz82V3O90pR+pYsVexANwdbEdqaogjvgFhUU=; b=bBg4Du/fOsVoASBNeammEzgOX6
	sMwnZjf9NZkDzTj0cYQWJKCGLoYwFfsb8lyIMEzuKr9THey0k5TY3NOXcFWBpRjR2gyqwzEB1xfgt
	2mBOE5B+A0xBANnFBluQp1wGNR3GIRcD4VVQoL7jIOD9zrA0lja4silnhHjmLUOQDFCh91j4Ha8d+
	aHUWajsW9QhBqZtEH3vh5w3zEtOrIbKaMBiy1z8676q1pJClEF8JHcRjK8sKSijfqPME9MXepcKVM
	887gCUSJLrgZHBu0C9u7QuPlu9coFLqydeNZg8nxZ8mpwzQgEA83dGtAhmc1WpP3b2GOGyNGj/p0r
	VBi7lk3w==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tndxl-000163-FM; Thu, 27 Feb 2025 14:30:05 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip: usbdp: Remove unnecessary bool conversion
Date: Thu, 27 Feb 2025 14:30:04 +0100
Message-ID: <6199846.GJh79HuArf@diego>
In-Reply-To: <20250224220339.199180-2-thorsten.blum@linux.dev>
References: <20250224220339.199180-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Montag, 24. Februar 2025, 23:03:39 MEZ schrieb Thorsten Blum:
> Remove the unnecessary bool conversion and simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



