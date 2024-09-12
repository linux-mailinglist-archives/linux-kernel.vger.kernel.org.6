Return-Path: <linux-kernel+bounces-326866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E34976DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDECF283ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835D1B984E;
	Thu, 12 Sep 2024 15:35:55 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A18844C8F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155354; cv=none; b=HepxcCSgKyU91F95mSNhdYcM9sFacVOtd1m+lc7ADNrMqD8EQG+t8qIEF49RAiRiQ39Fb25SxrVJybwmVoyHoEo4ikJ+HwyBxtdieORJLiMd3w+dLflnCsEKaGKuuSmwiAsork3TQmSxGxDiolhbsxHHlZrM4yJVbpa9xrIE1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155354; c=relaxed/simple;
	bh=naw2KYgxkUq5thI5FyeaglCUfU8OC8N5uOCGnoxdOEM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMP060f+HRkFYmEhkodC0z5JUXs5bAKA2RM3k7LxRRAQSFbblSENTgO9ABnQHzcj0FZn6/aZkoXXsVsE7QChsdxhsyKrU+Nc7YtaSKUrZfxyty9Vd/j4GWWltTNT8nSX0VBt1qxxZ27bn+JJErknJrVYHdxMWqRZJR2hGnm3XZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id adcf4374-711c-11ef-812b-005056bdd08f;
	Thu, 12 Sep 2024 18:35:46 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Sep 2024 18:35:46 +0300
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 08/12] i2c: isch: Use read_poll_timeout()
Message-ID: <ZuMKUnY58Blm7UX-@surfacebook.localdomain>
References: <20240911154820.2846187-1-andriy.shevchenko@linux.intel.com>
 <20240911154820.2846187-9-andriy.shevchenko@linux.intel.com>
 <pwvhzkxeniutopyxczvimkau3elchfy5x32cimlqwjnmqjzv42@zpojd2lxs3o4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pwvhzkxeniutopyxczvimkau3elchfy5x32cimlqwjnmqjzv42@zpojd2lxs3o4>

Thu, Sep 12, 2024 at 09:29:38AM +0200, Andi Shyti kirjoitti:

...

> > -		sch_io_wr8(priv, SMBHSTSTS, temp);
> > +		sch_io_wr8(priv, SMBHSTSTS, temp & 0x0f);
> 
> there is still a dev_dbg() using temp. To be on the safe side, do
> we want to do a "temp &= 0x0f" after the read_poll_timeout?

Isn't it even better that we have more information in the debug output?

-- 
With Best Regards,
Andy Shevchenko



