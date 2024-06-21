Return-Path: <linux-kernel+bounces-224236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846D911F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131B71F27BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3116D9C4;
	Fri, 21 Jun 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qGm3uYFK"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3A85283
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959707; cv=none; b=MHqEiU2wtKQmq4XOORSO6X0IWoP/BdMtiqjCk1pt6b376nHHIUhQAeCKVrLF+tgr2qJC37VOg1gYXisCSwwMAcCId2WLPyOmaTTJVyhQj+x+GFQCLRDoftgFtCb8EZoi+ymdR6ZxzDe5p1/kx/YdcCHUXIbvNGxj/2w3R+opBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959707; c=relaxed/simple;
	bh=cmNro0s81V3ggh/XTjBQaqQoYmXEBF36FlD7ZvBjvqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAWQbYMytuzON7JKuVXvihhKI0va+j4qEyFqPUu77l+bwU59mUFNNfgl5E1FfM7f6kjQ7tf1ZPwIMGIzAWbMgkjPYsO+Dlc0Xm8QIv8u8pklap9whBTlg20cTPTMqTQNcJ+Zkr/oX1aJyq7Bq4gCRExG+ptfDJgLsPrJ7dqwoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qGm3uYFK; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718959697; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3vsqKJpmmEF1YlrnBNdvTctEj6bpEdbnO2+TdQxtZ1w=;
	b=qGm3uYFKG9nlkiFJ6tpLIypL+Moz0n7fV3TT8uNjLHXGt++y8m90jBJiHMF2NweGMY6Xd5U5Hg9KtF96FNqrzQ1zui4avl4wsdQdSaY89967NdGv81bF4ckHQmdO23z8xUmMwvLYi7qizqdUaV53xK1qHQCp4GUJeruH5u/XgdU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W8vhyN2_1718959694;
Received: from 30.221.148.166(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8vhyN2_1718959694)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 16:48:15 +0800
Message-ID: <78a99414-314d-452e-938b-07e86182a8bf@linux.alibaba.com>
Date: Fri, 21 Jun 2024 16:48:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/qxl: Add check for drm_cvt_mode
To: Chen Ni <nichen@iscas.ac.cn>
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 airlied@redhat.com, kraxel@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 noralf@tronnes.org
References: <20240621071031.1987974-1-nichen@iscas.ac.cn>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240621071031.1987974-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/6/21 下午3:10, Chen Ni 写道:
> Add check for the return value of drm_cvt_mode() and return the error if
> it fails in order to avoid NULL pointer dereference.
>
> Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index c6d35c33d5d6..86a5dea710c0 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -236,6 +236,9 @@ static int qxl_add_mode(struct drm_connector *connector,
>   		return 0;
>   
>   	mode = drm_cvt_mode(dev, width, height, 60, false, false, false);
> +	if (!mode)
> +		return 0;
> +
>   	if (preferred)
>   		mode->type |= DRM_MODE_TYPE_PREFERRED;
>   	mode->hdisplay = width;

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks.

