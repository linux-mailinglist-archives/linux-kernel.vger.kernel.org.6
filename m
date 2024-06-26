Return-Path: <linux-kernel+bounces-231417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E9291987F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB6D1F21DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FBF1922F2;
	Wed, 26 Jun 2024 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjADkj13"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B71922E4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431233; cv=none; b=CejIVzO2HdsjYXf9ZRC5Ym2vVcvTAT+erhXj6EFFDJOFY1c7q0usjHmpVTyW1ipeTAEMOEQPy3cjce0PjK+JgySqKgx7SORyjJZqF2Nvy7TKPF5h8y2zEysjJoM2Kg05IGw2cvikAMZKWB4PdnOwJHg9XKbybOZPLk1ByyuXxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431233; c=relaxed/simple;
	bh=l3bUJ9KnFiZZ581aAAIDi02PIvqwbk9jreOFCeFI5mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fb1JmAi88gEITimaDzxXcfzWfWdqxsvbZ2+5luowshAzcU+MDTJrIB8b1f0Ym4XTOZpVvhFuCEVW1B50xFhA7cMsnYFVU5ijaD86kQsV8prQe2PUd7Pr741SKW1Nj0arTRaCEsj1kEHMNUmOIp8ROMRuEbt0HWoH46tsjLTUlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjADkj13; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b52eb2ee2eso21128026d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431230; x=1720036030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quNMt21k5Tu+QFDqj3HStB/o/6SWdJctxGCAsXhdbxw=;
        b=YjADkj13Yov7Wqn207XbdoZb2aqJoYvjTBnC9zhEsqiMMfnmjWYbrXa9V7RY4tMVyx
         EwFzWaq0AmsJGYrwbH4Ev0VrYYc9Rw3mQPX3jyr+Fd98HXRo+ogcFbJsPGDj/nwjN89m
         CvZMJc0JR2e6nKbKhF81CnC108NvcJX/zJxF8rpDpAcG2wRD+pJHUpqz3lzxkMzuUEGC
         Z5IvNfAc5SWC71HqOnYoMlzatW2NhxtIpGAMrcYRPv2FIOHEH5wLV//gzU0dzd1UfWR7
         XsXIaoy1QwgXcnsFVeCtn+XudPsxv3oTpQFoJm1aedsCM1Sl3sJTgbwggS1aNODGkrkV
         4LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431230; x=1720036030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quNMt21k5Tu+QFDqj3HStB/o/6SWdJctxGCAsXhdbxw=;
        b=aog3WflTw5254P0Mik/OFppSzmelFPEpYotDkautrCTdZu3d7PY6fako07NnxCnxAi
         vraI9cLU/FD+TZTPIplqQvimkHovBcoJBT7WvHriljmqoQylyvw/MzB7t00YIwevALw8
         lHpFy+QQPOTko2afKK9ACm/p+aEev5dU0u3Zmq5Wv8zYa5rH8yDoQ4OoDL/U9i7Rz3+Z
         aQ8M55kd5cjJaK624IOjZzO2jX7AQKUP8d0FmWauOCSIMV9UiQIdH++G+SBUIUPopiAw
         /mWjtJM4l89Fh+j9y2J83N9Igtu9FrEhdNMXKflXUwFPpVvRjlgqgjU9TwLmdN39WT8W
         crAQ==
X-Gm-Message-State: AOJu0Yw3DIqcKhXt/F+atGCWhR3YMXI9jAHiXH7dW2M5WPUOPWnTBPeV
	fMMv8gNefX+zNqxgyQVtJpP5ZTUH94iI029M+dg/OzbJyl178/CuLiX1tAWX
X-Google-Smtp-Source: AGHT+IHM/Hxcy2etI4hhkfIvRl+8PUp0crGZyN/TKijgBq+jzHdzfOIXVu30DrVTR8nykcty6UyYRQ==
X-Received: by 2002:a05:6214:1630:b0:6b2:c840:7a2 with SMTP id 6a1803df08f44-6b540aa8879mr114912716d6.45.1719431230584;
        Wed, 26 Jun 2024 12:47:10 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm48489996d6.99.2024.06.26.12.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:47:10 -0700 (PDT)
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
Subject: [PATCH v7 1/4] driver core: don't always lock parent in shutdown
Date: Wed, 26 Jun 2024 14:46:47 -0500
Message-Id: <20240626194650.3837-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
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
index 2b4c0624b704..03edf7a7ec37 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4815,7 +4815,7 @@ void device_shutdown(void)
 		spin_unlock(&devices_kset->list_lock);
 
 		/* hold lock to avoid race with probe/release */
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_lock(parent);
 		device_lock(dev);
 
@@ -4839,7 +4839,7 @@ void device_shutdown(void)
 		}
 
 		device_unlock(dev);
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_unlock(parent);
 
 		put_device(dev);
-- 
2.39.3


