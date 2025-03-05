Return-Path: <linux-kernel+bounces-547015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BE6A501CE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D6C3B31BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABFE24BC16;
	Wed,  5 Mar 2025 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1hZZrAKo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4B3205AB0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184543; cv=none; b=j4NtjkIlO7u4V4xWGeFUkV2nDHbGVSAoSJXB7QRXTDxCs/dGWwqvu7ZNv6wylZ5EEzn5Tu/sIRuYczlr3N7wknPo6XBzhdZll6qoSXdVUl49IHzof78c9u5EAlBl2cDmlDNb+7LoFg5rPEpw3Tru96z5gBYQK4wzzXiHXxyV+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184543; c=relaxed/simple;
	bh=q1p0lGw08RL5YMRCYScVDOI5FKKA+immX9xRe/ayVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBss6qLYlMtQbrgLZmtvl8p3tzDiMlSQ5k9t6sxfFBO2eLkzQy2S6SV/Wee8nl/TECbgYyoGRyVhgfGXWNRZ8KluIH7GCmDA+neYSvxfTl5zr3+tqNVVveXbCLVt1ObiCxyd3zoEAe4xT3bUk9mp3dB+M13mzbe3tar5M7I7D+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1hZZrAKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF1EC4CED1;
	Wed,  5 Mar 2025 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741184543;
	bh=q1p0lGw08RL5YMRCYScVDOI5FKKA+immX9xRe/ayVgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1hZZrAKojMCyLsI8KoHPRX4ZEHC1upK12IAHBj3dzD1LXa4LfbP1U87QhzEDgQWN+
	 lM5U3sp+r+5dO6xNrZnMCmJDTmm6M7OBtGUYt+RGaJucgiEyi+3Bw8C9+DuketF8uS
	 9Oqv4yeBBUBg/zcXNzn3eOUebMkjB10t6KETqw6g=
Date: Wed, 5 Mar 2025 15:22:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zxyan Zhu <zxyan20@163.com>
Cc: broonie@kernel.org, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regmap: debugfs: Fix name collision without atomic
 operations
Message-ID: <2025030531-spilt-duchess-0fa5@gregkh>
References: <20250305133251.44082-1-zxyan20@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305133251.44082-1-zxyan20@163.com>

On Wed, Mar 05, 2025 at 09:32:52PM +0800, Zxyan Zhu wrote:
> Thanks for the feedback! I think using atomic_t is a better fit here
> than idr because:
> 1. It's lighter and simpler for our basic indexing needs.

No, idr, and ida (don't remember which is which for this use case, but
one of them is the right one) was explicitly written for this exact type
of functionality.

> 2. No extra resource management is needed. If we use idr, we'd have to
>  handle resource cleanup and add locks for debugfs_init/debugfs_exit
>  concurrency.

The idr has a lock in it, right?  Use that.

> 3. As Mark mentioned, id continuity isn't a hard requirement, so we
>  can even skip the atomic_dec on kasprintf failure.

Again, use the data structure designed for this very thing.  To ignore
that feels very odd.

Drivers should almost NEVER use atomic values, as there are other apis
to use instead that are correct.  If you find yourself using one, always
verify that you really should be doing that.

thanks,

greg k-h

