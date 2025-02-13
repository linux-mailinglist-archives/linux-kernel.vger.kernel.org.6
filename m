Return-Path: <linux-kernel+bounces-513411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FEAA349D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5CC7A1B47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F73204C17;
	Thu, 13 Feb 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KR8XVUU7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C9288C39
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463514; cv=none; b=B+KG8SF8uRRhqFDnwboqmCl/l/rDvFCdIrM/k/I/o90zpcjt0BUMAK61kBQxgfG6cV/C2ULJPlPXinaLW8vwAEXBl5tJxAYqH1/5Z2SLo93y/2iSwju62FXbtNe2OTRNXxNQJRGVR0qhM2mihdv80x/h+RWtohtOWBYjqOViucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463514; c=relaxed/simple;
	bh=Vrn/4vwdmsdokkCuLMXfyT1nZ/jStbBCx0QhOmJ6E80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIZAXk0HLi7q9pAEGE1AlUIlAoDrekybpbWjhlBawZIP0rjlb6utTlQHO740r9XVBJc6WIsrbRLN0piefXR38shqFrCAMhu7J1KsmPRiPwlZUYi0VjWS/sMi25am4BfWnRSa0zfD07QhAMDM/7z0cPPhwZcKtHyR7KejtTnOTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KR8XVUU7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739463512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iKzjBSUkdHDLfZzf4JfzRiz+zb6GftCtkHoeHOHlZwU=;
	b=KR8XVUU7DG7jD/zxb+lbHS5Yl7VFnGZpON/cBXmjqzj2KmxQOpQcMqX52jSqyCP8CWVgLV
	NdAsg/reAu7LNebnW27WKUOi7k1UFnfbDJYzhiShkbzqsXFgeqU153YFy4GXTDqKQYH4fB
	uCq6STplimvX5HkrXSLwTIewYHgueAU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-uAxN4IglNm2VFIyu96Bi6w-1; Thu, 13 Feb 2025 11:18:30 -0500
X-MC-Unique: uAxN4IglNm2VFIyu96Bi6w-1
X-Mimecast-MFC-AGG-ID: uAxN4IglNm2VFIyu96Bi6w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4393e873962so5510845e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463509; x=1740068309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKzjBSUkdHDLfZzf4JfzRiz+zb6GftCtkHoeHOHlZwU=;
        b=aVLncs8GY56nj1hHjUyURQ38E67mEhAkOYuWs09R9gKeg97W5jd2XY/guwqzoqLIU2
         ukHkeEgjL1el5Pq/4P8PsGjPuHK1LzdZfp3wi+L2Yg2ixhJL8Y3j9WlbE+g7x0qQP7Sa
         es457P5GwII8dppgbG6QEtLpYX3Tct0xwAQZ0k2zaRA02JFxzyjmP5LJIdIyTvxsQ4sw
         ausAeX58jNclEYdbArT6YRUIc3MYTH5EeQVzL3QjW0ViHXPr3R/i3H2eLL1w6FtV2ZB3
         xOCEhf9JzhWGJIDFlVPjo3lmkW8JE/LSka27iOOhSp9mvzioVT7egp797bYt+mxWG/uc
         EoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWtWAH4LCt0N+KQsj1NKyHYv0IZy+PuKo/6C3lvMHlJ5LQjdzBvUn5JQLpNPk4vGXx7MguCNGbPpsrRxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxsb//zC/TNXmxeeJHsSdsVgJSPGsfuulaaWedUmwybbWF43hG
	BBcw3u4RF/6tyuTbK2bZ+bZFWjcmMS/c1zhtlSxeOWZBn3KjEWpUeFZS0karHI1nURAL58xH/OL
	aLj9lkSOT6IBEQhKaruPbyuF8A3rIaNpLijzHwEnTLWw515bc2mJYZn/y5w9ddcoVUfbZ8Q==
X-Gm-Gg: ASbGncsYQ2OsvsFsSpW1nIpk+KClRIg0fyimYAejlOa7fbbZvvrNypXUYIJKcIa6mKZ
	1qu/sGuRvtcQ1L3O+sxo0jdlMzZVbAP2ZgQ1MWM91MCGm2upOdNaCAp2HXSfOOJ/EpRb953+9GH
	V47SK/st9TTC1a9URMemwD2KZljNOFxUETpYTxfOKR6Van7mGsHVdeIGGX1tqZfsw+3UsewMORJ
	tq0yzIgSntYQ2FABoNo7TTouONyZtvuC/Ohr4AR3vE+CKsHIjtTUnGqavQ1m4Uz1GcxxI56XOGP
	BtZtoEvPE0I6Lo1Uuo0dAVcQEmG9l7AoREP/0hKpurJpjVQlJmYhGNM=
X-Received: by 2002:a05:600c:698d:b0:439:574c:bf76 with SMTP id 5b1f17b1804b1-43960179b7amr57710605e9.7.1739463509156;
        Thu, 13 Feb 2025 08:18:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu6y21w757rvE76+QUOv51wsc6Q/8KLtoBTuUd9R2tuHYuDtc916mYTl90tlTU0umnS7sdnA==
X-Received: by 2002:a05:600c:698d:b0:439:574c:bf76 with SMTP id 5b1f17b1804b1-43960179b7amr57709765e9.7.1739463508492;
        Thu, 13 Feb 2025 08:18:28 -0800 (PST)
Received: from stex1.redhat.com (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d237sm52922715e9.21.2025.02.13.08.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:18:27 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	linux-sound@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] virtio_snd.h: clarify that `controls` depends on VIRTIO_SND_F_CTLS
Date: Thu, 13 Feb 2025 17:18:25 +0100
Message-ID: <20250213161825.139952-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As defined in the specification, the `controls` field in the configuration
space is only valid/present if VIRTIO_SND_F_CTLS is negotiated.

  From https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html:

  5.14.4 Device Configuration Layout
    ...
    controls
       (driver-read-only) indicates a total number of all available control
       elements if VIRTIO_SND_F_CTLS has been negotiated.

Let's use the same style used in virtio_blk.h to clarify this and to avoid
confusion as happened in QEMU (see link).

Link: https://gitlab.com/qemu-project/qemu/-/issues/2805
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/uapi/linux/virtio_snd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_snd.h
index 5f4100c2cf04..a4cfb9f6561a 100644
--- a/include/uapi/linux/virtio_snd.h
+++ b/include/uapi/linux/virtio_snd.h
@@ -25,7 +25,7 @@ struct virtio_snd_config {
 	__le32 streams;
 	/* # of available channel maps */
 	__le32 chmaps;
-	/* # of available control elements */
+	/* # of available control elements (if VIRTIO_SND_F_CTLS) */
 	__le32 controls;
 };
 
-- 
2.48.1


