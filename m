Return-Path: <linux-kernel+bounces-382918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAF29B14E7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2240E1C21086
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8F13C80C;
	Sat, 26 Oct 2024 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TiYXEiR3"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852C8460
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729918369; cv=none; b=n/au+KFt53BbT/xFamRzoS79NYCl4/MZgP+bWr7V+5jBi4Ov2Pn5Wlb631sXYZblBPUkwfyaJcZQ7+NswCdnvH2Hw9W3tEfmgREw1xILx7CekCNXLsb8J7DJmhaxVuuLtrguy19gInIYIe4AhwMHjbK1lnyH9DL6JJCnTpPU9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729918369; c=relaxed/simple;
	bh=stVd2FFf+iYA36BChgCxWbjicm60rrkSJAYmXsn/JhM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=YUYkiENmrVggAwnJNG88ltX+gI1qM3VQi36hd9BgEF9dTVutyECLZn9aChbMaeqENqtGztLCod7y+PSW1ALEyvuoSdt6Z6bg2VFaIhruqNUthLjdiXt5hKCBtFlvwUNK4ET8ZA1esCHcDr/cAynlvKOcjbTXd55ThDXE3qoVNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TiYXEiR3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e0082c1dd0so56625317b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729918366; x=1730523166; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/xM391IR48qrcB5QAxis1fqgvS9fSdsN/EpuN4x9UQ0=;
        b=TiYXEiR33SZtuVGi9qkCVqOCdn72q/uEr4PrU+fwXENHVTE5ocyhysfcGECZkyYBoz
         MzmJ1C2J1qTnXrrzJ8KVkuBbNWZa2NYlyas85Vv9gU88YHk9ullGMfe0UAOQopQ6qMf7
         AR8Q0Ck7sLCwJ8vTNwHRtht3UrgN2xkZr/IaD2nw0tCe8bLrPc++wURh/gdaLCuL/WS/
         1XWwZy3OEqwAm5sVOgdTV4aWjW5bnDmAFr3RHljwK2f+qo+E8BZEx47yXVTnAf28ZuUV
         TFAIosqVV5xQeg5NxTot+iy5v36Hi5CIoyKdxyjkMR82XrevlDjrOBjjM/F6SPYKTcse
         QeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729918366; x=1730523166;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xM391IR48qrcB5QAxis1fqgvS9fSdsN/EpuN4x9UQ0=;
        b=umrsmcuVAyJh3p71oJ21ixU0lA+s7WBVE4WaOQvrZDFnsIPuWWCnsN9HqlfwXrLfkJ
         31RI0yoJ6PZUvhjZiMajGGpRhQhdjy321Ub7w+GdR08h0TXe/P+w6RrxqiLHWSKWKtpV
         PGOgKXXOvk0dxCL15tzXDiMhWmpkTngUaWgsNS5v/gyIgj3exfE/YFc/gUOK+chQgVka
         IGWUeoCxMG+YFo+1LdnJoFQDO9EFbd6iyNGYWun2YOBrXd18w604pUXumsJBFgz7Wplp
         0LJu4lgp9Nljlt6PseHCoKWEVzurZZoL3gOrt0WlRguTcH87IDV0Vh/j0IeMNfgZbK+2
         Tnpw==
X-Forwarded-Encrypted: i=1; AJvYcCVNJdSwfTmbR9/krtm1JsiEBt0LH9TH3Q+emCkdxtAYXxN4cP9U9clzqfzBe3N6bikoZy34n4bkupVblvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4/W5hARvYL5EYVmZWXVeCc/SF7kOB3b9+vTJsiaztRpqS73X
	oVyEOgjBgQ/tz3FlbZ20hZyoBaY1lKlzQMm94+908KTewbKa96nqiRhfNC1vfr4kNzPy0FgSBvz
	7Qe+jH6W5f1OU3g==
X-Google-Smtp-Source: AGHT+IGRhPGhaOAsmtwnVFsCBSjW9h81zlh5LCF4eegHPpzOMNumbplBd6lmfCGpHlNLVd/xKdy0TFipMv4YWoE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:999e:1eb9:2ed2:327])
 (user=saravanak job=sendgmr) by 2002:a25:838d:0:b0:e28:e97f:538d with SMTP id
 3f1490d57ef6-e3087c19387mr979276.6.1729918366217; Fri, 25 Oct 2024 21:52:46
 -0700 (PDT)
Date: Fri, 25 Oct 2024 21:52:41 -0700
Message-Id: <20241026045243.452957-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v2] driver core: fw_devlink: Stop trying to optimize cycle
 detection logic
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Devarsh Thakkar <devarsht@ti.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
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
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Greg,

I've tested this on my end and it looks ok and nothing fishy is going
on. You can pick this up once Tomi gives a Tested-by.

Thanks,
Saravana

v1 -> v2:
- Removed the RFC tag
- Remaned the subject. v1 is https://lore.kernel.org/all/20241025223721.184998-1-saravanak@google.com/T/#u
- Added a NULL check to avoid NULL pointer deref

 drivers/base/core.c | 46 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3b13fed1c3e3..f96f2e4c76b4 100644
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
@@ -2140,25 +2140,19 @@ static int fw_devlink_create_devlink(struct device *con,
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


