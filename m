Return-Path: <linux-kernel+bounces-313963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6E96ACE2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2591C241AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C641D5CF0;
	Tue,  3 Sep 2024 23:28:30 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680712AEFD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725406110; cv=none; b=ZDnIw/LCweUbSaht8SDjcE01ts/0UKtD7QindIOOR1vvC6pXCdzPQqFThMjLh50g2xmid0jV4nqvwFgU2ZwEQL3hQ8Air2QFgW/CcDMbJtylf/ScSDmlknHm+ahciilXTXgNlcHbxqsADVrLYz69CEDh2POFBejFSzvJ+rjYJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725406110; c=relaxed/simple;
	bh=4aZLyiaXjXzyZDXWBCeDhL4IvZTYCLWT7OnTnVf+N4o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP18cPgVUlxeB5nSvyit5aHqeRmAAVTukrcW1qwLu1X+3FBGJitjLMqenz4cDqLFK6s1y4nh0bWWTcvLJ76hCy0YZZqJ2Ql5iYqeV8vGwn8vlcyyf+7wyRsFJBvXhrBJ5j1CNFoYdwj75KqgCwReDxRCBia8GPGo5rfEKuZIf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 3266ba95-6a4c-11ef-8ecf-005056bdf889;
	Wed, 04 Sep 2024 02:28:16 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 02:28:16 +0300
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, jean-baptiste.maneyrol@tdk.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Remove duplicate code between
 labels
Message-ID: <ZtebkIvceS5x9_ib@surfacebook.localdomain>
References: <20240901120839.9274-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901120839.9274-1-gye976@gmail.com>

Sun, Sep 01, 2024 at 09:08:39PM +0900, Gyeyoung Baek kirjoitti:
> 'flush_fifo' label performs same task as 'endsession' label
> immediately after calling 'env_reset_fifo' function.
> So i remove that duplication.

...

> -end_session:
> -	mutex_unlock(&st->lock);
> -	iio_trigger_notify_done(indio_dev->trig);
> -
> -	return IRQ_HANDLED;

You missed

	goto end_session;

here.

>  flush_fifo:
>  	/* Flush HW and SW FIFOs. */
>  	inv_reset_fifo(indio_dev);
> +
> +end_session:
>  	mutex_unlock(&st->lock);
>  	iio_trigger_notify_done(indio_dev->trig);

-- 
With Best Regards,
Andy Shevchenko



