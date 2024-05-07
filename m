Return-Path: <linux-kernel+bounces-170545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C068BD8F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5FA1C21317
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D022A443D;
	Tue,  7 May 2024 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nzViaw57"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7D139F;
	Tue,  7 May 2024 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045597; cv=none; b=sTYwZ1M/kwtIIsiKvcfRDdXcBN+g/cUTeuASwty0CRhBYq4KHmjM2bGLS8meBiBP9vc0aADBTooVVBhpnS9sQHSyOS+uB0+noFT4FL//evdeEU5k5PJt+/udoHAJoZ8AtCQMTBlfGbMUIbNxzgS8oOg6Uzu3qrmpaeVeCLzEc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045597; c=relaxed/simple;
	bh=qPRJnYhfG3ihAcwLFlEiL3vMYD133/E5GbZFFwNXRHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSzgc8oQfSU1mTeJIe3xWf7Yxr1m+MZNVjo4CLy7M88mWu9jitWPcoZt6SqM0gZbyFyGN8cjwbY8ur8KjdbrnJAeUuSrT+26+ezEoqkks+E/t+uzHAiZEIecW/jG5nK1qir0EVKRp1BmEKX3Jid9ymkol5YPRvKgTej57K+AK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nzViaw57; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w7qpPlO1ia49EiV1A7IncpyuhlxwrR2pVKc054DktVE=; b=nzViaw57oJ4jG5xzUHra90T2OI
	qHIwcqcuZxUMtuM6QPghR6oGcnkw4kSFk6mBS548GtN8g2jMxAEulIvaDSVrbDNnzkMjp5E9cRlv/
	4YEp/uPp3UbV+S+SoXj+9cEUI0S3hmPOzYwe6ZOTBLB03PMnTHPEphnD5Um0Lg8U0uII=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s49hV-00EoJm-1l; Tue, 07 May 2024 03:33:01 +0200
Date: Tue, 7 May 2024 03:33:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: microchip: lan743x: Reduce PTP timeout
 on HW failure
Message-ID: <01145749-30a7-47a3-a5e6-03f4d0ee1264@lunn.ch>
References: <20240502050300.38689-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502050300.38689-1-rengarajan.s@microchip.com>

On Thu, May 02, 2024 at 10:33:00AM +0530, Rengarajan S wrote:
> The PTP_CMD_CTL is a self clearing register which controls the PTP clock
> values. In the current implementation driver waits for a duration of 20
> sec in case of HW failure to clear the PTP_CMD_CTL register bit. This
> timeout of 20 sec is very long to recognize a HW failure, as it is
> typically cleared in one clock(<16ns). Hence reducing the timeout to 1 sec
> would be sufficient to conclude if there is any HW failure observed. The
> usleep_range will sleep somewhere between 1 msec to 20 msec for each
> iteration. By setting the PTP_CMD_CTL_TIMEOUT_CNT to 50 the max timeout
> is extended to 1 sec.

This patch has already been merged, so this is just for my
curiosity. The hardware is dead. Does it really matter if we wait 1s
or 20 seconds. It is still dead? This is a void function. Other than
reporting that the hardware is dead, nothing is done. So this change
seems pointless?

	Andrew

