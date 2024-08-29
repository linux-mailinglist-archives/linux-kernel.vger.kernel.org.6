Return-Path: <linux-kernel+bounces-307123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB869648AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B941F280FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F31AB500;
	Thu, 29 Aug 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chPkQkaW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C81917C6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942286; cv=none; b=RTlVHMOIP8I+GLFufob/JSH3JYBAZ+ob+L3ofue5rr0U6pZCVLmxGm6HWeWoxg6+cq2QNhCW73VwDwCD/DK5Cg2aNxUzko37YilIXk7NrgfoA8Ba9gCfvIu5qhu9sFjCFl7f6wNXDSxB68AIPCINA4ZzvSszJRzOvqWybZ7iR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942286; c=relaxed/simple;
	bh=kO6eLj8b5GtxEvWv1FM9fpVAw32heo0eC6Eie2vwPK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1xguBPOZQHVnMwQqroJLdi7zy98qMpcHUuGNIh+tcACvRi0K4ViygZ3MHYpkR3p9OVau8Zj6hPZW7mAGy5fi8/NgIBU7VW0MxPIfMzZfuESsky/HJVrPzicDeJrjVcNSuaxLteC0RUIYZA0764k6MseP18ByVVTHYm3yNC2KNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chPkQkaW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724942283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QA7bpSUbSKgzhSzKQGbcEto2ZPij1K94G2+gp5Ocka0=;
	b=chPkQkaWZX6Mj/VsthirYlPItgYWLKBvGSOsPIIH/d1gArHjSgBozYeSbatetDdbCfAxD3
	r/v2eSI+q4jh3ejZV7eNvFpSlPlajSpIWs+dgFJcRXO0coXEad8bYrTV2XJbgWjcl5S5f7
	V9m1EUKi5L6yGRlEOJzl7yhynPuDeEA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-Lwxo_g6NPbOjAVqx8rxiEA-1; Thu, 29 Aug 2024 10:38:02 -0400
X-MC-Unique: Lwxo_g6NPbOjAVqx8rxiEA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8691010836so54129166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942281; x=1725547081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA7bpSUbSKgzhSzKQGbcEto2ZPij1K94G2+gp5Ocka0=;
        b=aVXrksU1EbK/s/WRfGf5Av92YYdgHh9xdcXKIioMwujqGc+BVOqyN5xZbYsG7aJ5sp
         5NxQKGz8+jZfv73i+sIP7NoTPw6CSwIRoTXvYSQvltB3znN7wlY2ee3ImRjnUD6P+4Cg
         ulUnuxsWQ3D3Zr0NOOSwz4SfKGhjAGYyNlc09mQ1+yZhspQaNJw2RlYbDRStCsn8xNPT
         zV3cXcbsnOxqh8Yy6JF1Y6YJb64tkrqyFh8rJKNiljvKfLud3s9iVLpWp5RrcVDRCeBY
         UFxMjRmIQWHwur9HksFdFt3sqDzjyG/z7YroFyMncrYEddTWhJFNLJCGFaQQkn6cCQ7N
         sJnA==
X-Gm-Message-State: AOJu0YxDQYQ51+DYdi1KYOD06ZkuOxwDsH/OF7SfcicfHFb1NJf8lH4T
	noZMqNsdm9etOOSQy3RGjjG2lpReIy64z/L6MVDo0a6o9wBTVyQqEAH1/Kv72A+StXrC96rPE6O
	H5YxSBw/cHhavD4zMWMeujL+K56Btk9U3a2+unjoGWtDvpbE1bkd3cUD0HjmXKA==
X-Received: by 2002:a17:907:9726:b0:a86:8cfe:ec0e with SMTP id a640c23a62f3a-a897f930bfbmr235824966b.36.1724942281284;
        Thu, 29 Aug 2024 07:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOsYeMoocTHM57DyV7DV7gjAjfbPxGEazD11vV1FPO79V3FNyyGgNXMYOj2hU1lGbIQbSmFw==
X-Received: by 2002:a17:907:9726:b0:a86:8cfe:ec0e with SMTP id a640c23a62f3a-a897f930bfbmr235824066b.36.1724942280376;
        Thu, 29 Aug 2024 07:38:00 -0700 (PDT)
Received: from step1.. ([193.207.133.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fef4c3sm86159766b.32.2024.08.29.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:37:59 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH] MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
Date: Thu, 29 Aug 2024 16:37:57 +0200
Message-ID: <20240829143757.85844-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio-vsock driver is already under VM SOCKETS (AF_VSOCK),
managed pricipally with the net tree, and VIRTIO AND VHOST
VSOCK DRIVER. However, changes that only affect the virtio part
usually go with Michael's tree, so let's also put the driver in
the VIRTIO CORE section to have its maintainers in CC for changes
to the virtio-vsock driver.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 878dcd23b331..6dcea63f396e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24218,6 +24218,7 @@ F:	include/linux/vdpa.h
 F:	include/linux/virtio*.h
 F:	include/linux/vringh.h
 F:	include/uapi/linux/virtio_*.h
+F:	net/vmw_vsock/virtio*
 F:	tools/virtio/
 F:	tools/testing/selftests/drivers/net/virtio_net/
 
-- 
2.46.0


