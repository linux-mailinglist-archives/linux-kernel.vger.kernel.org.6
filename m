Return-Path: <linux-kernel+bounces-411056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBFE9CF252
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083351F2135A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B8A1CEE9F;
	Fri, 15 Nov 2024 17:04:17 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF9824BD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690257; cv=none; b=c3Hxi9TDudoL19PeTMBg7m65uAMCqrmI5iBEfcWs8NAG6hcaTnQo5pOHHICVZ67gLXJiGriTyr9MrFxj2ViaktbR66k+toD8TrKF98YX6PkUSvxdO8Q3xAOozgu8w8XNL9HBfsJO3mvj85F0nWeH+nk4mFO44YMy55KDbvzPkls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690257; c=relaxed/simple;
	bh=18TjxhQb+YKXZD251KG3svx1YFfN87EPwE3g63hQQsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gpz2Y46mIVWuLKWOQwsKa8OXXYrCpLyyd74QJM1UxyYF/9EjEgWyP7vlVu96pTg5IJglckZ0a65ZR4YW9QSsCFiXjxDXQSBc2/32HXv1X/86B4TpCbRQmVG1JQ1itq8pkgFRNEG2f4ikIPJBOxpkgcTqUzneKGiY5W/dReVpPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 374C868D0A; Fri, 15 Nov 2024 18:04:11 +0100 (CET)
Date: Fri, 15 Nov 2024 18:04:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-core: auto add the new ns while UUID changed
Message-ID: <20241115170411.GA23437@lst.de>
References: <20241115083727.30005-1-brookxu.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115083727.30005-1-brookxu.cn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 15, 2024 at 04:37:27PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now spdk will change UUID of ns while restarted if we have not
> specified one. At this time, while host try to reconnected to target,
> as UUID have changed, we will remove the old ns, but not add the ns
> with the new UUID.

And that is broken behavior.  The host must assume the namespace has
been deleted and recreated when the eui/nguid/uuid change, and we need
to catch this.  Fix your broken target code instead.


