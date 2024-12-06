Return-Path: <linux-kernel+bounces-434350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39559E6555
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14FB1885E69
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526F313DDAE;
	Fri,  6 Dec 2024 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0KAta9D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471B47F4A;
	Fri,  6 Dec 2024 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458515; cv=none; b=LfsynL36wFCBe25P44k6N6T8cjAT75R7QQ8xUGyrKVN+zW2f9HXGIx2O3ENQjc2NUwRP+2z+QbjhM6di8BbbMGUwAbdM4mMPlGQm2YucTHuT2bn6gfaYlI1rujvfMJC76E/eY7c7CjVuj2m6BHVsIcOfojy9FR9xGRrvxHnfx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458515; c=relaxed/simple;
	bh=jyZygs4PtekuSAYjjYdnwJp1CvMvMHamuwdIrETXvjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtArHqaFLLHJrQj+tz2u4avfGrmV3IigHs5SDnzPp0ty0Dt8h/Tx6ZH6cWDLogF7JOXeuazUsrO/AHUEAaqxJMTKrbTkq4p+0Uj88K4Fm3yScyKF1LO7l9r19ORKre3XhyjosrVjjfo9vvjf3ya/cjcvBzN4MQua2HbY69pQwjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0KAta9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F92C4CED1;
	Fri,  6 Dec 2024 04:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733458515;
	bh=jyZygs4PtekuSAYjjYdnwJp1CvMvMHamuwdIrETXvjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0KAta9DmxO/95gtyc85ZtnoajDQ222at1FzRkXfT32Jf9Fbhf+RqEVcb9NjGPEM+
	 Bgg1AQqDP+jkjB5S8x1vLYAxOljEjpMTSrAn/JLbVK9g2D1qR9C7am1iEc1fXkYu7U
	 6fwUyX5/wSKLv13jzrzIfUG2Re7oOD/uUxiv8r3ssy8jGkf6Ywci2SSWx6obsePYcq
	 sjQopfwZ+TYhzlyfwx1fh8nijWNL5rdCle6eSUhc3yXaspApDz8uPQBFe4oAmXWGkj
	 Hq1ZDUgu+HD46gvI+Wp+JpuEQDDvscp4nIp8PJ7ebz4DqakOY04oojV6z25bHD5Gg2
	 e3GhbIbQuH8sA==
Date: Fri, 6 Dec 2024 09:45:10 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 RESEND 1/6] ALSA: compress: Add output rate and output
 format support
Message-ID: <Z1J6ThMuT6IW87gr@vaman>
References: <20241204053346.1865723-1-shengjiu.wang@nxp.com>
 <20241204053346.1865723-2-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204053346.1865723-2-shengjiu.wang@nxp.com>

On 04-12-24, 13:33, Shengjiu Wang wrote:
> Add 'pcm_format' for struct snd_codec, add 'pcm_formats' for
> struct snd_codec_desc, these are used for accelerator usage.
> 
> Current accelerator example is sample rate converter (SRC).
> Define struct snd_codec_desc_src for descript minmum and maxmum
> sample rates. And add 'src_d' in union snd_codec_options
> structure. These are mainly used for capbility query.
> 
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Jaroslav Kysela <perex@perex.cz>

Acked-by: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod

