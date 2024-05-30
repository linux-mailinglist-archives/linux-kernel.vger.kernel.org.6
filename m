Return-Path: <linux-kernel+bounces-195274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D54A8D49E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9755B20E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231417C7D1;
	Thu, 30 May 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="VJOKR4CJ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB486F2F8;
	Thu, 30 May 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717066287; cv=none; b=ulnVVgXLLHX7W9yjbhSzlrPlpCQgcMRPitWijpcD85EeEtsY4V6iZIE8v+6VGw6/ELtAC2gY7zmmqPneWh/TvG7BFNE2zWmb34N0LqI49Bsm48a+ZhUv8T3kE5RPQ7PDSRjIMvsz7WG2RGpSSMEfldYrkE9qJRdpQBMOnAr+ejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717066287; c=relaxed/simple;
	bh=SqhDif+E3Mxv94PAv4Se2ZvqYdJF/+qP6n64x1New7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/oe0HieWmfGO9Q52a7o8zuhpx9ItD0fpw1tc5mco23BnIQxB+xry9R2WOAYV3/bJemIIJGuIohgw95RTKPWjPqQjabsTP/Zo10Izcg6nbHlNz1nGzxZJrfpWT0euIJmQI7tc4P/rKk/bcLHFUbw7oLp6t+ytF8IF61PXPXokjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=VJOKR4CJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1717066282; bh=SqhDif+E3Mxv94PAv4Se2ZvqYdJF/+qP6n64x1New7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJOKR4CJP1VVxb1tHT9CGt0Ls51eobyWt++FDZYI1fkPve9MCBXP53pczG5qn5sa+
	 UWfCd5mvhGXi35jAQjliU/nGBRrTO/fORnhQASTyd6HQEQ9LTJljblILLgDTm/8052
	 e0eczXt/wK7OjvtTdSd0vczxGCD4/tg4ubbjMihc=
Date: Thu, 30 May 2024 12:51:22 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>, 
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
Message-ID: <6d5c2ee5-6e0e-4d13-a977-493d2ee2c0ed@t-8ch.de>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529205204.81208-3-linux@roeck-us.net>

On 2024-05-29 13:52:03+0000, Guenter Roeck wrote:
> Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
> sensors. Such sensors are typically found on DDR5 memory modules.
> 
> Cc: René Rebe <rene@exactcode.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Tested on MAG B650 TOMAHAWK WIFI with CMH32GX5M2B6000Z30
> (Corsair Venegance DDR5).
> 
> René: I included you as MODULE_AUTHOR since the patch is derived from
>       your driver. Please let me know if you prefer not to be listed as
>       author.
> 
>  Documentation/hwmon/index.rst   |   1 +
>  Documentation/hwmon/spd5118.rst |  60 ++++
>  drivers/hwmon/Kconfig           |  12 +
>  drivers/hwmon/Makefile          |   1 +
>  drivers/hwmon/spd5118.c         | 482 ++++++++++++++++++++++++++++++++
>  5 files changed, 556 insertions(+)
>  create mode 100644 Documentation/hwmon/spd5118.rst
>  create mode 100644 drivers/hwmon/spd5118.c

With the Makefile and detect callback fixed:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Thomas Weißschuh <linux@weissschuh.net>

