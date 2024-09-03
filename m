Return-Path: <linux-kernel+bounces-313928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FE796AC74
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15726B20B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E244F1D7E26;
	Tue,  3 Sep 2024 22:44:06 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4081D7980
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403446; cv=none; b=pj/BTZF+KaPK/JSeYnVKCurJuJPlVvlbn3+TMI/eMCEWKmyLWUDM3i09OcRlp5usekX01O/0rpJuHJKK9vooH7/bNgDJFqM0ldh0ysPmoES38hH/T5mWlGj0VMDd+RP1MV0Kj4sx6HPg5eBAyZaULtH5Az8ojMbvHKq6QLpztCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403446; c=relaxed/simple;
	bh=itxpL9AylZvLxi2g4MKj7cOwlR5V30GodpZINUgimWA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYuMAgRLKzv7JmA8TsTVdbSadt51gVnAoYwPaboMVYepnEDce11Oeoy3hJINcltKZ14YhQ8o7dKct3DhdXP8lpkQh6mvv2/lgtsozllRaOGn+LHgQ7M0llBmC4u4lyhqDO74GsGnW8TnN0wnJyj88WPUg8XmCqbfR+ycFzDEBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id fa384007-6a45-11ef-8ece-005056bdf889;
	Wed, 04 Sep 2024 01:43:45 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 01:43:45 +0300
To: Jonathan Cameron <jic23@kernel.org>
Cc: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: iio: rm .*.cmd when make clean
Message-ID: <ZteRIY3H0o4wYy1G@surfacebook.localdomain>
References: <20240831115931.596e35fb@jic23-huawei>
 <20240902035412.4835-1-zhangjiao2@cmss.chinamobile.com>
 <20240903200923.21c4c1ff@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903200923.21c4c1ff@jic23-huawei>

Tue, Sep 03, 2024 at 08:09:23PM +0100, Jonathan Cameron kirjoitti:
> On Mon,  2 Sep 2024 11:54:12 +0800
> zhangjiao2 <zhangjiao2@cmss.chinamobile.com> wrote:
> > On Sat, 31 Aug 2024 11:59:31, Jonathan Cameron wrote:
> > >> On Thu, 29 Aug 2024 13:33:09 +0800
> > >> zhangjiao2 <zhangjiao2@cmss.chinamobile.com> wrote:

...

> > >> rm .*.cmd when make clean  
> > > Where do those come from?  
> > 	Those come from tools/build/Build.include.
> > These .*.cmd files ware created when make.
> > So clean them when make clean.
> Hmm. I'm still a little curious about the path to those getting created as
> I don't see them. when testing.

At least this is documented here
https://elixir.bootlin.com/linux/v6.11-rc6/source/tools/build/Documentation/Build.txt#L149

Here is where they are being created
https://elixir.bootlin.com/linux/v6.11-rc6/source/tools/build/Build.include#L58

And it seems it is only created when there are actual dependencies.

-- 
With Best Regards,
Andy Shevchenko



