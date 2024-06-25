Return-Path: <linux-kernel+bounces-229316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6C916E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC21F22C97
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6135117334B;
	Tue, 25 Jun 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQfthsjd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8513B2B0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333456; cv=none; b=bBFIzzY+IWgW2DI/Qj0AjcDjASEbkIs9AUXtJ4trAccIHnmwHhrK9rNAtHXrVKVlcNRrIF5TGGofVaEJI3T9blE9KDy46F84yhcXaOtZil4hsdoKMhBxkKwmUEPKl7KfMmFVDjvlV0q2+R29I8wX0xn58UruzVnczClHqAImU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333456; c=relaxed/simple;
	bh=8PtmWZFEhdO5oFL3PM6WujyngC0aarxAvSZebgwjOKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5uUSEImVMczBblhlceHilkItNtWkLB3PS4sRDiX2J3BN/C+VDaBbj85T0aiGyqcevMlDEJmHbpFyStoD1bMhgdrASNCOPQ8BgMbzrIBrACBV9zrrDp2HnSVLD/4nREcDNFfFm1FtwzRicBTKmuOUQKYJwQfb0rRsFO331k4kJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQfthsjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D51C32781;
	Tue, 25 Jun 2024 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719333456;
	bh=8PtmWZFEhdO5oFL3PM6WujyngC0aarxAvSZebgwjOKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQfthsjd1lxzW7BWvWz2HsTLM/9w6xXKcOgxhp/N5RlgkiZQOpJe98ArJbS5PNqpN
	 2KmAHkSsRTFt1wyR+hivHTLUUN8fh/mcgWliLI18fdLrq4v6MmEtjK6aEk/kkvlVzo
	 HRKDmO6mizwDOi7Qw/1EOlWirOE/uHQoJIoakMBq8YfTog3rEDWL3F8oizB9bVCUoM
	 2eBf0qN/iRN/xeUrwH+/wsQ27OAt4p7xacJC+hUe/zqHEDyP9CgeqPGsi997zXmEHv
	 omQvuuWqkeFqQYZS/YHeA/Dn/wAqJGgqZVHeY1qsEVb8z+Fo4nBON3TBxIZfWb/O3y
	 LN4XDII3yTMeg==
Date: Tue, 25 Jun 2024 10:37:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, emilne@redhat.com,
	jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v8 0/2] nvme: queue-depth multipath iopolicy
Message-ID: <ZnryTZqwlz61s0D4@kbusch-mbp.dhcp.thefacebook.com>
References: <20240625122605.857462-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625122605.857462-1-jmeneghi@redhat.com>

On Tue, Jun 25, 2024 at 08:26:03AM -0400, John Meneghini wrote:
> Please add this to nvme-6.11.

This looks good to me! I'll give another day for potential
comments/reviews, but I think this okay for 6.11.

