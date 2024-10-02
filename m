Return-Path: <linux-kernel+bounces-348370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74BA98E6BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E8C285EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88CE19E998;
	Wed,  2 Oct 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0TnnZ0hV"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484A16419;
	Wed,  2 Oct 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911506; cv=none; b=XGmgZxaoQhuvL5Tz3dEpt45tOzkWNkckSRZ0yp3uFQs9UPvfNhPIvDTAYM9MTphn0HW/X6TLzEhwbqmrZqsrcm4BUL2y3h5R7GiTAKuf34EEEU3Su+2FIjLeZo2o2oBAQl4zZJU1Hhj2fqLF7N7DEa0uomsBMdHTGn08OjSFJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911506; c=relaxed/simple;
	bh=EAJnRUkOaeNIQzFSDLxBn4S+t6M8eIW65UMEMRqMY4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9fPG/uP3rUK/0g+izrpvAygpbhCBW8iu+PNUWEmIC9EMi2JJDJedw3TW6j/V9bgJo+qFqpItMBh4D72dsy2AfktWbhEPaoh7AJu4K376/j9NNXTIew2dD11ycmWz8wlHHVnIObJyd2tmkLxvOgsx8qrd4xs7vufM6NCfMGshGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0TnnZ0hV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2n2HQdMzt0TkAnJQRkl0HWW2DkfIetvURAPJjVJVM60=; b=0TnnZ0hVNXV1dkLf8Dn2BI3IXj
	gZnk7VGYwOgyo1QlP4/miERwsL/cpG2BqcbSPozO48t1/Yc/AbIbE0IfsbFDxzrxWcKh3tVzfYIlg
	NuA4WwdVtaqWwlO9YyaV1FGCKUwsUXS3RaRuLX89IbHHw/a9RZy+u1vMRpIE4lcjwmjI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw8iC-008u4n-Mz; Thu, 03 Oct 2024 01:24:52 +0200
Date: Thu, 3 Oct 2024 01:24:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 01/12] net: pse-pd: Remove unused
 pse_ethtool_get_pw_limit function declaration
Message-ID: <a6a3db66-50fc-43ce-8284-55ef3d4fb9fb@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-1-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-1-787054f74ed5@bootlin.com>

On Wed, Oct 02, 2024 at 06:27:57PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Removed the unused pse_ethtool_get_pw_limit() function declaration from
> pse.h. This function was declared but never implemented or used,
> making the declaration unnecessary.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

