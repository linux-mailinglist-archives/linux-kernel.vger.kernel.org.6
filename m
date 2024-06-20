Return-Path: <linux-kernel+bounces-223190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BEE910F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641F61F2396B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D6F1B4C3A;
	Thu, 20 Jun 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cBSVxayy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE41B4C26;
	Thu, 20 Jun 2024 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905070; cv=none; b=SxqyhtytUETksPSZf/DeR3ODwjDlsKcCTCgcM+16urcqvk1GkD/c1DWGUC16v9/fvSoN3o0Nok76T8k/n/WcDfkXTlWpIK2UBHzovDg7kZP/mbKWYKWWW2EfDSzBEHW+nT5qNEBRipH8O/2gza3en1aIreV7vdEPxu7vG7gCzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905070; c=relaxed/simple;
	bh=yUcba7XTwaAy9dHjTzqWubY7qwN5BUWdgWYQcZgo8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYxqG3qv39t7/gfeEYpIgklT7pmGBO01oTJaZlyvTfmIsoBzbuQCNDX8JCgmjHYhecbfzXWlulccxrNsZHt0w2PQDQYzjWXnya6GaQb/KZvkrLUyUUPbdZs8i4KbeDMUVCEfEtMCHzU4kSSMvTc9Es+Sb549Gru2c4x9Nn+9Iag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cBSVxayy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EBEC2BD10;
	Thu, 20 Jun 2024 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718905070;
	bh=yUcba7XTwaAy9dHjTzqWubY7qwN5BUWdgWYQcZgo8z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBSVxayydlKqsBV7c7gkAZm4j9op/CLk9rGMpVeGaV/GIZRrbiD4w1Bzfq9nty/7p
	 4dthpxaYdgxZxHOYFBOLxUQUxWySRwBZLFAo0rVHa5D5k7R1nVv4NC8GEHORKyBha3
	 UajhBcFMl1xCInnbXyBvbbjuaKyXqoa2IYZjusM8=
Date: Thu, 20 Jun 2024 19:37:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Jameson Thies <jthies@google.com>, Benson Leung <bleung@google.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: misc: onboard_usb_dev: Add match function
Message-ID: <2024062032-bobbing-backspace-8bd5@gregkh>
References: <20240612180448.1.I805556c176c626872c15ce001f0e8198e1f95ae1@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612180448.1.I805556c176c626872c15ce001f0e8198e1f95ae1@changeid>

On Wed, Jun 12, 2024 at 06:04:48PM +0000, Matthias Kaehlcke wrote:
> Add a match function for the onboard_usb_dev driver. Primary
> matching is still done through the VID:PID pair, as usual for
> USB devices. The new match function checks in addition whether
> the device has a device tree node, which is a needed for using
> the onboard_usb_dev driver.

So this fixes a problem with the existing code?  Or is for future
changes?

confused,

greg k-h

