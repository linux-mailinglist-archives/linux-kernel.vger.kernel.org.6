Return-Path: <linux-kernel+bounces-399400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1509BFE75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EC71C210A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3D3194A44;
	Thu,  7 Nov 2024 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wKSDEfFX"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AAF1426C;
	Thu,  7 Nov 2024 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961047; cv=none; b=eGyvD4Ki+YuyE28jkp2kjkjtS2wWOSNUTcd2CRC0GfFyQudNUGIdqdj3od4NnFQ+k8i2YCdkb3z+2fymVEJuudeU6dQgM0Vv3GthK4G8rCkmqbLITLljCEiRiETcYyY97hZSdfHMnq24LOOzZwF+udNKutQN/sX3WVFDuOiHJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961047; c=relaxed/simple;
	bh=b9X/uaE7mdNzyDuyL39w7Td+pQgj7Kk0Bc8AT00Pto0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+jLeYwPXQIesDGLU8XwqxpkmRGKGIUWYJsvwYhBpLl0/b3hs4ARUVTyjfDBzR7wCBiT/f++LWpv3AMcvi+81tT8cTsITrwHLU5ZvYZTfqmkxox2BFX5z4N6PVRypmoAcusZs79TtsFNSeGHCFHsrvjukY+u7YgqevYtGiElW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wKSDEfFX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z4fFsBMuTr+/KR25exKOqxWxItnrYFoxknfnC8WF7ps=; b=wKSDEfFXwTzUDlFsihcQe8EYfO
	6xIyzYo+5puAUMNLTL62x+Ed7o5GIibqFSnJT9V6FEoaTOGXjTbS4qN7U7Dhm2dLW4Bq0fh4K6gEN
	bJ9PzN0bog//XGnLUk43BSC3BYRAnMbDPQRaxGIsoT/JRSBa3UoKh3vhjDlxCVJfUAAKRZ1oZxIHk
	KIvEiX6ko1oXhTqGsdWhUwRatJIfImftXBX9sOfLa9JigRa4bd4ICTYQ4kGZJNMmEMSD8bpJAgK8x
	SXxZEAIr9AG/0h/vK66hKeRhHnkFIx5WW++z5xjzu6BFsSV2bYyEqzLki4d0RX7+Mz8kQH05iwbHz
	s8vWcYOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8w2W-00000005qSl-2VDF;
	Thu, 07 Nov 2024 06:30:44 +0000
Date: Wed, 6 Nov 2024 22:30:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jangsub Yi <jangsub.yi@samsung.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, junwoo80.lee@samsung.com,
	sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: Re: [PATCH] mmc: Add config_host callback to set a mmc queue
Message-ID: <ZyxelKdmXXiSVL1g@infradead.org>
References: <CGME20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c@epcas1p2.samsung.com>
 <20241106051347.969-1-jangsub.yi@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106051347.969-1-jangsub.yi@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 06, 2024 at 02:13:47PM +0900, Jangsub Yi wrote:
> From: "jangsub.yi" <jangsub.yi@samsung.com>
> 
> Currently, there is no way to set up a host-dependent MMC queue.
> In UFS driver, it is possible to configure the request queue in
> ufshcd_slave_configure.
> 
> There are cases where we need to configure and check the current
> state of the request queue on the host operation. For example,
> mmc_queue->in_recovery, in_flight, mmc_queue->queue->queue_flag, etc.
> 
> Additionally, since the timeout setting may be longer depending
> on the device, block layer settings such as timeout are also required.
> 
> To add the configuration for the MMC queue, I will add the corresponding
> code and initially try to add it during initialization in block.c.
> The detailed implementation will be done on the host side.

This seems to lack an actual user and thus just creates dead code.


