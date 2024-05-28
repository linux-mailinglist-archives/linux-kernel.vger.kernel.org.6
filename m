Return-Path: <linux-kernel+bounces-191871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005818D155C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE46284D62
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840471749;
	Tue, 28 May 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slzeKu3r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874D17E90E;
	Tue, 28 May 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716881429; cv=none; b=N1jTHAPMJeZbcw6LrF+oeodETHx5gxS+JbvfChkCByAw8zmmICkOvPWhsxxngC9fZrTFbfTZ9jobUKYF/u9JM1f3qdbYn5XXXMBHrvFG4Vxisx5bIbLD/YoZB22u+kASw53Th4ivSFTHypeIY1xH1BhoPY1H7q4QruQ6jZ/WdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716881429; c=relaxed/simple;
	bh=HVKNxMnOOTLPPnywKJaBVrnPD8jpeyqhRlQRF+IWqCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHSMnyCxMO3CSLW4uzM8mk242qNXvBuSMeewlNhH9ch5DXNgaGTI5cdo9YIc+Z2MV+yfz3LI/6NNeccpT0c2dJPJsvTnxCPdaD4hSiuYr8b1+SAetHz9E+LPRTvGY+k0+/xdq5se/2U26q8xN61opljGToL68O1X5Cah7/qoOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slzeKu3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C42C3277B;
	Tue, 28 May 2024 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716881429;
	bh=HVKNxMnOOTLPPnywKJaBVrnPD8jpeyqhRlQRF+IWqCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slzeKu3rA2OQ+S7Ol6BehuxEeaW6kQujMgTIwYPYPCufIHM496ffuS6790dFQ5Gxd
	 h6HGxKJVN7b5PEqJS6btS2+YocRYQlsoygUpHLN1ZJ706lLvyz9vKlOu8okxgAoOAu
	 CLKoOFkpVoj/1Lvuaeugy+1ItDH4hurLzojaJXLpuIKj1TBLgW1t+RoB3/TKHf3Q7d
	 UHdQ4z/0h/1MQ1wYDSdS5fUhlemxrgTKYMDzeIYHEncdkwySt3mYRCMDA3AHCWJ0Bu
	 akHoLGqR7fNCXztLMPiHcuvbCOMVfmZNwaGGPfdTFyTzC1zwPp1XKs0U50Zu/BQOwF
	 WO7YRJIFIr+bQ==
Date: Tue, 28 May 2024 07:30:25 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev,
	Dustin Howett <dustin@howett.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Moritz Fischer <mdf@kernel.org>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH v3 2/3] hwmon: add ChromeOS EC driver
Message-ID: <ZlWIEUv6kAG2ZO2x@google.com>
References: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
 <20240527-cros_ec-hwmon-v3-2-e5cd5ab5ba37@weissschuh.net>
 <ZlV8HWlsHfoz8QMc@google.com>
 <3025747e-658a-47fa-8799-86e9e974b796@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3025747e-658a-47fa-8799-86e9e974b796@t-8ch.de>

On Tue, May 28, 2024 at 09:09:28AM +0200, Thomas Weißschuh wrote:
> On 2024-05-28 06:39:25+0000, Tzung-Bi Shih wrote:
> > On Mon, May 27, 2024 at 10:58:32PM +0200, Thomas Weißschuh wrote:
> > > +struct cros_ec_hwmon_priv {
> > > +	struct cros_ec_device *cros_ec;
> > > +	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
> > > +	u8 usable_fans;
> > > +};
> > > +
> > > +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> > > +{
> > > +	u16 data;
> > > +	int ret;
> > > +
> > > +	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	data = le16_to_cpu(data);
> > > +	*speed = data;
> > > +
> > > +	if (data == EC_FAN_SPEED_NOT_PRESENT || data == EC_FAN_SPEED_STALLED)
> > > +		return -EIO;
> > 
> > `data` could be eliminated; use `*speed` instead.
> 
> Then the le16 value would need to be written directly to the out
> parameter. The current usage relies on *speed (sometimes) being set even
> if ret != 0.
> 
> (See next response block)
> 
> > 
> > > +static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> > > +			      u32 attr, int channel, long *val)
> > > +{
> > [...]
> > > +	u16 speed = 0;
> > > +	u8 temp = 0;
> > 
> > They don't need to initialize.
> 
> They need to.
> 
> The logic
> 
> if (ret == -EIO && speed == EC_FAN_SPEED_STALLED)
> 	ret = 0;
> 
> relies on -EIO and a write to speed from cros_ec_hwmon_read_fan_speed().
> 
> But if cros_ec_cmd_readmem() already returns -EIO, then speed would be
> uninitialized.

I see.

