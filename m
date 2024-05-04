Return-Path: <linux-kernel+bounces-168748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3818BBD0D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14DFB21437
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333D56B76;
	Sat,  4 May 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YjdLzQG7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACB74E1C9;
	Sat,  4 May 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714839488; cv=none; b=QmkRJel7RwfT3C8ymuStlb4+SmYKLpnn/e1fZJ4xTj9zlReAORcvKQZJAb04F0OqxSK4xIQvVMx+rsHjWgiH9PfyFMeISXpnmLfCYQqqqpiRjPE0K8ZUhbNjjlfCN7VY21ravgnSKyg0okQBcWeLqhi2qygAnGF5r0ZoUuXpNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714839488; c=relaxed/simple;
	bh=/J4pe6b3rK2ZUPDwtDpRK0Z/bGvMgNCqH1lmwkwOugI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPHdQZOZSik4wSlellKVnEnbe8ZnzfP57nOGUOAYQvro7vM1+e+1Gm8HChtEJnU37aA1KP7I/G3HRWNseJJbvFn9llpK+w5S2aukI//P3bijofioLPggoV4aReaEe+oiBag2n7gNaDoEuQ9hrEvuXIBSjjCYqPQx76QlSVpcazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YjdLzQG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181EEC072AA;
	Sat,  4 May 2024 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714839487;
	bh=/J4pe6b3rK2ZUPDwtDpRK0Z/bGvMgNCqH1lmwkwOugI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjdLzQG7aVfg1HIbTDlxwItjyUT1aP7FBsSDLiD93PsGKclunF1wu/t61OLNdK9wK
	 ES5W91q26MotxiL9Z/JG5QHH6RbuKebFNZ5aDHXA1OewZa3iOnLyRX4r8nhBORmUp2
	 qOoTXt+tcK9vERf0ADNDmwqyVTot2kXb+q24kRqY=
Date: Sat, 4 May 2024 18:18:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: R SUNDAR <prosunofficial@gmail.com>
Cc: heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org, christophe.jaillet@wanadoo.fr,
	u.kleine-koenig@pengutronix.de, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2] usb: typec: mux: replace of_node_put() with __free
 [linux-next]
Message-ID: <2024050443-coerce-bonus-977a@gregkh>
References: <20240410175804.5195-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410175804.5195-1-prosunofficial@gmail.com>

On Wed, Apr 10, 2024 at 11:28:04PM +0530, R SUNDAR wrote:
> use the new cleanup magic to replace of_node_put() with
> __free(device_node) marking to auto release and to simplify the error
> paths.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>

Please fix your name up for the next version.

> ---
> 
> Link to v1 - https://lore.kernel.org/all/CAA8EJppfzXEzzrQ_11O94MVn2dhcF2kGd9RR8ctJ1GmK=6C+ZQ@mail.gmail.com/
> 
> Changes in v2: reverted the structure declaration to top of the function.

How was this tested?

thanks,

greg k-h

