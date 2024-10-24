Return-Path: <linux-kernel+bounces-380595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8E29AF319
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF06B22931
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677052170A7;
	Thu, 24 Oct 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cmvnG+5K"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46D1EF943;
	Thu, 24 Oct 2024 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799818; cv=none; b=bP9IR2bVbyYQO2J1isgcYbasGTgReKdmxaFn4xuYQE6mGmzwnBCOvCXe7Y8uQQQJ0GhL1ffNtH+/vfXJszej1kE4WH8UQ/oXFTZBq9IaSUajle7XOyYSKMOx4z13K8D/3o7syAa+hQxbIB8Qrki3anAoQ4XSxe+BFnQteLf/TuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799818; c=relaxed/simple;
	bh=IJgSDB5gz+z3pu9yNDYuHeEngHai0OvQW7Kl+ZnGflo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGUr1jiDIg5v80YTA2aBFlVMc+b34192sT3f8YN5vdVPD23jnFgyzhw2LV2SMtbnNvk6rlv+pwoiPWEp16N8LsPYr3Izky5wF0c1A236gymyZ787Xsd4/Fow+zJZAriBAzrAAQbKouSBspHRE/TUGmj4j5RtshaUmDy5L6inltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cmvnG+5K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I8RKQMPVCCwHfjIyciwEDSITWWzYTZ0b95h5M3mbIRM=; b=cmvnG+5KFV3XnIBOzGhVZn7vDA
	zJGvdE4sNr9MZvBB5XjTcweYzevcspPQZkxxPuHBh1aJNuBGphsqjiniXkOt0H5foTxy9/YU83Q5j
	n5czdAUArWQQmT6ocsD/RB6zEkrSMZy4b/ErjSUaGthxaS5qAglngD0/IWgeVKAyODa4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t43wx-00BAjw-AS; Thu, 24 Oct 2024 21:56:51 +0200
Date: Thu, 24 Oct 2024 21:56:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Erik Schumacher <erik.schumacher@iris-sensing.com>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"jeremie.dautheribes@bootlin.com" <jeremie.dautheribes@bootlin.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: dp83822: Configure RMII mode on
 DP83825 devices
Message-ID: <62f1a24a-3922-47fe-af73-e7cc79d67aab@lunn.ch>
References: <aa62d081804f44b5af0e8de2372ae6bfe1affd34.camel@iris-sensing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa62d081804f44b5af0e8de2372ae6bfe1affd34.camel@iris-sensing.com>

On Thu, Oct 24, 2024 at 01:24:23PM +0000, Erik Schumacher wrote:
> Like the DP83826, the DP83825 can also be configured as an RMII master or
> slave via a control register. The existing function responsible for this
> configuration is renamed to a general dp8382x function. The DP83825 only
> supports RMII so nothing more needs to be configured.
> 
> With this change, the dp83822_driver list is reorganized according to the
> device name.
> 
> Signed-off-by: Erik Schumacher <erik.schumacher@iris-sensing.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

