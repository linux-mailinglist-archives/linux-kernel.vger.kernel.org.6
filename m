Return-Path: <linux-kernel+bounces-198304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D8B8D7670
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369D31C219EB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A44205D;
	Sun,  2 Jun 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJyg7vR7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C7219E7;
	Sun,  2 Jun 2024 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339785; cv=none; b=jkvBK3AlhNe3YHzpXkbsivLBmw5YVpRJ2Mca+9+bOl68yZ/DMjFv4+Nshyr1Utqz/tS4SB6yGY9i5Oe1fCXoWajFTqDrU6jaAkpB0ax1LT9OtK0O/fS5/Bp2tt+I3+t40mm7rJ3SZylEpXXrxzHC0jTfyF3etd0e9V96zI5x8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339785; c=relaxed/simple;
	bh=qqpqDZSrYTMw/+DH41TIxGx0oYZrcIkZ38JENHmMPBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHx5+76x9mLa8RPe1VCCAXjopLZETTnUuON4CLT5gyWSWU0YxkgUTxINvbLqZGxFbmxif0YTyci9d0p6hU6QUSsZNl3wjGp0Sl2Y1B0v+W7foQdvR1113Fgb+jziwmc53u5BMZ6K/4DeC/l/VcsngXpkvndS7lAAL/2UYBMzEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJyg7vR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F8FC2BBFC;
	Sun,  2 Jun 2024 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717339785;
	bh=qqpqDZSrYTMw/+DH41TIxGx0oYZrcIkZ38JENHmMPBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJyg7vR70GoaKryNgXpEIw0bOarjnZ/mKREJ/MOVm2FtiinHu2v4otRv06gM4NHRf
	 DvYR1BQ0dfsLVjIGOzncbYbDwBGi1rDLIBeeFMOhYeJpkvnqSzcjyE1BHq9NiWmjFL
	 OUk2SeQEXkqqLyKs3fC+lGgU7jyhG2TUeuPLk0AqpbS+PUVes2MS0+648YfHh01E91
	 DPgjCIrRQPp9G4N5uXUCVyMPhfiD+wqUbmq9jCDBp/UW1DXdCuDimMYgfsfIf0WMBa
	 FGpEoINOsqJWrd/5x87AB/wJ6hL6AX7/s47wGSpxfxYOcuHLxRjTxOoyFjhQxmpuEQ
	 Dc/05BvAjbCnA==
Date: Sun, 2 Jun 2024 20:19:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de,
	broonie@kernel.org, rafael@kernel.org,
	andriy.shevchenko@linux.intel.com,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] soundwire: slave: simplify code with
 acpi_get_local_u64_address()
Message-ID: <ZlyGhHNkcgrojyqs@matsya>
References: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com>
 <20240528192936.16180-3-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528192936.16180-3-pierre-louis.bossart@linux.intel.com>

On 28-05-24, 14:29, Pierre-Louis Bossart wrote:
> Now we have a helper so there's no need to open-code.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

