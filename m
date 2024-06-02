Return-Path: <linux-kernel+bounces-198151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB65B8D7420
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A33B2111E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3963E1D555;
	Sun,  2 Jun 2024 07:29:19 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E151CD06
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717313358; cv=none; b=izLhdoRxcw1FBX9YjodGl3NU5TXSCZHluhiXW3nq3VuHwXO6Yv2OvRepeTxYaYDDWR9ohfKUlS21gn3831kIUBV24t7kAYoJH3tKIWOsEF2xgBF5IEVoVoNuDTqpjRAKHG75Ncfs2F/MMzG7yHtFWAVUldfscj281ItwqV/bWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717313358; c=relaxed/simple;
	bh=zUZbFrgSobpP0gYNeUzRDdvN9yhMxp65fNvg1NuOxz4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn51pGjBkBSFMe+msASNi6QvvFfDYtfbCjt5wr099lNpxjEqYqtURGUZOn51m4OwydVaF50LU4ypdxRpgWjTMjnQYIxugrkccQltlGs0qrxbhr1uK9JiEiYbZ7gbhlMoPurGGQW86MXrhF5n/XJQ8eAlWXLohEfe4Z9rV2670QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id cc087c22-20b1-11ef-8e3d-005056bdf889;
	Sun, 02 Jun 2024 10:29:09 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Jun 2024 10:29:07 +0300
To: Jim Wylder <jwylder@google.com>
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap-i2c: Subtract reg size from max_write
Message-ID: <ZlwfQ3ERbo5snLcK@surfacebook.localdomain>
References: <20240523211437.2839942-1-jwylder@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523211437.2839942-1-jwylder@google.com>

Thu, May 23, 2024 at 04:14:36PM -0500, Jim Wylder kirjoitti:
> Currently, when an adapter defines a max_write_len quirk,
> the data will be chunked into data sizes equal to the
> max_write_len quirk value.  But the payload will be increased by
> the size of the register address before transmission.  The
> resulting value always ends up larger than the limit set
> by the quirk.
> 
> Avoid this error by setting regmap's max_write to the quirk's
> max_write_len minus the number of bytes for the register and
> padding.  This allows the chunking to work correctly for this
> limited case without impacting other use-cases.

...

>  		    (bus->max_raw_write == 0 || bus->max_raw_write > quirks->max_write_len))
> -			max_write = quirks->max_write_len;
> +			max_write = quirks->max_write_len -
> +				(config->reg_bits + config->pad_bits) / BITS_PER_BYTE;

Interesting. regmap-spi does this slightly differently, i.e. reg/8 + pad/8.
I'm wondering which one is more correct (potential off-by-one I suppose).

-- 
With Best Regards,
Andy Shevchenko



