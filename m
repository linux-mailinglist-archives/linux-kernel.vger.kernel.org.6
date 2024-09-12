Return-Path: <linux-kernel+bounces-326202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46469764D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B031F2488D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1A1917C0;
	Thu, 12 Sep 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNDP3jdN"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F06383A5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130957; cv=none; b=M3P0Xsbw+PZScl58WtdK8jsXjBAP5yOzAMM7FJ4kp3xx+a/B8guaMxG1aWbPQVXTxKPMCfbxQ0H0yHR8ME3jLmT58aLygvhIkTAlNlmyj+KNBV1+r84Gi3YN4rY4qNYfo7ulXBrJlqkOx0DPKVUA1YmZ1r7y0gsno/elA9dZp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130957; c=relaxed/simple;
	bh=1J3zCxy9ale5iPnZvhLv3BIL0HELGZX5YdbP0RlIDCk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kkWT68DpxOU2zRVpMKLfLfmvi5Q1dk+agIOixPPNnnz1hvM+OqjqmuUd7DLTNpayx/PdzfJRbAwNOBsLYLpBZrl2GpKO+OEVUeID+t1tmM32iIaBFE+Jz2ew87KQMi8GKnhdU8ahc3BIPPS96hMwK6qeId/lwQ0AcLDcuxn/2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dNDP3jdN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so6053325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726130954; x=1726735754; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABTI+i6mJ4CMOQCHX/yBx2eOYtdjf5jrjUW+ELTOTP8=;
        b=dNDP3jdNFKmXbNvqtlTW6TcfbMehHOKtLQjcOHbLKr/FHFBcyn7d7vrO8jRskQ9xHg
         w4axfx7Wgq+K7Y3XJf4Nx5iUz1SUWU2jUGfJ2N+Way2tZ1VeF7aS+QEnk39yOgeM9pW6
         ohSjfFEWMRao4b3y3fsRegcW62Qjatj5o4lawFWwqGeTu8k7esoOcwhRcHMLT/yMUOvM
         oV7S8T1SxFYwzuVvjwEjlRIKBGhyK3gcQ8OspZraVFZTA3r5xwFuY3x3wffcFDNPSwwv
         YgZhyabBIGqR9Kks3XwPnmUJjN9/jyNOp4YjxtkcWSrpibTVjveNYbJu2TdO1s5xya4v
         w3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726130955; x=1726735755;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABTI+i6mJ4CMOQCHX/yBx2eOYtdjf5jrjUW+ELTOTP8=;
        b=jmPNHEZJ/IauuKj341c1AxSaJsGub1wWAE6xE9wqKs3KwBBKC5MxJxsboO3s3PXoH1
         8Lo63uEwEDiCWqSVVVlRn/w7tcSC3vFadZgF7ysFiWKfhKHtrVIDi1gll8L2Fhxl+b2/
         ws/JrQTnTT0HdNotAVcrFQjhidajtZGqEXACvjxKKWe4ZtA0rem0S1HS0VmQDT4Cz740
         3pKWkYRbgqQ6rajfTaBuCWu+s3Jz7lREaNOq5yGAg/bOHj0ZAYO0WQKqRbSBMVhnbZ5t
         Vb7ZqnLwRNg69stc/v0xOThm94ASvtb74TCdiujJKWq/jWiGakFHPenoRGjkT5ZWAxnY
         XrKw==
X-Forwarded-Encrypted: i=1; AJvYcCUR1toBhvp8tizvnd3eYfnECbNMV+z2TSurMVIJhomdbSsRvKPviEDUWF+hdtXuNX4M9VmCIBIxMVWI8Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+pL3Zn12AaHSgRFv2v2n242NdSf0VGEUXGhAynJaLFJFIr9R
	uhvf1/MlP7NG+RRK5TrkweAXsTSc9+L5I3tBnFfx6+hf+rKo7KeilA+HLgScylA=
X-Google-Smtp-Source: AGHT+IFtFhvViZFvTwkPEdAJJREABhf7QxIe71ol7T4wz3pTBiMjTRfKnT+ODmIORLshY159TZO6IQ==
X-Received: by 2002:a05:600c:5127:b0:42c:c080:7954 with SMTP id 5b1f17b1804b1-42cdb575510mr17534465e9.30.1726130954537;
        Thu, 12 Sep 2024 01:49:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8120asm164411255e9.37.2024.09.12.01.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:49:14 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:49:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>, Christian Brauner <brauner@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>, Ankit Agrawal <ankita@nvidia.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] vfio/pci: clean up a type in
 vfio_pci_ioctl_pci_hot_reset_groups()
Message-ID: <262ada03-d848-4369-9c37-81edeeed2da2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "array_count" value comes from the copy_from_user() in
vfio_pci_ioctl_pci_hot_reset().  If the user passes a value larger than
INT_MAX then we'll pass a negative value to kcalloc() which triggers an
allocation failure and a stack trace.

It's better to make the type unsigned so that if (array_count > count)
returns -EINVAL instead.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/vfio/pci/vfio_pci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 077d4a2629c8..1ab58da9f38a 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1324,7 +1324,7 @@ static int vfio_pci_ioctl_get_pci_hot_reset_info(
 
 static int
 vfio_pci_ioctl_pci_hot_reset_groups(struct vfio_pci_core_device *vdev,
-				    int array_count, bool slot,
+				    u32 array_count, bool slot,
 				    struct vfio_pci_hot_reset __user *arg)
 {
 	int32_t *group_fds;
-- 
2.45.2


