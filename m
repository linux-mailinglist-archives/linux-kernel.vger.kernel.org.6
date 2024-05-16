Return-Path: <linux-kernel+bounces-181268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CDF8C79C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFA71F22BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204A814EC6F;
	Thu, 16 May 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMcNt0zj"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1698A14EC7F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874581; cv=none; b=XTw752Q5MOOFMcH0P2DO5BH0YAOLx6/Bz7N3Uq3M1wmiUHETq8bT6FwTSPkUjuSrvOBIdaMURzbOuoe0RYa6d8HW8c9Bnbm1MKTIqRKE3YHkyElZoC9cxb4C6v2akOYoiiW9e5fvtF9RM3p5xjrIdSws2I8Bb9jnIcUfMaJwmbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874581; c=relaxed/simple;
	bh=JaUqxQHgv5XV0nLiCJPy0w1saO04+8/J9qQEQZEGkUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHQLAQEDHIxSDFgYfMO1yAuqAYQiPZnkZzVTLaWQyK/udcM0jtclWchfcTw+aiNcduw12AU3en/T8gntnqhv2CThEbPH40OspmkVEI9Szh8R4iuxvFO+9BltFzBjI043JLqCBCF8YMVsALCQ61iUMMdy2YxoFNMrSKwo/ObTIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMcNt0zj; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b21e393debso248444eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874579; x=1716479379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOy8P+m9e9TVgnsDHnWWNjFRdWyhKRoqoSc5hCvwSV4=;
        b=iMcNt0zjBTcw9K8p/AxkihPgFexQ+JjZ6/JPWmTrLx9CPwJRrr4gPBLQ0qbTIpgmTf
         pmohl8HNLajApgnpyjn9BG8ZlnA5N8UtzrJSKU/y7V+QbFNSLCaNiiyRrKaQ3xhJSQkk
         WRgKAJNx0vjG7cvQ3RfxtZ/99SPhRbwgzetce6/NZdhv3aNYRp/b9lsZQ3G70d8rwU72
         3w/qfz+B2qpKS6OcxZyAchHmcZGca231YK/GvSFAoLdYnPNiYjbahn5Rkx7vcFKaf53e
         4zZTAu2t/08vRGwYbFyxjCUAE/NWoG6YOlj7vza55rnNjbMHCNCpKJT1A+rfaO0bvxHn
         FNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874579; x=1716479379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOy8P+m9e9TVgnsDHnWWNjFRdWyhKRoqoSc5hCvwSV4=;
        b=RHYPstuXf0k7yhK+E2AHoywBI+GGB9HJmXUNIR2KP41wEiA54Kw4OOqPhaaqebFB6l
         X5hvzHCTZh5AjO4MS+j2lZUjfzyMRIoxLP4IyIH5EHiWZvTHIrr/HnMT1EQ4om88yiyy
         TrthQD62kn/RPXffG79CMY/6PcC1lHqsehDDdTqSh4JorqikKtZ8v4eD8BDGxZXQ0+12
         Ksthuzs7EcuPa2z40igZVpHeKH2jY/Kbpef09oK+P2SflRAEv15rGJAJD14RJRhoAb28
         4SMH8z7Wr9yFykkxpUF7PVtq1PCrax+pneNRoyB3R6FtCepfwSMpaqZK9RkhY5flpLcF
         TGmA==
X-Gm-Message-State: AOJu0Yzi9auJWqmOjzPLAMPst6x6FrNZPPa3VCroQ7ZjUaxuftBVDXUR
	Rq8bqDuzyVvR/NcWEncLDpjZA5xr5pROPbmAXv7qAVfCOCJ+Ppm76PhRBF0k
X-Google-Smtp-Source: AGHT+IFe4JxeqXFfEEedGDdC/7vfVPMAfs7lQs5p32UhZ+Gvqi7D8XSTAiVSEh6jnICim3SD5rMfrw==
X-Received: by 2002:a05:6870:7b52:b0:239:701f:fc32 with SMTP id 586e51a60fabf-24172a23544mr21892680fac.9.1715874578667;
        Thu, 16 May 2024 08:49:38 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c82edsm3562563fac.12.2024.05.16.08.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:38 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v6 1/4] driver core: don't always lock parent in shutdown
Date: Thu, 16 May 2024 10:49:17 -0500
Message-Id: <20240516154920.221445-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't lock a parent device unless it is needed in device_shutdown. This
is in preparation for making device shutdown asynchronous, when it will
be needed to allow children of a common parent to shut down
simultaneously.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5f4e03336e68..e63177314e86 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4856,7 +4856,7 @@ void device_shutdown(void)
 		spin_unlock(&devices_kset->list_lock);
 
 		/* hold lock to avoid race with probe/release */
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_lock(parent);
 		device_lock(dev);
 
@@ -4880,7 +4880,7 @@ void device_shutdown(void)
 		}
 
 		device_unlock(dev);
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_unlock(parent);
 
 		put_device(dev);
-- 
2.39.3


