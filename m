Return-Path: <linux-kernel+bounces-344476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3598AA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFCA1F23562
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCE1990C2;
	Mon, 30 Sep 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cLQ1ISE8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF35194138;
	Mon, 30 Sep 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714663; cv=none; b=tu6FDc671jSYmgOMF1MRjr+FP0yDWZg9jYjKMmXFW3r5FCn3zG5F3OxMbnoMllUKEsXpL+A9CO9Z46U/vup5CdyIlPTzL+vWS3s4RISOK07D2MbrVFS7K4l88HMOnRx1ZSY8iJraI29RT4+D907J/gP7Xklr5K1Ug0WAkzgulUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714663; c=relaxed/simple;
	bh=tXFC57RcD3Nq4LZr3ZyrU7QKk8Uw8hlLIRVl8zd5y4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6KTq1cjUC+ArZYgAZ+3arDxFM8Mxvd0R5wkbtUt1QHBy9rualhST3OvzpO8TCPfQqL1UAhOM7HGZKmE/5kcSFVhygcmc29TUp+pVzhc84qn7D1m71uGLcBMQ971VZi8udS1ykWmvWehbPZ6viotMntaZ5Ym/uIoNQpatOqtJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cLQ1ISE8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zbG06xKB84OvkTESW4M7zpmhLleLEn2OiP+f0EybTkM=; b=cLQ1ISE84oO2wXRB3fq96nD39x
	AbGFfYRhB9xjY6cmrWFvRq0PkFgCBo2DPBawwudVMulvmei5jVyla/pmFD5yGskDtrGaYMB76xmUY
	CHx9TJ7ojKsmqydbHh4vgXQxSfR3wLrZw6vot3MzkF76Tsk5T6DA9rpYQGiLENysbwOo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svJVJ-008drh-Ex; Mon, 30 Sep 2024 18:44:09 +0200
Date: Mon, 30 Sep 2024 18:44:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Interrupt support for
 lan887x
Message-ID: <31efa9fa-f4e3-4538-b09b-b1363e419079@lunn.ch>
References: <20240930153423.16893-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930153423.16893-1-divya.koppera@microchip.com>

> +static int lan887x_config_intr(struct phy_device *phydev)
> +{
> +	int ret;

This driver consistently uses rc, not ret. It would be good to keep
with the existing convention.

    Andrew

---
pw-bot: cr

