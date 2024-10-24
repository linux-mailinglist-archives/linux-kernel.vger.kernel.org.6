Return-Path: <linux-kernel+bounces-379834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00A89AE469
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0589A1C217EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAEA1D173E;
	Thu, 24 Oct 2024 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5zfOseB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74C1C9B87
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771771; cv=none; b=TCxsxk/aOsiHyCDW7AjfqH53XqkqE/bb//8H9rfKlOwYUCmz0Od/xAsgp19W257u2qm+0QBQCXD7ins7k2xdnb8jNRNMeLytQTE8rLW3kHlJY+rTXdaODHDZlc5Q43ZjZFb1NcTT2inYvDiEttJvOih1Skna0k5/wx9J6M43ahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771771; c=relaxed/simple;
	bh=iomfgDWD5CNPh/yQuAmvEh6ZAtCf35TxW+HL9OdkpTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSxxBpxcA9K1yF5M9LHidLsTrGt9M7tCPm6ndESwlVZAnAm/hQWiyKTDB1eHRK/4bTsUdpnH6EjrpK0jroxvQZAQOYNS/VEGf27EyNg95zl4+jS7wWhhX1BQMPJtx/I1erYdvV57vhKwtnhdcCv3uL0KV9LGBAkcN7Ye0/LdCuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5zfOseB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6616C4CECC;
	Thu, 24 Oct 2024 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729771771;
	bh=iomfgDWD5CNPh/yQuAmvEh6ZAtCf35TxW+HL9OdkpTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5zfOseBU5At6zcSg1iZeNle02dtD8fPN9BgTj/4GRZnbZiFWew7XC5zKxwgiBpcv
	 vZ02+hIq3qAffniDfFtXzNrJUASWrNEux5QGE4ZcakH2v076KTfE8BHzjAXXd+JpuQ
	 AbsTDe4CIQRqtjkg3cNcfVuR/AYlzv5MzS7TbwTIl1pbV5Mr2FAHr+Vtzsc6RKn+SD
	 uwQQvSLY78eq820+bc7YfyEs603Qtz/Ye/FSjtf+1RTGrnGUDk0L6kzc+I55lYpS6Q
	 vxMlYNmWwCd6RjuDKyPJQo3HyuATn7Ak/CCb6ES3NrQnPsvOCQPrigpfkXUnGo+GnV
	 o7Xg3DS8bV+GQ==
Date: Thu, 24 Oct 2024 13:09:26 +0100
From: Will Deacon <will@kernel.org>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bbhushan2@marvell.com,
	gcherian@marvell.com, sgoutham@marvell.com,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v9 1/5] perf/marvell: Refactor to extract platform data -
 no functional change
Message-ID: <20241024120925.GB30510@willie-the-truck>
References: <20241016080153.3546353-1-gthiagarajan@marvell.com>
 <20241016080153.3546353-2-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016080153.3546353-2-gthiagarajan@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 16, 2024 at 01:31:49PM +0530, Gowthami Thiagarajan wrote:
> This commit introduces a refactor to the Marvell DDR pmu driver,
> specifically targeting the extraction of platform data
> (referred to as "pdata") from the existing driver. The purpose of
> this refactor is to prepare for the upcoming support of the next
> version of the Performance Monitoring Unit (PMU) in this
> driver.
> 
> No functional changes are introduced in this refactor. Its sole
> purpose is to improve code organization and pave the way for
> future enhancements to the driver.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 160 +++++++++++++++++++--------
>  1 file changed, 112 insertions(+), 48 deletions(-)

Please read the "Describe your changes" section of
Documentation/process/submitting-patches.rst. Specifically, we're
supposed to use the imperative mood and avoid saying "This patch" (This
commit).

Your other commit messages have the same problems.

Will

