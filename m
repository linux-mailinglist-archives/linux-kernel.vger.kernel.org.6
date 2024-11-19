Return-Path: <linux-kernel+bounces-413766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1619D1E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6801F228AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7613B58F;
	Tue, 19 Nov 2024 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kbJbvNEc"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B27C27735
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983920; cv=none; b=CSYsP4cyXv75o4PmKg3Q1KAIg9/7hFpYA//D+b8ZIdJSkQXvI7PxifdSCBjJ7UuFGKpdtUhDXNQx63mwdRoOUxnaz5wrIekUQNc61JxOx+Sb0e1smkU4hhaBR3AS2msvDgq1HMjICxeFptwGmm5BPovgeqjupe+MACMzM3mpEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983920; c=relaxed/simple;
	bh=h88T5LRHfoxZhHhEif4Sh07cXOaKAeS9POEAI5tcdEk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=JzfRHrHpru+szhVtous3i2Ksa5Gg5Wp46AQbezVYFL+vdGgRxhHi2PcRm4Wxz6Ucw24IvEV+4xqW79WTYGt7Kn3eTyFfv5LieTKjMyuGovl2R+HcnK0bFhud4jCfc5ZAkCx9agZ3HI2FXvKhBA506U/k0CiBHBZMU4m3DmilI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kbJbvNEc; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731983909; h=Message-ID:Subject:Date:From:To;
	bh=BnlWL8nhE0ODFU1d/mjsNaaQOY7POexgc8mjipuLhaY=;
	b=kbJbvNEc1nu4xKPUTom1r/bW3h+KqV5n9FXOj5zOgdCIQk1Zovi9nii+egLLkdZkahQfYfLCl35eRyhH0SWgmyDDWkdGH/wEws8AcooCCsgdK2XCC/Q9vpcWRHs/Ti5dlgr1MTlPpSE0Cr/qYfrzLg1LZcxuWqjlWYVyTkM8BVs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WJmXkAK_1731983907 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Nov 2024 10:38:28 +0800
Message-ID: <1731983829.623387-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio: remove the duplicate might_sleep()
Date: Tue, 19 Nov 2024 10:37:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "xiaowuding_jaguarmicro" <xiaowu.ding@jaguarmicro.com>
Cc: eperezma@redhat.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 angus.chen@jaguarmicro.com,
 Xiaowu Ding <xiaowu.ding@jaguarmicro.com>,
 mst@redhat.com,
 jasowang@redhat.com
References: <20241118124056.1038-1-xiaowu.ding@jaguarmicro.com>
In-Reply-To: <20241118124056.1038-1-xiaowu.ding@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 18 Nov 2024 20:40:56 +0800, "xiaowuding_jaguarmicro" <xiaowu.ding@jaguarmicro.com> wrote:
> From: Xiaowu Ding <xiaowu.ding@jaguarmicro.com>
>
> The virtio_add_status function have done might_sleep(),so we can remove
> the duplicate calls.


Is there any problem here? If not, I think we can keep it.

Thanks.

>
> Signed-off-by: Xiaowu Ding <xiaowu.ding@jaguarmicro.com>
> ---
>  drivers/virtio/virtio.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b9095751e..8352dfc1a 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -205,8 +205,6 @@ static int virtio_features_ok(struct virtio_device *dev)
>  {
>  	unsigned int status;
>
> -	might_sleep();
> -
>  	if (virtio_check_mem_acc_cb(dev)) {
>  		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>  			dev_warn(&dev->dev,
> --
> 2.27.0
>

