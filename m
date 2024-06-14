Return-Path: <linux-kernel+bounces-214220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D61A5908189
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFB21C20D08
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D8183073;
	Fri, 14 Jun 2024 02:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYwz+2Ok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803862AE75;
	Fri, 14 Jun 2024 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718331677; cv=none; b=tqaCShxScfrXK5WgsVSoRycrmd/g4gD6oSZh/pyOfiQu4l0KXSjC8zoUzw5UiDIvOTJ5i2xbyP4NDy1xtXdN117kLima9p5IKq4fbtG10Z2k+CS+ReOpOnNTQ60Cu5ciBGg5MOdqtUeY98Yqy5P0gn9j4wuCkXWZKY52ikBCgS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718331677; c=relaxed/simple;
	bh=BNG0nAvaHGm3HWERpezfVrO8KZGZ2JvMeFwF0CQszUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWEiODehZ0lhMid4U5xPJzljCjE79wAv6c70wXABLbkHma7tGVgQS9St2CmjeUfNrosazo4fIRZAk0Cu4NNFZ7aNpW5gCkq7/LZi/WTCavadPhuWr7S3cu8H6oZjWnCwHyP+YHZUBFReRpOUEIR7ALw7K9/BQVIpzNvZwr8uYrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYwz+2Ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA239C2BBFC;
	Fri, 14 Jun 2024 02:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718331677;
	bh=BNG0nAvaHGm3HWERpezfVrO8KZGZ2JvMeFwF0CQszUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYwz+2Okf9is4/9hlucE2Oyd1SvFV2qx7OeIcUKUFzx99mRCN/CDhihLCXgHdI2L/
	 ekPPpDh1B/153moJ9XJGFgV8BUAQGrMGq/dxjYsESYJqkskzrv4tspk6LeXPS89AKv
	 SccrLYtjI74cHL+yNk3k+/WYzvgNt38uGAG9eO8LX5Yv+cvygDSYWLsAWNLx9bRYvV
	 6wggHmIeMsYSmOEXj0LD0kUmqcJAGR2tZsjDzTrK0A0a55aCkv0c6qJt1gdF5CAsB2
	 vYUdp+wyQeH61im70SKWz7zIQB3KUEq7dJQlcjVZPTrqn8Em5NvaVytAF2F13vamkC
	 6THrVKVaA1oug==
Date: Fri, 14 Jun 2024 02:21:13 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Fix error code in
 cros_ec_lpc_mec_read_bytes()
Message-ID: <ZmupGcjkuU0bNtdl@google.com>
References: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
 <87sexgrdk4.fsf@jubnut.com>
 <ZmsvHBrYSpwYLyxx@google.com>
 <87o784ac55.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o784ac55.fsf@jubnut.com>

On Thu, Jun 13, 2024 at 08:14:14PM +0100, Ben Walsh wrote:
> Tzung-Bi Shih <tzungbi@kernel.org> writes:
> > On Thu, Jun 13, 2024 at 05:51:39PM +0100, Ben Walsh wrote:
> >>   or 2. Put in a check for length == 0.
> >> 
> >>   or 3. Change the logic in `fwk_ec_lpc_mec_in_range`. Although I'm not
> >>   sure what the correct answer is to "zero length is in range?"
> >> 
> >> I prefer option 2. What do you think?
> >
> > How about drop the length check at [2]?
> >
> > [2]: https://elixir.bootlin.com/linux/v6.9/source/drivers/platform/chrome/cros_ec_lpc_mec.c#L44
> >
> 
> This works, but we still end up calling cros_ec_lpc_io_bytes_mec() with
> zero length. Although this seems to work fine, we could put a length
> check at the top of cros_ec_lpc_read_bytes() to avoid it.

I guess you mean: cros_ec_lpc_io_bytes_mec().  Ack.

