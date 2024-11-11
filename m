Return-Path: <linux-kernel+bounces-404824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952F9C48C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D84C28370C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9788C1BC9F9;
	Mon, 11 Nov 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnLbdQ1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161F166F32;
	Mon, 11 Nov 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362754; cv=none; b=V3D7MKnA4LObF6asxuUIjV8I+c94IVB1vDu5c2lMk0Tdc7YXffegxhf+6Wo9MvIuZegGqsu0atMA9JoK35kOkYTvFXnwTuZJieOi/BxkIOt6LkxDFtlqdnzS3GHn5Sn2jUSI9wtx1/Vl+XfYVvvtQK3O6oznkT8hJZOipWv3A5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362754; c=relaxed/simple;
	bh=r7bR4MJ+C+mHCYGCz2Bb8i03zyGBAqFWkQc68ZftXcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp6bm07I5+0AEJbCLVKWWlpEnTr1UbEOQdPQYb7WSk08nQtqw1TF+HopY2Qvq2hoHFCBAQBiJUPSVj6tmJnSRTkFp+tLSKkHCgD8BdqdmeLLnUFTfMOwB5oCJJY7uxJ1528qa/oa5f+02FmbYMys7npsE/rzcuE9VwpAuh/2vnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnLbdQ1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC27C4CECF;
	Mon, 11 Nov 2024 22:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731362753;
	bh=r7bR4MJ+C+mHCYGCz2Bb8i03zyGBAqFWkQc68ZftXcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnLbdQ1SdpX6HyCl6fneVSJ+sPBPXpLWyKJR1z+9RGqKVG/PAqQ7sZEPZrZ1ljVzB
	 DX10gOJIH1LSoyc7jp4oNb6RfvBO3BttgVG6pVLR5Ci8P04bRkPYzKPgrGGFnmoh6M
	 FUu1hpCo0+vDrztREdYkWl5a7DGgVYJqPxuiHO4Gb6klsCsVFcmNBvTPzj5fzFW3qW
	 nMvzRQQQpnGH5HiryoycbhMPUFKIFwQaEfJ+GrIa40ayd4yxrvwWaM9sgu8U4ZENfj
	 Zp9lrgy9HUDZ7BUGUqqbUkvjZGl4xhSOWGai9QItDIOSnJ1FGZgC0bMCFD7sIUO0zq
	 x7GRHP7MPVqQw==
Date: Mon, 11 Nov 2024 16:05:51 -0600
From: Rob Herring <robh@kernel.org>
To: Chanho Min <chanho.min@lge.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, gunho.lee@lge.com
Subject: Re: [PATCH] of/irq: Fix a missed udpate of out_irq->np
Message-ID: <20241111220551.GA2011376-robh@kernel.org>
References: <20241108023440.29509-1-chanho.min@lge.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108023440.29509-1-chanho.min@lge.com>

On Fri, Nov 08, 2024 at 11:34:40AM +0900, Chanho Min wrote:
> Since commit 935df1bd40d4 ("of/irq: Factor out parsing of interrupt-map parent
> phandle+args from of_irq_parse_raw()"), An interrupt tree without
> an interrupt-map is not updated to the parent interrupt and it causes the irq
> domain not to be found in some out-of-tree device-tree.

Please see the comments I had in the previous fix for this[1].

TBC, I'll take the fix being trivial, but not without some details on 
what platform and what the (non-conformant) DT looks like in the commit 
message.

Rob

[1] https://lore.kernel.org/all/CAL_Jsq+Wcag2Lzu_kLRb5ia=3hNUOs1Ny93Y541eOY-NZOA5qw@mail.gmail.com/


