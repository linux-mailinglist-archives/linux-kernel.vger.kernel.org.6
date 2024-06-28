Return-Path: <linux-kernel+bounces-234561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D4B91C80B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5388F1F22C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A47F7CA;
	Fri, 28 Jun 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sxtsOYtP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171917EEF5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609627; cv=none; b=Rh/N2gDF56C3fRf7OfDdTbxUoT0TYFCQtUdmukZ59KHDCKuR8XmYnS8nrrDScaJrPVkqlb8aVlSR2VGMHAwzQ03uls8PkT4jP0d2feAdZLXPwQeQPa8QFZYHx6VNPEavKgHqStryOZDU/rsSsIhtl65Cs97ZXopxCu3+JHMmCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609627; c=relaxed/simple;
	bh=mfF2wfQxdFBuMi88fRsAiQshTfnQG3t3/Hvg7zr5Eyw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Iyq/v8knslZOULRYqWsiFZvpTNbmf2uEZ8/s5wxJ2xnvKiGrfAI2vHwlSSBrYJgE7mbh8xdXnyvXDOC40Lvkk9IS7S0N3xGhyYCaRr6QmSyzf9PiDM0lF1k9HMsbyftMyrLFbPLbAkB/4HMHbsrTWmJ4SlxEaV+pLDETsNecXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sxtsOYtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DA6C2BD10;
	Fri, 28 Jun 2024 21:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719609626;
	bh=mfF2wfQxdFBuMi88fRsAiQshTfnQG3t3/Hvg7zr5Eyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sxtsOYtPgR4H2hwACWGfznAZmhWDA2B2XsxQUzhyvh70GyOSOCypIpsQFpmaIhCMK
	 Yd3GpOYT7vkrvr/qYLX29Ce0gChJpwhPdshF6vc7gjV48BcybNoYqgl7jXPBqJd3W1
	 OWXPkYTttt7teolpwc7PFojWGafEoYvgZCnsAIpc=
Date: Fri, 28 Jun 2024 14:20:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mul_u64_u64_div_u64: make it precise always
Message-Id: <20240628142025.50ac4c92bfd2034668a0cc22@linux-foundation.org>
In-Reply-To: <39o9pnn4-p22s-rp4p-067n-83s18o5prnpn@onlyvoer.pbz>
References: <39o9pnn4-p22s-rp4p-067n-83s18o5prnpn@onlyvoer.pbz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 15:06:20 -0400 (EDT) Nicolas Pitre <npitre@baylibre.com> wrote:

> Library facilities must always return exact results. If the caller may
> be contented with approximations then it should do the approximation on
> its own.
> 
> In this particular case the comment in the code says "the algorithm
> ... might lose some precision". Well, if you try it with e.g.:
> 
> 	a = 18446462598732840960
> 	b = 18446462598732840960
> 	c = 18446462598732840961
> 
> then the produced answer is 0 whereas the exact answer should be
> 18446462598732840959. This is _some_ precision loss indeed!
> 
> Let's reimplement this function so it always produces the exact result
> regardless of its inputs while preserving existing fast paths
> when possible.

I assume this was tested with some userspace harness?  It would be
interesting to see that so that reviewers can see that suitable cases
have been covered.

