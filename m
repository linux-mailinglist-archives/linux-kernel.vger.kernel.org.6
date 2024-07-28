Return-Path: <linux-kernel+bounces-264467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A132B93E3A9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 07:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736411C21187
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 05:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2FF8494;
	Sun, 28 Jul 2024 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfQ6sGvx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5F63C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722146205; cv=none; b=URsiJILIsOTtdWPZ26Bntz/RpPJFxRM+qyLw9ppx4mQ59sA7J10E00UrjNXK7cYKRG8g35XGveDkyVo0nwugI1mG74ZJ5fQVfLcRiidVvpXQsscdIolO5el80/6VmXy1mog+Maaz7oOr+cmWWH1Dal+Vr7njfnZXyr8+MIeYax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722146205; c=relaxed/simple;
	bh=uCld50XnvjSrbJ0iGS9cXttlRxMGmtcm7bYnGGX8ENc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY9HmGMvmBwchRRMSd14C4RTyeoiMhOm+HKz1cf4B5647H50gSzlOzg+3xTx9xG5RdtnRNG5sgeClRavT2p6K7ctxRYYigKOkFAi4LB+ssPeXAABJKMLZPRZSq4WHW9vVN8AfD6zGpBh6Y9cvovZPXPxFZqSp3URMHhOC12mJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfQ6sGvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD56C116B1;
	Sun, 28 Jul 2024 05:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722146204;
	bh=uCld50XnvjSrbJ0iGS9cXttlRxMGmtcm7bYnGGX8ENc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfQ6sGvx9mhIzhUbuVafIX7LMTKd6gsPdyh6eZaZSGR2NYx64F/yR/LF0Z07sVXr4
	 nOHSZMuzDaZxLQ0pxrd+vHYkRMCNU0jLtmdG8vh2YLBm2zcluwNKPqtGqH5HDfNF33
	 UC++eDrnyqxW78IG1KTOJ2OtF8xBn1AOIzi0uSYRDBzhFrjrpZNu/PI6jp+xY7wcKu
	 4lKguWH98WQ5+Ua9AONr1wylfI/iqjahC9K7iAaVztM16SE/G64HO5UKql2NPxvt8O
	 5Jc2v9XYLKmqHFMDYSd9ceYU/VfCT+qESpeSM5XEVQ+SC2jfWCx9RdykuCQoJKoTVt
	 el/R7c/Wu+4aQ==
Date: Sun, 28 Jul 2024 08:56:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] memblock test: fix implicit declaration of function
 'virt_to_phys'
Message-ID: <ZqXdigYmtS27MxV4@kernel.org>
References: <20240725014157.17707-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725014157.17707-1-richard.weiyang@gmail.com>

On Thu, Jul 25, 2024 at 01:41:53AM +0000, Wei Yang wrote:
> Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
> alloc") introduce the usage of virt_to_phys(), which is not defined in
> memblock tests.
> 
> Define it in kernel.h to fix the build error.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  tools/testing/memblock/linux/kernel.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/memblock/linux/kernel.h b/tools/testing/memblock/linux/kernel.h
> index d2f148bd8902..ca56f36ef296 100644
> --- a/tools/testing/memblock/linux/kernel.h
> +++ b/tools/testing/memblock/linux/kernel.h
> @@ -9,4 +9,6 @@
>  #include <linux/linkage.h>
>  #include <linux/kconfig.h>
>  
> +#define virt_to_phys(p) ((unsigned long)p)
> +

There's already phys_to_virt() in tools/include/linux/mm.h.
It'd be better to put this one next to it.

>  #endif
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

