Return-Path: <linux-kernel+bounces-446453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730969F2474
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37F7163046
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCA7192D61;
	Sun, 15 Dec 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kqrI1soz"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FAF18FDD8
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734274160; cv=none; b=CJO50lBD8zfGu4wM6EPr3TjYU40/ShNb+QQImK9EoWpgVBSnMhqDMhYR78wENJ8JrSYV/u6WWiY+NlWsv10/bBJRp4np+YWcLoNh7DqvB2+a5lDZuyfwvVQ7y8B8OQZiibTLkLFPALOoeff63ftNz+VFiwJbRqvf4MLT6uGrU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734274160; c=relaxed/simple;
	bh=GPoO2MlSyFN41keL/IQMHVzwngO96d3fyeoIVD73xh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UyWqdXZVaQZa51pm4pF7Pplwh+4yYHgWV/3796FD8gMHcGiuyVtKZyItjTnPNXMmcA6IX/fUSfuqAyRr/x/hkpTExCbTSuai108HxiiDbx0z+raVSL0HqrOCbHZY/Jkb+Dh/0r2EejRhGHUJrVh3RszHoJUYzgPb2e9ZvnDzSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kqrI1soz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734274154;
	bh=GPoO2MlSyFN41keL/IQMHVzwngO96d3fyeoIVD73xh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kqrI1sozDNK2AvehZaV6vrnPcQnHjIX63VWtGVuX5PrnIRydf37SmfuXcC50KMzU1
	 VrO/QF2HovWq9imz0jt17WDBYaJK57fGEVwE6WfRYegxu1J9N1cgqt8l0KGfGkzMmK
	 IEbkdHc9pulhDogINALIBHxIPlhnl3aAAVr/mq/Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 15:49:11 +0100
Subject: [PATCH 3/4] firmware: google: memconsole: Use const 'struct
 bin_attribute' callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-google-v1-3-e5c2808f5833@weissschuh.net>
References: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>
In-Reply-To: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734274153; l=1259;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GPoO2MlSyFN41keL/IQMHVzwngO96d3fyeoIVD73xh0=;
 b=Rj/FM7RcVBGvm/gpxe+tx2rQ8WNOo+HWXEO2lIlSCw+4yndXGxNqd5yMUrbhhDpFa6SHj113J
 OUzVm/WZIkxAnOxLJaqIotYuRPnqD/evAmeLx2kACKW6uwd42u+0gul
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now provides callback variants that explicitly take a
const pointer. Use them so the non-const variants can be removed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/firmware/google/memconsole.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/google/memconsole.c
index b9d99fe1ff0f683f9fff3c4bc669d2a85c703366..d957af6f934984b74627e83f458575dbf2b7d592 100644
--- a/drivers/firmware/google/memconsole.c
+++ b/drivers/firmware/google/memconsole.c
@@ -14,7 +14,7 @@
 #include "memconsole.h"
 
 static ssize_t memconsole_read(struct file *filp, struct kobject *kobp,
-			       struct bin_attribute *bin_attr, char *buf,
+			       const struct bin_attribute *bin_attr, char *buf,
 			       loff_t pos, size_t count)
 {
 	ssize_t (*memconsole_read_func)(char *, loff_t, size_t);
@@ -28,7 +28,7 @@ static ssize_t memconsole_read(struct file *filp, struct kobject *kobp,
 
 static struct bin_attribute memconsole_bin_attr = {
 	.attr = {.name = "log", .mode = 0444},
-	.read = memconsole_read,
+	.read_new = memconsole_read,
 };
 
 void memconsole_setup(ssize_t (*read_func)(char *, loff_t, size_t))

-- 
2.47.1


