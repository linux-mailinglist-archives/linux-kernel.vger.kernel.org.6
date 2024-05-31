Return-Path: <linux-kernel+bounces-197471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEF88D6B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502471C245E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8681E208D4;
	Fri, 31 May 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaOJ2wXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7578276
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188835; cv=none; b=LQxSVK7mQ8Yv8JPdu1xX9mFghKpxRfSn1UYsyCB78H7Lukzje7QHeEJkajJxjU8P9dE/7AWzrhNgf43QnB23QpW4mxeHfgUgyhjdOT1tbY+9dCdSRye8K2ASx5YpqgXnTgZlPOpFwfe0te9pS7WH4PrUW6W2KM/AU43ax1+/jfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188835; c=relaxed/simple;
	bh=pgDYnODcp2BTX/BCu+v6+Qj8N74jOLekqacMvQEwug8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7iv1YfITSnfR1onc1LfoLXtkWBrhug/ZLmuxMZHPF7HQbrB7uVhH2I/nAVbJHHrH8bZdZYf15bYqFoI200WIqlIq1jRL6BXSYX3jw9K09mfJhwF6FSjvTZ0nFW0y/Xvs21ag80ZpzRagkN//xoWw0fla7hz4/7Xc6G5GCIFqmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaOJ2wXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFA4C116B1;
	Fri, 31 May 2024 20:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717188835;
	bh=pgDYnODcp2BTX/BCu+v6+Qj8N74jOLekqacMvQEwug8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaOJ2wXAJI5oyhlMmOS1qpjcTQt4YPKlTTg9M50fjcAQE4skZPup6aSVS8e+pw4a4
	 zwGjXJ6IW+p0HAzP50/bIe+tgDHtW1TLeGoEl1mv40L0Tdmjbh1rP/vEkjrX+7v3dW
	 PLzPmXU/CKE/MNSUXie59xTvsgO5VgldFNzk12EHqJeM9Ovp/L/4vkrB5hisaQcMYs
	 Y4l9NbGonOuZ7BH5DqNm+IhpjdfkUdfBCetxuCoGBEJIIJXY2R1Y7Ekn6vxLdLeOSC
	 wPsQLxbInDr717xHnkyM42HDxumtc4nOqHvvrLYPWhfdp8GgtPcl9MlVWli6TWvS7y
	 DdO2dWR7Etqvw==
Date: Fri, 31 May 2024 14:53:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] nvme-fabrics: use reserved tag for reg read/write
 command
Message-ID: <Zlo44PRN94sfQAoI@kbusch-mbp.dhcp.thefacebook.com>
References: <20240531092421.317296-1-brookxu.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531092421.317296-1-brookxu.cn@gmail.com>

On Fri, May 31, 2024 at 05:24:21PM +0800, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
> 
> In some scenarios, if too many commands are issued by nvme command in
> the same time by user tasks, this may exhaust all tags of admin_q. If
> a reset (nvme reset or IO timeout) occurs before these commands finish,
> reconnect routine may fail to update nvme regs due to insufficient tags,
> which will cause kernel hang forever. In order to workaround this issue,
> maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
> tags. This maybe safe for nvmf:
> 
> 1. For the disable ctrl path,  we will not issue connect command
> 2. For the enable ctrl / fw activate path, since connect and reg_xx()
>    are called serially.
> 
> So the reserved tags may still be enough while reg_xx() use reserved tags.
> 
> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks, applied to nvme-6.10.

