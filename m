Return-Path: <linux-kernel+bounces-421015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFD99D85BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8470EB37E14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63EA199EB7;
	Mon, 25 Nov 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrPymnv9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324891714AC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539073; cv=none; b=qPO/qD1J9V2/wpbgWCU5TafZW9P0Kx2ShGfOnUYmbPnWKPty1VExsrSTNFh5fihPyKEFuyXxC4jXIZo19VTks94blYY5CpouKr6yy86G76w5fFwu7/OSp1VvvjEvkiQ/ywFTcTXjZxrrbgo1ajU9OX2esXrBcYvwv3NhtZJWO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539073; c=relaxed/simple;
	bh=lL1pzJTJrsl5S8uCJZ6H18Rb7qtHU1zVpOtDA+BLHPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAvsAy0dGyVI3fYDNHb0y8zGm0B4ixGLiJ0B588vWJI/kb6AHGSDQYsrAu2HqrnSem6zqYDoarNFvn3BflwUNlGPVcGBFfJ8oO7BBz4xpYcU1tB5aAT0O6INuYH1FtZArLatb4+DmuAA5FeXRShtQA49LjPPcgJd0BMd11XjsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrPymnv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D918DC4CECE;
	Mon, 25 Nov 2024 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732539072;
	bh=lL1pzJTJrsl5S8uCJZ6H18Rb7qtHU1zVpOtDA+BLHPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrPymnv94rBJrNghmVERbLc5IwcUUEZwv045XKUU1q7U4sK80axXF1mdnzw2U/Na2
	 mUHzWYiehMD9vG7b4Zn97ZEB01C9JxCKNJIW7INWYwNakq692DLlbrP42hG11tEFtS
	 5huF/Oj+dgWFaTgoBGWnvU5JjiYnLzSEFWrJSfx+AItiJBCvXRgbkUkxrL73gZwFjR
	 O7RUpzlOpUGh0ufQDbIQ/SQx5TEuckjedXVihBPOa26Obj/iF7xJTign4EBHFFThZZ
	 M/gqA5HR6ybRLrhAotswuNSRb4oiOxEXmEJNqRs42YBbBCv/UGAjh6IwnRqURqJA1d
	 Zzd+ntes+Bzyg==
Date: Mon, 25 Nov 2024 12:51:07 +0000
From: Will Deacon <will@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>, catalin.marinas@arm.com
Cc: linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tuan Phan <tuanphan@os.amperecomputing.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/arm-smmuv3: Fix lockdep assert in ->event_init()
Message-ID: <20241125125106.GA858@willie-the-truck>
References: <20241108050806.3730811-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108050806.3730811-1-ctshao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Nov 08, 2024 at 05:08:05AM +0000, Chun-Tse Shao wrote:
> Same as
> https://lore.kernel.org/all/20240514180050.182454-1-namhyung@kernel.org/,
> we should skip `for_each_sibling_event()` for group leader since it
> doesn't have the ctx yet.
> 
> Fixes: f3c0eba28704 ("perf: Add a few assertions")
> Reported-by: Greg Thelen <gthelen@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Tuan Phan <tuanphan@os.amperecomputing.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Catalin -- please can you pick this up for -rc1?

Will

