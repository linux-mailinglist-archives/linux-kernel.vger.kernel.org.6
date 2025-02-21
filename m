Return-Path: <linux-kernel+bounces-525702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8526A3F35C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8ED19C1B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC0209F33;
	Fri, 21 Feb 2025 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="gBxMYbO5"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279A202F65
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138721; cv=none; b=XMMtikQZgNDK4mUCPUqjjncDADHSVFEUCcKUgo9KdK/AW4ADYJ1SXyKqEu3bsGwbafGzzhi5zg3zlZFMPFHBiPGvBh6/ZcfMHSOFpp6Z0HQDe9ZrjfVBbiO6NtYWJ7Kw3Q3qFD9T4myhkLgMAqB2yy3asT75VmmbeOrd4Bx/KEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138721; c=relaxed/simple;
	bh=ftAXw2Ry7mVAUfkkuPPQpE14IB3NBUi0JOYI3SboxEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8HeHFpvTSMlgMLdURF+8kD9lAbdQ4grG3yn9V++I4K1NH8xf/Nxtrh+j8F8shoWQlwREMq9bFAiMCWDAgrxfu05V84+JNRiz/8bFjRUFKzEXCiNjLHwm61e+KyA0wKEa9SKfQxT/UNzBznXcbt2T93zf4HA6dE7kXYi61V8wl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=gBxMYbO5; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 292A1240103
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:51:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740138717; bh=ftAXw2Ry7mVAUfkkuPPQpE14IB3NBUi0JOYI3SboxEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=gBxMYbO5hswpKWKgeK+xkTcNlGAku5CvF1jJBb2xtTVVYFzjbodV4wPxi048foYuB
	 m2MX8DDeWoTYsVfO+eh8jqO55eh1/L8Up0sPMUyHYORw1KjMJti0+8JgyA3CAUh4Tf
	 vgYW981qBUxGvEc+bPReyHhDwC+QDXXrMAEzioMbc+9xoCjfk30y6e+KR8ZvQ85csM
	 refkjEajwYqEPZxisZIL/4LmoZBVwQOmrdV0dU6vjSVuG/6CqVcBebvLQa0zRmCYwb
	 O45+Zr4n5HlZN3dvegKviPT01152KvY7FB8hjWIBrGjZLfPSYfw21Fh41jI74m/hul
	 qjXTnNnmimKaQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YzpQ24fycz6tw5;
	Fri, 21 Feb 2025 12:51:54 +0100 (CET)
Date: Fri, 21 Feb 2025 11:51:54 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: j.ne@posteo.net, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: net: Convert fsl,gianfar to YAML
Message-ID: <Z7ho2u6vi22sYMeU@probook>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>
 <771e89d6-60e7-4fc6-a501-b6349837cfe7@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <771e89d6-60e7-4fc6-a501-b6349837cfe7@lunn.ch>

On Thu, Feb 20, 2025 at 07:02:11PM +0100, Andrew Lunn wrote:
> > +examples:
> > +  - |
> > +    ethernet@24000 {
> > +        device_type = "network";
> > +        model = "TSEC";
> > +        compatible = "gianfar";
> > +        reg = <0x24000 0x1000>;
> > +        local-mac-address = [ 00 E0 0C 00 73 00 ];
> 
> That is a valid Motorola MAC address. It is probably not a good idea
> to use it in an example, somebody might copy it into a real .dts file.
> Typically you use 00 00 00 00 00 00 so there is an empty property the
> bootloader can fill in with a unique MAC address.
> 
> 	Andrew

Good point, I'll change it to all-zero.


J. Neuschäfer

