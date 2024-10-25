Return-Path: <linux-kernel+bounces-382725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DADD9B12BC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09B71C21C00
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A36520EA27;
	Fri, 25 Oct 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKvLHyT+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBBA217F22
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895850; cv=none; b=HtMKBd+gZ3Pi6KLqAMB2SwyKh3Uzqsgz/5CV3CuYvNydznIkXneEXExQKuf9cOIutFuoMu8NZhYnShZULKW+aKyd6X72XCJtzo9SYUDpDVMwSfYAfHQH/6azEe9uzbjmSm2gAsnTeyjj46Ml76iONk770Nz4AK3EjIioTUSmhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895850; c=relaxed/simple;
	bh=TAEEvevd4TZVPtnplAcToIg8/O0S13dJ6FqVh9IlgZc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=iNAcLqe7QA34aoRTDFiRsa0BriaofsAhaRY4DHQLJZPTmDWYPcph4y0W6wY6rfpP/8Ih8HLzZxsUkFeoxgxxHt7oz3yy9MxI6wVx2vs0zWXd+tUt6O9Mr4BrMgTdIOv7yl+J5yQUJqVU1ZYBpX14x491dkFXYLNfo5fQ6LmhIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKvLHyT+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31d9c8efcso47138587b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729895847; x=1730500647; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e1FcGVos8lyAaAg+NQccXSBbH5BYwARw1LkC+ohoZmU=;
        b=dKvLHyT+CYYSBI/RyhRF+gv/H5QKvNZRV4GKpg2ArhdjVrGDcgrKG7AX45Zpas57oG
         1kw2gMEJ55bi/FBbHSdKg0Q5t9PYwqHfDkZv9vwqLA8oFEBgJHH3Vj+FtzprvrtfMZzG
         1+qdT/5z+5xCNYQIPhFRjr7JbebqIlYlUEJpT+y3zXvIDfb7gDC+d2KcKl9ahPFgnkS3
         R1Gl0sMTcK4DPr/gb86SxDicrlOZZ1A3/Z4hcXMcgOlpCbQ9Cp6y+MLrjKt9AvzpMxme
         WlvbZY2WgvRPziFK+SA8PFqHAn0TvQKubV8RTixetv8KrYPM4MbR7U6Lps/HKYKoHwbM
         WfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729895847; x=1730500647;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1FcGVos8lyAaAg+NQccXSBbH5BYwARw1LkC+ohoZmU=;
        b=hdARR3LVD9oJID6g79Sn8GFVpXR8CCHKGAzeyGAKXuWeBj41rXbh0/HwRYFO/o87AL
         mG6uxlaTYhwCN4/44G9rLXW6wb0uojl/ejtj2QBRkp7NbnE4hdvpjFGEPM1i8+Fs5/qv
         OoK78AVzR7lmGQw9WczVKv1a+DcgisjEem1Ap9J1dhSJWfXv8YoBsmvKKzFtDZ6nEg+U
         QnKMGybj1bjb38b6xjn0Fd3BSWg+m7uhstuXQ2RkoL5q7YRSCsstzgaJT/ROHZpsxgxh
         EyGf3ET00GiEui7D82HaazAY10xsjJs8f802KhDkCuBXHTUnX1gB69SX//V3CbfbHJoU
         wFOA==
X-Forwarded-Encrypted: i=1; AJvYcCVLwOIyCnM82cDav1Uds+FrqNqH3+Ioqi2uMDJGbb78gaxgx+ef5I229OuSRfr+igqTDkeeZmKiBwtp9JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6H01rh5qhNwsnoShCGMDMd3+f6RhZPvCEVlPkgDGDZtIuu64
	Ms3mNb35YXjkLJU1V8gbEHcnOoxk8SsN79BFTRhLesunidQt6t9o1GZEtfApm+cVQfioTHxi82G
	6cuxeLkSfcBwA7Q==
X-Google-Smtp-Source: AGHT+IHPHZDbQbtP1icqGOUMOscV6/nhUscLSAkkWh0bRtUZf3hipMvM7Z6U5i5R21VQhYaDC0MEdVrMfBXQ6iU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:999e:1eb9:2ed2:327])
 (user=saravanak job=sendgmr) by 2002:a5b:348:0:b0:e28:ee84:e4d8 with SMTP id
 3f1490d57ef6-e3087a4ed70mr624276.3.1729895847339; Fri, 25 Oct 2024 15:37:27
 -0700 (PDT)
Date: Fri, 25 Oct 2024 15:37:19 -0700
Message-Id: <20241025223721.184998-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [RFC PATCH v1] driver core: fw_devlink: Detect cycles when the
 supplier never gets a device
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sometimes the supplier fwnode never gets a device created for it.  Instead,
the supplier fwnode is represented by the device that corresponds a
parent/ancestor fwnode.

In these cases, we currently don't do any cycle detection because the cycle
detection logic is only run when a device link is created between the
devices that correspond to the actual consumer and supplier fwnodes.

To detect these cycles correctly, run cycle detection logic even when
creating SYNC_STATE_ONLY proxy device links from a device that is the
parent of the consumer.

Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Tomi,

I didn't have a chance yet to test this on my end. But I expect that
this will allow the display to probe in your single-link case without
having to add post-init-providers. You should still add it for better
probe/suspend/resume/shutdown ordering.

While you test this, can you also do a diff of with and without this
change? It shouldn't have significant differences (other than the ones
with actual cycles):

ls -1 /sys/class/devlink

Greg,

This is RFC because I haven't tested it on my end. I need to do that
before I'd be okay merging this.

Thanks,
Saravana

 drivers/base/core.c | 45 +++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3b13fed1c3e3..cf20101c74ac 100644
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
+	    con_dev->links.status == DL_DEV_NO_DRIVER) {
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
@@ -2139,26 +2139,15 @@ static int fw_devlink_create_devlink(struct device *con,
 	    fwnode_is_ancestor_of(sup_handle, con->fwnode))
 		return -EINVAL;
 
-	/*
-	 * SYNC_STATE_ONLY device links don't block probing and supports cycles.
-	 * So, one might expect that cycle detection isn't necessary for them.
-	 * However, if the device link was marked as SYNC_STATE_ONLY because
-	 * it's part of a cycle, then we still need to do cycle detection. This
-	 * is because the consumer and supplier might be part of multiple cycles
-	 * and we need to detect all those cycles.
-	 */
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
+		flags = fw_devlink_get_flags(link->flags);
+		pr_debug("----- cycle: end -----\n");
+		pr_info("%pfwf: Fixed dependency cycle(s) with %pfwf\n",
+			link->consumer, sup_handle);
 	}
+	device_links_write_unlock();
 
 	if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
 		sup_dev = fwnode_get_next_parent_dev(sup_handle);
-- 
2.47.0.163.g1226f6d8fa-goog


