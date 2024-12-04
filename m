Return-Path: <linux-kernel+bounces-430875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE46A9E36CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD42B23F80
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A61A256C;
	Wed,  4 Dec 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RYR4uqfN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3DBE5E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305030; cv=none; b=faoTgE7HbuVN4GoeNGesTdC1Zotlu/XL09L5gpiQXVK+GzgRLySf9K+XLmHV6B9qy8M5lE0nwmvcOXCCtT3LIsxYDj1FsCokO9YqwnLKjHrnPBHCrs88pzkPzzVJGRdUfltBh1Ts9T17mskLId9jpAqzQxblwygOLPS5HJVglVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305030; c=relaxed/simple;
	bh=rxWyTW0lRxSruHtMHyIW5XhmWmVe1Y9ShBiZ8bwT0L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7VuFwIsK87/yooPA4tIVh9ccn/Ffq7V+clE9OleA8xNJzzZKmkmaPbPou00AgQK2jJwGjnTkkrtklWCJtOkqYr7YDaUD1NaJHi05DdFLe5hNn/D7kz9tEI39vvH9KnMtUG2Z6YfTBy5aXzn1HlU4coyM/HEhRNY15HWNEGf/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RYR4uqfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5315BC4CED1;
	Wed,  4 Dec 2024 09:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733305030;
	bh=rxWyTW0lRxSruHtMHyIW5XhmWmVe1Y9ShBiZ8bwT0L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYR4uqfNjuEHrpaj4cKJTG3oQF57oiuylf0icMmx0eCCO3ZTolAlZ3JvzMSboLslk
	 77xPDuN7/LzSbOEgQDu2a4ptYoYtYQTTGUDauMoQW/0QgT9oUZ9Ul9q0DzulLB1K9V
	 u0gbQ9PleMxzxEER1Hk1wnxg01GARdPpUkntdH08=
Date: Wed, 4 Dec 2024 10:37:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Don't match device with NULL of_node/fwnode
Message-ID: <2024120450-jogging-duty-fad4@gregkh>
References: <20241204000259.2699841-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204000259.2699841-1-robh@kernel.org>

On Tue, Dec 03, 2024 at 06:02:59PM -0600, Rob Herring (Arm) wrote:
> It recently came up that of_find_device_by_node() will match a device
> with a NULL of_node pointer. This is not desired behavior. The returned
> struct device is also not deterministic.

It's not deterministic because a NULL pointer will cause that to happen,
or for some other reason?

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> It would be a bit more efficient to check this up front before we
> iterate thru devices, but there's a number of users of these functions
> and this isn't really a hot path.

Yeah, this should be fine.  Does this fix a problem now and we need it
merged for 6.13-final and backported, or can it just wait for 6.14-rc1?

thanks,

greg k-h

