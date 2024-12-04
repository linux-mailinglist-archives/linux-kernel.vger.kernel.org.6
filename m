Return-Path: <linux-kernel+bounces-431962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C99E4529
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C449B36C17
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25D01A8F60;
	Wed,  4 Dec 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czlmAW6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB7F23918A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336452; cv=none; b=YOVejp36jnCpjWnYkswmdNdEJzZ/8JeuB78VmnrRgu4v3M1RNViLZxxn7T5cdrLnEFZpeWvnmsclmZzZf5cAhUr0VHvvLPt0GWH85VHneKW09gjsQJYt1D+BMI2ACBSA3/Q4Kf+3E+olv2AXpo9vsIX7m3I+5s8csHqYc5q4098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336452; c=relaxed/simple;
	bh=vTfYTgZ2HhDd4sDtskxxkSPUDGOGE1J5hwe4gG5aidY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFYBxZLBBSo22H2FkB/oynDXoUuND4Za7mQR6EmEQQYPDNE12zyE89Xkt4uGVf7UM8Si3txEySYfkBi/fn9jG+r8dYu8kZq463nOwi+r4roi6lS6yGQMl+Q8RJ1cY24liRabRAQ9WioCCnbsH3LwXkzXT5qEiSljvfyyh8vEO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czlmAW6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A8BC4CECD;
	Wed,  4 Dec 2024 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733336452;
	bh=vTfYTgZ2HhDd4sDtskxxkSPUDGOGE1J5hwe4gG5aidY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czlmAW6m49YwIa0dmF44ABJYMThfiWonKWE4fH4ajYEVKHWTqq5afkrnCeCf5t1zT
	 WpErwprZJhloUtz0eTzBPL9l20imOZUAQ6ls/+xrBbODwRrFD6FMvb2N2uuKBn+m+b
	 GTvxffUFtylKZXDUVaUcRPKuGcszM+56t8/Emr387fWGWlio6GE2oK8tmwEwxHCdVS
	 MRSA3/B5pAvj5+59TZj83MLkWSXT4t1o/+WmcRmDY11cq6Ii/IhcJ37iWEajzkCFmr
	 mZ+L2FpuaQ7ZKFP2w6dHuHR7QKvHqPMJJsiL2rr5olTRvGKWaGPARE4QF3WhgLEob0
	 SUrHcj+euDzgA==
Date: Wed, 4 Dec 2024 10:20:49 -0800
From: Keith Busch <kbusch@kernel.org>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hare@suse.de, lengchao@huawei.com
Subject: Re: [PATCH v3 0/4] nvme: various bugs fix & code cleanup
Message-ID: <Z1CdgbZr9a8WbW1b@kbusch-mbp>
References: <cover.1733196360.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733196360.git.chunguang.xu@shopee.com>

On Tue, Dec 03, 2024 at 11:34:39AM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Here try to fix the hang issue of nvme-rdma, memory leak issue of
> nvme-tcp, and cleanup the relative code of nvme-tcp.

Thanks, applied to nvme-6.13.

