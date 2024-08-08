Return-Path: <linux-kernel+bounces-279368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97A94BC5D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D791F2253A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900A18C34A;
	Thu,  8 Aug 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oosftomQ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9A189F52
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117069; cv=none; b=kuz+9kBwpoFRX/b7wUlR1Ee0Pk4HTaeUL1Bccp8aYhYT5snBQMAMQo/6M5vwKb/ihElTxtEfyNgiJBMR8uMiGcZdx/K4MZPPTzdf2Q3zHPAaetKTMZniqOOKgqyBvKyK7SV6SNfhf/NQCxnyDuuzTC1ztcQCfuxNEd8jvqXImcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117069; c=relaxed/simple;
	bh=PcDtehXPOnRp+0v2GaOgoZgVtGYtvFdOku2SbV4p6wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so0Nhx7ZGtLrlygutKRkXPzSZzITclo2d/inKh5aqxV5MSTFYAE4CBVb0DakilI7c6fQKH/pECf0wIz7ez2ilndXQHwqgOVXB0hkoWxLwMi8iHYwdCa36SrEvmy1UAAQc4JRNjX9V0m/6RfP/ZTBRoqAdILdayldssSvi+1kV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oosftomQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42808071810so6400505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723117064; x=1723721864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYjuaeJy2Pvg9rMTABhna8aZrftptocvWC4VLyaxXc4=;
        b=oosftomQ2DkU4kqKjVnqaAdubBQRDj7rzEslCAT9Y54Nmej+KSWJ9k5vXYlUCbYOY1
         HHg4J9POWaDWhTcV58j5sUsNrOK3g/kOq1sQ8x9+ckJYYdptiKp/jsagKQvuM3T72tbC
         N2/pzrIRhagiOL3EwmGuj2Vo3Z2PdFi5bX6h9MXkFAj7Mq5Nzs+uHjibBpgjIe9xTxu1
         KjDSltwXoTq8oFYktwaPCDrZlF+WrsXK04ToTYYiJ+KFH7z/SvfdndgsRvzta1b7mk08
         qzAE1xaNOM/z1fc/H336fGY+Ud/FFWHKIoDJ2ez5Y/OJyZe2Q4yIs6UyPju7qRQuUceI
         c8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723117064; x=1723721864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYjuaeJy2Pvg9rMTABhna8aZrftptocvWC4VLyaxXc4=;
        b=YxNiUPLwv2noPjfs0UHjoki1tRCQbCZ2A878SUy5/cM41jAWe6LbF9opM/ZJ10hC23
         0UjRgU39xybO/UyadOcj+fqdD6I9+wZQ38cvTsIff8soRUQN/LFoQs1HMB9MvJKVQVAk
         3szosNBs6nYplTzkj0vwubCDRRkxpOTzS5MyhRZ0kIbVcBkc1krdlQGJQoXTXlN11VNM
         vOKNyF6Wkt0GOIebqd4t54xLW4Auz/JnW90hZTGxw6dzSZAiFIjjMFjZDAtaxdoafzMg
         smau7HWzis3V9RUKANtlQSOGTyzwXEApahcsBC4fwDlDSzVVVueZuI+yGg72Biy2X9WY
         G2iA==
X-Forwarded-Encrypted: i=1; AJvYcCUXvyciFLieDDlrzYbp+FO7dTgFt1sSyOQs+mLF+ouVIUBrBFArup1/0SHp3Aezsa5dHscCrtm9hCM/jOYPzZSPh8Fr+mxgtpxpCHSP
X-Gm-Message-State: AOJu0YylaUHEmyXbYiehj71fqwDoddxqsMPambK7v2Vkz1MhLj5y5iBw
	3sdqyGC+Lx5/UNGr/CIivIrnFpX5lJmIzi63MPQWMvSM9tW/0y3vombihkLhZkU=
X-Google-Smtp-Source: AGHT+IGBaalm8I6v0NRwaz9hlc6hExrICBmkwG4RPAmXg++Ta5D8Vis1zmZkzdJ+0LOm4jWmhw0pRg==
X-Received: by 2002:a05:600c:1d10:b0:426:62c5:4742 with SMTP id 5b1f17b1804b1-4290aee068cmr16351235e9.7.1723117063943;
        Thu, 08 Aug 2024 04:37:43 -0700 (PDT)
Received: from localhost ([213.235.133.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72d6d3sm18713035e9.6.2024.08.08.04.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:37:43 -0700 (PDT)
Date: Thu, 8 Aug 2024 13:37:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <ZrSuBlWkE-USicQw@nanopsycho.orion>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>

Thu, Aug 08, 2024 at 09:51:41AM CEST, kirill.shutemov@linux.intel.com wrote:
>Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>accesses during the hang.
>
>	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
>	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
>	...
>
>It was traced down to virtio-console. Kexec works fine if virtio-console
>is not in use.
>
>Looks like virtio-console continues to write to the MMIO even after
>underlying virtio-pci device is removed.
>
>The problem can be mitigated by removing all virtio devices on virtio
>bus shutdown.
>
>Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>

Could you provide a "Fixes:" tag pointing to the commit that introduced
the bug?



>---
> drivers/virtio/virtio.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>index a9b93e99c23a..6c2f908eb22c 100644
>--- a/drivers/virtio/virtio.c
>+++ b/drivers/virtio/virtio.c
>@@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
> 	of_node_put(dev->dev.of_node);
> }
> 
>+static void virtio_dev_shutdown(struct device *_d)
>+{
>+	struct virtio_device *dev = dev_to_virtio(_d);
>+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>+
>+	if (drv && drv->remove)
>+		drv->remove(dev);
>+}
>+
> static const struct bus_type virtio_bus = {
> 	.name  = "virtio",
> 	.match = virtio_dev_match,
>@@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
> 	.uevent = virtio_uevent,
> 	.probe = virtio_dev_probe,
> 	.remove = virtio_dev_remove,
>+	.shutdown = virtio_dev_shutdown,
> };
> 
> int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
>-- 
>2.43.0
>
>

