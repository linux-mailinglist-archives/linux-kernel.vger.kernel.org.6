Return-Path: <linux-kernel+bounces-289631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5934954888
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B88E1F225FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82701B29C3;
	Fri, 16 Aug 2024 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf/w/qnW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6619FA91
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810359; cv=none; b=LihWL5Kndc16nR1t7YgkRtuFQkdAZaUuSa9T6RX6wwxJ5nh9Up2DBR+ebaqX4faogxGnWRv77UF9wq6ZdMYYwo3jwa3aBBWzS4B3fEsaVi/vKTRLfpCEPeGKg6tfraIOVPkdWSN9HglDpUasYJe2eOGjcEdZVamx1py5ZxuLM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810359; c=relaxed/simple;
	bh=sWOJ4stn7o4A4wXz+K9kRd1lUSfib0T9EWFu0acGtxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFkdEXL9Y2XYzpa39JwStkJxBHIrpU6D48pBO+CdNIiQaz80E9v0RkXTd430p2AFZznFl1L2cd9p+IkYxMvF9J0199Mtg9OrrMNLr7bBu7DB7AVamAP3wXUDOCRZMAKyRAmw3+2djtV/yGiZpXF805ppklMemdKlaIWLlHLprSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf/w/qnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A66EC4AF0C;
	Fri, 16 Aug 2024 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723810358;
	bh=sWOJ4stn7o4A4wXz+K9kRd1lUSfib0T9EWFu0acGtxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wf/w/qnW0MycQNRdj5jbEMHY55vYU4Hbo4bxcOLIheKLOl5oxFmR6/xCEUzCbmZgp
	 HnE3V/coImRP5HxtgKApRLvRwRglNhQOB0kY5cQ2xR38tpsRfHjdgXHfNitc2TMW+B
	 wcNI8yZebzsHvzEtR2SobtnVwBrQapr8wHI1JQ5uI2KI72nnSAPkiUrr01F7v5dDKO
	 QQp/L4W71t3rRRJVK0CgoOTZSxd/hSybKaN5OjW3eKtiqrNucNniW+BU0tm38MgEYr
	 NHxV3vGQJ/2HI9UEv90ec24ykYmDjG3c6RpE84iSKpBpiBjUYW9OSNmNlSUHlZ1/Ca
	 u+vV3YVrVp0mg==
Date: Fri, 16 Aug 2024 13:12:33 +0100
From: Will Deacon <will@kernel.org>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, gcherian@marvell.com,
	sgoutham@marvell.com, bbhushan2@marvell.com
Subject: Re: [PATCH v6 1/3] perf/marvell: Refactor to extract platform data -
 no functional change
Message-ID: <20240816121233.GB24137@willie-the-truck>
References: <20240704092022.1136805-1-gthiagarajan@marvell.com>
 <20240704092022.1136805-2-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704092022.1136805-2-gthiagarajan@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jul 04, 2024 at 02:50:20PM +0530, Gowthami Thiagarajan wrote:
> This commit introduces a refactor to the Marvell driver
> code, specifically targeting the extraction of platform data
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
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 282 ++++++++++++++++++++-------
>  1 file changed, 210 insertions(+), 72 deletions(-)

Please split this into a set of logically distinct changes. One large
"refactor" patch is unreviewable.

Will

