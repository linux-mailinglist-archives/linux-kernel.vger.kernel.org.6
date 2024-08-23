Return-Path: <linux-kernel+bounces-298969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F419D95CE6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3B1B20A59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACF188594;
	Fri, 23 Aug 2024 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N80b6+Ya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609981865E3;
	Fri, 23 Aug 2024 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421129; cv=none; b=oJLQ+i+T1JoA8VgGXGH7fQ1qUJLImcemuEgzcZCkDgy5q+YAsFqotV8n+CEPwpJgNdqSkJWlgeFyNGjircBqI+wDximV5NHqfmeNRZwaHeSb6j6/TgaxMH8pXb1u8tBAzvFq+A6vCYLNRcXCehQTzx94qTDfZ+uEHu+1VewXvHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421129; c=relaxed/simple;
	bh=RhwP9QW3XeOmnTE3QXqVNb4kMs9BiSJ5QGLJwHe3o+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOTldboXcFTcLFApZbkjpIBgBEzjDr/Us7b+odpTgGQfqdYuTXWIOpOtHZlrTfUef7r8aGE8YF5BMAfQqPhwjlLwkUgKqRhxDNC+Jx9XCnuy+GfiFQz2zkwPZnPJYtmnKTsrm0LTpDocifnSIpQGgsZypOhcjxJBWGv8JZ5ousc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N80b6+Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3A3C32786;
	Fri, 23 Aug 2024 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421128;
	bh=RhwP9QW3XeOmnTE3QXqVNb4kMs9BiSJ5QGLJwHe3o+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N80b6+YaVq0kDPuBqtxRLwLnDNPgfdSFJRPY81xbqXm95zg6+8R6mcKT99jHn2z39
	 1V3JoS2QZOniH1NsLPXNKFVzuywM0JDUjocqoPJKnLp0HW1otNOLmX+yGqHUgeTaDK
	 UDEMrahQRkVR2EWa0YjsIo7sIfrdTsQ3RsmLg7VPn13MM24hldTX0edmeeDlVPBX4q
	 Q43zJhw2zZwatTSblhz9tyGOjKO8TWQ9Y23LEqKaG3Kr0cAHiWUOArZ7AdUciXiDO8
	 ZteDEfKFjx0eOVmEhg//OYVvwMwf9qB5aKYsYZt/z/DBo/mvVGfxvLzEuTJ9S4AN4j
	 5r7Ksa6WsIKcA==
Date: Fri, 23 Aug 2024 21:52:04 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3] platform/chrome: chromeos_laptop: Use kmemdup_array
 instead of kmemdup for multiple allocation
Message-ID: <ZsiUBGz5Y4931iP5@tzungbi-laptop>
References: <20240823024056.3031644-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823024056.3031644-1-yujiaoliang@vivo.com>

On Fri, Aug 23, 2024 at 10:40:56AM +0800, Yu Jiaoliang wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

Thanks!

[1/1] platform/chrome: chromeos_laptop: Use kmemdup_array
      commit: d1b35e6d34e9b46fbf98444dd7aa114c032e9ac0

