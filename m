Return-Path: <linux-kernel+bounces-191852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC4A8D1520
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2231C2236F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B87344E;
	Tue, 28 May 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="C4Wwmams"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AB73164;
	Tue, 28 May 2024 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880530; cv=none; b=d+GFyiPTMuq18JNJB5P+yYyZMhj6hND1gVTgf/iS5uSu3cJz02//9X+IkR2rAX2nF84RFWViNdZDZybzpwCD5WbmgIPGu3A2ZGqmV4b7Y80i8SD6kNT+q5nAu7tyGluOiKTmVjkBVOA0fijBsVDZcV9iRWsgeg9VBUq8kLPLFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880530; c=relaxed/simple;
	bh=NjlB9HjaOzm7GFCCp1mog1GeOzYiA23MD7+v2ePYdq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MluGH6a+C/dD5nvfht5ooNjTH2HCwV6TdEo0x0wgstdxbxQhCor1NiLDfkbXX5VLsdMpBrJEAcuquF+lzcSfeoK0QpidF6d4n73KyTKnHavAwdO/w+BcXt9IZC8UMF+tJXoWOa+3Sn6MpO6klCWWKMirCI8Rh1fm/Y8ccPKrhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=C4Wwmams; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716880527;
	bh=NjlB9HjaOzm7GFCCp1mog1GeOzYiA23MD7+v2ePYdq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4Wwmams/C6BmEHgtSqsUf4ABEG3x9FouT0XOmS8ZLKOGcO1fshJdGTLGsN7Nn994
	 Ns0lKZ5/b6w6BRZhvgQw8KotY3Q6vXQdY5EPRZmTgzVPM9Y8B+T1TAy+wkKMdlYxDk
	 akXPVr+7UszijWMw5ZPrB3Hc613OgKLbfuHvGRW0=
Date: Tue, 28 May 2024 09:15:27 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
	Dustin Howett <dustin@howett.net>, Mario Limonciello <mario.limonciello@amd.com>, 
	Moritz Fischer <mdf@kernel.org>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH v3 1/3] platform/chrome: cros_ec_proto: Introduce
 cros_ec_cmd_readmem()
Message-ID: <c40d87cf-17b9-4500-ba87-35d14aeb1b4a@t-8ch.de>
References: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
 <20240527-cros_ec-hwmon-v3-1-e5cd5ab5ba37@weissschuh.net>
 <ZlV8Bx0-FOYeeTO7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlV8Bx0-FOYeeTO7@google.com>

On 2024-05-28 06:39:03+0000, Tzung-Bi Shih wrote:
> On Mon, May 27, 2024 at 10:58:31PM +0200, Thomas Weißschuh wrote:
> > +/**
> > + * cros_ec_cmd_readmem - Read from EC memory.
> > + *
> > + * @ec_dev: EC device
> > + * @offset: Is within EC_LPC_ADDR_MEMMAP region.
> > + * @size: Number of bytes to read. zero means "read a string" (including
> > + *        the trailing '\0').
> 
> The behavior is cros_ec_lpc_readmem() only but not for cros_ec_cmd().

Indeed.
I thought I checked for this specifically, but got it wrong.

I'll drop the docs and add a

	if (!size)
		return -EINVAL;

to make sure nobody starts relying on that behaviour when writing a
driver against an LPC EC.

