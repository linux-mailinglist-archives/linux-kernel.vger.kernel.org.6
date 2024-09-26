Return-Path: <linux-kernel+bounces-340633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB490987613
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A781C25352
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B99214F126;
	Thu, 26 Sep 2024 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeZ2c9kU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339914884F;
	Thu, 26 Sep 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362616; cv=none; b=uBxki3jSJ2huWXPvpYIQacGTZKjxXe2bRPaMTzzF/9r/fOt9iBLJKAkbnpZOrvgFXAOf8+YEqkz/T63JPv0Of5PmGdbICrlZiaIF8KP6nlCR0vYGdT4SDGlFQSro8BMLMUUrAMThlfCA2Maln4ROGKUPmRluHFEARZzNJudHABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362616; c=relaxed/simple;
	bh=koU45tsafl6q3bK7FOZZq1zw3+PWqldRYHm8pFUO1Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTRjyvJdRpmcUsFCjiEcRJKBwj8C9RhCAeugb7z6Q9CJLB5DfjLWDyPXXCHdRh5V/ELNKk0FQjwBnuhjbedODmHFLWL6nvhu77REr83Fz72a/T2zF8GleE/GV3kmhJtWK6C4h5G6UXoAadwO+URaz/rYDddsqHrNgIHzoQz3wWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeZ2c9kU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727362615; x=1758898615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=koU45tsafl6q3bK7FOZZq1zw3+PWqldRYHm8pFUO1Uo=;
  b=IeZ2c9kU+6y8eaN5w5Zzoe1w3zCB65V/vo0wWvLY+mraiBSoPm5Jtk09
   RXkkzL+KjOI+stfNucPB4pUg2hqg4TtQcJrFD31ppacWUM8ZnRncavU2p
   eD7KHZNJbsnBrxXeTPYrJT4yyMdrug275ERJ2QOt8ZWgdC7wmAtmi7wgi
   YiJ8cMoF9bUaHs+LbZwHoAMDRJzApmo2NA8Hz0tW/aHOuxcWisCclLP2g
   faWNCmUuL20O7WDkIkJcrlif+ciC4oMKZVdnxpNlFrV6XKlFlnbXqub3/
   JsrN37rLHzunVNvXimcVDTULFMjmCvy7EE+7qlUgwnHf052FVXhr/qGnx
   g==;
X-CSE-ConnectionGUID: Ld5VPHYsTaS4JiO9D3aJzg==
X-CSE-MsgGUID: rQwHHE8wQ72XCKg+ICwBzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="48995275"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="48995275"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:56:55 -0700
X-CSE-ConnectionGUID: lW8XC5FxReqpIA3sAP1BoQ==
X-CSE-MsgGUID: BFiY4MyrSFKd6IVrWrQt1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="102968638"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa002.jf.intel.com with SMTP; 26 Sep 2024 07:56:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Sep 2024 17:56:51 +0300
Date: Thu, 26 Sep 2024 17:56:51 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/1] usb: typec: stusb160x: Make use of
 i2c_get_match_data()
Message-ID: <ZvV2M7GBiInRO2PK@kuha.fi.intel.com>
References: <20240926122944.1251923-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926122944.1251923-1-andriy.shevchenko@linux.intel.com>

On Thu, Sep 26, 2024 at 03:29:15PM +0300, Andy Shevchenko wrote:
> Get matching data in one step by switching to use i2c_get_match_data().
> As a positive side effect the matching data is qualified as a constant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2: fixed rebase issue which led to the compilation error (LKP)
>  drivers/usb/typec/stusb160x.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
> index f3140fc04c12..6d85b25b40bc 100644
> --- a/drivers/usb/typec/stusb160x.c
> +++ b/drivers/usb/typec/stusb160x.c
> @@ -633,9 +633,8 @@ MODULE_DEVICE_TABLE(of, stusb160x_of_match);
>  
>  static int stusb160x_probe(struct i2c_client *client)
>  {
> +	const struct regmap_config *regmap_config;
>  	struct stusb160x *chip;
> -	const struct of_device_id *match;
> -	struct regmap_config *regmap_config;
>  	struct fwnode_handle *fwnode;
>  	int ret;
>  
> @@ -645,8 +644,8 @@ static int stusb160x_probe(struct i2c_client *client)
>  
>  	i2c_set_clientdata(client, chip);
>  
> -	match = i2c_of_match_device(stusb160x_of_match, client);
> -	regmap_config = (struct regmap_config *)match->data;
> +	regmap_config = i2c_get_match_data(client);
> +
>  	chip->regmap = devm_regmap_init_i2c(client, regmap_config);
>  	if (IS_ERR(chip->regmap)) {
>  		ret = PTR_ERR(chip->regmap);
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac

-- 
heikki

