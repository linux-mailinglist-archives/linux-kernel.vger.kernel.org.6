Return-Path: <linux-kernel+bounces-561000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B6FA60C37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E52189ABED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D771DB127;
	Fri, 14 Mar 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uf9Cv4cw"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A861D7995;
	Fri, 14 Mar 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942338; cv=none; b=JtC3TTBDxKxUi7jV0/DzEBEBz3UkZVUWWsvuwkErgis4ozA/ZTs3YjZQOZrSJgQMP/URlYihz2UZlmj9zl8vgR/yY/W32JLf6L0mTTC6vgc1d55G3BMPkkgul29PyHFhE/Kj7rPXyT5LrXPXW7Dh+Uz7efbALb+UOUVBpj1o0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942338; c=relaxed/simple;
	bh=0IugbQ0xdOnTYVC524TeNpw2WOR2AlKdYbu31P0ik1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqRdoIft/DMdUIY6k3TLQtIil5Jikf05dRwYsnH7g8YJEMzBQknofr73lzZETrhf2DFAVi053nPCQFnmHGBjHmJYkodOzt2m9aO0p8lQWcYO1hlvKvm7ubVxJ1uhZzODNfICPS/2HDdsrilqzIS1tohbFARZw++lQFXAfcRtLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uf9Cv4cw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741942331;
	bh=0IugbQ0xdOnTYVC524TeNpw2WOR2AlKdYbu31P0ik1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uf9Cv4cwOOCEF7NPBC9CwoCy0zBvQ7ACYolbw2moT3y6jhwkoR7GSm3xO/6A8g/KA
	 8teYOaXTmOxl/g6sdBQuSPFPhs98uAxA3EedxY6/ovgr3SB6J/GPAm5N6oWHEpPYB3
	 RYBvDKImArKLY/pruUuY2N+wpjowRWqF0L1IBd0s=
Date: Fri, 14 Mar 2025 09:52:11 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sung-Chi Li <lschyi@chromium.org>, Jean Delvare <jdelvare@suse.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (cros_ec) Add reading target fan RPM function
Message-ID: <5cb816c0-c445-4a23-82de-e3d9cbce54ee@t-8ch.de>
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
 <20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4@chromium.org>
 <782e6319-2082-4f05-9987-fa68439701ef@t-8ch.de>
 <523fe47a-73da-4eec-80b7-61408e0ba27b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <523fe47a-73da-4eec-80b7-61408e0ba27b@roeck-us.net>

On 2025-03-13 16:36:54-0700, Guenter Roeck wrote:
> On 3/13/25 09:24, Thomas Weißschuh wrote:
> > On 2025-03-13 12:47:43+0800, Sung-Chi Li wrote:
> > > Implement the functionality of reading the target fan RPM setting from
> > > ChromeOS embedded controller under framework.
> > > 
> > > Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> > > ---
> > >   drivers/hwmon/cros_ec_hwmon.c | 18 ++++++++++++++++++
> > >   1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> > > index b2fec0768301f116f49c57b8dbfb042b98a573e1..73bfcbbaf9531be6b753cfef8045fd5dab5b2ab3 100644
> > > --- a/drivers/hwmon/cros_ec_hwmon.c
> > > +++ b/drivers/hwmon/cros_ec_hwmon.c
> > > @@ -36,6 +36,19 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
> > >   	return 0;
> > >   }
> > > +static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec, u8 index, int32_t *speed)
> > 
> > int32_t is a userspace type. In the kernel use i32, or even better u32.
> > 
> 
> Seems to be pretty widely used to complain about.

There is even a checkpatch.pl test for it, which should have triggered:
PREFER_KERNEL_TYPES.

> $ git grep int32_t drivers/ | wc
>   43662  192381 3555402

33k of those are in generated amdgpu headers.
This search also happens to include the more frequently used uint32_t.

> Also, in comparison:
> 
> $ git grep i32 drivers/ | wc
>     820    4009   68486

The numbers for u32 look a bit different:

$ git grep u32 drivers/ | wc
    234768 1137059 17410570


Also this specific driver already consistently uses uNN.
This does look wrong:

	int32_t target_rpm;
 	u16 speed;
 	u8 temp;


Thomas

