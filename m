Return-Path: <linux-kernel+bounces-229848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D43917525
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A86AB21EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106311113;
	Wed, 26 Jun 2024 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LXaNHlwS"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE917E;
	Wed, 26 Jun 2024 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719360469; cv=none; b=O1tFPeoKzvKXjvuXqENjoJ6MY0yAxrRcjPZQfjXtecVBP30HvTDBnhOe2jpZMGf2JUZSiGtgT1G86Ff7Wm+npbyi6X89cGAZQgoXPvxWctGELAUp/e4WpBHLUNJadifX9Wp4EAtnWVowBOAt4g+fomgX5Y/O4vZJgEIRItsxIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719360469; c=relaxed/simple;
	bh=WaXeH1CwJQh0yqRTigKsUBZq3GcS2PuMgp0DaeGAN7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ny0yuHn0ErB1g4ikG/iEQxgpX/bSHRC9fMMBzWKIcYJ90bf0AtndkkDNxyA4gfvP/aXB3MKnIFY75m02kbSZQxKPUoZRPq3xYPFOxX7jCMm40/kyp/47Soy9WgyRbBhdt4XyqHXmHyhTOofUYxEeIc8bFczmdyQyrSOTpqOHat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LXaNHlwS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-79-194.adl-adc-lon-bras32.tpg.internode.on.net [118.210.79.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D6BF720009;
	Wed, 26 Jun 2024 08:07:42 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1719360464;
	bh=WaXeH1CwJQh0yqRTigKsUBZq3GcS2PuMgp0DaeGAN7I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LXaNHlwS+HZ5y2X2J/vB6bvpJbPMhWs9XqiSuo8zdiQcw2raaGO03puFpw5lRBEtO
	 bECin2der35xrQLabJJsrlfScb1SRNwF6zTeR3GIEeDx50WKbzH93ZOnD8r0D/Dl52
	 Rl8dViWrBYIPVxPO6tczVXQbUgQDmED/r5iROkwuzi2w9619e2XfJVOEBahCOYaDoQ
	 OtY2YRBQFjH9CyPR9kRBX22Iw4vujT9haO15cpdPzh+/Hg/f5sGYahxqBp5ofhGEcd
	 jJ1cRYjvzibC7IqCJY00rIjJuwA79MHF+e1i7AZwXgXtSdKhi8Hz9n8TYUzVeNvdaa
	 Saozc3s/dVy6A==
Message-ID: <c025e0db6455e3d79fbaf1ff38d72c9f8db7018d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ma Ke <make24@iscas.ac.cn>, neal_liu@aspeedtech.com, 
	gregkh@linuxfoundation.org, joel@jms.id.au
Cc: linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 09:37:37 +0930
In-Reply-To: <20240625022306.2568122-1-make24@iscas.ac.cn>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 10:23 +0800, Ma Ke wrote:
> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.
>=20
> Found by static analysis.
>=20
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

