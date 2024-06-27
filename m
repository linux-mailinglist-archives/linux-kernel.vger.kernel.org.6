Return-Path: <linux-kernel+bounces-232437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B4F91A8D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C55E1F28BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F160B197A87;
	Thu, 27 Jun 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q8WArM9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D26195B33;
	Thu, 27 Jun 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497465; cv=none; b=SM7CwWt/8d+3kGSE3CvGt+0DuAAQ24cp5lgHVgp3paPy+q1ZA/JgBZF8o/t7WeNCTRcfz1MbbMMaj6iBoX6neW4ke3XlY2+m1pfASySJpsP4Vm946e2rwDq56CyD1aiNUBmweTxLnzqPeW8CgFNaI4efdLJKEGQxPrHMIqTzkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497465; c=relaxed/simple;
	bh=4pyKeghgWQAKtrX0/RiOwcJJoKa0Ods4Nme4C33tAR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAYn5ip014BN4MIarJJj23KSQTKgUwievrEGOR2GgGpDckjURiwsicZ2jd5C3FnMh1hwEyG22RJSYAGqD1wL/N/+vccWKsWHadIz2EuWBeX7d0Y6OU0Z98hWZDiiw7Bcsu/yMuDJQQ0mHXNhCKTLPStmcSAzqYprOpDkCn+FTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q8WArM9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4421BC32786;
	Thu, 27 Jun 2024 14:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719497464;
	bh=4pyKeghgWQAKtrX0/RiOwcJJoKa0Ods4Nme4C33tAR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8WArM9O4a6jLSPyHq5pSrM9W2+3PSUywjYNcvCUH0MWl/8jg4hlvlAOwetA75RP8
	 vWTN2P5qaad7xuT73/etb59KL3O8Z+Z/wM22Ml0qhqLMFs9cGHfqiLBx1slWDb9WU0
	 /o9O3cw6Bw2Z5DnHIPTy/sKJbcGscg+zTOgXXmWo=
Date: Thu, 27 Jun 2024 16:11:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: glink: use
 device_for_each_child_node_scoped()
Message-ID: <2024062735-railway-stoning-566a@gregkh>
References: <20240623-ucsi_glink-scoped-v1-1-f0fdcfec69bb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623-ucsi_glink-scoped-v1-1-f0fdcfec69bb@gmail.com>

On Sun, Jun 23, 2024 at 12:35:11PM +0200, Javier Carrasco wrote:
> Use the scoped variant of `device_for_each_child_node()` to
> automatically handle early exits.
> 
> This prevents memory leaks if new error paths are introduced,
> as no explicit refcount decrement via `fwnode_handle_put()` is needed.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> This patch is a follow-up to the recently introduced commit c68942624e25
> ("usb: typec: ucsi: glink: fix child node release in probe function")
> to account for a safer approach to iterating over child nodes.

What branch/tree is this against?  It fails to apply to my usb-testing
branch at all :(

Can you rebase and resubmit?

thanks,

greg k-h

