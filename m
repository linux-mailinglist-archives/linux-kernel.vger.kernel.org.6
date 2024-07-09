Return-Path: <linux-kernel+bounces-246588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C3C92C3F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB4A1C22321
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E4917B04B;
	Tue,  9 Jul 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="YRtqXuq9"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68051B86DE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720553620; cv=none; b=pNQWiuJjyK4UlmItuw0DOdzgBNvUd5sUsphzf3PPCH8wWypOZ3zAHHG3ElVGLeGstNtn3V/z/sB9Q0C6CidvZeBhDVAdrlm9L5xPpJhzBrUhIMFJ1Vs98BJSdWw+UYS3cvt7FrkXg8znFQnglHj9ehjGEsMUY01tJsFPOYWc1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720553620; c=relaxed/simple;
	bh=v6AKfXnHeVu2/UfI+aqXZHef/Z7EGDNibYawF/VOrSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syqS986oaArO1IzrhzeeeNUBWrXxtg9MqZcSsgnH0o9t14ZRpBHBfAXqCfalKxuqX982Du9AU7lRvtWKchLIsTqJ6ej5X/hyR6RR4ZNGnZK4TIO2uRJ10to+P+IdkrALAuEJZKP2VUojoqTI3WrmuzBD3g1BqdBz1eHhFumauz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=YRtqXuq9; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720553598; x=1721158398; i=j.neuschaefer@gmx.net;
	bh=v6AKfXnHeVu2/UfI+aqXZHef/Z7EGDNibYawF/VOrSU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YRtqXuq92I4Ig30V05hzCVn4AE8yuwEib6KHaAco4+6u6YS/+xY8ExScIrH1dm+v
	 wb+2UgQw0GFWR1btnjp1pk0RoCB0PAUNHAnVQLMTsQXRs/twQUb82969flP4Cjo0f
	 blHToKy2NtQPy25Si+uG1DfJjHXaLmUbtfou05nVMOj9T+0AhXXGaLg0Ykor3bH1m
	 x33x73Nd2dOCWJpCx/ylwMlejBEhyIVwymua3Yo0C59QAutHZ+Trufz2K1dZbOW59
	 1DVbjiNMUS0kUTTdOMHN0NhN5jjtZH9u1zVExdFwz89wlZ9uZkkTNBkj4yvpGeHyh
	 UbVzI5Z+1sz5+BEmkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([5.145.135.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mirna-1rvDcQ0A5s-00m2f8; Tue, 09
 Jul 2024 21:33:18 +0200
Date: Tue, 9 Jul 2024 21:33:15 +0200
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: bcm2835_defconfig: Enable SMP support
Message-ID: <Zo2Qexs-J5_Lzbjm@probook>
References: <20240707-raspi-config-v1-0-3e122f2122e9@gmx.net>
 <20240707-raspi-config-v1-2-3e122f2122e9@gmx.net>
 <a5c69147-c0fe-4cda-8996-e46698c5e9e8@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a5c69147-c0fe-4cda-8996-e46698c5e9e8@gmx.net>
X-Provags-ID: V03:K1:ecQu54LuUbrIznY3FBeizi8y57eJR4/zdKqFyRuwNcTETv/ihf3
 sSGW3oIwz8F4RmkwlggQvyjQZ6lokMeJ6Kw+dmC3I6Jzv2iCcvmNDZy59FlO//AejCBHbHm
 nuNjnecfMNh6KmWR9O0ak5sefsaX/oqSI9tyKwkXYqBabXZqslYZV7R4AyVpXBALJDM9FjX
 j/tkyUg0h8slJTeTU56TA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NXQ3fA64Z30=;FdvoWY+TEk+6K0dWKXAdFotOfZv
 iQwSpvhNpy4qjjbY3FT42c9DNS+0tPJCy1BtcxQew3VAedI2fmW6GxDW33MfsXgavPLFSYnuo
 LSSKQVfB0w+M/5WBxHsRfPNkJF2kXyDIGqvqp6SPegvyj5TvmhXqS0HBzz3x3L/ChKg4/OSNk
 mRY9uzWtFI58+3DnrL1W5tYCq8bTm5aCKhpbASESJImlt12WS8L/fN3u7Ibd7d7tLKlaWRo3x
 PsCJNOI4LPCdEbnNQyQqC6g+IAzPYRwSm7xaAK+G+Ps25snj+b19BefnwbgpZ+44faT+yZBT0
 pwCJPu3rUvXJCh2R2F5THoo4uaJM8dB/uEwbY2xjmF6B+Hc6iwrE5YUg5SHnuyFUEEsruz7gD
 LpMlfT4hnp3Gira+WLMt9x6nwaCqvkvqOQiiahoixD+kby6F7thhKAmLAMFwP+LkDAZRF0kKg
 Gh5t0YdoOcs6xyVFJm311K4xVemvOTM4LgGEEb6asq/AbTDRiEkOGdj5xO50S0WBgSDWaDC0r
 2rV8IHocxG/pGgvT+eD04iuvgH+EcKRpElbWK4RKHhUBsyTnVe+w3dOmf/fZc4YpdFUZt6xEP
 48buwmo+1XujjsSMXGU1kTBdDOBSY9hlyMayPIwOuhmmKmujk5IvG8kq12WC+w6oZLYv4HUVs
 M6b2wZiPa40oxWmPEnTdaQBUvZwJUkn5P3OAqSA46Qb2vme/VcvOvWhmBesivT/aOQ9PZKQPE
 jD337oT9RVH8MN8k8naka8UYv2WhKv1gc/JpSQOWvl0iRRnK6I1sao+jrJDFc/FP3vmm7hfto
 SDrma/BgfpTl5SWcOOIYcA1IviSgWeCTelTvJW0dvdghU=

On Mon, Jul 08, 2024 at 05:54:25PM +0200, Stefan Wahren wrote:
> Hi Jonathan,
>
> Am 07.07.24 um 23:48 schrieb Jonathan Neusch=C3=A4fer:
> > Since there is only one Raspberry Pi related defconfig in the mainline
> > kernel, it's useful to have to work well on all 32-bit Raspberry Pis.
> this wasn't intention of bcm2835_defconfig. It's more focused on BCM2835
> SOC and kernel-ci (both non-SMP). If you want to use the BCM2836 &
> BCM2837 (incl. SMP), please use multi_v7_defconfig instead. Applying
> this change would decrease the test coverage.

Ah, fair enough.


Jonathan

