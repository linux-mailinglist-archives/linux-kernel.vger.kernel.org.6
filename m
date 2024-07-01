Return-Path: <linux-kernel+bounces-236068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E791DD0D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C381F21B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9C12FF6E;
	Mon,  1 Jul 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/TvZdcf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7E12C486;
	Mon,  1 Jul 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831036; cv=none; b=BZkhQRjmPgyvTdTeQ60yJkGJkaamS4hqD7LfnE/MB+JOeWQtqLy82KDoWKPS7VnYNafBLIifN5q8xXoHLpJyJ7/h/ges8mvs66tkPtnR/7qxPGPFn0T3IyZ8IUSB9jSWPKpbYaFYb8wSlN3gzEnliozkTw3Iyo7nNxp78OtVHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831036; c=relaxed/simple;
	bh=Mv/m2PNYtX88a8LcLcOJ5mSEFlvteVTV4Zc2YExmuCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoXLK1NNc+Z807M8WoZmLnu6M+pdGCcDK5LGk3Qh60qH7WmyU2L6Rpa7GgI1dgRM2C4jYVbhOiviRUW9ZNP2t1eQFIFE3WFwAE3KABU1a0wjsngb7IdTaCaFwC8exhmJ491OAyFuy4sEYpAw5kVwABHzHkSyLokqgRuziujtQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/TvZdcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B454C116B1;
	Mon,  1 Jul 2024 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719831036;
	bh=Mv/m2PNYtX88a8LcLcOJ5mSEFlvteVTV4Zc2YExmuCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/TvZdcfsgXUD5THmmHkhrKZEofqCUnlxliHJ/efwJ4NR1bbCx8ZyjNO5uAS3itpz
	 uTHB8Nq4177rChiV8mFDZoRMuzuNpxW5GLiPMlVEPANeCcIfCHrb3557jwQEmJqV1I
	 HGzXyKbK+YVYGh3jLBUol9xUe+FoTbdTEVssOdb3sT9OMBdg1ehiw7Is/GLi6cQzS0
	 1JvxYnuqVx7+Rzg6aeMzY7Z97sMulOSPrdKNO7B1uTPnQGp2w6Pw2g9fPHdGJ76LiR
	 qcqg3HXn5x6RVVhNlC8jTkPHX/xqDzgjil1BLF+b2aJmyUIEsYkwtmISDocB+hVBPH
	 kgHk3oukTHd4w==
Date: Mon, 1 Jul 2024 11:50:32 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v7 04/10] octeontx2-pf: Add basic net_device_ops
Message-ID: <20240701105032.GS17134@kernel.org>
References: <20240628133517.8591-1-gakula@marvell.com>
 <20240628133517.8591-5-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628133517.8591-5-gakula@marvell.com>

On Fri, Jun 28, 2024 at 07:05:11PM +0530, Geetha sowjanya wrote:
> Implements basic set of net_device_ops.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


