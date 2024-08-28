Return-Path: <linux-kernel+bounces-305539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD64963038
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAEF282245
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593051AB520;
	Wed, 28 Aug 2024 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBGSyrCI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E141AB504;
	Wed, 28 Aug 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870393; cv=none; b=fO0is+xsUdIXw41o2ZRMW409az4ohiQy7Vl9Aq87hatd1xWBhckf/hmvzH5V6//yQa2YAoOgJa0F1hxqoBSYWl9ZBJV6XJ2LViHNa9JjcsJc+thPsKYDmyLWpur4XFcY8L7o3+8/LvPSLp0hSfvjq0CRchmKTPyrHhjud0uiKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870393; c=relaxed/simple;
	bh=VcF43/65O253P7pePfq9VRow6d1vLNqhgwdz/Z0gN8Q=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=T59jK4m2/XZdEUOlJGUhdXBcbdMo9D7XIt+Hn9cNQWgB16fW0p9Oq1LUlk0reUwTZmbPKdMTzYlhKzRsGTAYeVHib1P5HJmufWurDqlW3f0omx6EgTOnvDA542IF1DQrWlWP+CQvPXVlUy0zg+a5s013+venaRuuHYyw8BZC5Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBGSyrCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC52C4CEC0;
	Wed, 28 Aug 2024 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724870393;
	bh=VcF43/65O253P7pePfq9VRow6d1vLNqhgwdz/Z0gN8Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=OBGSyrCIIeanuK+HVZupbQrRIZW+lIoYz8dkzHmGeSK8eoSwZXl0/4zBRG3WVHQ7Z
	 ryluoNPRP1IqzJm2wxIK1HJl+POhsVNyNLf1nz8+vPTZxWuHYHxQBXWSde8eysDPzU
	 /KGfnE1DCzC5tXujqm9AH0FTGfyrLntE8uOu/pslQzXqGKrl5kFr1xdU6nIDaaxA0g
	 /8GUfys0Qr9P+n526xV5teOGw1y8nPmkad2MxKrnNKtnQHSg+GUgsjH/m5qGH659pJ
	 RAJGAvq2Ij5h+z+wym3IkQp2D+VFSWUccjRrKpm0wL8xrVROi1xym1IBnjTus4VIBd
	 YkToSp6y6ku/g==
Message-ID: <def27b96be1c2a8b84f83a55e310bf95.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Zs8hRPA9Lya29d6d@smile.fi.intel.com>
References: <20240822155822.1771677-1-andriy.shevchenko@linux.intel.com> <9e16ddb1c1a697464ce1f5438ab9ca31.sboyd@kernel.org> <Zs8hRPA9Lya29d6d@smile.fi.intel.com>
Subject: Re: [PATCH v1 1/1] clk: devres: Simplify devres handling functions
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 28 Aug 2024 11:39:51 -0700
User-Agent: alot/0.10

Quoting Andy Shevchenko (2024-08-28 06:08:20)
> On Tue, Aug 27, 2024 at 05:19:04PM -0700, Stephen Boyd wrote:
> > Quoting Andy Shevchenko (2024-08-22 08:58:22)
>=20
> ...
>=20
> > > -       state =3D devres_alloc(devm_clk_release, sizeof(*state), GFP_=
KERNEL);
> > > +       state =3D devm_kmalloc(dev, sizeof(*state), GFP_KERNEL);
> >=20
> > When is this allocation freed if the get() fails? When the calling
> > device driver detaches?
>=20
> At device unbinding. Is it a problem?

It is a change, and the commit text said no functional change :(

