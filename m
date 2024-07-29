Return-Path: <linux-kernel+bounces-265057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D26993EC00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD73B1C215B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A16180BFC;
	Mon, 29 Jul 2024 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJEQu2mF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489964A98;
	Mon, 29 Jul 2024 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722224865; cv=none; b=EdZrkjuySQWolfPnJ13aBV0czcpkVN4hLdj9MHLhLAV12JoqNYNJlK7mcu/zgftOAtkuEWvowfWONLHzswu3fOrBI0e5n/2m37FHj3LjGiAPYAxfYY8Cbh7pASFBl+0fp/95/cbgF65qBNeciar4PZVvfMP3CUGMn7I2hAgZoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722224865; c=relaxed/simple;
	bh=oJ0IQ1Ze9SUqhUekQMR5jj/3oORn2b6FJ8uTQJ0K0Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgUyf8cKpgI1ydr9f1ZW4pDrYFCIlwODow/0LUDiP+PRRKlwUhraDnL0Gv3R5QDmizXJ7/ask8a7BQo6looI5vrHWJ3vv6ZJMBjW5OmDAHVOkC7iNFgLgmut3xHqTufH6ZSgL7Yd5heOylc4aIAOK0Nf4vOYFfk2ZRugEkscQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJEQu2mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712D6C32786;
	Mon, 29 Jul 2024 03:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722224865;
	bh=oJ0IQ1Ze9SUqhUekQMR5jj/3oORn2b6FJ8uTQJ0K0Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJEQu2mFbQPWORhV6zPtXyj4R4DKDF2KeYwXpMIU3eFjHChIPTcOAtFzbblulG55Y
	 y8gsOUeBhSf9cr4ZUg2x/dcG7iSopUxo183yH79SeRbWgcZgEvW7cutrJR0CkgtHZ0
	 ULse3VL2HrOfwjhPYyEljkBZOCctQuZ6uFGZSW8lYMsSuChyixa5GiQdMsCGi/8/T1
	 whFdxRHIy1nbz5RD/3YqL0J8tZRXmwva4nFkGXeCph79FRIYy8bLHtZ5AvPhk/rDni
	 8CPIDEoYH8xk1IRb/nS5phCvZnMx6vgka2IZfH6sK8kjzkqAyULhnn0hyyuTHi+3yj
	 MD7zVCUZr9ilw==
Date: Mon, 29 Jul 2024 03:47:42 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Patryk Duda <patrykd@google.com>
Cc: Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Lock device when
 updating MKBP version
Message-ID: <ZqcQ3rjY6Wu4lU6t@google.com>
References: <20240725175714.1769080-1-patrykd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725175714.1769080-1-patrykd@google.com>

On Thu, Jul 25, 2024 at 05:57:13PM +0000, Patryk Duda wrote:
> The cros_ec_get_host_command_version_mask() function requires that the
> caller must have ec_dev->lock mutex before calling it. This requirement
> was not met and as a result it was possible that two commands were sent
> to the device at the same time.

To clarify:
- What would happen if multiple cros_ec_get_host_command_version_mask() calls
  at the same time?
- What are the callees?  I'm trying to understand the source of parallelism.

Also, the patch also needs an unlock at [1].

[1]: https://elixir.bootlin.com/linux/v6.10/source/drivers/platform/chrome/cros_ec_proto.c#L819

> The problem was observed while using UART backend which doesn't use any
> additional locks, unlike SPI backend which locks the controller until
> response is received.

Is it a general issue if multiple commands send to EC at a time?  If yes, it
should serialize that in the UART transportation.

