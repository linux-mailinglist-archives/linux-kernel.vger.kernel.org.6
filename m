Return-Path: <linux-kernel+bounces-346715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B957F98C7CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85FAB211EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9C1CEAA0;
	Tue,  1 Oct 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RdMAxqen"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D8199FCE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819860; cv=none; b=Z83UF7A7XJK1ePSyxbL1oSbDnRTJnPqDSF8w5WlgfQ6RQjgLzuDjtBQATWb+1HTpAZxehWNkHxgkiWYed40taURWW3Dl/WBT1JAOvU8BxU8DdcuVrTGyqKJotY79LMR9Fc141ckdKVc0lvr/ZgfdA5FmB7sL/4Vlb/Rcc1PrP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819860; c=relaxed/simple;
	bh=YGIKrOuInaRqDGrK/inGJjR8gzvQJvu8DyHlLCHBLJg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WiiNH/xD7zaxvBiDnv7uMqf63RpoWN5fbSVCy1Rn1cZMe4bob591wuPbsUFQ4fME/FuwyO8jpiTpVKrmJ3c18hi7O9Hvs6ylcAIjmEy5w0bdRDzj/rsSHPmhzqQfiC3ilaiYfjsY5ZMJ+s/1GH0BVRjfsqkZrnVxoC4gRkLGumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RdMAxqen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B137FC4CEC6;
	Tue,  1 Oct 2024 21:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727819859;
	bh=YGIKrOuInaRqDGrK/inGJjR8gzvQJvu8DyHlLCHBLJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RdMAxqen3AsW1jODqEMpINhnmizZgU+f3MIM3D3ox+foRpuRAgZv3SLRjbKYQY+ZK
	 6DcAWUc+HprpuOp143F5gNgizk1NaMHQqWJxMSPlUDRdrgmMgIPhhKYAOCu4lIJ0S/
	 6s9S6+VP2MEC3Ucm50nZfLza2NGDW1rhuO1Hs+Ac=
Date: Tue, 1 Oct 2024 14:57:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] zram: do not skip the first bucket
Message-Id: <20241001145739.8afe344d456d90fb6e8d96d6@linux-foundation.org>
In-Reply-To: <20241001085634.1948384-1-senozhatsky@chromium.org>
References: <20240925005315.89E59C4CEC4@smtp.kernel.org>
	<20241001085634.1948384-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 17:55:56 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> A small fixup.
> 
> ...
>
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -264,7 +264,7 @@ static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
>  	s32 idx = NUM_PP_BUCKETS - 1;
>  
>  	/* The higher the bucket id the more optimal slot post-processing is */
> -	while (idx > 0) {
> +	while (idx >= 0) {
>  		pps = list_first_entry_or_null(&ctl->pp_buckets[idx],
>  					       struct zram_pp_slot,
>  					       entry);

I hate to be a kernel bureaucrat, but there's a lot missing from this
changelog!

a) What are the user-visible runtime effects?

b) What is the Fixes:

c) Is a cc:stable needed?  If so, a) is super-relevant.

oh, it's a fix against the mm-unstable patch "zram: rework recompress
target selection strategy".  That's new information!  Please disregard
the above.

d) what was wrong with the original code?  And still a).

> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

e) what did Dan report ("Closes:")?


Sorry, but this is all stuff which you easily had available but which I
had to figure out.  And which I now present to other readers so they
needn't figure it out.  That would be inefficient!

Ho hum, anyway, thanks, applied as an effectively unchangelogged fix
against mm-unstable's "zram: rework recompress target selection
strategy".

