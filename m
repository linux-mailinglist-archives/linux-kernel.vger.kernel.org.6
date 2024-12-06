Return-Path: <linux-kernel+bounces-435239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE99E74E5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145FA1885FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065EC205AA3;
	Fri,  6 Dec 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv4jpJ3F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7F62171
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500274; cv=none; b=Qi1F/WU/IXfSrzVbBB9ewTj90J0kUCJwmU/eot0EDmM+Ofw8TTDIOemvHXUsK0NSFis/afyRNsmZMbVGu/jjriGVm9ZwDWatWqjXijR0pYmpBd7Mdjs8+zTBLs03sxHZoJdqyNCEhyH8Wbbn+pulLOVMXOh7IjGR56SEsNFD3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500274; c=relaxed/simple;
	bh=4ST6XqOdFWhRjWNkItCEHp8dw/gXcIRdc65RQJvw+EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N6W6gAaA+16V1Bpy1CvWSapmD5K5xF46P8BFGHPAmN41cJI/b4hvt6V3sX7ig8qC5BFL++760RWQHZTdFI0ybT/2LJl7kk8aYnFP/70z1bj2FYo7z39uskr24KZicTIIdqsH90Bb94WSHnsZmfDRtkKsOur5QyUwJT7UMJH8Lsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv4jpJ3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B91C4CEDC;
	Fri,  6 Dec 2024 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733500274;
	bh=4ST6XqOdFWhRjWNkItCEHp8dw/gXcIRdc65RQJvw+EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fv4jpJ3FWfKKp8yuKSgt2/ocUjVOQTLPDJGkn2JFl78X2MjLUjS6gDXqztL2nWW63
	 9IH4vxRsvhsU+D5joJjBZcBk8xhKMnhrrKnne7sDCMZkJ/jqzo7zIQkojByTEQoV41
	 o7nvzKvujcEiJ9/bm1uFsbwb6xVM7VUd7ZOn32mFtmIC4RPuE6rF9G9J3q+FTikkhe
	 T0sXPY+v/NtWa6kmoj7GCkpSrKnSsRoBzEpb9EgHu9cSVQDJjaL0GRIJPdHD5/XHRt
	 x8X6H/wrehrSbex1Y2xVa+2YQkXSQF5PynEt1qmMeD1fzp6HEHifpS5jgQaWLR9Xjw
	 tn1/LYWD3zb6Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alvinzhou.tw@gmail.com,  mwalle@kernel.org,  pratyush@kernel.org,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  chengminglin@mxic.com.tw,  leoyu@mxic.com.tw
Subject: Re: [PATCH] mtd: spi-nor: macronix: use nor->addr_nbytes
In-Reply-To: <20241111113609.12093-1-tudor.ambarus@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 13:36:09 +0200")
References: <20241111113609.12093-1-tudor.ambarus@linaro.org>
Date: Fri, 06 Dec 2024 15:51:11 +0000
Message-ID: <mafs07c8c4xow.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024, Tudor Ambarus wrote:

> Use the nor->addr_nbytes set by the core, we shouldn't use
> magic numbers or states that are not tracked by the core.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> Alvin claimed he tested this patch at:
> https://lore.kernel.org/linux-mtd/CAPhrvRQrugRQgQcdHBdwid3_sUkCm0mZL9zhz1=TYzXg4qUTfw@mail.gmail.com/
> Though a Tested-by tag would be nice. Thanks!

Well, we didn't get a Tested-by, but that is fine since we know it has
been tested by Alvin. Applied to spi-nor/next. Thanks!

BTW, b4 complains about DKIM signature when picking up your patch:

    BADSIG: DKIM/linaro.org

Maybe take a look at your settings or ask Linaro IT about it.

-- 
Regards,
Pratyush Yadav

