Return-Path: <linux-kernel+bounces-297948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB395BF84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CDB28151F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEED1D0DF1;
	Thu, 22 Aug 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4vG2I+j"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73531CF2BA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358497; cv=none; b=nIHy7tHUoyFuxewTIxm8S8P8iRaZVrDsbccenVTM+raL4GSalsJqC9+Zpc0RSkqU62iP8FUztAgNb+R5HQXKcJlqh/9T4BCuaOoalU/1D0w6TlInQdulSOzeKepVTYwoaS/HSLHmPFryGbeZnLT4q52zoPSQxDzC76uNLuNSFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358497; c=relaxed/simple;
	bh=sihxqV4aIZQMIil8+9BUF5iovP+aVDiXz4bTbGf1B08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8qrJyjJmQM8vvB5vqerd5FmJLUHebb7Lco9ixsj1txSTAvKp0wgtYPR0WcmJ4DOcfrcTdzrXJscSD/YMLsbigZEqGyRxDDa7Qe3J15nidkxl2PHzrbLXMEI7O8EGA16buEAFETFTbQGiNWWQA4pmIvIgRL+vs4BPcqGerD8X9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4vG2I+j; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70e00cb1ee7so848247a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358495; x=1724963295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN6DwnGZ7LnuM1YHlsixLSHjYDgpQQZNtiJ32vWBOs4=;
        b=Z4vG2I+jxXvDg5ou/SGmx8dhEWjySNg+4UTNFT9nwXtyI46yNR6llfca1IsSL6pvl2
         fkxYm9zFZPd8dYvr1YVfNuZa9XdnckLnYmqJvwn/vP9fMWUgLOj5BOCoK0lUS5glrtRz
         125aRiXQuvoNtUYBZ/hGwOuoJUtq71VbZ05EKlrtcemolfdbnlD8mRMVuipZ1f6OZdP9
         Gqu67QUKrBkA2ZnFbkG8Y5HYQVIbhbdnqz0ZDNG82oksSRuidY5sm1wzLqwGY6uth8xp
         SdOvmoeiU49WHA0eNwky6745JKRaJZobjhiDFhNjHoHG38ag+AR7cXW1/1+46IJ9Cys/
         eybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358495; x=1724963295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kN6DwnGZ7LnuM1YHlsixLSHjYDgpQQZNtiJ32vWBOs4=;
        b=IJumhtVJemWahn3Yz97NrzCvYpUu3DzX2LKwBGWHTXKwU5fX7wEKvlL3dr1cKGjIqb
         gXxcWS458jlceMXSWL1BURo+AgQst4E5UpadODg9jI5p7UH0t2jKaWL6/FMiBeqEEaS1
         ly8UJ1xtAbEAbMXLRBRCBi/ogdwV/BCEGJ312jNEGChgwrwDnx1HDgN+XuZLt1YDXyTu
         6mI1uBgQ4829RGEyTOgyznmwMA7S+nMYrd9zZa4wMk82vMrKjJ+tMUOPhLWoY00blUAk
         I+8GsFcps3zcAlrK88pcccx3ADdSRAogk0DH8L4ABiYNi/YHeCHbjcbt19wMVDEnYnHt
         dUvQ==
X-Gm-Message-State: AOJu0YziULC+RUOUqg6Dr1lw3PCNVU9W0Qnx/jiLcQfSXgOODBPpr0LD
	KmaM+G7xZ7P5i1cfN5WPXWmH3p8BcSvJucSmNLUWdnJ3RYNT6QTNoFR337w/
X-Google-Smtp-Source: AGHT+IGM9eaD6qRrORCTD3ILenlNYjzUDdYyP8kMrFM2XEXW2BxWn6SCb4xiJnKAbfa0J/SN7nuIiQ==
X-Received: by 2002:a05:6808:3c4f:b0:3d9:2154:2ffd with SMTP id 5614622812f47-3de2a8416bdmr32232b6e.3.1724358494866;
        Thu, 22 Aug 2024 13:28:14 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d5fbsm421265b6e.1.2024.08.22.13.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:28:14 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
Subject: [PATCH v8 1/4] driver core: don't always lock parent in shutdown
Date: Thu, 22 Aug 2024 15:28:02 -0500
Message-Id: <20240822202805.6379-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
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
index 8c0733d3aad8..13253d105062 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4818,7 +4818,7 @@ void device_shutdown(void)
 		spin_unlock(&devices_kset->list_lock);
 
 		/* hold lock to avoid race with probe/release */
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_lock(parent);
 		device_lock(dev);
 
@@ -4842,7 +4842,7 @@ void device_shutdown(void)
 		}
 
 		device_unlock(dev);
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_unlock(parent);
 
 		put_device(dev);
-- 
2.39.3


