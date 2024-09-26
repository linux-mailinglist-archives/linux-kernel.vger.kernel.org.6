Return-Path: <linux-kernel+bounces-340753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB0F98776B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CD67B21D97
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0938A1552E4;
	Thu, 26 Sep 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Oztb0/WS"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571BE34CC4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367471; cv=none; b=jvytrHvUWYil/HJcVB+MhyQoENkIrnVV6WSQTjEC1/bk1bosV4ajuZmwG5DJXzab79gI0oTGLbYlqw77wXcOozpL8o4T8UqcBzDC18/Io2+9LZZ1jw/RkEkr2I/K2Gbi40xDkf+LJa8F0ql3mzIkqrVC9mUBC6byBuVJ+gIxRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367471; c=relaxed/simple;
	bh=7gDjgu4wElEbQxuDgDh35dLOIRlB1xp7/51JxMwantQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eiTilfMPQ/wiXnHnzspHMYZWVopPL4BXF99pXFxTTjWFv7W54URwGV4ZkHr4tF8opXYL2Ek/+ji3oVt8Axm1iYVhrjG4a+3pudECREuG0IM1GQWrCXQlzyZAraHaSumsJLGe++C2japbmbUEn7dS6/ClDKnIJub4djvXkDbOi3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Oztb0/WS; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8AD6E3F2FC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727367444;
	bh=b1Yy5Y+O/8SNdOfIY1NdJ3kg1DxrF1aZEa29oc+RxsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Oztb0/WS04iM+MTpN9XLV0YJBWobEOIOA+zZw9TMj+AJgRVb/cVXv4oVY+VA24nux
	 9c0nvNjat1VVe/Qpmzz49J/xjBk3a9baVUV9Hw7/51nB3RbGEGJQpNmNwhfMSscAqf
	 6HCHIAdAvkTLNq2UL7FXgn1GfkGuRBVKUPeUFtJVVCOL/BMvbm5gGYeuqCeRfRlywn
	 iRXZlczQtHtauBxfg3nxXdOKXXfj2/iBfCmN8k74ue5oE7bGaI6H7v/6DTqriMCxNW
	 5twVgh1kqD+qpjtnIKBK4aIBV3+NZUb+DgEK768i1YHaz9IpkNtZmukIp3nkJDsAYD
	 IjE8bvwC4X6jA==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so11146045e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367438; x=1727972238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1Yy5Y+O/8SNdOfIY1NdJ3kg1DxrF1aZEa29oc+RxsM=;
        b=BM/PD1ds6IAAk0tScyhPUA6m0OWSNfOU7f8PlbgPvz/ezrw/qVPdto1ArXM7A8kbIF
         UVkhWjc4gp/ZSjNWe0MncEHQCQSrqII5FgV4FxdjQ2amsRc+gCXqiExcKibTznHE5ulg
         Qmyv03uS84EpLzGdbHRlTTaN4yuvJ28KDd+u1rk20Czt0niW95ywmXq7pQDLohhfqF8r
         6L4hTzRXudn64/M6ZxedlC962sTHJM+TOqPfRBOkzNLzlH1oMt/ZcaotNx0gbjQy9btS
         9ZUl+spQ2zNz8c8H/oCsInk3hLXVPhS/Q7ZwDhgPDZBgy8KSOwq58UJ/AWWCyOULkQau
         dQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCVYehuZNcmPR/0SaKEfyxysGfdIEofMTYoMmYK+GmQVn3U9b4Ukbm0S79jAVDvghB7cK3krKDZOpwsniVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iPKX0q/l0DZiIlBXggwB/REy/ey79h0aZdMHm4wZG4hSLEYp
	NiviqVWsEk01inidK0Uh4wgHxH6x3j13LelDZ/1L50Mv5Xs12HDQTulfQIHsCsc8dvtRuE0RBiG
	KVzgCAcAICXB7Gvi++73vYoXpS+cLc00PoqDuFeyG2XjZzh514CyfQaH49zqetScTj/4MAerNw2
	kmXw==
X-Received: by 2002:a05:600c:1d88:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-42f58433478mr169585e9.8.1727367437786;
        Thu, 26 Sep 2024 09:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzaX27OdIk12RXul9FuGgRDD+iCxKpGs0uDOQekLQVHE70zEjsFFHKV6Qz72FM1jylL5Re6g==
X-Received: by 2002:a05:600c:1d88:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-42f58433478mr169345e9.8.1727367437454;
        Thu, 26 Sep 2024 09:17:17 -0700 (PDT)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948231sm14104266b.99.2024.09.26.09.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:17:17 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: stefanha@redhat.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vsock: specify module version
Date: Thu, 26 Sep 2024 18:16:40 +0200
Message-Id: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explicit MODULE_VERSION("0.0.1") specification
for a vhost_vsock module. It is useful because it allows
userspace to check if vhost_vsock is there when it is
configured as a built-in.

Without this change, there is no /sys/module/vhost_vsock directory.

With this change:
$ ls -la /sys/module/vhost_vsock/
total 0
drwxr-xr-x   2 root root    0 Sep 26 15:59 .
drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
--w-------   1 root root 4096 Sep 26 15:59 uevent
-r--r--r--   1 root root 4096 Sep 26 15:59 version

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 drivers/vhost/vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e23073..287ea8e480b5 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
 
 module_init(vhost_vsock_init);
 module_exit(vhost_vsock_exit);
+MODULE_VERSION("0.0.1");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Asias He");
 MODULE_DESCRIPTION("vhost transport for vsock ");
-- 
2.34.1


