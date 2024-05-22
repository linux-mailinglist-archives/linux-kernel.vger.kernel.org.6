Return-Path: <linux-kernel+bounces-186464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF29C8CC486
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991E9283350
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694C213DBA0;
	Wed, 22 May 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IelD6NNy"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C516EB5D;
	Wed, 22 May 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393218; cv=none; b=hr0+wGpcN9Lbt9mjnEFwQoEtEVHQBluUnkATtwsvY/EYNW8u9yGzhmJmFYozlHu9zLMBcReit5iaFb1OsD1+1sBWT0xK63T7jfbgolOPq/TJ6xtjpqg6deea094t5ZcmXjfSe78ThxTOdVno4UZ+1xx9h9I+PuWL8ioFlrcjC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393218; c=relaxed/simple;
	bh=A/ZS2NtINBxthxwqs5PcU2EkST+CNjfZ5b8/iFOfEhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3Noggr9Awp4EVuJe0+0aFRen4X6+Sxg+gl0tNkRb2xkuyiUkYENjNMyyZSp2Nu3DA1CiLtKt+u5sqolKi6JhdMmR7niP/Sm7kAVdNtMaZuimiqiUBolSiUD1zqBKleSh8/wsHQsGtJ9437lJ62VUfOeH2PqzsYLldTh1xOMrgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IelD6NNy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BBF1BC67;
	Wed, 22 May 2024 17:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716393202;
	bh=A/ZS2NtINBxthxwqs5PcU2EkST+CNjfZ5b8/iFOfEhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IelD6NNycUfvoHK84yZHpxTn7nh6WN1bSc/gKsWdz6CnuXUTf38HWwaPvr6+f46Ev
	 fjdBnlhyT0LQC+YAMTDIFZiq82rAMQu7V+IdNFjhjB2SHACSsutM/PVjn7kdz7liPg
	 7gHxp3CUdzihFfVj4PCTsnbiMKo42t2Ig5Ag5XDQ=
Date: Wed, 22 May 2024 18:53:26 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Subject: Re: [PATCH] drm: zynqmp_dpsub: Fix an error handling path in
 zynqmp_dpsub_probe()
Message-ID: <20240522155326.GC9789@pendragon.ideasonboard.com>
References: <974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

Thank you for the patch.

On Mon, May 20, 2024 at 11:40:37AM +0200, Christophe JAILLET wrote:
> If zynqmp_dpsub_drm_init() fails, we must undo the previous
> drm_bridge_add() call.
> 
> Fixes: be3f3042391d ("drm: zynqmp_dpsub: Always register bridge")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Compile tested only
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> index face8d6b2a6f..f5781939de9c 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> @@ -269,6 +269,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_disp:
> +	drm_bridge_remove(dpsub->bridge);
>  	zynqmp_disp_remove(dpsub);
>  err_dp:
>  	zynqmp_dp_remove(dpsub);

-- 
Regards,

Laurent Pinchart

