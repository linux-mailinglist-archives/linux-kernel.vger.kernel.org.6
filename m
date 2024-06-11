Return-Path: <linux-kernel+bounces-209892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8461903C97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9C91F22E94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248A17D35E;
	Tue, 11 Jun 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L94lrCQd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9717D357
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110883; cv=none; b=Ja/UqgbiT0JOLh8tM/unrJujrMGgvs4FUGekxZH++h9TxNF02VykUNEVUuzFshSPM6xbXgGrdHxc/Q875qPYa2A2UjdwndLuLHtxEhwAULcs/xvQ1osZqeWJTDWg1cpP/piuoatj8ZX6HPwWC3dwSC/PVKhIcijY4kNC3o4tAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110883; c=relaxed/simple;
	bh=N5PoFHKoWvFUydSF++A0qAzk4rZ0C9suWHG8tjZ6f+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5zBT65dV+1/jHzaIOMaChA5Mekk+ybGyEfLkUzX5hk9sNwFOUoDBbtwzspjKr49MxveHaXCy5d6v/aS+quBAhZpCVtZcuUK+ElU5PMQv4I1gIICvMTF1ml/blp9LELByskijnkbumedRr8sSszvXU6BTGt+Z8Ych245NQe9qRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L94lrCQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4195C32789;
	Tue, 11 Jun 2024 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718110883;
	bh=N5PoFHKoWvFUydSF++A0qAzk4rZ0C9suWHG8tjZ6f+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L94lrCQdz78HEeBprwZNyKW4PCTH4eZDeUATzdbu/Kohtt2+zoLs/vWveUKQ/ha9+
	 E0hxA6qNnW8GRIQDjMiDhx6DxvA2Psn2j40F6rEARHVnyChWXN/3XakihFpYYg0+Bc
	 Bl6ybg23up+nyQz17TvyJ+HLoMspaaJi3bNtAQS4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 4/6] driver core: make device_release_driver_internal() take a const *
Date: Tue, 11 Jun 2024 15:01:07 +0200
Message-ID: <20240611130103.3262749-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=gregkh@linuxfoundation.org; h=from:subject; bh=N5PoFHKoWvFUydSF++A0qAzk4rZ0C9suWHG8tjZ6f+E=; b=owGbwMvMwCRo6H6F97bub03G02pJDGkZXpPO6s/gEPJ/um4Sh1sJz2nuiQUtctnZqRP8f99// Od756PZHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRaRsYZrPXhpx596jiUfyn MCe7mWJmiywP72RYcCri9bZ9ChcrT1rs3KO+J9hn0j8LAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Change device_release_driver_internal() to take a const struct
device_driver * as it is not modifying it at all.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h | 2 +-
 drivers/base/dd.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index cba8307908c7..d332b87cde9e 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -155,7 +155,7 @@ bool bus_is_registered(const struct bus_type *bus);
 
 int bus_add_driver(struct device_driver *drv);
 void bus_remove_driver(struct device_driver *drv);
-void device_release_driver_internal(struct device *dev, struct device_driver *drv,
+void device_release_driver_internal(struct device *dev, const struct device_driver *drv,
 				    struct device *parent);
 
 void driver_detach(struct device_driver *drv);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 83d352394fdf..c24eca917d41 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1284,7 +1284,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 }
 
 void device_release_driver_internal(struct device *dev,
-				    struct device_driver *drv,
+				    const struct device_driver *drv,
 				    struct device *parent)
 {
 	__device_driver_lock(dev, parent);
-- 
2.45.2


