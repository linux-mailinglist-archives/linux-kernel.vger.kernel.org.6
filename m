Return-Path: <linux-kernel+bounces-213849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022C1907B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53F51C243F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1443A158213;
	Thu, 13 Jun 2024 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nueE7lgG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA371581EE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303692; cv=none; b=FO0sXej0NxnqJGmEuMXu2TWO7G8DXf1KB4zrKhE7WY+Y17yGnjY+YbJuPtl9LiP2xCXIk+RMuNqKV5m8IIIpXayGL9OpnuDH/xly9lFv5cFH3z7Tt5gZXEq0KWXbgw7rUbCSaefU2/bfDgFs6MtcSufwMGbqpeLJjRiuVnqiMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303692; c=relaxed/simple;
	bh=HzYejYuOAn5iwkrueS+PiiRJuMEgvDnHU5MUoSEiTXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ3ET2dnrcSPTZI8FDV181oFRYix9O/LPn443R65NNBvfrDhTgWKaMq2C7GA9Gs1bV38JdT7wGMzCNMDqa2eNtAYZrMz1cb1mxyEopAaTZd1R56cwyBbAD9+tUCTMF5ydKx59hgjOkh8lljk+iEgHypp4PADyxasDOYTwgHedAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nueE7lgG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421820fc26dso11825085e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718303689; x=1718908489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+98BqI659caT5fQyMNy5nW5CXfFil4jPP9JHzeqpioA=;
        b=nueE7lgG/naHoaPFwMMQmTbMK+2/EAH6ktB36ICcvkmhc2yVGAyH3y5E53CJgTwyF6
         dn+lrqcmtsufzy16Ul/EwLmaqTxX+YzxHyvixZKk+6lgapD+eQvNFHe01rNlivdLf/sj
         cLDPP7G51iuCnM0XpakbceOu8xN9cVJ5WsuEtC4qXMbYqPoTlYieZMHzREpEUBN952pA
         nOFdKlU0CGmofu2PHDd5cWmv9WplcAdVkyk5tOjH8cZuKXXwG0fiKDhmi+XPhhLBkCGh
         6Tx8M0dRq7rIzDrUkn3m+s6+1EPR+A4n0UqVjkPioFqnHJQ0Hc7ZDN5G7mq/y0IQAd+h
         +Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303689; x=1718908489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+98BqI659caT5fQyMNy5nW5CXfFil4jPP9JHzeqpioA=;
        b=H4GFJoW1H2xYQfsz/L8tRED5A0hJXPOE7cjtI7wl4wFhiInULDqig0TbDjCy11ZZR/
         0azdTtmeWLbkwW4fsRsCsrN5qXbtWqWChbrpFUmHDYAs8gw14sCOOcn4Z4plRz1iAW8r
         krU7hBi02r9ooVsRXFBwykg6BEjqKTWAcFVG5sATPXQMzu9EAjNxgV+Rcwo/vbz1AoOl
         5LwcvGay0ujChzYO/cdfPFMSCtE3AHKdhNMgfHBUobji+Qyv/vj6mlqr9Bf4yuKMWSE1
         iRLDKT4uSu8kPbDW6lKzl4H6vwUGcdR0gk7md+GNCjiucD+WoLxv3iSq2oGMIPsePSxM
         ebDA==
X-Forwarded-Encrypted: i=1; AJvYcCWHZl6QebH11T2+45gTwAarNisNwS45Lm99CzPi3EOHbiQsAsVI5NvExqOMrmVXfwaGRLbWveo3ga6gKP/NhWjsPow5CQfRVqkDaG2w
X-Gm-Message-State: AOJu0Yw1nNq8W5xtlbAM9FBDFABZ01hLZCfTwzHBD8Hz6hCN2Tzwign9
	Gmm3iqfDmpwCZ82GsQwAfIMT9OKa6I8YRCl5N1KM+LcVpENnRE97zozjH6lzSaVdnM4NaFPUdUi
	1
X-Google-Smtp-Source: AGHT+IH+s7hcDwfwjXdg6cobQ343oD9A/3tP8Z+Ip47trN4be35NWLP4NUKC3Qmn1FTyx++7yP9BQg==
X-Received: by 2002:a05:600c:4c9a:b0:421:7ac9:460c with SMTP id 5b1f17b1804b1-4230484cfc5mr4462905e9.39.1718303688813;
        Thu, 13 Jun 2024 11:34:48 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320b11sm33706145e9.29.2024.06.13.11.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 11:34:48 -0700 (PDT)
Date: Thu, 13 Jun 2024 21:34:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Fix error code in
 cros_ec_lpc_mec_read_bytes()
Message-ID: <68f1d8df-69d2-4246-8c64-4c7cc975feb1@moroto.mountain>
References: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
 <87sexgrdk4.fsf@jubnut.com>
 <3226cba0-82c5-47a3-89da-01ffa935a9dc@moroto.mountain>
 <87sexgaemn.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sexgaemn.fsf@jubnut.com>

On Thu, Jun 13, 2024 at 07:20:32PM +0100, Ben Walsh wrote:
> 
> Dan Carpenter <dan.carpenter@linaro.org> writes:
> 
> > On Thu, Jun 13, 2024 at 05:51:39PM +0100, Ben Walsh wrote:
> >> 
> >> Thanks for fixing this! Unfortunately `in_range` returns -EINVAL if
> >> length == 0 (see the definition of `fwk_ec_lpc_mec_in_range`). I'm sure
> >> this broke something in my testing, but I can't find what it was now.
> >
> > I don't think fwk_ec_lpc_mec_in_range() is upstream.  This email is the
> > only reference I can find to it on the internet.
> 
> Sorry, I mean cros_ec_lpc_mec_in_range().
> 
> >  int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
> >  {
> >  	if (length == 0)
> > -		return -EINVAL;
> > +		return 0;
> >  
> >  	if (WARN_ON(mec_emi_base == 0 || mec_emi_end == 0))
> >  		return -EINVAL;
> >
> > But I don't like how subtle that is.  Probably adding a check for
> > for if (length == 0) to the  to cros_ec_lpc_mec_read_bytes() seems
> > like the best option.  I guess option 2 is the best option.
> 
> Thanks. I'll check out Tzung-Bi's suggestions as well before we decide.

Writing length 0 bytes to cros_ec_lpc_io_bytes_mec() changes the
function to basically this:

	cros_ec_lpc_mec_lock();
	/* Initialize I/O at desired address */
	cros_ec_lpc_mec_emi_write_address(offset, access);
	cros_ec_lpc_mec_unlock();

	return 0;

I was a little concerned about the cros_ec_lpc_mec_emi_write_address()
But I don't know this subsystem at all so it might be fine.

Perhaps the cleanest thing is to delete the length == 0 check in
cros_ec_lpc_mec_in_range() and add one to the start of
cros_ec_lpc_io_bytes_mec().

I think that's a good solution.

regards,
dan carpenter


