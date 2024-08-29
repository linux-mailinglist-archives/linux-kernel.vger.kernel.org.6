Return-Path: <linux-kernel+bounces-307291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB8964B62
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F150284260
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAF91B4C55;
	Thu, 29 Aug 2024 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIiCHahz"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210041B3720
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948186; cv=none; b=lVMS9HzoZQZ01HFVaTLWmU6H+CZqycjMb46y4G/3fecv7dQ0evXBC09fn3OXQvnLsLzsbbUzDtev7w7GY7yDMYd596s9kDQoG3P0zQmOOex+36tcKpQHPPY62dp8tN29sCoYUqrhGgjyhpybUK6GIWcR1kkzFxjoX6t0hIUFrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948186; c=relaxed/simple;
	bh=MViJWjSfHsJqaLlei01V1CNwpxAGQHBmr8mJNmgGnwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWZxSEjQD8oqScvzkX0qfs85S58sexj8ymgZI5zFQRK8U/tva5SfQ0YK2znMZlXZJ6LMj1cvzPCcOzn8VYGBToH0mHmbwqe4YJ1oGPBNKO7kIPrlkOkx511WEY8t1XQjPGLBqsiFi0Wiaq0eVkdgkkUlF4XW54c/KehajCKIXkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIiCHahz; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db13410adfso542879b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724948183; x=1725552983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6zbcqyBIlUP/XnZ5rNs71IcJLBzOMtfuT2/Qd8j9UY=;
        b=hIiCHahz3ul9h4K9b9cdCBiODaliWsEiqq8muR1Wi/wNUyxMuoIqGYRm3mFJrldV41
         SK9tNfjLMK5q/+X58hLiug+TBbM8txWMEcyNXm0dWGWuaclLExnjDuEpvrIr1vCJOlA1
         9rjC1acUxhTSTb9kY+/NjlHGQA/8dR6WHzWZP4GEl39+H7XMlNJciFBRIg4+nBij5D6o
         /otDwtaPlbm1JS11DL6ySPWJTqEZA7KyzTTmk525pppLI0gPas9tPmY9KNnafGO03NNt
         w7O50IdttDsknJrtcAjNNqqjv4MFpcuxUIghNUQsm/lnT/Xv/J/jc477yp8/9gfpn4T5
         Mxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948183; x=1725552983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6zbcqyBIlUP/XnZ5rNs71IcJLBzOMtfuT2/Qd8j9UY=;
        b=cap9xkgg11n82UN4b1l3pPf2SAdiFRyymT2bz56Z81hyH7xzxpEhtpUwrLalou+B5e
         K6d1bpy9kiA7ArjKfko8yq3xV1Sx+HUx8NiohzE4r1Z9haxJF3wGgzBOrXHpc86Y711I
         +YkQfRL7DPyL18y/LWcqLQ0kv3/BZCuqrylzlJZ0B51QPlvDjNq8d2Canyi83qLLtoDR
         cQvtRVVuEQ1VGkgkpYn9NtXeCzKaZqa5ooco73zkYFqJp2QQnJsfq8D3Wjd8RDvbSAIv
         MUlRuXs1/+uROGIN39Tvszx2IxtcR6C773iChz0LW6VA6TlX/09RZl+6Kzs6PG6xvkcp
         9pHw==
X-Forwarded-Encrypted: i=1; AJvYcCW4TEczttKn0U8F825TGlJeygBrvAMS4C9vgMyHJArRYxD+WEODleKqvbDmILSgfOMEDjOnbPxWIONkMe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0ueN2xRPzSka/SDdFJGxsLT+3c7IxHo+3MB/sfX7mbc3YcEP
	DMRIvM4NUSqRux4HS9ynhNSf/MlfBJ5NnZk09zNm/V4YrBTRO8q+
X-Google-Smtp-Source: AGHT+IGT7RHkuPcE1EA+8NmGKrBLu805FthVMb9kuQ3jIGS8N3mNyXQD6Yd0H3MdVk5p7pYpDIW51w==
X-Received: by 2002:a05:6808:1a05:b0:3db:153d:5552 with SMTP id 5614622812f47-3df05dc09cdmr3292554b6e.30.1724948182948;
        Thu, 29 Aug 2024 09:16:22 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df08943854sm372296b6e.45.2024.08.29.09.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:16:22 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com
Cc: bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	cratiu@nvidia.com,
	lingshan.zhu@intel.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [PATCH 0/2] Initialize vDPA speed/duplex and support their updates
Date: Thu, 29 Aug 2024 11:16:18 -0500
Message-ID: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

Initialize speed and duplex for virtio_net_config to UNKNOWN (mlx5_vdpa
vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Include
logic to update these fields (for VHOST_VDPA_SET_CONFIG) -- even if
hardware support is not capable yet (Make a note of that). Also add warning
messages for out of bounds errors in mlx5_vnet get/set_config logic.

Note: You can test these changes from user space passing a fd of your
file "/dev/vhost-vdpa-%d" to:

void check_config_speed_duplex(int fd) {

    uint8_t *buf;
    uint32_t size;
    struct vhost_vdpa_config *config;
    struct virtio_net_config *net_config;

    if (ioctl(fd, VHOST_VDPA_GET_CONFIG_SIZE, &size) < 0) {
        perror("ioctl failed");
        return;
    }

    config = malloc(sizeof(struct vhost_vdpa_config) + size);

    if (!config) {
        perror("malloc failed");
        return;
    }

    memset(config, 0, sizeof(struct vhost_vdpa_config) + size);
    config->len = size;
    config->off = 0;

    buf = config->buf;

    if (ioctl(fd, VHOST_VDPA_GET_CONFIG, config) < 0) {
        perror("ioctl failed");
    }
    else {
        net_config = (struct virtio_net_config *)buf;

        printf("  Speed: %u Mb\n", net_config->speed);

	if (net_config->duplex == 0)
        	printf("  Half Duplex\n);
	else if (net_config->duplex == 1)
		printf("  Full Duplex\n");
	else
		printf("  Unknown Duplex\n");
    }

    free(config);
}

Carlos Bilbao:
  mlx5_vnet: Set speed and duplex of vDPA devices to UNKNOWN
  vdpa: Add support to update speed/duplex in vDPA/mlx5_vnet

---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 46 ++++++++++++++++++++++++++++++-
 drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++
 include/uapi/linux/vdpa.h         |  2 ++
 3 files changed, 74 insertions(+), 1 deletion(-)


