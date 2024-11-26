Return-Path: <linux-kernel+bounces-422324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD59D97DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C5B28309A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6D61D45FC;
	Tue, 26 Nov 2024 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAp9i8Js"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B292F32;
	Tue, 26 Nov 2024 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626086; cv=none; b=ODBQEqonQiOoV8jTr+6kqWPUBvLJOZcpbHQnia+bRL+KrTtEfbalSeny5hc9o9AP6riNO3/7NsXMEafHO4eV28H1vJ6e2sGv2p/+TsFRaZsnOfGseWun1YrZ7Vyw/GS67pONOItsDawH4PRO1g2D3Y/XFtGC+1TVWM1qrONsR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626086; c=relaxed/simple;
	bh=U0ictHmf0B3aVXdPyjnyZ6wdvCFwyRC7QMzdLnqIA08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn6Ofu6t8EGxnN0OLSUoLMt4G3uVX9B7PdT5uMZrKwvY9mslaTH4bxYoVREJNSqT788auQgKPiQh9eqnregNL2vSfUrVOfSWphFGt0mOUlFotD69uiBo/vtPgqUTw1QaxvhqGTxIb4icJHFpRRAbFdmu77pi3NOhaISPLCZrlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAp9i8Js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC8AC4CECF;
	Tue, 26 Nov 2024 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732626086;
	bh=U0ictHmf0B3aVXdPyjnyZ6wdvCFwyRC7QMzdLnqIA08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAp9i8Js3eh1AVrjU2uhmDKTeAuvCguhe6AdgjCc50WMlmae36iHmmOVh687PazRr
	 LgZ3/31Wcbq0/n8EGNT6/nNGFVM8eUU+ZHjhVrQ0R9M9O8g+bpmYh8urLVI8+PvlA9
	 b4HInvsNs9bzqZ72+TagW8WiZzr37MfCft/a8Efyu8YU7XHsIivNq26eJcJbBjA7xt
	 AiwHqH6oJ2pU17mrqvdPkCzEt3w2KKkRU8BVoLVsgoeFHonb8apivHArUwt/DVtAfx
	 OGFCQgC5isrHxKh85wNn0mIH0FAx5brly3w1BGu/jHkwLAc/fAd+S08arZp9W3mQeJ
	 JkWYacE7PFM4A==
Date: Tue, 26 Nov 2024 15:01:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Selvin Xavier <selvin.xavier@broadcom.com>,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: Re: drivers/infiniband/hw/bnxt_re/qplib_fp.c:1090
 bnxt_qplib_create_qp() error: we previously assumed 'res->dattr' could be
 null (see line 985)
Message-ID: <20241126130121.GO160612@unreal>
References: <da54caf2-26af-420e-bfd5-106881ce6b27@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da54caf2-26af-420e-bfd5-106881ce6b27@stanley.mountain>

On Sat, Nov 23, 2024 at 01:14:25PM +0300, Dan Carpenter wrote:
> [ I reported this last year and generally I try to report only report these
>   warnings one time, but it still feels like perhaps a bug.  Mostly likely with
>   these the NULL check can be removed.  But smatch still warns about it even
>   with cross function analysis.
>   https://lore.kernel.org/all/c2ff81f3-5de6-4498-b157-909d89e74fcb@stanley.mountain/
>   -dan ]

<...>

> 07f830ae4913d0 Selvin Xavier      2023-12-07  @985  	if (res->dattr)
>                                                             ^^^^^^^^^^
> The new code assumes this can be NULL

Yes, this if can be removed. res->dattr != NULL in all places.

Thanks

