Return-Path: <linux-kernel+bounces-294055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3639958853
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771CC1F232CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA74191461;
	Tue, 20 Aug 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RCgQ5mjt"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E0F189F3F;
	Tue, 20 Aug 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162006; cv=none; b=u83rdlpFZW8AjNY3NfHuZvsHmR5Zwibdr5Ef+XYbrvulJUcBtbIvxSVmubWoJt4gSMKthWkCQtaNNo3jk9Ehs4XS6E1GwpbK1+mdpcsRO5z0LpCxz3CMtpUsb/IHg92++Js7cbV6DDI8HafmbxE/X4C/SRH8mc0aQm9Mb54Xskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162006; c=relaxed/simple;
	bh=r6gHvFs8qZzRj9TkJDY+97S1cPLWFtbFUj+Y6c9CGSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYC/e44UAhKFMKZa4pjDdqwDt6pSWkxksM4GIlUWoJoXXxEdu+Hc9+4h95zzhfsRLwI5cRLpULVNIOo072XqbhONm8V5OpGHbL5YbULta1znWmbJVgx6sE5eOE+jB+jEhjZ6Ejv5QFOdbcxCFb/daz7HBuvxh61hJIbQuF4rN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RCgQ5mjt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F4x+TbXBdvP9pTk8wDhbTQg3Pl05KK/CEEJAKll4LPA=; b=RCgQ5mjt0mrlU1EGsPpU80KRUh
	uUIwKaem310Yr6bMhAnar/MuOK32T/OFpvgOXAo2S1brcsT56ke6JF29MLDRgkAxb5yLdMwTDVk16
	RoX2/lFNXcjrt6u4OgyR0FQ5CVh+OK/9BeaNtDPCdF+LwlTK73vZ0VvvsCr0Mb8K6JeY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgPIX-005EAf-MS; Tue, 20 Aug 2024 15:53:21 +0200
Date: Tue, 20 Aug 2024 15:53:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next] nfc: st95hf: switch to using sleeping variants
 of gpiod API
Message-ID: <2a72c443-2aa8-4a98-ae2e-62a781e0dd94@lunn.ch>
References: <ZsPtCPwnXAyHG2Jq@google.com>
 <9b77e25c-8942-42f7-b82e-42b492b437d8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b77e25c-8942-42f7-b82e-42b492b437d8@intel.com>

On Tue, Aug 20, 2024 at 10:10:37AM +0200, Przemek Kitszel wrote:
> On 8/20/24 03:10, Dmitry Torokhov wrote:
> > The driver does not not use gpiod API calls in an atomic context. Switch
> 
> please remove one "not"
> 
> > to gpiod_set_value_cansleep() calls to allow using the driver with GPIO
> > controllers that might need process context to operate.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Code is fine, but why not as a fix?

Why would this be a fix? What is broken?

    Andrew

