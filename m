Return-Path: <linux-kernel+bounces-419075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304EB9D692C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DAB281EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDA21AA7A5;
	Sat, 23 Nov 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aioqrH4x"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D81A0AFB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732366941; cv=none; b=bsCjErDKtXA7WIX8PkHW5wqCaDuvBVdRSBXl/XW859wTffTzhAYUPJRVKlrl2TQPq+UCu82rybn0/5vZgrc5RhROdlX+UqOJp2bdGewdL9xobgO5CL5BCN9H1sh7KeoF5R9fhZIR/gTA3OLhqCHaG3gZOAIw5gXHisKgvmMpR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732366941; c=relaxed/simple;
	bh=1FA+hjg1bN4nj28QQZhaK6g2V/NyW1wvcou+vTxD0/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UONcdoc/cfcqLdPmQZG5F4tgsCqILeT8OBcw7xBvK0KqXjFQ7iXFdJ8zB2BiFQRwSpbddSyd6dpiULeyu5MELDK1NXWCyV/LQ20bO2Hl/YjaycDE5RWi17s81VMHYXhsAMCHjWCxPxRi7+iEmjcIR+/TVWXpRfjLRqDWRdiPHh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aioqrH4x; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea6d689d22so2431483a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366939; x=1732971739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0Wy8akKqdjTq0kGb7hjR97SIT8ZdC6Xj+nkupcGNJY=;
        b=aioqrH4xksa8hdt6iuSzOtweg0zOfA7ic5pYsWPMDxq+2UEHYvtYRojIYcK7Eu/HZc
         yg3ZpsxQxFxrqMw53an7IKasqH6SCWC3RHGDWQUOHJtd0a4ujcH1lT39UtlaiQioLEn3
         25yUyRyJ2pNEDWU+Wzaxk63HAcd81QXVuvOaPve+EWxLW7JwMWwThHEaio/eaqxjZTDq
         KBI0Hwh2h9Mf6rtPvQqOUTdjhLo167CRtiwSQIPsVeMsY+FjzUWyExBAQp2pUh+QsIZZ
         Za0TsZAFFQhjuuBodNXPQshIE+n1fzdiNSUhoJPqNK+hCknvv0KygDoecyX4rU3c9p6g
         nzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366939; x=1732971739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0Wy8akKqdjTq0kGb7hjR97SIT8ZdC6Xj+nkupcGNJY=;
        b=f+Iw+0YebEKx0gbKF8xZwxMjQ7oBffwAGwxrMlLu66ez1MVOYB/+t/QryvHJDd2zGO
         tzcmzoWyASZ8zAzei081RjMl1LnsS1G02XxbqqQIv51ZaiNj0RUcsdk++rsud1SZn9zz
         MNnoMX4I+1RKYlHHYFxl92WF4ShYODaIf7fRVMTjz/9azRbE8FO/lncnewwUrcbyt/i2
         QF7rH1tEdfsmzFrcLKLcXWhLxLffoWOCjh8vh3P9KK8R5U0cdE+V3Ce/y2g2JeaMA+Jn
         2lIF2OaoHlGDUXvDPijEa2BC/L/9ENjU7LQx8XuL+c0okz9AEYHiVRtgDBXPIUdH9ALE
         Ujow==
X-Forwarded-Encrypted: i=1; AJvYcCWm6APG0T2GBMjia1st+EB7Sl9bqM2MSjSpMKWs5wUsnwf14CZVTFW+skaeRcT6PSLg0Z27PAUP4yPQ+Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6K9tIeghDMmpkD/shQ+wflLRPTbjU3szO2/HwO0G+S82rd0xP
	BhlprS66ZG6s+Pk/B7q9GzjhHDdghmJljU2s8gIaphIiX0vWNKYa
X-Gm-Gg: ASbGnctFlNpMmHsGPSoRs4Q45ItWFn0xBvE1+J4/bo8zK2Id9PcgSDAxOiv5781IXLd
	ywGJ83aIyRbtzpmHaP4bZg3ah7usKH3vQRPOso5TNkEXExHPSs++vqrV10yyOtZmup8pVbXReiL
	GJKVU2b3HoFpzPxhuaQtmcb7rYjq6GAnAD1UsBxr2WDg4dd5jKFXVFJMQa9nXics4jd0psYi89a
	/OytTVb5qEp5dlbyA6CuFRS2CnGuWflIpSFIkSdJj53I6cKd6Z+hbCx6zt5Ng==
X-Google-Smtp-Source: AGHT+IEZbBIT2xSL8lKwxiK2DmFG5PNj1NHAzAd71DuVF5rYYhINvdRlBjQGjWEtHL15HTh9/7gSqQ==
X-Received: by 2002:a17:90b:33cb:b0:2ea:712d:9a7f with SMTP id 98e67ed59e1d1-2eb0e427ae7mr8022347a91.20.1732366939554;
        Sat, 23 Nov 2024 05:02:19 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:18 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] nvme-tcp: fix the memleak while create new ctrl failed
Date: Sat, 23 Nov 2024 21:37:41 +0800
Message-Id: <55fc0f971eccc72b7ff2b2ce176a7faa8828e487.1732368538.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732368538.git.chunguang.xu@shopee.com>
References: <cover.1732368538.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now while we create new ctrl failed, we have not free the
tagset occupied by admin_q, here try to fix it.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 57f0f0290cc8..36c7e49af38a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2267,7 +2267,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
+	nvme_tcp_teardown_admin_queue(ctrl, new);
 	return ret;
 }
 
-- 
2.25.1


