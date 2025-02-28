Return-Path: <linux-kernel+bounces-539117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F78A4A116
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B5D3AC426
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0319276025;
	Fri, 28 Feb 2025 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drsSSEV1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FF26FDB1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765896; cv=none; b=tqf62xDLP0Qvnp8mVv9U99pEAgPppdjY+wP56ThHzr/vvV0eWhS7tbAhB7ivQVWN7wmS2fEvltszMuzK3V/yEfs6mE96sTmIvDSTf/QI9KxbueGwvH1csQ7gh4Sg3moVQprFKBR1nu1BAJjblVMetHTjO/S+vwBTKI/l1To1jt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765896; c=relaxed/simple;
	bh=scfmeAIOAJYjZm7Jb+84QkPQyC4V8osgVIoJao20Z88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdeC4dz9mQX3y+QMVrlBBQPwtcosHNYVmoWophj1bUFiMjCg5Tb/yOEXze5leL/KvGLbq4hm6ZVcf5Izcv2LGlnWgUo+2r+2oMzwlgRNqNb3ubsTTcr91h6M41NBgZcLDTCKMxqQpd2t2dyt6CfoUQToRS77oIS3mAt5K+kmwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drsSSEV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740765893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAMkimjaX5T169DBm7Y9jGqkQ+vg8U81DkhhnBduopw=;
	b=drsSSEV1sT9mw7otbLgCY28AShbwzlYWTgBZSZRVl4CidTmSTzXJQWA1Pt+CiIKjR+1Pj8
	WmqSkRxLpJnEVUcuoUh9lmuVJoxklvcvmf5xrQfMEhOffg/bI8gtFh+tMXVN2uoM+3k1rl
	HzJfiNjRHo8fu307nNXm8eLh2pZaYUo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-1ArMy8TqMSizM5o1PGX4Aw-1; Fri, 28 Feb 2025 13:04:52 -0500
X-MC-Unique: 1ArMy8TqMSizM5o1PGX4Aw-1
X-Mimecast-MFC-AGG-ID: 1ArMy8TqMSizM5o1PGX4Aw_1740765891
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c096d6602cso609212085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765891; x=1741370691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAMkimjaX5T169DBm7Y9jGqkQ+vg8U81DkhhnBduopw=;
        b=oEyj3VqC9JaeQbPawhPfZ2Gl0LBTI6wqxJ5AWA83iRXHUJ0EGgaI0KfPJiYngtsxUK
         xvjNMRvwlw7+o7zwWaVm3O+xyfK0FuqyJnsrRhiGE6BM/C00d9YcfwyeeIcpXBXtgkHb
         F6BHkcnKEY8QuXTsrxcGdULZI/5M05yxf/qu29zcjxvQoBjqkKxFJXdekcgXNTuS2+Rp
         3S6KU9ejuZv1k5+0RrSYIKILBoFamRZznXOIMl18Fvo2ES+OK/LcONmHFW6TeRvTl2si
         MnN+6NPHAqeOjM9MyunAUYmjz10xoKOJilz2rLW0wFoo6w/0t1Gf1IhiGeU4YySM0dNh
         61/w==
X-Gm-Message-State: AOJu0Yy3H05T49Ojclcj0y1rNKZYnM0ySHd85lEnNhQowyF7pY080X8c
	MKjwi87nY1ASHCCapsg1ssWRREJLkXxvdVCscSuc/85pjrwU7/9PO5A93zRi6aRjGZyV+P2jEmw
	JZZgPoXNWD/pkFtveWPNy7qpuUdB6EK//cHZUdBn9KFKKgpZb2Ql6pVsGwqm0bA==
X-Gm-Gg: ASbGnctLzyKz3Iu/2AbdnjnlPFueeLeaehgt/f+w2MLeqQduhKF8vzjaLjnWmXoCco2
	wTlQjFAR1TkBqtMyTsuEKk05VaWl2AbGhsS2jQ2tjM9BAGrNqZZ6SM1mPhKGHTSmjQZOaHByaeM
	Bp+3I4cpMLtti4HNh37YrPd1yhc3A6q+jJwt4kkpSdqAyBvw/Q7Hgh9VSO4AmzhYiE9ttC/xHu3
	U1xISNozdDcoOR288ojWH/fD1TXEwy0peFQBAW9Usbtx3BC18+uLpXin0UHW4Ptvz19pG12PkyE
	b3uNnryXta+CDswX8BcDWhhlRa+EHG2bl/uG85dqh+J5Q+htgdHPjZvPI1nraoaWgOWVk2X0g0A
	=
X-Received: by 2002:a05:620a:394e:b0:7c0:ab10:1132 with SMTP id af79cd13be357-7c39c656e05mr626151285a.38.1740765891351;
        Fri, 28 Feb 2025 10:04:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTh85sVtk5oi8HSf7ZrK+kyN9/o2F13SCQKm1m3pZ9EncsS4obYl1hjRjtWWMtTxJIGo4z9g==
X-Received: by 2002:a05:620a:394e:b0:7c0:ab10:1132 with SMTP id af79cd13be357-7c39c656e05mr626146785a.38.1740765890866;
        Fri, 28 Feb 2025 10:04:50 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8a08sm274654485a.6.2025.02.28.10.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:04:50 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v4 2/2] power: reset: nvmem-reboot-mode: support smaller magic
Date: Fri, 28 Feb 2025 13:03:26 -0500
Message-ID: <20250228180326.256058-3-jberring@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228180326.256058-1-jberring@redhat.com>
References: <20250228180326.256058-1-jberring@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices, such as Qualcomm sa8775p, have an nvmem reboot mode cell
that is only 1 byte, which resulted in nvmem_reboot_mode_write() failing
when it attempts to write a 4-byte magic. Checking the nvmem cell size
and writing only the lower bits of the reboot mode magic is needed for
these devices.

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/power/reset/nvmem-reboot-mode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc4..112e6cf77d1b 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -20,11 +20,18 @@ static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 				    unsigned int magic)
 {
 	int ret;
+	u8 *magic_ptr = (u8 *) &magic;
+	size_t cell_size;
 	struct nvmem_reboot_mode *nvmem_rbm;
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
+	cell_size = nvmem_cell_size(nvmem_rbm->cell);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	/* Use magic's low-order bytes when writing to a smaller cell. */
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && cell_size < sizeof(magic))
+		magic_ptr += sizeof(magic) - cell_size;
+
+	ret = nvmem_cell_write(nvmem_rbm->cell, magic_ptr, MIN(cell_size, sizeof(magic)));
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
-- 
2.47.1


