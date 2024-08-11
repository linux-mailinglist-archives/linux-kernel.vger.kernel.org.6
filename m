Return-Path: <linux-kernel+bounces-282216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A132194E0EE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A89D1F214AB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B214436C;
	Sun, 11 Aug 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=robert.mader@collabora.com header.b="N70IP/sv"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C02595
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723375082; cv=pass; b=ZOLy6h96pWPP7203TeSVd10YEVFJhfz6LeU2v300DyHOEoj4POxyWwOT6sNvJPJuu+tXyenkh1sNmoeoSEO+Ai8PIPMid3VzHUHaQqN1X79khlVVzWC0AIfvMVfFQNAoTZTC3CWJ1pMAbz0GZfwoGfvDQjQqQ1quHBycter7Vws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723375082; c=relaxed/simple;
	bh=06Y3ZCE6t58fv7ioNNp5RA4gyffmDvtpFDdEDMX7h+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBGr5UULt3czvEl7Uw932aQGYTOHNvsej9YQ22RB+Q6hi65iFr9675VEde0hazE4IQiL5eVVY15/J1yjxt0DkmOCMcekT11zh3n2KlkDery3IFW9/AwZ9MekuL8yWJhILmjbdYp5IH6VJxupMIyljn6eyFojzl/k1cgR21YmBiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=robert.mader@collabora.com header.b=N70IP/sv; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: robert.mader@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723375073; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GzDiZlUmKRZ+Nr1bPfcU10+Lvg98XQX7Uy6rFFSZkNNuwu5QfGTxpSKFbG+lZvJb/HrmKh9gQC+H2RW9xzf8bNPi3oobLVhYLokZRnoJp0JqEJHKupfzO/SM8AG8AVbfODAeAp7y4v+KwIdGWkx5PvXH/psB6bCbeY4qWyHDj/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723375073; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rXC5Y6aabeGaXCfpaHE5pi2wTVvK1E/AuRwctWhkQjQ=; 
	b=Qk5yXiANHJvqHArjQEethpkBe3Um3FLcThMRC3mVp/JISO8gEq5V3tdH9LB4Ns8Q5XHNH1kNmA5M7M+Nh2rc/wNw9iYUk8ycv2ExSuGxNFXCDCOOyBeiA8NUFcVfDOG304RDP/2hLC4cVCSdBFl2zPYch2D6h94PMEhif1fTeJg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=robert.mader@collabora.com;
	dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723375073;
	s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rXC5Y6aabeGaXCfpaHE5pi2wTVvK1E/AuRwctWhkQjQ=;
	b=N70IP/svR0ScSi7iuTDWGvJ4hQGQuJI1hg6QM+0wue/Rp3PFQeeJsXVV+D3WU4my
	P+u2NdTVTEnGBSGUKjDRxnqeLb+b2/EAtqPpbzPg6ScoJcJtFIE3uqWpP5pKj/ZjXSN
	QvAWirpBK1t6U3SbjRh0is9ID3HdaPu1SasglNjI=
Received: by mx.zohomail.com with SMTPS id 1723375071369221.40284585100392;
	Sun, 11 Aug 2024 04:17:51 -0700 (PDT)
From: Robert Mader <robert.mader@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: jacopo.mondi@ideasonboard.com,
	sakari.ailus@linux.intel.com,
	javierm@redhat.com,
	kieran.bingham@ideasonboard.com,
	Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v2] media: i2c: imx355: Parse and register properties
Date: Sun, 11 Aug 2024 13:17:04 +0200
Message-ID: <20240811111718.22513-1-robert.mader@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Analogous to e.g. the imx219 driver. This enables propagating the
V4L2_CID_CAMERA_SENSOR_ROTATION and V4L2_CID_CAMERA_ORIENTATION
values so that userspace - e.g. libcamera - can detect the
correct rotation and orientation from the device tree.

Signed-off-by: Robert Mader <robert.mader@collabora.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

---

Changes since v1:
 - Slightly changed the commit message
 - Added RBs
---
 drivers/media/i2c/imx355.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
index 7e9c2f65fa08..0dd25eeea60b 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -1520,6 +1520,7 @@ static const struct v4l2_subdev_internal_ops imx355_internal_ops = {
 static int imx355_init_controls(struct imx355 *imx355)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
+	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl_handler *ctrl_hdlr;
 	s64 exposure_max;
 	s64 vblank_def;
@@ -1531,7 +1532,7 @@ static int imx355_init_controls(struct imx355 *imx355)
 	int ret;
 
 	ctrl_hdlr = &imx355->ctrl_handler;
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 12);
 	if (ret)
 		return ret;
 
@@ -1603,6 +1604,15 @@ static int imx355_init_controls(struct imx355 *imx355)
 		goto error;
 	}
 
+	ret = v4l2_fwnode_device_parse(&client->dev, &props);
+	if (ret)
+		goto error;
+
+	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx355_ctrl_ops,
+					      &props);
+	if (ret)
+		goto error;
+
 	imx355->sd.ctrl_handler = ctrl_hdlr;
 
 	return 0;
-- 
2.46.0


