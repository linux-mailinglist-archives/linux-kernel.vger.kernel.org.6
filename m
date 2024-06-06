Return-Path: <linux-kernel+bounces-205004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C288FF60D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4D6284A78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30D512AAC9;
	Thu,  6 Jun 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="emy80JGq"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8B4AECB;
	Thu,  6 Jun 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706946; cv=none; b=lng9uwShn8MWLka8V7hTeyCsMdfSGMRRIYWOx6EBhVvPh9mi3Iz5uxuzIGXt6XsvRrLgfDa5Oiv7GIHcdyHfFnWgonnVSKSfZYrEPPJqyfxd1XlfmkbUg/wc6TBxiGGXznfFuWV+AmVn88xlJYervxH4GRreAaVjj2Ds0TtqTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706946; c=relaxed/simple;
	bh=p6jNNr5yW2xzPxtDiKafQJVv16x4Fx9TtvoO6CBw4Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSl5neD3V9O5512oxshnltq+sM+KMTOg2xA9uq+bftY+S4qwzNGraSgjSAAMxVPPL228kORFQb6X1SnpcPZljC9xr1togO0xEKHc9Jb2lrw+Cco6NvzBENDIYUdfMGstwgf7ZuSzS/xwZ2iUYDSKeNREJMdxP3eS8BQrfvnI+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=emy80JGq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717706940;
	bh=p6jNNr5yW2xzPxtDiKafQJVv16x4Fx9TtvoO6CBw4Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emy80JGq6Y8v2ZaDg2S8BIjchrX1M+eOh2z0WltlmeC2oN9dwcK7JAqI62pbJ9U6+
	 hTSSBLREO/fXiWNmiGqslT5v1sBru3qNDcK2DvKRJgCAordn8rrXaCt/O1LRNeGErL
	 rOiVZt1pdp7ae7n00pT2Mly4ZIMJ2zMe8XdkesuY=
Date: Thu, 6 Jun 2024 22:48:59 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] hwmon: (cros-ec_hwmon) Fix access to restricted __le16
Message-ID: <a9409e1f-a6d1-4d97-86c5-acb11c0115af@t-8ch.de>
References: <20240606180507.3332237-1-linux@roeck-us.net>
 <571aaac0-a397-4aa8-b9d5-2315f6a637d4@t-8ch.de>
 <9f2e2b48-f7b4-49da-ac02-1f73923fb9ef@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f2e2b48-f7b4-49da-ac02-1f73923fb9ef@roeck-us.net>

On 2024-06-06 13:16:59+0000, Guenter Roeck wrote:
> On 6/6/24 12:53, Thomas Weißschuh wrote:
> > Thanks!
> > 
> > On 2024-06-06 11:05:07+0000, Guenter Roeck wrote:
> > > 0-day complains:
> > > 
> > > drivers-hwmon-cros_ec_hwmon.c:sparse:sparse:cast-to-restricted-__le16
> > > 
> > > Fix by using a __le16 typed variable as parameter to le16_to_cpu().
> > > 
> > > Fixes: bc3e45258096 ("hwmon: add ChromeOS EC driver")
> > > Cc: Thomas Weißschuh <linux@weissschuh.net>
> > > Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Acked-by: Thomas Weißschuh <linux@weissschuh.net>
> > 
> > Guenter, does sparse work locally for you?
> > 
> 
> It does, but I use the version from git://repo.or.cz/smatch.git.

That does indeed look much better, thanks.


I have another question about the endianness conversion in general.
The only places I see doing a conversion are
cros_ec_sensors_cmd_read_u16() and the original cros_ec hwmon driver.

Also the documentation of the EC protocol does not specify anything in
that regard.
Instead there is the following comment in host_event_set_bit():

   /*
    * The overall host event implementation assumes it's running on and
    * communicating with little-endian architectures.
    */

Can the conversion be dropped?

