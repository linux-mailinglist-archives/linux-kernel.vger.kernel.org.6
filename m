Return-Path: <linux-kernel+bounces-269182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6917F942EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221B1287E07
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851221AD9FF;
	Wed, 31 Jul 2024 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pPAl4iOU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644518DF62
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429941; cv=none; b=I/hZudV8iqMqcH0c73JWFgsc0YsADzrfw4llUrqXkYFn2iN10TjcULA1rtUqNc2Uokh6LSeOC4XokvGjx4DgJBrqQiqDxzRx4HOqb/lVqPnaGXbHXjZJK+9vA9L1284UEWTcb7KPhno27Gp67BPqsXLEGD4R02UqsH04D8RqIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429941; c=relaxed/simple;
	bh=+GPzbDOsidhFZ3Y4CmebonwYwnqKoagFXlUDvpg98F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgw3cK06oEbBX11wN3lImmSt4U5Z7qUpyFD7rnVDO4emvL0m0HrBxPZJspK24I2XJnOMSXlRM3g0MO35E2ZAvJ2bcgRLvBJ29rsuTvIIaunQ0HqpM/8avRwIkL4IwmJrl/PhijHWYRF390E3bI8Cl18W9Lc23t3W8ue7kPOpGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pPAl4iOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90369C116B1;
	Wed, 31 Jul 2024 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722429941;
	bh=+GPzbDOsidhFZ3Y4CmebonwYwnqKoagFXlUDvpg98F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPAl4iOULqXixQGi4H1zDZR1R9kqTf5Pa9K8NruQjjvxnGV5sK5BuYZBqFG4NO5Br
	 G64w9JNcaWUSFwuhZJfWzGoHeuNl4jyqT7UmxdlQq8tp3Rfs4EYNQWFPoC3+tKtmY1
	 9wywLky92FCTR4nblrPqRlS/n7TV7q/RWkIfcUgs=
Date: Wed, 31 Jul 2024 14:45:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5p2O5ZOy?= <sensor1010@163.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] driver:core: no need to invert the return value of
 the call_driver_probe()
Message-ID: <2024073100-outclass-yearbook-1feb@gregkh>
References: <20240710140041.4066-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710140041.4066-1-sensor1010@163.com>

On Wed, Jul 10, 2024 at 07:00:41AM -0700, 李哲 wrote:
> In the probe function (either drv->bus->probe() or drv->probe()),
> there is no return value of EPROBE_DEFER. the error return from probe
> should be -EPROBE_DEFER, hence no negation of call_driver_probe()'s
> return is needed, nor should there be an EPROBE_DEFER check in
> driver_probe_device()

Are you sure?  What makes the logic in commit 45ddcb42949f ("driver
core: Don't return EPROBE_DEFER to userspace during sysfs bind")
incorrect?  It required the check for EPROBE_DEFER like this, has
something changed since then to make this test not required?

thanks,

greg k-h

