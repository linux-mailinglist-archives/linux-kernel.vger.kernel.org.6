Return-Path: <linux-kernel+bounces-294033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC159587FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DAAB22E03
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED971190678;
	Tue, 20 Aug 2024 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVBzl496"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A2190485
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160678; cv=none; b=m6zQOPs5fO9tLSYgx7vHxYdUTF2b+UsW4A0AF2TgYksuTWgkbkbYOY5KqujGZ1MAn1CoeIPDs8iobXsNlYCfsteqcLIszNF8594FDntJ+Su2rEgD9fv4IbPa6lNLx31x+iLYKT+4VFCD8ju+jgqKk6FgrPMlNGaNCbYnlT8jeyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160678; c=relaxed/simple;
	bh=uAc8Lep60iobU4iswgHSLdJR9LVE/jEHkoCK2Luey+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8ldrOHUjlNRHdOcoEHrVlvmAkMkR6gU2+6LbJvIV2P2b6SY+H01PC5Qtr2XnhKwnp3f6ijYWKAeot5VhRVTKO5AGhH9TdlQremgnKqILWaEl5uaGvgAnsJ9grMgdaP6c5rfO1hSDgHAgUqq2sT6DInDz/gYzawJiPwdTVY1y8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVBzl496; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F45CC4AF10;
	Tue, 20 Aug 2024 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724160677;
	bh=uAc8Lep60iobU4iswgHSLdJR9LVE/jEHkoCK2Luey+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVBzl496lUuYuXJ1j0wA7qDpDRR3tLI6wEsqp5+STq9chiKwJLzB9/SvPzwg6we32
	 8Zmg0L6BrgIAdjEfWwNGu4r9cimgrCkJHARs7IyqkTxlZmrMERaEDzkz4+ZVE2bqBJ
	 H8y61nJNpVxKDyMe86jVplrNyrCXCt27BCFN7D7E=
Date: Tue, 20 Aug 2024 21:31:15 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: drop __must_check from
 driver_for_each_device
Message-ID: <2024082021-service-handsaw-407b@gregkh>
References: <bd5221cf-2071-4be0-97b1-00a681482a5b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5221cf-2071-4be0-97b1-00a681482a5b@gmail.com>

On Tue, Aug 20, 2024 at 11:00:29AM +0200, Heiner Kallweit wrote:
> There are several users of driver_for_each_device where the worker
> function doesn't actually have a return value. One example is
> __igb_notify_dca(). This results in dead code just to make __must_check
> happy. So drop this annotation.

No, that code looks correct, the only "odd" thing is that it's a
notifier callback and so it requires a different translation of an error
message.

Personally, attempting for a driver to iterate over all devices assigned
to it just to print out a kernel log message seems like the big abuse
here, why is any of that needed at all?  Ah, that's a side affect of the
dca api there.  Ok, still looks correct, I don't see a problem.

Ignoring error values is not a good idea, let's not make it simple to do
so.

thanks,

greg k-h

