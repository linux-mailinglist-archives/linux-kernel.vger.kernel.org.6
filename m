Return-Path: <linux-kernel+bounces-331651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704A97AF92
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE068284B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB09175D59;
	Tue, 17 Sep 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0H2AXF0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76718BB9B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571716; cv=none; b=ApUDnc2Wme/2TwYxFHh2hKCOoxmSpwWLFOmVgEX1+LBfc7XOY5Fn7jS/IQUe1+AiYUDvaSFwwK/NIzo8VOn5gOxXm68WmKqxJANtd0oVEnl7LV05FnTJlckUOpqe+K8ttkdA8/27/d3FDjOwpKbbRRYpIBh4GyDn6RhazaJmBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571716; c=relaxed/simple;
	bh=CYAjQ4wdv7Y03goPVnrOZbsfz8xAVNVMuosK2YnJqOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkJSrRmkuZS22GCBXurMk8YmWQU5dPelwscbPZLnalWqPV5jB5qee4BGUgj+n/dEs6WZRbsZzNPihyKcvJCImhBjDTX6MXasPDlrH9QIFlD76abp8vPMvPP6kXyijUAbUQmEuJAPw6uhity+Gjep5ECMAkKyS6Quh4D3gaqySyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0H2AXF0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726571711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MW8x678qT6AsCGLPgfGprRX5j+kTF2/8oGHXxDM/kNY=;
	b=b0H2AXF0sonQE/z8z1g8ApM68waekaJ/A4XWGkiYqmcq9XLRus8pMv5KrNJ6vDS1A1U2DD
	jPHACL3KASWnVOSXhpo1mxt24TcPtvnJzI9B8UVRUMqOpcBY+gA9R1Iin4a2VM4w7yaUOs
	TR0ZpqHQf3GkgdfTuEOssp+r5+d7hPQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-x-f2rH4nP9WjDeqiws32cQ-1; Tue, 17 Sep 2024 07:15:09 -0400
X-MC-Unique: x-f2rH4nP9WjDeqiws32cQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb9e14ab6so34767775e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726571708; x=1727176508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MW8x678qT6AsCGLPgfGprRX5j+kTF2/8oGHXxDM/kNY=;
        b=kA7761tf1Fl+COhMGXuAaECdQgtrelcDHe2zXsZis40eCt7wGBIeCgdrkrBQZMeESX
         XYwp7NmGtt0QmOW/c32nxLx2AoRGXsBE/Yk8g0/mN1/55hZ5MtEdgz1m7ZG9ZkQyos+t
         vdfUfGUK22BQ16CnO20g7lp/y4nZ9Oo18Y9p3Z4L3ma30K7oBzAj4AJUFRWb9zR+/d2H
         OUHkL13lpbjZXc8aEmFdzxcErIg/xhJGkvl5b5xTGqx9Ri3NwlnWf88wXh8ZQCsEbG9Y
         RdWwRu0jOUll9sZ/7ux+ajgdPpRgrrY+SfYDqjSoEE93fccUKt2fCgxDBqjAK1Swaq2w
         M61Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGvlNNxRLSS80DGTuUuOtxaIyDzIGGua8cWNNnkBQDlkz9qQusfesG8KScrZCR5gd07KYiNoYOxK1JPp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWbs/hkp9gWUZuUjcRwlxuk0YKV0O+MM8ukPU5wW6qx81qAong
	3Qpl6Ck6uLb4qVAV2nzEeaK3QqIdFCOAWQ2Z0pXNPhbYNFsu2qiHBo6neaPZtkjqiHqjPBuIFdk
	8BsxbkMN02Nqp2h7fmLNfjoCUdA7GWiU4yvWZQOc/i4JO849XNie7Lx8yQOtH/Q==
X-Received: by 2002:a05:600c:4ed1:b0:42c:aeaa:6aff with SMTP id 5b1f17b1804b1-42cdb54078dmr141256345e9.10.1726571708569;
        Tue, 17 Sep 2024 04:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWah53YqgeAFPFiU9AClXZ/7GYiDqizPqjCjVuclqxZI582y3EwGlDFOfbQ2R5ux1g9w4d9A==
X-Received: by 2002:a05:600c:4ed1:b0:42c:aeaa:6aff with SMTP id 5b1f17b1804b1-42cdb54078dmr141256035e9.10.1726571708075;
        Tue, 17 Sep 2024 04:15:08 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b1949c3sm133660925e9.46.2024.09.17.04.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 04:15:07 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry of the oa_tc6 header
Date: Tue, 17 Sep 2024 13:15:03 +0200
Message-ID: <20240917111503.104530-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit aa58bec064ab ("net: ethernet: oa_tc6: implement register write
operation") adds two new file entries to OPEN ALLIANCE 10BASE-T1S MACPHY
SERIAL INTERFACE FRAMEWORK. One of the two entries mistakenly refers
to drivers/include/linux/oa_tc6.h, whereas the intent is clearly to refer
to include/linux/oa_tc6.h.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference. Adjust the file entry to the intended location.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a4fa88edcd3..23a9337bb97a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17317,8 +17317,8 @@ M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/oa-tc6-framework.rst
-F:	drivers/include/linux/oa_tc6.h
 F:	drivers/net/ethernet/oa_tc6.c
+F:	include/linux/oa_tc6.h
 
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh@kernel.org>
-- 
2.46.0


