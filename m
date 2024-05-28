Return-Path: <linux-kernel+bounces-191900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150658D15C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459461C21FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0326D139D11;
	Tue, 28 May 2024 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z/3d3nBp"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0078676;
	Tue, 28 May 2024 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883493; cv=none; b=btbsGM0DR8eJ0dbYuM/JbqrZK9QbwbXRWxCz7vgJQkfshv8d13Ozgz7t8CB8KOYL0Mq+K/OGxGnuXwHGy638zEMo8D4icWOCPsBu+41wkR32il1speUDVyMYpftIUBXgnyOvziTBMcEO64G2pxB2X5CtvPmAc0lw7UTJecNMMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883493; c=relaxed/simple;
	bh=eDcKts2t8y1TB70dyhVt2Aqd8BNkr5AK9LGsD9MS7ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWb2BmnC5RhoaIv2tdsH08dIQitOn3C8CWr/nAN+odQjc5qbl7Zw96FZlZUrCfqjjCbailhHgFiO0IRtIfntOnpMHd1h0n+PGUPKfNXI19IQ2/UsGEd/Zdui8kkipWwduZva38/SnDmFFAXRzKAGroM7xlOQqkOwwfCTWUqRlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z/3d3nBp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T1kkozHdAWncRAY26LRIlcmiras1bPg20TXNvg/U/KY=; b=Z/3d3nBpM6tBXg3l2yk3TLVzXQ
	wh3kY858l94g3RMqEd7wzU0t7n0cntF40q50QW2iDI2UHPOlC0Vup16ADO620EkFktVcSfUcYqjFv
	9MJuXcTWYdMQ6K6rAnZCOnqARVomgke9Jje8pKZ3/BS9dpVh9qDCVS4lHYSKAu+iSLVVNEPEjkl32
	CyeCa1e5E5CQOedayL+Uc4rgBGmHzpBKLpcWJSWSU4QJ8m0MkOLDJvxvpufkdDS9s114+EIZ24Liy
	+UcJPs19UjzvbWEPYpDozyBe0ptclcquizRmXHkK0S2yp1jtGG7oaQbS+Nk1w6XVLqTYrwwqpvwkS
	dtUTW4iQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49854)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBron-0004Pb-0B;
	Tue, 28 May 2024 09:04:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBrol-000361-I5; Tue, 28 May 2024 09:04:23 +0100
Date: Tue, 28 May 2024 09:04:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>, Yang Li <yang.lee@linux.alibaba.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] clk: sifive: Do not register clkdevs for PRCI clocks
Message-ID: <ZlWQB1q+8cE+mOAN@shell.armlinux.org.uk>
References: <20240528001432.1200403-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528001432.1200403-1-samuel.holland@sifive.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 27, 2024 at 05:14:12PM -0700, Samuel Holland wrote:
> These clkdevs were unnecessary, because systems using this driver always
> look up clocks using the devicetree. And as Russell King points out[1],
> since the provided device name was truncated, lookups via clkdev would
> never match.

There is another reason they would never match - clkdev has always been
about matching the clock _consumer_ using the device name and connection
name to the producer. The device and connection name passed into clkdev
should always be the consumer (it's documented as such.)

Providing the producer device name to clkdev when registering an entry
will mean that clk_get(consumer_dev, consumer_name) will fail to find
the entry in clkdev's table, and thus fail to find the clock.

So, this code has been incorrect from the very start.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

