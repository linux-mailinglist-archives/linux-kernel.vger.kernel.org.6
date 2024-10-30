Return-Path: <linux-kernel+bounces-389263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBBB9B6AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426B01F26250
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255C219C99;
	Wed, 30 Oct 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8zbfrE1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC21E7C3A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308220; cv=none; b=mcWeBjdxNzDD/CZNqpnNV471m5jY6NLPhEhbn0jnTbHntPYNXY3rZGZ2dcIa46ASbVOXTb1KxiUqHEgmea4B27EIFMwPL813tkExbAejOnCegcrmXobb9ox7JPWyNqFM7cPeW9DL+hbdqu7FDP6TU6v7hOfkGSMLqt9Mr5CWKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308220; c=relaxed/simple;
	bh=BFKIQkTGhB3veHwl/yFDrlhA7LWlhh4WhE2ygVL4zvU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=NtnUD6Iu3khOIFj9eYxqRC1oGsURRsxn/QKY/1oUqFFNLs/pdHTuV8q0eAgkWkJpdiyX6GmhMCbX67QsJCqTBWqmV5rDY1BVD22yu1TtoSeBLetGsk83VT64Fa6RqLqGy+Zn1vkcyAGSwdOvFSSwC0Kqq2a3MMtB4FXQDRTGK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f8zbfrE1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7f633af02so96983787b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730308217; x=1730913017; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKPczPrIHVoIPAap6CD8XnlkDXAcxAg65DV8XgUmABk=;
        b=f8zbfrE1Qyg8hRQqt7Fe7QANef5vhVJBVEZ7aVYBIHAwd3sEK0fXwAf9T/U8kAxAd6
         NtQmqty8icovBPG+7ywAhvO6lScLI8TiMGXbDr0v79DbTwD7FcqdBDqpf9gIgJlnaUON
         LoxCH+wsr4yw/Mt/NSE3A/Oa8ZWcfmT72Vn7V3WcxmECKPyCPGqcLvVIcWknE8Sc7RCP
         NQziBUtfzt2pG83Y3ay6XgrKr60XFzQjLIixlMkIQqlidelmq7J8G84mDaY6+4DES/Wi
         2L1DcneJKLV95auKEi292B+6Elsh1OjsaWcgCv78HilnkhbXnnGN+SNmzh6mvhF8NRzA
         /kFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308217; x=1730913017;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKPczPrIHVoIPAap6CD8XnlkDXAcxAg65DV8XgUmABk=;
        b=P4ud3K9AptbiUJyBil45KYnaF0hRcvsR9pGaFJtPvqkyfP+vIVlfvC2bfMuhcYMn7B
         P0icSVVgTZT85MxEJT0w8X1J/St6qaQmOOCHY6Gu5stqqpHe1Q3RqOyjuqZkxhWxczzM
         F9EB5HwOopDoMaj+NBGO7k0+3ooEvEF0lxgZ/Sa2vPIicWFmlwbrIf1uTNAt7J0nYpBy
         unBUIDEs7efc0vFx8ki6Zw1QGqTScXXEFd8x/8XO/zfD2jG+jWW19jgaSXHSexJrp8R6
         5KJMuoyEKBpa4fP49JELY5UX9Q9GPMGuMbhmKcXgwHK9ynyy+129DuzGhNgLzTLIa0do
         lm2g==
X-Forwarded-Encrypted: i=1; AJvYcCV8vGUuDVFpGXj0mqvAbHn2e1CW0CJmTAHDtwqyvkVZKvx/exXH/gd6R5Ax5xHD0eCT5mi21qk9YEg/ruI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBMXbDjDcI1YgaKcRlkVHVI6yph/TiTtLlLq5pq7HOZ+erl6Q
	2cJDNoJvGku2Sb6Sr+2EhKzdOi7M27ba5x0f6XvM+NBSvfpbJniy0wAQly/Wq3W9EbFaRgC7qYJ
	+E0s3cGy8rudznQ==
X-Google-Smtp-Source: AGHT+IHatxPf2CMCPYzx1MzYjsdyU86M4M6o6doxt17jPB7LXwsKr485FzM9xZFBqSUrnuT1/xfn3bQ9u8uFMYE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:9d:7a30:334c:91c8])
 (user=saravanak job=sendgmr) by 2002:a05:690c:6913:b0:6e3:1627:e866 with SMTP
 id 00721157ae682-6e9d8b8da3fmr7986337b3.3.1730308216745; Wed, 30 Oct 2024
 10:10:16 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:10:07 -0700
Message-Id: <20241030171009.1853340-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3] driver core: fw_devlink: Stop trying to optimize cycle
 detection logic
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Francesco <francesco.dolcini@toradex.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In attempting to optimize fw_devlink runtime, I introduced numerous cycle
detection bugs by foregoing cycle detection logic under specific
conditions. Each fix has further narrowed the conditions for optimization.

It's time to give up on these optimization attempts and just run the cycle
detection logic every time fw_devlink tries to create a device link.

The specific bug report that triggered this fix involved a supplier fwnode
that never gets a device created for it. Instead, the supplier fwnode is
represented by the device that corresponds to an ancestor fwnode.

In this case, fw_devlink didn't do any cycle detection because the cycle
detection logic is only run when a device link is created between the
devices that correspond to the actual consumer and supplier fwnodes.

With this change, fw_devlink will run cycle detection logic even when
creating SYNC_STATE_ONLY proxy device links from a device that is an
ancestor of a consumer fwnode.

Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com/
Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of overlapping cycles")
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 55 ++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

Tomi,

Thanks for all the testing and debugging help! And do use
post-init-providers even with this patch to improve ordering
enforcement. I probably should change the cycle log from info to warn in
a separate patch :)

Greg,

I no longer have concerns about pulling this into 6.13. But we can give
a week or so to Geert/Francesco to do some additional testing.

Geert/Francesco,

If you want to test this patch, pull it in and compare the output of
the following:

ls -1 /sys/class/devlink

The only device links that should be missing with the patch should be
device links in a cycle that weren't detected before.

Also, if you notice any significant boot time increase with this change,
let me know.

Thanks,
Saravana

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3b13fed1c3e3..9a490b1b7a6f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1990,10 +1990,10 @@ static struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fwn
  *
  * Return true if one or more cycles were found. Otherwise, return false.
  */
-static bool __fw_devlink_relax_cycles(struct device *con,
+static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 				 struct fwnode_handle *sup_handle)
 {
-	struct device *sup_dev = NULL, *par_dev = NULL;
+	struct device *sup_dev = NULL, *par_dev = NULL, *con_dev = NULL;
 	struct fwnode_link *link;
 	struct device_link *dev_link;
 	bool ret = false;
@@ -2010,22 +2010,22 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 
 	sup_handle->flags |= FWNODE_FLAG_VISITED;
 
-	sup_dev = get_dev_from_fwnode(sup_handle);
-
 	/* Termination condition. */
-	if (sup_dev == con) {
+	if (sup_handle == con_handle) {
 		pr_debug("----- cycle: start -----\n");
 		ret = true;
 		goto out;
 	}
 
+	sup_dev = get_dev_from_fwnode(sup_handle);
+	con_dev = get_dev_from_fwnode(con_handle);
 	/*
 	 * If sup_dev is bound to a driver and @con hasn't started binding to a
 	 * driver, sup_dev can't be a consumer of @con. So, no need to check
 	 * further.
 	 */
 	if (sup_dev && sup_dev->links.status ==  DL_DEV_DRIVER_BOUND &&
-	    con->links.status == DL_DEV_NO_DRIVER) {
+	    con_dev && con_dev->links.status == DL_DEV_NO_DRIVER) {
 		ret = false;
 		goto out;
 	}
@@ -2034,7 +2034,7 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 		if (link->flags & FWLINK_FLAG_IGNORE)
 			continue;
 
-		if (__fw_devlink_relax_cycles(con, link->supplier)) {
+		if (__fw_devlink_relax_cycles(con_handle, link->supplier)) {
 			__fwnode_link_cycle(link);
 			ret = true;
 		}
@@ -2049,7 +2049,7 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 	else
 		par_dev = fwnode_get_next_parent_dev(sup_handle);
 
-	if (par_dev && __fw_devlink_relax_cycles(con, par_dev->fwnode)) {
+	if (par_dev && __fw_devlink_relax_cycles(con_handle, par_dev->fwnode)) {
 		pr_debug("%pfwf: cycle: child of %pfwf\n", sup_handle,
 			 par_dev->fwnode);
 		ret = true;
@@ -2067,7 +2067,7 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 		    !(dev_link->flags & DL_FLAG_CYCLE))
 			continue;
 
-		if (__fw_devlink_relax_cycles(con,
+		if (__fw_devlink_relax_cycles(con_handle,
 					      dev_link->supplier->fwnode)) {
 			pr_debug("%pfwf: cycle: depends on %pfwf\n", sup_handle,
 				 dev_link->supplier->fwnode);
@@ -2115,11 +2115,6 @@ static int fw_devlink_create_devlink(struct device *con,
 	if (link->flags & FWLINK_FLAG_IGNORE)
 		return 0;
 
-	if (con->fwnode == link->consumer)
-		flags = fw_devlink_get_flags(link->flags);
-	else
-		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
-
 	/*
 	 * In some cases, a device P might also be a supplier to its child node
 	 * C. However, this would defer the probe of C until the probe of P
@@ -2140,25 +2135,23 @@ static int fw_devlink_create_devlink(struct device *con,
 		return -EINVAL;
 
 	/*
-	 * SYNC_STATE_ONLY device links don't block probing and supports cycles.
-	 * So, one might expect that cycle detection isn't necessary for them.
-	 * However, if the device link was marked as SYNC_STATE_ONLY because
-	 * it's part of a cycle, then we still need to do cycle detection. This
-	 * is because the consumer and supplier might be part of multiple cycles
-	 * and we need to detect all those cycles.
+	 * Don't try to optimize by not calling the cycle detection logic under
+	 * certain conditions. There's always some corner case that won't get
+	 * detected.
 	 */
-	if (!device_link_flag_is_sync_state_only(flags) ||
-	    flags & DL_FLAG_CYCLE) {
-		device_links_write_lock();
-		if (__fw_devlink_relax_cycles(con, sup_handle)) {
-			__fwnode_link_cycle(link);
-			flags = fw_devlink_get_flags(link->flags);
-			pr_debug("----- cycle: end -----\n");
-			dev_info(con, "Fixed dependency cycle(s) with %pfwf\n",
-				 sup_handle);
-		}
-		device_links_write_unlock();
+	device_links_write_lock();
+	if (__fw_devlink_relax_cycles(link->consumer, sup_handle)) {
+		__fwnode_link_cycle(link);
+		pr_debug("----- cycle: end -----\n");
+		pr_info("%pfwf: Fixed dependency cycle(s) with %pfwf\n",
+			link->consumer, sup_handle);
 	}
+	device_links_write_unlock();
+
+	if (con->fwnode == link->consumer)
+		flags = fw_devlink_get_flags(link->flags);
+	else
+		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
 	if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
 		sup_dev = fwnode_get_next_parent_dev(sup_handle);
-- 
2.47.0.163.g1226f6d8fa-goog


